Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A858CC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJ45-00028h-72; Thu, 03 Jul 2025 08:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ42-00023h-73
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:29:18 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ3v-0005WL-KN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:29:17 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so5523353276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545749; x=1752150549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8xdj6c+38EuRY+1BuRHUGGDUpfQZzXq6foPApM0LJdg=;
 b=SlxU4aKQnPD6ZbeJbVrf59oPVCyAjZ5vEWFoX7HiNiP/r/VWwQrOprqb0LnYcGPuMA
 sGyTQ5OUk7+mZ2IywVg65czgdB8LRapfr4sKIiDHvdemh7lUWDDOcCC+7F0bDj34dGjh
 aqTeI6JQMb7NrCeOO7fCFsRtWxj3Hhj8P64iJ53VTvTIsgz5Rjg5jdsiYC/8sjnxIkTz
 Wa68q6nuOWmXoglKCD8Lc9G8oRELJtPtnRCyZ2aND6OqQLeG7Wi/hLP4FZTTLpFTC/F0
 pkKLceOIZLOO6F15MIRGC2UA3eSq9Xd5qzBh/HwtDEQbzVORcAQFAed4Sb/PjLL6WjzE
 kBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545749; x=1752150549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8xdj6c+38EuRY+1BuRHUGGDUpfQZzXq6foPApM0LJdg=;
 b=G+Lz/zCsK4LQQGsRTYfUfQmATxAxv6DjCySsL3dxbOnoaSQBjro9kkxuBe4v81DYu8
 5ndpnIMOyV/yjr9cgEyr9jy3nevGFMpqwe257iN/TxEXbgRgdFXW7tpqfjrVHeYnsGND
 DzaHOKCxg3GizkZlMbuTaQpVYpDzEVFRr1nDIE3pyqtFhfVyLItZ55cDWrcROCKFkUYm
 EqpIafXrvxfOhxl9Qwh11z6cewUdOzNJxl7G9jhKy6edMm/9cUN7cJ90tJ4buOedNLUV
 /hbSoyPto15ytzx3Wdaz9dV30ZkGMSnI5kXh1GOlBg+mM6+tiuA/HGB5vYX9LI1z0l6Q
 bcdA==
X-Gm-Message-State: AOJu0Ywyn5knqZxsjZQe6YeP5E/AWtBJSyJ3bhxlywEHla0Bb46Et/yn
 ndLUzL+YjxS150KbUrgLBdADKus2tqLB9eb2YmB9G7ezQxwfB2xUkH/DIqnqXbitzy3K3X7Na5j
 T/AhoFbJk4VlfWG17TEuNzkfzdi7aOHPXIXoiDLtQXw==
X-Gm-Gg: ASbGncuZE7Q5dy/hIuvlC7hPrjVtzBHIF7U2WnOwswhWXxM14shAbbLpsdIKz7RJ7ru
 KaQNiHR6nhQAdvqQDqHXxKF3BDKJhVnmrZNU3OQxpiqhfawnXFMpk2EJx7PshSP8rGg4mUiYyDy
 9e9mlMegEFP4GPSaFM3WPgO9S11GME4BN2Cjj1HAYnAaSC
X-Google-Smtp-Source: AGHT+IGiVMhY6/HLLdFYcffoVizGKTU/5D36r0s3ruj5CzfB05VZjqk+YGFRzRWEbfnQUlXxZua2Q+omaNfHS50Yt7c=
X-Received: by 2002:a05:690c:dc7:b0:70e:2d1a:82b8 with SMTP id
 00721157ae682-71659114e63mr51031687b3.34.1751545749064; Thu, 03 Jul 2025
 05:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-81-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-81-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:28:56 +0100
X-Gm-Features: Ac12FXykxzDQygu4kX1dW4atCoFqSZBvU5F1kOYcZPBFtT4VMBE74bTKdnJKwC4
Message-ID: <CAFEAcA-jRUBh223-NL0fDTfdo1fWAafPj41e-nuHGi-OMPmAfQ@mail.gmail.com>
Subject: Re: [PATCH v3 80/97] target/arm: Implement ZIPQ,
 UZPQ for SME2p1/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Wed, 2 Jul 2025 at 13:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    | 10 ++++++++++
>  target/arm/tcg/sve_helper.c    | 29 +++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sve.c | 19 ++++++++++++++++++-
>  target/arm/tcg/sve.decode      |  6 ++++++
>  4 files changed, 63 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

