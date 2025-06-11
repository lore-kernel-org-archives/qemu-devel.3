Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221E7C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPGCK-0002Dm-HJ; Wed, 11 Jun 2025 03:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPGCI-0002DW-Jz; Wed, 11 Jun 2025 03:48:34 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPGCG-0005Yk-0n; Wed, 11 Jun 2025 03:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749628112; x=1781164112;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Htxx1W5DV9BbrswGnir0GHKqPRLkRUgFJGmRtjrtWbA=;
 b=gfj/074pzzEWa56MP7b409z56AOFzPzGv6CTEP2NbW47BhMJnbeOJ1Pn
 Zf0CvSHSA9a39HN+l9EaEu3hTEu3Y+6Ay0RX6qnRVIX+vwbfBqDOX6lV9
 3eqkAUv7clnUusNCK/jdNn5yQZWyoHdU492aTG5+illmOp3UlrZwltMod
 I0ScRsmlWxunCtmtPtiarHKl3YNZig3zu32gLwXPox0JBNM247Fa2vkCQ
 8IyqyfvS344uit5PZIzYA0REpLC/UebrvKCNAwTZWHCDMJTxi/KJWraHP
 8w4GqcFL4n9WfGL5OYxc1zkVMlgu3ovMVPCbIWgGlQ/gnvK4P56+j5UHQ Q==;
X-CSE-ConnectionGUID: dsTYOyWkS+yAuBTO6UDUwg==
X-CSE-MsgGUID: Ao+S14ptT3O7Vb4YxnUhnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51906650"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51906650"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 00:48:26 -0700
X-CSE-ConnectionGUID: wwYCDrjmRTCpqMBDX9tWYw==
X-CSE-MsgGUID: uBCEGinBRhuNrJzvtiKNlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="147594201"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2025 00:48:25 -0700
Date: Wed, 11 Jun 2025 16:09:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org, armbru@redhat.com, mkletzan@redhat.com
Subject: Re: [PATCH 3/3] scripts/qapi: generate high-level Rust bindings
Message-ID: <aEk5xDG+kcr3NEok@intel.com>
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <20250605101124.367270-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605101124.367270-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jun 05, 2025 at 12:11:24PM +0200, Paolo Bonzini wrote:
> Date: Thu,  5 Jun 2025 12:11:24 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/3] scripts/qapi: generate high-level Rust bindings
> X-Mailer: git-send-email 2.49.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Generate high-level idiomatic Rust code for the QAPI types, with to/from
> translations for the C FFI.
> 
> - char* is mapped to String, scalars to there corresponding Rust types
> 
> - enums are simply aliased from FFI
> 
> - has_foo/foo members are mapped to Option<T>
> 
> - lists are represented as Vec<T>
> 
> - structures have Rust versions, with To/From FFI conversions
>
> - alternate are represented as Rust enum
> 
> - unions are represented in a similar way as in C: a struct S with a "u"
>   member (since S may have extra 'base' fields). However, the discriminant
>   isn't a member of S, since Rust enum already include it.

Why not map the C union to rust union directly (in `pub enum %(rs_name)sVariant`)?

(latter comments are all about format nits)

...

