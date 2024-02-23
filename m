Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E047C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYqG-0007px-Lp; Fri, 23 Feb 2024 11:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYY4-0002qM-Fu
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:37:23 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYY1-0000Ff-CA
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:37:20 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so779708a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706235; x=1709311035; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gbDuLMC+h941sbR5rr+vKCnvv/J26lTcKlZI0jpKbJA=;
 b=IRUNvu+v9mOJy+jPFZtaxkVcccvbAzhL6m/mc/Dyh1UsrmlyplKeNypX3QRT9A98p/
 2IbuJPxDuYXGyU7ZGzQBZO/59lDfEa/+/mmrV9GOR3rvURrppCyQNbhWVixbdrOuH66A
 ZLboWJ8L3vjZeKL61vh/B5SfsMiNfMAQzxcVbCRro4NAWmRA2oH9WwzEZGPA/cvXOEoi
 2N3t8WaDMDVoVgdQOVX286MUKIybm8pVULLrufH8eNYT1UQ4dYII4Rd4y7vS9Lj8gUEY
 KPq/fwdLu0UuCkxIuO4TpeLuxFgy1pAJYa2Fdcgdyxh69knGeP+rio+iizmz0dG/XfyG
 0Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706235; x=1709311035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbDuLMC+h941sbR5rr+vKCnvv/J26lTcKlZI0jpKbJA=;
 b=qdrHsL4hG684/u9ivWh5UgEGfqZrRy4R9ZG1td97v9FsKensPPZBTyNftRWNvgcw72
 zYa+MfI+WGzQMg4Y2MKs11TuogpmQjrsicYx6+w03YEpWt6saP9FjEcLKgcMKsaLZKcj
 JDJpsMbxRHBrsODB64+AaGdWeRHQ4a6SVA72BI4Ug/z+Ntnn90uAQvuTWYnsk5IXzvpA
 voyb5mXt3CLIppKoR1Qzc1KaPTdIWedeGaF+4a8ozJ9CXVvywGI0VzERNrwD59IlERzO
 sHrTh6nOwUsrp8QTwKMcEBzlsM4rDgDJVOgwrx5Nuu/zWe2vzgJnKU4u909vmYpgzgVs
 Cnhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIkWHe/ab9T0QN71x+JIMBXhXjGIsOeKZ8SybmvpnEnM4lOzrMJCUtoCSvxbRbJeH9rvqz6OnpDbNUElnr2VK5y405CDs=
X-Gm-Message-State: AOJu0Ywwb3QzpPYCkpidlsLVDdzeBe679cPt7KanjkCojNZ2hbNxqHkW
 Rk11g8v1KQ+EBInCaRfQVQbsOMhE6Po1XbsFjxThPJ6EmBooy/YAA8V80APCKcdCuNItXYs3uUs
 XuXeOz+0evRDrOb4NuO9JsiEkksVtsUqx73Z3Ow==
X-Google-Smtp-Source: AGHT+IGGPoQyKvTuuBO3LJGnUAtvLS87Wf3ZocowHof6PaMO58Ytm0CXzqtVCUp/jzLQ/4dTl3UjDzrFWVU3oL3Sc7o=
X-Received: by 2002:a05:6402:3411:b0:564:7350:cac8 with SMTP id
 k17-20020a056402341100b005647350cac8mr268230edc.15.1708706235607; Fri, 23 Feb
 2024 08:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-2-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-2-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:37:04 +0000
Message-ID: <CAFEAcA8kOKhd=BH9m8kWFsaJ2NQHOdfwg+9JnCHDNDsni58tiQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/41] Split out common part of BCM283X classes
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 19 Feb 2024 at 01:18, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Pre setup for BCM2838 introduction
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

