Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB13D3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RzK-0004y0-IL; Mon, 28 Oct 2024 11:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5RzI-0004xT-2e
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:49:00 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5RzF-0003rz-Hi
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:48:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso6941960a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730130535; x=1730735335; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gHV/bLonf1T7cFCCIyJivlbSqvtQH3czNf0k+2W6D2A=;
 b=hBZQ60GZlmqGjBkN5TVHsA1OLWvvDv6D6P/HLjYojhuJCGbVoxwjAmpH8tJyn7KniA
 h1XE/CNsR/jzEOBZuRqTPJnicFItGWvgmrEQv3oV9HcgrdfRWHLMElOjQ6XnsOGYLIVx
 5DD1IypzuVSnZGD6fllFZc6I6+0lEoTFLLeT25gk6ri+5SsbEY91XvKazDd4zqVn0lmd
 1uT5odIglGkDz8gY5Ku2/XwdT/+ZWYCF4V7IBzQTWu/F56vheBqVroi89ExNZJOFcxLD
 UbNgTjQU5vmUvh5tzW2urOYtuMbdARv7UywjPVBgruzkgKLclQrvui3Imlu/FW4q1DTg
 Da6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730130535; x=1730735335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHV/bLonf1T7cFCCIyJivlbSqvtQH3czNf0k+2W6D2A=;
 b=sHFg5kVc2AaYYJYEvTzC8Byhu2jEJPgQN52r3UXecJPMvIVQF+q7SqbiTEUIO35drR
 5T3RnEL2hX5eyapDIxO9TFaGS9Wmc1ervM85rwpICmSdzYvRw2KMnQVuSXrH4PDnETzL
 ASRlBPVOCgrVV3GKPBMy7S7L5uJWRREwC5z9B8ucoxoI1iP5XJ1a7YnI+3KPPlyrC82C
 pj45ZHj3ZxiH06UVoHxY0Ap07OnpYcm9c5YG9uJr3niq5Vzzfsc8RUIGtHBe33rXA8oZ
 sU3xnd+/NItYtuCwVaDl/dMyYALlWKD4H910QBcjEUWojv4L4KFCfdpHdQ8kacvf7OUj
 h2Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+x0ZKb34rT3wc4mKjrBCMpu45yv++FErz82BbCYnPDuWIHA0z5J5nfvan8fUTL/3l+RbwwFeL+UQD@nongnu.org
X-Gm-Message-State: AOJu0Yx8CZmMrZ/U687p8p+5JVsk5q2aH+dedUQOmkcx+MzofvT981eT
 /2DMpW+B6wCDFyDIFENrQ52c6wKqRaZQ5Qaks21sJie2y354yBbGB/x6wRvpRKJ+nFX+5IiDAWW
 xb4NmSQNJKXBaU5PvSXYeCP4qMpTUkByFitzc5Q==
X-Google-Smtp-Source: AGHT+IGAjrSdRHa6H4QglHg+DQx5JKUtsu7V11ech87Rh1F+k2zHk2bGLWff0LkH3/Er9L1Pk13XJZ9rRX2NPHnX/fQ=
X-Received: by 2002:a05:6402:5188:b0:5cb:881e:6d3c with SMTP id
 4fb4d7f45d1cf-5cc19667091mr60690a12.8.1730130534987; Mon, 28 Oct 2024
 08:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
In-Reply-To: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2024 15:48:42 +0000
Message-ID: <CAFEAcA-V1fS0vKyZecxacTtbd-UV8y6BMU-XMFOh1xYbhwwgTQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, gaosong@loongson.cn, 
 jiaxun.yang@flygoat.com, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 28 Oct 2024 at 01:58, Sia Jee Heng <jeeheng.sia@starfivetech.com> wrote:
>
> Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> The SPCR table has been modified to adhere to the revision 4 format [2].
>
> Meanwhile, the virt SPCR golden reference file for RISC-V have been updated to
> accommodate the SPCR Table revision 4.
>
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
>
> Changes in v6:
> - Added Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> - Rebase and update the build_spcr() function for the LoongArch virt machine.
>
> Changes in v5:
> - Reverted the SPCR table revision history for the ARM architecture.
> - Corrected the output of the SPCR Table diff.
>
> Changes in v4:
> - Remove the SPCR table revision 4 update for the ARM architecture.
>
> Changes in v3:
> - Rebased on the latest QEMU.
> - Added Acked-by: Alistair Francis <alistair.francis@wdc.com>
>
> Changes in v2:
> - Utilizes a three-patch approach to modify the ACPI pre-built binary
>   files required by the Bios-Table-Test.
> - Rebases and incorporates changes to support both ARM and RISC-V ACPI
>   pre-built binary files.
>
> Sia Jee Heng (3):
>   qtest: allow SPCR acpi table changes
>   hw/acpi: Upgrade ACPI SPCR table to support SPCR table revision 4
>     format
>   tests/qtest/bios-tables-test: Update virt SPCR golden reference for
>     RISC-V
>
>  hw/acpi/aml-build.c               |  20 ++++++++++++++++----
>  hw/arm/virt-acpi-build.c          |   8 ++++++--
>  hw/loongarch/acpi-build.c         |   6 +++++-
>  hw/riscv/virt-acpi-build.c        |  12 +++++++++---
>  include/hw/acpi/acpi-defs.h       |   7 +++++--
>  include/hw/acpi/aml-build.h       |   2 +-
>  tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
>  7 files changed, 42 insertions(+), 13 deletions(-)

Since this seems to be for the benefit largely of
riscv I'm assuming this will go via the riscv tree.

thanks
-- PMM

