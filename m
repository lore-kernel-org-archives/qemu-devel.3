Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4431E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPGu-0003um-QJ; Wed, 11 Dec 2024 11:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPGd-0003gL-5X
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:08:51 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPGa-0005dm-JZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:08:50 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e39779a268bso752065276.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933327; x=1734538127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgXhxKsovO2mUySK3XXly2g4lapJwYYTu0gwvcav5G0=;
 b=HTtVoO+i2jNvU2ci/XjACbEA7zIB/m+9C5Dn6lIBNK6HMvx7BO0HbsmkOWJgPIg8Us
 7HHdOR+9r1DkETlRwz4/WRmV8nssyC5ykhaWEDViI0YXwwFx6/T19+uJ3qmeBmS4qUNJ
 mOBunOszeXEjte01KPL6UV7CdABoBJFVcxZ89e7TGRHRHXgV+lNAaN/PBXYULv0OLrOY
 5tc/d36+h1gJKul8g9XZHUd/fFo0jkzOFRNuBc6t2pKFfXvuNUDqLz0YY8Vd5VkWIqPG
 +JudMdvoxQzuoMsHTqnhXyBo52s9JNxKGfANiMSgWMvW/lvFeJEXoxYKHp8hOfG1Dw9y
 wXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933327; x=1734538127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgXhxKsovO2mUySK3XXly2g4lapJwYYTu0gwvcav5G0=;
 b=Q3JYzb0FTUSj+IEIjuJdbsDtxk6lPoBucKTYKIVExDC0/b0gR68ud1sUTRFR/xAMYx
 qyshc5CT//vUOow0JFDDI4G/FX2FbnvfEZ+xU/9xHfF//hfP6a0k+xCG+e/p/rgn9WVs
 VizTVcM27omxzBXiqupuybw/43MhxUdzLiDLZjJRGuE1yMbPQA31qdTZSu5JithpngVB
 xm8ZJnHNMdCZIRhYOTgY/slfSXrHUHSz7g8+8HUJ/D1JQYU8tFLKbCi7Qnuin/XWlm3z
 F41GNt8DCPx4jhmcz5/hHkIamosRv1vfuX5y4aumDbZCVZ9tYB1N+OELjs5e1i+SdM0P
 qggw==
X-Gm-Message-State: AOJu0YycFIMmIcpmVyNpOhpRQ3kMLtzgHldYb2aI+rYm8ZK3/Gm4poZ9
 srkCEwb09scj6wZf2mzqrVo4A1WQfwdJRDw/CLnbJcOXxPOQhWf4N8qP6+uqJXiaywJFv5vr+fF
 o1g1SyfLJh6oXAG5TekTNCkLLadtLk0FAfv43ow==
X-Gm-Gg: ASbGncvzDpqZm1aaURgoZkckS7t63ffRhin91y7kWZDDLXJkCP1IJYVISj2+yzl2f+d
 bu2YsU7uMq0lgNK6I/eVIdFdspg+unM9zqcFg
X-Google-Smtp-Source: AGHT+IEAmRcTH3Lg4tLztOT9+g26QqRrQJH5KnFAO7i6d62CB2DxAOCK+YhestRPfgKj+EHoCyRaP4BwaMiIdfzNfhU=
X-Received: by 2002:a25:d045:0:b0:e38:d000:1555 with SMTP id
 3f1490d57ef6-e3c8f97116emr2972607276.4.1733933327140; Wed, 11 Dec 2024
 08:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-65-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-65-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:08:35 +0000
Message-ID: <CAFEAcA-7O=w7UJAU=ESeV29YKRvPS1xmt2Hm_QmXFqN_Y08yRQ@mail.gmail.com>
Subject: Re: [PATCH v2 64/69] target/arm: Convert FCVT* (vector,
 integer) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 10 Dec 2024 at 16:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove handle_2misc_64 as these were the last insns decoded
> by that function.  Remove helper_advsimd_f16to[su]inth as unused;
> we now always go through helper_vfp_to[su]hh or a specialized
> vector function instead.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

