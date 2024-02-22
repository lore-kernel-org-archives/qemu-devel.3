Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C169C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5Ue-0006et-AM; Thu, 22 Feb 2024 04:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5Ud-0006dt-4j; Thu, 22 Feb 2024 04:35:51 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5UW-0004GX-A1; Thu, 22 Feb 2024 04:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708594544; x=1740130544;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0I3Grk97EFZAZEOpOvJ/R2MlrW4jSdK7oEzs5F+q1o0=;
 b=L0tg3FcWyvTcMurpK6RetT5NxOg7xpAoo7Ej3avmOkpMXVAYHz+lzKlL
 5/AwZAc6orDFYee0Zf1CTdj2cCNpkmTYVpf6TDoT6VF4HvC6FnV+TPfQy
 cfMONr01Phi6QLI5bDvlzUFw05c0n146h94MKaNnwfZoiuyykHRqJs9TW
 bR1xsM3HBTEPTKA1LdErFAzt1dtNvw7GBAux8Pti7gsSZryEPdXNmr8Pu
 A3W1Um791kh6lhAH8UfX8yvtWERvCmgikXrxJY0kP9NWillOiUVTuk2HV
 8L40eKTk3YNgR1MhmZcFjXOfpYXBtsb8Fj+14f+C3tKwcezgpfweaAxJK A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6622893"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="6622893"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 01:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5747800"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 22 Feb 2024 01:35:34 -0800
Date: Thu, 22 Feb 2024 17:49:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 11/21] hw/usb: Add QOM parentship relation with hub devices
Message-ID: <ZdcYmhG3zcad3RLC@intel.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216110313.17039-12-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

Hi Philippe,

On Fri, Feb 16, 2024 at 12:03:02PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 16 Feb 2024 12:03:02 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 11/21] hw/usb: Add QOM parentship relation with hub devices
> X-Mailer: git-send-email 2.41.0
> 
> QDev objects created with qdev_*new() need to manually add
> their parent relationship with object_property_add_child().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/usb/bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index a599e2552b..baad04f466 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -439,6 +439,7 @@ void usb_claim_port(USBDevice *dev, Error **errp)
>              /* Create a new hub and chain it on */
>              hub = USB_DEVICE(qdev_try_new("usb-hub"));

One additional question comes to mind, should we use the qdev_new()
here?

The difference between qdev_try_new() and qdev_new() is the latter
uses assert() to ensure the passed type exists.

So if we know that type parameter is correct, we should just use
qdev_new().

Only when the caller is not sure whether the type is valid,
qdev_try_new() should be preferred.

Am I understand correctly? ;-)

>              if (hub) {
> +                object_property_add_child(OBJECT(dev), "hub", OBJECT(hub));

From the comment above the code:

/* Create a new hub and chain it on */

this only creates a new usb-hub, should the new usb-hub become the child
object of the original usb-hub?

>                  usb_realize_and_unref(hub, bus, NULL);
>              }
>          }
> -- 
> 2.41.0
> 
> 

