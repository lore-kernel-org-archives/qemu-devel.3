Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10F2C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtyh-0001XH-SP; Tue, 30 Jan 2024 14:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rUtye-0001Vi-En
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:41:00 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rUtya-00089K-5H
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:40:58 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso2958465a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1706643653; x=1707248453;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=9AW16PRokhMGl06KG1+mzOcMotYScHaSgwc9WRqUlNM=;
 b=BL1ohqg0p2v9PSwaU3erbF0rZfeD/FXKZu2FGy/VI8LdqKUXC5Qau67XnAV4u+jRxA
 /ilcxZ5h71ZNRGqaFztV5bk6jL4FB+jGwHQ+1+osj5bx7zIGPEiXxa+3bNwGebgWyNBM
 9m/75whXRdHz5NQ/pkd3YKExJS9vkStB3TyFzNAwnRVQqnDqY30uPVayYZ1yDKVbDW6j
 JigDX0pNsYqMsSDhAdMBlOAR36YyJEbs9eMMmrXqy+SGb7wPU/GjUvhWeGlhfXDF9D0u
 YuO/ZwhIRNu0UeXye3sO4dratpa6xqxkrAX84buqHcEImhfeCykHfQc4OGHed9Hu/sle
 If+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706643653; x=1707248453;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AW16PRokhMGl06KG1+mzOcMotYScHaSgwc9WRqUlNM=;
 b=XISUaLu6VOErRQDEPAj9aqg+BktfE7uKhyldUx/m12awrYHMSQFp8svrckdjqBWROJ
 l/9LVVE2bLCS5x0Z03xOVYFYV9DPI/kFh05pCo7i/QhD3NuRF612V2Uge0tTx/6oTkQe
 6/A0mv5vNcivot6VEg/h3BxK8T52XyB8m7NRQifyzlO7LS1cVGNSk3gsbayQLG0lieW8
 3d4LljbI1jZwN5wK8OyLtwD1xV7CfujFLdlFhrULojl3s8ct4ZN3me2vv2SZG8kY637c
 N+8CNYCHkmvpXWLgw30204AUHViYFAz7TnHuVsTDJByqQyLTVHhdkyQ8WiSUNbYia4s8
 h/qQ==
X-Gm-Message-State: AOJu0YzzJtRmXq9Fxx8WkcKgvI5B/krvu2DJXtWsAAMPu0MUwdBn//iS
 Jn/gFC5TGh6eNsDd1+2FaGv0Fr8Srr2GnZrYZNlBjdolBfPybFNlGaeig0rhLrKIohywJoxDmLJ
 t
X-Google-Smtp-Source: AGHT+IE2ABRPgbWZ1/MDn9OpRWpB/SaUaaTOUydu8QmhFKdM9K+7ePH7kuhrq0irpESYDV32az2H2g==
X-Received: by 2002:a05:6a21:920c:b0:19c:9ce0:6d87 with SMTP id
 tl12-20020a056a21920c00b0019c9ce06d87mr8460525pzb.0.1706643653109; 
 Tue, 30 Jan 2024 11:40:53 -0800 (PST)
Received: from localhost ([12.44.203.122]) by smtp.gmail.com with ESMTPSA id
 i26-20020a63541a000000b005cd78f13608sm8579092pgb.13.2024.01.30.11.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 11:40:52 -0800 (PST)
Date: Tue, 30 Jan 2024 11:40:52 -0800 (PST)
X-Google-Original-Date: Tue, 30 Jan 2024 11:40:44 PST (-0800)
Subject: Re: Call for GSoC/Outreachy internship project ideas
In-Reply-To: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
CC: qemu-devel@nongnu.org, kvm@vger.kernel.org, afaria@redhat.com,
 alex.bennee@linaro.org, eperezma@redhat.com, gmaglione@redhat.com,
 marcandre.lureau@redhat.com, 
 rjones@redhat.com, sgarzare@redhat.com, imp@bsdimp.com, philmd@linaro.org,
 pbonzini@redhat.com, 
 thuth@redhat.com, danielhb413@gmail.com, gaosong@loongson.cn,
 akihiko.odaki@daynix.com, 
 shentey@gmail.com, npiggin@gmail.com, seanjc@google.com,
 Marc Zyngier <maz@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: stefanha@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 dbarboza@ventanamicro.com
