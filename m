Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FD4C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM3M-0007qV-H2; Thu, 19 Jun 2025 16:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uSM3K-0007oz-QY
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:40:06 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uSM3I-00057H-OH
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:40:06 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-609c6afade7so3955373a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750365603; x=1750970403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9m5gye6uoLoCfaTMVFw7Btzmb4PpAX1nwack/je4qI=;
 b=YiBHMkSWTb/+ttvLBFlIuPB1+QR3hTPZQAK9hy9ipkuGd9wKjWsPr+fAGW/oeTdEDb
 ueZ9XdoyYL/GMKdwyeHxf315RX1w5oShkEPyo04zi6I4H0/YdNANKOr6fCUotJYRjBas
 ZQQ4OTfu9fHJW7wzN/6VQzwAB0idCvL4WnRU+mQiLkjDFAmSz/u9PA+QNf4snNPQkH9U
 NXTM4XXIwtFk4c0inzSBeCFWwi2VdG0AxyLMUIhHq9qSZ2/r4oiWxbVYjvn0IfCNsMRp
 OhfrLxI1eJHJoOfWE4GVO7hwIfD0KzvSdtyxpXcUNFYG532HndODsgGwtciOYDNvgjQq
 EMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365603; x=1750970403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9m5gye6uoLoCfaTMVFw7Btzmb4PpAX1nwack/je4qI=;
 b=TR1NCIlWB2B0AXPpd5MnA1Uy3WUyDDtyQ2hqspcOqYUWSDy9kuTfC8Duk16K3TVotG
 8iv/GcoPMHMVdLBYMlYZYl8bDOgI/mEgpw+Opc3Gay45vrJX1+6tdALqd2gQDWYmhyAw
 c0G2ZsSPk4mQP3spM9nEssi6c3XfZw3IQYCadFatk+Xq+sbN8kZiNgHBQFj7dxjIsIqA
 x8WWyASEtRHs+hREVDhDl4r6gLx9VIXCnqebBUxAzhCRtukIziIOkiy93OQhibyoR05E
 yAXLTisekQ7iG08gp9yWlm9ijoqP5w8N5uPsoDBwge472YSZzetqwtE0/afWc+tbyWWG
 iRcg==
X-Gm-Message-State: AOJu0YwH9SkB2csP/ahbwZD+QnpWPShKU5FEbf41unOxu7wgoXBm3kdl
 F2i6hBjYviCkvNkgXn55fO8Px5PqFZfrLc47VcEx9iDQnLOuJhFt449+PZCdDLQ97uh9bzMME7w
 oT9IM6UxsC0Y6bYTbuRxwgykaTBFt+pMZb2gM
X-Gm-Gg: ASbGncv4D1mWX0/CY6tlQwdvTWjdFVNxCof6B/xNoCXGq+4+95Y3OCxWDfYBnmyhbOn
 azcJ+zXZ6B8lSo/Pp7ibDCmX/dg+SoVDzqYXd9d+GdNWXVkL0B+Sc9DRnD1sdrvoibdRNh3djJ9
 IKyAWh6kGaFUBxDRHH5d1M2JU/1CbcE0z69C+JrWvelA==
X-Google-Smtp-Source: AGHT+IHEGIGRKWGf1cWvf7TVR8cnPU1oHv902ieE6aXctzo/i1FBAdlvtExWWhUex29eZ59v8yWw+hla8Q/sYPgxpbM=
X-Received: by 2002:a05:6402:4414:b0:608:199e:df25 with SMTP id
 4fb4d7f45d1cf-609e38ec1acmr4342366a12.2.1750365602469; Thu, 19 Jun 2025
 13:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250619082817.1517996-1-gaosong@loongson.cn>
