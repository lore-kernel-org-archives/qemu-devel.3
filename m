Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27877C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWNE-0005oH-Nd; Fri, 07 Mar 2025 07:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWN9-0005lT-Qk
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:00:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWN5-0001IF-JE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uh9jiD6XsvLm8+bLX3gHu8bnjZYy3R6/2R/c8tFf84Q=;
 b=hsjxp+akRyxnQ5OhG+UWZHxEoZ3wIJJrAifL8w8+LkTnczBRTjS1ZFrpUawcVOvRvRLaFs
 S5/K2xjJ2LBntOj3/OKV/2h722Rj3q410xPO6wmYqrZvJhpBu7OfkKuwGg8WTP/fdhjTN4
 /8K2KPjF3LQjRRz46IIWtTkAP+XThoY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-c5Hu_-LIP2-acy-koFGa9A-1; Fri,
 07 Mar 2025 07:00:01 -0500
X-MC-Unique: c5Hu_-LIP2-acy-koFGa9A-1
X-Mimecast-MFC-AGG-ID: c5Hu_-LIP2-acy-koFGa9A_1741348800
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6789D1956087; Fri,  7 Mar 2025 12:00:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C680F18001E9; Fri,  7 Mar 2025 11:59:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A0B821E66C2; Fri, 07 Mar 2025 12:59:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 35/57] docs/qapidoc: Fix static typing on qapidoc.py
In-Reply-To: <20250305034610.960147-36-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:44 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-36-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 12:59:57 +0100
Message-ID: <878qphkq4i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Now that the legacy code is factored out, fix up the typing on the
> remaining code in qapidoc.py. Add a type ignore to qapi_legacy.py to
> prevent the errors there from bleeding out into qapidoc.py.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py        | 40 ++++++++++++++++++++++-------------
>  docs/sphinx/qapidoc_legacy.py |  1 +
>  2 files changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index f4abf42e7bf..5246832b68c 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -24,17 +24,18 @@
>  https://www.sphinx-doc.org/en/master/development/index.html
>  """
>  
> +from __future__ import annotations
> +
>  import os
>  import sys
> -from typing import List
> +from typing import TYPE_CHECKING
>  
>  from docutils import nodes
>  from docutils.parsers.rst import Directive, directives
>  from qapi.error import QAPIError
> -from qapi.gen import QAPISchemaVisitor
> -from qapi.schema import QAPISchema
> +from qapi.schema import QAPISchema, QAPISchemaVisitor
>  
> -from qapidoc_legacy import QAPISchemaGenRSTVisitor
> +from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
>  from sphinx import addnodes
>  from sphinx.directives.code import CodeBlock
>  from sphinx.errors import ExtensionError
> @@ -42,6 +43,15 @@
>  from sphinx.util.nodes import nested_parse_with_titles
>  
>  
> +if TYPE_CHECKING:
> +    from typing import Any, List, Sequence
> +
> +    from docutils.statemachine import StringList
> +
> +    from sphinx.application import Sphinx
> +    from sphinx.util.typing import ExtensionMetadata

Can you briefly explain why this needs to be conditional?

> +
> +
>  __version__ = "1.0"
>  
>  
> @@ -53,11 +63,11 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
>      schema file associated with each module in the QAPI input.
>      """
>  
> -    def __init__(self, env, qapidir):
> +    def __init__(self, env: Any, qapidir: str) -> None:

@env is QAPIDocDirective.state.document.settings.env, i.e. something
deep in Sphinx.  I assume Any is the best Sphinx lets you do here.

>          self._env = env
>          self._qapidir = qapidir
>  
> -    def visit_module(self, name):
> +    def visit_module(self, name: str) -> None:
>          if name != "./builtin":
>              qapifile = self._qapidir + "/" + name
>              self._env.note_dependency(os.path.abspath(qapifile))
> @@ -65,10 +75,10 @@ def visit_module(self, name):
>  
>  
>  class NestedDirective(Directive):
> -    def run(self):
> +    def run(self) -> Sequence[nodes.Node]:
>          raise NotImplementedError
>  
> -    def do_parse(self, rstlist, node):
> +    def do_parse(self, rstlist: StringList, node: nodes.Node) -> None:
>          """
>          Parse rST source lines and add them to the specified node
>  
> @@ -93,15 +103,15 @@ class QAPIDocDirective(NestedDirective):
>      }
>      has_content = False
>  
> -    def new_serialno(self):
> +    def new_serialno(self) -> str:
>          """Return a unique new ID string suitable for use as a node's ID"""
>          env = self.state.document.settings.env
>          return "qapidoc-%d" % env.new_serialno("qapidoc")
>  
> -    def transmogrify(self, schema) -> nodes.Element:
> +    def transmogrify(self, schema: QAPISchema) -> nodes.Element:
>          raise NotImplementedError
>  
> -    def legacy(self, schema) -> nodes.Element:
> +    def legacy(self, schema: QAPISchema) -> nodes.Element:
>          vis = QAPISchemaGenRSTVisitor(self)
>          vis.visit_begin(schema)
>          for doc in schema.docs:
> @@ -109,9 +119,9 @@ def legacy(self, schema) -> nodes.Element:
>                  vis.symbol(doc, schema.lookup_entity(doc.symbol))
>              else:
>                  vis.freeform(doc)
> -        return vis.get_document_node()
> +        return vis.get_document_node()  # type: ignore

This is where you call qapidoc_legacy.py, which remains untyped.  Okay.

>  
> -    def run(self):
> +    def run(self) -> Sequence[nodes.Node]:
>          env = self.state.document.settings.env
>          qapifile = env.config.qapidoc_srctree + "/" + self.arguments[0]
>          qapidir = os.path.dirname(qapifile)
> @@ -185,7 +195,7 @@ def _highlightlang(self) -> addnodes.highlightlang:
>          )
>          return node
>  
> -    def admonition_wrap(self, *content) -> List[nodes.Node]:
> +    def admonition_wrap(self, *content: nodes.Node) -> List[nodes.Node]:
>          title = "Example:"
>          if "title" in self.options:
>              title = f"{title} {self.options['title']}"
> @@ -231,7 +241,7 @@ def run(self) -> List[nodes.Node]:
>          return self.admonition_wrap(*content_nodes)
>  
>  
> -def setup(app):
> +def setup(app: Sphinx) -> ExtensionMetadata:
>      """Register qapi-doc directive with Sphinx"""
>      app.add_config_value("qapidoc_srctree", None, "env")
>      app.add_directive("qapi-doc", QAPIDocDirective)
> diff --git a/docs/sphinx/qapidoc_legacy.py b/docs/sphinx/qapidoc_legacy.py
> index 679f38356b1..13520f4c26b 100644
> --- a/docs/sphinx/qapidoc_legacy.py
> +++ b/docs/sphinx/qapidoc_legacy.py
> @@ -1,4 +1,5 @@
>  # coding=utf-8
> +# type: ignore
>  #
>  # QEMU qapidoc QAPI file parsing extension
>  #

Types look good to me.


