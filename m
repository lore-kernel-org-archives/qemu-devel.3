Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E998C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 23:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ralTz-0001Aw-1X; Thu, 15 Feb 2024 18:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ralTx-0001Ad-Q9; Thu, 15 Feb 2024 18:49:33 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ralTw-0002RU-5a; Thu, 15 Feb 2024 18:49:33 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4c02af5c0b6so409949e0c.0; 
 Thu, 15 Feb 2024 15:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708040971; x=1708645771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2oTvT+/x3P3mlS6j7UxKbrN+dT373fr/0EQFk9nnxw=;
 b=M5UWNqGwKxDrfbsLggexN8+u3Vmw01adEDRCHur2W8fO8PC1aGPvajW89jKCI+brUO
 pQAVBmbEOV3MFQDhRNQcdKS9fLZ4kreYH07QhezHNICyDJZuNkXP1N0N6V+UH+7KIlab
 hUN4hNe7nCdCGI/PxLo2xaBywPfo1NbuqKItiV0HgzgAPYeGOA1Eg5pfBDR+PBI7oik9
 syaGEZL9WqbJ07e6kM9j1pAlMo4yy7VogBVRhoYuplz9/45RV54G6fHt1aOPobyXAc+j
 5dR20yOtNOiVabVGUMc3WWKXWbro5NIS8UEP8a+KfVrwuuLkoWbsAtmVa3snD/6tdGqT
 O01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708040971; x=1708645771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2oTvT+/x3P3mlS6j7UxKbrN+dT373fr/0EQFk9nnxw=;
 b=GtOy12edtVQlo6hFtOPmRwrZqS2T/RKmtTR/YCy6f/0LGr5z94wMVyU9kj2G1lhr4e
 EbNgb35dSQiLOQyN0jhTSFYikXmL1PMVEmePCfXS651SLN4JjzhxpuJGyI009JcSihg7
 TSh72bLCqwmd6C/7Pazmp5nFnJCAzmPyLUYWLG8WozzBxp9d8ixUXzy3T1ZGpnIqsz/1
 SVjvN1Rw1SG3aQbU+cQM2INF7uS5i54OeSqvDh+Zu3X8Hjf5MboXXQMRYIveokziCFSu
 e5l5faaRgHUh8AsnZMUcN5ldOXGTqlrI73A/ehDDmJnFJZ76cHhnem1MWObWgQFQ2dmz
 kJ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1k+/r0eckuY+/lfgnNrsLE4jXbyhaF6T0Njg8nJiFCPiEDIRrZ1hd1ZhXkVLco/NevRYn+pIBCklHigrEFQr2WVmVHyk=
X-Gm-Message-State: AOJu0YxwBScW+MSeUEtjgy6lANEOOuankzdeVfA/8wAo6Z+OKjnX8Uwi
 nTaJVYmv0CLnOPpoVYsVj9sFoLGPxvN2RWULfzU5HNwgi0GbzRXQ5Wd1VsD5D+fzRas/L6kMqCc
 vBrgQ/fdqC60R+Yr4Y9Dbl2EgrAU=
X-Google-Smtp-Source: AGHT+IEfC+1i+TROqGxuZCiFCS12AMoJF++hZqdvy2KupDUE10DswU0kI8uswyhMwMqs9Fg36KAygbOIkRjVHqIEuC0=
X-Received: by 2002:a1f:4b87:0:b0:4c0:29e5:d31f with SMTP id
 y129-20020a1f4b87000000b004c029e5d31fmr3294614vka.2.1708040970728; Thu, 15
 Feb 2024 15:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20240215223955.969568-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240215223955.969568-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Feb 2024 09:49:04 +1000
Message-ID: <CAKmqyKM_MOOQ-SU12yxDmZiE1Go=KOe0T8JRm75-+WgKhBizSA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] riscv: named features riscv,isa, 'svade' rework
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Fri, Feb 16, 2024 at 8:41=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This new version is rebased with alistair/riscv-to-apply.next and with
> more acks added.
>
> No other changes made.
>
> Changes from v3:
> - rebased with alistair/riscv-to-apply.next @ c93c42a273
> - v3 link: https://lore.kernel.org/qemu-riscv/20240202152154.773253-1-dba=
rboza@ventanamicro.com/
>
> Andrew Jones (3):
>   target/riscv: Reset henvcfg to zero
>   target/riscv: Gate hardware A/D PTE bit updating
>   target/riscv: Promote svade to a normal extension
>
> Daniel Henrique Barboza (3):
>   target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
>   target/riscv: add riscv,isa to named features
>   target/riscv: add remaining named features

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c         | 70 +++++++++++++++++++++++++++-----------
>  target/riscv/cpu_cfg.h     | 12 +++++--
>  target/riscv/cpu_helper.c  | 19 ++++++++---
>  target/riscv/csr.c         |  2 +-
>  target/riscv/tcg/tcg-cpu.c | 34 +++++++++---------
>  5 files changed, 94 insertions(+), 43 deletions(-)
>
> --
> 2.43.0
>
>

