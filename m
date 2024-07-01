Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A68C30659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGO7-0002OK-S1; Mon, 01 Jul 2024 08:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOGO0-0002NW-B5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:44:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOGNy-0002OV-Ab
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:44:00 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a725041ad74so118343466b.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719837836; x=1720442636; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rnUxW0JWidalX8YOh7GVsIVx9nc6EBrMkotCaTb32wg=;
 b=MvBUCk8eGSfhfJV0C+kFhvK6TDAPUpfxCK+vjSN29DI5OU2wE9s4nR3jDkPLgPlqjz
 hoAKGL3OEc9N51y1BaO09Idbt6fcQwJKLb/STqx2YIJ+5x7qw1YBsbkzDSFlEZYGmxPw
 44qAd7/tFts1nUlDhWzgy2qhLSJTtjo4Av+jAz25Q6lUEb4WG8mKzMIDyn86nLf2gOVQ
 PxndaSVhTT8XAW0LXQntArAKuUxyAptf8qyav9+HBn47yT6VRWRpy5GcvOr9L/3kT7zH
 QHy/uAZ9NvbPIreml1Jo2meCn/6p0Ir2ick9gK+8qtTjJclcDa0+xhBZh7f8QiGyzJbC
 pgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719837836; x=1720442636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnUxW0JWidalX8YOh7GVsIVx9nc6EBrMkotCaTb32wg=;
 b=b7H3p1grL1pSgbjNwK/Th6Xv9GYLDPsCRIj0acP6jm6GNGkz/TbIssPG9PhgsV94FH
 9IiX36hlv+EPnLm6ovoMZQuwNTu8R0vE2lZewkETDAfeYJbtb20RJWDyoh3xOJfvoUV9
 wZghC84PWk+RbCzQjimGDWmZm+r/EqdOJlWYEdm7uEhPMt9Y+EdKs38Y6dF8nWfAzl+L
 ITe9U19XvJ+iChHK2CJzSvxt6EWzrDiwls5X6Zu0POL3ANMyu+7F7HONykWvxXS+1Y44
 4EgDEbY1iq/UDzhIjqCTQxIygVvnAHSwgYo9m2Jh+A8k+X4ZLWpav8n6R1t2GdWIhcgr
 YX/w==
X-Gm-Message-State: AOJu0YwdCaK/ZdXCspfsAewQ8VWbA/uDtFhEVgndtA2bKXlFBt3tKvod
 pdO0IElRMCmL/Ovs0cM30b4I0nHmAimswbusdFQaAqcsrwikFMU23d9MAr6+nmfH4aawEG7rqso
 t2Cr0v670PMYrhvMgggmAjlX/4BV7ib1ZBvEnVw==
X-Google-Smtp-Source: AGHT+IFrNLHOZLg98hmTEz42baNE/gWievm0tJGENB9WVNiL4eieqTd91MCRE/hGT+vmVWqE5Vst59KDzjU3RFa222s=
X-Received: by 2002:a05:6402:50cc:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-5879ede2742mr5263554a12.5.1719837835753; Mon, 01 Jul 2024
 05:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240630163225.2973081-1-zheyuma97@gmail.com>
In-Reply-To: <20240630163225.2973081-1-zheyuma97@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 13:43:44 +0100
Message-ID: <CAFEAcA81ymhA+bGLpfT_jmZ+=D9t+h_wg7QgWkgSFR4EKRGPqg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb: Fix memory leak in musb_reset()
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun, 30 Jun 2024 at 17:33, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> The musb_reset function was causing a memory leak by not properly freeing
> the memory associated with USBPacket instances before reinitializing them.
> This commit addresses the memory leak by adding calls to usb_packet_cleanup
> for each USBPacket instance before reinitializing them with usb_packet_init.
>
> Asan log:
>
> =2970623==ERROR: LeakSanitizer: detected memory leaks
> Direct leak of 256 byte(s) in 16 object(s) allocated from:
>     #0 0x561e20629c3d in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
>     #1 0x7fee91885738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
>     #2 0x561e21b4d0e1 in usb_packet_init hw/usb/core.c:531:5
>     #3 0x561e21c5016b in musb_reset hw/usb/hcd-musb.c:372:9
>     #4 0x561e21c502a9 in musb_init hw/usb/hcd-musb.c:385:5
>     #5 0x561e21c893ef in tusb6010_realize hw/usb/tusb6010.c:827:15
>     #6 0x561e23443355 in device_set_realized hw/core/qdev.c:510:13
>     #7 0x561e2346ac1b in property_set_bool qom/object.c:2354:5
>     #8 0x561e23463895 in object_property_set qom/object.c:1463:5
>     #9 0x561e23477909 in object_property_set_qobject qom/qom-qobject.c:28:10
>     #10 0x561e234645ed in object_property_set_bool qom/object.c:1533:15
>     #11 0x561e2343c830 in qdev_realize hw/core/qdev.c:291:12
>     #12 0x561e2343c874 in qdev_realize_and_unref hw/core/qdev.c:298:11
>     #13 0x561e20ad5091 in sysbus_realize_and_unref hw/core/sysbus.c:261:12
>     #14 0x561e22553283 in n8x0_usb_setup hw/arm/nseries.c:800:5
>     #15 0x561e2254e99b in n8x0_init hw/arm/nseries.c:1356:5
>     #16 0x561e22561170 in n810_init hw/arm/nseries.c:1418:5
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/usb/hcd-musb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
> index 6dca373cb1..0300aeaec6 100644
> --- a/hw/usb/hcd-musb.c
> +++ b/hw/usb/hcd-musb.c
> @@ -368,6 +368,8 @@ void musb_reset(MUSBState *s)
>          s->ep[i].maxp[1] = 0x40;
>          s->ep[i].musb = s;
>          s->ep[i].epnum = i;
> +        usb_packet_cleanup(&s->ep[i].packey[0].p);
> +        usb_packet_cleanup(&s->ep[i].packey[1].p);
>          usb_packet_init(&s->ep[i].packey[0].p);
>          usb_packet_init(&s->ep[i].packey[1].p);
>      }

I don't think it's valid to call usb_packet_cleanup() on
a USBPacket that's never been inited, which is what will
happen on the first reset with this patch.

Looking at how hcd-ehci.c handles its s->ipacket (which has
the same "allocated at device creation and reused for the
whole lifetime of the device" semantics) I think what we
want is:
 * at device init, call usb_packet_init()
 * at device reset, do nothing
 * at device finalize, call usb_packet_cleanup()

(There is currently no hcd-musb function for finalize
because the only uses of it are for devices which continue
to exist for the whole lifetime of the simulation. So we
can ignore the last part of that.)

PS: the tusb6010 and hcd-musb are both used only by deprecated
board types which are scheduled to be deleted by the end
of the year (basically after we get the 9.1 release out,
and before 9.2). You might prefer to target your fuzzing
efforts to board types which aren't deprecated.

thanks
-- PMM

