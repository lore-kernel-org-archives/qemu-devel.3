Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523B6C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lMp-00029z-OE; Wed, 23 Apr 2025 21:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7lMj-00023a-A9
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:27:01 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7lMg-00081d-Qx
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:27:00 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-8778151ddc5so212369241.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745458017; x=1746062817; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3UUGcwgS9vviGnSXKyeytpAXhJHQZTDVem2AgbXV+w=;
 b=km1rDgnl6ehRcuYNxIbooeUF3dvPdxVztC0UpbaTeh9AXCjlDDKvqcBm5umSfaNeuU
 CHDiYDmQ4wSLykQg4fc1Dqg/BpMY0oLjja7h5xL3ZAVe9nFDRDGs3aMiFFrKgiAK9v1/
 zb5+Bz1zWvnBsS03go7Oepnt7dvDbu3R1K0aW54JD83fTbn2bG7tXEPdPU3fajojwfj5
 F42qdBlCtHhU/KtNeUJM34m7qZSrSW9uHcBSsCT/jeRQ6E0dKdksPCIBXueBmvIFlf6w
 tLvhTh6/us3ZjYMBigcv2GvdlHRTZ0XU+K7UargkDCXm3w9JWeb3/Erg3WKDuCpFrCZd
 Fj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745458017; x=1746062817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3UUGcwgS9vviGnSXKyeytpAXhJHQZTDVem2AgbXV+w=;
 b=cXNfklJK3QUfWe1R8lrZt+nDxy/9k76EmdNsg5E43nxpsjQRlch7kbJ3CaEZp5LDee
 4x1/vBuzCJaLPBTPRk8KS/t3Zs3YbVuH3cGfkfJKCOmD4yo1c77ZJO7vu4ACvEN7uM+s
 YrnJqImvLp90L9rBCjJygr0DIF9Y454a77qAI8uWcdFHfSHfeilf+oyfPyrImnDKI7hW
 BdCqdUzTGqWCutA8y8tPTX75O/Nyp6K4lMoG+iZ7kOK+x9Zz/e+KK7aVJo2ds1S+3nml
 YEwHspw9XppJ/WdpR096axD5k9rp8xzyfOJXUNkdrnC6lj9Zx9xGprglx9vqa0qtn/JP
 12Ww==
X-Gm-Message-State: AOJu0Yz0jxeiJ5pzRXUxFxyaSvLXfwXcx2iw7EEZIsTFnk/soGUEENU+
 MAlpEMuRB7uOS/PJJRJjjoa2kJE2rG4IwzRTM83a/yHrp4KRHBMK2wu69vYjsYRESHXxdk+ufCO
 ZQbg+YwbMvJMzDkv1jGjJlzhlLEc=
X-Gm-Gg: ASbGncuQq4XT2BVo3W6GCdkb1w4AQNti+KCYqV9Mh1+BCjjTwi7H4wKKZeB7Ca8Ub0v
 ZHzrJywKZnLlZOBZ+1wQWGabGAhAflqBak8SPkihx3PcVjRKlRZXoPSFVppP+idX+drHxh6e9BX
 QX/VowMOnuhbOZ35K10fu7gINvHw5ZoK/YxWy/Hv5UyjPK6xJ/4mf3
X-Google-Smtp-Source: AGHT+IE3mFSOfEz438DCNFhncWpCTAMuXa3jCfuHLozxQWVL/WJz4DeeFsZmWxRka5fiXRUZipr+5ufukLU/ecwGMQA=
X-Received: by 2002:a05:6102:c50:b0:4c4:e3fe:4af9 with SMTP id
 ada2fe7eead31-4d38d820a3dmr1060633137.12.1745458017318; Wed, 23 Apr 2025
 18:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 11:26:31 +1000
