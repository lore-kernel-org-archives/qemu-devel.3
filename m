Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF862C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXIoZ-00017S-Iw; Thu, 03 Jul 2025 08:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIoX-00014F-4l
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:13:17 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIoS-0007Wi-1o
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:13:16 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e7387d4a336so7150448276.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751544789; x=1752149589; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9+ZA32YvUuWwIi13W2XKODXe1yTxf/SCxzSz4JFmEmQ=;
 b=qJxQ5tXBFg5rDj3EBTK7XsEIx+VLVCaYK4CN/4NV0OlwBBb31VQerqO6X84OyZmnlg
 KOBViZ2sYDxu0IRIRSgVUGrg5yUQbQ2NereX5LwEu7KcChzpB1ZNCw3vl6YwCMrxIn5X
 ModVTFE9LNE08cII759cfotCEmczG+WUUHHWYXSsFnEwfOSTWPZmvUbR/Jp/URCWuc8l
 /mq/Oo4tcTac3YSw5Q2gMD7qEdvwG6XQKnq5GeIGqbA1QlE/k03nv3JqUeiEDYNfZ8wg
 S9rPV+v/mL9PcwLozEPbav2pGlRhANd9dRil5mgETNEerO1sAwcmcGGAz5UX9djSV5fs
 gBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751544789; x=1752149589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9+ZA32YvUuWwIi13W2XKODXe1yTxf/SCxzSz4JFmEmQ=;
 b=q9N/PeB0o/mOpQ8narnu9BfeHKbwT8B7yGe8nywSl12e9GWug9UGY7ODpy/dAQmTJN
 TihPMufsZeInABAo8IvqCzMPuP0/sdwMhfS4rNq399ftlkVk1r9yn8T5mpClVL75Onqs
 kmRh9P/vZpnTOZvHqiQ43snnat/Fd+X73UMggEnlzZ0IuqfpZOozwOc2UZL/AGmmzsFr
 zs/sG+uCz4bvvES+gggi9QLtTiwj2kEYgBvWvoHKVYYKK4z3YsQqumsxEcumPLslQGXz
 OlJ4KS12bC11FD/B471KzE2wHLbVMqAZgywmFHK8leJKODNfQvQXinC99cOTHhelO2+l
 qGVA==
X-Gm-Message-State: AOJu0YwLTFee6GR+3hg6lvZVlwW4c7XbA1Dp8GmZ8o2AMLZxFSMH103G
 4kvT+4cqrLUcm23r+Sju6qqfIfTzUxDiz8K093PovbbMAkMDbqsZR6VQeynXDgNWHTJnMtZzVTt
 jPNX6clN3ITkNK0Mj/BpqLJ1qCavu5L9EYc0DhtJc9g==
X-Gm-Gg: ASbGncsphiehiR0y2VkyVqT2SkUMWpN/bk3CE4/aIO2zZi8bOrzNMUSQEigLj12Ipgy
 g74Ufb5ymPNyWSwFI21m1TeRsbG/jNMGa3X4K4NxGXeuJi0g5eiM8I20MJIXQydq0KGeawJufBG
 OG60ooeTdqV6ueHK2LM5lSWi2ChMCik/CMiMT7RJfIXglm
X-Google-Smtp-Source: AGHT+IF46zxRihKAdK69D3P4LgvEcI/JxRAf41kNDvUv6pkj1J/zNC1kF1J40z7f3c0TLi8Oum334Ysk9wKtufZ5Nc4=
X-Received: by 2002:a05:690c:6809:b0:70c:a854:8384 with SMTP id
 00721157ae682-71658fe391dmr53998387b3.11.1751544788910; Thu, 03 Jul 2025
 05:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-69-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-69-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:12:57 +0100
X-Gm-Features: Ac12FXxzUk62Lfx5-g9TEmHNU_YY-vv0fvdy3xZcTPK14jVOIIHzs0IfB4S_KZo
Message-ID: <CAFEAcA9LRz0FhXsZJsbfwevVbp=YtQqJWf_5EBV-Wd2OiquDZw@mail.gmail.com>
Subject: Re: [PATCH v3 68/97] target/arm: Implement SVE2p1 WHILE (predicate as
 counter)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    |  3 ++
>  target/arm/tcg/sve_helper.c    | 51 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sve.c | 22 +++++++++++----
>  target/arm/tcg/sve.decode      | 11 ++++++++
>  4 files changed, 82 insertions(+), 5 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

