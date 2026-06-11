Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5552ECD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgoR-00025L-Mk; Thu, 11 Jun 2026 10:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wXgoO-00024p-MX; Thu, 11 Jun 2026 10:55:16 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wXgoM-0004eR-AZ; Thu, 11 Jun 2026 10:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781189715; x=1812725715;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=9O+AiuAD0x+MEYvWTgj96gjmpLD7simCz3s5IofkHWY=;
 b=oBQu2NQoxtT1pVHg9E/NpULyJGoHWTa7yKcdt0YBmYxmOlqaDd+JFg/n
 CzOX4PEuP3+qBOasvtpVv1I3TTgX7r3mvqTLGxJoL0bNEbgnn5+wDklK4
 tYx/3yG9WgsmGApQo7wG7h8lgOy0S9JJ8tNpA5FQs5yiCw4jd5QPvZgwL
 tCKrM3chH9+YbPttZnJpFhZb8gDx7QA68JX3w9sb5RuCZ7YQYr5ONmxIP
 EJtp188fVh64mc4rZxKLC4M1b3NU32bXnwlHzI3EVQz+WOOyEtzFl5jkI
 lQGwIjgJRQUHeGyjV1ExNgEs/ToX/4dH87P7yHcAipEWQVUaHkkLDdC9Z Q==;
X-CSE-ConnectionGUID: UMhhyqELQ8mYXwltU/vPCw==
X-CSE-MsgGUID: I2mRQizDSqGCOJsMY3fahA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99579791"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="99579791"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 07:55:10 -0700
X-CSE-ConnectionGUID: /28juovqQO6w5etGyBepyQ==
X-CSE-MsgGUID: cTnpv9OiQfi1AeVxzLsxBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="245395064"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 11 Jun 2026 07:55:08 -0700
Date: Thu, 11 Jun 2026 23:23:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH v3 15/19] scripts/qapi: generate high-level Rust bindings
Message-ID: <airS4hj5u/9T2T2H@intel.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
 <20260526175618.227743-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526175618.227743-16-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

[snip]

> +def rs_name(name: str) -> str:
> +    """
> +    Map @name to a valid, possibly raw Rust identifier.
> +    """
> +    name = re.sub(r'[^A-Za-z0-9_]', '_', name)
> +    if name[0].isnumeric():
> +        name = '_' + name
> +    # based from the list:
> +    # https://doc.rust-lang.org/reference/keywords.html
> +    if name in ('Self', 'abstract', 'as', 'async',
                    ^^^^
> +                'await', 'become', 'box', 'break',
> +                'const', 'continue', 'crate', 'do',
                                         ^^^^^
> +                'dyn', 'else', 'enum', 'extern',
> +                'false', 'final', 'fn', 'for',
> +                'if', 'impl', 'in', 'let',
> +                'loop', 'macro', 'match', 'mod',
> +                'move', 'mut', 'override', 'priv',
> +                'pub', 'ref', 'return', 'self',
                                            ^^^^
> +                'static', 'struct', 'super', 'trait',
                                        ^^^^^
> +                'true', 'try', 'type', 'typeof',
> +                'union', 'unsafe', 'unsized', 'use',
> +                'virtual', 'where', 'while', 'yield'):
> +        name = 'r#' + name

EMM, r#self, r#Self, r#crate and r#super are "RESERVED_RAW_IDENTIFIER",
and "It is an error to use the RESERVED_RAW_IDENTIFIER token". [*]

[*]: https://doc.rust-lang.org/reference/identifiers.html#grammar-RESERVED_RAW_IDENTIFIER

We can't use 'q_' prefix for these special case, or what about
name + '_'?

e.g.,

if name in ('self', 'Self', 'crate', 'super'):
   name = name + '_'
elif name in (...)
   name = 'r#' + name

> +
> +    return name
> +

[snip]

> @@ -502,6 +515,9 @@ def is_implicit(self) -> bool:
>      def c_type(self) -> str:
>          return c_name(self.name) + POINTER_SUFFIX
>  
> +    def rs_type(self) -> str:

Only a nit, it's better to check _checked before accessing element_type
(just refer Markus' suggestion in v2)

assert self._checked

> +        return 'Vec<%s>' % self.element_type.rs_type()
> +

Regards,
Zhao