X-Gm-Features: ATxdqUFZORD9bju8zfzllDux75IGKFzxqV3EfMIUqLnuv46HFiBfRRwH_uj6L4g
Message-ID: <CAKmqyKO=-QhuKNAKJBXfGiwPdSt=uT6M16pgVJENLxgEiy5Adg@mail.gmail.com>
Subject: Re: [PATCH 10.1 v3 00/27] target/riscv: SATP mode and CPU definition
 overhaul
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Sun, Apr 6, 2025 at 5:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> This is the combination of the previously posted series to store max SATP
> mode in RISCVCPUConfig as a single integer, and convert CPU definitions
> to a small extension of RISCVCPUConfig called RISCVCPUDef.  I put them
> together because the first part (patches 1-6) is already acked/reviewed.
>
> As mentioned in the earlier submissions, the main reason for me to do thi=
s
> is to remove .instance_post_init, which RISC-V is using in a slightly dif=
ferent
> way than everyone else.  Whereas other uses (including x86, which is
> currently buggy, and Rust) would prefer to call .instance_post_init
> from root to leaf, RISC-V needs it to be called from leaf (CPU model)
> to parent (DeviceState).  The fix is to move the logic of the former
> .instance_post_init callback for the leaf at the end of the leaf's
> .instance_init, as done in this series.
>
> Paolo
>
> Supersedes: <20250228102747.867770-1-pbonzini@redhat.com>
>
> Paolo Bonzini (27):
>   hw/riscv: acpi: only create RHCT MMU entry for supported types
>   target/riscv: assert argument to set_satp_mode_max_supported is valid
>   target/riscv: cpu: store max SATP mode as a single integer
>   target/riscv: update max_satp_mode based on QOM properties
>   target/riscv: remove supported from RISCVSATPMap
>   target/riscv: move satp_mode.{map,init} out of CPUConfig
>   target/riscv: introduce RISCVCPUDef
>   target/riscv: store RISCVCPUDef struct directly in the class
>   target/riscv: merge riscv_cpu_class_init with the class_base function
>   target/riscv: move RISCVCPUConfig fields to a header file
>   target/riscv: include default value in cpu_cfg_fields.h.inc
>   target/riscv: do not make RISCVCPUConfig fields conditional
>   target/riscv: add more RISCVCPUDef fields
>   target/riscv: convert abstract CPU classes to RISCVCPUDef
>   target/riscv: convert profile CPU models to RISCVCPUDef
>   target/riscv: convert bare CPU models to RISCVCPUDef
>   target/riscv: convert dynamic CPU models to RISCVCPUDef
>   target/riscv: convert SiFive E CPU models to RISCVCPUDef
>   target/riscv: convert ibex CPU models to RISCVCPUDef
>   target/riscv: convert SiFive U models to RISCVCPUDef
>   target/riscv: th: make CSR insertion test a bit more intuitive
>   target/riscv: generalize custom CSR functionality
>   target/riscv: convert TT C906 to RISCVCPUDef
>   target/riscv: convert TT Ascalon to RISCVCPUDef
>   target/riscv: convert Ventana V1 to RISCVCPUDef
>   target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
>   target/riscv: remove .instance_post_init

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu-qom.h            |    2 +
>  target/riscv/cpu.h                |   42 +-
>  target/riscv/cpu_cfg.h            |  180 +----
>  target/riscv/cpu_cfg_fields.h.inc |  170 +++++
>  hw/riscv/boot.c                   |    2 +-
>  hw/riscv/virt-acpi-build.c        |   15 +-
>  hw/riscv/virt.c                   |    5 +-
>  target/riscv/cpu.c                | 1014 +++++++++++++----------------
>  target/riscv/csr.c                |   11 +-
>  target/riscv/gdbstub.c            |    6 +-
>  target/riscv/kvm/kvm-cpu.c        |   27 +-
>  target/riscv/machine.c            |    2 +-
>  target/riscv/tcg/tcg-cpu.c        |   13 +-
>  target/riscv/th_csr.c             |   30 +-
>  target/riscv/translate.c          |    2 +-
>  15 files changed, 729 insertions(+), 792 deletions(-)
>  create mode 100644 target/riscv/cpu_cfg_fields.h.inc
>
> --
> 2.49.0
>

