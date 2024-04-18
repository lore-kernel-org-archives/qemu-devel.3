Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7844EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 02:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxHC9-0004vy-B8; Wed, 17 Apr 2024 22:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rxHC7-0004vl-NT
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 22:08:11 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rxHC5-0008Oz-Ef
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 22:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713406089; x=1744942089;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nPa7z7P+/kV+o3o1F2EpfWOBiZZBN4sSPisnsk9f8cM=;
 b=Ex2YG4M1wOgfgnrCUZ7LdMQA+RE0IEUF+b/XYJ7lR+izQp0zd7LyHEME
 TZeYCdTKoFfqK4llxwBzXpNY1eBz3D4SozKIk4HCpydyQs4ryq/cb5J0q
 3b4kMfwOlhxptFasj2MuDldFJrARR56dI9qY5WgCXzqVLEyhNI1tO3/Nm
 vC29lwyITkI5Ra/yQQoJYu/rFoqYjEfLlemlNYv21D1PsfReB8MBMPvxi
 AKWHEzPS/W/TIpyOOKsN9ExOJs7npu7M/3YAy3y/58bejj0oJxHYH3lqx
 /Sk8Ve62/Z3tSAcI9/GXAAi2sV3V1JvR1WMoCP03nwGiOkTIVy1EqZuVU w==;
X-CSE-ConnectionGUID: kOTlI5tNSGejtLTnfJYHdA==
X-CSE-MsgGUID: WaraJnD1RweITlZRzGFjhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9479383"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="9479383"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 19:08:04 -0700
X-CSE-ConnectionGUID: B5T2YtylTX6j7DiYgdAXvg==
X-CSE-MsgGUID: QanWG84pSzGpOF4sszSrfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; d="scan'208";a="53755946"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 17 Apr 2024 19:08:03 -0700
Date: Thu, 18 Apr 2024 10:22:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Dave Hello <hsu@peterdavehello.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <ZiCDzzFDRmQGPtDD@intel.com>
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
 <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
 <Zh6qLCvyiSk6YkVy@intel.com> <Zh6oIH8Ihyn-9RwT@redhat.com>
 <pTgk5-fHZzZe_qQn7RdevQ7Dg9Yz_-I4jWPpYknkgbiStJvLCRlTj9EpfRY_K9GCqdSABB_s_xzuGBCxxRqDfzDIoO6AVcvP-onYk8yRiWI=@peterdavehello.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pTgk5-fHZzZe_qQn7RdevQ7Dg9Yz_-I4jWPpYknkgbiStJvLCRlTj9EpfRY_K9GCqdSABB_s_xzuGBCxxRqDfzDIoO6AVcvP-onYk8yRiWI=@peterdavehello.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Perter HSU,

On Wed, Apr 17, 2024 at 01:07:17PM +0000, Peter Dave Hello wrote:
> Date: Wed, 17 Apr 2024 13:07:17 +0000
> From: Peter Dave Hello <hsu@peterdavehello.org>
> Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
> 
> Hi all,
> 
> Thank you all for the feedback. I've updated the patch to address most of the suggestions, but only the copyright part. I'm not sure how to deal with it. BTW, should I directly paste the revised patch below? Sorry that I'm not familiar with the process here. Thanks for your help again.

New patch should be sent separately to avoid replying directly to
previous mail thread. And the tag of the SUBJECT for your v2 patch needs
to be changed to "[PATCH v2]".

> From: Peter Dave Hello <hsu@peterdavehello.org>
> Date: Tue, 16 Apr 2024 00:43:29 +0800
> Subject: [PATCH] Add a simple zh_TW Traditional Chinese translation
> 
> This patch adds a basic zh_TW translation file for Taiwan Traditional
> Chinese users.
> 
> Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
> ---
>  po/LINGUAS  |  1 +
>  po/zh_TW.po | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 po/zh_TW.po
> 
> diff --git a/po/LINGUAS b/po/LINGUAS
> index 9b33a36..08163e8 100644
> --- a/po/LINGUAS
> +++ b/po/LINGUAS
> @@ -7,3 +7,4 @@ sv
>  tr
>  uk
>  zh_CN
> +zh_TW
> diff --git a/po/zh_TW.po b/po/zh_TW.po
> new file mode 100644
> index 0000000..e6d2c07
> --- /dev/null
> +++ b/po/zh_TW.po
> @@ -0,0 +1,74 @@
> +# Chinese translations for QEMU package.
> +# Copyright (C) 2024 THE QEMU'S COPYRIGHT HOLDER

Refer to this file /po/bg.po or any other source code of QEMU, copyright
belongs to you or your company.

> +# This file is distributed under the same license as the QEMU package.

You can declare the license by:
"SPDX-License-Identifier: GPL-2.0-or-later".

And put this license under the author line.

> +# Peter Dave Hello <hsu@peterdavehello.org>, 2024.
> +#

Others look good to me. Pls go ahead and respin your v2.

Thanks,
Zhao