In-Reply-To: <20250619082817.1517996-1-gaosong@loongson.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Jun 2025 16:39:50 -0400
X-Gm-Features: AX0GCFu6LRUe61P194mjKBXmlKec-hmq2RZMngFaVjVIYggb5bIuNHg8TyFvWBE
Message-ID: <CAJSP0QWsFx8qcR4k4nb2fBH0Q1aFWwCUU4JEs+NFCGHKhSphMA@mail.gmail.com>
Subject: Re: [PULL 00/14] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jun 19, 2025 at 4:51=E2=80=AFAM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> The following changes since commit 6e1571533fd92bec67e5ab9b1dd1e150329257=
57:
>
>   Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu in=
to staging (2025-06-16 13:47:19 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250619

From https://github.com/gaosong715/qemu
 * tag                     pull-loongarch-20250619 -> FETCH_HEAD
gpg: Signature made Thu 19 Jun 2025 04:49:38 EDT
gpg:                using RSA key CA473C44D6A09C189A193FCD452B96852B268216
gpg: Can't check signature: No public key

Why has the GPG key changed? Your previous pull request was signed
with key B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF.

If you would like to change keys, please sign your new key using your
old key and upload the new key to the key servers again. That way I
know that the new key really belongs to you.

Thanks!

>
> for you to fetch changes up to c2a2e1ad2a749caa864281b1d4dc3f16c3f344f6:
>
>   target/loongarch: fix vldi/xvldi raise wrong error (2025-06-19 15:57:31=
 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20250619
>
> ----------------------------------------------------------------
> Bibo Mao (13):
>       hw/intc/loongarch_extioi: Add kernel irqchip realize function
>       hw/intc/loongarch_extioi: Add kernel irqchip save and restore funct=
ion
>       hw/intc/loongarch_ipi: Add kernel irqchip realize function
>       hw/intc/loongson_ipi: Add load and save interface with ipi_common c=
lass
>       hw/intc/loongarch_ipi: Add kernel irqchip save and restore function
>       hw/intc/loongarch_pch_msi: Inject MSI interrupt to kernel
>       hw/intc/loongarch_pch: Add kernel irqchip realize function
>       hw/intc/loongarch_pch: Add kernel irqchip save and restore function
>       hw/intc/loongarch_pch: Inject irq line interrupt to kernel
>       hw/loongarch/virt: Add reset support for kernel irqchip
>       target/loongarch: Report error with split kernel_irqchip option
>       hw/loongarch/virt: Disable emulation with IOCSR misc register
>       hw/loongarch/virt: Add kernel irqchip support
>
> Song Gao (1):
>       target/loongarch: fix vldi/xvldi raise wrong error
>
>  hw/intc/loongarch_extioi.c                      |  49 +++++++--
>  hw/intc/loongarch_extioi_kvm.c                  | 140 ++++++++++++++++++=
++++++
>  hw/intc/loongarch_ipi.c                         |  29 +++++
>  hw/intc/loongarch_ipi_kvm.c                     |  85 ++++++++++++++
>  hw/intc/loongarch_pch_msi.c                     |  10 ++
>  hw/intc/loongarch_pch_pic.c                     |  45 +++++++-
>  hw/intc/loongarch_pic_kvm.c                     |  89 +++++++++++++++
>  hw/intc/loongson_ipi_common.c                   |  33 ++++++
>  hw/intc/meson.build                             |   6 +
>  hw/loongarch/virt.c                             |  65 +++++++----
>  include/hw/intc/loongarch_extioi.h              |   5 +
>  include/hw/intc/loongarch_ipi.h                 |   5 +
>  include/hw/intc/loongarch_pch_pic.h             |   5 +
>  include/hw/intc/loongarch_pic_common.h          |   1 +
>  include/hw/intc/loongson_ipi_common.h           |   2 +
>  target/loongarch/cpu.h                          |   1 +
>  target/loongarch/kvm/kvm.c                      |  23 +++-
>  target/loongarch/tcg/insn_trans/trans_vec.c.inc |  13 ++-
>  18 files changed, 563 insertions(+), 43 deletions(-)
>  create mode 100644 hw/intc/loongarch_extioi_kvm.c
>  create mode 100644 hw/intc/loongarch_ipi_kvm.c
>  create mode 100644 hw/intc/loongarch_pic_kvm.c
>

