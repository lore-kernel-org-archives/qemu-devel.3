Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7FCD609DC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 11:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGG8y-0001kZ-UL; Wed, 27 Nov 2024 06:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGG8v-0001k9-Rw
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:23:39 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGG8u-0004fa-15
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:23:37 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cfddb70965so8128924a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732706614; x=1733311414; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d0PzA+s/QDhUbgJg2hssFIWE6nAfzQd+B4Ci9W7D+3c=;
 b=pqZiAVfBsROBd1wfK7nwUxJxoySFRlp7qx3Qib0PbwmBN1zeJCPYN5ReuNOon0771L
 oGXyYjRAyHYu4IEA/vYum7ILICYK547ufPzSM9z7MkKTBTwD9dQRHZNXNbhtLHyu7SLL
 FCzu8mNzkgLjOlwXyTBbw1eg6yrKq3p6E9VmWnzG7Qn6AgEqNwAaORabNKgcHpCpIWZ6
 w5y2Ppf/aGLhFoV7OEwBXj4OM89Fq5LLp26mC9elmSozlWfQtt5biplA+HuDeU3tcsB3
 CM5aLuUbrkF41+Ri+HVmvqKQed4vAL+x+bU34iiBwwgb5639I+DDUUg0umOjngyqImgp
 mr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732706614; x=1733311414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d0PzA+s/QDhUbgJg2hssFIWE6nAfzQd+B4Ci9W7D+3c=;
 b=ZApDQKq3uWJlUk12M2tAICf370lholdzhhh4iX0NucxZ9KjM6j6O/fx8bQdcI8T80x
 8SjJ17WzL2KaHkW173FM8CN0bxD6yPwuD3webXOcitZTp/UPATPCeDsNxclbQdbBSpLk
 cWt4PelXQ/mhLq+d98/rJX78X5R1CHwa3yTo3FoBuhhym2yJQ+Khw3fk51n2VfRHA+3t
 SoJUyOmUZXu1HGk/E0EQL076vU8O7jvhBuJQ15MyRbbi+NDizPlyV/yQvCY7Pc0sTSq1
 ubAUXGrevrr14I+VJ3g+Nhm8f/IDcQUC3lqA/aB4oYKTah4gbED2i/Vsdhf6XH8F7v7o
 Idaw==
X-Gm-Message-State: AOJu0Yx5+sHofUy6U4NuxfZCiDkjQ4t6EL4MWra1yAoY4RDBdaJI33hM
 TTyR6yPqmQh1WIr3OCscK2ZQutyFfO7cwLiGGs/kkY5qshJQVp/+tST0XKQi1Dv+NT8y4EzSxq8
 iWSHGScUVo/V2vPXAby5ceLJu4JrMkITAiDyLGw==
X-Gm-Gg: ASbGncvd3o4g7gW9srub5cV9QCQ70qvpL9xrIGXV1fjGiLd4SGPzzXT0JT7btrd1+qI
 vLYTV/0NzEmXqxEZWwTqWfTNWQUmywL3R
X-Google-Smtp-Source: AGHT+IE5WrzX27stcE2nVVAGFNqsbIDkzcYSV8yNpSSfvDcfvm6mIDCbHDDVoR9Xs0TfG/965tlhMFLSTkTdryC72Fw=
X-Received: by 2002:aa7:d68d:0:b0:5d0:8676:3ed9 with SMTP id
 4fb4d7f45d1cf-5d08676410cmr964845a12.8.1732706613360; Wed, 27 Nov 2024
 03:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <0ace2747-efc8-4c0a-9d9f-68f255f1e3a5@igel.co.jp>
In-Reply-To: <0ace2747-efc8-4c0a-9d9f-68f255f1e3a5@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Nov 2024 11:23:22 +0000
Message-ID: <CAFEAcA8oDPD7xdhMC__Rp3WOzSdm9CnSHw-bepvQnxK3BMzVOg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] support unaligned access to xHCI Capability
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk, 
 foss@defmacro.it, qemu-block@nongnu.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, farosas@suse.de, 
 lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 27 Nov 2024 at 04:34, Tomoyuki HIROSE
<tomoyuki.hirose@igel.co.jp> wrote:
>
> I would be happy to receive your comments.
> ping.

Hi; this one is on my to-review list (along, sadly, with 23 other
series); I had a quick look a while back and it seemed good
(the testing support you've added looks great), but I need
to sit down and review the implementation more carefully.

The one concern I did have was the big long list of macro
invocations in the memaccess-testdev device. I wonder if it
would be more readable and more compact to fill in MemoryRegionOps
structs at runtime using loops in C code, rather than trying to do
it all at compile time with macros ?

thanks
-- PMM