Message-ID: <mhng-bcb98ddd-c9a7-4bb9-b180-bf310a289eeb@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=palmer@dabbelt.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
> Dear QEMU and KVM communities,
> QEMU will apply for the Google Summer of Code and Outreachy internship
> programs again this year. Regular contributors can submit project
> ideas that they'd like to mentor by replying to this email before
> January 30th.

It's the 30th, sorry if this is late but I just saw it today.  +Alistair 
and Daniel, as I didn't sync up with anyone about this so not sure if 
someone else is looking already (we're not internally).

> Internship programs
> ---------------------------
> GSoC (https://summerofcode.withgoogle.com/) and Outreachy
> (https://www.outreachy.org/) offer paid open source remote work
> internships to eligible people wishing to participate in open source
> development. QEMU has been part of these internship programs for many
> years. Our mentors have enjoyed helping talented interns make their
> first open source contributions and some former interns continue to
> participate today.
>
> Who can mentor
> ----------------------
> Regular contributors to QEMU and KVM can participate as mentors.
> Mentorship involves about 5 hours of time commitment per week to
> communicate with the intern, review their patches, etc. Time is also
> required during the intern selection phase to communicate with
> applicants. Being a mentor is an opportunity to help someone get
> started in open source development, will give you experience with
> managing a project in a low-stakes environment, and a chance to
> explore interesting technical ideas that you may not have time to
> develop yourself.
>
> How to propose your idea
> ----------------------------------
> Reply to this email with the following project idea template filled in:
>
> === TITLE ===
>
> '''Summary:''' Short description of the project
>
> Detailed description of the project that explains the general idea,
> including a list of high-level tasks that will be completed by the
> project, and provides enough background for someone unfamiliar with
> the codebase to do research. Typically 2 or 3 paragraphs.
>
> '''Links:'''
> * Wiki links to relevant material
> * External links to mailing lists or web sites
>
> '''Details:'''
> * Skill level: beginner or intermediate or advanced
> * Language: C/Python/Rust/etc

I'm not 100% sure this is a sane GSoC idea, as it's a bit open ended and 
might have some tricky parts.  That said it's tripping some people up 
and as far as I know nobody's started looking at it, so I figrued I'd 
write something up.

I can try and dig up some more links if folks thing it's interesting, 
IIRC there's been a handful of bug reports related to very small loops 
that run ~10x slower when vectorized.  Large benchmarks like SPEC have 
also shown slowdowns.

---

=== RISC-V Vector TCG Frontend Optimization ===

'''Summary:''' The RISC-V vector extension has been implemented in QEMU, 
but we have some performance pathologies mapping it to existing TCG 
backends.  This project would aim to improve the performance of the 
RISC-V vector ISA's mappings to TCG.

The RISC-V TCG frontend (ie, decoding RISC-V instructions 
and emitting TCG calls to emulate them) has some inefficient mappings to 
TCG, which results in binaries that have vector instructions frequently 
performing worse than those without, sometimes even up to 10x slower.  
This causes various headaches for users, including running toolchain 
regressions and doing distro work.  This project's aim would be to bring 
the performance of vectorized RISC-V code to a similar level as the 
corresponding scalar code.

This will definitely require changing the RISC-V TCG frontend.  It's 
likely there is some remaining optimization work that can be done 
without adding TCG primitives, but it may be necessary to do some core 
TCG work in order to improve performance sufficiently.

'''Links:'''
* https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04495.html

'''Details'''
* Skill level: intermediate
* Language: C, RISC-V assembly

>
> More information
> ----------------------
> You can find out about the process we follow here:
> Video: https://www.youtube.com/watch?v=xNVCX7YMUL8
> Slides (PDF): https://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf
>
> The QEMU wiki page for GSoC 2024 is now available:
> https://wiki.qemu.org/Google_Summer_of_Code_2024
>
> Thanks,
> Stefan

