Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE8BC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rScjX-0001vu-PB; Wed, 24 Jan 2024 07:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rScjW-0001vk-Ay
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:51:58 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rScjU-0000UU-Id
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:51:58 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-599d1fd9cc1so142258eaf.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 04:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706100715; x=1706705515; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cs/6JsPLBzreJMgldTB9t6wd19xezkERRpVu8YmspeU=;
 b=GVGHVQF0bS/OcXTzro0WUYcKm1dwKGwYwCZmUn/PerYF1k+wawe4gI5wRCl64A+TfO
 BWXWFf14PsrOHo0DKkHbU/9Q1wshHXgbH8yyxar6tMt6g6Z3L4iTUPSA6BLSaXqYTHJW
 CSDjx7bjyPwQsQkLw010YvtXfCgFb3bQZ5or4oElPZsJqUY0VPuQvROUU6XpKBNvLKzF
 QN0FKKqAYBhayYTT0wzNxrsYV9+c3Ph0jWOmvmg7Lavl40c46/yw9HLTfgHAyPg13KH5
 K6ibUuKudE3CyKAdUr5vIkGME3PkyB7sYdZgeqmdICsG3mikanBBbaifmVqdD+0wh95K
 ESVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706100715; x=1706705515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cs/6JsPLBzreJMgldTB9t6wd19xezkERRpVu8YmspeU=;
 b=QzgcGTdEuvToinmh13gkOBnOo8UwnehOkev3nFmJZ4d9iBUKWERwsYl5jLbnvModhJ
 FCW4F0+SMuyaGiGkvrmPaGzbeXxhsqTygV4147Bb0YFTkU67bsh6628ReRqWfDZ6mpLT
 fYbBwIBXiOrGTTEpmFToVHMaBMT6jLm1qMgs26p0Ejq+qBmDnzbz5thO9hmaZSZ48eui
 JR+u5o6xseisxu1cNbJaVY3oGfjjD4HSjOaAFjWdsgX5GUjb7TU+TgbIrhG5UoftC3sF
 rkpDWKUgZuDDoOf6ssbg17ESU7RyRXqME3GAdorCbu+Pt2G5S2yCkQEAZQoJgjmRHTfi
 aUwA==
X-Gm-Message-State: AOJu0Yy28nK2o12ai+iYVUlUFfmKUTmonwy5fg49nFuUCyHyU2FrJf7a
 MSiAkLRSWxp5Zf1n59h6sJasTVSMzjf8FeynxrI9vTEKQgm+yKHAySNeWeXgduYOjOYCAzrBmlZ
 JfWP6X7ihpIbyswLQsNPilcfqkXM=
X-Google-Smtp-Source: AGHT+IHbxv/DVhQ9sc23QC0rRtvtHQgqtBqLdLNysaL/CcQCK5BxP16443ZkR5JZs7J0br7snzL44ceinoH1c8/NyvU=
X-Received: by 2002:a4a:e60f:0:b0:590:aaff:e4a5 with SMTP id
 f15-20020a4ae60f000000b00590aaffe4a5mr1227241oot.19.1706100714674; Wed, 24
 Jan 2024 04:51:54 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <CAAfnVBn0+627rLGXeLdsvUge0_VegcbTVuQf8rQwtjuJ3hcJnA@mail.gmail.com>
In-Reply-To: <CAAfnVBn0+627rLGXeLdsvUge0_VegcbTVuQf8rQwtjuJ3hcJnA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 24 Jan 2024 07:51:42 -0500
Message-ID: <CAJSP0QUV7-_C7WS78WytD9zE0aTt4JgqJTHcP-fU2exbmsN6SA@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
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

On Tue, 23 Jan 2024 at 22:47, Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
> Title:
> - Improve display integration for upstream virtualized graphics
>
> Summary:
> - The Rutabaga Virtual Graphics interface's UI integration upstream is very simple, but in deployment it will be complex.  This project aims to bridge the gap between downstream consumers and upstream QEMU.
>
> Looking for someone interested in Rust + system level graphics to help realize the next steps.

Hi Gurchetan,
It's unclear what this project idea entails.

Based on your email my guess is you're looking for someone to help
upstream code into QEMU, but I'm not sure. Last year there was a
project to upstream bsd-user emulation code into QEMU and I think that
type of project can work well.

Or maybe you're looking for someone to write a QEMU UI code that uses
rutabaga_gfx.

Can you describe the next steps in more detail?

The project description should contain enough information for someone
who knows how to program but has no domain knowledge in Rutabaga,
virtio-gpu, or QEMU.

> Note: developers should be willing to sign Google CLA, here:
>
> https://cla.developers.google.com/about/google-individual
>
> But everything will be FOSS.

Which codebase will this project touch? If a CLA is required then it
sounds like it's not qemu.git?

> Links
> - https://crosvm.dev/book/appendix/rutabaga_gfx.html
> - https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/
>
> Skills
>  - Level: Advanced
>  - Rust, Vulkan, virtualization, cross-platform graphics

