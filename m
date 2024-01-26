Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECE1C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLyP-0007ma-P1; Fri, 26 Jan 2024 08:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTLyF-0007le-6f
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:10:11 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTLyC-0002Qa-NW
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:10:10 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cf3a095ba6so3654281fa.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706274607; x=1706879407; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c2tnfFwluBnPok2LE9eJ5kbkU1R75wPvxTNjBBJGrik=;
 b=aNRibTx99Wy9W5ylUjP+AqAG8h4N6/mj0xp9jljU3+OMMGCzYpi67jaOucvqF+oK+9
 kJZGvEuPeM+pBMAjgIP3cooaAdqkVsFvfWEwjSBwwZFFjE5YZplLxa66puY7Abo/ljdt
 9XXJtuYanH4R5gWTi/Vsr4wGVQH0IeTbuNkP9BcAfzXnLQVastEbe5nnSHAQPG1n0NiE
 IvNfUFTkSllnxxf1XVskZ4IWhiowtEvgKigPW6Ge1rM68DXVeVT7/ecQb0BCO1a5TC0E
 4t8zYBRiogJBn9ENn9oLAhMeG8BwgH7zelXFsL7KwPivn+cbJAueeY/UzNJTI7oMUTQH
 0V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706274607; x=1706879407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2tnfFwluBnPok2LE9eJ5kbkU1R75wPvxTNjBBJGrik=;
 b=lG89X40f1ici+Xhh+56rmfXBJdjZGBQXPrzel8s8cZ0X70BFH4qucz8B6WixDflfI+
 9QWg8ZOI7I/ygmc+1Gzfm3YlBKNsCagYAJkfFS1m1gi9bpPSicqTUiLZGbLKITybBhbp
 YSsGKGnINzujvcNv88J8MR6E7oNOgSdVwmyr9KolSCK8KAUESVCafMD6Xpsf5tG8QKOh
 Dppowri4GZCGIZxaPesPLZKCgWu26/0ZlxvItnvs0A/MxABBk923l58NYwTwdtjy03+b
 n0g4Fhqd72IvX+sX0O/XNV74IRygmd+I7dFsZtkoviqRjc0hzAX2VEz6UbYsvphmi3Vr
 uRWQ==
X-Gm-Message-State: AOJu0YyUlh2hAxcZqDR++2ONkznqAld9BkvxfFy271Ckjza6ezXs/JfY
 5ib+swN+Eg/e6KlrEsDsqcEQ6bpLEJQqvBmt4Ihj+fpkUFJJLnhaY15F5UmL06XNLS+zocYIfFr
 FToX+FD5J6a8/Q8WeBFFFTdspJGI49BGwSTEdGIbf0zX88FTP
X-Google-Smtp-Source: AGHT+IFZvaaant7Ay4f7vqmGostG2nKwFcUIf56wRuusvoczl+BmBpvLVxMWl6gXNAnwECsWA2c+E/uWdbJoZQvgxmo=
X-Received: by 2002:a2e:881a:0:b0:2cc:9491:6743 with SMTP id
 x26-20020a2e881a000000b002cc94916743mr925194ljh.27.1706274606796; Fri, 26 Jan
 2024 05:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20240125084704.19301-1-jasowang@redhat.com>
In-Reply-To: <20240125084704.19301-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 13:09:56 +0000
Message-ID: <CAFEAcA-FptfVaHPrqq2pmVFNJhSEV5-oW5_daTusa5NNjLMy_A@mail.gmail.com>
Subject: Re: [PULL 0/1] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Thu, 25 Jan 2024 at 08:47, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 4a4efae44f19528589204581e9e2fab69c5d39aa:
>
>   Merge tag 'pull-hex-20240121' of https://github.com/quic/qemu into staging (2024-01-23 13:40:45 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jasowang/qemu.git net-pull-request
>
> for you to fetch changes up to 2220e8189fb94068dbad333228659fbac819abb0:
>
>   virtio-net: correctly copy vnet header when flushing TX (2024-01-25 14:58:00 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Jason Wang (1):
>       virtio-net: correctly copy vnet header when flushing TX


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

