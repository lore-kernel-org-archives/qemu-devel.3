Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3696EC35FF3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuiPf-0002UG-E0; Tue, 18 Mar 2025 21:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuiPa-0002Tb-JI; Tue, 18 Mar 2025 21:40:03 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuiPY-0008Ny-Od; Tue, 18 Mar 2025 21:40:02 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86d5a786c7cso2687469241.2; 
 Tue, 18 Mar 2025 18:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742348399; x=1742953199; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAsJkiLQoQFhjttu7+q7JwiD2QqI6oNCU+LxD4twIdw=;
 b=BTYvLqN5rtOkUNtxndK3eO6nD2mqEDIJdSp3GcyPs90tpoXDiRr2OkECqQN2nzoa+F
 HKmnUQdBGUUIiun5MZfX7W3emRho8PintbiamFfxVwlJVL8IBWB545OJ+SGnPjumQmbe
 /mp2D7MxCr/FiFvjCuE7Liwch5HNANnvf1oGDvVBeRMBFydZebXLb4vwKI16mf+BngDy
 MtSdeUHcTlIuP+8EU72wvyVT+K9s+cT0uo/riOvoHfHduvTb0XQH4OjwWXdiFoJ10wuV
 V2ZBYEOCcO3oNdMfmV7O10YYqmqXH/r1nzSnbAfkIM/F747kc3xgV0PZSnnqI2hvg5hk
 vebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348399; x=1742953199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAsJkiLQoQFhjttu7+q7JwiD2QqI6oNCU+LxD4twIdw=;
 b=DPzJr61jsu6DOicy0CWp5/HqPTcB7QtfhkyI1bua1YUEVH1atXRzK1ureAIZEAe4wd
 qMLIk2H1rK9+Ra524anMp4pu9n3Ji27CQT0uK3UozkQf612G8UdH2S8750UFt6m0ZwRQ
 ZRrpcPtBD1TKv+uCxzhwPBYrbNqPQpgh8F1XmgXLm0IpTeOBl6ZM5HVHz93DEp1uUp/o
 NXexg8aI1LRgayJhOizOtkmMG/4gGgl6/hitt9uHolpudP/7pyFsP8X7xm5tFOC1KpNY
 lcb9CSFqHm4EpuxjbaQIzoQ62LLSS2jdo18ZWroegVraMlG5m4NJgN3YmIXpKfn3KepE
 ltXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULXRtbbyEP+OJLP79wCVx99W563cm4cPdAuis3RVN/5o3DjOSueCMSYnDB/z2DPKWNwMCtFBg9NVDl@nongnu.org
X-Gm-Message-State: AOJu0Yx3rqwXw20XT9XzFa7RDi+NzIm9tsRggqCUGAIYxKjOUu50Oj7O
 oWDO1px2/c5PoeByNSYO/WlmIUKrTNGX43/TZls/6FXlaOYWF9RlSi0RBIJbRCq/OfQKYWkTKN9
 BYmzEYE6V3wNnd28OOstUwpvP9Uw=
X-Gm-Gg: ASbGncsDfj2f4LeGCj0uUJiCGV6J8PN5Eiy6uEBSJ8WeQzxRLPW6pBXBonRnoFXpwoZ
 o1veogvvSPpPOPbKMrIgDBxqj8PeXCl243EGodaIBNfo5lVfpGgr7f67tQZKGAUCDVlZIyrus26
 cqtKwTMFU7u5HoT64bKNFQTB+ek8mCLzLJvB9gr1u12IX8xvD1SpCTYUQ=
X-Google-Smtp-Source: AGHT+IEjNHp7VlhhFI8vWGw013Hngf/+rr4Ok+NIzwT5sF0Q1y2cylVy9SkWiv45n4Re7oxURvjIgg1NUHnR8NKhR5M=
X-Received: by 2002:a05:6102:50aa:b0:4bb:d394:46ce with SMTP id
 ada2fe7eead31-4c4ec61480amr588959137.3.1742348399244; Tue, 18 Mar 2025
 18:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250312192215.318565-1-paolo.savini@embecosm.com>
In-Reply-To: <20250312192215.318565-1-paolo.savini@embecosm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Mar 2025 11:39:33 +1000
X-Gm-Features: AQ5f1JrLOGsxraeKqxNhm_9SlBLjTG4AXSlRAxM93pw5Gkh31fNTpl4WJHSUzgU
Message-ID: <CAKmqyKNTnPfbZzZd=iC9hAtJvGDrJRABsd1FD-z1xDaxq64LkA@mail.gmail.com>
Subject: Re: [PATCH 0/1 v3] [RISC-V/RVV] optimize the memory probing for
 vector fault-only-first loads.
To: Paolo Savini <paolo.savini@embecosm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, 
 Nathan Egge <negge@google.com>, Max Chou <max.chou@sifive.com>, 
 Jeremy Bennett <jeremy.bennett@embecosm.com>, 
 Craig Blackmore <craig.blackmore@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Thu, Mar 13, 2025 at 5:23=E2=80=AFAM Paolo Savini <paolo.savini@embecosm=
.com> wrote:
>
> Adding reviewer information to the patch and rebasing on top of master.
>
> Previous versions:
>
> - v1: https://lore.kernel.org/all/20250129144435.82451-1-paolo.savini@emb=
ecosm.com/
> - v2: https://lore.kernel.org/all/20250221155320.59159-1-paolo.savini@emb=
ecosm.com/

This is already in the RISC-V tree, you don't need to resend it

https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Alistair

>
> Cc: Richard Handerson <richard.henderson@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Helene Chelin <helene.chelin@embecosm.com>
> Cc: Nathan Egge <negge@google.com>
> Cc: Max Chou <max.chou@sifive.com>
> Cc: Jeremy Bennett <jeremy.bennett@embecosm.com>
> Cc: Craig Blackmore <craig.blackmore@embecosm.com>
>
> Paolo Savini (1):
>   target/riscv: optimize the memory probing for vector fault-only-first
>     loads.
>
>  target/riscv/vector_helper.c | 103 ++++++++++++++++++++---------------
>  1 file changed, 58 insertions(+), 45 deletions(-)
>
> --
> 2.34.1
>

