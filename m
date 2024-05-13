Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98090C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6T0q-0005wc-M9; Mon, 13 May 2024 06:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6T0p-0005w5-D5; Mon, 13 May 2024 06:34:31 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6T0n-0002lQ-JK; Mon, 13 May 2024 06:34:30 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-47eefa04398so1381053137.3; 
 Mon, 13 May 2024 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715596468; x=1716201268; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyRn+Q+jmo/xRbzvW7eKVofrTxNguEp+Ib1kgRUJ7mw=;
 b=NDByqmG+4p+tQRIhRHL8iNjYdCnpEy7NfMpb9HjTr32bMMddcoDVo6mT7aSJugQVJa
 1Vu18gzLCrqVI43UE5RdkyZzh5LfvKJDqyVlV+X512yKAQUPduR2Dbt4EWhn7JzRjRL2
 hxuOyz4IejdcW6auls41rcV7t/Ij4JnujMZTg/JeEBUXO8N+rQZySXZer8BONEZDsCHX
 81fB/dFh9fqD4PFXO2ICHvcrCu5L8qzFcsyLvLofMcqGsG+sMKNATsgiWmvyQMyT/OiF
 gipG3sMajM78nF4MLeSiwTrO7mGjkaEL6az6PuCkT9gkHsuZOvmEICxZUy5XxQErwetV
 KCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715596468; x=1716201268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyRn+Q+jmo/xRbzvW7eKVofrTxNguEp+Ib1kgRUJ7mw=;
 b=nA8i3DRKujnwjadm5qih1kqdCxyVSfREZBSRJUT/B2WyiUdbyaq2EH3K5d6qVx9EFl
 vHqPm1LsUPc3BAcl/6tkGebtXN2+iT9Y9EYvxWBoIpcfGxzQro/c5nbW5RW6xrQMo1aj
 vW8s4LtJu4zLdkf9hUTSnPFXol9aCEYLxvZgBYMLud4KtAg8IPAV5mVqZKiRlBE1T02n
 OVboO2RLUjvuoasbnGNIjPOKFjfpYDO4JXMa2jGZYpB7SBH0ZhN0Fnaf3JLJF3rQwIoN
 J+Nr6gOwrSJYIbNgFUoEJQ2MoNGOeSwY4vv0K4SPLFMDPH8YMLtHFIPkHflBRcicJS09
 P1uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7sBb6sCZcoRAf/dSVleNK4jE7AMxaG9s6POYvbx/q/9OUgwkrUkDwu/JkVFDxKxHmFs4JywWKZBOsoPP1yCRmk6ocX/o=
X-Gm-Message-State: AOJu0YxWYE2IVITG4bE9DWtbdhSOtYijm8q/dP3Tx8LQWSCfPLgusjYU
 KMskGClK7iqn+ZNgCb7VjNL+wUCUn8WpXZ6TUv/ZlR0qsaj9tlhfKlyckcK8Y8ucxPadygMWMRk
 qCUKz6QqTFINw218UzXnTrbqkubQ=
X-Google-Smtp-Source: AGHT+IE8nrqVtgzLRKT24Sha8ldGyYKj5cynOygg8sqAZVInQodGgxbe/KGPdk6zRZm0+iZzhs6wFw3XeYEge2e6QSw=
X-Received: by 2002:a05:6102:3c90:b0:47c:2926:6212 with SMTP id
 ada2fe7eead31-48077eb7262mr9484449137.35.1715596467229; Mon, 13 May 2024
 03:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240507102721.55845-1-rbradford@rivosinc.com>
In-Reply-To: <20240507102721.55845-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 20:34:01 +1000
Message-ID: <CAKmqyKPWk2VK+LpBsAkzUOZ5Rh6tSyBuNoTKnASVE3bhHqCR0g@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Remove experimental prefix from "B"
 extension
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Tue, May 7, 2024 at 8:28=E2=80=AFPM Rob Bradford <rbradford@rivosinc.com=
> wrote:
>
> This extension has now been ratified:
> https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
> removed.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>

Just to be clear, do you mind enabling RVB as part of
riscv_init_max_cpu_extensions() as part of this patch

Alistair

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..861d9f4350 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] =3D {
>      MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>      MISA_EXT_INFO(RVV, "v", "Vector operations"),
>      MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> -    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
>  };
>
>  static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> --
> 2.44.0
>
>

