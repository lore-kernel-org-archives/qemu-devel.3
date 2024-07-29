Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCE4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSax-00034E-3A; Mon, 29 Jul 2024 11:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSav-0002yD-D0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:47:29 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSaq-000500-DL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:47:29 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so5928057a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722268042; x=1722872842; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mSjDKWTBAXsg4nDAEN2Cn2dlEzXIiayBQvxoWLB0AM=;
 b=Muq61KF5eUck+ugZSy0Y2K8imT+1TQtG9+YlSQezrulAVOmypqCiKY2LLc2Be2H21U
 U3MKiTMsJZQTV+63axlWEmK4VGRsqf9GO9pYy0fkGgiV0MZLZWytWfribjpILpLv/ZPn
 I5pnhTSoc6oH1aew6A1Hg8qFHj2KpD2vNhrlluZy04qzwNv2um2sRJd8306FJq7+NzzE
 Hhdb981KzgvhQH09wvQKci6LXOc8piUlWp0CLt2SH4wnFRWaNvHGIGLeLG6VC8d9uQ9x
 qqlFCIye6VoTR0lpM34ZoOb9wAsFei9ZNe6VYdDPABhk1NUb9ODQ16lkPRPDOf6mau37
 zRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722268042; x=1722872842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9mSjDKWTBAXsg4nDAEN2Cn2dlEzXIiayBQvxoWLB0AM=;
 b=boWaqfyBIAVPzM31o7ooLrwPHdQUL8qCWb5jnJR3KurtvjgO+C9vdDx6/DkK5RULJe
 8hFh0kPT51aSwPqQiC2WZRGmZvNpCNfFX5IdqaKHxPycnR33m+ZAFCRrV3xPTVm6gFpu
 uEH1eRVXV094JiYZFTy7omKu3737E+O2timZbT41znMkcb45BWe/Cnob9m5e6U8ilE5N
 hr8RpvoQD6XMGpaRVIGVhld/0i2kP+f70ao6klu1MQXtY30DVhmYiLrqEx+jfUgwCDDS
 XPvxtp3OdIV0ygVjVTzXOSr7PnFjMDvROhZIyTpYZ/mQ9JG0AWsR/zynzfwNXaoDbWCW
 vxug==
X-Gm-Message-State: AOJu0Yx93uTbHkt2AE5LFC9xZhPD1wmeo7+uMMvxzUTR0WIFT3b8midq
 L9P+xLnAX7RBv4hc4whC3aYrYBDDirUHnKUiBqOMHjUBdWopNeCxTVr8KSZlpfldcA4oe3tA2ZZ
 b+XyW1DI8ss1VyICuZs9vmmjKavxRyU6OUVL1Ig==
X-Google-Smtp-Source: AGHT+IHrQ3q44hntbezR2QNgC4BIjAWOsZs4/iZHgXzGbusu3StZZEsd/yQ/VbsgQQsXiApFds3Kb4wTjJkIdcCejhQ=
X-Received: by 2002:a50:8759:0:b0:5a1:5fd9:5fb7 with SMTP id
 4fb4d7f45d1cf-5b0221f0a72mr4781668a12.33.1722268042098; Mon, 29 Jul 2024
 08:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-10-philmd@linaro.org>
In-Reply-To: <20240719181041.49545-10-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:47:11 +0100
Message-ID: <CAFEAcA9QA3Kn3h_bwMSoht7KZa8DOpMXFDUWon1kc+iHy59-EQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/16] tests/qtest: Update tests using PL011 UART
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 19 Jul 2024 at 19:11, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We weren't enabling the PL011 TX UART before using it
> on the raspi and virt machines. Update the ASM code
> prefixing:
>
>   *UART_CTRL =3D UART_ENABLE | TX_ENABLE;
>
> to:
>
>   while (true) {
>       *UART_DATA =3D 'T';
>   }
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/qtest/boot-serial-test.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-tes=
t.c
> index 3b92fa5d50..5cb309ccf0 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -70,18 +70,23 @@ static const uint8_t kernel_plml605[] =3D {
>  };
>
>  static const uint8_t bios_raspi2[] =3D {
> -    0x08, 0x30, 0x9f, 0xe5,                 /* ldr   r3,[pc,#8]    Get b=
ase */
> +    0x10, 0x30, 0x9f, 0xe5,                 /* ldr     r3,[pc,#8]    Get=
 base */

The instruction bytes have changed but the disassembly comment has not...

> +    0x10, 0x20, 0x9f, 0xe5,                 /* ldr     r2,[pc,#8]    Get=
 CR */
> +    0xb0, 0x23, 0xc3, 0xe1,                 /* strh    r2,[r3, #48]  Set=
 CR */
>      0x54, 0x20, 0xa0, 0xe3,                 /* mov     r2,#'T' */
> -    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3] */
> -    0xfb, 0xff, 0xff, 0xea,                 /* b       loop */
> +    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3]       loo=
p: */

This placement of the "loop:" label is odd -- usually the label
goes before the instruction that a branch to the label will
start executing at.

> +    0xfd, 0xff, 0xff, 0xea,                 /* b       loop */

Here also the bytes changed but not the disassembly. Since
'b' is a relative branch, why does the offset change?

>      0x00, 0x10, 0x20, 0x3f,                 /* 0x3f201000 =3D UART0 base=
 addr */
> +    0x01, 0x01, 0x00, 0x00,                 /* 0x101      =3D CR UARTEN|=
TXE */
>  };
>
>  static const uint8_t kernel_aarch64[] =3D {
> -    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
>      0x02, 0x20, 0xa1, 0xd2,                 /* mov     x2, #0x9000000 */
> +    0x21, 0x20, 0x80, 0x52,                 /* mov     w1, #0x101 */
> +    0x41, 0x60, 0x00, 0x79,                 /* strh    w1, [x2, #48] */
> +    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
>      0x41, 0x00, 0x00, 0x39,                 /* strb    w1, [x2] */
> -    0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
> +    0xff, 0xff, 0xff, 0x17,                 /* b       -4 (loop) */

Another unexplained offset change here.

>  };
>
>  static const uint8_t kernel_nrf51[] =3D {
> --
> 2.41.0

thanks
-- PMM

