Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00271C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 04:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7cE-0003sq-08; Tue, 23 Jul 2024 00:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7cB-0003rO-BI; Tue, 23 Jul 2024 00:59:07 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7c8-0004ce-N4; Tue, 23 Jul 2024 00:59:07 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d316f0060so809333b3a.1; 
 Mon, 22 Jul 2024 21:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721710742; x=1722315542; darn=nongnu.org;
 h=in-reply-to:references:content-transfer-encoding:cc:to:from:subject
 :message-id:date:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=FgpFYmOgkh+3Nuy6wkK/bugSyVYsw4Ol+/5eGQtZWP8=;
 b=PAt/bWRjIDY1q03uDNviQ6yZd1WJwCdFt1eiCLEXW9B/gPC/JHrBMCk4g8HJ/MPXzq
 TcaEyKvximwDg9BZz9lPqshVbtCbvn8Dz47sgad2beoDOIhWgQZjLeNao7lio9yRaFeU
 otskCewbIwtDqdMckJXD1voVmB22OLAYGP1zWmEyizGjjOVMQ4F5HptvIEC1tUFYvPkw
 edtkserkLfKCquUYxYlneCMppzlVjn7EBzO2Z1nBNP5Q61jBdwLS9fWd93kyjgcQgKqM
 8Bjww6pzPRdr/CHFMZ4zbErhGSdUJoULN5Gj/RV2qfIh87y6gX03JWus1TqwKIMHYROq
 U2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721710742; x=1722315542;
 h=in-reply-to:references:content-transfer-encoding:cc:to:from:subject
 :message-id:date:mime-version:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FgpFYmOgkh+3Nuy6wkK/bugSyVYsw4Ol+/5eGQtZWP8=;
 b=Fk9kiEvemijeipEXMMhlZHD2tX0O21+OOmbKpmDtmb7CEKGZfkV220pWkVqg8dOhg0
 xxIdP3frPin5/F62egbm/TXefUs1sbSLW6tSFJYa3ySVMg/EIFgiu25q/U8DPDx3eNOY
 4O7mWUSIRaSxNtaHzD1682yrb6TMOgKYtTLVcTrDupYbg3l6HmeqRfp2U1RO69wpoXBU
 PwMPSyD0iJJ1QsY66PCHotlyWQOufLl0Mgj4YOCXz+Fm7MNLpmbwKOw/Rnui3BaY5F38
 xvf6RdyKnGW4OrtHnMT2/S8c35f219F1jezBK1i38M+0V1z1mYZDDIW8hlmJtJqymV0/
 Y02w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaBMK13BWrh4VHTCrpCq2iZiIfIqKF8mj5ZreZ1swH4VmGN3Lu0nd1naF+Av4qgLpab3qE3r1SQtYPlsetqqSvdc/P
X-Gm-Message-State: AOJu0Yxi/+x68atpD4rwYEj1ngyCjJMxl34nr9KKnH6TCL4GsaxebyPE
 Jy3QKaXRqZ75kN1tKEznPEY9oETl0r5cjLY7gKSZQ8D7AbJfLwI0
X-Google-Smtp-Source: AGHT+IGNdzFvzQjFI7aAqRL08NErMHDXpIMccWscVdTALtiUphwRs6QP3XPXMhTNYKae84aI+hmQwg==
X-Received: by 2002:a05:6a20:4f22:b0:1c0:e8f9:5ac0 with SMTP id
 adf61e73a8af0-1c4522d5e86mr1160520637.27.1721710742405; 
 Mon, 22 Jul 2024 21:59:02 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d13c2b588sm4247450b3a.3.2024.07.22.21.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 21:59:02 -0700 (PDT)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jul 2024 14:58:57 +1000
Message-Id: <D2WNIPIYCNGA.2WYVT9ZXPW78Y@gmail.com>
Subject: Re: [PATCH v5 5/5] target/ppc: Fix regression due to Power10 and
 Power11 having same PCR
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.18.0
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-6-adityag@linux.ibm.com>
In-Reply-To: <20240606121657.254308-6-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

On Thu Jun 6, 2024 at 10:16 PM AEST, Aditya Gupta wrote:
> Power11 has the same PCR (Processor Compatibility Register) value, as
> Power10.
>
> Due to this, QEMU considers Power11 as a valid compat-mode for Power10,
> ie. earlier it was possible to run QEMU with '-M pseries,max-compat-mode=
=3Dpower11 --cpu power10'

Isn't this expected to work, or no?

>
> Same PCR also introduced a regression where `-M pseries --cpu power10`
> boots as Power11 (ie. logical PVR is of Power11, even though PVR is Power=
10).
> The regression was due to 'do_client_architecture_support' checking for
> valid compat modes and finding Power11 to be a valid compat mode for
> Power10 (it happens even without passing 'max-compat-mode' explicitly).
>
> Fix compat-mode issue and regression, by ensuring a future Power
> processor (with a higher logical_pvr value, eg. P11) cannot be valid
> compat-mode for an older Power processor (eg. P10)

This should be done before introducing the Power11 CPU so there's no
regression inside the series.

>
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  target/ppc/compat.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index 12dd8ae290ca..168a3c06316f 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -139,6 +139,10 @@ static bool pcc_compat(PowerPCCPUClass *pcc, uint32_=
t compat_pvr,
>          /* Outside specified range */
>          return false;
>      }
> +    if (compat->pvr > pcc->logical_pvr) {
> +        /* Older CPU cannot support a newer processor's compat mode */
> +        return false;
> +    }

Hmm. I suppose this is the right way to fix it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>      if (!(pcc->pcr_supported & compat->pcr_level)) {
>          /* Not supported by this CPU */
>          return false;


