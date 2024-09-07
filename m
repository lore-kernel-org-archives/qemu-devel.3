Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560F6CE7B04
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 01:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smkZ3-0003qb-7w; Fri, 06 Sep 2024 21:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1smkYV-0003j1-8r
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 21:48:07 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1smkYR-0004Ol-KI
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 21:48:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 518165C013A
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2024 01:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F5CC4CECA
 for <qemu-devel@nongnu.org>; Sat,  7 Sep 2024 01:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725673672;
 bh=KaK41JPOiwkTi9ta791J8wS37yAgctFiFMaLNuuZ/y0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ja7P/h1Rik8bso2VeBsPNO38kUZ0kWeIIQcLp+37wbHG6PfM0cQJxvklf5lJXOmHw
 K1zK90HEKY7dn9Ms3pOy/zrdxWWNJW18Kz82/vtVy2G0suYAtQ3QMGBxKdoA8QzxK8
 1ZzvkK7u6n9zLz5pnvkNMBN2XpOyjMe7/TIvEshNaDAc1NAd5HL1VxfbWRnM9nYmL+
 FnLRwRwdBZUxvHsJxzzG57l+RvUX8Avk1XrsDDH4EPirCwSrWmpKTvsshwT1aW4PCk
 8qs9bYkZuREQYydjqWbGxGjM0mMZT24j71lcxPGzn5urSLpG+/cnSCEc9FxjOTU69C
 +Ija1Qd0zJCzQ==
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2f75a81b6d5so2919851fa.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 18:47:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCURCC+zP+iFfZufxna/o2oau+O//lVJQZt5kJqFsCPvZIp8K/HjHfzM+rAd5OkfCFi8X4FygMsRDn7G@nongnu.org
X-Gm-Message-State: AOJu0YyXHyTiHcp34xsOVfJKDJbQkV9F3KwCmJNtxlUMpLPD7zGl1he1
 v5j1ZQ9uNP6sNnVablkJnqyLBUn4L+KkbPGDhijroMprDPz8OUyticZGTGEp9jsQ8CDVCjob03v
 Ln0QOL/qJpI48te3QZEX3KIhaIaY=
X-Google-Smtp-Source: AGHT+IEAbN9Eqzj7/94jpm3ZQGTLWu4waEvFkSByhRyNjqTPy8Lz34CNrAmcTOD6tEPOYyD0XNKDboxR4rC3W+hfagk=
X-Received: by 2002:a2e:a983:0:b0:2f6:63d1:166e with SMTP id
 38308e7fff4ca-2f751eaee26mr34366321fa.3.1725673670870; Fri, 06 Sep 2024
 18:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <ZtsX_tcEuOjktUl9@zx2c4.com>
 <84a8ee9c-7781-c474-c394-d1498dc00050@loongson.cn>
In-Reply-To: <84a8ee9c-7781-c474-c394-d1498dc00050@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 7 Sep 2024 09:47:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5CbyemhjoYLXqW3pLPtp4Ne3wcOZXzv2k5=jJCpi3rfg@mail.gmail.com>
Message-ID: <CAAhV-H5CbyemhjoYLXqW3pLPtp4Ne3wcOZXzv2k5=jJCpi3rfg@mail.gmail.com>
Subject: Re: LoongArch without CONFIG_ACPI and CONFIG_EFI
To: maobibo <maobibo@loongson.cn>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, 
 qemu-devel@nongnu.org, thomas@t-8ch.de, xry111@xry111.site, 
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jinyang He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=chenhuacai@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Sep 7, 2024 at 9:44=E2=80=AFAM maobibo <maobibo@loongson.cn> wrote:
>
> Add huacai who is maintainer of Loongarch Linux kernel.
>
> On 2024/9/6 =E4=B8=8B=E5=8D=8810:55, Jason A. Donenfeld wrote:
> > Hi,
> >
> > It appears that as of QEMU 9.1, it's possible to boot LoongArch machine=
s
> > that don't provide EFI or ACPI.
> >
> > Would you consider removing the `select ACPI` and `select EFI` from the
> > arch Kconfig, so that kernels built for this minimal QEMU environment
> > can be a bit leaner and quicker to build?
Very difficult, at least removing EFI is difficult. Even if booting to
a FDT environment, we still get information from EFI now.

Huacai

> >
> > Jason
> >
>

