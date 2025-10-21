Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8456ACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBARw-000862-AK; Tue, 21 Oct 2025 07:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBARu-00085J-6J
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:22:42 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBARr-0006m2-8h
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:22:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B5735972E4;
 Tue, 21 Oct 2025 13:22:33 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rtbSanHmmbYZ; Tue, 21 Oct 2025 13:22:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2BE135972E1; Tue, 21 Oct 2025 13:22:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2A1FA5972DE;
 Tue, 21 Oct 2025 13:22:31 +0200 (CEST)
Date: Tue, 21 Oct 2025 13:22:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 08/43] qdev: add qdev_find_default_bus()
In-Reply-To: <20251021090317.425409-9-marcandre.lureau@redhat.com>
Message-ID: <292dc18a-9386-3887-bc9c-186a8fb70f59@eik.bme.hu>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1740677293-1761045751=:49605"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1740677293-1761045751=:49605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 21 Oct 2025, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> This helper is used next by -audio code.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> include/monitor/qdev.h |  3 +++
> system/qdev-monitor.c  | 21 +++++++++++++++++----
> 2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> index 1d57bf6577..de33637869 100644
> --- a/include/monitor/qdev.h
> +++ b/include/monitor/qdev.h
> @@ -1,6 +1,8 @@
> #ifndef MONITOR_QDEV_H
> #define MONITOR_QDEV_H
>
> +#include "hw/qdev-core.h"
> +
> /*** monitor commands ***/
>
> void hmp_info_qtree(Monitor *mon, const QDict *qdict);
> @@ -11,6 +13,7 @@ int qdev_device_help(QemuOpts *opts);
> DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
> DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>                                         bool from_json, Error **errp);
> +BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp);
>
> /**
>  * qdev_set_id: parent the device and set its id if provided.
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 2ac92d0a07..4b732f579a 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -621,6 +621,21 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
>     return prop->name;
> }
>
> +BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp)
> +{
> +    BusState *bus = NULL;
> +
> +    assert(dc->bus_type != NULL);
> +    bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);
> +    if (!bus || qbus_is_full(bus)) {
> +        error_setg(errp, "No '%s' bus found for device '%s'",
> +                   dc->bus_type, object_class_get_name(OBJECT_CLASS(dc)));
> +        return NULL;

Should it differrentiate between no bus and a bus that exists but full and 
return different error to help debugging?

Regards,
BALATON Zoltan

> +    }
> +
> +    return bus;
> +}
> +
> DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>                                         bool from_json, Error **errp)
> {
> @@ -657,10 +672,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>             return NULL;
>         }
>     } else if (dc->bus_type != NULL) {
> -        bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);
> -        if (!bus || qbus_is_full(bus)) {
> -            error_setg(errp, "No '%s' bus found for device '%s'",
> -                       dc->bus_type, driver);
> +        bus = qdev_find_default_bus(dc, errp);
> +        if (!bus) {
>             return NULL;
>         }
>     }
>
--3866299591-1740677293-1761045751=:49605--

