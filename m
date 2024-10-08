Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C5ACEF17D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syBAz-0006Xy-35; Tue, 08 Oct 2024 10:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syBAv-0006X6-KV
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:26:57 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syBAt-00018Y-Fo
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:26:56 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fabd2c4ac0so62010511fa.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728397613; x=1729002413; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RQozRerSiRfKC4vBeczSbk4ogjlVq89iod84xYTjpH8=;
 b=qbk9y5bsRX4BdYX5AkrBawphp/l4T58y5ZIkF0ZDXnII8zWZE8Kt/zsQ1X5LGHeMsT
 Oxn1N0ATL9GFgj8a93tMNDU2HaMxIXG3Suydas6BsO/vxwPW1Ksl+o2wWhfQXUDppeCY
 767Ws/2epaLN+rJ2ZLatCMH/HMD8ZoCGzUcoXIsQ8qhPMt8e7J9iSnZYxkyXfOctuxHY
 TKSWkQ4sdd8u46TIV/JEha8h71Xb+Ph/ceM1/+AMzj7zChpBpgHa1Pfo5dMBKqVekhsr
 gX8B7efhvWfmK4nDEXauU6cYdwJFcMZHNkjI4LuQfLee4D7BHbjEuWGAyREiTnR0nKTQ
 vORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728397613; x=1729002413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RQozRerSiRfKC4vBeczSbk4ogjlVq89iod84xYTjpH8=;
 b=DBBwueeB6Vri/4yiS2o/dPR0xcfMzgLWq/FTZGLGbDMvYc3HHNMCfcycqjx6N64N/m
 g4o5y8vH1IDoKso68z4C065TJWWYQGSM939upZaQ7fVEsBqegEmWVB7nWAivODp82Z37
 OjfD+q27scfBdZ8Mtr1BKFKbWK9wKF+0imelnErTQ0kOPohZrp8JKQLmsQ1yYTQ+oXqC
 tRdxNeqErbbqiftgN+QcGIn7z5cYwJBxjN5rVkQZ7ztYhlILMjg9D+t+pHhRENkTBuNL
 ciXBY1Yre+RKVWZSMCLmGEa/hEbP+03pIEHceobqTfS6HwA37BgD2vS2l/XNDRvbQ5h4
 37Cw==
X-Gm-Message-State: AOJu0YzL5rBavt3/gs5MpPTZsXvEPUi9NT2SebnFyt7G1UveDQ70a8hP
 R/Bckq/VZDKjT5ucH1/dNM5XhfStLcOBoIH94OTpOFYytfJiFBJ+uTIyGyESDjHFlLbHmuJanEA
 piQsqs/zdWnOizGfnLj+P4SNhjd0wCWU9ZMsU9w==
X-Google-Smtp-Source: AGHT+IEK40RZGPZt5Ym42R8l1+Af5CABSgiP3N8qQETkX12gAxA9awW14sA1GNRaKGIg0p+kd3F0YmluVLQN8uT/C+o=
X-Received: by 2002:a2e:be90:0:b0:2f7:9d20:3882 with SMTP id
 38308e7fff4ca-2faf3c63ec9mr87028611fa.22.1728397613383; Tue, 08 Oct 2024
 07:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-16-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:26:42 +0100
Message-ID: <CAFEAcA-d3MHj=_Ma6MHLGLT-nW0iKA9fV7C7gmK9pnG-9NXZcA@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] target/arm: Pass MemOp to get_phys_addr_gpc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Zero is the safe do-nothing value for callers to use.
> Pass the value through from get_phys_addr.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

