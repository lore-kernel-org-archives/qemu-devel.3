Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F17606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f0PXIT/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpKO-00072v-Gm; Tue, 24 Nov 2026 07:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVpK7-0006xF-IS
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:08:35 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVpK4-0004jA-RF
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:08:35 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67da69e7c31so4602550d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:08:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795522111; cv=none;
 d=google.com; s=arc-20260327;
 b=HeOfMMpk/qLTvIaLq6vnyJlrChFTWlS5jhoDGtI0PjCwUYheXuLxkja1LFrEI8IBuI
 xQr7tfnZAn/JunZBg9I7I55WrfJBSM2dJSjAocC3KFywdApC80j6aqIHJA3/zsV3x27S
 cXkznKIQlqF3TPTfden64dmm+w/6pgMxcbWViEJ+T3VaH8xgohdFhthoMFj5Mafc5jeg
 qzpEvDWAbz10nS+J2Jcq60ptRR091qPZq0SbbwyXGAeocbPUXfuiACW90/R4miQZYhfm
 dMsgqioHZ7hBbBhxZ40IaKEx7KHxaSbrzDUO06VYtdco3AcrxM8f4NjpeX81T0U9B7kZ
 NGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jk27SiGItVv0FOji9yRZKQz3tyCrXpcdJqP0cfT75K8=;
 fh=kjIIHBxOc2+eheqJ3UOmUVeT86hj4XqWJtrPoTu5ZIs=;
 b=qdHIYv/4FtkOHiuKZKrs5Is9OIMPL/rT2tuABnV6g5XRFxGy4YXDYam3JdiXZyyEKn
 eBbBAJseAsdrenTkvxQC/1p56kSxg+i9hFFYKnEWn+Xl0UjT0mZjsInoLLkEt+vnGmt9
 1i6DMWJ0nYEs9SDOgAHnHzAuSl527X20ZAuiR0Z4OAi5oUQDsPLIg0ynBuVYR/bPizcc
 rGX6GZWFOi1pWKH4LW9aCzorIDQYCatgSlK4iGbDvyN14Ixd2cPQ6pgEYAO7imB6qLoF
 wgmgl2HUgjNM3ZQCzc0Uh6cnnmetFl8ygoG5R0izPwAxKpUblHzz3gpgMzA6U5eMZnlE
 6OJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795522111; x=1796126911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jk27SiGItVv0FOji9yRZKQz3tyCrXpcdJqP0cfT75K8=;
 b=f0PXIT/qDpirnDsbapwcJ2tyjVWy51nKFfxuik8GYIISbeMoc6sfHJBRr+2z1aHFDb
 MuaogriH09WSl73AtMZWWCG/BSXAqAZYxqaHdjUOoND6RZVV8o7jZ/QlDJw+Y2SVEfja
 V9KNLMqmFzVXXCzFxWN8VbyGljmtO+e9E3hDTLKdBDmqZgk+eN/3gqmb1LqG5wINx8Si
 BRehekCZY1TF7btWOnGsWL9Pr+UNxLUpvj9E4Nz+W4MVbeDh2hV8uQPvbtcLKCzAKg/X
 cTgbBC4OSABPxxGbg/dGUCyrGTEkvdQRL/ACnsuYVn4lVNkIapSuScLkK0u/mN6uZjCj
 vWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522111; x=1796126911;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jk27SiGItVv0FOji9yRZKQz3tyCrXpcdJqP0cfT75K8=;
 b=Vj+MzKzopwuUDEtZu4iYA+UP6q2wP0BkNnRaaFUY58ks6uabkbWAvbjhyGLuJwxcQH
 FK/Fvks8qzvuEKUhU4/FJZyxdbIljmGtN8AGB01Iv4ZR62GKinJySrTnWQlh7gy948pc
 g9CUeDxcD1t5lBKlE8TJOa0pQxijBKXf5xPp07u+Jf7Jo44FJW+fzSh7CGhFlCUe4P4j
 nNSITkjRy0GIZwTog7Os258z0OFNFGK257ubgZ7bJK/znjCLu0HEjgRILqW9X5LnNi3G
 csVZ/7YbYJjbiUC5qhdXRhU6dF8+4V6Wy9RCGWvvbUqiBKP0v4YTGRbcWwTPJlPrBb1B
 TmUA==
X-Gm-Message-State: APuU4Z9nvRQrAXBohl7JALo9AK6+opM4JOA738tXSLeAaZ3CsE0lPSi3
 By5QKg5/uxy/qvjqaPfxAkp7jRS/vs7PXJi6a2ZNXf7d6AFUCTpFdLkhtV9VSF+xKNuJuWqcdRD
 q3F8JfVi1XyT5RO9O4QzyeuXKMDchSEiv/WRM7MAtmA==
