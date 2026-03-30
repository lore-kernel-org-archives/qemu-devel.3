Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A74B1061B04
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Dhb-0003Fd-TX; Mon, 30 Mar 2026 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7DhH-0003CH-Bd
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:34:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7DhF-0002zD-Lr
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:34:31 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b97905516faso605921866b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774881267; x=1775486067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OnW3Nzm3A2tuGDk+KBHWjD1GqJ6hpIYk6t5qncrmZA=;
 b=sSfEa+dib3c5ZV8LIqeo4uYSGrOfnqrt3VWah4dPIWI6yYg5N3qJlZdhPm5jAt8t3N
 7+EaLMzoYy6syvM5KBRf4wSV8uPN5V9uh+3Lx0NkHGJqEgYW8P/g6X0dljjkCD6kI6tc
 L5bfiH/uVAprapAMI8ODLZ/H9YCX2R2Jp+p9I6v+UcSgrhPA3b8g/DWkw+YwifpjX/HT
 KsaLhcNr0WT3NyP2L2DECmPOaArnaVFavNUk2+vMp6EZTRmVGSwDnIRkJ/gAkNiH6Tk6
 SDxRNvnSOCuQ8HmIzhRXqPrDCWNvbo2r0bN7p96FmzDvOxhNMpVmQnyAkQkLX5QAPFED
 y+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774881267; x=1775486067;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0OnW3Nzm3A2tuGDk+KBHWjD1GqJ6hpIYk6t5qncrmZA=;
 b=msPX/igOZ8eTU+e0GpYjGImYsZGumrq6RPpFcFO/m0cGFXDdwa9ia9H3Q0em1VEslh
 rMWb/MKmiHNXSlkYROXkqiAHfiBxDrgi+3ITyCIUi+XQW/yj8j7DFRLfmQ8iuFNv8081
 ReE7HcPMobqfePPCtvojgH74XvT1mkP7cqgGE/iM7Mxvv3K2i/S2QfOm5XxA97qVeOUy
 /N0xn2ZoTvhldvZX0S4mXrlJzvM9Vcd/7zMKJYRhkBzWVlx569I8b57MQ9LbQ2o1h0YM
 /0zP4jS8PhiK51gtpAjrhaXL+YJqYzEAO72A/mtNU9XHgYfyrD48mz2NUWb6aqu8UWqH
 Ro2w==
X-Gm-Message-State: AOJu0Yy/4vjAr4LVx9uXR4bOr42y+NxKk3sNgI0Vt20fKS+jWqjZ1lGP
 RXBlB3WDMy+YtvEZlmz4n8pVIJUY8o8IHCCk03A9q8+VAeO/MhRihqZR77Uy0k+/jZk=
X-Gm-Gg: ATEYQzzIE7lTWUdyjHXwRsZXuQEE3NzQx6esxQI/2BS7KQKmOlmVGGH4ae4iFHa1xG9
 XbRST9ZDCoKdnvqlsCRHc2s8lPB3j5EaExncq3LM7BREZlVtpQCWs8o0tOtRXhvMU1r5xzPhst/
 X8cBYARwvc29i4iMoWSwRDDhrFNXPKEBB++0/pXh28T5nJrwKEzMFviUvUrnFpRCnorOOj7uOFA
 NVNfatS1QiKHH2w9Rha25HtP4YDWDmkdHgZwRwulFIQsJK4xgC76+ArXrxhJDYRSWTkVPIKtCJy
 IFfVtUsyQxs5XtTUMMzPPQHYakPgb701oQ8UsfnTaPZYbH0D43PooAau3eyeC8XIaGmhcB2pGc+
 byh8xzNo20LVDl0a5cDocrm6+96cegvaKB7xSlAPS27jg113LdKulbUuBfc6mG6eaDejqMRWmik
 r4B+LMtn0862dMR1vRLAzz1y8=
X-Received: by 2002:a17:907:1b09:b0:b98:4c2a:d503 with SMTP id
 a640c23a62f3a-b9b5090af40mr747117066b.38.1774881266132; 
 Mon, 30 Mar 2026 07:34:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a65c2sm302295666b.34.2026.03.30.07.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 07:34:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F1175F713;
 Mon, 30 Mar 2026 15:34:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/display/vga: Fix debug message
In-Reply-To: <20260330140656.46FE55969F2@zero.eik.bme.hu> (BALATON Zoltan's
 message of "Mon, 30 Mar 2026 16:06:56 +0200 (CEST)")
References: <20260330140656.46FE55969F2@zero.eik.bme.hu>
User-Agent: mu4e 1.14.0; emacs 30.1
Date: Mon, 30 Mar 2026 15:34:24 +0100
Message-ID: <87ecl1perz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

BALATON Zoltan <balaton@eik.bme.hu> writes:

> Fixes: f9b925fd41 vga: introduce VGADisplayParams
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/vga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index ee7d97b5c2..26039f0020 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1662,7 +1662,7 @@ static void vga_draw_graphic(VGACommonState *s, int=
 full_update)
>=20=20
>  #if 0
>      printf("w=3D%d h=3D%d v=3D%d line_offset=3D%d cr[0x09]=3D0x%02x cr[0=
x17]=3D0x%02x linecmp=3D%d sr[0x01]=3D0x%02x\n",
> -           width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
> +           width, height, v, s->params.line_offset, s->cr[9], s->cr[VGA_=
CRTC_MODE],
>             s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
>  #endif
>      addr1 =3D (s->params.start_addr * 4);

Really it would be worth just deleting the #if 0 code - if it's really
useful for debugging you could turn it into a tracepoint.

There are a bunch of other #if 0/#if DEBUG_* statements that could also
be dumped/modernised.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

