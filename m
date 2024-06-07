Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8028CC27C65
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 05:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFRmm-0007sE-Se; Fri, 07 Jun 2024 01:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sFRml-0007rX-JL; Fri, 07 Jun 2024 01:05:07 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sFRmj-0002XG-E7; Fri, 07 Jun 2024 01:05:07 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-80b26f1cadaso565431241.3; 
 Thu, 06 Jun 2024 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717736703; x=1718341503; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHP7bSfVELwRPSMQrkzalt1IaT8TdTLBmjT9owy7zEY=;
 b=XgQUGZLgy1jP14iCf8UvYx7RSIHYXZNzLYQoKWa08HtUerrRwcz9+7jXP6fp+dEuI5
 zO5tm4R/T/pqgSuo/V7xmpt+/I/FtIuDXGFnw0wSZRh+15UgQbDN5HlhpOg101VQbhjC
 I26hP4Qd2rQsxxUC3Fi4FLVZsPAOf6XDRiFJAcN9H9Cokn2N8bHYNyVsquU/4e1j55uG
 lIypv9CTi/KVZtfVhokiI29mshzlw042XjOD9BdP/G7u1EbWeoBTk8EIhWkbZ3K0hcIl
 uJASmpHlsGjkRx0G84vHkFVuQ+LtIIAz6CCQPLluwMTZBFfsuXony0SiN4n5vCflBCQ/
 2c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717736703; x=1718341503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHP7bSfVELwRPSMQrkzalt1IaT8TdTLBmjT9owy7zEY=;
 b=veOTlTfJWE4hEbbFt7Og6ZeTEt7Kj2CzVuEL3Aggs7ujyUrhMJgGIW7x3wvFsK03xR
 wXy+XUNZdxa7ym26NiXhv7fV3f0kH3Myh3eCtaCPBDH2JmRJYIp9S/4vyy9F3Od9cWBO
 jPFDkEFKjuZ+CWDO89CSIlmHViVV3m2ttgGRI2j7wvzsLGiQcoClUzbFSuv9if98lyEG
 iFbevLbR7qJ40ZpQ/gK0DOqa+ZXftUeb3X0qMXxJS8DRKMPzUIrE94JNhR8Z3YcGkANY
 Tgx4a9xTitx8c6PTtQlaplM4y2tqx8JEyU4aseOddxmDuFm2ymHG0XpPYOV3Sgi598Wa
 aCeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcSLDLCkHTtGjNT8uGUxhoFPJBXgU22O1Nyx59/EMvLqjBs0qyWCszlAG5JKzbW4j4fO4dECalL9QPS5VyRFgHgQaoNeI=
X-Gm-Message-State: AOJu0YyCZrTELrcRv4sYo9sK+tNDu+6GD0qJmjuLGysShvjJYBKoHwvW
 tvgknPBq5GXQw2hmU+95CirNDIxPBiDaVxPJ3BHJvpGZ7Nc+7kbnA5QtvQXXNJXQtzKhn6zaOR6
 sXv8ZS7B0zGy9FDi+EiaQYgHx3b8M/Q==
X-Google-Smtp-Source: AGHT+IHHKgUGVcY1aQyvVaPXAY5xNz/MZHd2QibkjyzTWeROS9xmD0RYLVx31Cvqe8lvAod7KJj+IKim2e3kdF+GTnQ=
X-Received: by 2002:a05:6102:32c2:b0:48b:ae47:c11 with SMTP id
 ada2fe7eead31-48c272a67b4mr1810581137.4.1717736703461; Thu, 06 Jun 2024
 22:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240606135454.119186-1-fea.wang@sifive.com>
In-Reply-To: <20240606135454.119186-1-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Jun 2024 15:04:37 +1000
Message-ID: <CAKmqyKNzTu4va_epcOL=OZL7=WpCK=b+x_WXYVQcn=FO8VPkjQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/riscv: Support RISC-V privilege 1.13 spec
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Thu, Jun 6, 2024 at 11:50=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Based on the change log for the RISC-V privilege 1.13 spec, add the
> support for ss1p13.
>
> base-commit: 7a2356147f3a5faebf95dba4140247ec6e5607b1
>
> * Reorder commits
>
> [v3]
> * Correct the mstateen0 for P1P13 in commit message
> * Refactor commit by splitting to two commits
>
> [v2]
> * Check HEDELEGH by hmode32 instead of any32
> * Remove unnecessary code
> * Refine calling functions
>
> [v1]
>
> Ref:https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-prefa=
ce.adoc?plain=3D1#L40-L72
>
> Lists what to do without clarification or document format.
> * Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip, impl=
ementation ignored)
> * Added the constraint that SXLEN=E2=89=A5UXLEN.(Skip, implementation ign=
ored)
> * Defined the misa.V field to reflect that the V extension has been imple=
mented.(Skip, existed)
> * Defined the RV32-only medelegh and hedelegh CSRs.(Done in these patches=
)
> * Defined the misaligned atomicity granule PMA, superseding the proposed =
Zam extension..(Skip, implementation ignored)
> * Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed)
> * Defined hardware error and software check exception codes.(Done in thes=
e patches)
> * Specified synchronization requirements when changing the PBMTE fields i=
n menvcfg and henvcfg.(Skip, implementation ignored)
> * Incorporated Svade and Svadu extension specifications.(Skip, existed)
>
> Fea.Wang (5):
>   target/riscv: Define macros and variables for ss1p13
>   target/riscv: Add 'P1P13' bit in SMSTATEEN0
>   target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
>   target/riscv: Reserve exception codes for sw-check and hw-err
>   target/riscv: Support the version for ss1p13
>
> Jim Shu (1):
>   target/riscv: Reuse the conversion function of priv_spec

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c         |  8 ++++++--
>  target/riscv/cpu.h         |  5 ++++-
>  target/riscv/cpu_bits.h    |  5 +++++
>  target/riscv/cpu_cfg.h     |  1 +
>  target/riscv/csr.c         | 39 ++++++++++++++++++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------
>  6 files changed, 63 insertions(+), 12 deletions(-)
>
> --
> 2.34.1
>
>

