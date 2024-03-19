Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF9C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcsF-00079J-T1; Tue, 19 Mar 2024 13:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmcsE-000789-F7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:03:38 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmcs0-00046l-Tv
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:03:38 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-512e39226efso4970417e87.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710867803; x=1711472603; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2b3jASX7RFyVohiA/6seRvyBdIah23RfJM1oQS2Tbxw=;
 b=RRZHwZA2mbNmYv+lJg25Ast331NSKJ3VPAnIez2GAgGAmaK6O7zOSdhr9wayYCYqEF
 dYaHSZDwN7JtDd7+0gfMSBL7NeAotLsEIv539SkEjO6Fmrn7L6TUpDCkSSD7yFx5Yilb
 U7e4Uxtj5wMLgr6Quv/Av2rSgPgo6sZ0kAlZqGICbagcVAheKhdlHiJ6zbkx6KKExE6v
 iy2CRSN3g2Z5/HAbUNTjYM9GGtQuR09eIZuts44UxisdEzVUGlX0g8dsLZAtUu/f9THb
 RE7SeyIiWAYV2HL3bK8zMahH4oZeqzbW/b2/MLkSMvW55lt7R/jOlO4rhzsTJOatiiTY
 Lj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710867803; x=1711472603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2b3jASX7RFyVohiA/6seRvyBdIah23RfJM1oQS2Tbxw=;
 b=coPMx4n8O847Ocojh+qUi/3FCQrpUGHjtXiMy3sUm4BAt336P2EsXiWpNRCnIDTpnF
 R6eQT9hAQmkGTbnc1eTZZ2ksDzZ6akbh0csfcYhSr/Jfjh78wTn/QgGTfUSLNzIEvlxY
 Sb/VyW7uO4/VjnuKLDxBmr9Q0DkvQtmBpocU3B2uNRAOGngR6FtFrVq+cgvPv7udiq0n
 BU1KQLtWK7++8nYCkzjRxC6404cXez9TCRw5MXgmC/PUA8AGyxNoNKVWjaqqqJXD+6uA
 xelQKHXtLGNqhAFboUi8BUTikd6uac55ddV2HZO0WqweRM8Itoy6A1fg69L1H0RcewZM
 duNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+hRzxf9Z0XGoLjK636BcwMs1cxgz8KkWVxGkZPkwbTp8WZKFbNnJDrqKCzKkXHs/s9e+TIKjLp2WR7+xxTdVPxwbgAMs=
X-Gm-Message-State: AOJu0YzplMtQMAQViQEMO8Ekn2s9l5kzoCT2uD/UgbvYPxkbOSzaqsxt
 P43QMTBiPf1KE3PKugXG/rlltC454vZCvSjCamLUi0Id0QKTn7RNsF8ytjQqDLF89ugtWhAcNYt
 5mndkLKYGgpauRKMlAV3V8N1c5v8fVwQ1Wjm6NQ==
X-Google-Smtp-Source: AGHT+IF8vA8NNnqe6Q9FmER1WZJ63I4wctLr+ouQ6jwcIIMTwQaMF94gy403vTpeTiNXX500DT+fVfgzUkLn3JcgyoQ=
X-Received: by 2002:a19:9104:0:b0:513:dc90:7d1c with SMTP id
 t4-20020a199104000000b00513dc907d1cmr8101164lfd.18.1710867802807; Tue, 19 Mar
 2024 10:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-7-ruanjinjie@huawei.com>
 <8d494fe8-c0f0-47b3-9f59-ac69f10c1e64@linaro.org>
In-Reply-To: <8d494fe8-c0f0-47b3-9f59-ac69f10c1e64@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 17:03:12 +0000
Message-ID: <CAFEAcA93HZEvVxFWE8GoCEZwOMjCVX-_EdOoubyGSyoMc+f6LQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/22] target/arm: Add support for Non-maskable
 Interrupt
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 29 Feb 2024 at 23:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/29/24 03:10, Jinjie Ruan via wrote:
> > +    bool new_state = ((env->cp15.hcr_el2 & HCR_VI) &&
> > +                      (env->cp15.hcrx_el2 & HCRX_VINMI)) ||
> > +                     ((env->cp15.hcr_el2 & HCR_VF) &&
> > +                      (env->cp15.hcrx_el2 & HCRX_VFNMI)) ||
> > +        (env->irq_line_state & CPU_INTERRUPT_VNMI);
>
> Because the GIC cannot signal an FIQ with superpriority, I think you should not include VF
> && VFNMI in CPU_INTERRUPT_VNMI.

The GIC can't, but a hypervisor can -- it just sets the
VF and VFNMI bits if it wants one. (Architecturally, the CPU
has a FIQ-with-superpriority, it's only the GIC that doesn't.)

thanks
-- PMM

