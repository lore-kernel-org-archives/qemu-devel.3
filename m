Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD4DC61DD3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 02:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1au4-0007CZ-7S; Tue, 01 Sep 2026 22:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1x1atv-0007Bl-Pf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 22:40:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1x1atq-0001cC-Ba
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 22:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788316831; x=1819852831;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5IN0z1ZZrUobt1+FBF8TYpgY034UGdiu0Zc3yJMpNMY=;
 b=CcAdlnFS0vMC+OC+B1btAo83InR7A/otOd+u+q6iSHHIPddmUqow5xHS
 enGNorxFyTPk1XFeSjl+IQNqvuNL+VmleT+BaL3oGZCXk1MZKVEvQHgNp
 G/r7TiYkVeGfirIKqy/Gz3u8FL+AKbNMdRq9/pwDJmYs5+HHxc21PnyP9
 jHc4UY+DYLgjFrL7ocw/6r3ZuL34YXYx5//QDv/phMRalP72I+KXbwx70
 jN521GQY2eYOlDw2JMEf9LzByISxiW/lUAI9s621cBXn4cxTMEP9u+Amp
 5INTHkIMTe8jrXwwNYTdthWDXOk+dQiMZmWupikNLF3xXijEANP4ZDvyU A==;
X-CSE-ConnectionGUID: A3pCyCZFQYGxcnEszKbHiA==
X-CSE-MsgGUID: 5GzgcG3LS3ayaBnPkcaZdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100116823"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="100116823"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 19:40:26 -0700
X-CSE-ConnectionGUID: oHUYpSz2S4KS3trJWD3L8w==
X-CSE-MsgGUID: FDlN/uNLTVOMzU1QaP7wQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="264982787"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 19:40:23 -0700
Message-ID: <12100e0f-0730-4f12-81db-5e9dd18fef79@linux.intel.com>
Date: Wed, 2 Sep 2026 10:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/i386: Add support for LASS
To: Kishen Maloor <kishen.maloor@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com, farrah.chen@intel.com
References: <20260826035734.114685-1-kishen.maloor@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260826035734.114685-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/2026 11:57 AM, Kishen Maloor wrote:
> This series adds QEMU support for Linear Address Space Separation (LASS) [1],
> an Intel security feature that prevents a class of side-channel attacks
> relying on speculative accesses across the user/kernel boundary. Paging,
> along with SMEP and SMAP, already provides mode-based access protection,
> but enforcing it requires a page walk whose timing can leak the layout of
> kernel memory. LASS applies the equivalent protections during
> linear-address pre-processing: given the usual partitioning of the linear
> address space into a user half (bit 63 clear) and a supervisor half
> (bit 63 set), an access targeting the opposite half is rejected on the
> basis of bit 63 alone, before any page walk.
> 
> This series enumerates the LASS CPUID bit, recognizes CR4.LASS,
> and exposes LASS on the relevant Intel CPU models via new versioned models.
> LASS is not emulated by TCG.
> 
> Exposing LASS to a guest also requires KVM support: KVM must validate
> the CPUID bit and CR4.LASS, and enforce LASS violations in its
> instruction emulator. That enabling is currently under review [2].
> 
> Tested with a Linux guest on LASS-capable hardware: LASS is enumerated and
> CR4.LASS is set under KVM, and not enumerated under TCG.
> 
> [1] Intel 64 and IA-32 Architectures Software Developer's Manual, Volume 3A,
>     Section 4.3, "Linear-Address-Space Separation (LASS)".
> [2] https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/
> 
> Isaku Yamahata (2):
>   target/i386: Add support for LASS in CPUID enumeration
>   target/i386: Add LASS support in CR4
> 
> Kishen Maloor (3):
>   target/i386: Introduce DiamondRapids-v3 to enable LASS
>   target/i386: Introduce SierraForest-v7 to enable LASS
>   target/i386: Introduce ClearwaterForest-v5 to enable LASS

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> 
>  target/i386/cpu.c    | 26 +++++++++++++++++++++++++-
>  target/i386/cpu.h    |  7 ++++++-
>  target/i386/helper.c |  4 ++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 


