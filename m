Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD15C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 00:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwFw-00089q-RM; Tue, 28 Jan 2025 19:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwFv-00089W-NU; Tue, 28 Jan 2025 19:48:35 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwFu-0002aX-Bd; Tue, 28 Jan 2025 19:48:35 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5174d53437eso3559931e0c.2; 
 Tue, 28 Jan 2025 16:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738111713; x=1738716513; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6tnew2DgVFFKIJAEs5N01Y/fLiZdDy6HIq2f8o3AoU=;
 b=A38B0Qf+Y+T2ndJNzNcGG7I6bwWJLW7hPBAUjIcac6/0ZHskC9cxvgbQolH+WiBQ+E
 4Fe3PFoou6SI0ftQuG9E+LQAlbrV35jdr+BB8PZ03DHtlTBQRsoovPF7OucUiygtYReQ
 f5kHtUjGgaXDSr8DERzYfMhMYjdbDd6pp9NKOq0N93okE06fKSO2y3LjcI3dbsgMvfGR
 xqHpX2wb1WQk69FUkhhW+Js3sZPuiZzdCQiGNdM0k1yTeJPMJlrQ27pCPS66WJjDAgHp
 hKeyA6F35p2oq/09Ao8UGPApMgjdVO5xhdDTaCnDHMEmZ4E8RviifjG6x8FPmyEvY2Xa
 ZcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738111713; x=1738716513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6tnew2DgVFFKIJAEs5N01Y/fLiZdDy6HIq2f8o3AoU=;
 b=iA+lqNCZTFOp3uL4/zevn3OzxkAX0K6+qBVkkAUzuDc6GBHKplC/7u5p3xu6l7HG1q
 wvSgiD2W75rFj5eNwptgslcefG6FGgfPY/F/s7X1+0s/ea657SbgCKBB8aY1VV0tQ0D7
 l85buHD+FzF/wCLy6H0nK4AJ+xiS75UJaBMuPzNMyeMofUtGvKlZZEnw6DcUfrF4u9gQ
 TRvALL0j40dABsL7pjrHRGKa6rkVmxeUNcPSDVjCkz92QjWPYb2VsV8dxGPDN4vMY/6J
 WD/XFro58LOnMHXUwkf9awlFqI8WChfoN4KQm4NEHEi/O5uCN8u30k00hkVQAk+tJyDa
 0zZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/INhQrSTPB/Bizc/6uvvLhvyG+hmCDzTG1GrHU+2qH1p2CLT71bh1xjez5cB/2PV+GlrsX3JQJywA@nongnu.org
X-Gm-Message-State: AOJu0Yy1Szow1sY5qpiGY59vo8ML4gOA8WERc37qHxpTLbOBMkdRdaFn
 H2o0Gphn5zhaduYm3ThamwlfYbfB6Cci9pBb+w2413zJJwlTrXIDm9z1JIieqChbw+6t68mBY0C
 m53nG0eVG2/+cwzxKVM/y5hR8b9Y=
X-Gm-Gg: ASbGncuVOJj/hBGJYFfi/rdtHqm+75Wp25hfj7azv36m0g9FdC23amNFlFl18uq4KeW
 15zpu55VkoNn/FvbC5s1T+6OqsjI34X/sPfTuuKmIEjY2ejKEGVsR6XtDg6BqZ+teLc4m0H5Shb
 m2vlyRpol5nJmdLTxL416UvPgkng==
X-Google-Smtp-Source: AGHT+IEN0KV1tkGi9LYGCYEGf4x1mrDyzx3TsiId0Lu3OQVrUHa48R9yAijoj3x81AHTrtQ5kVbVq5lyqH71rsMxLvc=
X-Received: by 2002:a05:6122:a18:b0:518:a1a6:4642 with SMTP id
 71dfb90a1353d-51e9e519390mr1961059e0c.9.1738111712850; Tue, 28 Jan 2025
 16:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20250115-pmu_minor_fixes-v1-0-c32388defb02@rivosinc.com>
 <20250115-pmu_minor_fixes-v1-2-c32388defb02@rivosinc.com>
In-Reply-To: <20250115-pmu_minor_fixes-v1-2-c32388defb02@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 10:48:06 +1000
X-Gm-Features: AWEUYZkEyIHczy_be9Dlwa8uJxUMZpB_O5ReBOQuFppmThquTAaxt1PqDRp_Yi0
Message-ID: <CAKmqyKMS0DOnxX4A5QPViok0AS2uO3hbHY3fBEWYG1sLnGS2xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Mask out upper sscofpmf bits during
 validation
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jan 16, 2025 at 10:51=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> As per the ISA definition, the upper 8 bits in hpmevent are defined
> by Sscofpmf for privilege mode filtering and overflow bits while the
> lower 56 bits are desginated for platform specific hpmevent values.
> For the reset case, mhpmevent value should have zero in lower 56 bits.
> Software may set the OF bit to indicate disable interrupt.
>
> Ensure that correct value is checked after masking while clearing the
> event encodings.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index cf713663ee56..0408f96e6af8 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -390,7 +390,7 @@ int riscv_pmu_update_event_map(CPURISCVState *env, ui=
nt64_t value,
>       * Expected mhpmevent value is zero for reset case. Remove the curre=
nt
>       * mapping.
>       */
> -    if (!value) {
> +    if (!(value & MHPMEVENT_IDX_MASK)) {
>          g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
>                                      pmu_remove_event_map,
>                                      GUINT_TO_POINTER(ctr_idx));
>
> --
> 2.34.1
>
>

