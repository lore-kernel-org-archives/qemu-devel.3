Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9C3CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 07:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLG6p-0007HS-PV; Fri, 08 May 2026 03:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLG6l-0007Gx-Qi
 for qemu-devel@nongnu.org; Fri, 08 May 2026 03:58:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLG6j-0004Mn-9c
 for qemu-devel@nongnu.org; Fri, 08 May 2026 03:58:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b150559bso12993165e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778227127; x=1778831927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cL85ZpwJPDNm/wyL6w34ALJiy8RLWq1D49yEYjKqMl8=;
 b=gGC8/BnW92OniPaUG68yjybBXxl/FWQHW9TkWTK58df7/4OK5BGCRCinDpc2UtZufy
 3Lx05gj61SY2dDXujqiwV97SrcBSoaFyGeFslD64cKHswHdBtlNuHnswmz8ETll/cxZQ
 1Gucc8CbL8I7xi5a71tpcMQHmE5tMXK74lN+k4BUEDdlp4dCFqfNujAgIU52/bL/sY1l
 WbzM3UW3wyB1oBb4KBMPA8QUkwWEuex+u54m5kM2cg4wE4zGLIZtrX+i2Oz/MMoCfc9t
 naXfL9p8lnZwFxbPGAPRyz6K+LvSzD9L2dDSQj5PDJyhgzvq/UW8RC+NQ7YB584hxp58
 MwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778227127; x=1778831927;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cL85ZpwJPDNm/wyL6w34ALJiy8RLWq1D49yEYjKqMl8=;
 b=PneIYWxp5nCZmPbhj6W/N3/IM9KSwN5MXeaJ6NvvWfKjPmEntPPTLQszKBlsbIyOf1
 MjQNN78gvsc0lfIyS5E0HrA+PWOZNnEAaFDw/w1V9Me3FLSugT9eNxYmH/Ho28HGVAJY
 6tIfJ24iGUH7NReYJC3DOU49DpPKLOydkNSqwLWfQCSt19+8dlyJD3td8IvkvmQi4IDU
 Lhdy1jrqHbhK7b2ijmE6a3lG6PHNwiMNliphu1aaEYQcQ3Hk1mUxlcTMRmrVSFy4iSLL
 ys5HEzeKRQHlYVWc0SSecjOI32eu5h3k+VvFfnKG7eUlYFrdDXHcMJy5lMlL5W9k81ub
 RJIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wxabj6XMhSCyE6sBdxLJ6cHmpTrKgYXuCEXGminw0XipSGdhtPHVnTBDds2obKlinBe0cSnHsCk+A@nongnu.org
X-Gm-Message-State: AOJu0Yy35TJxvOtXETlK27YUWRpmCTODrePTDSizj1VlNARxmstZlY6n
 UML8F4z0M46LIBB1B1DGfbL/amGBPLj6i+4UPNnRsvfD5H9+ad0kWAM/+uaAflr9KJk=
X-Gm-Gg: AeBDietEOPsKSbSayaoSvLRskjXW6qy5P8TPHPusFhe3AaXaIE2HtQUYwqNcz31xsJe
 TN/u+PunDx3cKgfEPyyGcLdcnmBingO0W9mrxspWgTkQo/5bxTUMXV25jc501iC7KMtbKh/Ry3F
 cU8svw6ONLBYrd5xws/Ki5/nu6LmdfRfgdOc5iDejBoP/Bg6oX0TRZsd7B1gvZYFQG7YDV61EnF
 S66QOYvGqt/5FnkZYW7KR7xVKnUdjTG+qJi4L2XB4qcSTD4PK9QH+wZqKX/MTIeTlpe5+Q8ZXZQ
 txPR2HTGBpavI61jc4NGfWppyA4EXAUob7+TjIKN6J60Gm4UGOc7LatAhmUS4S8T+PiUPDNGdc5
 tL9A/5dUz5XV6C9TcejXqLKh7VyDSp0nKfZ5Qap2D6PbLSouVtbv1TDAlL9BlPxaEmKAC1KuY/J
 1+mbvqfwFn7jw+r2JZeoWryhi7E40EGDGJcyJWjYeL90pzWDt6H4RRrJjXNQWeFRDd
X-Received: by 2002:a05:600d:6:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48e51f28ef2mr136820005e9.11.1778227127325; 
 Fri, 08 May 2026 00:58:47 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a68ebsm2339074f8f.1.2026.05.08.00.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 00:58:46 -0700 (PDT)
Message-ID: <c45c1333-7af7-441e-bf44-2ee280c0b60d@linaro.org>
Date: Fri, 8 May 2026 09:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tests/functional/test_hotplug_pci.py: Require TCG
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260507194728.2034696-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/5/26 21:47, Peter Maydell wrote:
> The hotplug test asks for the cortex-a57 CPU type, so it will
> fail on an AArch64 system using KVM where TCG is not compiled
> into QEMU and the default accelerator is KVM:
> 
>     Output: qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument
> 
> Restrict it to the TCG accelerator.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/test_hotplug_pci.py | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

