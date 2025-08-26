Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC3ACA0FED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 19:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqzG1-0003Sm-Gw; Tue, 26 Aug 2025 15:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqzFy-0003SD-D9
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 15:22:58 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqzFv-0005Ea-Ko
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 15:22:58 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61c51f57224so4462734a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756236171; x=1756840971; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSNsdVwOYlCRRAJazlWAu1iQQhxGDp52ngtWsg7Zhaw=;
 b=Unl3wx0Jca0319BgOBHD4n8AypTmmwCJ8r+HOxOUIfh6bieATcqlsOjmdCPYA5UUnk
 Dljw2fWDQJqOzlqf99sK75k66/zOa6zXr8EFVnw59vervPCy0nNFVVWHfP+oPWIoD3iY
 pBDqW0E1XlLZ6vyXgXRYOONgwy/ZlF2Q6EL16CX8mO2oxuNKVURrs19TRAamGQnxzQlk
 gON+9R1Cuk8fMWrhLXdJ8iDN6jlp8NT2M4L+PIf/K0AYbQjnId6gL4BnyS4UeHP1SIa3
 1jpT5H41V9Yo4s+1buprIQWOvUQMloqr2sonNCGBX8bWnl9dNEJncm70KBGZ9MZHflKh
 YLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756236171; x=1756840971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PSNsdVwOYlCRRAJazlWAu1iQQhxGDp52ngtWsg7Zhaw=;
 b=sDplglKE/O429qXcv877rIpuBXS436RZn/cMIja5z64uDfMjFrl+UEchwbBPC+xUdg
 +SWf8VaTYf3cqPcoORKcBP8v07kd+tDsEU0+VjjORb24s7lMze0kPGP5T75AJ+/zGGbu
 hRgIYnJs9vXXBbAjN6Nk2ZiLyqSpuCmd+83WL1FXmiPSbZf7tD8mttdltbjCYS6yVf1z
 7otiatgYG5MWUae0dGh8aP05ruddrXYHcFkweiekDCnBZyf7z+fM7CCsmao5b8jf7oXA
 kRLbNjCpYVfnEokUJow/4rtkVajvUYwIAUR1m0VinZ39eNOrrzN+3pWv9n7ffiE6HGKk
 jXUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDXGErGv82UlVZWmar9z+jNYrBBTiFY5nAswJKdIb9i+R6mHzJCRZ6usnMH5u7LzZKm/Mxxs97tS0N@nongnu.org
X-Gm-Message-State: AOJu0YxdJ7dViURvfB81kCFpf7qvjNJLG7uyVonoLvaFxT8bmsHzmhrf
 s/obtu5VSynBNiqD2YU+MfA5EZVCNYY0izHzhxUF2oT26CABbdINVK3UHI/tu/Xa/XOQ8boZyFH
 2PqETmTn8yGDonNsL+qKS6I4U9mVv+m4hxEry/L7jfw==
X-Gm-Gg: ASbGncu3RVdMVPjyPdcO3SGrVG3w6yJD9wOKGylsLKOe/bGMqACydh+jkkKEcW+CbCx
 Ke44EEOYP/g4coMNzKIrWyNsqLUZzAi0Kj9KDvqC/PZg3rlO2vV2aMQUMzIjuqOvnIGla3fQM6B
 HfckSmlsg53rc0eAqCM7xPiJlWuKdszTh2TrmVJVHIDMe+2W9mu90+t/0zzw+beWGweuy8YegjS
 7IM8djM
X-Google-Smtp-Source: AGHT+IEHzo6LSFG8VjwCSuuWSEPuTypcml246vK+1Zh8bas5XpE9pdbW4e1EXZ6/ABWhN2d44T7Bl5gHfGTFx1RsM0w=
X-Received: by 2002:a05:6402:46cf:b0:618:229d:707b with SMTP id
 4fb4d7f45d1cf-61c1b45c5a8mr12435269a12.1.1756236170784; Tue, 26 Aug 2025
 12:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250826174956.3010274-1-peter.maydell@linaro.org>
 <20250826174956.3010274-3-peter.maydell@linaro.org>
In-Reply-To: <20250826174956.3010274-3-peter.maydell@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 26 Aug 2025 22:22:24 +0300
X-Gm-Features: Ac12FXxdbK3YCyRjt7SA53pKzPP2qqYuUX_MUrDXhsaGHwuaqORFM7w15zfvVyA
Message-ID: <CAAjaMXadqVFcd13iSx8BBEh29VzginDj5kbVm1CvCkfzwHDs+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/display/xlnx_dp: Don't leak dpcd and edid objects
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 26, 2025 at 8:51=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> In the xnlx_dp_init() function we create the s->dpcd and
> s->edid objects with qdev_new(); then in xlnx_dp_realize()
> we realize the dpcd with qdev_realize() and the edid with
> qdev_realize_and_unref().
>
> This is inconsistent, and both ways result in a memory
> leak for the instance_init -> deinit lifecycle tested
> by device-introspect-test:
>
> Indirect leak of 1968 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qe=
mu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
> 3fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0=
+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-f=
rom-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
>     #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop=
/qemu/build/arm-asan/../../qom/object.c:789:12
>     #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/q=
emu/build/arm-asan/../../hw/core/qdev.c:149:19
>     #5 0x5aded54458be in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-lapt=
op/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1272:20
>
> Direct leak of 344 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qe=
mu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904b=
a5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0=
+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-f=
rom-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
>     #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop=
/qemu/build/arm-asan/../../qom/object.c:789:12
>     #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/q=
emu/build/arm-asan/../../hw/core/qdev.c:149:19
>     #5 0x5aded5445a56 in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-lapt=
op/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1275:22
>
> Instead, explicitly object_unref() after we have added the objects as
> child properties of the device.  This means they will automatically
> be freed when this device is deinited.  When we do this,
> qdev_realize() is the correct way to realize them in
> xlnx_dp_realize().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/display/xlnx_dp.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 7c980ee6423..ef73e1815fc 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1267,14 +1267,18 @@ static void xlnx_dp_init(Object *obj)
>      s->aux_bus =3D aux_bus_init(DEVICE(obj), "aux");
>
>      /*
> -     * Initialize DPCD and EDID..
> +     * Initialize DPCD and EDID. Once we have added the objects as
> +     * child properties of this device, we can drop the reference we
> +     * hold to them, leaving the child-property as the only reference.
>       */
>      s->dpcd =3D DPCD(qdev_new("dpcd"));
>      object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
> +    object_unref(s->dpcd);
>
>      s->edid =3D I2CDDC(qdev_new("i2c-ddc"));
>      i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
>      object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
> +    object_unref(s->edid);
>
>      fifo8_create(&s->rx_fifo, 16);
>      fifo8_create(&s->tx_fifo, 16);
> @@ -1311,8 +1315,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error=
 **errp)
>      qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
>
> -    qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_b=
us)),
> -                           &error_fatal);
> +    qdev_realize(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
> +                 &error_fatal);
>
>      s->console =3D graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>      surface =3D qemu_console_surface(s->console);
> --

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> 2.43.0
>
>

