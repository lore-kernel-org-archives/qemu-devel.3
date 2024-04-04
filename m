Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532B0CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNqy-0003If-LD; Thu, 04 Apr 2024 10:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNqt-0003HD-3n
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:14:05 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNqr-0007qU-Kv
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:14:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e2119cffeso695278a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240039; x=1712844839; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kw8qSm+jj7rowiqyw2J7UwXOS57ueFbUIQr2KQjl2JA=;
 b=e3onnncSO41qGZ4cAHHM1nK0qYxJOtlKYOBnzLcj8FBKzIMREBEwpRdDX858NG+i1l
 q2AYSNPoj9YxzEGTyjEZ39wPMn3qYPaVW1RQ/07K4qB+Jnlm0xM9HJ1vT7PP63EXwxdu
 PZE53oSsnpB8CxPrM0oJS0IMQcm2fEUvKvzuDO14nincpzyGf8uET663SqnYtjtjmFi9
 mLg7CpkFCiTJI4IwkBbDGLX0o/5+v7EcZI/RA5atpS88oV5AxVbHpSrNLjrI8R2Uis5e
 97HBhKoOQqAX9k53+2kb6mjvkkYKoQell5HWajKIF/rXMADf2mHnE/e8qxfVz/icQNgS
 kPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240039; x=1712844839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kw8qSm+jj7rowiqyw2J7UwXOS57ueFbUIQr2KQjl2JA=;
 b=AIlmOqrftvmm6Cka9Ph1SgNTtNe0K00MrVuuXVirf5A1/a56RY8kTOhoooCS+qoKm+
 HGYc7QrAd3N/cgtATY9gliEw+0iALeqeYtTusmlKeR4yl3vgN7L21VVzGV0PscZD3dLw
 QxHjJmDv11UO98ocgjLI8Qc6o4Xb7SDF5T66eg4RXYqHOCuZ1hBn1uRjVS9LAkdsOnnB
 JIgKf24pTX+a5Rsprgb3GGCX4+lbvMfW3CXxj3k4i/cL1Z1LwYvkncqXEkYFpVnbL4Do
 fNlaGdMss7GrtaidIMeMjJOIlFH/FjxtNZ0m6c6t7sHbSkEWKfUeFV9hF8dwNsib6Kxt
 pL1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtkamwdKTNft3Q3qr/8VRJikvna46WABGEnG3/lwJNSvZMvpDR8rFnDMvY7xwsDzIDg1UvLKNYdv5mnirtp9DdUKSVoPQ=
X-Gm-Message-State: AOJu0YwtAEKykJ6exZY0kAR6mzYJRkceYsoDPljqYlHnq09efc6TKNfL
 FNaRj44wwnZHD92hEklEl0rXgTSAjLNx2Bid0kPyJKWZk9yPVtIFXBdg0nDocUuAdItgIR1J5vD
 Ol+vPenibYlvPWVPD7pjzC9rRU/RhIG1ZXeDDXw==
X-Google-Smtp-Source: AGHT+IFmhHr4Y5XRa1UscMZ0Zq1+I2ep0MIXFILRgSnHrfl3uVhQn7p1TK4AqhIPQDrvexCR3e3bHvuVfa8WRxZGK8A=
X-Received: by 2002:a50:d4d4:0:b0:56b:defb:3b59 with SMTP id
 e20-20020a50d4d4000000b0056bdefb3b59mr1598780edj.19.1712240039130; Thu, 04
 Apr 2024 07:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-6-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-6-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:13:48 +0100
Message-ID: <CAFEAcA__1g2zD-d3HWP=N5i4Ln2bmskx3QHp3tVOga5-MteCvg@mail.gmail.com>
Subject: Re: [PATCH v12 05/23] target/arm: Support MSR access to ALLINT
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, 3 Apr 2024 at 11:17, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Support ALLINT msr access as follow:
>         mrs <xt>, ALLINT        // read allint
>         msr ALLINT, <xt>        // write allint with imm
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

