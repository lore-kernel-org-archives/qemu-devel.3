Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBBBC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprAi-00085Y-5P; Thu, 28 Mar 2024 10:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprAb-0007yT-TA
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:55:57 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprAY-0007FK-Ay
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:55:57 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-515c61a74e4so794400e87.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711637752; x=1712242552; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8TY7FcskIZBYZwKsnml/Hy1kUHUtaLEmLDD3ELdVs4c=;
 b=DshatkztmglZOWH0iI5KFVjAU+Lh8Zw41XJ4p63wAUaiJqw24QqFE7g16B/br2zEr7
 6azmYqFGeZrKApWKrZ5DeE2xFhtP/caw+x0FiXlJNTsogopcpHBX0Mj117cI3zYauzJG
 SrydFz2lXJw0rFyhSBlDxZMTxvnL+NMocVXsbuh+BahfnQ1alM0bB09KMO0R2c174xx8
 m3lukXlj/X5By+ZvJOj7WWsRjV65KNrJbyXydWwqk2Im9PCS83opEbks5ST6O+Xhq8mf
 JaCaBKLNbl+EtkC86K2biGRLJEGbrUrgtmKDMJMkwUctzzSJhyc3bBnYm5OsS2vZT2dG
 Mztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711637752; x=1712242552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8TY7FcskIZBYZwKsnml/Hy1kUHUtaLEmLDD3ELdVs4c=;
 b=aNTRR973yotgQxZ0Rxpi85GTs2CbeTt8qPvU+MWfNHh0cLdsj7x1mTO1lxCLf99W0O
 LfL1jWyPVfFvUPG/VNe9BuohVdrDkUjeOUrmgjFQzCVa5GQo6f64sd9FCBFKh5ZIwXhu
 vsH1b5+WQL6aJZFy/2xAzhdf/E3CmSnsAWl0z7GFKuHGybv9nTA9BiiB7CwmNxpV0ii/
 4yEKN66Jm11JzJoWc9HsE0H99a6d6MBOZchafjAWsFskaa/X2ZObG9Qv2p+huLU3J8Nk
 +veuNDSofDFhFdTGqLVNZ+RrFrlfp0trK+Go2vlbdmqEuFDlnPDp2Coq6Sn9gow5Tmco
 XBoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOPSBUkKA5MAg+leGnf1N6TxXCLlCpD1lbfPTMBGfUcFXTDQa0KE6cfBcs5xRP0Z4S2+oAp4zXOQ91Z1P9iMqe3cr278k=
X-Gm-Message-State: AOJu0YzKurgmksfGktlxi3tgBAO7FWCw9SSt9RyolcPuntqVOOusaWx0
 a9qiAj48NO39zOaz9nU26agBd/K4qSdc/ERmwS6Yde3c2A4NtKruyy6D7TVapbJYpStps/RaDAg
 YBo/8TtunA6PmOhrSgcgD3a+itqSlAFDWxMASYQ==
X-Google-Smtp-Source: AGHT+IFDyQSPff3/juIaMzAtbd7s0mpIDBnZE9BFiBLbymneAAkgPZpTDSf2WxZWv1A9CpmyeADacFc7V7T/ZQ2oeSU=
X-Received: by 2002:a05:6512:2f1:b0:513:1577:3d66 with SMTP id
 m17-20020a05651202f100b0051315773d66mr2162929lfq.64.1711637752622; Thu, 28
 Mar 2024 07:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-12-ruanjinjie@huawei.com>
In-Reply-To: <20240325084854.3010562-12-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 14:55:41 +0000
Message-ID: <CAFEAcA912XopYLBo52PEczE8tSp4BPJB-Oxke3OQRW_X-Wrh2g@mail.gmail.com>
Subject: Re: [PATCH v10 11/23] hw/intc/arm_gicv3: Add external IRQ lines for
 NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Mon, 25 Mar 2024 at 08:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Augment the GICv3's QOM device interface by adding one
> new set of sysbus IRQ line, to signal NMI to each CPU.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

