Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836BDC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCrd-0007Y1-21; Tue, 21 Jan 2025 06:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taCra-0007Xg-Bs
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:56:10 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taCrX-00053V-Nh
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737460568; x=1768996568;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kMiLQwcXQG1zpki8Rvyb/zvPF7Gcu8Np0v+f5Pbgak4=;
 b=ECIztmxpe7flZlKWOXaMpRte3RvSvlWXu0wS++9KHNGGhy8c4J9881hC
 wVGk+Ttxj0euEZ+vSeysPm83EFsskfhmCHoWkOuDWvx2ynUXuvGjZpkM5
 dD+YGxfUZ0olYmcEN/ktAM7Bk31OnxeazZIA5r8nQpLyHeg2761JfTDnn
 st9jN4xzHGZ3FfHR+PrvaQOAaEO0fGMgWGt0O9eY6trchSi8IkP/4cHQ/
 zrhoy4fesP5jS/Y4EzngaWEj12/j0bfG6r1Hsd7WXNzfx7hInYMIoY1y9
 ZVfKakzkF3cjdz1lgXXws9P0q+rAv0WoZ4AGEbSYArylKS35ifduPSHfL w==;
X-CSE-ConnectionGUID: S5PJX84uRkGnww3fs0/bLg==
X-CSE-MsgGUID: v9KGQ6q7Qf+54KHYfSZvVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="25468205"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="25468205"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 03:56:05 -0800
X-CSE-ConnectionGUID: lAKdxn3tTuGBQ7o5kz6wGw==
X-CSE-MsgGUID: JDj2LSRmREOeteuK1awOIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="107391274"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 21 Jan 2025 03:56:03 -0800
Date: Tue, 21 Jan 2025 20:15:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=C3?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] memattrs: Get rid of bit fields
Message-ID: <Z4+P3eHXqcU4Dqdx@intel.com>
References: <20250120074258.2204342-1-zhao1.liu@intel.com>
 <20250120074258.2204342-2-zhao1.liu@intel.com>
 <CAFEAcA_VAOU+p_BC5bpnk2GKa5piywjf+yhFTh=-3O7TGut+uA@mail.gmail.com>
 <Z458D/RuBQ8Kq0al@intel.com>
 <99397e13-e74e-45e0-8f2a-6d045407bc81@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99397e13-e74e-45e0-8f2a-6d045407bc81@eviden.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

Hi CLEMENT,

> > It still raises the size to 8 bytes but saves spare space, like:
> >
> > typedef struct MemTxAttrs {
> >      unsigned int secure:1;
> >      unsigned int space:2;
> >      unsigned int user:1;
> >      unsigned int memory:1;
> >      unsigned int requester_id:16;
> >      unsigned int pid:8;
> >      bool unspecified;
> >      uint8_t _reserved1;
> >      uint16_t _reserved2;
> > } MemTxAttrs;
> 
> Don't you think this will be an issue as some devices will need to
> support more than 256 PID/PASID? The PCIe spec allows using up to 20 bits.
>

Maybe we can have the layout of MeymTxAttrs like this:

typedef struct MemTxAttrs {
    unsigned int pid:20;
    uint16_t requester_id:16;
    uint8_t secure:1;
    uint8_t space:2;
    uint8_t user:1;
    uint8_t memory:1;
    bool unspecified;
} MemTxAttrs;

I think a finer granularity division could solve this issue. And
there're still some spare spaces :-).

Thanks,
Zhao


