Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50957C54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebk8-0006vD-41; Mon, 26 Feb 2024 09:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebjt-0006gg-V3
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:13:55 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebjr-0002Pq-L0
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708956831; x=1740492831;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uiIBa4NE10MCDcFb1wCFmJuVpzEfYoLwaY2GrJ7E7O4=;
 b=eKFJFHISP6gYcwFDOhUAlZ8IZVUIa2Usn8S0b/xHYqbzP7U5D/odKato
 rA+UaKU4gQF+5knywPm/ccOWeSgnSE9Mq0pfaUrs570U0Ovkg7ahawgkp
 /2u/4TGXxeBCsZoDZ8DtfY2CemNlr2IOMAC3U0zFQPqlL1Lb1SH7AYUv0
 u+6cKLC+Wzs8I3Huq9rWFyr3ajjzeX1xY8fMWRMXBQi/+X6JP0QqEP2rS
 oamYytQ+Cgn5yfAeveA0rtEr/TEIrDtrC6k5Oz9GwcnaNvnieoo00eSz9
 DO9Z57OwuAwFOAhrzHItg6yQScVpDzKIxbJxKCAwOOYct92kMEv5dkGzl w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13884842"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="13884842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 06:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6708041"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 26 Feb 2024 06:13:45 -0800
Date: Mon, 26 Feb 2024 22:27:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 05/10] hw/core: Add documentation and license comments to
 reset.h
Message-ID: <Zdyfz8kc9/iumCAA@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-6-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-6-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter,

On Tue, Feb 20, 2024 at 04:06:17PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:17 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 05/10] hw/core: Add documentation and license comments to
>  reset.h
> X-Mailer: git-send-email 2.34.1
> 
> Add the usual boilerplate license/copyright comment to reset.h (using
> the text from reset.c), and document the existing functions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/sysemu/reset.h | 79 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
> index 609e4d50c26..6aa11846a69 100644
> --- a/include/sysemu/reset.h
> +++ b/include/sysemu/reset.h
> @@ -1,3 +1,29 @@
> +/*
> + *  Reset handlers.
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2016 Red Hat, Inc.
> + * Copyright (c) 2024 Linaro, Ltd.

An additional question, when there is a new (notable) contribution to a
file, then it's time to add the company's copyright. Right?

> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
>  #ifndef QEMU_SYSEMU_RESET_H
>  #define QEMU_SYSEMU_RESET_H
>  
> @@ -5,9 +31,62 @@
>  
>  typedef void QEMUResetHandler(void *opaque);
>  
> +/**
> + * qemu_register_reset: Register a callback for system reset
> + * @func: function to call
> + * @opaque: opaque data to pass to @func
> + *
> + * Register @func on the list of functions which are called when the
> + * entire system is reset. The functions are called in the order in
> + * which they are registered.
> + *
> + * In general this function should not be used in new code where possible;
> + * for instance device model reset is better accomplished using the

s/for instance device/for instance, device/

> + * methods on DeviceState.
> + *
> + * It is not permitted to register or unregister reset functions from
> + * within the @func callback.
> + *
> + * We assume that the caller holds the BQL.

HMM, what does BQL stand for?

Others LGTM.
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