X-Gm-Gg: AZFdTZfs1uYERNzfaXlocyiamQxqqqueqePTWV6GbyAug9zohRSkb84LolTFa0KzERM
 Ud6P1OJ7dnwaEcHXHdJKTT33liBUJQu2r5Lbw12EaZlSnY4/B04yN4gOpmf8v/faRnGBjTxA0o3
 Ya2x+U8W1/vi9nKHWz22PhWexAMv6DryjJhWDw5fb53fnbOUZZi1HiRGI0sJGjJq2NslPVktzbs
 7NNjn/YMU4qUREUaTS9Ky2liUYCBRxVqHb10T7aI7VO214Sp6BWUTKJBm5Zm287Pi1Qxx+vAo74
 4tws7rpZPyWxD4nvnXxyXMhlU6B9k7Ak7/GLEbgOM0kVDh82s3I+eX76xJynVbONK/+PiTqsqIi
 MGOiX0kImeY8OT0Em5WX8p7s4gmCGN7qLK8D/Xm7cZ3Qt0f1+lJGpgIabbY61pRMu6/eGxsDt0i
 4zGXjRvGy4uUWXc0dXE8Etx6tnW7iuu2qGUhOKo+ej7Q==
X-Received: by 2002:a05:690c:b1b:b0:8b3:90db:a864 with SMTP id
 00721157ae682-8b520442e65mr73566627b3.11.1795522110706; Tue, 24 Nov 2026
 04:08:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-6-philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-6-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 12:08:18 +0000
X-Gm-Features: Aa3M54pwpxPJTVIggpBieAzJJk8and7CXiuIjARd9QXjrWziN4PwFiG2T_BQSoM
Message-ID: <CAFEAcA8gnP199dvdtUUfd3qR6yqRNO+mW_6S1FFZs0cOG7fFJQ@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 5/9] hw/sd/sdcard: Migrate the data transfer size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 22:55, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Commit f486bf7d1092 introduced SDState::data_size, the size of the
> current data transfer, but did not migrate it. When migrating in the
> middle of a data transfer, the destination uses its reset value (0):
> the transfer completes after the next byte, so the guest receives a
> truncated data block.
>
> Migrate data_size in a subsection, only needed while sending or
> receiving data. When the subsection is absent (older source), assume
> the whole data buffer. Use uint32_t, as the size never exceeds the
> 512 byte data buffer.

Not for this patch, but maybe we should assert() that the size
is in bounds when we set sd->data_size in sd_cmd_to_receivingdata()
and sd_cmd_to_sendingdata() ? (There is an assert already on size
in sd_cmd_to_sendingdata(), but it's in the "if (data)" rather
than in thi "if (size)" so it isn't executed in all cases where
we set sd->data_size.)

> Cc: qemu-stable@nongnu.org
> Fixes: f486bf7d1092 ("hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and s=
d_generic_read_byte")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sd.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d922e813c102..cca8debc0938 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -194,7 +194,7 @@ struct SDState {
>
>      uint64_t data_start;
>      uint32_t data_offset;
> -    size_t data_size;
> +    uint32_t data_size;
>      uint8_t data[512];
>      struct {
>          uint32_t write_counter;
> @@ -1002,6 +1002,25 @@ static bool sd_ocr_vmstate_needed(void *opaque)
>      return !FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP);
>  }
>
> +static bool sd_data_size_vmstate_needed(void *opaque)
> +{
> +    SDState *sd =3D opaque;
> +
> +    return sd->state =3D=3D sd_sendingdata_state
> +           || sd->state =3D=3D sd_receivingdata_state;
> +}
> +
> +static const VMStateDescription sd_data_size_vmstate =3D {
> +    .name =3D "sd-card/data-size",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D sd_data_size_vmstate_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32(data_size, SDState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription sd_ocr_vmstate =3D {
>      .name =3D "sd-card/ocr-state",
>      .version_id =3D 1,
> @@ -1072,6 +1091,11 @@ static int sd_vmstate_pre_load(void *opaque)
>      if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
>          sd_ocr_powerup(sd);
>      }
> +    /*
> +     * The data size is not included by older versions: assume the
> +     * whole buffer. Replaced by the state restore when included.
> +     */
> +    sd->data_size =3D sizeof(sd->data);

In the "we didn't get sent the right value" case, what's the
effect of assuming the whole buffer? If "assume 0" resulted
in the guest getting a truncated transfer, does "assume 512"
result in an over-extended transfer ?

-- PMM

