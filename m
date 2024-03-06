Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B639FC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgNy-0000Hr-Ak; Tue, 05 Mar 2024 20:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgNw-0000H4-HO; Tue, 05 Mar 2024 20:47:56 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgNu-0000UE-JR; Tue, 05 Mar 2024 20:47:56 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4726608233fso1007049137.2; 
 Tue, 05 Mar 2024 17:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709689670; x=1710294470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EL8Yafyl4cnQOSXldTKS5ZEaAlLFa0fm8kJqJANsbtI=;
 b=kPBZKJplhKKvMTXVtPXteF85cFyulNFyOy1SHhMax5tBX2wONDkCfCk9mKYjvcK6Su
 EWlZXirKt1JKp575ZHRglUbmcyCkz2YHXyp3ih7A/RyWQK7DUIEPzvSXg6y7YUUBiYP9
 /yHmTTFA7yPV+uBw9IhrtPQz+Za2FY9eUFit5FwS0H4mNsDmkED4LTq7gOpPc5DZFFHG
 uKCNU6AlZ7PbFd6b65p76zO4r9WwKSDQS3JkVI39SHpEWiM/1/fauzc5PTAaUO7qGeTf
 Rkcdrwo9zNnKh38cp7XUzl8b48KWJDv9XPleNwJmxNi46/bxmANTjfHz60mx4CRqya1m
 uI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709689670; x=1710294470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EL8Yafyl4cnQOSXldTKS5ZEaAlLFa0fm8kJqJANsbtI=;
 b=of7c9YKCbl7qVW17xtNYIwnv0AjW5+gLSBmMbQo15Qb3PD0XbTnsyJDk/SoElb+hg2
 3qMUjEZstFfhnADnrXaGBNBPaW3ZA9L+5sXL5P0u9q6bRLhsRG9wPJtRFBpZ+SuoBNH2
 0onZW8OoSiNQvz8IqLN3uFHfvTiR+5wzoFcSLTFYHlJpbDTFH7lgxdySzwpz9muCzhhF
 4Gw2O66yldWIMUCUwKXzQ11M7nAPdpErBos4PiLlyeZWPffesUCgcODQsfUT7wsEevCf
 V/PHRP7d5S4wjy+n1KZwsx3l7gKCUAq7JK0fT2Vnk1n45ECCui+Rb+SLcgP+NDfKDYmv
 Kdbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8aXXEvQ7Ji8/zcJ2H8UiaNxfbDsvaiyecJ2fGjs21Dc+sHbjKATMpAaK6u3ceNyTl08+3j2Ibun2PNyp4wGzpD8i2b68=
X-Gm-Message-State: AOJu0YyDSfQkIfGHESqLyR2lSiw8waVDASLZ7ulApEhWEHbt7RqI4UHb
 i6Fvmgpb4ZfeoVBKREHQ5IR0k3LvcifiDNXQyXh8d2HhXWm5vUThHwhkI4L7bTHUUbg5oEIO3Ae
 jghjL8u26AowdXY6Bxpooh5SDcbw=
X-Google-Smtp-Source: AGHT+IFVNrR593g0cS8tlJXlNlVEEWuY6Dt7R5EWWccwRKugmNM7LregUe7InRyoSGtZOBUp8Vwkz8RsYNITk9T1wLo=
X-Received: by 2002:a05:6102:3754:b0:472:69ec:97da with SMTP id
 u20-20020a056102375400b0047269ec97damr4102901vst.27.1709689670439; Tue, 05
 Mar 2024 17:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
In-Reply-To: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:47:24 +1000
Message-ID: <CAKmqyKPaTSS6LMGM9svgFGG4VtuHC46Bk9JWiLn__k_tnX=XFA@mail.gmail.com>
Subject: Re: [PATCH] tests: riscv64: Use 'zfa' instead of 'Zfa'
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 1, 2024 at 4:07=E2=80=AFAM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> Running test-fcvtmod triggers the following deprecation warning:
>   warning: CPU property 'Zfa' is deprecated. Please use 'zfa' instead
> Let's fix that.
>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/tcg/riscv64/Makefile.target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefi=
le.target
> index a7e390c384..4da5b9a3b3 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -17,4 +17,4 @@ run-test-aes: QEMU_OPTS +=3D -cpu rv64,zk=3Don
>  TESTS +=3D test-fcvtmod
>  test-fcvtmod: CFLAGS +=3D -march=3Drv64imafdc
>  test-fcvtmod: LDFLAGS +=3D -static
> -run-test-fcvtmod: QEMU_OPTS +=3D -cpu rv64,d=3Dtrue,Zfa=3Dtrue
> +run-test-fcvtmod: QEMU_OPTS +=3D -cpu rv64,d=3Dtrue,zfa=3Dtrue
> --
> 2.43.2
>
>

