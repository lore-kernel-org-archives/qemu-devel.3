Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC96E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLP35-0003i6-SO; Wed, 11 Dec 2024 10:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLP33-0003hM-La
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:54:49 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLP32-0003zM-AQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:54:49 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3d18886010so22967276.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733932487; x=1734537287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TlpwIXmcyz6DCaOErKJBIKCl8E1QjfX9Oj7cY94iv3U=;
 b=l9ShLHLCdjonlcYNW5pNJ49Gjxcv64JbKSTriV5rZ8d7CdJzVcw/6YstHVX16fujFU
 qnAtwaQFq1WUNcfxl/qmgvi4fpSNeaBHsXnNwWs/lnHFLz1FJWtn56uto9U8NmfZFqya
 6S1nHOv72w4KW5P6HD0Vyyi9GEPP9uOGmpb6FrRt0MAVVW0eo6VPAcRuJcXXJ4iDik5Z
 PtO8akhvmQ3kcBiAlkBFGsc+gEEGITFnUI/Ii7zHpZejEogB2q4jDHb+Bs3MpP8e9JVb
 axmWdJSAcg7NNXjppuvbkk67jyp6XAkBhQWcowPVuWOXe07E9/IR9Xrgy8RwyEakXEdS
 1aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932487; x=1734537287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TlpwIXmcyz6DCaOErKJBIKCl8E1QjfX9Oj7cY94iv3U=;
 b=UGYS0Nvd6akGpyYESgOs2LJDNoI4jyW3QHcQYQ9dlZLZQi78oxf/o/lo+bSK6UQ27y
 NqR2R/0G6awVgOXkki1MWbfF2++KeT9UU0hoXdE01Z6r1f+oElQ18JSC6wOCKHazUydF
 BKXTinOG5Qg5WFkN2jkDo9iMZPKvBFIqk8bf/7R6JIqe8TUWhw9H7AwNUhUSSau7o4Yg
 LRoVUwBVmJkzmH9akPOe167CALGsQz4CU/2xUv2zHkkS8OpRb8qxywvv9pR0l6/4AMri
 gGik7ZzYb1Wox+meK5D/UN9K8vr2GvBfNhQbwTvjmnzyq8IHAbnCUAknAf71nCPTT/X7
 c7Nw==
X-Gm-Message-State: AOJu0YwnUKvEe93tXgotkpnQwGzAKbMy5Bc4KS/8Et+ZheXWSkVz0sYm
 c4njXmJr4q841K8Xiq8c8+9Ml8GIvk/u2RECyLhsfayEuo9/LWKmTnOFGzOEL+VcwCbM3StsVrE
 gSQkvUoPLs+sttgb+9+d0pg03MfA5ZGeBi+J00A==
X-Gm-Gg: ASbGncux/OH5OJJ1ynuLFRQ5Xmv8/T3ChZPlt3w/vFUCEmnKIuHkxoX+wNLeRZ6eeUQ
 IKRmQ9dTrukLk+ep9TUDk7i/PT+6fIxB7LNhe
X-Google-Smtp-Source: AGHT+IEWteaJN01p52I1musnTUW9Q3aShZk1XcjDsT+xeM7PVT4SeQOUZjY5iVhYE2vWYmKZHFg9eb8+xOxR0UsqgUM=
X-Received: by 2002:a05:6902:1549:b0:e38:a15d:40ad with SMTP id
 3f1490d57ef6-e3c8e42da9dmr2370440276.7.1733932487205; Wed, 11 Dec 2024
 07:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-44-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 15:54:36 +0000
Message-ID: <CAFEAcA8xx_FWYcojWAQHQstkPH7GO5taweo2Lop3MenGpE_X=g@mail.gmail.com>
Subject: Re: [PATCH v2 43/69] target/arm: Convert handle_rev to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Tue, 10 Dec 2024 at 16:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes REV16, REV32, REV64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

