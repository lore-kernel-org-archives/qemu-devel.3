Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E9FD690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcUj-0005D6-Km; Thu, 28 Nov 2024 06:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGcUi-0005CF-BC
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:15:36 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGcUg-0001Mg-Oc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:15:36 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cfa9979cd1so505925a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 03:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732792533; x=1733397333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=za3EhzXj5DYygS5GFq2oYbV7IrxFuvLL5f1BW3LcY8U=;
 b=F1YObzB+EfeQe/94GpxwiAG1K2juVckh7W2gvF7xvQ6ziA1O+3HJ7QXCZdN+Dzgsp3
 TOaslWiex5O5x8eJrmTwgcUnUTSo9eE7F1HSkeoeQOgwnoUarBQ5wbFRj1jgQdOhFelz
 9xf0pDg006BDRRp+ORlp7avwYcB3HMlSuDIuXGtSlk6cDmZaBytE9v0usdZVtu+98CzK
 1z8V/cH5qEjVJVMm/BW2P2HmhXCAtDaIjcmj+1BUTCiEAnre342vJQsUjLLVxEYnOr2y
 C7pg+AFh3CJV5YYQRoaaAcGoKXi3oOq30mzBFP8gjQC1DcrcAmIhLgHYG+nDEdUnsGfj
 d3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732792533; x=1733397333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=za3EhzXj5DYygS5GFq2oYbV7IrxFuvLL5f1BW3LcY8U=;
 b=rF7r9SRwoa0yy9iQJEvGcHJQgW8a5z65E3iaNn5V/kiVba0LgZPw5TS16oUrDNSI/7
 ZTBENrfrOsSjSmdNXdXfXngQYikXordWVECUYn/isco6ijLDwtceETiLj2kFyq0GUWmV
 K6DXp6x8Mz86axCfe3Ibmd9zqhmjYxWHBKeJ39VXeJwvg6uVk39+Icfj1QWyLurUfy87
 ZxXQ+m+ZWhd1KaW82KUAdak397xoJ3c1FUxhw5En8w8xfQUiY5EZXL4yqVrHf+3m9leB
 PrbHxBw2xQD6V0QEyKXrI1sVhO2SyyHxvPP2OQFIScd9V678GWUTD3PJtP732GE0VIVJ
 9K6g==
X-Gm-Message-State: AOJu0YykkEE0ckJamnXau1titABTl+MWAbczUoM6Udji6JKzBtyKFKf/
 Nh1jcZbw2qFa1Fr14MSt2zSTJaIpVxpK5bUax+h5g3EyBHikCjDJrDIBJUVqbsIEtZdCIK5jcHq
 knOYQN75GRbjwgeccCmMiFiqBGS9HRa2l6Dbk6Q==
X-Gm-Gg: ASbGncu5cSc2Vefl6E8IKIk9u5Jo1GzZ5QSdIEh0iNBZ9RRbwUOcukPxZ+831JysT1A
 BXS983/3kgxsvNAz794zWBJ3wiCWjfClF
X-Google-Smtp-Source: AGHT+IHzKYkoDaivWTP2ywe8+TEuHdQpl+8krpSBt+W3eqmD2ffqTsFbyn2dxiaKQodCz6wU2fYfrvPRT4QzLcEBFlk=
X-Received: by 2002:a05:6402:510b:b0:5d0:96db:dc29 with SMTP id
 4fb4d7f45d1cf-5d096dbe832mr1954588a12.3.1732792532998; Thu, 28 Nov 2024
 03:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <0ace2747-efc8-4c0a-9d9f-68f255f1e3a5@igel.co.jp>
 <CAFEAcA8oDPD7xdhMC__Rp3WOzSdm9CnSHw-bepvQnxK3BMzVOg@mail.gmail.com>
 <1499e05e-acf6-4e4f-8929-e8bec5b92fac@igel.co.jp>
In-Reply-To: <1499e05e-acf6-4e4f-8929-e8bec5b92fac@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2024 11:15:22 +0000
Message-ID: <CAFEAcA85NOxbmzpCT-5jv5uvcFH2WU5zm+fRTAK-VVG6LQRLbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] support unaligned access to xHCI Capability
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk, 
 foss@defmacro.it, qemu-block@nongnu.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, farosas@suse.de, 
 lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 28 Nov 2024 at 06:19, Tomoyuki HIROSE
<tomoyuki.hirose@igel.co.jp> wrote:
>
> Hi, thank you for your comment.
>
> On 2024/11/27 20:23, Peter Maydell wrote:
> > On Wed, 27 Nov 2024 at 04:34, Tomoyuki HIROSE
> > <tomoyuki.hirose@igel.co.jp> wrote:
> >> I would be happy to receive your comments.
> >> ping.
> > Hi; this one is on my to-review list (along, sadly, with 23 other
> > series); I had a quick look a while back and it seemed good
> > (the testing support you've added looks great), but I need
> > to sit down and review the implementation more carefully.
> >
> > The one concern I did have was the big long list of macro
> > invocations in the memaccess-testdev device. I wonder if it
> > would be more readable and more compact to fill in MemoryRegionOps
> > structs at runtime using loops in C code, rather than trying to do
> > it all at compile time with macros ?
>
> I also want to do as you say. But I don't know how to generate
> MemoryRegionOps structs at runtime. We need to set read/write function
> to each structs, but I don't know a simple method how to generate a
> function at runtime. Sorry for my lack C knowledge. Do you know about
> any method how to generate a function at runtime in C ?

Your code doesn't generate any functions in the macros, though --
the functions are always memaccess_testdev_{read,write}_{big,little},
which are defined outside any macro.

The macros are only creating structures. Those you can populate
at runtime using normal assignments:

   for (valid_max = 1; valid_max < 16; valid_max <<= 1) {
       [other loops on valid_min, impl_max, etc, go here]
       MemoryRegionOps *memops = whatever;
       memops->read = memaccess_testdev_read_little;
       memops->write = memaccess_testdev_write_little;
       memops->valid.max_access_size = valid_max;
       etc...
   }

It just happens that for almost all MemoryRegionOps in
QEMU the contents are known at compile time and so we
make them static const at file scope.

thanks
-- PMM

