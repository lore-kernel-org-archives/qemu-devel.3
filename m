Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED71C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 00:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twVeK-0005LX-Qy; Sun, 23 Mar 2025 20:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twVeH-0005LH-NS; Sun, 23 Mar 2025 20:26:39 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twVeG-0002oG-7D; Sun, 23 Mar 2025 20:26:37 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-523dc190f95so1935102e0c.1; 
 Sun, 23 Mar 2025 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742775994; x=1743380794; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=960VDtBN2b9EaNp55Hhumwy4I/1BDpxlnNaXzPMaOYI=;
 b=GsgnmLhx3z5udvX52AwcMaMtJdrO5f5d41doPyaD6aG0Jl3k6haa9wlEDPPubolPIL
 ziI4hxOA/thqGPS7Tqnjk8/pRpGHTghYmTHwHk7Sg1lqNtY8U5f8T3Ez8bUV5u/62Bfv
 Ief1UxgbuzEfjM323oJsjLw+rqdAdsgbr99+XD5Ni+ZfGJQ98+zQURicRM8G+i7mD5DP
 A8P59kg8u8EdIHwm8NrgL8w1NNbqp/xQM+x1e1ym91XLhLfFJFft546HUuPocyKuJDyx
 xuLN/OQ0GAoM5gvVBgJZ88ujCKBfu/U5AsJAdJciX6lg4wB7bEewZ9sZhfq2n8OapkbB
 bB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742775994; x=1743380794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=960VDtBN2b9EaNp55Hhumwy4I/1BDpxlnNaXzPMaOYI=;
 b=Uy5nFbGQwAIO80gICRbytnkKblIe14BrF3hcUgE7ubaU9nEgQNNf5KfRCzJECIwc/G
 KvwbPDYcPOiZWM/UP+KdKmPIIohzttex6gmf8kDwTdQ80tsbVModBs5iAu+JHplNBfcs
 fBPa+tcNZoVQn6jy0rdFFEVnmTefKH+Sa6nvY+SlGK8EcfmkqByKnGRB7KIm5hOB/ClT
 G5qESchkhmZ7R6QXiXrXuvWVJSlOgLH+MLr4nM86dlgxGx1NWSuR1tNb5d5T649S3bhD
 svJcxjK4DxATWcmzdb7gcFRW85M9+FJakssPNPSzrqCKVkTKE1WwK9LYPdWCwF5alm0C
 KCLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP6lKXFP2EHnC4+J7XaiPacgFW2Nf6o9at8xjhMwBVmE0IgZc4PB66fiT7B9n46hD1KRjnC9jAWCoG@nongnu.org
X-Gm-Message-State: AOJu0Yz4OGlk9/Aiu5RV6JSbg7+c6mprjwcYb57Y0JVAQ0fVJixiFz/y
 H2EKybYQt+NawK2Z/bBF+e2C352/PTyFYfSFKmRzU9Eu0vLRtx5OzJw4tAj4es0OEm6iYmTuFVW
 4vq+3oMjeNJWKVRpcf6yXgyV42zqijQ==
X-Gm-Gg: ASbGncuTtIaVTlhHkPdKOoyDVjj2UfBQUwS19BlE6wrcjotTKD0HHs3eNtY5M2CXOaN
 6+va4pgnJz0tleYhfwKP/Y09ZKmrTt7g/GngFHqhTM1dnVc7lVvgBdDviGqGCixMgKqcDOzMlHR
 AyXkrSZFwknl69Gpi+EbY4UyczvFDiRwUwZMRVb7qurM2OsI7WkN/sTSg=
X-Google-Smtp-Source: AGHT+IGSdetzD9On3rcHm1k1bgkTqphgCSo+CX3lFW2Hdcf8MeewufqzQiE5KydYRAy8nwaatVti9MmGHAoCs3Zxo/o=
X-Received: by 2002:a05:6122:3417:b0:520:5a87:66ed with SMTP id
 71dfb90a1353d-525a837923fmr7787130e0c.5.1742775994109; Sun, 23 Mar 2025
 17:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250323140151.9994-1-hemanshu.khilari.foss@gmail.com>
In-Reply-To: <20250323140151.9994-1-hemanshu.khilari.foss@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Mar 2025 10:26:07 +1000
X-Gm-Features: AQ5f1JoOuDwpUh8_Friroa97VGvUGQBDAME8IBPEP7ugAcGnca-JxjGYHzAEJmo
Message-ID: <CAKmqyKPCgoHKX+2doa45Z2tu-_9vt2scmzjaZc6nniDukkRjHw@mail.gmail.com>
Subject: Re: [PATCH] docs: Added docs/specs/riscv-iommu.rst in MAINTAINERS
 file.
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Mon, Mar 24, 2025 at 12:03=E2=80=AFAM hemanshu.khilari.foss
<hemanshu.khilari.foss@gmail.com> wrote:
>
> Added docs/specs/riscv-iommu.rst under `RISC-V TCG CPUs` section in
> in MAINTAINERS file since
> `scripts/get_maintainer.pl -f docs/specs/riscv-iommu.rst` doesn't list an=
y
> maintainers.
>
> Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f470a1c9b..27f2cfd833 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -319,6 +319,7 @@ L: qemu-riscv@nongnu.org
>  S: Supported
>  F: configs/targets/riscv*
>  F: docs/system/target-riscv.rst
> +F: docs/specs/riscv-iommu.rst
>  F: target/riscv/
>  F: hw/char/riscv_htif.c
>  F: hw/riscv/
> --
> 2.42.0
>
>

