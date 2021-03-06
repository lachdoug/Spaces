app.blueprints.resolutions.new = (router) => (a, x) => [
  a.h2("New resolution"),
  app.form({
    url: `/api/blueprinting/${router.params.blueprint_id}/resolving`,
    object: { identifier: router.params.blueprint_id },
    scope: "resolution",
    form: (f) => [
      f.field({
        key: "identifier",
      }),
      f.buttons({router: router}),
    ],
    success: (identifier) => router.open(`/resolving/${identifier}`),
  }),
];
