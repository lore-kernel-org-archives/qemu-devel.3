Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A5CC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 10:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCd3G-0001GJ-PK; Thu, 30 May 2024 06:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCd39-0001F8-JT
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:30:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCd37-0000ps-27
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:30:22 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57863a8f4b2so844030a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717065019; x=1717669819; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jt33+swSTK2dSEH23iCR5MbnCc7IK5ESWO5qH12q7hc=;
 b=nO05KcAz+D5+jH6bMZjGY3++VnxcV3PmLnCQvLe5h5RZPiL9pJS/weEqifcMQI2Blt
 kMueb3fiKyHyfqhkb9CBTPvbKmdYKEnsCC71i2JevBLcrTD2yma8eFu+zX4X0pKWHrfh
 FgY9GZE5ecvyUSxk19uS1n4PQ3WebEQviuu4fJlsA8ed5UxK1n+gnND2Pi+Buu6btAQP
 GzwP4bY+azbf6GBClHyR02OHOM2CKQYsAtsFPsLleSvkUyAKU5dOV2wjOMyoUFbw8nLr
 /7B4PW6aqAI9yTDQuPC7EkK3AaDWOD3+18QLeQQXDlRzWhT31p4SZ5nbywHW/Ik7/9sJ
 wcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717065019; x=1717669819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jt33+swSTK2dSEH23iCR5MbnCc7IK5ESWO5qH12q7hc=;
 b=mXTIJLtXK+sFhX6O7gpOYI/1SMTahHDI/yZ9w6VEdE8jqgO3bGLpX5EkLsK4LJUYL1
 GMEZqUuXoSKQqt9BFBvORTf0eS0Oi32xY+lQmMMkTpwdDZF2xhoyH/FuEuv0ysZSMEJp
 b8LdRJsjWh1FUKm+fvuTmRiLNtvtRFmQaJ8rkAhNWIwU94/TT2mh1stXP7zOuc13nSDQ
 I5qAq4u+S+PReQ1Dq2qLdUnclBFDLhXct8bafKzsU3MtBZz1o7fGxaHCLoNHTDAqFx8w
 QH3I8rEdIraKeqDYfSoM8lw8T8LTFQOpvyEqLqm+hTxg37pL9cMyw7g6uArXZPhHYAvm
 H6Bw==
X-Gm-Message-State: AOJu0YzXP13F/b74PYE6vC8S21Vx3Bs+P1rdlzMoMBiT9JmTVdNe0fto
 +LWPMHrRtKm4juZ5HHY+4tWcIQN2XugkXXkLf4ERvGMe0jCNg6j2L8w+5jbPldznLxVqhT0z3JK
 yClVsOMhNeW8wNrLm1jA+MPhpvRY5kZwRUwxOUg==
X-Google-Smtp-Source: AGHT+IEGM2nceeG70DyHm+BOi9q0/PVqzpslgM3Rb8kRZDAA34PdPqF+zotFLT07eserA8LuY42HxaTvn+lITT1FfbE=
X-Received: by 2002:a50:9f2f:0:b0:57a:23eb:13b3 with SMTP id
 4fb4d7f45d1cf-57a23eb1421mr607671a12.12.1717065019278; Thu, 30 May 2024
 03:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240524120837.10057-1-sebastian.huber@embedded-brains.de>
 <20240524120837.10057-3-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240524120837.10057-3-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 11:30:08 +0100
Message-ID: <CAFEAcA95Vnz4kyBeTNZWJoa-dmxTnijteFrDzMUqHhuBvmHcSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/arm/xilinx_zynq: Support up to two CPU cores
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 24 May 2024 at 13:08, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> The Zynq 7000 SoCs contain two Arm Cortex-A9 MPCore (the Zynq 7000S have only
> one core).  Add support for up to two simulated cores.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

> +        DeviceState *cpudev = DEVICE(OBJECT(zynq_machine->cpu[n]));

You don't need to do a double-cast like this, you can say:

   DeviceState *cpudev = DEVICE(zynq_machine->cpu[n]);

(I'll make this minor fix when I apply the patchset to target-arm.)

-- PMM

