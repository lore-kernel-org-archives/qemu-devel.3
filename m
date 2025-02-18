Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F970C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKpz-0007Tt-DI; Tue, 18 Feb 2025 05:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkKpx-0007TL-SJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:28:21 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkKpw-0008CL-3H
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:28:21 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5dab3f372aso4164409276.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739874498; x=1740479298; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UeOOGOFNXXCZBQIKn0Dh3msNBOIW++sG7O+b1/LW6aM=;
 b=R3i8rjjy57BZrQQ7SGIeK7A1MUUIvVmvhcSZlDOESLnzAkoLulipIXME8ph/ButUWh
 3v9BHfbpl5AeGpSrsIVwhX+HjOwzBSGkaUQZKOlw6H3mdoAfVFi1rlfR8QhpyGcytO7b
 fakiZqrQbWPOzR316NxChREMZ78DXSVvIF2NXZ1qixxizjBREN5VhvQNjgf+2LnPxV8O
 Bcypai3NTJUyWipQiQKHolibk0ce2H4Ac2DaTL787gOOeyPr8fOlW4Ofl/tXjsdwi03R
 OnWz/9UF4iYda4bzFkGsie7V9mJaEjAWfkOZOaau+tOvFMWb14iQpU2jdXIHR38E5xhC
 kBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739874498; x=1740479298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UeOOGOFNXXCZBQIKn0Dh3msNBOIW++sG7O+b1/LW6aM=;
 b=EZ31DQtuyH3tvVFgt8lsM3UONrPOCbMw6l5V0mIf6RydWxBdH+7enEaQ/1WeIzFMLt
 WkuM0fOblMX1YCcGrhP9UZATPzb7LQjV0Vj07ko7Vx1zhVBBH8TF6DfpL0BIZj5Z+AWn
 7Wno2GufZn0KJPbeCf34ZCzZWEG2BGmQBVwFsy46q8mNqnEXuKCEe0yg/IAXZQgmfTFR
 xIyTE67jBBIZn0MJcIz3xFqI1fqs3ff2MUzr+KuEjJKul33b8y9yCK5/cD2F9gEzsTzL
 LoOgV6n8a6W8QJ5UDwoKSLzdLXCH3eRL+RJRTpKFGu0hmveC98jm/572sxfPzVEOK6aC
 zYqw==
X-Gm-Message-State: AOJu0Yzh/qI0gcu8qY+KLfL3BlLFY+edtRVyEnuMu+viwE1FNNa9r5Bl
 2JzKTAO0qi5f0JzsOk/N55DnDdOQrfR37JHNDfBwvQ81E1SjtobpyvawlHeoGKY/XqtIvxya7GE
 ZeJH6HXaV4L9LsEN6yvJU4Lig+rWliw/du/ALKg==
X-Gm-Gg: ASbGncto6QXA+AomDvS/C5mqp1YhfCthRgmJqgw0DSq5KLnGE3FCASE3SxUHiEyPIv8
 Zx3Ba35zYY74ZY5tEOEg9/dok+VBqEWQf3WRkpB2lvg4NYtTi+tsZyU8d1FV4FzI50P36zfHqCA
 ==
X-Google-Smtp-Source: AGHT+IHWvOBAtJ009AevMWpjG8VR1QuwJ3/u47BrbMrBtAMhs9ucDQwEqgJnxZjxQkSW37uptiedtxlYJ1+gsWJNJUU=
X-Received: by 2002:a05:6902:3408:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e5dc98b2a49mr9422159276.16.1739874497936; Tue, 18 Feb 2025
 02:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20250218085835.64928-1-zeff@altlinux.org>
In-Reply-To: <20250218085835.64928-1-zeff@altlinux.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2025 10:28:06 +0000
X-Gm-Features: AWEUYZmg1CLKmyyDvp-hRAFxEKqhHM8ZSTXVhYv8qihJIa1FtvUNOaXM1gUhzjk
Message-ID: <CAFEAcA_A7oqFFP4Kwu8QhHQYZsoXarowgxfhcVP62ZB397oEDA@mail.gmail.com>
Subject: Re: [sdl-qemu] [PATCH] disas/sparc: Fix integer overflow in
 compare_opcodes()
To: zeff@altlinux.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, 
 sdl.qemu@linuxtesting.org, e.bykhanova@fobos-nt.ru, sergeevdv@basealt.ru
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Tue, 18 Feb 2025 at 09:00, <zeff@altlinux.org> wrote:
>
> From: Denis Sergeev <zeff@altlinux.org>
>
> Fix an integer overflow issue caused by a left shift operation (1 << i)
> on an int literal. For i >= 31, this could lead to undefined behavior by
> exceeding the 32-bit range.

The only case here where i >= 31 is exactly i == 31.
QEMU compiles with -fwrapv, so in our dialect of C
a shift left of signed integer 1 into the sign bit
is *not* undefined behaviour.

thanks
-- PMM

