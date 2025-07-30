Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B763BC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvJY-0008Fo-RP; Tue, 29 Jul 2025 21:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvFP-00006S-QT
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:04:47 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvFN-0005NF-Ro
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:04:47 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-88bb3eebeacso134657241.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837484; x=1754442284; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ao6PmA4EQzR3LhIP12OV6ExGOV3d7KaSEKdW0e0eKL4=;
 b=d1DydbzAeX8AtMbq8AALHXcOEQo+RPOIC47VawpAbWhcWbL9nKaZvcNmNWFy12pISO
 aEvm3wARiZi0Xny76BJi6+glURjLPHCbZ7Zlv6rXJTvbmyN80SoGIowpk0yBZP1prtuG
 mUowq9Delb5nFC/R6gjdDuPHqI4GSFmkvaze8bAoHQuZeoHyWceBVNUS++NhHytYpBaE
 z8HCrcYPjFUNYm+50xo93uRHwFcsolS6qUcznrk8GOKKpa2gnZWMHgWLarrYP1kzrqXl
 104HA7fJpdTnDvoCJxRK51zSWgMaLhC617u08i1G0TpQlJx09z4jyr+T4uNwPrrnkdgt
 ZySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837484; x=1754442284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ao6PmA4EQzR3LhIP12OV6ExGOV3d7KaSEKdW0e0eKL4=;
 b=UybrWlPRGZ65dbMu+rLp80YifvSlpMPu7VmEu8fkKnjq3j8nw+PALZ2bKeljwMLSiQ
 0plfrILkIa+eLqA21ldmN5vlR/xD1EICHTe7vpRpauKDvJKaR9epiiChR8YKtWc29uMt
 +iMSYHyrRh5UVue88MzoS/Px6PZjNfoFAZeygGSbyk2JdFGooSoGyBSNvxginCDN7yy8
 MCNnlhnmE3O3PsJwg0BCmrrnZ2UbCRA5PCZsSbzYBqw/sYG1ToUToGJaJgdCMoH5TyhS
 Nyh6bhgd6GS8jTcZilBuDo9EsXFYOSxvD8EUbGG1yDHQV5LJY09mG7liioeqJ71fFakI
 I19Q==
X-Gm-Message-State: AOJu0YxDH9TJnDhO7HqFha5WxA6JWTkVkZiC+MAL1+akfP1C7LBfeukZ
 m92aXPxCZt8bKJvUpkaXyLrnlyHFYgirZAvhPCOThnkC/73Z4BVpxwlvhOVbCjG/z0WI0MZj2cc
 zGqXPk1N6JP1OM6zQTjv64R/SkUFZm1RM0g==
X-Gm-Gg: ASbGncubsgCFN7NG4kzyh+AsGYqBqZdYaIXEvG/KDRCqX3Udrb8VdmQQQgmkNyLSIt2
 OkRLTDtQ4Qww+Z1sNj4srgrlcjsdVwLNFJ+86tlWiKtyHEcHQHTYY384mhah5iUhhn2udX6RbzL
 Rih+B40B9gtZhb47ChaIvMuliaTZBU+pW9QqExFE+13Pw9WC3I4o/L81s5YQQxMqqWWYL1Yt0PW
 bwhyJ8+5Oq/C3dCqAXtFhsSxSvon+4ZE4ztLg==
X-Google-Smtp-Source: AGHT+IHc8ATjxTNubHWjDwLT2bozWlwqbJB8s+S8b7IBcnqa5bWrkA2UCkHxOKnMLtblJmKqi9DCCfL5AvElfAkF2Zs=
X-Received: by 2002:a05:6102:32c8:b0:4e7:dbd2:4604 with SMTP id
 ada2fe7eead31-4fbe8772709mr1196381137.17.1753837484371; Tue, 29 Jul 2025
 18:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Jul 2025 11:04:18 +1000
X-Gm-Features: Ac12FXw3GeJ6zgjuW_EJBORodS397exrjmkAU7AFO_b0kzeMjSUXX-N0kn1FrvE
Message-ID: <CAKmqyKP+tHtyx2ZDyRE70kgyWTZDFGaq=ZhKgAo5H_O8H0MZvg@mail.gmail.com>
Subject: Re: [PULL 00/11] riscv-to-apply queue
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Wed, Jul 30, 2025 at 11:01=E2=80=AFAM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The following changes since commit 9b80226ece693197af8a981b424391b68b5bc3=
8e:
>
>   Update version for the v10.1.0-rc1 release (2025-07-29 13:00:41 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-2025073=
0-2
>
> for you to fetch changes up to 86bc3a0abf10072081cddd8dff25aa72c60e67b8:
>
>   target/riscv: Restrict midelegh access to S-mode harts (2025-07-30 10:5=
9:26 +1000)
>
> ----------------------------------------------------------------
> Third RISC-V PR for 10.1
>
> * Fix pmp range wraparound on zero
> * Update FADT and MADT versions in ACPI tables
> * Fix target register read when source is inactive
> * Add riscv_hwprobe entry to linux-user strace list
> * Do not call GETPC() in check_ret_from_m_mode()
> * Revert "Generate strided vector loads/stores with tcg nodes."
> * Fix exception type when VU accesses supervisor CSRs
> * Restrict mideleg/medeleg/medelegh access to S-mode harts
> * Restrict midelegh access to S-mode harts

Sorry about this being so large and late in the cycle. I just got back
from parental leave and wanted to get these fixes in for 10.1

Alistair

