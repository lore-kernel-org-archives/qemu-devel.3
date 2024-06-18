Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F5CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 14:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJZcL-0008Dk-9O; Tue, 18 Jun 2024 10:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJZcJ-0008DE-Kf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:15:23 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJZcH-0005Fh-4s
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:15:23 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6f9fe791f8so44911366b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718720117; x=1719324917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R2LNaLe3vacQ58nGStk3t20IhDtC/JxGHkVRUMmCapE=;
 b=c/zSdrSRJ7nLfWMm8Mj2J07GFp2Xeh4aS/xxm79tzgb9czE2W52RW8kRRFZ4kEwD2M
 0vw8EIS7wr1xvP954Az7NG4HCwHrAFWtr05+JDIsv8mbXIM4g27WrTxbclL0OGiK/wxp
 u2Yjqu6S+EJeVt0Ozo8wkL/8GrGl27Q+XLJl1pTIjSm5NN9kRYjwx4jc9v0sfeFP75uj
 DUSjyoRf8jXBfbeDjw0Nz3DlhCGXlEXMUPjsHhumE1mH1f8Itd2D9KsPAAgdMgIwTGJq
 ZKXfjBZGaDbTXcFjJL7nDcnvi4HzsHJ+To7dDMvL2LtlHaaPhUKniS4917UHS/+lcJ7+
 /ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720117; x=1719324917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R2LNaLe3vacQ58nGStk3t20IhDtC/JxGHkVRUMmCapE=;
 b=IFpJfk8tdeXKD+EuigV8pNdS8wwIuOkkm6AtynhDaDiJJvZANduRH246cJWd2Cw3Mx
 ykKUqprkRQZ60qLw9HzqLsTWHxR/RZHVs2bbCUHDI/YOjmKnTrWki82r7BYnjOjZAwmn
 6Im4XUOdvkJweddIMJyC2KF/7WKsX5BjSJUhX5B3VtEe1WLg8LzXz1JdCw2kd7lh0puU
 4gGH5Pyaa6BTYdth3/Q05la3L8Q58E2sFfGDUGZ7VltmItqwnwHLyPWYeAY8ijNaiN+w
 20PhDEofVly0Bt7Ko07zWc8nYjxsmBwHE4xiFeydz6kDQEN5HCESy9ONs0730IXryS9s
 io/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTRJgJ1nynKHuhN/tJk4BqP7Asm8yl6TD7DCq2/WLp/xGF9zhDnPe5vk9Rr1gE89n05Wm9owZNRZNnb/l/ceIEcBCVf4I=
X-Gm-Message-State: AOJu0YzsoqBLw5NtisMlP6LTfUdj5NPFpScAGZQbLrhCspmahb0m9Xi5
 71nU1kscEyN/mEIcti+Ilp1DdC1ttuIBnVTZwTagQuhCthBxioX3CtXsiwKX/T0=
X-Google-Smtp-Source: AGHT+IEXjpIl+n8prhx1E8ljlmUaFv6VX4QAUU/+C0XSbg2PzyG7qKSyQ+2EuMJysJ0S9dIGZzspyQ==
X-Received: by 2002:a17:906:36ce:b0:a6f:7707:b846 with SMTP id
 a640c23a62f3a-a6f94e1f8f6mr172320066b.15.1718720117487; 
 Tue, 18 Jun 2024 07:15:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa4150sm627321766b.212.2024.06.18.07.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 07:15:17 -0700 (PDT)
Message-ID: <7c8cf4f0-c717-47dd-8390-41c7fd7d0a0b@linaro.org>
Date: Tue, 18 Jun 2024 16:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/usb: Introduce x-query-usbhost QMP command
To: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240611102305.60735-1-philmd@linaro.org>
 <20240611102305.60735-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240611102305.60735-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/6/24 12:23, Philippe Mathieu-Daudé wrote:
