Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82704CD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 18:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpue4-000536-Lz; Thu, 28 Mar 2024 14:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpue2-00052c-QG
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 14:38:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpue1-0000Qq-DR
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 14:38:34 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6f69e850bso1507701b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711651112; x=1712255912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8k8ShgZpDq6NET7E/sFDOpXqTEBsCxuTZlNM10OEm+g=;
 b=ZMN5YWbBYo0MOFS9NETgtDrOlN+WZy4s9ypKOgtGWfV9CqoGP3rK0NoFh4tu4sLwuF
 dwXKTahWYrFe66uTTRcL4ThLmOA8O0UjAEVvQGnJABIhPXtQZgRT2HpYFZYZ/eqzweXS
 bRAOEt/jOrLWozaECFoYRUFGo5EEfSELGFbQYEHVxbmpYRW/BOtAd9seUUN4XWA/lqXP
 QtRJTxAokp+Zo2+wDXtDsxfQxJoGvOYPAGh+AeyyrbNR78jtRyQ4xyAtg3W1mqV4hCi7
 pXhOZ7+/GZ/XFqcjtkTdcprCtfVCAInVtfKs5e1Wteuq8FbMQGrhA9jSgup610oIZBEz
 oo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711651112; x=1712255912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8k8ShgZpDq6NET7E/sFDOpXqTEBsCxuTZlNM10OEm+g=;
 b=esjbtmJxlobkkwi8JhcKm88renZ/wZl3Oh5LOOCvRLri0zXEUG1uGgFh+nvimrlxEl
 nWiswkRDi9+nuIXrstUKUnHhCUJNbSaqZIqnJutdhxWWrbJw4h5xF3fwBdPez628KYdw
 eUlEnZGuZrwmVbq6bAh3++JUDCPbCb7rWsQfgOST8ehGO2SQ/hKZduiD9s6yMqYPeBXc
 gE6ih4vWMtwyIvL88P3zVxWqumQ5atk1q3vrofdWeFuS6t2wfF459EIWQBGt3AnDZZLa
 Pb9matHp9dGMMlVTCU6ubzosjV6oSBJMuskr1eHqycFyOlxwl6e1wonpyd9yErKQaeae
 BZZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5sIxpGwE2z8cbCL2tO4SStuomMM+p8uVc436vRGzoz/c65Jq67NidPTh0lZNrxQX86G8r4IZ4szMZVYrLn2/YIOobG4o=
X-Gm-Message-State: AOJu0YwORVFFFtUKV8A5qrWi4Fl9zVOsLASrtUDXa75WzR5Y/Qpb8dJo
 QCsM9R1e/ZupFxI3kiJ8ufG3VwlmVKzNQrrARgdtIyxgatfLgn+95Ix+E058PIs=
X-Google-Smtp-Source: AGHT+IEyNFk1U7IBFhjb/w6h7CXqQ32MFAvPLY/YcYH4rWFzLANa8v2AUvZYuQfKGn9/chXHNyf54g==
X-Received: by 2002:a05:6a20:b387:b0:1a3:6a74:2e6b with SMTP id
 eg7-20020a056a20b38700b001a36a742e6bmr3219271pzb.55.1711651111966; 
 Thu, 28 Mar 2024 11:38:31 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 fj14-20020a056a003a0e00b006e554afa254sm1698720pfb.38.2024.03.28.11.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 11:38:31 -0700 (PDT)
Message-ID: <364a15eb-ca23-4cd1-aff7-37de8bd7e825@linaro.org>
Date: Thu, 28 Mar 2024 08:38:27 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int
 group is disabled
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240328153333.2522667-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240328153333.2522667-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 3/28/24 05:33, Peter Maydell wrote:
> If the group of the highest priority pending interrupt is disabled
> via ICC_IGRPEN*, the ICC_HPPIR* registers should return
> INTID_SPURIOUS, not the interrupt ID.  (See the GIC architecture
> specification pseudocode functions ICC_HPPIR1_EL1[] and
> HighestPriorityPendingInterrupt().)
> 
> Make HPPIR reads honour the group disable, the way we already do
> when determining whether to preempt in icc_hppi_can_preempt().
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Pre-existing bug which I happened to notice while working
> on review of the FEAT_NMI patches. I don't suppose real world
> code disables interrupt groups which it's actually using, which
> is why nobody's noticed it. Still, it's a safe bugfix so might
> as well go to stable too.
> ---
>   hw/intc/arm_gicv3_cpuif.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

