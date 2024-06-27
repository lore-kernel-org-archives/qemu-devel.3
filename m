Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE334C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMtCN-0005GE-Ul; Thu, 27 Jun 2024 13:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMtCM-0005F4-Ix
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:46:18 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMtCK-0004p8-Rw
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:46:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-725a7b0fc55so1365813a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719510375; x=1720115175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zy9+2Y5z+E/jcgEQDJIKFs1CFOQ7j8fTTrfraUdvMS8=;
 b=UEC4O693l046M5JzlrFDec+fbjz4NTtWMf5n6Ae2hOx5/VX68q+GfGEUAgrcGCRjhR
 Afcjl5Gpel9wtKid5gCqhwE5giRN1JYn7zqA/3FrFIXNC5OQdN0KDZDwcQKtyIUn7oFC
 w3VamPivWzRPWj6TvdnE0m9/fl4TpIBBvzfYy9yNssMu1S5vTIfBGzs4nMw4IQNCfkY9
 Bs0BvtFLg2rcyNa+st+EjTYqghgqziKMkvcajCu07lIYVN8YPqqHd5F2a40eMzhpljiO
 0w7jrQqisMsjqEYsSbtQOEDRi5UIxyOF8Fa0wWfSEkI7ZuN2ZqtNxdl/E4W1pJEYYwv8
 BRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719510375; x=1720115175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zy9+2Y5z+E/jcgEQDJIKFs1CFOQ7j8fTTrfraUdvMS8=;
 b=GqPpP8vFVYGJsN3rCgRXbPnSc/lerFf3QpnSoMXyMaPcKCN4MfexvoQ8yZOtleMKyC
 hDmQnchLSfnf/p+Bru+WktobZ+BuHcE6OFJqwDUvertuvPJowTBmFUaQq35yMq55wFP6
 39W9OwQz0gvO2xrIoDXECBhlmLM1XgPDSMEvXTowZD2sXgqPIG4kdg1Kl63Nt2yz5uzk
 R5eKudR2dLBMcOtzN9+NjspL2fxFWWU0WdrrYAK0GjKyCHNSDgH8bGj6uCAlp3HB2LQq
 3EmrnLn0zTLsP9e7z8XeFzgdJw+nF2K5PRyf//GsNr3zSP5By+BeWKspi7O92NaZWAy/
 pivA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXPaLEQxURcuCIffVETfNk7Eo8oYHZa2ZLrZ1BSBL7A3SqQ8n1cyxS+oeS0W4C4fSKu576WxJ1S6YLSap10b8q46aHb/0=
X-Gm-Message-State: AOJu0Yw5QhqCTP/fT2AoOS8Bq8n60D4V4R25rxHv+P6DQYVg4ggm5DI0
 dwnzqt4vniMw7tbxOmL2FZtWWxbklTMQlRKIQxsYqdIYb2NPXsEpm/90oBoedpc=
X-Google-Smtp-Source: AGHT+IFP87fC/BK50bK/ixIusZOpeuMd5DyLFCSAZ6H/Supki/SbGVeedgEwNtYeoZGrq1SJXrFDWg==
X-Received: by 2002:a05:6a20:4a11:b0:1bd:28bc:b047 with SMTP id
 adf61e73a8af0-1bd28bcb828mr6514710637.0.1719510375017; 
 Thu, 27 Jun 2024 10:46:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d88e6sm275645ad.95.2024.06.27.10.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 10:46:14 -0700 (PDT)
Message-ID: <a9f9fb1d-81e1-471e-bc41-fddb98561d03@linaro.org>
Date: Thu, 27 Jun 2024 10:46:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 6/27/24 03:00, Alistair Francis wrote:
> The following changes since commit 3f044554b94fc0756d5b3cdbf84501e0eea0e629:
> 
>    Merge tag 'pull-vfio-20240624' ofhttps://github.com/legoater/qemu  into staging (2024-06-24 21:30:34 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git  tags/pull-riscv-to-apply-20240627-1
> 
> for you to fetch changes up to 2f5a2315b84a9b1f089ecfc3f31b29813609a7b7:
> 
>    target/riscv: Apply modularized matching conditions for icount trigger (2024-06-27 13:09:16 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 9.1
> 
> * Extend virtual irq csrs masks to be 64 bit wide
> * Move Guest irqs out of the core local irqs range
> * zvbb implies zvkb
> * virt: add address-cells in create_fdt_one_aplic()
> * virt: add aplic nodename helper
> * virt: rename aplic nodename to 'interrupt-controller'
> * virt: aplic DT: add 'qemu, aplic' to 'compatible'
> * virt: aplic DT: rename prop to 'riscv, delegation'
> * virt: change imsic nodename to 'interrupt-controller'
> * virt: imsics DT: add 'qemu, imsics' to 'compatible'
> * virt: imsics DT: add '#msi-cells'
> * QEMU support for KVM Guest Debug on RISC-V
> * Support RISC-V privilege 1.13 spec
> * Add support for RISC-V ACPI tests
> * Modularize common match conditions for trigger

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


