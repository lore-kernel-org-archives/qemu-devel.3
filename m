Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B8BCF11E1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 12:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sysCu-0004oq-CU; Thu, 10 Oct 2024 08:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sysCt-0004oZ-5P
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 08:23:51 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sysCr-0001WB-4C
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 08:23:50 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fad100dd9eso9064011fa.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728563026; x=1729167826; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xPP8y+wl4PoB/00FUXYMO+USuL2ewhrPu9g8Dl9MKuQ=;
 b=Rd9jbe0mS4//dADee4aqLL5cVskGPdEqmU3abIsgXUZyuLswRm73Ayu4Z8u3vTsPDI
 92g3QZc7D2vGklXMm4HbpK9v9wKf5ko1H25wXTHib7KkGtOWjMfGdYrUL+CRPOGCgI+E
 0SSYs/3ZPbqAaT/XMNaHMMrC30dTrozKZBSar/0yriCp2GzghpEAtALKLpEqkbj1Rhyh
 f34o+e6NltIULEm6tpQGgeqSFu69tE1Ef2kajxcL+oZUAdjleq70exPNmkGFOh24WD3u
 rnbdZbna8GQySRgzGr/LdC+WzPq0u55KyxD2QNfO39S1xVgdD8M85HQEUjqiRIOeDW+a
 NFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728563026; x=1729167826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xPP8y+wl4PoB/00FUXYMO+USuL2ewhrPu9g8Dl9MKuQ=;
 b=I+B5Nyctx45qm1XFDmceNFihwAiLWsL8Cbo5uEG+IJY8oNbDhfYfLrXhkQb/xpUjju
 7tp2kqzLFkh8x9/2eDKMV/o22KsdVYx1isE6wG6S5K0xDIo9bt8n2/fI46BU9egzPilC
 ECb2esToTYAd5UEJuLeVRRXmRHZtDGIkBG4SYWD2oDMxx6BMv2gFTPj7E2tm0DAOUunn
 SWxgkYMAwRAFummwW1qGBgCgbwKdc2lO3jKQUCIPYaD2pRUVGJTqtFjxRQb9atQwt+rf
 q0GXhgYib12bsEPiwV7sUxKP3Lg6lTK6O/vT3tz7CQDgJL/3kKsF42VFZFRwk8eBNFWF
 dhtw==
X-Gm-Message-State: AOJu0YwCPvWT2fle7IzuX6qcJukRYIrkYY4UbeRDd/+VTMjrhIwPTYzn
 l5vPkLOJz6Kj6GW7H0fCSX9Dl43UBq8l3mTIeHClyYqv5rnrj0k+VRyPZ7+DZ7WuqrVUahAKL7T
 Lx2YJzbTfVkmyLzHRIarXZjPTnI7wXmjhbuQrQA==
X-Google-Smtp-Source: AGHT+IFEsjR0hzhv21ZQ0cJX5yx0rPfGA/NNRigFkVh6Y/6ncqamkzVGBGhykBoaTh/t77vLs9kCiXtRB6Ry0wzsgHA=
X-Received: by 2002:a2e:bea3:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fb18720a67mr41335481fa.4.1728563025875; Thu, 10 Oct 2024
 05:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241009124238.371084-1-peterx@redhat.com>
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Oct 2024 13:23:34 +0100
Message-ID: <CAFEAcA-FFEEfao2z9BvDDpSQHdDmqD3U8G0gKFcEGD8c0SAvEw@mail.gmail.com>
Subject: Re: [PULL 00/12] Migration 20241009 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Wed, 9 Oct 2024 at 13:42, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit 2af37e791906cfda42cb9604a16d218e56994bb1:
>
>   Merge tag 'pull-request-2024-10-07' of https://gitlab.com/thuth/qemu into staging (2024-10-07 12:55:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20241009-pull-request
>
> for you to fetch changes up to 2e49d6a20b2193378e508b01de82eaffc5adc3bc:
>
>   migration/multifd: fix build error when qpl compression is enabled (2024-10-09 08:30:53 -0400)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - Ani's patch to complete the memory API on coalesced IO / eventfd notifies
> - Fabiano's Coverity fix on using pstrcpy() over strncpy()
> - Dave's series on removing/deprecating zero-blocks and uffd cleanups
> - Juraj's one more fix on multifd/cancel test where it can fail when
>   cancellation happens too slow on src
> - Dave's one more remove deadcode patch in iova-tree.c
> - Yuan's build fix for multifd qpl compressor
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

