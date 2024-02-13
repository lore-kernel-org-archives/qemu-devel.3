Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B56FC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv3n-0002zw-LQ; Tue, 13 Feb 2024 10:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZv3l-0002wr-Jt
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:01 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZv3j-0005X7-Oj
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:01 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-561f5086a1fso926106a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707839457; x=1708444257; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v++f+aX1lTrmT2lq+VRxWggWXpnz3nfrAMvD5brQAlM=;
 b=MH9LY01tjoo2CCPmU+cvL4w/OrwhhOjmDD/IneerOPIb7KpC1RNicK99SLXH8zfa+4
 ge7P2bvI6yXXe81CsHgFXun69iezSiat/yo2GZorAXBheCGE9K6f+qVZrfMiUw6H11K0
 fnHDayHh1xa8/8wEEIdJFmyeAVlYbI3zc4SPLqBfZ/vUmgN1vjgVCaCXO+dMG+xcMykU
 mthI7jb+XmtXGwi78pJO/hzEqud7awcVsG5JvVE6y67jmRr90xujYWzqjP+FoMkp8ar4
 7ID4CnrkL6FrLl/MUeDQe9KMURC93eKWBFEN7zOIa1bHftaPbeZnoZuhGodXxEgemKS9
 CUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839457; x=1708444257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v++f+aX1lTrmT2lq+VRxWggWXpnz3nfrAMvD5brQAlM=;
 b=mm6c2AAWuvItE1XT1oWaeqgCT82D2cAAjTuiS2iAaM47WXt37SLLxaEU5CNpHPvwb1
 AoCzZdrvIPctwPhaXT9LR/H+NTH1BTWp65odYxgzWmCYSjABMDZoJ8D0eVGthH2+9KxY
 lBRi5WhVnzHPefNbIj3TdLLpXxqsPWq3/z+z+ojJT8Fb/hjX//zQe/aG2a9t9/VNrvbJ
 0ZYRVEo2CkM2xV54hm3jk3NXAYDvRAjqjpzU3mOCqxxwDlXgaOhI2T3LFa4xjEoIMyo0
 FPHkVvhuDVmo6Mqm4OAyFZK5UHMHhgRs7GFQXOEOzO/Dx7eWPVFA+KSvghOEuaPk8/Jh
 7hew==
X-Gm-Message-State: AOJu0YwmIwei9p2gvgGgyS0FKjoVY9zq7/kcSJSn41Bbrf7fykocakpl
 SN2Mtk4CMNAZl1TQl05VQiqc81yVRXZJwGbxLU/bUE5Ln4SW2Y5cWW7RzEyzjVDfXhW0Y8sDJGx
 k9qU2JYt4KK8FkHrPuylbgMYuTTqiLAgtLJ85PA==
X-Google-Smtp-Source: AGHT+IF0qBdkSRNjEwS6sKyQjxk+A/DPAd+gsN4bXYFfHl7qrQut7EVm69kPSIf+YFuqwnc8il/9hcRCkmmr3JmUgxE=
X-Received: by 2002:aa7:c58f:0:b0:561:b28:e61 with SMTP id
 g15-20020aa7c58f000000b005610b280e61mr34278edq.31.1707839457598; 
 Tue, 13 Feb 2024 07:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20240212234723.222847-1-deller@kernel.org>
In-Reply-To: <20240212234723.222847-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2024 15:50:46 +0000
Message-ID: <CAFEAcA--wZRZQUS1dJapAmgXG3Q4VvMW4GbyERpKUUa-BaUtjg@mail.gmail.com>
Subject: Re: [PULL 00/12] Hppa64 patches
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 12 Feb 2024 at 23:49, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa64-pull-request
>
> for you to fetch changes up to a9314795f068515ff5925d0f68adf0a3215f6d2d:
>
>   hw/hppa/machine: Load 64-bit firmware on 64-bit machines (2024-02-13 00:44:06 +0100)
>
> ----------------------------------------------------------------
> target/hppa: Enhancements and fixes
>
> Some enhancements and fixes for the hppa target.
>
> The major change is, that this patchset adds a new SeaBIOS-hppa firmware
> which is built as 32- and 64-bit firmware.
> The new 64-bit firmware is necessary to fully support 64-bit operating systems
> (HP-UX, Linux, NetBSD,...).
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

