Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0255C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 03:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN1WU-0006rc-S6; Wed, 04 Jun 2025 23:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN1WU-0006rL-01; Wed, 04 Jun 2025 23:44:10 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN1WS-0008Ar-IO; Wed, 04 Jun 2025 23:44:09 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-87e0ce80ed4so302005241.2; 
 Wed, 04 Jun 2025 20:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749095047; x=1749699847; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZthRI03lhm1xXiins+HboAPfbXOTy2WMtccb1/Hdeo0=;
 b=i5WKRBdkzEK4lvb5Q3Gd/SwLmNMErdT87g4SReOUuywx7cSR+ugo8iTIXrOs6MBw0c
 CQAZm5W7YRv2Bke7ZnuoJtcDyFjcI1219tUV+/EIEix7zZ2UwPAueDKpn/U4ERGo1POX
 VrRiieK+NR7Yd2ocav8jbpl3Hrq+JBDxBfwBvZFK/qnlHRvr0BiO3pB2bQ2HyGIsj7W4
 5S4z7ROqnLSana6gsfQttFivQn0V5vdbbRX6ACPaSYH13n30K9f9E2vPkiwTMhv6yq6V
 uSy/hLpzOVWVI8/oYS9G6tLtPB6t+8UmoVNYG9QqyrziLKPtmWavbr2HX/E5F5BZvkOH
 BPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749095047; x=1749699847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZthRI03lhm1xXiins+HboAPfbXOTy2WMtccb1/Hdeo0=;
 b=nPCUpgfdSnoE/wZIhWrG3soddSLetIUii5VMDsLRGAHUW8ZD5pt6fo/7CaZB0fl0Sx
 /ZrPQPRYpUel+a/OOoi6afYaGkhNbk+Tz/eXe5LLUDWZ4mV9ofXzSnXzBpxn6PJgbpOH
 gjRJjYbXcdXahWpRCRjy54YrZSd8FLQ9gSGW5STbEhY4sT3XuPk1OvU/bBGIiFhNnDA3
 qxcB9xyo6jnio7XoKQqtxhIVs2RCym3jusCcbIKKDgi7YpzqruQKdP+0lOOgYVTaD7wG
 55mW6AkP2lFUs6MAY7NMl6RbZoFXgem5ldLwWCxPini1yqycX+4UjtwYp5qfTBIZaEiI
 qRmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN5+mYzYDi14MAnDQ6b1w/n7//JR+SSIgEghujeOIRLZROBvmlEAtdMIZq16mUm/uXB9tWZjFmZ+yv@nongnu.org
X-Gm-Message-State: AOJu0YzGNuM4+nO6YhBoZgXWfmajb+GK0iqHvJZC4SWfh4FEhNjCkoP9
 /UkDw/bTuJsB+iuBw3GuqzVFu8VIT98KtU9lC+xB4cHUXDhGGwlKIvSCf4wBJIpIguHMjhTglLH
 O8BQqBuUMjWW7s1qVJ8KmmJSEgI06M3zpXA==
X-Gm-Gg: ASbGncsiQff9ekp+T0baqsulIkULWkYDrXuPt22mvAbmN6iON2Ceyn/U9qPj95F0da1
 ZU934CAtYVAyUYUbEmriMhRzESSLFVHf5u5LjePeNCEh2Eav9l1Y8CHYHTz+ADgjss56pmZCcwx
 /vs070fawkRWm5G/jlLuc8gdUq36xhuxFzU3IrxceJFKnKa8nRh4BeSPblugOhxb5B/mTc4aAS2
 A==
X-Google-Smtp-Source: AGHT+IE0UvuFiZt7W7QCbD52doDBhsWKiv97YrQdmKToOzYAIjZxS1U3I/k9gY/65PeSmv8ZFKrETOs5LgN3g2G0IyQ=
X-Received: by 2002:a05:6102:b0b:b0:4e2:82c3:661c with SMTP id
 ada2fe7eead31-4e746d8c858mr5129041137.11.1749095047067; Wed, 04 Jun 2025
 20:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
 <20250604174329.1147549-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250604174329.1147549-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Jun 2025 13:43:41 +1000
X-Gm-Features: AX0GCFvr4LpLF4dh7pVPVAlIviAYVQo8Bngj7ckbhQtPV9ndvdYjqKIOBvfcw1A
Message-ID: <CAKmqyKNxaeFKoX6yO94e7QZApNuDYcdjOrZVCprrz-=3MfeJLg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/3] target/riscv/cpu.c: do better with 'named
 features' doc
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Thu, Jun 5, 2025 at 3:45=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Most of the named features are added directly in isa_edata_arr[], some
> of them are also added in riscv_cpu_named_features(). There is a reason
> for that, and the existing docs can do better explaining it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Message-ID: <20250529202315.1684198-4-dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c1bcf60988..758f254c15 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1378,13 +1378,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experiment=
al_exts[] =3D {
>   * 'Named features' is the name we give to extensions that we
>   * don't want to expose to users. They are either immutable
>   * (always enabled/disable) or they'll vary depending on
> - * the resulting CPU state. They have riscv,isa strings
> - * and priv_ver like regular extensions.
> + * the resulting CPU state.
> + *
> + * Some of them are always enabled depending on priv version
> + * of the CPU and are declared directly in isa_edata_arr[].
> + * The ones listed here have special checks during finalize()
> + * time and require their own flags like regular extensions.
> + * See riscv_cpu_update_named_features() for more info.
>   */
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>      MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
>      MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
> +
> +    /*
> +     * 'ziccrse' has its own flag because the KVM driver
> +     * wants to enable/disable it on its own accord.
> +     */
>      MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
>
>      { },
> --
> 2.49.0
>
>

