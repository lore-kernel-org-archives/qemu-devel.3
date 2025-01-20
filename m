Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDCAC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 16:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZuiu-0005VO-0l; Mon, 20 Jan 2025 11:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tZuir-0005Ur-FQ; Mon, 20 Jan 2025 11:33:57 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tZuio-0007vs-IQ; Mon, 20 Jan 2025 11:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737390834; x=1768926834;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=e7xyfVhmJGr3MUJ0nFvs5TvCu9bCvaJCs1lzqESuWGk=;
 b=KsZKZPo5ci96KIrPYT34noNYuP4Enz/AVeuvFpO+TQt3ADJqNsXR4hj1
 +FgZBXXbojHw/8zni3q2tkRF9NzZVb70rWDkXuBYVfYRb5bL6hh671OL0
 Kt1FJPWwDwe5QJgJTdZtHSlOhhTjsWOmYWTKYbF4Xh5wsGBk77ucVUnE6
 iQccNH7WKUB79n43ix2HaMiW57HCmRv4HAQfftHc1ipSq7BvbNAl3Bl3w
 9PeBFrcwkc+W4NxAODX51DEOiamAops2yqKen/oKwZiUtFTd8W01AMyLt
 bFKYvoVDlYZEYWHtvwCjQ7sVGVhkyAQOMvuN+IrBpbxaxDsAOCSJtYBlp Q==;
X-CSE-ConnectionGUID: P5Sej4VLRqmnjUSkDLitEQ==
X-CSE-MsgGUID: KJuHn7CtRouWoBOTBlPn+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="40609629"
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; d="scan'208";a="40609629"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 08:33:09 -0800
X-CSE-ConnectionGUID: zgF1DjRuS1+C0HkFuC+NvQ==
X-CSE-MsgGUID: VZ49O1CKRCmOoPrLYJ+Csg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="129833174"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 20 Jan 2025 08:33:07 -0800
Date: Tue, 21 Jan 2025 00:52:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
Message-ID: <Z45/MNYY5jD5fNET@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
 <CABgObfZSR2s5AYEAcJfsdF0jKQGf_AVcDafKQq47qzLmBuX0RQ@mail.gmail.com>
 <CAFEAcA_dVnpN2Vn+VAf1XZSAdj183wJhQZ3pVNtb=NHeMOF2Jg@mail.gmail.com>
 <CABgObfaAdDtrLF4tWL17Lmw9UKiLRNVvuiDZsQxc-9Wd8W61Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfaAdDtrLF4tWL17Lmw9UKiLRNVvuiDZsQxc-9Wd8W61Dw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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

On Fri, Dec 06, 2024 at 02:13:57PM -0500, Paolo Bonzini wrote:
> Date: Fri, 6 Dec 2024 14:13:57 -0500
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 06/13] rust: add bindings for memattrs
> 
> Il ven 6 dic 2024, 09:42 Peter Maydell <peter.maydell@linaro.org> ha
> scritto:
> 
> > On Fri, 6 Dec 2024 at 14:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > Yes, hence "decently" packed. But I think in both cases it's passed in
> > registers, and for 64-bit machine that shouldn't change anything.
> >
> > True. Though it does mean we go from "space to add new fields
> > without making it overflow from one register to two" to
> > "completely full and no space for expanding it".
> >
> 
> I guess it's enough to make unspecified the only non-bitfield. Then you can
> declare MEMTXATTRS_UNSPECIFIED as { unspecified: true, ..Zeroable::ZERO }
> ("start with Zeroable::ZERO and change unspecified to true"). For the rest
> it is not important to make them available in a "const".
>

Sorry I missed this comment before...

Now I have a MemTxAttrs like,

typedef struct MemTxAttrs {
    unsigned int secure:1;
    unsigned int space:2;
    unsigned int user:1;
    unsigned int memory:1;
    unsigned int requester_id:16;
    unsigned int pid:8;
    bool unspecified;
    uint8_t _reserved1;
    uint16_t _reserved2;
} MemTxAttrs;

and its binding is,

#[repr(C)]
#[repr(align(4))]
#[derive(Debug, Default, Copy, Clone)]
pub struct MemTxAttrs {
    pub _bitfield_align_1: [u16; 0],
    pub _bitfield_1: __BindgenBitfieldUnit<[u8; 4usize]>,
    pub unspecified: bool,
    pub _reserved1: u8,
    pub _reserved2: u16,
}

unfortunately, Zeroable can't be applied to __BindgenBitfieldUnit since
event its member (`storage`) is private :-(.

But there's a solution to force (and at the same time unsafely) ZERO the
entire structure in const:

 * const_zero macro: https://docs.rs/const-zero/latest/const_zero/


With const_zero, we can implement Zeroable for MemTxAttrs:

unsafe impl Zeroable for MemTxAttrs {
    const ZERO: Self = unsafe {const_zero!(MemTxAttrs)};
}

pub static MEMTXATTRS_UNSPECIFIED: MemTxAttrs = MemTxAttrs {
    unspecified: true,
    ..Zeroable::ZERO
};


So do you like this idea? If so, I can be a mover to introduce
const_zero macro.

Thanks,
Zhao


