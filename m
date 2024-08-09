Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7278CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLFe-0000Np-QZ; Fri, 09 Aug 2024 04:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scLFV-0008W8-3d
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:45:25 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scLFS-0002mE-0b
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723193122; x=1754729122;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hkvsZS0fdROU6ScnxB4WAjsIm1MnTN09BDHI1xYG6L8=;
 b=CqCWWJUivs6sTdbHXB691DZCZ1r4HaTBcQibDEDzS1Q5poxKm3V0ZV8f
 jG8zHuxArnaTMjYqu4spVVCH7BVrtNQNcHihhh1fU8y0wUArsPw5mH3gM
 ZN14bYSYjS76oQsarrZ1gn1q16IYnUHNMAu5RHhK5+ztzXRRb3ylM4SH8
 QYUqNpvMKtnM8XTgB5qIZt79b2BgP0nRpDcBvVLx8ERvbFeMyoVSKJe7s
 4Bmrz1NlABASrdOE/MV3+D7r0U5UlsTCAFiEuMFRKGVj3+Ji3kPj6bRPr
 Tay/nr5LnLmq/IRo6G5qrHjvV8dZ7auVs11nLXcaI0RR+9hw8stEczm+G g==;
X-CSE-ConnectionGUID: t1M5UwV5RG6Fz0iY0k/9bw==
X-CSE-MsgGUID: M8yOot77QyunJeQZjmoKRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="12931495"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="12931495"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 01:45:18 -0700
X-CSE-ConnectionGUID: 6TCl3s8VQO+LFCPgalAXgw==
X-CSE-MsgGUID: WckzEW+fSpa2THOAo14/dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="62144995"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 09 Aug 2024 01:45:16 -0700
Date: Fri, 9 Aug 2024 17:01:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xin Li <xin@zytor.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 lei4.wang@intel.com, xin3.li@intel.com
Subject: Re: [PATCH v1 3/3] target/i386: Raise the highest index value used
 for any VMCS encoding
Message-ID: <ZrXa0zdri8cXnt1a@intel.com>
References: <20240807081813.735158-1-xin@zytor.com>
 <20240807081813.735158-4-xin@zytor.com>
 <ZrOVSXX2uvezT3J1@intel.com>
 <235c9a61-fe2c-4124-acbb-e7ab287164fc@zytor.com>
 <e2b97f46-0913-4cc7-ac28-635170bea1f5@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2b97f46-0913-4cc7-ac28-635170bea1f5@zytor.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Fri, Aug 09, 2024 at 12:38:02AM -0700, Xin Li wrote:
> Date: Fri, 9 Aug 2024 00:38:02 -0700
> From: Xin Li <xin@zytor.com>
> Subject: Re: [PATCH v1 3/3] target/i386: Raise the highest index value used
>  for any VMCS encoding
> 
> On 8/8/2024 11:27 PM, Xin Li wrote:
> > > > +    if (f[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
> > > > +        /* FRED injected-event data (0x2052).  */
> > > > +        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x52);
> > > 
> > > HMM, I have the questions when I check the FRED spec.
> > > 
> > > Section 9.3.4 said, (for injected-event data) "This field has uses the
> > > encoding pair 2052H/2053H."
> > > 
> > > So why adjust the highest index to 0x52 other than 0x53?
> 
> Okay, found it in the Intel SDM:
> 
> Index. Bits 9:1 distinguish components with the same field width and type.
> 
> Bit 0 is not included in the index field.

Thanks for your education and explanation! I see, for
IA32_VMX_VMCS_ENUM, bit 0 is reserved and only index field is enough.

Regards,
Zhao


