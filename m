Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A8AC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 18:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVFCf-0001P3-Nz; Wed, 31 Jan 2024 13:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rVFCe-0001OQ-1U
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:20:52 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rVFCc-0008V1-7y
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:20:51 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-59a910a1265so50412eaf.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 10:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706725249; x=1707330049; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5nzSUsGtwDOpa5mVgavX+vD5ccBHZ1+xybNzom9gkDM=;
 b=EJIsd+8HZYIo3ZzcLJN2NtyCbT7ahFU8NmRPuq5u2XVgb8wSvS6M3eYcEhagsQKtv6
 a1ok40adgOEoGBGo+aRKH3kCmcw0LOp79wAXEuce9qVaWdQ0rSILJl2iZFprXB09ZZNh
 SJZagUjd4zBH5tElopvjXztPcM0fnHPOtd2Y/Le1qfeYZgEpUOnP9U3Ht1hcIKO1GwSE
 pn1XQTkH3JKHqEU3IS+aOThAkJwXHwyR4dR3l7tqSwMnjf8Cgxr4dRGdXRGBWeqqVNpx
 woAsI3CbCTM2jO9CwaS+uogHjOmClg4qo3Ypi9Za8E5k0HcsuAiDMERf9N9rYnaAqTos
 nPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706725249; x=1707330049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5nzSUsGtwDOpa5mVgavX+vD5ccBHZ1+xybNzom9gkDM=;
 b=f0zjto5spdISfRnyplnidAEmlLv+fdUZUemvF5h7cUrkw+dfJCxSWEKv+4fJcALzH8
 x/4Z/bRWDP7nKdZgmfqynntLQFPZy/W7t6iFLdhAf2evCbBecAotvAIl7r07hg2HyK33
 2PqqJhNaiav8PdnO4+Hn0C2StUwtzJGUZ4a+RqVdwxT2xdbDLlaNwGQOg5p3kHLeM8+F
 3LNta4w/evUz8ATvchDR3SDfWT4gJu40/T8eyRlIH2Wk24e+O8jbeLZBtnbxKd4iVpEB
 SIGlvEXBw9XQvppHfoH272b2erTzvwhFrvIOioKem+2zEC773KU6ZNW8plIlzafwsFCs
 jlsA==
X-Gm-Message-State: AOJu0YxWXVkZILqSkuKahUyyS9sTrjT8PtGThGl+WdaiS+G2znLOuKxw
 X0Ii+J/CLdxWjM4FqSl0P/ljnqGxA/U74gdNb+lIo9pfgxgV8bs0dUZ/ZJo4wOtepRk8iS86sU6
 ta+tJ5QMssv/aB0l2+V7IuuvZIqI=
X-Google-Smtp-Source: AGHT+IHPFDaL5R0u4JVoG0cJRFQ7IuSEn5SqHC7WVPA7Bzuf/ThSIeBbOqrKSRxz+u0Q4VWFrMbLHfJVpBlzcRr+qOg=
X-Received: by 2002:a4a:d018:0:b0:59a:e23:2831 with SMTP id
 h24-20020a4ad018000000b0059a0e232831mr2276572oor.2.1706725248860; Wed, 31 Jan
 2024 10:20:48 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QWE8P-GTNmFPbHvvDLstBZgTZA7sFg0qz4u28kUFiCAHg@mail.gmail.com>
 <mhng-125f45c7-5a14-4c91-af16-197a4ad2f517@palmer-ri-x1c9a>
In-Reply-To: <mhng-125f45c7-5a14-4c91-af16-197a4ad2f517@palmer-ri-x1c9a>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 31 Jan 2024 13:20:36 -0500
Message-ID: <CAJSP0QU8d6UdNgk25+BZoOy6OXFMAR9Ux=T445O8Ehir_UsTew@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, dbarboza@ventanamicro.com, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, afaria@redhat.com, 
 alex.bennee@linaro.org, eperezma@redhat.com, gmaglione@redhat.com, 
 marcandre.lureau@redhat.com, rjones@redhat.com, sgarzare@redhat.com, 
 imp@bsdimp.com, philmd@linaro.org, pbonzini@redhat.com, thuth@redhat.com, 
 danielhb413@gmail.com, gaosong@loongson.cn, akihiko.odaki@daynix.com, 
 shentey@gmail.com, npiggin@gmail.com, seanjc@google.com, 
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 31 Jan 2024 at 10:59, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 31 Jan 2024 06:39:25 PST (-0800), stefanha@gmail.com wrote:
> > On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
> >> I'm not 100% sure this is a sane GSoC idea, as it's a bit open ended and
> >> might have some tricky parts.  That said it's tripping some people up
> >> and as far as I know nobody's started looking at it, so I figrued I'd
> >> write something up.
> >
> > Hi Palmer,
> > Your idea has been added:
> > https://wiki.qemu.org/Google_Summer_of_Code_2024#RISC-V_Vector_TCG_Frontend_Optimization
> >
> > I added links to the vector extension specification and the RISC-V TCG
> > frontend source code.
> >
> > Please add concrete tasks (e.g. specific optimizations the intern
> > should implement and benchmark) by Feb 21st. Thank you!
>
> OK.  We've got a few examples starting to filter in, I'll keep updating
> the bug until we get some nice concrete reproducers for slowdows of
> decent vectorized code.  Then I'll take a look and what's inside them,
> with any luck it'll be simple to figure out which vector instructions
> are commonly used and slow -- there's a bunch of stuff in the RVV
> translation that doesn't map cleanly, so I'm guessing it'll be in there.
>
> If that all goes smoothly then I think we should have a reasonably
> actionable intern project, but LMK if you were thinking of something
> else?

That's great!

Thanks,
Stefan

