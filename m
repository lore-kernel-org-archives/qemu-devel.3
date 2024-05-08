Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8EBC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gS5-0005ar-Cx; Wed, 08 May 2024 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gRz-0005Yu-A0; Wed, 08 May 2024 08:31:13 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gRv-00037b-DW; Wed, 08 May 2024 08:31:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso3205738a12.0; 
 Wed, 08 May 2024 05:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715171464; x=1715776264; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GpM2Wau9g7vnLLFGS1shdiSHE3sPS8g3dHSCTmh/6c=;
 b=fe5is1pz1W1OCy0exaVWf5NWeJOKnPP3laLpuYNUd106ZoihoODGH1gV/kTmEXU1id
 gCauFOXxzcv4BBbP5PlNGQI7hnNZf4UxJAH/1oo+f+rGExBC42qcZnscZbbkKmz6I8b5
 CGvWxHDZwgdBKVt0pww81i2GWoR1+oolzemC3NUwhmC7Z0SnLbsCDA5ZF4NcF5cWKLHS
 Q7r5kyhDpGZgEKEzVWHpL+Hhx1Yey/pZUI3GyOiW5f1xWliFyAa/NsKw8WeRABSprmlO
 JyYyfoVQ+0KDaoOF4Fy7hNLFYQGkObchoE/jJqWDLQ6RuctrH26v+cFwk+ioQRg7TOyQ
 bECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171464; x=1715776264;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6GpM2Wau9g7vnLLFGS1shdiSHE3sPS8g3dHSCTmh/6c=;
 b=QV3LHzJp5ZyPa/h8sixMcwfMnx79rQIX5nn1PxceV/cuF6mJ4hVNlFKgHDkcZ2xpzK
 VGDNsKah1hJ/JrBNv4Pduf2ghf9LOKXbFkRdnnvxnupk9QRvp5StIVLVKQ9ykagUOKvM
 jsa/uWV7qW1Vq2NANOyKoboxlQNcSIlB9klf8CxveO/B6aTcnAjbU0wIx6MT5VeMrWWA
 a8NqMmXTRMFr0n42BGPtiIByqcOyA5gy8IYoF7YDIgu3CLFPxRwSHbt/AQ3zRNRsyv9y
 4sngTaEVdyUAr0y/Kc2jSSX3Rw1isRaS13wHPrTNmc9LZd+in+zfvruSERLMwxAj4se1
 GMqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA6U8D4IYf/21U8WnbQqO00MZ1MEook/iwJQi1C9YBA32CFChTMa5K4uIIlVy3FA6gffJ+LPec/0rtxMCKtL5dnAdNHHo=
X-Gm-Message-State: AOJu0YwEVrug3FauYf3FPgctAp7U9GsmO/ZbVvZkVmLPmBwDtb0bo6xn
 TLXFfkzRspTXnHVN/dW09X9OeFCvJdR5r2jwWQyGgpBqzNLsgnsrm24J/Q==
X-Google-Smtp-Source: AGHT+IHsdEzOsg+0VUkyyAwLXWC3VdaTCWunh1jnlnKO+hWzfscOypM84mIX+IeF0DlvE2GOVvG6yg==
X-Received: by 2002:a05:6a20:1592:b0:1a7:ae5d:5fb4 with SMTP id
 adf61e73a8af0-1afc8d4df22mr2805232637.28.1715171464236; 
 Wed, 08 May 2024 05:31:04 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 bf5-20020a656d05000000b0062070308b0esm6921812pgb.46.2024.05.08.05.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:31:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:30:57 +1000
Message-Id: <D149JDYPG4NB.GTUPG8F1OZL2@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v2] ppc: Deprecate 'ref405ep' machine and 405 CPUs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240507123332.641708-1-clg@redhat.com>
In-Reply-To: <20240507123332.641708-1-clg@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue May 7, 2024 at 10:33 PM AEST, C=C3=A9dric Le Goater wrote:
> The 'ref405ep' machine and PPC 405 CPU have no known users, firmware
> images are not available, OpenWRT dropped support in 2019, U-Boot in
> 2017, Linux also is dropping support in 2024. It is time to let go of
> this ancient hardware and focus on newer CPUs and platforms.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  v2: fixed header line
>
>  docs/about/deprecated.rst | 8 ++++++++
>  hw/ppc/ppc405_boards.c    | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 03f8b1b655e071432ecd9decf61e194821d06928..e22acb17f296362509a3e143b=
a61bafd210a6c91 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -258,6 +258,14 @@ dropping the ``cheetah`` OMAP1 board, because we don=
't have any
>  test images for it and don't know of anybody who does; the ``sx1``
>  and ``sx1-v1`` OMAP1 machines remain supported for now.
> =20
> +PPC 405 ``ref405ep`` machine (since 9.1)
> +''''''''''''''''''''''''''''''''''''''''
> +
> +The ``ref405ep`` machine and PPC 405 CPU have no known users, firmware
> +images are not available, OpenWRT dropped support in 2019, U-Boot in
> +2017, Linux also is dropping support in 2024. It is time to let go of
> +this ancient hardware and focus on newer CPUs and platforms.
> +
>  Backend options
>  ---------------
> =20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 4092ebc1ab59de14b66ebad2be7eb019faf45db1..c44e7ed162fae5ec884ba4e45=
8138f84430a8460 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -350,6 +350,7 @@ static void ppc405_machine_class_init(ObjectClass *oc=
, void *data)
>      mc->init =3D ppc405_init;
>      mc->default_ram_size =3D 128 * MiB;
>      mc->default_ram_id =3D "ppc405.ram";
> +    mc->deprecation_reason =3D "machine is old and unmaintained";
>  }
> =20
>  static const TypeInfo ppc405_machine_type =3D {


