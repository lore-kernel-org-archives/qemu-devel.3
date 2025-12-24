Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6999E7545F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPiA-0008Iq-JX; Wed, 24 Dec 2025 09:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPhv-0008Gl-T4
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:19:19 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPht-0004bH-NW
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:19:19 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so1191033166b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766585956; x=1767190756; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybOOe1LcfPWqDeZBQ2PPCoQDUkV4EoWlk2OuKiJAlgA=;
 b=uvGK/3kB+4VrWyvscvV80NtyDTTmj7G1bhU0BiAhrSuNWZUYcTC9y+NtvAmj8usDSm
 DGJOpIbWE1usS4r0e/yL4TKHMQG0VRq8EEqw3Gfq2SeLDK6MrZSXr7YlzuJqNdAuvL8T
 XGd4dHhAd9tCphgJFMMfPyjU7IAYCA4UGBX98WDhU0hR/2VYz0aWiGZlUEwvMeH0/0ds
 P9qm96zrtXkFh7+Rj/Kx8TfsvLijhoBcwxRNJPOxy55r2sfIUAx0+SSIKfaxGgV9bnm6
 4hKmg4I83OyIhMqTwvvgswn2DnsBzqHy5efg7Fwh6AIWBe8H6qQPBhYB1aqlHTrO2tl5
 HHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766585956; x=1767190756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ybOOe1LcfPWqDeZBQ2PPCoQDUkV4EoWlk2OuKiJAlgA=;
 b=b2l2PzJJ/3ZESH0NCoTaW4Y0y9JY+FP4kn7w2C+OaxdqzoRMhLZNT9mOEI+y+gaTWd
 1dmV7abrYq1C++Uu13vRTMNcMlnboCp/FJaoUAvx8+KL48M//DBUbhfkRrU67WpSQF3g
 2v8w+ejVYF/cECEJ3Rt/IOhhQJ0vubWMmoApvrzeJd029o/J5W7gQGBiF0nRpMqsNBuy
 U7ULwRLsUjvhMl0Rs6nHlxHOctA1LJ9SW0qMM8SQNfpclVCiMC2agqVmz7G++ACCxbR5
 JzCgQ8g5mR+L/0vbFWDVfHj2AwrkEppYUlq4wrMPJvq10Fiva6WysFuJjhqkAqu6DyeP
 N2kA==
X-Gm-Message-State: AOJu0Yy2QfamKInSkhXIwIxTlYdvnO3HE1iVtqKpbPuTZftWpCBcdw6V
 Xp8ZS1izqcJmW8p3w4UY1fnpzeo6PtM3bD43Rn5ZtiDXlb5e1Q8q5bRadOPvgcr8PxFvvfI/oTz
 XnI66SfHbtQqIs983+nCtapP/i000D8BmFpgp/tsVAg==
X-Gm-Gg: AY/fxX5cknNzro7HEUe19w04pbX4gQSJH22bAWa8L29L2Vd8mF9nLVzRaiQAv1DmfAB
 BCrUFpiWNP5CCEwkk6k8Zts6djQGXN5zY2zpGXbPDZCKrwH310PON+MfSYiv3YQcCIj/EWtQVwW
 kLeLAdHEZ6DKiEGkAt0U7YHj9XdFXYWEHEQUW9QHhP6u9GAnwbyNOKURCFgtwkORYi8nLqn9chU
 uOs8tOUQ1sTaa1d08jNi77ivkhjUOTlEoJs5caqWQh5MurmEuz7GJEFIRlWpmu+29HDn7o=
X-Google-Smtp-Source: AGHT+IF/QcXL24YkCzO2u3Jg3lS59mOQcCo77PQSUHerOmB4xdmgpyuvQ1p8f0BXhy+zlguUpoxUbSZSRW0Wg2vWTEY=
X-Received: by 2002:a17:907:e109:b0:b80:3846:d46 with SMTP id
 a640c23a62f3a-b80384610eamr1482570666b.20.1766585955801; Wed, 24 Dec 2025
 06:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-3-philmd@linaro.org>
In-Reply-To: <20251224133949.85136-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 16:18:49 +0200
X-Gm-Features: AQt7F2oKUafNmH0DKe84bjwEmY84vhwm0gbeq2_YWS1POlkonDdrKhawVKqWOc8
Message-ID: <CAAjaMXYFYcPme=EAgoTYT0qzhDwdx2iHiPqSLXGJQV2V9O+asQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] monitor/hmp: Use plain uint64_t @addr argument in
 memory_dump()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, Dec 24, 2025 at 3:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> memory_dump() takes either hwaddr or vaddr type, depending
> on the @is_physical argument. Simply use uint64_t type which
> is common to both.
> Pad address using field width formatting, removing the need
> for the target_ulong type.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  monitor/hmp-cmds-target.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 2976f986d35..c00f75eab3c 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -122,12 +122,13 @@ void hmp_info_registers(Monitor *mon, const QDict *=
qdict)
>  }
>
>  static void memory_dump(Monitor *mon, int count, int format, int wsize,
> -                        hwaddr addr, int is_physical)
> +                        uint64_t addr, int is_physical)
>  {
>      int l, line_size, i, max_digits, len;
>      uint8_t buf[16];
>      uint64_t v;
>      CPUState *cs =3D mon_get_cpu(mon);
> +    const unsigned int addr_width =3D is_physical ? 8 : (target_long_bit=
s() * 2);
>
>      if (!cs && (format =3D=3D 'i' || !is_physical)) {
>          monitor_printf(mon, "Can not dump without CPU\n");
> @@ -165,11 +166,7 @@ static void memory_dump(Monitor *mon, int count, int=
 format, int wsize,
>      }
>
>      while (len > 0) {
> -        if (is_physical) {
> -            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
> -        } else {
> -            monitor_printf(mon, TARGET_FMT_lx ":", (target_ulong)addr);
> -        }
> +        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
>          l =3D len;
>          if (l > line_size)
>              l =3D line_size;
> --
> 2.52.0
>

