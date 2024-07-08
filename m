Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5072C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQdxt-0006hi-9f; Sun, 07 Jul 2024 22:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdxl-0006RE-Ip; Sun, 07 Jul 2024 22:18:46 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdxk-0001iw-44; Sun, 07 Jul 2024 22:18:45 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4e4efbc3218so1436653e0c.0; 
 Sun, 07 Jul 2024 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720405122; x=1721009922; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKIwMRn5Yli7LICD1JPIutBeKifZLgq3ExSaGGJGA9Y=;
 b=M8I4bPNk9IgQluOR4NaQFhpC0vjCBpxPrzyxc5bA14zdfYQWuUIDngrDozsbHspz0r
 hA9DCHGm2VmqqYu9ZBAqVTwnHfS04448LD3auKAVzxhFLE9nhJ6BJLCxWNBMDzsrLPPa
 GFHkm8M4l5kG7IKsVBeRvUBK7dkt9lbeaV4ZK0mbbWcCMCY17R1Injgyxm5H2cvo0xZ6
 fRks8708d6lbNyYYqIMc+QflB83oSd2jdfnBSZO8acw/MJyHMrQ04YniKhB4xmGhxsbB
 +WNfzIwZLza4tRDBzFd5NT+nRKhK9x7fD/nIqvpt5nVRKJ7qDldZRVnThGPeYdeV9qdW
 CwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720405122; x=1721009922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKIwMRn5Yli7LICD1JPIutBeKifZLgq3ExSaGGJGA9Y=;
 b=jMY1sMe3vlePRjD6NtH9I10BCJK1UCc7IvqJ7JXH9cepMgS8enOzJy8l4d3mdzjawu
 wkNinWEBVj8pI+zlToMGqMC4KmxfRAjPCE1rTiEO12T4eCO//AgRa6eUCmLotuS2PZ8j
 0ZkK6/yHB8qx6mhgiyIFe/e42HGqtcAoI3p2kHRvCeqCvfVc6Ti1tV8Nqogptjn68FR5
 nD9mD5WQmOgq0aaUjyTfSnonWKpGh8pbd8TDYjepmR1UQnbaw+jd606LB5PO4+DeUWFu
 zYx105qELKZlW1eNTTlQKHcOQLhpQyBbiJg/QMnqr+Pv1mj1J0gfYjnAYfkP/LSZa0ob
 aNdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfjmBSQmnl9konQL6gyio6w5nuklIZzKELE24IoP/mTHjhC0vLr309HYLendJ92t4BB1SUOMLKMRjSTx3uK90vB4phpqY=
X-Gm-Message-State: AOJu0Yx3P7NLnA8D9Z4lO/NnJNUgOLNKVk4rpD1N041srXsyd9PARNuN
 zYqvyY0C/29+zWGUlKKXCUVM6tTH6F5ofIe5nbGTeb3R7IeNcOn9pC7ih+stnpVpcsa3sIVznhS
 q7bCzVC+yZYe8cG7O53qBn+TCWs4=
X-Google-Smtp-Source: AGHT+IGz+PqsTCj0KymLaDlcZ9ZFXB5uMs78+lDQYquYQVtOJ7Dtw0BbRBxZjBX/HTM/y75jw5c8oYNSjZsA2ovM0LM=
X-Received: by 2002:a05:6122:4306:b0:4ef:6731:83c6 with SMTP id
 71dfb90a1353d-4f2f3f16330mr11452071e0c.9.1720405121687; Sun, 07 Jul 2024
 19:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
 <7a0f63e4-9634-4274-af00-93c4a4e34810@ventanamicro.com>
In-Reply-To: <7a0f63e4-9634-4274-af00-93c4a4e34810@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 12:18:15 +1000
Message-ID: <CAKmqyKMWTjPnQa1x-n8EEEgwHFjVmBR7jPjcNHH85VoNMBBLuw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] riscv: QEMU RISC-V IOMMU Support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 frank.chang@sifive.com, jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Sat, Jul 6, 2024 at 7:26=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> Would it make it easier for review if we squash patch 3:
>
> [PATCH v4 03/14] hw/riscv: add RISC-V IOMMU base emulation
>
> and patch 8:
>
> [PATCH v4 09/14] hw/riscv/riscv-iommu: add s-stage and g-stage support
>
> In the same patch?
>
> I'm asking because I've been noticing since the first versions that some =
reviews
> on patch 3 seems to refer to context that are s-stage and g-stage related=
, i.e.
> added later. Perhaps squashing them together makes it easier to review si=
nce
> we'll have a more complete picture. Patch 3 will end up gaining +381 line=
s
> though.

Squashing is probably the way to go

Alistair

