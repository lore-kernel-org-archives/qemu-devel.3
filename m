Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93B7C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcxC6-0007hh-SG; Tue, 28 Jan 2025 20:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcxC4-0007hK-RD; Tue, 28 Jan 2025 20:48:40 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcxC3-0005G4-5T; Tue, 28 Jan 2025 20:48:40 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5188e0c2b52so1879367e0c.1; 
 Tue, 28 Jan 2025 17:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738115318; x=1738720118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7MpE9inRxOKKIFwH942mtqsH7coM70jyAcWa1TzOB8=;
 b=Ui9cCQmxIGlkgTt87Jb8Zvqf6RIl74XpCsQBz1YIsbBn4ePls5v01cB72yjXIn89Ch
 8WuZP5p58HNqIshUksBe4+FpXxFJv/ipMQDj2QI6v7U54Ro/KCri2EaVzR+P/f2Acax4
 oSUjQptaiQvN5+Gvlf9rM0wYpbA3lHmDsSjl4nUGfp+3b0lFP7f8PYZhiFhnTAJz5zeM
 Th1va04Lg/HPLLcrocUUwmhqU3UbWwGY/eYJZJnf+vMaQJduxKh89HuH5rMTrf9zSr5P
 zy1YOnAy4ZMhGMOkgc/4uIOJO21ollJ20v81q9TjsZPNdHHOvISt1X3AlEIPKBtreACx
 Ca3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738115318; x=1738720118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7MpE9inRxOKKIFwH942mtqsH7coM70jyAcWa1TzOB8=;
 b=UgJvvaPUHPSQ5Lno0xsADKmhITKDUGyIN0R0YL8vYiyNW2IlZbALdb6vwaDWF+yhAo
 B0J3zbVed05gfAeSDjQWQcB0RUwAIwjk6rfrrufqB2T1EG+k1Pv90XlQw0KRolJNagGl
 MGa8W0mDlc6lbABMr8TkrnA5LM/EG7S7ENQXEA7/1nof1BxtPc3SlQEcR2FD27OjPEsw
 3TThEDxu5Xc97gsNSQFEcVxyr7DXxRIK5CSxNrNSxcr+LNgcic+Jy9E55N08B8DR/Sjf
 EsWBvS+LRKPneCj+2X2/8Eh5R1kcfJtn76geBA7nTX6WtbZnuA6Q/a86nP+pGFZuaX02
 M4eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUef1ARathXRhb7OP6wqZmzrsljP8+Iu/uKFZTV7pCyK+ienK7ys/ly0MiHqsbNc0u1VwGnkRPAbzv+@nongnu.org
X-Gm-Message-State: AOJu0YzehpEq/52hg5VGZ1kMIzk2gT+1wjOfw3oAKuvEX0fSkDrBIv8N
 xUHs+9ZovqmsmUHBicOqMVlXkQRYGMpHTpvzMeWwmrOrmjv9f3KO8uwOnERJMI3aueqGm9xArHN
 N4Qmd5gYdwmL2mBSw+6+ALKZfPCv+cA==
X-Gm-Gg: ASbGnctSvrRdl0NIRcjHRc1Hx42fSLzfxvhXX1FK8bsAa1/26L0499kDJu6rJdnqclW
 eHkQlQt6Z+bmIZPcx+BJMd0Ekr7G3AOIeU+wtHzVa45TjusNf3urLeOTsuU2Hbl4YKB/NZYKF9a
 ndvErOrbS33+QmjKIuDoOJzBO6Ww==
X-Google-Smtp-Source: AGHT+IG6cB0+lcZyQn04P51zfEpHrzi0biN5QUqGu26PXz8ov830X5MxYKEk+lT3n2BX4CyU+uCQaQiqLCdyL58XCkA=
X-Received: by 2002:a05:6122:17a6:b0:516:240b:58ff with SMTP id
 71dfb90a1353d-51e9e45ecc4mr1920942e0c.5.1738115317630; Tue, 28 Jan 2025
 17:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:48:10 +1000
X-Gm-Features: AWEUYZkAcBUtot1696tZIMqqqjThBCemLCkqXcIy5bEjdr4PXtOjvTLOJfuot70
Message-ID: <CAKmqyKN-+Jo0Hoexk5Up=DBiHqmB_6-SK87Gwx-+bEORoAwQQQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] target/riscv: throw debug exception before page
 fault
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Wed, Jan 22, 2025 at 3:07=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this new version, in patch 2,  we're using the address 'size' val from
> riscv_cpu_tlb_fill() instead of infering it from the CPU XLEN.
>
> No other changes made. Patches based on master.
>
> Changes from v2:
> - patch 2:
>   - use 'size' instead of infering wp_len using the CPU XLEN
> - v2 link: https://lore.kernel.org/qemu-riscv/20250120204910.1317013-1-db=
arboza@ventanamicro.com/
>
> Daniel Henrique Barboza (2):
>   target/riscv/debug.c: use wp size =3D 4 for 32-bit CPUs
>   target/riscv: throw debug exception before page fault

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu_helper.c | 18 ++++++++++++++++++
>  target/riscv/debug.c      |  6 ++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> --
> 2.47.1
>
>

