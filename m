Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E2CC369C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59Ih-0006tt-OK; Wed, 16 Apr 2025 16:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59Ie-0006sb-AI
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:00 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59Ic-00026R-6A
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:23:59 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-47666573242so113981cf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744835037; x=1745439837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4c7chwNKfpIw0sShDTlgSfNynE7ep37GEYT+yGZvuc=;
 b=bD+L4HKqIwvMccK7/oar60Ee2Yf6LFFzpXo2F220D33YSYyfoEw7Fx8urf6396ECdC
 RsbivGipO7LUXsGQWR9ikLVtxc4pQxieGnn1lg2LkibyU2eNZ5XL5cHc7ArTPj5zMw9Z
 EF/6i6FwfeUS9Sul8i2YvQ16j8GvCN9edOhpsB8lDiKgjH90LFfhSYQ/lIWaiWlYn9EN
 WQlkourPbGFVf6KNWWiKXtynOPGP71vUhb0fHP1BYJlxKO8lDLtJgJXph4V+In4dWCex
 9SwK9x+W3X/iGyjEqe5V6Z2lfyyOvop06e/KonLdDIbC+iPglwBofvOaG/pMUHZd0/tv
 wF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744835037; x=1745439837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4c7chwNKfpIw0sShDTlgSfNynE7ep37GEYT+yGZvuc=;
 b=Pm8sd+UDqZXh2/dAEvsRxF9+bcPFD1BcXpPtz0598uh+isAo2Vb/Mi7bEvLYbuECsj
 7UD1PCS0T+h4itRecTn/8v2kPx7dU84ShHGqRXbFKKWcuIBOgJ8T7HQU3Pdk23fpVO5T
 uzXHIDQZ9XSZUq0DYVtTZ/zO6nfyBgUyLiI/12cHxBWYY+FezjPeIhVqPim3mH+6atTa
 3+whh/lCCyyaZ35B/jdD7tWwOX0+UFM3ee8uB9lOxe1Q6vh8oq4QylCdQziBx7krNeCB
 8VqAZpibiGOlluxd/zzf5mnj6n++ygvMXd/iV1hrOIH/TwLLiYL520orYWeq5soAXGQh
 NxGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIIy1+lJtcBXYaqn9/fcMDovNLGmAWTIyB8+QR138YgC8kEsqYSlBci013ysrY6cr/NgH7+Nq0oZ66@nongnu.org
X-Gm-Message-State: AOJu0Yyi8U843uVZEv2tXYM9LoWN2GOR5zOruNiWsHqvBsP1VV0DygDT
 259uRVA9+5nRQEn5CAzkxEAqFcobsRIUk7VrAcq07bbhVYjXsw98FXDcD/TMCVZcds0/IldlUCS
 6fkHe8Byc4tw455mHJOFWa5vcRqiUjhnyWTeR
X-Gm-Gg: ASbGncvrs8TkazfRq/N+mBN1oyH6SQG/8biYF8rLSLILU2S/ebuaRWSMgjwn9kUokk7
 1KERVCcfUiJVF3zewd+D5JYgAoS66wyJQKQugj+z+PYcX3wnXop5zXp+vIV7quZksv/mSSmKQ7v
 t/OeNMvoTdZmFEjhuq98UpE1j8vZWPZr8bdOa3lhL2k998yWC3iv8C
X-Google-Smtp-Source: AGHT+IFgWEHh6cyv3g6bOMg7lyBcTpvITILSoakQUPlCI5v9pSYQD3APkhIc1gWRj0D6n9Wvrc6IjpwV0wow7mAi5KM=
X-Received: by 2002:ac8:5750:0:b0:477:1f57:5493 with SMTP id
 d75a77b69052e-47ade69aea2mr785171cf.20.1744835036545; Wed, 16 Apr 2025
 13:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250416034327.315714-1-jamin_lin@aspeedtech.com>
 <20250416034327.315714-11-jamin_lin@aspeedtech.com>
In-Reply-To: <20250416034327.315714-11-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 16 Apr 2025 13:23:44 -0700
X-Gm-Features: ATxdqUEt1ZCtRqxnu1yRK-448Vdu2tHpoDciB6IqIhmBhJ1A28hQM7uiTL_inl4
Message-ID: <CA+QoejUAQZETahXQXirGF7bh=u7ZxgiBo-RGGA_A+-F4rrpmyQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] docs/system/arm/aspeed: Support vbootrom for
 AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -178
X-Spam_score: -17.9
X-Spam_bar: -----------------
X-Spam_report: (-17.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.268,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Apr 15, 2025 at 8:43=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech.com=
> wrote:
>
> Using the vbootrom image support and the boot ROM binary is
> now passed via the -bios option, using the image located in
> pc-bios/ast27x0_bootrom.bin.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>

> ---
>  docs/system/arm/aspeed.rst | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 97fd6a0e7f..c87a2cf796 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -250,7 +250,14 @@ under Linux), use :
>  Booting the ast2700-evb machine
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> -Boot the AST2700 machine from the flash image, use an MTD drive :
> +Boot the AST2700 machine from the flash image.
> +
> +There are two supported methods for booting the AST2700 machine with a f=
lash image:
> +
> +Manual boot using ``-device loader``:
> +
> +It causes all 4 CPU cores to start execution from address ``0x430000000`=
`, which
> +corresponds to the BL31 image load address.
>
>  .. code-block:: bash
>
> @@ -270,6 +277,26 @@ Boot the AST2700 machine from the flash image, use a=
n MTD drive :
>         -drive file=3D${IMGDIR}/image-bmc,format=3Draw,if=3Dmtd \
>         -nographic
>
> +Boot using a virtual boot ROM (``-bios``):
> +
> +If users do not specify the ``-bios option``, QEMU will attempt to load =
the
> +default vbootrom image ``ast27x0_bootrom.bin`` from either the current w=
orking
> +directory or the ``pc-bios`` directory within the QEMU source tree.
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-aarch64 -M ast2700-evb \
> +      -drive file=3Dimage-bmc,format=3Draw,if=3Dmtd \
> +      -nographic
> +
> +The ``-bios`` option allows users to specify a custom path for the vboot=
rom
> +image to be loaded during boot. This will load the vbootrom image from t=
he
> +specified path in the ${HOME} directory.
> +
> +.. code-block:: bash
> +
> +  -bios ${HOME}/ast27x0_bootrom.bin
> +
>  Aspeed minibmc family boards (``ast1030-evb``)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.43.0
>

