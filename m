Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C77CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4cL-000494-2f; Thu, 04 Jun 2026 05:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wV4cB-00047P-6Z; Thu, 04 Jun 2026 05:43:51 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wV4c8-0008MT-23; Thu, 04 Jun 2026 05:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566228; x=1812102228;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jBnhXAJYaU2gjrYB2lA/Qkt0NX8m65lNZvcnPX205Jw=;
 b=OUM+fqSiPu2xVJVimDVfvtapHNbY/WBlq2jGKo2DT198oZO4AetA5q4n
 ISbyHViu48OHKgdI8/qxjyYFZZu6m85hlyQaQCDyguFBDTrIRtKYQf2lf
 nyQMugrUrSQ+CbNuj+jurNbwYiStFw4kX3Ey+vWuMT1uJS7sl21+OEYKw
 vuW87H8b3Pjch06O7Wfv0FOX4wvZHf0KnLPbtyxdaRjXf20j6d0gIY9Zs
 A93j46P1n/U4gsQqyC0Tmgj7eC8Kha8EmUr1JxFYMXxlQxGasvxTY/41/
 3dmqxD9uIhVNHCer56gK+mKQMaFHpmRmeiPH68DXMBAFpZ+5J/IlAOqtO w==;
X-CSE-ConnectionGUID: pS39nGR9Qv6/IUnPxncvIQ==
X-CSE-MsgGUID: mkJARUYjS7yMsqWSWyoESQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92763291"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="92763291"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:43:41 -0700
X-CSE-ConnectionGUID: 6b2kWFhpTlGMXcElwRsFEw==
X-CSE-MsgGUID: 87F8hMR7SfiBYGlU8Jwzhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="244355682"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 04 Jun 2026 02:43:40 -0700
Date: Thu, 4 Jun 2026 18:11:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH v3 15/19] scripts/qapi: generate high-level Rust bindings
Message-ID: <aiFPYDvtWdAXD1kk@intel.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
 <20260526175618.227743-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526175618.227743-16-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 26, 2026 at 07:56:14PM +0200, Paolo Bonzini wrote:
> Date: Tue, 26 May 2026 19:56:14 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v3 15/19] scripts/qapi: generate high-level Rust bindings
> X-Mailer: git-send-email 2.54.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Generate high-level native Rust declarations for the QAPI types.
> 
> - char* is mapped to String, scalars to there corresponding Rust types
> 
> - enums use #[repr(u32)] and can be transmuted to their C counterparts
> 
> - has_foo/foo members are mapped to Option<T>
> 
> - lists are represented as Vec<T>
> 
> - structures map fields 1:1 to Rust
> 
> - alternate are represented as Rust enum, each variant being a 1-element
>   tuple
> 
> - unions are represented in a similar way as in C: a struct S with a "u"
>   member (since S may have extra 'base' fields). The discriminant
>   isn't a member of S, since Rust enum already include it, but it can be
>   recovered with "mystruct.u.into()"
> 
> Anything that includes a recursive struct puts it in a Box.  Lists are
> not considered recursive, because Vec breaks the recursion (it's possible
> to construct an object containing an empty Vec of its own type).
> 
> Given the experimental nature of Rust, and the incompleteness of the
> backend (it lacks commands and events), QAPIRsBackend is not modular
> and is not built together with the C and trace-event files.  It can
> be used by specifying "-B qapi.backend.QAPIRsBackend" on the qapi-gen
> command line.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lureau@redhat.com
> [Paolo: rewrite conversion of leaf types]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build              |   4 +-
>  scripts/qapi/backend.py  |  25 +++
>  scripts/qapi/common.py   |  49 ++++++
>  scripts/qapi/rs.py       |  50 ++++++
>  scripts/qapi/rs_types.py | 372 +++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/schema.py   |  59 +++++--
>  6 files changed, 540 insertions(+), 19 deletions(-)
>  create mode 100644 scripts/qapi/rs.py
>  create mode 100644 scripts/qapi/rs_types.py

Revisiting the v2 discussion, I think maybe it's still possible to use
visit_module to identify predefined cases (in schema builtn module)
instead of is_predefined?

