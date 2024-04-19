Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 17:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxraZ-0000gw-CR; Fri, 19 Apr 2024 12:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxra1-0008Sp-R2
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxrZv-0003u1-Q4
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713545949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSPgAWa85pqiz7SGlA4eXoq9LBUCsEG6NGfsKqGUs+k=;
 b=dHB9Zv2Y+MGkoPjfVBDZBLrVcrI1rPx4R5N3a2N68spRnIKQofUezo/Mi63/0JvRDCSy+C
 QoMYxA/kYpCqgMUICO2YOZ0z9CwL5xPmKAWbQOaliyX7uM6j5xOMlCN94/4vAEgsY/uMD2
 hbb+OIAIPBwCaPa05xDcOLd4r+aAIUw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-yh6y0s07NXCWxnM8uWcBEQ-1; Fri, 19 Apr 2024 12:59:08 -0400
X-MC-Unique: yh6y0s07NXCWxnM8uWcBEQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cec090b2bdso2280484a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545947; x=1714150747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSPgAWa85pqiz7SGlA4eXoq9LBUCsEG6NGfsKqGUs+k=;
 b=BqcoMEXuf9f0ydkb9n9bmbMvD1heqkNd7cQDAhJh16vECLwtsp9ErmT1gS+ZOTbINE
 nIQ6/RMWnsdxht0KezZI6MVFP6rir8/VNIvjHvYoxiHm/Kw+QyKd8cRcLtbssUlno2et
 LkPBdBZ7JS3mCVe5IhZ0rgWVpgOlY5OMrt8U/bbodzOScuAxhNdwoGXVK25YABwN0gsy
 A9J4RjznamkvlxvFxX9ZvhXyegKSx2y2EI2o+4VFRVLliifrOBdRM6J1DA/i/BhDTA3p
 DX/LhEmqkkoqwY0CKUvfVzr6WKI1ziR5W1xOnTUId1rCyWlj/P3TwnK5uKckSx41Imfb
 yWlg==
X-Gm-Message-State: AOJu0Yx0BwQQMeBrYM0M3R6hGFyj/3uIP8WkLawwZITy4xvllMJeZAQ2
 5+0F/4CNfq5Hp37vFvljI/3TAyDn7UuQZAdfwnm9fOMUStjG0H5ZYKkWCG+GHSwiCj4KdLgELw5
 tbzbitE8WS0vbxKr+vkp1fVosGLKsqyxFw51GL8IhL897W5Dn0jw8aT1hEHml2awWSHI8oB1WKU
 DsEb5ghrVaphVtPaJ1LutF5qZaUh6yYQPjGHY=
X-Received: by 2002:a17:90a:6389:b0:2ab:a53a:6e52 with SMTP id
 f9-20020a17090a638900b002aba53a6e52mr2876086pjj.37.1713545947032; 
 Fri, 19 Apr 2024 09:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpFg/9l3GFuwtEkrBNfHjEk2d3416JnvvpZbayWqjLmzA/SY74Uv95mFZaTdSEWhAhgqEMHDf2MPW3mbSzAHs=
X-Received: by 2002:a17:90a:6389:b0:2ab:a53a:6e52 with SMTP id
 f9-20020a17090a638900b002aba53a6e52mr2876064pjj.37.1713545946581; Fri, 19 Apr
 2024 09:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240419043820.178731-1-jsnow@redhat.com>
 <20240419043820.178731-25-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-25-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Apr 2024 12:58:55 -0400
