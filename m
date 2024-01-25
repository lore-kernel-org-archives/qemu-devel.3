Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2FEC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 15:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT1OK-0007TL-Ex; Thu, 25 Jan 2024 10:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT1OI-0007Sw-QC
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 10:11:42 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT1OH-0003Um-7R
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 10:11:42 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55d0031d8b5so657329a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 07:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706195498; x=1706800298; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JlZx2CConwDZM4SlbaEO4H+Gs581wkGTZT7k6BZJkPg=;
 b=mEr453wJRpsudQDeb31SHErZK4qrGKX2k519kpyQHanSW3d8UqW63NZsxul8L8s0AQ
 fPlJtnA8JKsE7i+geYzLdBEa4MaJw7kI8AlqpwGXcQKuxEGZiEsNSzn4hk/LXMOMmBUo
 D5tdPcBi8c6/cdqVXg5tak40z7oO8apib7OTypWSjTAzKVCkCGlFQEobibOjHMhS6W55
 rr0NhDFW2ZwTjiXCijF7mhn5gVsIoK30pd7gcEK6fNa9DAHpumVz+z6bocPEn533PddU
 vpNnT+NEVby3UJcnYBi6eWPDAx147nz9SCd5lYr86opQav4TSBpHcXB4WeHxlZTsk/cf
 gKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706195498; x=1706800298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlZx2CConwDZM4SlbaEO4H+Gs581wkGTZT7k6BZJkPg=;
 b=qQ4GahHf+7YxAqlKi0UYJHGTxHyhlIh/DFw6BzNO6hyw3qTyAM+/5TiTkeGg4W9t1B
 n0MCuhm2nsgx0JZbALYKCI2Wn2zkrS4wuILDhjg5Z47H32im+U6wZN0+fmHAnH0hCAWM
 gxyZCbesxRvA3Zs9csIqfqBKZ4VQN6FbGPu2bsVbyeBmbehN0e3zl8B2g+hZ7Ey0lJpY
 kKm3U/a1vilnSoGB5X83RhZc9t9Il243/SSw3pSvLrSZFDG0zLGoIz/DYOxaehX6ffEY
 jYEgeq+d7SH8tMszNtNpUsQb+vDyZSdmwMmiLEiGEGX2PM8M/rGC6vhdcqSnVjvOioFW
 JTZg==
X-Gm-Message-State: AOJu0YwgOJ3xrUqZHFmZFpjuOZyCYcK6FQi7nNX612vjhVY2c3WT3MoE
 gd8UXV/WfZTUbqunzTZ5qsHscoE4zd1EtrzPVSaF49ujGFhjOgUd8PYCvYbleKjXiH8Ua6MThlv
 kaB6UvReSoh9oYa7aJUf+O2asPiwtOLSxgW7TCw==
X-Google-Smtp-Source: AGHT+IGgdemACCkbDf+TCIXx/mm8rnVQmR0QrQNtMjNKRogDUp2QE1yWq2+ZzIaCgglAX3ok6iB4SlVF9q4ydcmU5fM=
X-Received: by 2002:a05:6402:254c:b0:55d:12b8:626 with SMTP id
 l12-20020a056402254c00b0055d12b80626mr394458edb.35.1706195497841; Thu, 25 Jan
 2024 07:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20240122160126.394141-1-stefanha@redhat.com>
In-Reply-To: <20240122160126.394141-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2024 15:11:25 +0000
Message-ID: <CAFEAcA_vRf6uAEDNJjOpXVk+pkYx-cX_YvBr5Swyh7hOEk62zw@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 22 Jan 2024 at 16:01, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 09be34717190c1620f0c6e5c8765b8da354aeb4b:
>
>   Merge tag 'pull-request-2024-01-19' of https://gitlab.com/thuth/qemu into staging (2024-01-20 17:22:16 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 8a9be7992426c8920d4178e7dca59306a18c7a3a:
>
>   block/io: clear BDRV_BLOCK_RECURSE flag after recursing in bdrv_co_block_status (2024-01-22 11:00:12 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

