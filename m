Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E5C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 20:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUuir-0006hf-64; Tue, 30 Jan 2024 15:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUuip-0006hS-C6
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 15:28:43 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUuim-0008Hm-Lh
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 15:28:42 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-59505514213so110340eaf.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 12:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706646519; x=1707251319; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TYjiL86j5niPhaSV5lYxgLBEBpuOrxJ2AjgyyF2AcnM=;
 b=mGfTDHQRIzndbRmMgP/AnMYMTrxie6v8sJhow4TZskFW6YsxpZzz9D1JiaKNVm7n+g
 /1X3dIHHYbt5SKjKk6kKmBiJCk1JL6Pdh60YjbW4cPUwYsJNLN2MVp8Zja9XTwh9c5Ia
 8OnK1uGDWMAXoLRMgtu7XomLHjX/BbgtO9707LzXpSgLmD/Lxwpn8pVFbCIVb9rXGBVv
 qPGed8oXQNnRZwKvCtm/+AtZaGFAG3TeP5m7xXhc1VVic4Uk1pYO1c4fBQ2JogadSRQt
 mLegUfcxMxMAordJuATw0MhPe5WBuAVTq0/9rbhkZnhMjGdhr+GD3iD2AQvKjCB0oLA5
 pkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706646519; x=1707251319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYjiL86j5niPhaSV5lYxgLBEBpuOrxJ2AjgyyF2AcnM=;
 b=ldETSVQBp6l3HjuXvNfi+QO3pGT8n7dB7tSaa8VPn/Ot0bvsOOdPqfZOzi5r+24JI4
 eqFfCygYTpdSLa2JygoVtyaqotP2NxgCKQ8O6J1TDSlxWhbrOu+iE+q8tSJywtjVbtLi
 EwEMr9of0HaB44US1zOh5LfYe2Y9+A+aCDl8bnyFm/jFk8sCbxZggZ4CJXWK3HzaUaz7
 fa+4LmHGZ/RhGanFLEbE11efmtCA891tWE9RWsakwoHTYmwvEL2TRzWkRLsaHlC4M8yQ
 pDExwdtEYQ1aAcB1Ix4C7plm0lB0jKqWBWVcVztSUH1CB9zOaAQV9dA/ssM+No85iBOU
 5fgw==
X-Gm-Message-State: AOJu0YzQ/dPvbPCVGh6sJyJ4bRcWciudtHTqQ9xGten3HBoM//O7oaFp
 ASTxXylJi1dTqHHhLaufH/BJO+KE9mYzkHJ9vpViCSs1jhOQDgAoOKVPZCPFIpOO6HZXBsbXtH+
 PEVj4vnbwDeupsDuiClRH+jt/1kQbKAbX
X-Google-Smtp-Source: AGHT+IEgAFHJcT5ZyOD5Gq6Oo0pP5q1NgjrVNlQcrKs3vwi5+IJ3NA6BQXRkLImoda378AAHNUgK7bJmlJQgj35fiWw=
X-Received: by 2002:a05:6820:167:b0:59a:8848:de64 with SMTP id
 k7-20020a056820016700b0059a8848de64mr271290ood.3.1706646519301; Tue, 30 Jan
 2024 12:28:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <mhng-bcb98ddd-c9a7-4bb9-b180-bf310a289eeb@palmer-ri-x1c9a>
In-Reply-To: <mhng-bcb98ddd-c9a7-4bb9-b180-bf310a289eeb@palmer-ri-x1c9a>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jan 2024 15:28:27 -0500
Message-ID: <CAJSP0QU2M0e56M0S9ztMDO7eyqFB-p1KgwxJhzwkxt=CuS_PqA@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
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

On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
> > Dear QEMU and KVM communities,
> > QEMU will apply for the Google Summer of Code and Outreachy internship
> > programs again this year. Regular contributors can submit project
> > ideas that they'd like to mentor by replying to this email before
> > January 30th.
>
> It's the 30th, sorry if this is late but I just saw it today.  +Alistair
> and Daniel, as I didn't sync up with anyone about this so not sure if
> someone else is looking already (we're not internally).
>
> > Internship programs
> > ---------------------------
> > GSoC (https://summerofcode.withgoogle.com/) and Outreachy
> > (https://www.outreachy.org/) offer paid open source remote work
> > internships to eligible people wishing to participate in open source
> > development. QEMU has been part of these internship programs for many
> > years. Our mentors have enjoyed helping talented interns make their
> > first open source contributions and some former interns continue to
> > participate today.
> >
> > Who can mentor
> > ----------------------
> > Regular contributors to QEMU and KVM can participate as mentors.
> > Mentorship involves about 5 hours of time commitment per week to
> > communicate with the intern, review their patches, etc. Time is also
> > required during the intern selection phase to communicate with
> > applicants. Being a mentor is an opportunity to help someone get
> > started in open source development, will give you experience with
> > managing a project in a low-stakes environment, and a chance to
> > explore interesting technical ideas that you may not have time to
> > develop yourself.
> >
> > How to propose your idea
> > ----------------------------------
> > Reply to this email with the following project idea template filled in:
> >
> > === TITLE ===
> >
> > '''Summary:''' Short description of the project
> >
> > Detailed description of the project that explains the general idea,
> > including a list of high-level tasks that will be completed by the
> > project, and provides enough background for someone unfamiliar with
> > the codebase to do research. Typically 2 or 3 paragraphs.
> >
> > '''Links:'''
> > * Wiki links to relevant material
> > * External links to mailing lists or web sites
> >
> > '''Details:'''
> > * Skill level: beginner or intermediate or advanced
> > * Language: C/Python/Rust/etc
>
> I'm not 100% sure this is a sane GSoC idea, as it's a bit open ended and
> might have some tricky parts.  That said it's tripping some people up
> and as far as I know nobody's started looking at it, so I figrued I'd
> write something up.
>
> I can try and dig up some more links if folks thing it's interesting,
> IIRC there's been a handful of bug reports related to very small loops
> that run ~10x slower when vectorized.  Large benchmarks like SPEC have
> also shown slowdowns.

Hi Palmer,
Performance optimization can be challenging for newcomers. I wouldn't
recommend it for a GSoC project unless you have time to seed the
project idea with specific optimizations to implement based on your
experience and profiling. That way the intern has a solid starting
point where they can have a few successes before venturing out to do
their own performance analysis.

Do you have the time to profile and add specifics to the project idea
by Feb 21st? If that sounds good to you, I'll add it to the project
ideas list and you can add more detailed tasks in the coming weeks.

Thanks,
Stefan

