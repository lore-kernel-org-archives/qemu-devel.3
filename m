Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4CAC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 07:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTKl-0001PP-Sr; Mon, 24 Feb 2025 02:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTKk-0001P0-VI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 02:56:58 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTKh-0006d0-7P
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 02:56:57 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-471ede4b8e5so20911201cf.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 23:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740383813; x=1740988613; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0H44uaZel0YwtgrX8Da3ncQx8kVGrBB827ev2xiSjVU=;
 b=TnLj7NkVc0jBUP8pyB1S1ws6D159/j7aD1zKglHPSP4az9UIpuh2XzQBxcGmnWrQsS
 ai/2xkOAychwuzZmYTzU08WzoFO1kQVpUBfAgM+FKeoPx1fxgBztiavdoWOJ0u2u5ECG
 ZulEVF2XJEAqGPe/08E0ZakVvE5MxxxBXmGO4Y6vqaeGNduHOjsRpVyK/4XGrM7nl6q0
 OwbDRxjrn6YbOyY/h5Lou30QEMlae3Nc178cc1qINvAMAJFSJ8bp8O9TDcDKJOWIlq6M
 5pej0HEFAousWe8qoKrYWgVNtUvbdGSpRam9j4uBrMJvKWf/2qWdNt1nBfiVcH8tmEvQ
 3VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740383813; x=1740988613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0H44uaZel0YwtgrX8Da3ncQx8kVGrBB827ev2xiSjVU=;
 b=TApG5GRgRJY8/0NU0tHQ4lRULaYOhLOvvUxKtCJYGBrYmm9PFJe9tsyuM5QA8RhqE0
 Vd/vCg3D03psKn4WkB6Qaw/7ac8eTyAckiiK2zygD9Xd1h8naSBHNxPpcZnMugvF/RYL
 wO+inxF8njuB20HwJ+4SkvpmiD89KgaM22qB294hJ7oXrPX6mpOfU3Rf6UQAiiagqPzI
 pKOK/nna4kxF5+jQOiNsg8quPTjJ9iEnnGPhRiwgap3nyaFiyx7xBPvGrkxmU/RVzA5o
 dgNqVFT6J6GD80BmMLyVq9y6YbUZ80iWqFUFJDC2/inS1sbR/7PcosCIhQw8l85PcSvp
 qXNg==
X-Gm-Message-State: AOJu0Yx4NJbjYf9BiyVnqAtNOEx7RqWdNMViFpdr/MnKw6klY+0h2X4e
 iYshHR84w4gbJhG8zkaAWu9xzW/Q19Htm1OBVISMtJOdkYULollyizgMXv/MXaOF+9v2SleAwA2
 vtW6QlKgsm9yFfOO4YBnH0E7+kLQ8vShKtUN62Q==
X-Gm-Gg: ASbGncsJIwmt7IDTYTh4cDnsKowmwkhpmJSp40mbEHg7FjG9uCCFk5j44CCDRhFfsq+
 GbnxB1lKYMo1sGOWd9FaVfTmr96X3herCoAh4qqMm66Z6E2WhPNF53BMJ/rsf7cgNjHa89niqCB
 A93fq7LPZLoQ==
X-Google-Smtp-Source: AGHT+IFvXLRqrrLahMh+nA+e87vJUGwcaiLd2HH6Qu5wGlqbc4j/SOx0YSKJfuFdH+AE/j78+oywJpfHRd8ZRLs1Y1Q=
X-Received: by 2002:a05:622a:1447:b0:471:9b3f:2464 with SMTP id
 d75a77b69052e-472228dc9fcmr166270121cf.31.1740383812963; Sun, 23 Feb 2025
 23:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
 <20250217081730.9000-5-yongxuan.wang@sifive.com>
 <20250217-d6ff55e1f04b68643ae8295e@orel>
In-Reply-To: <20250217-d6ff55e1f04b68643ae8295e@orel>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 24 Feb 2025 15:56:42 +0800
X-Gm-Features: AWEUYZl7vWFacCvZDaCFyIiguvyNwOSFkPxEFvEgGamnSxOdcKOkq3qZqtfXwrk
Message-ID: <CAMWQL2ihmaRfkqDtr9Z6eeh=fCMZb1TqSk_h0AoeYxU1g21_sQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] target/riscv: add helper to get CSR name
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qt1-x82e.google.com
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

Hi Andrew,

On Mon, Feb 17, 2025 at 10:01=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Mon, Feb 17, 2025 at 04:17:24PM +0800, Yong-Xuan Wang wrote:
> > Add a helper function to get CSR name from CSR number.
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  target/riscv/cpu.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 616c3bdc1c24..133d1852ee1e 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -920,8 +920,12 @@ extern const bool valid_vm_1_10_32[], valid_vm_1_1=
0_64[];
> >  void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
> >  void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
> >
> > -void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
> > +static inline const char *riscv_get_csr_name(int csr_no)
> > +{
> > +    return csr_ops[csr_no & (CSR_TABLE_SIZE - 1)].name;
>
> Shouldn't we assert csr_no is correct rather than silently
> truncate it?

ok. I would add some assertions in this function.

Regards,
Yong-Xuan

>
> Thanks,
> drew
>
> > +}
> >
> > +void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
> >  target_ulong riscv_new_csr_seed(target_ulong new_value,
> >                                  target_ulong write_mask);
> >
> > --
> > 2.17.1
> >
> >

