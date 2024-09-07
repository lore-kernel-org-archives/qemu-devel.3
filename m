Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FD9CE7B04
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 02:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smlVy-00015Y-Fe; Fri, 06 Sep 2024 22:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=+fej=QF=zx2c4.com=Jason@kernel.org>)
 id 1smlV9-0000rT-SS
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 22:48:50 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=+fej=QF=zx2c4.com=Jason@kernel.org>)
 id 1smlV5-0001ww-7k
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 22:48:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 48B83A43F0D;
 Sat,  7 Sep 2024 02:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FEFC4CEC4;
 Sat,  7 Sep 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="fqO02YY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725677304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tEnVSgl4KWu1DsgL0C8TGbUh8FjzR6eAkgRRbuiFhw=;
 b=fqO02YY5HU2dzIXH4LOY7waP1KOWEKEq+VK2fi3DFd0ALf2jlq4EUKGsxhcXb8luexzVoh
 ln7+wBl1ecMkfj7zz+xVXxfFN25l7W2561YA50qHpmhc1r6x0u0AU+BLvbUUH7ezTwXtNP
 geFkd0DFal/qrafG/iixh225s5PpreI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b2310a09
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 7 Sep 2024 02:48:24 +0000 (UTC)
Date: Sat, 7 Sep 2024 04:48:22 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo <maobibo@loongson.cn>, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de,
 xry111@xry111.site, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: LoongArch without CONFIG_ACPI and CONFIG_EFI
Message-ID: <Ztu-9qgiKS98c0hl@zx2c4.com>
References: <ZtsX_tcEuOjktUl9@zx2c4.com>
 <84a8ee9c-7781-c474-c394-d1498dc00050@loongson.cn>
 <CAAhV-H5CbyemhjoYLXqW3pLPtp4Ne3wcOZXzv2k5=jJCpi3rfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5CbyemhjoYLXqW3pLPtp4Ne3wcOZXzv2k5=jJCpi3rfg@mail.gmail.com>
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=SRS0=+fej=QF=zx2c4.com=Jason@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Sep 07, 2024 at 09:47:38AM +0800, Huacai Chen wrote:
> On Sat, Sep 7, 2024 at 9:44 AM maobibo <maobibo@loongson.cn> wrote:
> >
> > Add huacai who is maintainer of Loongarch Linux kernel.
> >
> > On 2024/9/6 下午10:55, Jason A. Donenfeld wrote:
> > > Hi,
> > >
> > > It appears that as of QEMU 9.1, it's possible to boot LoongArch machines
> > > that don't provide EFI or ACPI.
> > >
> > > Would you consider removing the `select ACPI` and `select EFI` from the
> > > arch Kconfig, so that kernels built for this minimal QEMU environment
> > > can be a bit leaner and quicker to build?
> Very difficult, at least removing EFI is difficult. Even if booting to
> a FDT environment, we still get information from EFI now.

Makes sense. !ACPI is the more interesting one for me, anyway, as that
takes a while to build.

