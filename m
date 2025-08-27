Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3124CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur59d-0002NE-J8; Tue, 26 Aug 2025 21:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ur59Z-0002Ll-Py
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:40:46 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ur59U-0004qM-9q
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756258841; x=1787794841;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KpR5gkIFOCj/rHMUN+O1XVUbkEGDV/18p9NzCnv+RpA=;
 b=K9/Ibnl4eVRYL6ql6et9J0hnRY0oMkxV7o42pjKns2P5fNuyBrtnu6z9
 QnEgxJo2fgUeFtP+s2+jjooTntEgdk/SCEC4lasLs9cjZlvDuoKqvnMRW
 Zc8JcTrE+ZCDaKzw0VPVvnsIAxKtZUt00NApZ2Mrt73uTL7nG1bnIMsm6
 rpbSQkvXXiE2qaa97r2Nr2Bx+7z2iBlV3NWdMnCIW49VCnyzbUXvBh1In
 E+jWOk46au9SvGvX6ldV50NHDEmiYOMz2zGbQ4l1+F/djvzlCmYC7w4bJ
 W9644zzHdrhpD7b03vR2USaP1cOklhTanHX9st8ThZ9ChkQhoRC0Ji4UA A==;
X-CSE-ConnectionGUID: GUDae4cvT0+xvugcjHzAdw==
X-CSE-MsgGUID: q3ywyUIpSe+fyfN0KCndiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="75959884"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="75959884"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 18:40:34 -0700
X-CSE-ConnectionGUID: lNikNvBYS+20QVqb8D4GCw==
X-CSE-MsgGUID: vWQADt3zRoyDY1fAiyvrYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="206887266"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 18:40:32 -0700
Message-ID: <4b53880f-cef2-421c-bdd2-5c963c316958@intel.com>
Date: Wed, 27 Aug 2025 09:40:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] QEMU 10.1.0 is now available
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <175625036608.469964.4138433906168641553@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <175625036608.469964.4138433906168641553@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/27/2025 7:19 AM, Michael Roth wrote:
>   * x86: Support for initializing confidential TDX or SEV-SNP virtual
>     machines using the IGVM file format

Can IGVM really work for TDX?

