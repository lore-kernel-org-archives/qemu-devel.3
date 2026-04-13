Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10D4F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQEE-0003ti-4O; Mon, 13 Apr 2026 18:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQED-0003tR-Au
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:58:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQEB-0003YK-RD
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:58:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so35210395e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776121078; x=1776725878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gxRgWQ43m29rANNrEq4yJIwSgTd1uHnE3QuvOp4Gjc4=;
 b=Owz4j+aWo0edQvYQZmBQSS2ZatPEz8mznE2V+txWjcV02N1FGCnRpywh5wWDJO73rr
 JbD3cK5a+BjT6uYweGiUv/tswG/HKJoOcmFivEmDSXJ0Bc0IjgVJ6y8gemmIV0BMsUUX
 O2dLDdtjjrENYh0chnOb3L2RsII3yl9DsCHVBJvczVKGeXXHI/DACuhYzN1yU4fD1Pci
 sKesrVgOIRXGlmJK3dUjG9phYalgHL2aBWZnjD4H+vjAPEmt0t9l9CYYymNFOhQGQsho
 3FwxIHAXU/9QJNIWsm1BAxkfNyW6/j0Fh8UjHRJiUjW0EMFBeX/Xh5XJW/3G0mFmK2J7
 O8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121078; x=1776725878;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxRgWQ43m29rANNrEq4yJIwSgTd1uHnE3QuvOp4Gjc4=;
 b=YDdccR8cWGqhbczQcjEt2Rm8ZBbZSH1+IPxQWlg1rhHzmyu/fn5djHVXYwGYxlkyGA
 Ob+IemOfqU+fpMSpIboNJwwPvgfTfeaot6mZpRxOSGd+Jyfn+Ag0nahDXSb8eXsCGcSf
 qmwb4uovs6phFnJq6IowfElGlw7Z3OPYmGgF7et7XMTalcWKUKjqYm/15yk06w0G2qv2
 3HyEHYOZZwO5FzdDn8rnNsI5/64HHErhzv5VTCH2aAiGzIhpCDTC9WTinP+hAe92FIgw
 nBuQrvKdbwGKjew8rDZpo3esLTNGDJ4kWq6C6J83nMFzc6T16KZ4HC2p3tb6av+fmXpK
 StkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FtrJnpX9t/qdmojdmCWA/3HbMgbAc+H1SrhOII0/fMSVtx8JS7z4ET2pWm5VdI+snzOqk5A8fBoyu@nongnu.org
X-Gm-Message-State: AOJu0YwT7YTPWnyVJpDIBMYsh5Ef/lJ4zqC1H63kh1B/1U7UD/Q1Movf
 gNbhn6u06/4M0rm6W6VV03haO57AiadFD+ridf5b8+xe9qaqfMRirVb6g4BH+egd9fERUHvxoHX
 n6+LaRSk=
X-Gm-Gg: AeBDiesI6PH59ToJPtpLiDEFy5qnAazQ611xryRP88ffFDiSWMZTOtoGXzEJZeUriBh
 EMBsmTU8hs40uBdNJBIXVUuTOTK1I2geRPCpKbeD2tqe8LIH/W0Tl4wa5uFXpPWCxe3iqhFVTPP
 BQJ25clUHBpyRrOnb9hGHv39MCG3OcR1kUb6ymUSdzj7uX2FHVNVWZun/CJHwMThbfuVAUk2O8u
 kVyBqQf4Ec2S6LOp9WO/SLCzzDof87IWFmxDq6vTcBu8THXyFPLiMulCZ8+WdHfFBR1uIK5bqSA
 X0qoRucCp2Nieoyvd7n20V3maRV/OteiN4m/LjLJxqYWp6iZopp6kVu6VjyYxUQQj82c5/E9Hd/
 RurnyOD7cnnEYMfoDTy/tc6bseklQZxC4jGCCVd5Wk+bv+RbWStxdp2ChmtVKW4GNP0CucjJxFy
 GBaxzlZ/q53/rRk5qSwuhjpLLuZ4Wx/bjkhzQ6WUHmpOVKL4QyIvLHPNsIHyG28LRU8g==
X-Received: by 2002:a05:600c:3107:b0:488:8b52:f7de with SMTP id
 5b1f17b1804b1-488d6860930mr183623885e9.12.1776121078130; 
 Mon, 13 Apr 2026 15:57:58 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ecde5b26sm19675265e9.2.2026.04.13.15.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:57:57 -0700 (PDT)
Message-ID: <f5907e4e-c1e8-49a2-bf7d-f81a8ca64374@linaro.org>
Date: Tue, 14 Apr 2026 00:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 61/65] hw/arm/virt: Advertise GICv5 in the DTB
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-62-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-62-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 12:16, Peter Maydell wrote:
> Advertise the GICv5 in the DTB. This binding is final as it is in
> the upstream Linux kernel as:
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/arm/virt.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

