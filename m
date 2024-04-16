Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AA4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 16:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwlYK-0000nO-FY; Tue, 16 Apr 2024 12:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rwlYI-0000nF-V8
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:20:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rwlYG-0002g3-Bs
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713284456; x=1744820456;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dyF/XYekO/o8VEsr3ra3iXg8GX4AS25PMxHbmLR5Dl0=;
 b=iQqbGzh9KmgeDXpq9HtlgAlQu6fHApxLlIIkN+TDGKqRo9X7rYK2d4kv
 o1lo5z7jiMjhi843dox1S8q9DqKCMX/AEra6FF6bUTZzL+j3lUDtHRVjG
 vMzxoQjbfKL93tcUwkcM9OvRiqQevSmHMfN8H3lSABOVyW5aVuzaSs3ZM
 kge1oI3xs/KDu+j3JToRo1G6oFesdjkcQXS4FpffdoWyIv3bAU1nMct58
 dO/ziN9cxRUA2TZYHegHZ8jP+V31cD+0LdB+96YK7oQSaTmWZPM6g1d2q
 W+ws6CNa1wJJhch5aZHGed9BC+N78Ft/XYXckAZaqe8cX++mOql72rrI5 Q==;
X-CSE-ConnectionGUID: 0AICSEqHTqylIPSMWBA7bw==
X-CSE-MsgGUID: VUgOudN2QcuuKbm+87Qw/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="34123820"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; d="scan'208";a="34123820"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 09:20:53 -0700
X-CSE-ConnectionGUID: 6GCGrLzSScyQhM8Kn4S54g==
X-CSE-MsgGUID: ySvIzbeiSYua+qoit0oiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; d="scan'208";a="22377349"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 16 Apr 2024 09:20:52 -0700
Date: Wed, 17 Apr 2024 00:34:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Dave Hello <hsu@peterdavehello.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <Zh6osLjy89W+Xhvj@intel.com>
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Tue, Apr 16, 2024 at 11:31:24AM +0000, Peter Dave Hello wrote:
> Date: Tue, 16 Apr 2024 11:31:24 +0000
> From: Peter Dave Hello <hsu@peterdavehello.org>
> Subject: [PATCH] Add zh_TW Traditional Chinese translation
> 
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
>  po/zh_TW.po | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
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
> index 0000000..d25557e
> --- /dev/null
> +++ b/po/zh_TW.po
> @@ -0,0 +1,93 @@
> +# Chinese translations for PACKAGE package.
> +# Copyright (C) 2024 THE PACKAGE'S COPYRIGHT HOLDER
> +# This file is distributed under the same license as the PACKAGE package.
> +# Peter Hsu <hsu@peterdavehello.org>, 2024.
> +#
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: PACKAGE VERSION\n"

"Project-Id-Version: QEMU 9.1 \n"

(Now the target version should be v9.1.)

> +"Report-Msgid-Bugs-To: \n"

"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"

> +"POT-Creation-Date: 2024-04-16 17:52+0800\n"
> +"PO-Revision-Date: 2024-04-16 17:52+0800\n"
> +"Last-Translator: Peter Hsu <hsu@peterdavehello.org>\n"
> +"Language-Team: Chinese (traditional)\n"
> +"Language: zh_TW\n"
> +"MIME-Version: 1.0\n"
> +"Content-Type: text/plain; charset=ASCII\n"
> +"Content-Transfer-Encoding: 8bit\n"
> +
> +#: ui/gtk.c:231

Referring to the support of other languages, the comment here can be
deleted. The lineno related comments in the following text can be
similarly deleted.

Regards,
Zhao


