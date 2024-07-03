Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F85CC30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 00:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnsR-0006Hz-9z; Tue, 02 Jul 2024 20:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnsQ-0006G0-HE; Tue, 02 Jul 2024 20:29:38 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnsP-00075B-4k; Tue, 02 Jul 2024 20:29:38 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-810173a1d0bso146149241.1; 
 Tue, 02 Jul 2024 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719966575; x=1720571375; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tx6y204S3b2wGrsGYq1RaevGdDamghgKBfKhydjQ3Ao=;
 b=Oby1mjUoghbi+ZCtQoR54JrGCfezS2CZLSVgM95kW+RyT8blEPprLP/Po1XlxjxIl7
 JDo4cfIVMBtja7lOe9ZCf6OCqNcaDT/WUJV+7hGrBCWI7gGfmCPICG8KDJp0Q18HxkFj
 2rHStSv7BKXi0tcDAp/YtBJzKvQPv/+zhnyXUxpfF4XQBM5BoXTI21pZYCHB60zUa64z
 pkWnPzwcbosLTamv1UhCIpNHFY5PdBqCQadvOJ90rYxFNIT6EajQncDAOWoArbUkuOZP
 Y0Gidp++2Ygg8+7QhmgQtI7/U5GwHv+zqQm5Nzko5SfDmUbUtn9iqFr/rqxuDn4zzzSu
 77Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719966575; x=1720571375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tx6y204S3b2wGrsGYq1RaevGdDamghgKBfKhydjQ3Ao=;
 b=sz7KLyUig6fze+MOsQ3B7DqgRmDrld/SfpSlljmCdgdCGUWIRf8/2SQgKq9UD2eOoP
 IB2yJuqyQAjGvhvEDI5f1YSr0bFKFRsqJGN/bF61VcigvGGGYghBclQbaL1DXGsLXclJ
 W/v9OUDQO4D3G6qssn41oFfYqvLg6vRGXitUsmx+r8pLn36vtuxuUU9vBu9YK23FGFtf
 OH+4T/zdSur5OSJrNieQVmyOHnMs/OXH9G/EnrfBoNdn4RzrMpy1v+5+1TLKPRLEO4T5
 V6PlGx50JNQ7lhQsMyfQAQBVB2bvggVu/siZuGkoRWSoZ3DA/LQ6BvIN2jExXd7haN3G
 ymgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXle5FcPuJpY9tg3Jk1Bml0mZ0Qx4d746xetvLs8s45DlSIKPl1Cq750lTdndV6R1GyW7Ydh98LxfQ5YjU32X1dcacXVFo=
X-Gm-Message-State: AOJu0Yxui2El0mpWeyKmSF4KOiCnyWt3xs+L9bDCr4Iq84Wzhpv4wj1C
 r1sje9+DIqBB+rkbpYG9Bqs4clbj3pv708Ke7KxzkHs6PosSKwdaqWbRh0LYKntqG9PkvN+HJb7
 jcS4ro6fCLhrFYWEUL+04vhXD2BE=
X-Google-Smtp-Source: AGHT+IHFmmmT0uPs9a6T3b+UgG7DDXPSrRkTTNIV8I9MLXafeTqzb3d3/gb2KESJhYmgRmZIntOTbNj2t5TDY0SAE0o=
X-Received: by 2002:a05:6122:478b:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-4f2a56e6f1emr11566222e0c.12.1719966575633; Tue, 02 Jul 2024
 17:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
 <20240630030559.877-11-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240630030559.877-11-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 10:29:09 +1000
Message-ID: <CAKmqyKN=8hHSrTNiK5OiUXvX3ma=NYkK4_QXfczQA+6J_p3tEQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] target/riscv: Enable zabha for max cpu
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Jun 30, 2024 at 1:13=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

This isn't really max CPU specific, it's just exposing the extension.
Do you mind updating the title?

Otherwise

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5219b44176..8cd52e6801 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -117,6 +117,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
> +    ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
> @@ -1478,6 +1479,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
>      MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
>      MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
> +    MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
>      MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>      MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
>      MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
> --
> 2.25.1
>
>

