Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF88D13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 10:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5MfD-0000XY-Qu; Mon, 28 Oct 2024 06:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5Mf8-0000Wx-Sa
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 06:07:52 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5Mf6-0004gW-Gl
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 06:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730110068; x=1761646068;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mIXqyOw7BmdTqVyO0eOUDOuY78R2XIr1BhA4DKn+Zn4=;
 b=fgle7DRPQ3D3i2ZWaJYWQpJD1J8UZH6hMtsXihHp1D7S2v5PgAFRgoMp
 OEu7JIzrPSwlbe32FPFMmmWkcVnFRC3x72tIcEy4RCwQmd5JAg+lUHnc1
 uU4aOgA4g1GYoCE+Llgmzr+qbUjcGeD8fucw1JrrRmckVj5GG1wbrJ4as
 Ncw7cae5viDHJ99/CVXHWcbCl4ciKZ0+cnSn3TO3HaUuHgl2G8xFXQI5S
 gxeGAVjeA26bI0nm5rs7Jk5lE5n59JSWnIhj6UzYhKeWOJMvZd/SMTaVX
 4St/ONXt74OfBk9SUKqCsykK0RAEuj7P6qHV8wJVO+mNRIu1Te7P9FptX A==;
X-CSE-ConnectionGUID: nimYChpPSmS5uremoND8DA==
X-CSE-MsgGUID: mJSjmCvUSAmexEMrT1aWBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="33495768"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="33495768"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 03:07:45 -0700
X-CSE-ConnectionGUID: 11WMIT28RaS/oCSB7y4uXg==
X-CSE-MsgGUID: 9n4wEJnsTWS2zGWF8P5gyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="112409906"
Received: from linux.bj.intel.com ([10.238.157.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 03:07:44 -0700
Date: Mon, 28 Oct 2024 18:02:38 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com
Subject: Re: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
Message-ID: <Zx9hPncYMxsF3Hkh@linux.bj.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-5-tao1.su@linux.intel.com>
 <b9ca7c3e-86e6-4a25-9295-573dbacf0ce1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9ca7c3e-86e6-4a25-9295-573dbacf0ce1@redhat.com>
Received-SPF: none client-ip=198.175.65.14;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 28, 2024 at 09:45:39AM +0100, Paolo Bonzini wrote:
> On 10/28/24 03:45, Tao Su wrote:
> > Since the highest supported vector length for a processor implies that
> > all lesser vector lengths are also supported, add the dependencies of
> > the supported vector lengths. If all vector lengths aren't supported,
> > clear AVX10 enable bit as well.
> > 
> > Note that the order of AVX10 related dependencies should be kept as:
> >          CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
> >          CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
> >          CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,
> 
> I think you need to add a set of dependencies so that avx10 cannot be set,
> unless all the older AVX features that it's composed of are available.  From
> the manual these are
> 
> AVX512F, AVX512CD, AVX512VW, AVX512DQ, AVX512_VBMI, AVX512_IFMA,
> AVX512_VNNI, AVX512_BF16, AVX512_VPOPCNTDQ, AVX512_VBMI2, VAES, GFNI,
> VPCLMULQDQ, AVX512_BITALG, AVX512_FP16.

Thanks for such a quick review!!

AVX10.1 spec said:
Intel AVX-512 will continue to be supported on P-core-only processors for
the foreseeable future to support legacy applications. However, new vector
ISA features will only be added to the Intel AVX10 ISA moving forward.
While Intel AVX10/512 includes all Intel AVX-512 instructions, it
important to note that applications compiled to Intel AVX-512 with vector
length limited to 256 bits are not guaranteed to be compatible on an Intel
AVX10/256 processor.

I.e. AVX10/256 processors will support old AVX-512 instructions
(limited to 256 bits and enumerated by AVX10) but not set AVX-512 related
CPUIDs. So, I think we can't add these dependencies…