> +%(cfg)s
> +impl From<&%(rs_name)sVariant> for %(tag)s {
> +    fn from(e: &%(rs_name)sVariant) -> Self {
> +        match e {
> +    ''',
> +                cfg=ifcond.rsgen(),
> +                rs_name=rs_name(name),
> +                tag=rs_type(variants.tag_member.type.c_type(), ''))
> +
> +    for var in variants.variants:
> +        type_name = var.type.name
> +        var_name = to_camel_case(rs_name(var.name))
> +        patt = '(_)'
> +        if type_name == 'q_empty':
> +            patt = ''
> +        ret += mcgen('''
> +    %(cfg)s

This introduces extra \n, which will generate a blank line if there's
no cfg.

> +    %(rs_name)sVariant::%(var_name)s%(patt)s => Self::%(var_name)s,

So, I think it should be:

    %(cfg)s    %(rs_name)sVariant::%(var_name)s%(patt)s => Self::%(var_name)s,

> +''',
> +                     cfg=var.ifcond.rsgen(),
> +                     rs_name=rs_name(name),
> +                     var_name=var_name,
> +                     patt=patt)
> +
> +    ret += mcgen('''
> +        }
> +    }
> +}
> +''')
> +    return ret
> +
> +
> +def gen_rs_variants(name: str,
> +                    ifcond: QAPISchemaIfCond,
> +                    variants: Optional[QAPISchemaVariants]) -> str:
> +    ret = mcgen('''
> +
> +%(cfg)s
> +#[derive(Clone,Debug)]
> +pub enum %(rs_name)sVariant {
> +''',
> +                cfg=ifcond.rsgen(),
> +                rs_name=rs_name(name))
> +
> +    for var in variants.variants:
> +        type_name = var.type.name
> +        var_name = to_camel_case(rs_name(var.name, False))
> +        if type_name == 'q_empty':
> +            ret += mcgen('''
> +    %(cfg)s
> +    %(var_name)s,

ditto,

    %(cfg)s    %(var_name)s,

> +''',
> +                         cfg=var.ifcond.rsgen(),
> +                         var_name=var_name)
> +        else:
> +            c_type = var.type.c_unboxed_type()
> +            if c_type.endswith('_wrapper'):
> +                c_type = c_type[6:-8]  # remove q_obj*-wrapper
> +            ret += mcgen('''
> +    %(cfg)s
> +    %(var_name)s(%(rs_type)s),

    %(cfg)s    %(var_name)s(%(rs_type)s),

> +''',
> +                         cfg=var.ifcond.rsgen(),
> +                         var_name=var_name,
> +                         rs_type=rs_type(c_type, ''))
> +
> +    ret += mcgen('''
> +}
> +''')
> +
> +    ret += gen_rs_variants_to_tag(name, ifcond, variants)
> +
> +    return ret
> +
> +
> +def gen_rs_members(members: List[QAPISchemaObjectTypeMember],
> +                   exclude: List[str] = None) -> str:
> +    exclude = exclude or []
> +    return [f"{m.ifcond.rsgen()} {to_snake_case(rs_name(m.name))}"
> +            for m in members if m.name not in exclude]
> +
> +
> +def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
> +    ret = ''
> +    for memb in members:
> +        typ = rs_type(memb.type.c_type(), '', optional=memb.optional, box=True)
> +        ret += mcgen('''
> +    %(cfg)s
> +    pub %(rs_name)s: %(rs_type)s,

    %(cfg)s    pub %(rs_name)s: %(rs_type)s,

> +''',
> +                     cfg=memb.ifcond.rsgen(),
> +                     rs_type=typ,
> +                     rs_name=to_snake_case(rs_name(memb.name)))
> +    return ret
> +
> +

...

> +%(cfg)s
> +#[repr(u32)]
> +#[derive(Copy, Clone, Debug, PartialEq, Eq, qemu_api_macros::TryInto)]
> +pub enum %(rs_name)s {
> +''',
> +                cfg=ifcond.rsgen(),
> +                rs_name=rs_name(name))
> +
> +    for member in enum_members:
> +        ret += mcgen('''
> +    %(cfg)s
> +    %(c_enum)s,

    %(cfg)s    %(c_enum)s,

> +''',
> +                     cfg=member.ifcond.rsgen(),
> +                     c_enum=to_camel_case(rs_name(member.name)))
> +    # picked the first, since that's what malloc0 does
> +    # but arguably could use _MAX instead, or a qapi annotation
> +    default = to_camel_case(rs_name(enum_members[0].name))
> +    ret += mcgen('''
> +}
> +

...

> +def gen_rs_alternate(name: str,
> +                     ifcond: QAPISchemaIfCond,
> +                     variants: Optional[QAPISchemaVariants]) -> str:
> +    if name in objects_seen:
> +        return ''
> +
> +    ret = ''
> +    objects_seen.add(name)
> +
> +    ret += mcgen('''
> +%(cfg)s
> +#[derive(Clone, Debug)]
> +pub enum %(rs_name)s {
> +''',
> +                 cfg=ifcond.rsgen(),
> +                 rs_name=rs_name(name))
> +
> +    for var in variants.variants:
> +        if var.type.name == 'q_empty':
> +            continue
> +        ret += mcgen('''
> +        %(cfg)s
> +        %(mem_name)s(%(rs_type)s),

    %(cfg)s    %(mem_name)s(%(rs_type)s),

> +''',
> +                     cfg=var.ifcond.rsgen(),
> +                     rs_type=rs_type(var.type.c_unboxed_type(), ''),
> +                     mem_name=to_camel_case(rs_name(var.name)))
> +
> +    ret += mcgen('''
> +}
> +''')
> +    return ret

