Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D210C021B2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 09:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlm1H-0007E1-02; Sat, 22 Feb 2025 04:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1tlm1F-0007Dn-0Q; Sat, 22 Feb 2025 04:41:57 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1tlm1C-0006lp-O4; Sat, 22 Feb 2025 04:41:56 -0500
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-439946a49e1so18248205e9.0; 
 Sat, 22 Feb 2025 01:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740217313; x=1740822113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/6zF18sr+H4aV8iIBaQuqtGPgtDt/rve8RnYGx0smc=;
 b=ekJC+Wa1409ZZ8GqK3gyNGV3/NggjCVYxNaClziM8ZZfs/IMm/jaOm5hKyyXnMXoPZ
 G/5LV1TNrpEDch3NE0bCimm16/LpNlV3+bb1tXCAwO0KcKyAc8yaG6WRgjjaPuNiltjh
 HVi02k74IVkUA/AOc+eMmWxlJcAQ++NzgLzuAOuzHQdvB2fUD+ML4KwcVgXxRQplSL5/
 vBmXBNHk7mgmrV+1rTTdRxmgt3ha6wyzR3OulpmpYf8t3SX5tKkdGER3JSo+3iGHwg5I
 ivF8bCSidzdPDYebyXDkD6eVz/35gN81mfq6VpUmH1cTyDa3VCOCCDZLmMiGxYwnldXQ
 PSwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXn8//plak6HupPLHi7iWHf5yeZ8eeV+27pOltclE3mNt7n6bDgfuwzu/A0KD8Kue4xeBU6i2rNA==@nongnu.org
X-Gm-Message-State: AOJu0YxwtIf3MbgMf0TpHbkf2ryXbKOR60vXaq5Uvbcop5tclJM8wy1m
 Y/QK8ArxznRmKJS2H9kjk/+oMSuwBUlLPSf+RCIFFvMKOFBOeZ9/
X-Gm-Gg: ASbGncvQLRXo/wMLovR2tqEGy5kSVF3zaIt1Azh7Na/07JJmRNmve23dICrYhgULdhX
 L5zCSBgDOFzQiheaHWdri3s3KK/AdscVUYIRpYpdirryxJVTACV1uI4kzBXREGS0FrE/zuyQLX8
 dogHgm+lN5PdWjstfrFwPB0TtV7ss7/f76sXF6ypPO5ECM1Uqjh/GoBFnrLgaSBOqN0MNAegs4v
 +Soh5/2UdSpSvvWgyuEIvXSfcXRqy9EaoYCkdm+/vcU9LLmZmgcGYrgoEfVGWH3qJWxSNfdfqZV
 tJzciBBEWunkL9aaGa40asS6rHZf9PSpZxtzjHYlgxPyrwGf
X-Google-Smtp-Source: AGHT+IGEUOKQJQZEbO5RqGE2g5ULtX+AHPzfTNSznb9Z3gM5FL8SnzorvM1NV4f2l0zdVCW50yfgRA==
X-Received: by 2002:a05:600c:1910:b0:439:9225:2f50 with SMTP id
 5b1f17b1804b1-439ae1f1586mr66345315e9.16.1740217312610; 
 Sat, 22 Feb 2025 01:41:52 -0800 (PST)
Received: from tpx1 (ip-109-42-51-157.web.vodafone.de. [109.42.51.157])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b434fsm26142897f8f.16.2025.02.22.01.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 01:41:52 -0800 (PST)
Date: Sat, 22 Feb 2025 10:41:50 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Shin'ichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Rayhan Faizel
 <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org, Evgeny Iakovlev
 <eiakovlev@linux.microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2 8/9] hw/char/mcf_uart: Really use RX FIFO depth
Message-ID: <20250222104150.03b08f1d@tpx1>
In-Reply-To: <20250220092903.3726-9-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-9-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.44; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f44.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Thu, 20 Feb 2025 10:29:01 +0100
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> While we model a 4-elements RX FIFO since the MCF UART model
> was introduced in commit 20dcee94833 ("MCF5208 emulation"),
> we only read 1 char at a time!
>=20
> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>  hw/char/mcf_uart.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
> index 95f269ee9b7..529c26be93a 100644
> --- a/hw/char/mcf_uart.c
> +++ b/hw/char/mcf_uart.c
> @@ -281,14 +281,16 @@ static int mcf_uart_can_receive(void *opaque)
>  {
>      mcf_uart_state *s =3D (mcf_uart_state *)opaque;
> =20
> -    return s->rx_enabled && (s->sr & MCF_UART_FFULL) =3D=3D 0;
> +    return s->rx_enabled ? FIFO_DEPTH - s->fifo_len : 0;
>  }
> =20
>  static void mcf_uart_receive(void *opaque, const uint8_t *buf, int size)
>  {
>      mcf_uart_state *s =3D (mcf_uart_state *)opaque;
> =20
> -    mcf_uart_push_byte(s, buf[0]);
> +    for (int i =3D 0; i < size; i++) {
> +        mcf_uart_push_byte(s, buf[i]);
> +    }
>  }

Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>

