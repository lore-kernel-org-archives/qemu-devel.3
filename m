Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A1EC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 16:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ronTI-0008BI-9n; Mon, 25 Mar 2024 12:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ronTF-0008Ax-Up
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:46:50 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ronTE-0005Pn-3S
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:46:49 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so1554987a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711385206; x=1711990006; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LlaZHiBgJO/fi6fxpm+UYSSCS/7k+XM8Ne4kRIxu1LY=;
 b=uQ8AyQINdGQeXc2d9zMKyyfkSWW6UYlEayReNDHiy1v0l0JroOEYJpTJqQRmS27M5u
 1qWr/IBAJxmN3huvBa1Z0Fl3PsTO2TwsSmE14GN1Vg2QTaWXe03E+dE6ry4uDDVFCOtW
 cALbFRjwePuCrryrzqzvw7/HXvrLQmzJJI1YkQlo/UoKlYHYXFBX9b5nO9z316qVUy/k
 VZq0p1nyOiPK6uDijhFI5y5GWOX2K4vIFXTsSGBpOEzTicpSLld97CjMI5OeynO0Y+RU
 pzLVeX1uS+Twgs3zfclrgWaXEZ1FT7olboTp9xB5o0gfsRAeITnkJUIe1vJfT3e2zopC
 N5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711385206; x=1711990006;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LlaZHiBgJO/fi6fxpm+UYSSCS/7k+XM8Ne4kRIxu1LY=;
 b=efJ8caoSM17iDHPLvcxA9pKubUa0Qkgw/hjokZqPFkZYqja0yImYejnxH8loUTXgEu
 QImB+ceLFbt/QX8eCKTjR7y2hLulOv4JXIZ2aOB126IqM0pqaijTnJzgFUMH0tXTc30k
 bcdKNGNTzT3wb8sLuZLPNd4BemIdDgZt842M46JebaPBqVMK6va3U2c7n98h2JRTPYKy
 H5VLMdfv026ugQBs4pAKQcZ3EzFGTGKnrzJofbu0IV/ocJEJoeNwvRYpaLyQ/6/0e4S1
 2CWi8Jq7g6DyCHmORccHYS+eYo7nydNwwRjo2Nv1+8NL3VB3JPF9Z6dXp3wVz0HalRs7
 cX3w==
X-Gm-Message-State: AOJu0YzIhPYdcEuhjFDCgKpWsag3Ww0KvJCuM80sjzmuJSaMvI6gJw3S
 7IDz3bmDZQgczKToMzDLNCpDm1zSzrKXo9K+ffMvOPXGqv2qzU8MZowqoWqtfD4Fw/GDmwNmw5W
 WlB1nXRMH7HU/g9VH5AgqjMLwaxeDoTbMka8D2x0YXxNPnTof
X-Google-Smtp-Source: AGHT+IERu6XmDJLoi94/nRPnHfMltl3jTkRyDUM64GTIuRib1mr+ny3xeLqt6BEpGydjxFqU5Eqeg5oH8wUk78OTvqM=
X-Received: by 2002:a50:d659:0:b0:565:665b:9c82 with SMTP id
 c25-20020a50d659000000b00565665b9c82mr5729900edj.8.1711385206407; Mon, 25 Mar
 2024 09:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240325141901.2080584-1-peter.maydell@linaro.org>
In-Reply-To: <20240325141901.2080584-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 16:46:35 +0000
Message-ID: <CAFEAcA9taS7SriXG54yrrTMOyYOHA2peF59nPXiN3a6u1+taeA@mail.gmail.com>
Subject: Re: [PULL v2 0/7] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 25 Mar 2024 at 14:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>
> v2: added a missing #include qemu/error-report.h which only causes
> build failure in some configs, not all.
>
> The following changes since commit 853546f8128476eefb701d4a55b2781bb3a46faa:
>
>   Merge tag 'pull-loongarch-20240322' of https://gitlab.com/gaosong/qemu into staging (2024-03-22 10:59:57 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240325-1
>
> for you to fetch changes up to fe3e38390126c2202292911c49d46fc7ee4a163a:
>
>   tests/qtest/libqtest.c: Check for g_setenv() failure (2024-03-25 14:17:07 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fixes for seven minor coverity issues
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

