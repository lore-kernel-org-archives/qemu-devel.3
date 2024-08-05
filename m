Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2108BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb7Do-0000qN-R1; Mon, 05 Aug 2024 19:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7Dn-0000p2-Ht; Mon, 05 Aug 2024 19:34:35 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7Dm-0001xa-0i; Mon, 05 Aug 2024 19:34:35 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4ef76f04977so37497e0c.2; 
 Mon, 05 Aug 2024 16:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722900872; x=1723505672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cb3dDnvI4ENJjMQ0jNRvNM9q+TfH0RxzcjqT34rBw4=;
 b=AWnvDsLrgkxjY67rPYIQ8ooxUGbhhWGcMyruUBvwuvjNKHyXZXmA7yJ5nvwwoBc0Zs
 uLgrNAi2xDzQlpiXN8TQobJYl26nJgcIhkKaAni8k0SDDcUNuLxCsyV2rIeq2l8bnSre
 tc9blTez4144WeUeL0OyL6kZ5gRKeJ8KB/FVyIqVCMZHeS3Sr0UHcQdBjt/+VU2sArG1
 oY2LD2WNG8h5UWJJNZZgZTWfxnlUQ8jHfRxXzGF5Cj/BY995s6vN2yq0u9zExZmlIbIv
 ycj99l/F6zsmVta5he8Mx9iCCYYCTSo2beL22xsMYpCfxo/oaFHiFW26R0/9yfh3we1u
 0Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722900872; x=1723505672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cb3dDnvI4ENJjMQ0jNRvNM9q+TfH0RxzcjqT34rBw4=;
 b=fl+AIIMkKwHebHQbZ0yo3se7JE09Q17sDZuLOLkVQ7OpG0UMPAYCt9vVPn7OYCB+jJ
 JJL7jz2GOQr08MlhvTJCF9uWaHaw8c3Q9P2wAFwtAkhlTs51Oh+VR32gnLJ4OblIT7O6
 1JGsD/JIa5m9n0xN3ScM9bwjz4pJ2cHinUspPCKbVIZkpoXo1N9KrgaV761JSLt9NVmF
 4SK+toUQzNgHCsRDyG3liCJb4u1hd0xywMDM6TZrN3IFMoPtsei+poefaoGtuuiRh+gY
 wfTkjYWPw9aKkWHQLpaxsfZq+L5T6I17VophbP+GMVJ5qpoga+oMr82P1OcNlJlArSjw
 EepQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+G97/kLO+hFCmR1di9ZFFz3W2OoCjfgY9J+Z3Cqf+bCvCAfbQza3aZnWH1YQPIfPBRO3Wa8YX6Gap9jBIHGTbPzyaAaM=
X-Gm-Message-State: AOJu0Yw0Rxq11hOPp8J8Nrnjt9BMlHIhN99zs6cFr+up3hg6WVE1Dzp/
 c/YE4BhHQ2bJtGGRtGSclsBGi1t7f83ddFj4owJVr/Iy0pt6Q1Da2m8QIY1GsZIixPHKsMbvx8r
 xf4MUzRobVVzQwaltNQjXnMEdsx0=
X-Google-Smtp-Source: AGHT+IHr+QnZDK7As6676AVokfTnm5ZZyercudkQEeBcxcSrdVEnOT8L3LF3jS7gGRNwGGLVU/WMp5rLahy8e8JoWck=
X-Received: by 2002:a05:6122:1ad0:b0:4f5:12d3:799a with SMTP id
 71dfb90a1353d-4f89ff3c57fmr16232406e0c.2.1722900871728; Mon, 05 Aug 2024
 16:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240805120259.1705016-1-dbarboza@ventanamicro.com>
 <20240805120259.1705016-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240805120259.1705016-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 09:34:05 +1000
Message-ID: <CAKmqyKNvYdvrOmoW4SdycSu1Bi9fwtx3SHF04L=bAM+i5WNhEA@mail.gmail.com>
Subject: Re: [PATCH for-9.1 1/1] roms/opensbi: Update to v1.5.1
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Mon, Aug 5, 2024 at 10:05=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> A new minor version of OpenSBI was just released after our bump to
> OpenSBI 1.5. It contains significant bug fixes that it's worth doing
> a new update for QEMU 9.1.
>
> Submodule roms/opensbi 455de672dd..43cace6c36:
>   > lib: sbi: check result of pmp_get() in is_pmp_entry_mapped()
>   > lib: sbi: fwft: fix incorrect size passed to sbi_zalloc()
>   > lib: sbi: dbtr: fix potential NULL pointer dereferences
>   > include: Adjust Sscofpmf mhpmevent mask for upper 8 bits
>   > lib: sbi_hsm: Save/restore menvcfg only when it exists
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268312 byt=
es
>  .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 272504 byt=
es
>  roms/opensbi                                  |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv32-generic-fw_dynamic.bin
> index 7ec260ff40..b2e740010b 100644
> Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv32-generic-fw_dynamic.bin differ
> diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv64-generic-fw_dynamic.bin
> index 090c0cf6ac..018b4731a7 100644
> Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv64-generic-fw_dynamic.bin differ
> diff --git a/roms/opensbi b/roms/opensbi
> index 455de672dd..43cace6c36 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit 455de672dd7c2aa1992df54dfb08dc11abbc1b1a
> +Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
> --
> 2.45.2
>
>

