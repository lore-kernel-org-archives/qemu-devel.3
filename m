Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7984FC369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59JB-00072K-Nf; Wed, 16 Apr 2025 16:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59J9-00070n-Gq
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:31 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59J7-0002Gx-Om
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:31 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4769e30af66so21031cf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744835068; x=1745439868; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xq388DhXZB9hNvxukWG3QesZ8hs+pPdsydsNVKIkg9E=;
 b=eec+e2kBpZSXqlN6fTOI2qZId4264Mi9et/EcRVidYIUezM1IhT/5dJBGNAYL3WtCE
 C4jKvShCD4HZgIHbzuESxaHu2VEYsmd1WG3bMovKWJ+oZOh41w+QL5T+ImQNgxlalNdG
 NQucsie6gbzdvJk5+XVlyvKyOWwGYQfTxoBhD9zm/wFJiUzuUuCmWMnnZurMwNyAtoIM
 W+bDWtnVFLPy7+fcvMNrn+T4VbcKV6Kr07CBBP0B3R9OunMduFhBGFiQcCEZVe9BZ6FS
 m3e66qz0mAWPxNU5VzpJAdFG1jcVZhSjYrBOAiCjaU93QJ5ajuX1FruXPN/qtlos/NRo
 iszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744835068; x=1745439868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xq388DhXZB9hNvxukWG3QesZ8hs+pPdsydsNVKIkg9E=;
 b=a4b01j8TzKAY9HDyuOBnlpWk5XbIYSgZA/+kErGHlJWKaHA2CPFNTl9yrUxprxjKz5
 3BquFA6wJJm4mzYbipJNtgV+B8utylOWpfk9/3upC0Q5SkjOBqn42P2QmJbf+7JREfGD
 nV2ITjO/FoJd4elKTbQkW/K+b1NSFVIdXwWxYt2ajL3n0xbrj12pC2JpAONI/IdvbK8I
 BRODApKgg/Z59SGJenXUu8iDLoQ8CqDD31f9NyiYwwG0RED0beN1K9ASZsFjb5jG0BlP
 nYd1O6NpiSSQXSe7/W9b6SGtkc4x6A6pQzvBJWUXDSDmiWJtHrQGS+jTcajvBQ9uswKj
 gwSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuNqefqrsNN9708+RI1wzmOveTezioNur6Qhcm0Hs+/TvSMmEAemuAUj9u5TLkLH5go7ftruHlGQbB@nongnu.org
X-Gm-Message-State: AOJu0YwoV5WYkdx+YlwsJByhcapcQvjhmCDLyUAB9Eu4OS6bUy9Wrs4t
 IoKPdufbkx7hN47cd0BnUChceBFSiXaeb1zu0WG9BORV2xsKcEgihNmxlkX9Xf+KemyNZYE35iL
 6hjyBXDFbnfQgdf89QjA1rFMYMZL98b7L26v1
X-Gm-Gg: ASbGncuvdExYFSZbgFLy2tVY+4FHeEkQPTwOBKGtfDVVZQ8/RmSF67lGxk3l/U945AJ
 TcHibcoXOvMOM+BiFViGgS0FpgLXU+MP+5y/wuuMK5gK5uI5hUt22ZwsCrFilpe0o2aKMZimJEu
 FhFWmcE39vwyCTh80aB4Z+W2YuRW/4OZDw5fJSB8JgIL4+gq1aHJDs
X-Google-Smtp-Source: AGHT+IGw0AnopGaHiXVZWRjUeiXBg/4xA7eirbf7l+niaUN0F1GUCNDk01Ubq3agDtHzjR1U67INV2wK9VYBWveo2uI=
X-Received: by 2002:a05:622a:14d4:b0:479:973:46f1 with SMTP id
 d75a77b69052e-47ade6ac501mr965301cf.22.1744835068400; Wed, 16 Apr 2025
 13:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250416034327.315714-1-jamin_lin@aspeedtech.com>
 <20250416034327.315714-4-jamin_lin@aspeedtech.com>
In-Reply-To: <20250416034327.315714-4-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 16 Apr 2025 13:24:16 -0700
X-Gm-Features: ATxdqUGzMUpbSUdHOBu1xoXj518eftjerrPMnQNDiUOFR192a8s55Im3UDVqj_0
Message-ID: <CA+QoejUwtpNrDLfQrxv5u-3eDeD+McT=+WVwrPp84hm-bXT5-A@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] hw/arm/aspeed: Add vbootrom support on AST2700
 EVB machines
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -178
X-Spam_score: -17.9
X-Spam_bar: -----------------
X-Spam_report: (-17.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.268,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
> Introduce a new "vbootrom" field in the AspeedMachineClass to indicate wh=
ether
> a machine supports the virtual boot ROM region.
>
> Set this field to true by default for the AST2700-A0 and AST2700-A1 EVB
> machines.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

> ---
>  include/hw/arm/aspeed.h | 1 +
>  hw/arm/aspeed.c         | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 9cae45a1c9..973277bea6 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -40,6 +40,7 @@ struct AspeedMachineClass {
>      void (*i2c_init)(AspeedMachineState *bmc);
>      uint32_t uart_default;
>      bool sdhci_wp_inverted;
> +    bool vbootrom;
>  };
>
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 82f42582fa..e852bbc4cb 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1689,6 +1689,7 @@ static void aspeed_machine_ast2700a0_evb_class_init=
(ObjectClass *oc, void *data)
>      amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
>      amc->uart_default =3D ASPEED_DEV_UART12;
>      amc->i2c_init  =3D ast2700_evb_i2c_init;
> +    amc->vbootrom =3D true;
>      mc->auto_create_sdcard =3D true;
>      mc->default_ram_size =3D 1 * GiB;
>      aspeed_machine_class_init_cpus_defaults(mc);
> @@ -1709,6 +1710,7 @@ static void aspeed_machine_ast2700a1_evb_class_init=
(ObjectClass *oc, void *data)
>      amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
>      amc->uart_default =3D ASPEED_DEV_UART12;
>      amc->i2c_init  =3D ast2700_evb_i2c_init;
> +    amc->vbootrom =3D true;
>      mc->auto_create_sdcard =3D true;
>      mc->default_ram_size =3D 1 * GiB;
>      aspeed_machine_class_init_cpus_defaults(mc);
> --
> 2.43.0
>

