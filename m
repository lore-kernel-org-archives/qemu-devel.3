Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A60CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXqh-0007VP-So; Thu, 14 Aug 2025 09:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1umXqY-0007MU-5N
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:18:24 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1umXqU-0008Oo-Jy
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755177499; x=1786713499;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=Yu0hRXF6m48qmsJhVo6AeK9muv2L7pUmOnM5bqGV+vU=;
 b=ecS+XOVyE1K86W2TtwQWGkCVr1liypsRt3o5GfZOpFGUY8CwdY2q9lNd
 4IEK8w0j0Wt3rhbJ4s0FB5oTtMayJx3fWhLzC9MmyzctvPjjxSpAUWwxi
 UasaEN+7f4sMAkymxT6Eno71WMoQA/O8OQo3ZXJhpOGTHk8a9JvHFganc
 EfAUezQbT1R5P2MT7kmZc11LtdMgtDeKALHKB7A5KRY5k96yUD986HdBh
 1drq+4C0/PTXPsURKsV0QyPuVx9QazJqTuO0YGYjmgx++pwgiuDFQ/G3f
 o0YVYfwwiBiZ5of26Pi3McYywcjs2Ivky3uCzrrEFkpz3GYCkS0Bnnd/w Q==;
X-CSE-ConnectionGUID: CBLloHGuSeeb9NAH6UVPsA==
X-CSE-MsgGUID: s4HaR4ItSqyX+jyV7wnGjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57560104"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="57560104"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 06:18:13 -0700
X-CSE-ConnectionGUID: olj3kvCCSreWTwBddTxXLQ==
X-CSE-MsgGUID: +xo/T3QDSXOcezYQYPIsbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="170966679"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 06:18:12 -0700
Message-ID: <58cc83b8-224f-4cde-9a89-0e6ce18d42ae@intel.com>
Date: Thu, 14 Aug 2025 21:18:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/i386: document TDG.VP.VMCALL<GetQuote> and TD
 attestation
To: Mikko Ylinen <mikko.ylinen@linux.intel.com>, qemu-devel@nongnu.org
References: <20250814123144.136966-1-mikko.ylinen@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250814123144.136966-1-mikko.ylinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.94, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/14/2025 8:31 PM, Mikko Ylinen wrote:
> TD attestation has been supported since the handling of
> TDG.VP.VMCALL<GetQuote> was added. However, the documentation still
> states that TD attestation is future work.
> 
> Update TDX documention to match with the code and move the TD attestation
> section up to the feature configuration section. In addition, add a link
> to TDX Enabling Guide that gives further details on how to setup the
> platform for attestation to work.
> 
> Fixes: 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>")
> Reported-by: Benny Fuhry <benny.fuhry@intel.com>
> Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   docs/system/i386/tdx.rst | 40 ++++++++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/docs/system/i386/tdx.rst b/docs/system/i386/tdx.rst
> index 8131750b64..47d8fd023f 100644
> --- a/docs/system/i386/tdx.rst
> +++ b/docs/system/i386/tdx.rst
> @@ -97,6 +97,28 @@ if the fixed-1 feature is requested to be disabled explicitly. This is newly
>   added to QEMU for TDX because TDX has fixed-1 features that are forcibly enabled
>   by TDX module and VMM cannot disable them.
>   
> +TD attestation
> +~~~~~~~~~~~~~~
> +
> +In TD guest, the attestation process is used to verify the TDX guest
> +trustworthiness to other entities before provisioning secrets to the guest.
> +
> +TD attestation is initiated first by calling TDG.MR.REPORT inside TD to get the
> +REPORT. Then the REPORT data needs to be converted into a remotely verifiable
> +TD-Quote signed by a service hosting TD-Quoting Enclave operating on the host.
> +
> +The guest issues TDG.VP.VMCALL<GetQuote> which is forwarded to user space by KVM.
> +QEMU handles the request and sends the REPORT further to a Quote Generation Service
> +(QGS) for signing. On success, a TD-Quote is returned back to the guest.
> +
> +To enable TD attestation, QGS destination must be configured using a
> +"quote-generation-socket" property. Intel reference TDX QGS supports the
> +following socket addresses: `{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}`
> +or `{"type": "vsock", "cid":"2","port":"<portnum>"}`.
> +
> +See TDX Enabling Guide for details on how to provision the platform for
> +TD attestation to work.
> +
>   Launching a TD (TDX VM)
>   -----------------------
>   
> @@ -112,6 +134,9 @@ split kernel-irqchip, as below:
>           -machine ...,confidential-guest-support=tdx0 \\
>           -bios OVMF.fd \\
>   
> +Additional properties and their descriptions are documented in the QAPI
> +schema for the 'tdx-guest' object.
> +
>   Restrictions
>   ------------
>   
> @@ -135,19 +160,6 @@ SEAMCALLs and corresonponding QEMU change.
>   
>   It's targeted as future work.
>   
> -TD attestation
> ---------------
> -
> -In TD guest, the attestation process is used to verify the TDX guest
> -trustworthiness to other entities before provisioning secrets to the guest.
> -
> -TD attestation is initiated first by calling TDG.MR.REPORT inside TD to get the
> -REPORT. Then the REPORT data needs to be converted into a remotely verifiable
> -Quote by SGX Quoting Enclave (QE).
> -
> -It's a future work in QEMU to add support of TD attestation since it lacks
> -support in current KVM.
> -
>   Live Migration
>   --------------
>   
> @@ -158,4 +170,4 @@ References
>   
>   - `TDX Homepage <https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html>`__
>   
> -- `SGX QE <https://github.com/intel/SGXDataCenterAttestationPrimitives/tree/master/QuoteGeneration>`__
> +- `TDX Enabling Guide <https://cc-enabling.trustedservices.intel.com/intel-tdx-enabling-guide/01/introduction/>`__


