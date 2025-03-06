Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDCCC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpyky-0007dM-SP; Wed, 05 Mar 2025 19:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_ubIZwwKCjUeRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com>)
 id 1tpykt-0007Yi-S5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:06:29 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_ubIZwwKCjUeRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com>)
 id 1tpyks-0006uZ-D1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:06:27 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fec3e38c2dso371509a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741219583; x=1741824383; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=WUYfGT4tZgOk8vPsyLiI12zfKR9QKBadLQTRXrZflD8=;
 b=byQvn+Sw4k5e/6Ij7LVTR+rcnlIi7/OFhQppNDLh1YXbscbvtZNiMaJiMiKm3jDZMI
 gSxrFH/fyc1o72sihHoeDWeuzMPfeHN1+A/PbKxMF0SXixmX/uOy0/zrElxuoRd0UW9F
 fBwj4R/x5wNl8wuKQe9lzsuRvm8P13US5UHy9giDTs6JyYs4omInqCQf1eF5YxQqBQwa
 f+5S+j8H3DyLppC61G0AcUJpkBYDDYe254s6vbj4sLgOUz5iFc57IeRzXwIjNWxOb7Mo
 UypykPdGv882oEImho8kl1YsaNw//2jgF2mxjQwefDF+jjiQHor/OXNFGarrjOuCPu8N
 Ab3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741219583; x=1741824383;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WUYfGT4tZgOk8vPsyLiI12zfKR9QKBadLQTRXrZflD8=;
 b=kfjVh2M2LO8WZC0sfcwX/U42Hzdkhr4jjY5CDzNHI5Rll/WIDQ0IjeVmes9k2664R7
 ISDWKgvdKWr4af3UVuzZCD2nTD5dPAV/k2xiDkLR4OalrtBHEP0yVMTyPb+vchJ5Ona9
 wRKkAWefFceCW/TT/rpu5kEUuVTkwDHyyRsEW35lLJstCkhHHZ87iNyT7aL/fwRKINr+
 V9+3KfWsDhDuJkS+BAtHs2DaUtOBXbXpW4R+VcVShnQInZvwh+X4k5FCgHSoio/KNcQI
 dJ/oKQ8Pyc/ETOVaue0VgyYRoZczrJtrk7OOfJ7cMuwpW9UC/O/RFVHd1owGeF2tLnZQ
 zyPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPMfSA5Vu8Yn/C7xofnl3wti6o9Begq0mpLEdDs90VaRpmlqvJkJPunPeX2Yahi+3i2F76Hv2KpEwV@nongnu.org
X-Gm-Message-State: AOJu0Yxr2fVuUzFY2cXmLwkCL9gT2Atn/KmAwyyllB9+7v30OaAQq0Q7
 HXojRFvk5narTuhiXwZAivckuyGUDrbSatuh9rrxt2uHf8+neI6/H7fH8fem0jKj4ITpGjMpAuS
 VwPZMb1RkgwFvPhc1eUOunh7Ytg==
X-Google-Smtp-Source: AGHT+IHCxkzT4BewicbuR0nG0wcc4xmQ6uPBdAoUteOenxn3DZDNNpLLMKGXG0EFewkb5D9HDVF0Hm38dvEWdRM9AjI=
X-Received: from pjh12.prod.google.com ([2002:a17:90b:3f8c:b0:2fc:2f33:e07d])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c108:b0:2ff:52e1:c49f with SMTP id
 98e67ed59e1d1-2ff52e1c577mr4670473a91.26.1741219582818; 
 Wed, 05 Mar 2025 16:06:22 -0800 (PST)
Date: Thu,  6 Mar 2025 00:06:16 +0000
In-Reply-To: <20250304064710.2128993-4-jamin_lin@aspeedtech.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306000619.2093315-1-nabihestefan@google.com>
Subject: Re: [v5, 3/6] hw/arm/aspeed Update HW Strap Default Values for AST2700
To: jamin_lin@aspeedtech.com
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3_ubIZwwKCjUeRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Reply-to:  Nabih Estefan <nabihestefan@google.com>
From:  Nabih Estefan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> Separate HW Strap Registers for SCU and SCUIO.
> AST2700_EVB_HW_STRAP1 is used for the SCU (CPU Die) hw-strap1.
> AST2700_EVB_HW_STRAP2 is used for the SCUIO (IO Die) hw-strap1.
>=20
> Additionally, both default values are updated based on the dump from the =
EVB.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Tested-by: Nabih Estefan <nabihestefan@google.com>

Thanks,
Nabih
> ---
>  hw/arm/aspeed.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 98bf071139..c6c18596d6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -181,8 +181,10 @@ struct AspeedMachineState {
> =20
>  #ifdef TARGET_AARCH64
>  /* AST2700 evb hardware value */
> -#define AST2700_EVB_HW_STRAP1 0x000000C0
> -#define AST2700_EVB_HW_STRAP2 0x00000003
> +/* SCU HW Strap1 */
> +#define AST2700_EVB_HW_STRAP1 0x00000800
> +/* SCUIO HW Strap1 */
> +#define AST2700_EVB_HW_STRAP2 0x00000700
>  #endif
> =20
>  /* Rainier hardware value: (QEMU prototype) */
>

