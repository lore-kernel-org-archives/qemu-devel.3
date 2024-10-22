Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB898D2C556
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FK3-00059D-BI; Tue, 22 Oct 2024 09:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3FK0-00056M-PJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:53:16 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3FJz-0002BF-Ad
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:53:16 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so7058574a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729605193; x=1730209993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QsMx4QOo4Wm+97sGBJ1SuDd//1IZcQPDGt3SBXm63Qs=;
 b=GOWQSaU5J0p3KQpsdDyxPTp/NQXF0YuH7CYWf5XzLS4vXuRJDqZqJEFQLbuMZsykrD
 zgmMkE0cwZ8sDmiR1k6ULdn7a5nS+USMPrM1cMN1QtbI6CEiXHeR9TX9Mg6H3C9ToY0H
 27bPsl8xkOY3v30+8rtuylHtXbA/2OfLANGx8S+ckC8HAp9PTbh/iVASnvpTqzMr++hN
 Bejx8Szh+02s3Jk91Q4ixXG006qvbhiBPtY27EecoCmutCU88x6Kh5BFv5KfyYkcWyeO
 qSdQzcug8QZINE9VrHu+F5wlQdNScdbcdkGPgKubilQv2KEgFq7qq3xvwcoUIZpdC1BM
 xcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605193; x=1730209993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsMx4QOo4Wm+97sGBJ1SuDd//1IZcQPDGt3SBXm63Qs=;
 b=L4NlYkSBqWPIODZeiZ3YM6+3+OIeoOoZd3z6bLpljpshkvo30cjaI0rD0hdPoJopCM
 lgM4tVw58g66FZBpVX1pxXPDHUp5FSC3pdEZzfBE8LAQCr78xQICGf1Jl1NeJYlK8COH
 C8lPYMAIZXJgUy+KKlJ0+XoP+R567tsnNFxEI2ATxFW2SAMnnKBmvY/oti37jL1eHpnt
 dQiqRVWJRHHvpJN4YnBORRj8i8jpXrs3dEvhh5U+44fIYKNeQyIP+/NC28nchKeLsK3U
 3dVdGJQFPPE5ymXiqiqfZIT3unpEFmsXj7RxvO33dJgHwYba6FzOCOWvCae5ZwGNueLe
 CW5w==
X-Gm-Message-State: AOJu0Yx/HeqG1umVTb6ZPkH5N6A+6BLSsdZjxaSDsFkb9DDCvvvp+E0z
 Q9cZlG8s1mIwz13tk+N7cxb5bdxU6LOZiKIY6++oRgyZwPgm6/k8mPuMfSYEKCX7jSYmiWd7txw
 o5f3b0JuE+McmWfdX3uoU9230/uNjxyZMHfyjTg==
X-Google-Smtp-Source: AGHT+IEjGAMKq7QhmA97PLJHSAOAckV4V0OdTnwwdVS1GuK6mpB1ke6REnbeYtF17JCCvr3dvNzVdnxRctiOJe6jxts=
X-Received: by 2002:a05:6402:348a:b0:5c8:acf3:12c6 with SMTP id
 4fb4d7f45d1cf-5ca0ac443c4mr12420123a12.6.1729605192974; Tue, 22 Oct 2024
 06:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241021161156.176427-1-thuth@redhat.com>
In-Reply-To: <20241021161156.176427-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2024 14:53:02 +0100
Message-ID: <CAFEAcA8EL7S0uBDy9rM_i5h1o8G0ER=93CBOrNZ6n1mpF0pdAQ@mail.gmail.com>
Subject: Re: [PULL v2 00/20] Test updates (tuxrun tests, new QTest maintainer,
 ...)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 21 Oct 2024 at 17:12, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-18 10:42:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-21
>
> for you to fetch changes up to c592ff35110a5f7e247d3933871d5aca74fc9288:
>
>   tests/functional: Convert the Avocado sh4 tuxrun test (2024-10-21 16:41:39 +0200)
>
> ----------------------------------------------------------------
> * Convert most Tuxrun Avocado tests to the new functional framework
> * Update the OpenBSD CI image to OpenBSD v7.6
> * Bump timeout of the ide-test
> * New maintainer for the QTests
> * Disable the pci-bridge on s390x by default
>
> v2: Drop the troubled aarch64 tuxrun test (and modify the last patch
>     to not remove the avocado test)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

