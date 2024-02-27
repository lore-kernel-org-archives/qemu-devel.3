Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DFFC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuVq-0002Im-U0; Tue, 27 Feb 2024 05:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reuVm-0002Gg-D2; Tue, 27 Feb 2024 05:16:34 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reuVk-0002Yc-Rb; Tue, 27 Feb 2024 05:16:34 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e4ca46ab04so2419908b3a.3; 
 Tue, 27 Feb 2024 02:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709028989; x=1709633789; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YgmlfO+LcGqdSIv++XkkpSprmSjpq+Zmhi8g37iXdU=;
 b=M48MZgzxeOLjGA/CsouWgn1gXvUcH6KKeBwHYudkLUcB3V81/9PEcymTrwYFGwTobz
 pnX6FB9ReC9t3YmsMxwE/9WNqd+PmUfBnDO9S/qLifPBklzHDfU/B+2F0GjONfEBwCya
 NugnZ9+b/juFkeVkv4kVgqfjt3YdgV7vPUOww/EAsCBUlgLOGbDUK0XDSWj/ikGyY8k2
 EDvS7z3snn7v5hurg8550gDywJPrK8hosv69T2Rovmoqq/EvepYa3Yy5v7UjxLc2IcEd
 wQ3eT0+d76ATRSYcyKaAFeQ6r+C0RCjKiDHw8+SrnwWBLFIgzBHCnW/jTaGM24xlAepX
 k0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709028989; x=1709633789;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/YgmlfO+LcGqdSIv++XkkpSprmSjpq+Zmhi8g37iXdU=;
 b=tj9rEXfZ6CIli18u/XR/fGHSEhVoRtzYdpXtPYOyv7e1pELZfbU+oNZohEoMrKjMAI
 skAxBdhersqYxq0JbL5zy8Y8REYCvhd5/S33CDC6aX/vbS2hUCyI7hSua9A6jnfRwJ2s
 8IxvZFnmcgYGgvmoh0dORSQ4oq1AKQMf908lrUbCttU+APVfJsKv+ob6LY+cmnashl/5
 FFKjzykSwTyRR12WtLXQY21+G26LAssrm6mRUSvvrKlqSvM6biR5qYgvUaDLXXzulP8X
 B07XwTg2GeKo4TcE2D8/F4pUcW7zlHGVg2G5fOijRcuF3RNegQEiH3lHEZRVCf6zEL8d
 EIJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDxK3/c2XJHmmTtDDdDEfxrSoDDC7KZbfMX9w1c2WU1tIj3wt2YEyhdSn+grLhVnxQEw7CPil3Gvj82Fno6HTBG6R3uEJvoTedU0yQzbswRlpA2TeAIn/dsWA=
X-Gm-Message-State: AOJu0YxBAqhACf5Vh/zaIzqkReih67ITjgTHpZr9YT/MPq+7mgq6TOxU
 H5etcWbdHrBxQxCZZmSSsGQ+cFzriEbtkrpsZujjcBl3WeX961OK
X-Google-Smtp-Source: AGHT+IHJHup29eL9tlDzFqbo2FdfQO+ir3xCdcZeqm3qpLzX6mzkAf13hjv5Eg1PgF8zt4ITW6LYGA==
X-Received: by 2002:a05:6a00:23cc:b0:6e4:cdb2:636f with SMTP id
 g12-20020a056a0023cc00b006e4cdb2636fmr12771032pfc.4.1709028989401; 
 Tue, 27 Feb 2024 02:16:29 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 p18-20020a056a0026d200b006e45b910a98sm5576251pfw.6.2024.02.27.02.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:16:29 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 20:16:22 +1000
Message-Id: <CZFS7NVV22F1.11DDO9RYBJG5P@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 12/15] spapr: nested: Use correct source for parttbl
 info for nested PAPR API.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-13-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-13-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
> For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
> partition table info, use the same in spapr_get_pate_nested() via
> helper.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr_nested.h |  4 ++++
>  hw/ppc/spapr.c                |  2 ++
>  hw/ppc/spapr_nested.c         | 20 +++++++++++++++++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 1b7e55f12a..da918d2dd0 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -511,4 +511,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spap=
r, PowerPCCPU *cpu,
>  void spapr_nested_init(SpaprMachineState *spapr);
>  uint8_t spapr_nested_api(SpaprMachineState *spapr);
>  void spapr_nested_gsb_init(void);
> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cp=
u,
> +                                target_ulong lpid, ppc_v3_pate_t *entry)=
;
> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
> +                                                     target_ulong lpid);
>  #endif /* HW_SPAPR_NESTED_H */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 51a1be027a..3453b30a57 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1379,6 +1379,8 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vh=
yp, PowerPCCPU *cpu,
>          assert(spapr_nested_api(spapr));
>          if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
>              return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
> +        } else if (spapr_nested_api(spapr) =3D=3D NESTED_API_PAPR) {
> +            return spapr_get_pate_nested_papr(spapr, cpu, lpid, entry);
>          }
>          return false;
>      }

BTW. I would change these asserts to } else { g_assert_not_reached(); }

> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index aba4b25da6..0edb362709 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -52,6 +52,19 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr=
, PowerPCCPU *cpu,
>      return true;
>  }
> =20
> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cp=
u,
> +                                target_ulong lpid, ppc_v3_pate_t *entry)
> +{
> +    SpaprMachineStateNestedGuest *guest;
> +    assert(lpid !=3D 0);
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    assert(guest !=3D NULL);
> +
> +    entry->dw0 =3D guest->parttbl[0];
> +    entry->dw1 =3D guest->parttbl[1];
> +    return true;
> +}

Asserts should not need to be changed to proper error handling, right?

Thanks,
Nick