Message-ID: <CAFn=p-Y=e=AjJADij=8aj_W5GB0X3z6tyeiwHmL20SKBDQ4z5A@mail.gmail.com>
Subject: Re: [PATCH 24/27] docs/qapi-domain: add type cross-refs to field lists
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 19, 2024 at 12:38=E2=80=AFAM John Snow <jsnow@redhat.com> wrote=
:
>
> This commit, finally, adds cross-referencing support to various field
> lists; modeled tightly after Sphinx's own Python domain code.
>
> Cross-referencing support is added to type names provided to :arg:,
> :memb:, :returns: and :choice:.
>
> :feat:, :error: and :value:, which do not take type names, do not
> support this syntax.
>
> The general syntax is simple:
>
> :arg TypeName ArgName: Lorem Ipsum ...
>
> The domain will transform TypeName into :qapi:type:`TypeName` in this
> basic case, and also apply the ``literal`` decoration to indicate that
> this is a type cross-reference.
>
> For Optional arguments, the special "?" suffix is used. Because "*" has
> special meaning in ReST that would cause parsing errors, we elect to use
> "?" instead. The special syntax processing in QAPIXrefMixin strips this
> character from the end of any type name argument and will append ",
> Optional" to the rendered output, applying the cross-reference only to
> the actual type name.
>
> The intent here is that the actual syntax in doc-blocks need not change;
> but e.g. qapidoc.py will need to process and transform "@arg foo lorem
> ipsum" into ":arg type? foo: lorem ipsum" based on the schema
> information. Therefore, nobody should ever actually witness this
> intermediate syntax unless they are writing manual documentation or the
> doc transmogrifier breaks.
>
> For array arguments, type names can similarly be surrounded by "[]",
> which are stripped off and then re-appended outside of the
> cross-reference.
>
> Note: The mixin pattern here (borrowed from Sphinx) confuses mypy
> because it cannot tell that it will be mixed into a descendent of
> Field. Doing that instead causes more errors, because many versions of
> Sphinx erroneously did not mark various arguments as Optional, so we're
> a bit hosed either way. Do the simpler thing.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/qapi/index.rst        |  34 ++++++++++++
>  docs/sphinx/qapi-domain.py | 110 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 138 insertions(+), 6 deletions(-)
>
> diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
> index 8352a27d4a5..6e85ea5280d 100644
> --- a/docs/qapi/index.rst
> +++ b/docs/qapi/index.rst
> @@ -105,6 +105,11 @@ Explicit cross-referencing syntax for QAPI modules i=
s available with
>     :arg str bar: Another normal parameter description.
>     :arg baz: Missing a type.
>     :arg no-descr:
> +   :arg int? oof: Testing optional argument parsing.
> +   :arg [XDbgBlockGraphNode] rab: Testing array argument parsing.
> +   :arg [BitmapSyncMode]? zab: Testing optional array argument parsing,
> +      even though Markus said this should never happen. I believe him,
> +      but I didn't *forbid* the syntax either.
>     :arg BitmapSyncMode discrim: How about branches in commands?
>
>     .. qapi:branch:: discrim on-success
> @@ -261,3 +266,32 @@ Explicit cross-referencing syntax for QAPI modules i=
s available with
>
>        :memb str key-secret: ID of a QCryptoSecret object providing a
>           passphrase for unlocking the encryption
> +
> +.. qapi:command:: x-debug-query-block-graph
> +   :since: 4.0
> +   :unstable:
> +
> +   Get the block graph.
> +
> +   :feat unstable: This command is meant for debugging.
> +   :return XDbgBlockGraph: lorem ipsum ...
> +
> +.. qapi:struct:: XDbgBlockGraph
> +   :since: 4.0
> +
> +   Block Graph - list of nodes and list of edges.
> +
> +   :memb [XDbgBlockGraphNode] nodes:
> +   :memb [XDbgBlockGraphEdge] edges:
> +
> +.. qapi:struct:: XDbgBlockGraphNode
> +   :since: 4.0
> +
> +   :memb uint64 id: Block graph node identifier.  This @id is generated =
only for
> +      x-debug-query-block-graph and does not relate to any other
> +      identifiers in Qemu.
> +   :memb XDbgBlockGraphNodeType type: Type of graph node.  Can be one of
> +      block-backend, block-job or block-driver-state.
> +   :memb str name: Human readable name of the node.  Corresponds to
> +      node-name for block-driver-state nodes; is not guaranteed to be
> +      unique in the whole graph (with block-jobs and block-backends).
> diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
> index bf8bb933345..074453193ce 100644
> --- a/docs/sphinx/qapi-domain.py
> +++ b/docs/sphinx/qapi-domain.py
> @@ -50,11 +50,12 @@
>
>  if TYPE_CHECKING:
>      from docutils.nodes import Element, Node
> +    from docutils.parsers.rst.states import Inliner
>
>      from sphinx.application import Sphinx
>      from sphinx.builders import Builder
>      from sphinx.environment import BuildEnvironment
> -    from sphinx.util.typing import OptionSpec
> +    from sphinx.util.typing import OptionSpec, TextlikeNode
>
>  logger =3D logging.getLogger(__name__)
>
> @@ -68,6 +69,90 @@ class ObjectEntry(NamedTuple):
>      aliased: bool
>
>
> +class QAPIXrefMixin:
> +    def make_xref(
> +        self,
> +        rolename: str,
> +        domain: str,
> +        target: str,
> +        innernode: type[TextlikeNode] =3D nodes.literal,
> +        contnode: Optional[Node] =3D None,
> +        env: Optional[BuildEnvironment] =3D None,
> +        inliner: Optional[Inliner] =3D None,
> +        location: Optional[Node] =3D None,
> +    ) -> Node:
> +        result =3D super().make_xref(  # type: ignore[misc]
> +            rolename,
> +            domain,
> +            target,
> +            innernode=3Dinnernode,
> +            contnode=3Dcontnode,
> +            env=3Denv,
> +            inliner=3DNone,
> +            location=3DNone,
> +        )
> +        if isinstance(result, pending_xref):
> +            assert env is not None
> +            result["refspecific"] =3D True
> +            result["qapi:module"] =3D env.ref_context.get("qapi:module")
> +
> +        assert isinstance(result, Node)

