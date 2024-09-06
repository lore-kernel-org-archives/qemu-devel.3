Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE91E6FE22
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smadr-0006wE-AW; Fri, 06 Sep 2024 11:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smadp-0006vh-V4
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:12:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smado-0003x7-8m
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:12:53 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so2801677a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725635570; x=1726240370; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0iwq1bWaUcXeg/UBUdG+FMEh4Trl9yIhDB5gZW5lKWI=;
 b=Ru1PgNu5u/X0k2+/vB6kAMk3ax4MyQ3bipMSV2GKJ5IAZQAN6MmZl2htdDLHIwMds/
 ym1jeE5AykZB6PMOydpKRaCHWuzshJTd9WegT+oyAi6ik4hn2l5gZOMsXmudF6jsPZfa
 RA6yAogTKwkfK/2yN75vNIliQ//FduoZKs0zJLIaQcLsBQQT5IbwxPbpux1MOOKrYf14
 vPfJWccDyVJXYP98lP0Bdg1H0SOrak27Xu9uGD2bMosul8iW4ptFyCvKHq7vJ14j9yqY
 ewac0TCzwPH5qsTj6tlF4WYSAdVUZBZdNXttwABB/oAJLefSi17Ve9u1OYQExSPv4XWg
 APVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725635570; x=1726240370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0iwq1bWaUcXeg/UBUdG+FMEh4Trl9yIhDB5gZW5lKWI=;
 b=mH2TyN1znNN4ukDy74GQQOqk/Or63rivcyLPbICViLw3GCWP41xsdAvZDRWE8thuY2
 bjodkLLHpr21tjoxZ0mnXkTIO8QuapHP/Umx/BJLVUiyoOj9pek0alycHwJIpz8wB6a+
 WTUyCuJIbMO9VfCr9QHVsM13imZiudDYdlFEoY7lwhby4/F43lp6IUOW7spsXQrDbu1+
 s7bgRoqemnJmSMxak35HQqQz58dm4wQ3sCcbpta7J8nSABtdhM8NDE57j5qKgFPChluR
 d7sAQj2xzVL0PamjhjDoNSRfAOiJFfh1iS5g75MeBe3+iO1fDzXh0dDG33rChoAFKYwG
 nauw==
X-Gm-Message-State: AOJu0YyOIRHddjR8IyX6koCBUCo+PQXh9PCbvbDGW03XZhC6nPZOzEZM
 Qg+kVJs9kzIv8h4xj43enwQm+JWWsCQQ1M+t2SPbI5IwRPerbgHPsZJqJnleQkD9kg2QZSSXSLt
 T2LHZyy9HCIcgdtpdY1ZsgDOTIFAGkPx31aqYvPCBQhOyVdg7
X-Google-Smtp-Source: AGHT+IEzy5g4GrbMAxjFCGK53Rj9IDXdDmH8SDqZ6v9bKbffNznkJc3U1QA6637uLWdFFS91Q/2ZtAaG5EepfR7lCEU=
X-Received: by 2002:a05:6402:210f:b0:5c2:6a7a:5795 with SMTP id
 4fb4d7f45d1cf-5c3dc784aefmr2404169a12.6.1725635570315; Fri, 06 Sep 2024
 08:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
In-Reply-To: <20240816132212.3602106-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 16:12:39 +0100
Message-ID: <CAFEAcA8XwbB89sNKPJpFRXcFb1esUpRMaeue8e=Wepvpmr9PHw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 0/7] docs/devel: Convert txt files to rST
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

Ping for review on these docs conversions, please?

thanks
-- PMM

On Fri, 16 Aug 2024 at 14:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset converts a collection of the remaining txt files in
> docs/devel to rST format. At this point in the release cycle
> I'm targeting 9.2 for these.
>
> Patches 1-5 are simple conversions.  In patch 6 I move the
> QemuLockCnt APIs to their own header file; this is so that we can
> include the kernel-doc generated APIs in lockcnt.rst (since
> kernel-doc works on a per-file basis).
>
> Paolo: can you confirm that you mean GPLv2-or-later for the lockcnt
> code?  There's no explicit license comment in either util/lockcnt.c
> or include/qemu/thread.h.
>
> (There's one .txt file left in docs/devel after this, but I don't
> think it's very useful so I propose to delete it and will send a
> separate patch for that.)
>
> thanks
> -- PMM
>
> Peter Maydell (7):
>   docs/devel/blkdebug: Convert to rST format
>   docs/devel/blkverify: Convert to rST format
>   docs/devel/lockcnt: Convert to rST format
>   docs/devel/multiple-iothreads: Convert to rST format
>   docs/devel/rcu: Convert to rST format
>   include: Move QemuLockCnt APIs to their own header
>   docs/devel/lockcnt: Include kernel-doc API documentation
>
>  MAINTAINERS                                 |   8 +-
>  docs/devel/blkdebug.rst                     | 177 ++++++++++++++++++++
>  docs/devel/blkdebug.txt                     | 162 ------------------
>  docs/devel/{blkverify.txt => blkverify.rst} |  30 ++--
>  docs/devel/index-api.rst                    |   1 +
>  docs/devel/index-build.rst                  |   2 +
>  docs/devel/index-internals.rst              |   2 +
>  docs/devel/{lockcnt.txt => lockcnt.rst}     |  89 +++++-----
>  docs/devel/multiple-iothreads.rst           | 139 +++++++++++++++
>  docs/devel/multiple-iothreads.txt           | 130 --------------
>  docs/devel/{rcu.txt => rcu.rst}             | 172 +++++++++----------
>  include/block/aio.h                         |   1 +
>  include/hw/core/cpu.h                       |   1 +
>  include/qemu/lockcnt.h                      | 130 ++++++++++++++
>  include/qemu/thread.h                       | 111 ------------
>  accel/accel-blocker.c                       |   1 +
>  hw/core/cpu-common.c                        |   1 +
>  util/aio-posix.c                            |   1 +
>  util/aio-win32.c                            |   1 +
>  util/async.c                                |   1 +
>  util/fdmon-epoll.c                          |   1 +
>  util/lockcnt.c                              |   1 +
>  22 files changed, 608 insertions(+), 554 deletions(-)
>  create mode 100644 docs/devel/blkdebug.rst
>  delete mode 100644 docs/devel/blkdebug.txt
>  rename docs/devel/{blkverify.txt => blkverify.rst} (77%)
>  rename docs/devel/{lockcnt.txt => lockcnt.rst} (75%)
>  create mode 100644 docs/devel/multiple-iothreads.rst
>  delete mode 100644 docs/devel/multiple-iothreads.txt
>  rename docs/devel/{rcu.txt => rcu.rst} (73%)
>  create mode 100644 include/qemu/lockcnt.h
>
> --
> 2.34.1