(I guess that's what Markus wanted in v2, hopefully... and apologies if
this is a bit too verbose. I'm learning QAPI code so I want to explain
my undersatnding in as much details as possible (to ensure "IIUC") :). )

> +class QAPISchemaGenRsTypeVisitor(QAPISchemaRsVisitor):
> +    _schema: Optional[QAPISchema]
> +
> +    def __init__(self, prefix: str) -> None:
> +        super().__init__(prefix, 'qapi-types',
> +                         'Schema-defined QAPI types', __doc__)
> +
> +    def visit_begin(self, schema: QAPISchema) -> None:
> +        self._schema = schema
> +        objects_seen.add(schema.the_empty_object_type.name)
> +
> +        self._gen.preamble_add(
> +            mcgen('''
> +#![allow(unexpected_cfgs)]
> +#![allow(non_camel_case_types)]
> +#![allow(clippy::empty_structs_with_brackets)]
> +#![allow(clippy::large_enum_variant)]
> +#![allow(clippy::pub_underscore_fields)]
> +
> +// Because QAPI structs can contain float, for simplicity we never
> +// derive Eq.  Clippy however would complain for those structs
> +// that *could* be Eq too.
> +#![allow(clippy::derive_partial_eq_without_eq)]
> +
> +use util::qobject::QObject;
> +'''))

IIUC, though there's only a single QAPIGenRs, but we can just use
visit_module to cache a flag and don't need to skip something like C
did:

def visit_module(self, name: str) -> None:
    self._in_builtin_module = QAPISchemaModule.is_builtin_module(name)

builtin module is created by schema and is maintained in _module_dict
(in QAPISchema.__init__()). When QAPISchema iterates through _module_dict,
it will always visit he builtin module and once it enters builtin module,
visit_module() will be called (QAPISchemaModule.visit()).

With _in_builtin_module flag, then we just need to "proof" it has the
same effect as is_predefined() method.

> +    def visit_object_type(self,
> +                          name: str,
> +                          info: Optional[QAPISourceInfo],
> +                          ifcond: QAPISchemaIfCond,
> +                          features: List[QAPISchemaFeature],
> +                          base: Optional[QAPISchemaObjectType],
> +                          members: List[QAPISchemaObjectTypeMember],
> +                          branches: Optional[QAPISchemaVariants]) -> None:
> +        assert self._schema is not None

(if we use self._in_builtin_module, this assertion can go away.)

> +        if self._schema.is_predefined(name) or name.startswith('q_'):

This is called by QAPISchemaObjectType not QAPISchemaBuiltinType, and
QType is QPAISchemaEnumType.

Only q_empty could hit is_predefined(), and q_empty has been included
into builtin module (in QAPISchema._def_predefineds()).

And a good thing is _def_predefineds() doesn't add other object type
into builtin module! So "self._schema.is_predefined(name)" is same as
"self._in_builtin_module"!

> +            return
> +        self._gen.add(gen_rs_object(name, ifcond, base, members, branches))
> +
> +    def visit_enum_type(self,
> +                        name: str,
> +                        info: Optional[QAPISourceInfo],
> +                        ifcond: QAPISchemaIfCond,
> +                        features: List[QAPISchemaFeature],
> +                        members: List[QAPISchemaEnumMember],
> +                        prefix: Optional[str]) -> None:
> +        assert self._schema is not None

(if we use self._in_builtin_module, this assertion can go away.

> +        if self._schema.is_predefined(name):
> +            return

Similiarly, only QType can hit is_predefined(), and builtin module has
only one enum: QType, therefore it's safe to use self._in_builtin_module
here, too.

> +        self._gen.add(gen_rs_enum(name, ifcond, members))
>
> +    def visit_alternate_type(self,
> +                             name: str,
> +                             info: Optional[QAPISourceInfo],
> +                             ifcond: QAPISchemaIfCond,
> +                             features: List[QAPISchemaFeature],
> +                             alternatives: QAPISchemaVariants) -> None:

I think maybe we also should ship builtin for alternatives type.
although for now there's no predefined alternatives...

> +        self._gen.add(gen_rs_alternate(name, ifcond, alternatives))
> +
> +

... Overall, it seems checking builtin module is more robust and
porvides forward compatibility, and we don't need to add special case to
check.

Regards,
Zhao



