Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72548D74956
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xnP-0001Pr-6x; Tue, 29 Oct 2024 21:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5xnM-0001Pc-W0; Tue, 29 Oct 2024 21:46:49 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5xnL-0001pp-DH; Tue, 29 Oct 2024 21:46:48 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84fc9005dccso1633337241.3; 
 Tue, 29 Oct 2024 18:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730252806; x=1730857606; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RrsnZ4un5P3fiw9/MjGP5pRGQfzoHDPJLADMDoBZNY=;
 b=jrdkRQgfP3zfDgJlPPjlTqocD5wtr0zf3YaOKNZ8Q+c2F6r5RIn4H7V1ShE/J7FAnW
 wAGgKI3ltoONLCcT/1y+TmULnbrhg9hr6yFPuiOEugDRXdpAq+vKYkjeyNgFJ90B3wqX
 BPBtGr71fUUsxaw4VL7kjGgiVaxIa8MV4TdvDMg2gNAuZ138qIJKpOGOqsyxcfguEb6F
 nQbT0N8y+zHiOSbiptnq082Rh6rl+mFDaX94YESIIaZPF1fopvwGwYzHLlHBs7X23AmN
 4kOLLal0517i2fiULhZj3xwTXUuS43trqe+OeIxtkTBogxys+pSSIOt9Rx1eISBBPxnf
 n1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730252806; x=1730857606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RrsnZ4un5P3fiw9/MjGP5pRGQfzoHDPJLADMDoBZNY=;
 b=s+7NjmZg9P+GDPrCAzH8MADGCUj0/yJE2t69q+oDdvc0wBqW2IYgxGKM0QimZdPWgg
 Sha5LPbSIRheBPqbIX+PUQ9POm92709UwhjswQhV8sAIJ9FxUPmZ0a29WoGZoTjQFELF
 Y0jFGgZHbu+Nh6qaFM7qUkZMPXePfktMS3w62PTAPn960LyYfOCxQV0ve+siWEsKltXh
 8pxoG+y42/2Z4IqvIwPPnWvO6emRSYuWu2jXEl8WGYR/JYSUW7Pn5s/9apZ1fL6qZYUc
 otecScDBp65Xz9i6nNMpVI5YsLKgk0NHwWxHBuuu7nRxBh+PnEMjbFwo2n2MPg2Nx7Mc
 Y8fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsTH+AjEOlEmIgBxnMfVYJottMOeMajd0ZxfyCk28wwz+CUXOyw7oP/0AqBfAvCuGfm26LfTGRGfgn@nongnu.org
X-Gm-Message-State: AOJu0Yw4PGIRu/OvpXfqZD6NgY52kdlvdgmrnfx7ZmKi2QpI1MgW87mA
 Rha/BkLb00h8wg1Euh53pKeoJ8r/4HWaN5r9Qa0OrZ0CwlTWbbXH38OryEHF4UUAu1JHvT8fqs4
 HfXg7dOnuePunDd9U15Est61giwI=
X-Google-Smtp-Source: AGHT+IHCgwD51E/EqZr8dquL8PuwhG01rplWjfzBJJbVH/gs2aicNls2DOy/ZRpvCWfKefyJJ+7x1fL+fKC1GPH7tkQ=
X-Received: by 2002:a05:6102:50a6:b0:498:d12b:4774 with SMTP id
 ada2fe7eead31-4a8cfb58dc5mr13136035137.7.1730252805843; Tue, 29 Oct 2024
 18:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241028182037.290171-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241028182037.290171-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2024 11:46:19 +1000
Message-ID: <CAKmqyKM4Ugk5aWFzSwng-7AYtapMpJpXrwYOjKK-JnFeGFjswQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/riscv/kvm: riscv-aia fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Tue, Oct 29, 2024 at 4:21=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this second version we removed patches 3 and 4 from v1. The reasoning
> behind is that the deprecation process is too harsh in comparison with
> the user benefit from using bools instead of strings.
>
> We'll expose the string property as bools when it's time to expose them
> in QMP and users will keep using the existing str prop.
>
> Patches based on alistair/riscv-to-apply.next.
>
> Changes from v1:
> - patches 3 and 4 from v1: dropped
> - v1 link: https://lore.kernel.org/qemu-riscv/20240924124407.766495-1-dba=
rboza@ventanamicro.com/
>
> Daniel Henrique Barboza (2):
>   target/riscv/kvm: set 'aia_mode' to default in error path
>   target/riscv/kvm: clarify how 'riscv-aia' default works

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/kvm/kvm-cpu.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> --
> 2.45.2
>
>