> This is a counterpart to the HMP "info usbhost" command. It is being
> added with an "x-" prefix because this QMP command is intended as an
> adhoc debugging tool and will thus not be modelled in QAPI as fully
> structured data, nor will it have long term guaranteed stability.
> The existing HMP command is rewritten to call the QMP command.
> 
> Since host-libusb.c can be built as part of the 'hw-usb' module,
> we introduce the libusb_register_hmp_info_hrt() helper to allow late
> registration when the module is loaded.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qapi/machine.json           | 18 ++++++++++++++++
>   hw/usb/host-libusb.h        | 16 ++++++++++++++
>   include/hw/usb.h            |  3 ---
>   hw/usb/bus-stub.c           |  7 +++++-
>   hw/usb/host-libusb-common.c | 31 ++++++++++++++++++++++++++
>   hw/usb/host-libusb.c        | 43 +++++++++++++++++++++++++------------
>   tests/qtest/qmp-cmd-test.c  |  3 +++
>   hmp-commands-info.hx        |  2 ++
>   hw/usb/meson.build          |  1 +
>   9 files changed, 106 insertions(+), 18 deletions(-)
>   create mode 100644 hw/usb/host-libusb.h
>   create mode 100644 hw/usb/host-libusb-common.c


> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index d46d96779a..c0b34af518 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -465,9 +465,6 @@ void usb_device_reset(USBDevice *dev);
>   void usb_wakeup(USBEndpoint *ep, unsigned int stream);
>   void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p);
>   
> -/* usb-linux.c */
> -void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
> -
>   /* usb ports of the VM */
>   
>   #define VM_USB_HUB_SIZE 8
> diff --git a/hw/usb/bus-stub.c b/hw/usb/bus-stub.c
> index fcabe8429e..948429bb33 100644
> --- a/hw/usb/bus-stub.c
> +++ b/hw/usb/bus-stub.c
> @@ -11,7 +11,6 @@
>   #include "qapi/error.h"
>   #include "qapi/qapi-commands-machine.h"
>   #include "sysemu/sysemu.h"
> -#include "monitor/monitor.h"
>   #include "hw/usb.h"
>   
>   USBDevice *usbdevice_create(const char *driver)
> @@ -26,3 +25,9 @@ HumanReadableText *qmp_x_query_usb(Error **errp)
>       error_setg(errp, "Support for USB devices not built-in");
>       return NULL;
>   }
> +
> +HumanReadableText *qmp_x_query_usbhost(Error **errp)
> +{
> +    error_setg(errp, "Support for USB devices not built-in");
> +    return NULL;
> +}
> diff --git a/hw/usb/host-libusb-common.c b/hw/usb/host-libusb-common.c
> new file mode 100644
> index 0000000000..406a2b25be
> --- /dev/null
> +++ b/hw/usb/host-libusb-common.c
> @@ -0,0 +1,31 @@
> +/*
> + * QEMU USB host redirector helpers
> + *
> + * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
> + * SPDX-FileCopyrightText: 2024 Linaro Ltd.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-machine.h"
> +#include "monitor/monitor.h"
> +#include "host-libusb.h"
> +
> +static HumanReadableText *(*qmp_x_query_usbhost_handler)(Error **errp);
> +
> +void libusb_register_hmp_info_hrt(HumanReadableText *(*handler)(Error **errp))
> +{
> +    qmp_x_query_usbhost_handler = handler;
> +    monitor_register_hmp_info_hrt("usbhost", handler);
> +}
> +
> +HumanReadableText *qmp_x_query_usbhost(Error **errp)
> +{
> +    if (module_load("hw-usb-", "host", errp) <= 0) {
> +        return NULL;
> +    }
> +    assert(qmp_x_query_usbhost_handler);
> +    return qmp_x_query_usbhost_handler(errp);
> +}



> diff --git a/hw/usb/meson.build b/hw/usb/meson.build
> index d7de1003e3..af92b504fd 100644
> --- a/hw/usb/meson.build
> +++ b/hw/usb/meson.build
> @@ -7,6 +7,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
>     'core.c',
>     'desc.c',
>     'desc-msos.c',
> +  'host-libusb-common.c',
>     'libhw.c',
>     'pcap.c',
>   ), if_false: files('bus-stub.c'))

Since this files depends on libusb, squashing:

-- >8 --
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index af92b504fd..89b197fbd8 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -9,3 +9,2 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
    'desc-msos.c',
-  'host-libusb-common.c',
    'libhw.c',
@@ -86,2 +85,3 @@ endif
  if libusb.found()
+  system_ss.add(when: 'CONFIG_USB', if_true: files('host-libusb-common.c'))
    usbhost_ss = ss.source_set()
---

