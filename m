Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C977BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 14:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg42e-0007qi-RE; Fri, 01 Mar 2024 09:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg42e-0007qQ-AS
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:39:16 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg42c-0000iZ-Fs
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:39:16 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-564647bcdbfso2942599a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709303952; x=1709908752; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YK8BQ4ac4EH/yN+dGS2IChQwa+eLXblrrFDHKStMHdU=;
 b=yOAkdCgqQ46R8A9LiA01rFfyL9xdkd1cKUVTKlNNnO3F9NLH4YhMmTuubO1psP3QcV
 bEeYP2++m1E9a69xLnGyQA9luFdYcx1wBjtZT+MjSQXj2huWbObraOPYJXyIaBPFcPVc
 V3OewgwyzxdGUuSzWHwGYoJlxju3H1Q7q0+oT3wraXtiP+ozlbdhhD4uNwO9jmkefFRd
 JhSrq3kOjLvAk6PuuoGAgQXdkMc1LBbT91ycSb2G5qaZX8J4ujvD0GkvL0+whGvLSe34
 SwATcKn++zSIy0bNshbpECGTRkbO0zfs9HPiGoJ6NjY+BeAjG9uFmqKGRT+Zq6bJMFbA
 HX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709303952; x=1709908752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YK8BQ4ac4EH/yN+dGS2IChQwa+eLXblrrFDHKStMHdU=;
 b=HnRVE3vMJ3CuJfqp/5EztHU7tFa+6rakJnohgNyWNcX2ayeiM3I9nW6leB+TJgVG+w
 ki+ffVBjD+Kx36EzxmOGD9RuUE3oNRy9SGga2L+gmYdOK0xwYeqE8NwrjZi6sk99yX35
 yvHsemFDjHfJS52+vJN0nK5BwxwgcOabnHZ0JBGWxwSdlzL73UwteAQMWiQHUoVATpVY
 gHri8w+q+clHTcgyl67EkHPqbh3OJcXgpFExaYQBin5t08oQahlZBOywl7qcer3ofQw5
 wCjLWZwg81NZ0iUV4yCz8uiLKZgnTi9ItwtZ5t0vSE0MqAALhB4unxe1ve6QvL/p4pWA
 U20w==
X-Gm-Message-State: AOJu0YxFagryfq9UwjDtRUNPko6z2PpLQa4QAQW5g8526LQeyEBXLZjt
 u5+svJl71RvkPbh4shOgRgAgNLMzc37amLIloCrqpYwtVa4dgXoB5RkJrFi//9IslpiQqyD9Eyq
 OpWPy7g1Phz2nGFDj2xipulID7HrBv6uVGvyVIw==
X-Google-Smtp-Source: AGHT+IG7++Nf/UY74fflJUozRLyZFqsrM6rRuVSp4nPAqrIrSdpOFFP1MYQxjwpB+ki+Tl5RkdZ+guv3oz5/5UBXWMg=
X-Received: by 2002:a05:6402:323:b0:566:5ea2:1257 with SMTP id
 q3-20020a056402032300b005665ea21257mr1408686edw.16.1709303952525; Fri, 01 Mar
 2024 06:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20240301080953.66448-1-thuth@redhat.com>
In-Reply-To: <20240301080953.66448-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2024 14:39:01 +0000
Message-ID: <CAFEAcA8BGHP4okzXO7o9hCVzjDaUH=fthWRQd1_Yo_mtnauWSQ@mail.gmail.com>
Subject: Re: [PULL 0/6] Misc fixes (libqos vring, Kconfig, TLS io channels,
 ...)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 1 Mar 2024 at 08:09, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit c0c6a0e3528b88aaad0b9d333e295707a195587b:
>
>   Merge tag 'migration-next-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-28 17:27:10 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-03-01
>
> for you to fetch changes up to 462945cd22d2bcd233401ed3aa167d83a8e35b05:
>
>   chardev/char-socket: Fix TLS io channels sending too much data to the backend (2024-03-01 08:27:33 +0100)
>
> ----------------------------------------------------------------
> * Fix some bugs in the vring setup of libqos
> * Fix GIC settings when using --without-default-devices
> * Fix USB PCAP streams on Windows
> * Remove temporary files from test-util-sockets
> * Fix TLS io channels sending too much data to the backend
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