A bug snuck in because I made edits after I published to GitLab; this
line should be:

assert isinstance(result, nodes.Node)

> +        return result
> +
> +    def make_xrefs(
> +        self,
> +        rolename: str,
> +        domain: str,
> +        target: str,
> +        innernode: type[TextlikeNode] =3D nodes.literal,
> +        contnode: Optional[Node] =3D None,
> +        env: Optional[BuildEnvironment] =3D None,
> +        inliner: Optional[Inliner] =3D None,
> +        location: Optional[Node] =3D None,
> +    ) -> list[Node]:
> +        # Note: this function is called on up to three fields of text:
> +        # (1) The field name argument (e.g. member/arg name)
> +        # (2) The field name type (e.g. member/arg type)
> +        # (3) The field *body* text, for Fields that do not take argumen=
ts.
> +
> +        list_type =3D False
> +        optional =3D False
> +
> +        # If the rolename is qapi:type, we know we are processing a type
> +        # and not an arg/memb name or field body text.
> +        if rolename =3D=3D "type":
> +            # force the innernode class to be a literal.
> +            innernode =3D nodes.literal
> +
> +            # Type names that end with "?" are considered Optional
> +            # arguments and should be documented as such, but it's not
> +            # part of the xref itself.
> +            if target.endswith("?"):
> +                optional =3D True
> +                target =3D target[:-1]
> +
> +            # Type names wrapped in brackets denote lists. strip the
> +            # brackets and remember to add them back later.
> +            if target.startswith("[") and target.endswith("]"):
> +                list_type =3D True
> +                target =3D target[1:-1]
> +
> +        results =3D []
> +        result =3D self.make_xref(
> +            rolename, domain, target, innernode, contnode, env, inliner,=
 location
> +        )
> +        results.append(result)
> +
> +        if list_type:
> +            results.insert(0, nodes.literal("[", "["))
> +            results.append(nodes.literal("]", "]"))
> +        if optional:
> +            results.append(nodes.Text(", "))
> +            results.append(nodes.emphasis("?", "Optional"))
> +
> +        return results
> +
> +
>  class QAPIXRefRole(XRefRole):
>      def process_link(
>          self,
> @@ -96,6 +181,14 @@ def process_link(
>          return title, target
>
>
> +class QAPIGroupedField(QAPIXrefMixin, GroupedField):
> +    pass
> +
> +
> +class QAPITypedField(QAPIXrefMixin, TypedField):
> +    pass
> +
> +
>  def since_validator(param: str) -> str:
>      """
>      Validate the `:since: X.Y` option field.
> @@ -416,10 +509,11 @@ class QAPICommand(QAPIObject):
>      doc_field_types =3D QAPIObject.doc_field_types.copy()
>      doc_field_types.extend(
>          [
> -            TypedField(
> +            QAPITypedField(
>                  "argument",
>                  label=3D_("Arguments"),
>                  names=3D("arg",),
> +                typerolename=3D"type",
>                  can_collapse=3DTrue,
>              ),
>              GroupedField(
> @@ -428,9 +522,10 @@ class QAPICommand(QAPIObject):
>                  names=3D("error",),
>                  can_collapse=3DTrue,
>              ),
> -            GroupedField(
> +            QAPIGroupedField(
>                  "returnvalue",
>                  label=3D_("Returns"),
> +                rolename=3D"type",
>                  names=3D("return", "returns"),
>                  can_collapse=3DTrue,
>              ),
> @@ -460,10 +555,11 @@ class QAPIAlternate(QAPIObject):
>      doc_field_types =3D QAPIObject.doc_field_types.copy()
>      doc_field_types.extend(
>          [
> -            TypedField(
> +            QAPITypedField(
>                  "choice",
>                  label=3D_("Choices"),
>                  names=3D("choice",),
> +                typerolename=3D"type",
>                  can_collapse=3DTrue,
>              ),
>          ]
> @@ -476,10 +572,11 @@ class QAPIObjectWithMembers(QAPIObject):
>      doc_field_types =3D QAPIObject.doc_field_types.copy()
>      doc_field_types.extend(
>          [
> -            TypedField(
> +            QAPITypedField(
>                  "member",
>                  label=3D_("Members"),
>                  names=3D("memb",),
> +                typerolename=3D"type",
>                  can_collapse=3DTrue,
>              ),
>          ]
> @@ -629,12 +726,13 @@ def run(self) -> list[Node]:
>          # of per-class to incorporate the branch conditions as a label
>          # name.
>          self.doc_field_types =3D [
> -            TypedField(
> +            QAPITypedField(
>                  "branch-arg-or-memb",
>                  label=3Df"[{discrim} =3D {value}]",
>                  # In a branch, we don't actually use the name of the
>                  # field name to generate the label; so allow either-or.
>                  names=3D("arg", "memb"),
> +                typerolename=3D"type",
>              ),
>          ]
>
> --
> 2.44.0
>


