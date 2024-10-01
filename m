Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008D6CF3189
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 22:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svlIm-0002Eq-Nb; Tue, 01 Oct 2024 18:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1svlIl-0002ET-Fh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 18:25:03 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1svlIj-0003lG-9V
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 18:25:03 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-82ce1cd2026so223449139f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727821500; x=1728426300;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wx0YiWPvD/PUn+o4IcJHRE40SNinP2g1PiGJiVSYyRA=;
 b=VaBSVc3BYj9eV8H+6okKwA45iLGFAHul7xzQIqmjdgiBhnZUaYVCVS3eG41szYytgd
 /Y0iPjrcwv8+DLw7sTem+aL+C9kjBQFA5WJ0Ak6rxUl+Z4r+YtFFi9YZfNMvNikc5FF1
 E6vO00A1UK6p+IIFHlCJs9pAIdlsU2Ui3x31d9gKiYe7FH/wTcgN4RDEx2zemeO9qeBO
 NgcuvHYQ1pKK7wRYZP5Tarzmp3hcHj1t+C+inR4ep6DP1wzD3bylwOKbN80MN4F2dFm9
 S+rL41QO8jH4BjIVDll4Cgfge0xDND7Ivpvkl/TRykAwhfUQx0XS2SDbreUmxszs8Fyo
 JFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727821500; x=1728426300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wx0YiWPvD/PUn+o4IcJHRE40SNinP2g1PiGJiVSYyRA=;
 b=BHhtgM/db3bwj1yPAY26Bn01Bwalg83qAfesNrmI0HTnASqJO0l1q2YplO2NtABLbF
 LyDGpyu3aC77A8FmKyWxR/sFDpogoyq4R9hyikLHImt/3QzWtgXwIaYbgn/1rdR9Swk5
 xQo8ngjAyUs0zWc++uinOVaL0nHh4BrP7v6ZlJvDifB3eJdw3Fp3uctOC7sOZk5OEmkh
 AiqvFsewTEjwF6hrr70tMeXIySkLfuPrCwYac24GbQNi+/7QD9cl71N0VzFc2hMQhQ1d
 ZeC8BSv58AjnF3LW2A9N+FYrV21Pru1FWCrZZJ0xiEQXnSYbHlnfHzU4s0zbCpnfNALY
 NClw==
X-Gm-Message-State: AOJu0YwF2crqwVepplLHni5gA9Qp5Ft7TUDCvfQUTsb+XsxDc7t05F4g
 cX/xn1MiT7MUDSOPz/IR43K9uG+zHTN4ELZtIqgBxxF+7LJf/XZFpcD00+U2KXzqxzXwvKLg2hq
 bX4eCbRUBbXhr3CrnJ6hwyB4s7RG3Tai/2IIWnA==
X-Google-Smtp-Source: AGHT+IGUvRbKyZT90oa/Qo7HSk41kWi8Ueag/86AVpldNT6hzv9JbYaS34203VBZJEB3/7DGwrV2pjXSw3N+MP0MVX0=
X-Received: by 2002:a05:6e02:1aa6:b0:3a0:926a:8d31 with SMTP id
 e9e14a558f8ab-3a365964af5mr10398885ab.16.1727821499820; Tue, 01 Oct 2024
 15:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <20240924221751.2688389-17-alistair.francis@wdc.com>
In-Reply-To: <20240924221751.2688389-17-alistair.francis@wdc.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 1 Oct 2024 15:24:49 -0700
Message-ID: <CAH2o1u474YJPaxkA24-JE5XpuF=3UnOMP2iWHbCu=FxTf_SvNA@mail.gmail.com>
Subject: Re: [PULL v2 16/47] hw/riscv: add RISC-V IOMMU base emulation
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Sebastien Boeuf <seb@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=tjeznach@rivosinc.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 24, 2024 at 3:18=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:

> +
> +/* IOMMU index for transactions without process_id specified. */
> +#define RISCV_IOMMU_NOPROCID 0
> +
> +static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec=
_type)
> +{
> +    switch (vec_type) {
> +    case RISCV_IOMMU_INTR_CQ:
> +        return icvec & RISCV_IOMMU_ICVEC_CIV;
> +    case RISCV_IOMMU_INTR_FQ:
> +        return icvec & RISCV_IOMMU_ICVEC_FIV >> 4;

Please add missing brackets to fix operator ordering bug. Here and for
PM, PQ cases.
It should be:  return (icvec & RISCV_IOMMU_ICVEC_FIV) >> 4

> +    case RISCV_IOMMU_INTR_PM:
> +        return icvec & RISCV_IOMMU_ICVEC_PMIV >> 8;
> +    case RISCV_IOMMU_INTR_PQ:
> +        return icvec & RISCV_IOMMU_ICVEC_PIV >> 12;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +

thanks,
- Tomasz

