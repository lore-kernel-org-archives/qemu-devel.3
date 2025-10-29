Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A74CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE13s-0000HQ-Ah; Wed, 29 Oct 2025 03:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE13I-0000CN-Vy
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:57:11 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE13D-0002fv-RA
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:57:03 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b50206773adso141569066b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761724618; x=1762329418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4sPXd+f5zY8n2kHjAi5lKVQFwSLfKOiBokR5aqYplLs=;
 b=OUPt/yElRKSM8BbdGwQ91W3sWYRcIfWB/TcmecWmSvMKJo86vG2KlB4zSvDmrUYExe
 hfAObZJxjOEiP8f5p4PGqG5XtbmMskM/J6g9Kolsy8ENMnFN0E8Zo7SQ3dS+++HiIfKd
 9adptH3wMEZG2yncOd2K54Pprwbd7aZLg6GQD9i4gyhl+fxrYpoMhwuixgikEOACghMf
 0UKb/eopKccvtE4lu5nywLdytfNDfN+59+3p1wBME5g3MkAR9ABiLnPk210HSIttmBLh
 z2EBa7ya1Lr8spirtrn2Obe1+WvnrsgdTVzD3Jx2cPlcutYW/3xWuIbCHh4PHz7IBxAP
 UjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724618; x=1762329418;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4sPXd+f5zY8n2kHjAi5lKVQFwSLfKOiBokR5aqYplLs=;
 b=ahUDw9emFl/2ADDqQbchWCURavfpZVbD98ErV3M1idgQQhjmhaYMr2yqXBySBaIYzO
 HVbrYCNQZfJHV08evalyZSx8Qi7FZ4hm4Jxj3ibGWXEe6a6gJbuTpz6OifIfnp0bHdJc
 9XwoHZbKjF47uEMW1VO0KdP1qyqqjcKNm6wi3YNs1lcBN6piJp5x+32UATYD3s2hwLpu
 RkLye9kPgc9/WVA4oW/lwoSSzfgpOI7qU9P5KnfAPEpI5rmRLmx1erbr1XtO+zwRstN4
 LMYPtxBY6j/fjuSsl77zaQBuRj0ziLUs3jND3Z166DIxRJUP3TojmlKut9SnUItgPa7G
 4Y4Q==
X-Gm-Message-State: AOJu0Yw2stKE2ZBq8jhPjAhujG1yrWYhN+WItXIGFNvWNbR3cTc1+k0J
 Qn5VJVsaI1naAMHSg3OSL60paxYImP3qn48N4kXkBNT5vMrTvjcJn0tPJE9uLsuPRXf0207fQ/D
 yFgIEYWk=
X-Gm-Gg: ASbGnctf1E9r1d3SBDGArJA8xg4k/HCBtwCAx23v5UeO41FM6KmnZejAeYYA4Kg9MGi
 gooKoP2QwlRqUPEEdixTVRBgll/o18hB0z04v9sS0jrUD3ThH0IemspieXo2CWpHejWfXzArv5Z
 HaNRZPxD2A5Ley9k8ucYrK3hWnh0EfcVx/5aYl+MAU1i6bbxYQkxN0aPL9snxUZBJLVOe8vqpqe
 W65Sdgzef19y/v+gOdHUTxMSDV+nxva81sSnQx5CKiAgoc+jKjtAe+gDzfZF/mQt9NpeexwcLlz
 FKpWieuM7VmTlL9PaquEb53hRb+cffwTIH90XxqH9hPMAfMX/W9xUEsV/i+dkmz5viRm7NWz3Z+
 gM0ZUPFNT2tPw6HHvB+6aWYhDfwc+3t8XxP6r6S+iSUT9+nPYKvLNlz79mmLLYD/8Nn4RhCOH0J
 zKPJa67meeVAv4zXWG
X-Google-Smtp-Source: AGHT+IG19DmgAco5Fz36v9sE9T5jsH0ngNRR6hhDp5UcQ0Pe2KzD7RdW1ZXCPYjJweEz9MG6M7m8YA==
X-Received: by 2002:a17:907:3f99:b0:b6f:6a1b:755e with SMTP id
 a640c23a62f3a-b703c1f3353mr256693766b.31.1761724617758; 
 Wed, 29 Oct 2025 00:56:57 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d854395absm1348773566b.62.2025.10.29.00.56.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 00:56:57 -0700 (PDT)
Message-ID: <fa30ac47-5dc6-4665-ab34-e501038d80c1@linaro.org>
Date: Wed, 29 Oct 2025 08:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/25] hw/ppc/e500: Use proper SysBus accessors
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> SysBusDevice::mmio[] is private data of SysBusDevice, use
> sysbus_mmio_get_region() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ppc/e500.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

