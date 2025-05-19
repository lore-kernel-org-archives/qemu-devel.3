Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFD6C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1ry-0002T7-U7; Mon, 19 May 2025 10:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1rd-0002MO-UW
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:53:15 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1ra-0001E0-Df
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:53:12 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7086dcab64bso40738707b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747666388; x=1748271188; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mnf9o7MDcZwhNkHxdqDET6uEGwN5Wo48yDCKM4l+zRA=;
 b=mFGOXv6Vsfzq1dSQ4oCpeVLDBY6MPhEWEOBVQJdqs7g7cqCJdqLLEfaIbq4QWdyCFd
 C5W+OyR8jbBQfUU//m7FjYHKcrGqrgcHh1tp+ponlEuNL409ynGftP9dHgZCEofWuJ9W
 dlg96TvWEUkTsVKx3TJWrJTAkj0EyHYKjlQUq7k0XEit2aaHluAH6nmEPmPO0GuPBZCu
 zPAcBSuzXRk2QqmJ97qRjHdeXVgQiK+MuPUG/fW0y9vce6YWL0CwYsFx3cFlyeQ2qmKV
 lOTCCqcbm96/6D1EBAzaHrQJtykhc9RxAGVyPx/EnDPc0+pG1o91jGCS484oTW+7H2CG
 dKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666388; x=1748271188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mnf9o7MDcZwhNkHxdqDET6uEGwN5Wo48yDCKM4l+zRA=;
 b=LjBEe4esXxFnD9T8HquYcUMULkqywcdzKpoDRsflam2pyS0osuUfS68WiHOVHxQ/sK
 Z0SBOMGn55wT6WV0mAy67RQ3enmm+Kx9Jlcz/aByjc/QSXZYaTA8I0mvPZdH9tMERYuX
 0KB4//knmExQIEGUsRiIm6rfPaqiefoyWUcnol2+o0dyyYJceDA2ygDVHiB9ej7CS5Il
 GtZYtZNh/TstMRDr7NUGw2NsRlib8Sz4gxSnueBpCfCUqp+4FcGFVRkRsBxYuGKu1Ebq
 BcXdqiVUGqf2D1u0ghovbr2+2OdEt4lHmHPHb15E0IILC3mV8nuqf3igGWNtqUBup0Us
 BxHw==
X-Gm-Message-State: AOJu0Yxg6fi9OzEx/3sR+V3QUjVmyxrsjzyw5WyZrrh5W7cGrwg0Ws8f
 aphgS2PlpDS0HUSXTMdQ62L841YAck2WNiy/pls9AZ+ThrnUm2qj6Js87wugWc1YANWLllvPriW
 y1zVrjX5rAkkJ/2oXqS7rVL72pUW0ITzUQqUkxh0Gww==
X-Gm-Gg: ASbGnctYUMVelUZGs33oU19Q4I9p/81cmyz6lyYpYQS3fzcBtojEPTmfArjvKJnwKqa
 y4/YAwZ7sf7j1/mXI8UNVsjHnu2J4eEjFs5bQSn6xb2c91OWHPsSHxW1ZPXHXvskjwEV/KOYw6L
 gL7ozcMTDrRanAbbJMsc+Bbv97FH2sUcmRDA==
X-Google-Smtp-Source: AGHT+IEkWtxR//oHKX6D1iP4BajQV1g9GXaJwU/W2SHBMAgVLNaLmbTuF/hHR6wQyZIIsCrcxDR/7ZQYsrmDISMQ4Us=
X-Received: by 2002:a05:690c:3389:b0:708:3a47:3d2c with SMTP id
 00721157ae682-70ca79cb5e9mr195332097b3.13.1747666388473; Mon, 19 May 2025
 07:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250508220718.735415-1-nabihestefan@google.com>
In-Reply-To: <20250508220718.735415-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 15:52:57 +0100
X-Gm-Features: AX0GCFsRZOYxLP3VhfyvpcBvc4KAoZNLSsP6NpOj-5L8zU5VREgXpbX7jciopBs
Message-ID: <CAFEAcA9w1D=jBfjGVb7oBv+fxZ==8SvdTk7je1gGFSPzFtWe2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm: Nuvoton 8xx - GMAC patches
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, kfting@nuvoton.com, wuhaotsh@google.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 8 May 2025 at 23:07, Nabih Estefan <nabihestefan@google.com> wrote:
>
> This is a set of patches to add the GMAC devices to the 8xx board and
> migrate the GMAC tests to 8xx, which is how they were originally
> created.
>
> Hao Wu (1):
>   hw/arm: Add GMAC devices to NPCM8XX SoC
>
> Nabih Estefan Diaz (1):
>   tests/qtest: Migrate GMAC test from 7xx to 8xx
>
>  hw/arm/npcm8xx.c             | 54 ++++++++++++++++++++---
>  include/hw/arm/npcm8xx.h     |  5 ++-
>  tests/qtest/meson.build      |  6 ++-
>  tests/qtest/npcm_gmac-test.c | 85 ++++++++++++++++++++++++++++++++++--
>  4 files changed, 139 insertions(+), 11 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

