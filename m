Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032B7C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOxX-0005Bs-B7; Fri, 09 Feb 2024 06:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYOxT-0005Bj-Qv
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:22:15 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYOxS-0004Pt-50
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:22:15 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso1409634a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707477732; x=1708082532; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GwrI3Y0Q63EJf0Oa1G/IyR1DoDOYyW3lAEj0VYYII5g=;
 b=ztXgUFWL+CR9+L8wZbUpkbrZE1Z5PK5hjrufXQ2RQbBrBVUXuQd9rCi6cRCxN9u0MJ
 R2Ir8F+crp7+NVLxMjeaYlLIAHUR6S5BrhS/RRwCSgbDt109ZlIklqKQVWxI0VeqgNJX
 zPMtRrQWGC3ma9T5J/02hjGVdzAuUmRjwI6JF9M3nqhp8DPNvYMtKr26O9s/qfW+UBtX
 pFtskNmMD2SpJ2T0nKwDVUZ3RsB2v4xMk89Y4kvnt4oA0Zd06M8lyj2cPkNrv9r2Byym
 QqHfhngTqUbeGfSe4RhIObJs9KeWGiAsrzFEVDL4JGsHhRaoWrpEa7A2y1ojbncDhxC1
 vBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707477732; x=1708082532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GwrI3Y0Q63EJf0Oa1G/IyR1DoDOYyW3lAEj0VYYII5g=;
 b=gGWZvpwex/YcTC6CSnSSHiuQdA9in0yLUcRvW0fdmMvFREi0LyvAaqxu+xLeWueJym
 ksD1tD0/DLEr4oTTGaHOScNrCESQsBD08hWsqJkbBrzQlvhaiREbZ8YS8K0EKmAWdA9C
 eaTEqyWW+2ir1CkUDS8UhIIyqSndAzLzt8oOJJHNqwpubzzpdC65Sh5pLtCbNjw8eQIT
 OeXiJV2Mt6PkZ8icLd5+gdddi7KwO6Id4zFELoJFiJB+76bkx/pwnU95VbDL6wUy77k6
 QpJqpD7ezIj4J2uKZLRr7ffGeXKwSde0wixKgE7w2aK/v2F1DE2NW5BXhzoAv49zlghr
 KCYQ==
X-Gm-Message-State: AOJu0YwzDZAz4zKDK3y//mlv5PtxXh2p4yrP3fbknAh6GsiHSArhc83O
 0r3dh1e2v/lGW79xmRJziXxVtCJQrGjvdMFGH9ZcvsgMyDqn/y7yPnGVkIKeA2T12Egy4+Gomf2
 DR3Tmn0+SWR8m0StGM/uQSSEY4vGqdaG0pSMOdw==
X-Google-Smtp-Source: AGHT+IFmG2PIyGIBvskpif3KO/iykFomPx3Gy1sJRt3yVnBGGS0y9U3Lgx/zZtU0sgnOGImD/eAe9mSOqZw+xGZ1pbM=
X-Received: by 2002:a05:6402:1756:b0:561:3d1f:26d4 with SMTP id
 v22-20020a056402175600b005613d1f26d4mr924610edx.3.1707477732268; Fri, 09 Feb
 2024 03:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20240207215606.206038-1-kwolf@redhat.com>
In-Reply-To: <20240207215606.206038-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:22:01 +0000
Message-ID: <CAFEAcA-1pRr7sagq7pg3grTOhX3dQmg3X6F4TKUc61_hSpxr7w@mail.gmail.com>
Subject: Re: [PULL 00/16] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 7 Feb 2024 at 21:57, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7ccd0415f2d67e6739da756241f60d98d5c80bf8:
>
>   virtio-blk: avoid using ioeventfd state in irqfd conditional (2024-02-07 21:59:07 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Allow concurrent BB context changes
> - virtio: Re-enable notifications after drain
> - virtio-blk: Fix missing use of irqfd
> - scsi: Don't ignore most usb-storage properties
> - blkio: Respect memory-alignment for bounce buffer allocations
> - iotests tmpdir fixes
> - virtio-blk: Code cleanups
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

