Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D443AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 14:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdVlk-0002Sl-3o; Mon, 12 Aug 2024 10:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdVlh-0002R3-6H
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:11:29 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdVle-0005GE-HG
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:11:27 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52efd530a4eso5949085e87.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723471884; x=1724076684; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pfWf/ngXQYnE2u2itjcrKImrtTr4LroRGjSrxyJGTNc=;
 b=tXslvMY3d5E8IA0cYlQXy2Bg7RiOYxR+QLqKCINahsgJYpQ5c610WJ0hd0l/n9lXJn
 1JNLfvdrHpj1Jul5Jqu+j5vx6/WgZs2VBq+Z1W4mibQpkPPwVt/Y2ia8xDMA6gZDerFQ
 fWucr0SlJklmt2HSOBTfJcPkoRsRSnY0EBaznb9pSrGgncgelUGsQG5WSZkpsMsIpJAt
 3qTSAQ/KBxMSS28tIRvEDXXSC5LVQsL3agv9HTGwp15N3VTmL6DliCB8dt1LGG36nPqP
 BYpiFyB4Ii1m8HcXZH/sRlVsUT0BQbPEwxnclRuLMNmHvbQZyny8r967qkyzX4Yxp+Vy
 CqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723471884; x=1724076684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pfWf/ngXQYnE2u2itjcrKImrtTr4LroRGjSrxyJGTNc=;
 b=XQSoEiCwetvH2hoJYKCMxXvwzDBnSAECVVqEjVKMm+gW1gMpAPKcQq4NOrBtjBVuD3
 ypBVMSvbWGVmyJnyCFXMmkoJ5h7jsWb8cgZCEbuD0tAnf24RKhBN+tOn9XbiuueyOOoU
 tuz/pgnh0o5cfdMFclr9fPO6mvyoyfizK1WPos9O/7Wx1x4+QOoC+QLOE0FPpdyrjM8e
 MqJ1kZOZJzqxAxHm9xu7zBdY1s/b1KrCC77EOTwQ2cpiX1NuL1mLTtc6+VKWyKGHXFX1
 eVWauQmohrI338GK2TJVfapGZ2NYxpaE2NxaV37nM+lxtxNczj1oB6RwixpRCwOYZ9Ar
 LjlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsu+vGMUPQbXPCnZ3o1wNwNjYzap7bBAsZ88by7eqoe0lpM1aSmG87tFsj7+5CYT4kgBKSjmg5v+LjszpzOhVQl+gjk4M=
X-Gm-Message-State: AOJu0YxtUKEmpCV67EemBpErYt8RWcQb0i2I8mVGwIJewvlAcHHPiGB8
 cu6yiUBZ3wwWvCx6GlpnOgUdtgbDAFrNPf8jNzDMiyUO+pEip6+xAkjdKGB7G1n+pFqfqR5xp5d
 Unsomd6dMBXv3mAKe5T2Syc6QnF0cOlyrVU3EeQ==
X-Google-Smtp-Source: AGHT+IFQxt0J6p9E2VAnTixhmoxy7BRGSySSrju5pFBT9ImxezoSafHCyLyU7L8dzMt4lzm+4OvyYdEIJDBGRyrMXxg=
X-Received: by 2002:a05:6512:3195:b0:52e:f9f0:f06f with SMTP id
 2adb3069b0e04-53213662e79mr179812e87.36.1723471883974; Mon, 12 Aug 2024
 07:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240717060903.205098-1-richard.henderson@linaro.org>
 <51b8f685-2ffc-4021-9d7c-bdabdc4ba177@tls.msk.ru>
In-Reply-To: <51b8f685-2ffc-4021-9d7c-bdabdc4ba177@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 15:11:12 +0100
Message-ID: <CAFEAcA9J54_G-wQY6HJKLZeVmgFwc5+gmcyGeGJW_z8k5avK_A@mail.gmail.com>
Subject: Re: [PATCH 00/17] target/arm: AdvSIMD decodetree conversion, part 4
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 11 Aug 2024 at 18:41, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 17.07.2024 09:08, Richard Henderson wrote:
> > Flush before the queue gets too big.
> > Also, there's a bug fix in patch 14.
>
> Hi!
>
> Has this patchset (together with the bugfix) been forgotten?
> Maybe we should include at least the bug fix for 9.1?

Thanks for the ping -- I had indeed lost track of the
patchset. The series itself is not 9.1 material, but
the bugfix could go in. (I don't rate the bugfix as
very critical -- nobody's noticed it in the at least
five years it's been there.)

-- PMM

