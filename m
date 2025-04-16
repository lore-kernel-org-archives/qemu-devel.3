Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F698C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59JA-00070p-0R; Wed, 16 Apr 2025 16:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59J7-0006zS-HA
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:29 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59J5-0002Ft-8e
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:29 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-47666573242so114241cf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744835066; x=1745439866; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdImBUd8+Y3gUuU+siH992oEhjyYPvebA76p06tGW50=;
 b=JYnUvT7dGOTMMibG4KWnCv11a1vTCp8Vb5xGo6QhpmCSQrTGcitnu5IdKSI+Bd4hPo
 qGP+2A53NajPPKPANW5yD9PHCL5rjd2Wnrn03kS1jcU9qJjdGcalQpF2l5E+ge48b/ql
 3V3gRUc2BJAuvPL9Go7GU6+4pTE9VFg1bwaUrgOxjJ7jTNTYBA3HjvEre7jX0wddanXD
 tYFa+JazaXLhOINHUomtfR9AFxO0qbFSx3bQpj6pZE89FxxKnxxfBby15VO2Rt3cxN8Q
 9sXaQIPhMNtYt67OCzhzywDO87VI3HFkOW9vgDkBUiXBWvi7BKy0t/cPFVx7A1+TtxU0
 KqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744835066; x=1745439866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdImBUd8+Y3gUuU+siH992oEhjyYPvebA76p06tGW50=;
 b=xSY/x6+ibk8ce8yI8pUw53vAGxY01l9Jv0HiutJq2bVZqP55fY6IZgwiOeOI9wG7gw
 PdT7LfGqQlUK0HjwppUIZKZY9T0wt1Ghp+BceND1H5r2T8YBufVNt4ZQtENOkn2HmaRk
 b4cfn8SrBYpqliVqlH/k1cP4oGyaI+1vG87WilRFxZPb8oXO70rp0yCmv7Q/roMJZbvP
 F2DSbMuxjmGDYQu+8OOWKVT/bicVHjfXH/DOlB0/mP/mzDPZue+IwkDOtbzV79gF4sTy
 i8UrZpPIZ//mBwWSRwC5RMM71jcuHQdgcBipDNBDRVIcX5g/8g+VotEbE+papShTmvOK
 hEuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaSjoyzpm9khpWHHUXmUwB3REVMWbFSOoE+EgsKtQTbMwbipAguh1uJnc94SS54+e2SrxZR/I4J4ak@nongnu.org
X-Gm-Message-State: AOJu0YyKBLScqGlUWRhIywiIbazAnmtbKq0lceSy6vrV6jkn2hcQtUwe
 dDGuXE4OZwo9T8d+2WnfBb3Nl7yNkHbRXYmKp6V7LjSONzg8+MWgd4hMxyg/1kDlKK67xuvIZ4i
 qtaVZx6Px74Xg2ccKkwao6RpjBfHClRDX349Q
X-Gm-Gg: ASbGncv3GHXOHI3/mINalettrmcKituHnQV5nx727C4fcOxmbOwhcvoeEYuh1uZHH0O
 RGdmg6rojXPyFO7Rjq3VlAIXd/7pS44Jz4/qavMu91nLJXGN6+Sc0OpraWvg384vjKciOASGIeJ
 mg5Ez4YMGtP2uOZuwN1jjrR9l462tLcbby3DmonoOeKVetN+RSoi2E
X-Google-Smtp-Source: AGHT+IHis1hkPkK5GQc85mCFUcrzBQMyjijV+24aog/SdHeRoj6TwGhtf3CTO7767mwB5Co/frbx5OOG3OIEx67fOJc=
X-Received: by 2002:a05:622a:1903:b0:479:1958:d81a with SMTP id
 d75a77b69052e-47ade6170eemr806031cf.6.1744835066112; Wed, 16 Apr 2025
 13:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250416034327.315714-1-jamin_lin@aspeedtech.com>
 <20250416034327.315714-2-jamin_lin@aspeedtech.com>
In-Reply-To: <20250416034327.315714-2-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 16 Apr 2025 13:24:14 -0700
X-Gm-Features: ATxdqUGkYVhDuwFt_ty5X90dDFxcR_vIYlceIt9E0absZVr1ZmxwBQEz8giN328
Message-ID: <CA+QoejXTjwpR_tW4JzD6=FoUhm3_Rftdr-8M4xDbRKGX_H4k2Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] hw/arm/aspeed_ast27x0: Rename variable sram_name
 to name in ast2700 realize
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, troy_lee@aspeedtech.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x835.google.com
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
> The variable "sram_name" was only used for naming the SRAM memory region.
> Rename it to "name" for consistency with similar code and avoid unnecessa=
ry
> new local variable declarations.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

> ---
>  hw/arm/aspeed_ast27x0.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index dce7255a2c..b05ed75ff4 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -577,7 +577,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>      AspeedINTCClass *ic =3D ASPEED_INTC_GET_CLASS(&a->intc[0]);
>      AspeedINTCClass *icio =3D ASPEED_INTC_GET_CLASS(&a->intc[1]);
> -    g_autofree char *sram_name =3D NULL;
> +    g_autofree char *name =3D NULL;
>      qemu_irq irq;
>
>      /* Default boot region (SPI memory or ROMs) */
> @@ -649,9 +649,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)
>      }
>
>      /* SRAM */
> -    sram_name =3D g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu=
_index);
> -    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram=
_size,
> -                                 errp)) {
> +    name =3D g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_inde=
x);
> +    if (!memory_region_init_ram(&s->sram, OBJECT(s), name, sc->sram_size=
,
> +                                errp)) {
>          return;
>      }
>      memory_region_add_subregion(s->memory,
> --
> 2.43.0
>

