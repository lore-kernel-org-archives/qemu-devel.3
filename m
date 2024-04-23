Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F5AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 16:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzJ5o-00049e-L0; Tue, 23 Apr 2024 12:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1rzJ5n-000498-1y
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 12:34:03 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1rzJ5l-0001PK-9A
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 12:34:02 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-518f8a69f82so7088686e87.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1713890038; x=1714494838; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3JM07lnpUoNLbh9z5M56/L9GuYgZeYjNXzA0bB/EHo=;
 b=JxeNIuvxQJwVn9J0dMPr+azDIHHt3R2YasUuimXTZqsLKZMi3gdz5IcBkJsZd/pcsi
 gvAjL5amj99TryIgKFRJ2eJpiagyn2Yf/syA8Pqzw4XHx6rLB1Xi59ftWhWJQDktQmoG
 pjkNT/JmdlOfDJHdlW4LTsBcklzvPziVd63Z5fxGMPjmAOCDiM1sXBptRION5S2VHmaO
 IJFj/f8tAZLNX0Xb5Lj7gn8/3HyFzPloSsFTPWu0BvPo/4xqCIdjExbPXvalpnBfBiBf
 dbj+JagJZxRy8UjRBqwlwzgCP105TyBG0F27xm/SNCP7OJZOoUfPzxG28m+e3Nx2t2f4
 jJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713890038; x=1714494838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3JM07lnpUoNLbh9z5M56/L9GuYgZeYjNXzA0bB/EHo=;
 b=nEO75DckpFnEP3huSd9zcIqccqTKfzs9j/a6B25kwpbuKebx95YrLK9G2wteVpTR6L
 68RWj5jEMh1o7yvJPl1sXkPjg3iP3LuG3V8g6aFc3FCQ0O3+baemSRADmD5+vwPgPXhn
 FB8u535R2vpqvBAQhHosGXpU3LkqvM8b2ds8vrhG/sGjPWVnkFDLAEOW1gAdAmeIl4T7
 Vuw6gCQNsY6+3hDsqN5yMNUmH2xwfOEbWs80Zk1571kDsIrb9vua9yobyvC76OARWXx6
 lfWSEX6XSO/VGxk7Qh46gK2thmTRYdGqHa20Av0nP/52fvStagrEMnP0aRkwaR6UA7dn
 +9IQ==
X-Gm-Message-State: AOJu0Yw/fKJJJemH2f+6+edBaSbAngcP0QLDH0ASlIhyYp95Nl6qEDhy
 6WVZ0SETuRbjSzsrKatL33mL8VdnA070685zzzNNIPEA1OFEyRfcJOCbjBTYMvm4iwckFoXoKkd
 PTY/JMZ91sjU8usq6ELLcoSXQniA6OzBJI/X15d4Eag/pIiZ8YtzkpeoxZuoVLTDDqNaeE03ji4
 OT0NOXwLn8v4w9ljzfh5TIAfJGkAAbsIJPHJuWogLIHA==
X-Google-Smtp-Source: AGHT+IE45Vx8RE9YX7zAGUW2SrmmTJ+sA8NU+gsV9kgYVxDVDF84RaXBK1zaLblIhIU6jIKIMzg0ig==
X-Received: by 2002:a19:c207:0:b0:51a:c28c:4d01 with SMTP id
 l7-20020a19c207000000b0051ac28c4d01mr56724lfc.15.1713890037562; 
 Tue, 23 Apr 2024 09:33:57 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172]) by smtp.gmail.com with ESMTPSA id
 h9-20020ac25969000000b00518e44b5d4dsm2068947lfp.98.2024.04.23.09.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 09:33:57 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2dcbcfe11f8so45802621fa.2; 
 Tue, 23 Apr 2024 09:33:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWjRmBBj/3mHbKF9bTMnYrn7IP7j+kyOUTUz2SMSIL+6C//6TcTMKel3BVQMcwVoXLjMYFzbdZhxApgGzbbr48BJuTdqOU=
X-Received: by 2002:a2e:9a95:0:b0:2da:9f24:44a8 with SMTP id
 p21-20020a2e9a95000000b002da9f2444a8mr9503460lji.11.1713890037092; Tue, 23
 Apr 2024 09:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-2-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 24 Apr 2024 00:33:45 +0800
X-Gmail-Original-Message-ID: <CANzO1D0q5nv7TAWkTS03CaNFS7visaewDS4Of5PzWxA+LdhFvg@mail.gmail.com>
Message-ID: <CANzO1D0q5nv7TAWkTS03CaNFS7visaewDS4Of5PzWxA+LdhFvg@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] exec/memtxattr: add process identifier to the
 transaction attributes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Extend memory transaction attributes with process identifier to allow
> per-request address translation logic to use requester_id / process_id
> to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  include/exec/memattrs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index 14cdd8d582..46d0725416 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
>      unsigned int memory:1;
>      /* Requester ID (for MSI for example) */
>      unsigned int requester_id:16;
> +
> +    /*
> +     * PCI PASID support: Limited to 8 bits process identifier.
> +     */
> +    unsigned int pasid:8;
>  } MemTxAttrs;
>
>  /* Bus masters which don't specify any attributes will get this,
> --
> 2.43.2
>
>

