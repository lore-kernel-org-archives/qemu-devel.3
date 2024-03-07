Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9215C54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 02:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri3XS-0000cg-5I; Wed, 06 Mar 2024 21:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri3XQ-0000cB-0A
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 21:31:16 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri3XO-0004ii-B0
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 21:31:15 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4d35b9a4b13so234148e0c.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 18:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709778673; x=1710383473; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/3NeDMoiIHSi0MPdJgTOWitoLCbSv6GCoE2ktGCVcw=;
 b=Qjc14XaKDoUn0/1ZWAhbMKHnwc8fI1DkAG/SyV7Cfl2zQfJIU21dp/zCtMOIXVRQ4e
 1ci8fHUj4zq9W2hGXnoRVX0QZa4HoysjGDlhBIwqGHmPoKaEClvqMBg0Olis+NA3oxYF
 xJ0+ZB4rcwJAS/FGTr2jaIhPDjkZi4oZ7RYvOCPs6e1MWk7A2iy2e+UxHxNzDJ3VYqjA
 4bDXNvFek/uVe93kEBTPDZ3jFUAeQcyTKE5KEUHBS9JGAK88SPeylVVNPXCyS67uE1/i
 F50+8P1S6rj+q8LVX7EM7VlzhgGkfk/OgoYxoTCrHIw3fZvzqM1XllauK3nKy1ZZH2Ta
 Kykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709778673; x=1710383473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/3NeDMoiIHSi0MPdJgTOWitoLCbSv6GCoE2ktGCVcw=;
 b=F1vJaEFQpibdwD5ajuixQLvRcooZCV7ALQVB35CaogZ8EQTp1hqMFtZiHon9Nv8xPw
 CcE4+TauRuB5q51xvtkom2byE4icbZzNK3Cd5CjP+L9u5RNC93M9yfgr1NkQOLb1y2Pw
 rirE1HGkkHOQ9B3TGnSDC1sFFeP3zaHTa/quDxybXQ0moLEEmbTed45B4m3WRR1jsRvG
 j3UsTfkc7ylJApBVt1VJPW2zUIBySA3s8ItVBvPgARnSoHcoh9uI1gTEepDDvdH6U2sa
 Abqv23vNdmTmfi4VKmuYqaWIFge4L+XKN6p2Ga8pj7yfB0ouNQPc98g+LwbTKjFhpjS4
 wM7w==
X-Gm-Message-State: AOJu0YwB5amqeF/OB2DQ1zHp/ARxFGYzhe2br5X9brELfF0OJzIvlksk
 fmt2vLz7azoXcUQZQ9SoEc8xGFRr76ZPVWBBHmxm1XSJV622eLbnOJ46U1XSVs7ddzNpeJWI+kP
 N4YJZFhpHThMiOk+XCJOg5dpUSH1QpckBGWA=
X-Google-Smtp-Source: AGHT+IEeVqwgVc9dDJ16+cFaiTJqpkRbOvXfp7c9OfXUyGiuED51K9XCy3Qo5ncQO28+ZCQOkE7aIbSxz6dlpbQ5+3E=
X-Received: by 2002:a05:6122:a0d:b0:4bd:54d0:e6df with SMTP id
 13-20020a0561220a0d00b004bd54d0e6dfmr46961vkn.1.1709778673077; Wed, 06 Mar
 2024 18:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20240228081028.35081-1-hrak1529@gmail.com>
In-Reply-To: <20240228081028.35081-1-hrak1529@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Mar 2024 12:30:47 +1000
Message-ID: <CAKmqyKPAop8B-QZPErvdx7ZPAB0Q=JtHe2k3Jvmniud7L6UrxA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix privilege mode of G-stage translation
 for debugging
To: Hiroaki Yamamoto <hrak1529@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Wed, Feb 28, 2024 at 10:14=E2=80=AFPM Hiroaki Yamamoto <hrak1529@gmail.c=
om> wrote:
>
> G-stage translation should be considered to be user-level access in riscv=
_cpu_get_phys_page_debug(), as already done in riscv_cpu_tlb_fill().
>
> This fixes a bug that prevents gdb from reading memory while the VM is ru=
nning in VS-mode.

Thanks for the patch. In the future can you ensure your commit message
wraps at around 70 characters?

>
> Signed-off-by: Hiroaki Yamamoto <hrak1529@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d462d95ee1..6e13069da7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1212,7 +1212,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, =
vaddr addr)
>
>      if (env->virt_enabled) {
>          if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL=
,
> -                                 0, mmu_idx, false, true, true)) {
> +                                 0, MMUIdx_U, false, true, true)) {
>              return -1;
>          }
>      }
> --
> 2.43.2
>
>

