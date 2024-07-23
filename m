Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0E7C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 04:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7Ej-0003iB-7f; Tue, 23 Jul 2024 00:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7Ef-0003gv-Dl; Tue, 23 Jul 2024 00:34:49 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7Eb-0003h2-I7; Tue, 23 Jul 2024 00:34:47 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-708e75d8d7cso2878040a34.3; 
 Mon, 22 Jul 2024 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721709284; x=1722314084; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJqtxH+xLomgK6cyzTS1mP9hjGARTIHCrzsiwdkA8ek=;
 b=N9nOgI1uJigHwSaTITRKov2PNnl8B+fNQtyt0iQdIeVZXU3xQiwnHPnnIYsIlUAdW4
 67uwRowk3w3VNpnk4UqchtAHsU749pNKaFV30eWiGQCakkvXg57kGYIN9yXyEu7mlFFI
 iqp/GX7+G53lllSLNbQLJGYNJfZk+GI9xIMG/Jc3lGEKuP91CHv8iuoSBm6spCiCvwmO
 XoiXsANuaq9IqNLaKZvQZNGTEugMoyncV1JqguclmyYhbckJEFWmsP3pADp6JMobiBaB
 1aIWXALtdtIxYudFrpZUt0qr3VeKADoUeodzGh9lG3OSc4ifZtjJRFOdigTiwCe4bI07
 uNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721709284; x=1722314084;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XJqtxH+xLomgK6cyzTS1mP9hjGARTIHCrzsiwdkA8ek=;
 b=PCSkjgR12JuXiO3zfcCCnaxP8M66RK49Rd8zqnIBjr+MK6o4s9G9tCsQpPofLZXHLe
 yfhvRM7935Bhauw/0VVgzZZahSE25gov8lifPdYW1+JLuLiQjrsTkpYfCvK/ZVQJjd6u
 TndGhi7PgIgYVN3xegfu3BKWmDBG5NIzGOTDwsX9syeeJP4jyEQtYsPEUvGG8K/LEd1w
 UMk9KwKiR6mUb6ipVY9bQJvLDB3QXvrkypKEMr0fNxFRWhTgkEtihN+xj7czPVWXg8k0
 PLuu4JlGc1l0PU7bUTS3+Vtc6VyERUcgZQPjG8ixJ9EkhY/QnASC7dFBczskygYC8da0
 fi5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUShmHHdMRJNn6oFdrq7SqM6+4Tjo7anqGAFP4B37uA76GnlTlMivcWG8fQPqrKJvTkibPXXhBe6x9b8Ri2fhsH6BAT
X-Gm-Message-State: AOJu0Yxe4/QZiulXjY2rbffXo5oIdKMotblZcJVSvF+DiN+VoUWFxzhW
 8SmQg3Ato+qZ3gIs0P4zC10tP5kE+RzAs54ZyoImrkj5fm6e+xQ+
X-Google-Smtp-Source: AGHT+IG3N+5YYGWbp9IpEHQ9a7zlfFNJxZk8KviPYMFH2ABgsoTHG05K59i4skVILh8yoDs2JbTIkw==
X-Received: by 2002:a05:6830:6a96:b0:703:5c2b:9024 with SMTP id
 46e09a7af769-709008d11d0mr11064960a34.16.1721709283930; 
 Mon, 22 Jul 2024 21:34:43 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2801e3b8sm2595900b3a.212.2024.07.22.21.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 21:34:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jul 2024 14:34:37 +1000
Message-Id: <D2WN02YAGFCD.3MQREU9GFBJT5@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v5 3/5] ppc/pseries: Add Power11 cpu type
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.0
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-4-adityag@linux.ibm.com>
In-Reply-To: <20240606121657.254308-4-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x330.google.com
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
> Add sPAPR CPU Core definition for Power11
>
> Cc: David Gibson <david@gibson.dropbear.id.au> (reviewer:sPAPR (pseries))
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com> (reviewer:sPAPR (pseries))
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Fr=C3=A9d=C3=A9ric Barrat <fbarrat@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  docs/system/ppc/pseries.rst | 17 +++++++++++++----
>  hw/ppc/spapr_cpu_core.c     |  1 +
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
> index a876d897b6e4..bbc51aa7fcdb 100644
> --- a/docs/system/ppc/pseries.rst
> +++ b/docs/system/ppc/pseries.rst
> @@ -14,10 +14,19 @@ virtualization capabilities.
>  Supported devices
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - * Multi processor support for many Power processors generations: POWER7=
,
> -   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ =
exists,
> -   but its state is unknown.
> - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
> + * Multi processor support for many Power processors generations:
> +   - POWER7, POWER7+
> +   - POWER8, POWER8NVL
> +   - POWER9
> +   - Power10
> +   - Power11
> +   - Support for POWER5+ also exists, works with correct kernel/userspac=
e
> + * Interrupt Controller
> +    - XICS (POWER8)
> +    - XIVE (Supported by below:)
> +        - POWER9
> +        - Power10
> +        - Power11
>   * vPHB PCIe Host bridge.
>   * vscsi and vnet devices, compatible with the same devices available on=
 a
>     PowerVM hypervisor with VIOS managing LPARs.
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index e7c9edd033c8..62416b7e0a7e 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -401,6 +401,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
 {
>      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power11_v2.0"),
>  #ifdef CONFIG_KVM
>      DEFINE_SPAPR_CPU_CORE_TYPE("host"),
>  #endif


