Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44193E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgLK-00064j-Cr; Tue, 03 Dec 2024 22:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgLI-00064P-MU; Tue, 03 Dec 2024 22:46:24 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgLG-0004Py-HI; Tue, 03 Dec 2024 22:46:23 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-85b95896cefso889103241.2; 
 Tue, 03 Dec 2024 19:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733283980; x=1733888780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dLC9YfyDxuP78IdDcElXDEKd5mKRw80uiCLCTNM3Z4=;
 b=a0cc3aYe0x59xNRyGj1obCGbaA42u2hCMJB9p9IxWhj8hYqkvALZWILtCuNHWzF6Ey
 bcNao3wStqsASSWMYKEKGGiQ1p90uoTanEay+2qSMYTo8ria52SNDtXN2UnuaAsxKl3b
 /gbzvqXjherPKNKbb65GFgcMOnxbs6xxDq37amneIdtGKms8SS3lcMHkQKoZArO77gaL
 jmOWxBtFUqEZHSTUYPiJtFjgFzWjOOLZiCZY/tSLA87gGyoRbNWp8Ba+Er4JMeUL0uUJ
 +QmzPz4NFfS2hpIhGEJ1gug9GCB7qwiGm0MYEWZ1DvZQtCt4b7CSAC0GWOxUrSW8WXlX
 1QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733283980; x=1733888780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dLC9YfyDxuP78IdDcElXDEKd5mKRw80uiCLCTNM3Z4=;
 b=PsSc/KoSLsJBneUt8xzXdyHvE/NIZsvCVMfwSw6hJ1bl7JWKz3vl6NIGtVxc+ponjs
 Zm5Eqm9o2V8DvRLn3h9dJpZ5H9LkysoeDT1uw8foD38ih/oouf5R7aKCj0kSmkcijBr0
 C7I1j+gd+GRDdEgw/Td4FDl9XD+tnRtFeDQDfN4Bjr20B4O8Euu9xx9Iy3EBGajSR7Gp
 0409Fu5aP1Suv4fcBxp1mXiY7fgu3bISUNYJWfuY0uRknTKInzNY7zFuFccwiKu1LbT7
 qdhi8m0QVwAouKR6UtRrjyIGT+GiDXQZn3DYGDtdYhdvSrv6l2i7xU2UQQ4rmmSHLO9w
 SXoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq5A/Er5aNmmOhYRjL4VtsshkrHnmf0JLGx/PMShm23BERmtEk5FyaFv2mYAAlBm0SvY8uzT/dgypn@nongnu.org
X-Gm-Message-State: AOJu0YxxcLplVXNmeKugffzUQBMYNQ1BgETBvOoTq/mSJttg9Mcck9PP
 YUd5H2ysAuySi+rda0ecYQeGaKk331X69brZQxSjH0Zs9+uEXZqB3zfcO6OgU3FM9ANlNjSKH75
 6CkVkrLxpRBvR1qHZKmbVxqiUcq4=
X-Gm-Gg: ASbGnctsEF24f0aoodSiud2IqCLFsAI6Ncc1ju75dBhPNxlhVUD43lsj9j8hHisFO/i
 qvwaLXIRMFK4hQTIeI6c66OLpbPmmibm8
X-Google-Smtp-Source: AGHT+IFVMBLfur8G5KEstUbzvC/iuCAWOdp+X10amR9x3RIcm4m9s1ociMhyHM9yIxo/7hrBYgXsmZXO7lM9N9/PjmQ=
X-Received: by 2002:a05:6102:3046:b0:4ad:4fc1:5783 with SMTP id
 ada2fe7eead31-4af972388a3mr7520296137.10.1733283980587; Tue, 03 Dec 2024
 19:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-4-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 12:45:54 +0900
Message-ID: <CAKmqyKPECxbjVu-N3ryxK6BmLp-VL1O6i2u0_ADUnDYTPrZH3Q@mail.gmail.com>
Subject: Re: [PATCH for-10.0 3/9] target/riscv: add shcounterenw
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Thu, Nov 14, 2024 at 2:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> shcounterenw is defined in RVA22 as:
>
> "For any hpmcounter that is not read-only zero, the corresponding bit in
> hcounteren must be writable."
>
> This is always true in TCG so let's claim support for it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4ad91722a0..6bfb1b1530 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> --
> 2.47.0
>
>

