Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2D4C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 16:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWHY-00082k-UX; Fri, 21 Feb 2025 11:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlWHV-00082a-KW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:53:42 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlWHT-0008Cv-QB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:53:41 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so1826942276.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 08:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740156818; x=1740761618; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lXyseHkOIxpZbDUhPQpGD6sZGyMtv5H2mjwXcSuTWzc=;
 b=zpUHu4npFmoa4+nDbgKCGY2zGbe6bd2g3Vvj/t239wcAFd5KoRlpZ7q9KjOmXcO/b3
 5F93pbCIb29DE4TUl75E6xMokPC+MMzufHkQ/HyVHAMW2ys/jkhyKcPA3QMZBqsKVI5l
 ledGHL5V93DaPJKJj/kK3AMKww5IX+8G8MqOLZawYBw0dwcRWwQi0gLmPzurm2EQAOv3
 tBrmqTGOn8fhGVoiSFJbMQbvb0o4LLQUaREUB6OooxcWcmdSDQ0Ny66rml05V0MJJje6
 znIFpUGCsKlHeelmFAtuRg70DiUheCtJmWUjo0qjErHJtfLiTPbPdJtCasGrOah7my5o
 O6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740156818; x=1740761618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lXyseHkOIxpZbDUhPQpGD6sZGyMtv5H2mjwXcSuTWzc=;
 b=jUYn2axydGeNV6rA7PQnwjnlElkTzvV7ErUkPqMvifPp6qpiijRDzHaBQzMXXADHNT
 JZHncQxFUquJv486/6H9VzeVBWKl9EbwTEWkh09tzMHJw1N8CsZ/4lQwnNfI8mFdGSC2
 +1o+7fetDXESYxPqPLZF3YHVAy/zM1cPSAqDd8zmFaflMPqOsYTtRRvWoqibE83I5XW/
 7befgCRs1vkxfxpQMjbIeJVwYb07GJpt4b0+VRSLrOa2e+SkaND2+SsGVw6IWOz6wLpB
 5rXVZqDdifqHzjncq4vVEUqAOMZFfut12T8QnDnAbq50UC5oLUVCW8gpkg6d0OSaL7kQ
 rVLw==
X-Gm-Message-State: AOJu0Yx+dhOBHPJWbvPfV7Q2jsMo/4ma+YVnIQRDn4qtxLoXANcW+gBD
 EGBy3lVibrf9147MpGbvmCp1uxJ4F1/muSgoICRdA10+gk2T07O5E1odkhN0E5+YM991Sca1sif
 YRiWz+1umrzB7zYNjP1EuBKH7Guepim+Bru4ZiQ==
X-Gm-Gg: ASbGnctXn0xn8PmKyCbyF2W6BY7Ouvv/yYmzDYJ7tPC0DiKdbPFHUGu4bTGN0SUnEgR
 Mgu8jNu0NNSCfDq+HqgT1Ov1Y+84wX4554J6MYOTCHSbf4BOH1WLPHQZRcddswQSBVvyOlSrio3
 zLBICok6rw
X-Google-Smtp-Source: AGHT+IH1/5AtjZAib55FGx5bFGVAlySaQNreIQxv0ONecUmsur20zc5OzFPQcuVPnZcUynVUmoDF2ZXeFTw0d66SCDc=
X-Received: by 2002:a05:6902:90f:b0:e5d:b88a:5536 with SMTP id
 3f1490d57ef6-e5e2468a253mr3315238276.44.1740156818007; Fri, 21 Feb 2025
 08:53:38 -0800 (PST)
MIME-Version: 1.0
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2025 16:53:26 +0000
X-Gm-Features: AWEUYZnEXjnhZ6MexkqDZJKCSK16XYuHp6yO0d5_a5ndUPUOU0CgFxtuAZod9jw
Message-ID: <CAFEAcA9pEajzzPidCJG3iZraH3FneKv=LGpidn+3cDhM_=XjfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/19] Factor out HVF's instruction emulator
To: Wei Liu <liuwe@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, wei.liu@kernel.org, dirty@apple.com, 
 rbolshakov@ddn.com, phil@philjordan.eu, jinankjain@linux.microsoft.com, 
 liuwe@microsoft.com, muislam@microsoft.com, ziqiaozhou@microsoft.com, 
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com, prapal@microsoft.com, 
 jpiotrowski@microsoft.com, deviv@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Fri, 21 Feb 2025 at 14:02, Wei Liu <liuwe@linux.microsoft.com> wrote:
>
> Hi,
>
> Microsoft's Linux Systems Group developed a Linux driver for the Microsoft
> Hypervisor (MSHV for short). The driver is being upstreamed. The first
> supported VMM is Cloud Hypervisor. QEMU will be the second supported
> VMM.
>
> The plan is to write an mshv accelerator in QEMU. The accelerator is still in
> the works.
>
> MSHV doesn't emulate instructions. VMMs are supposed to bring their own
> instruction emulator. The path we've chosen is to reuse what's already in QEMU.
> The instruction emulator in HVF looks good for what we need.
>
> This patch series attempts to make the instruction emulator in HVF a common
> component for the i386 target. It removes HVF specific code by either using a
> set of hooks or moving it to better locations. The new incoming MSHV
> accelerator will implement the hooks, and where necessary, enhance the emulator
> and / or add new hooks.

If you want to make the hvf decoder more widely used you might want
to look at this old patch to it that was never applied (issues in
code review not addressed by the submitter):

https://lore.kernel.org/qemu-devel/CAFEAcA8yaBOD3KXc-DY94oqzC5wkCENPkePgVCybqR=9NmdQFQ@mail.gmail.com/

which is trying to fix a problem where an overlong string of
prefix bytes causes the decoder to misbehave.

(PS: if in the future you should ever find yourself wanting to do an
equivalent "decode loads/stores the hypervisor doesn't handle"
for Arm, use decodetree, not a hand-rolled decoder...)

thanks
-- PMM

