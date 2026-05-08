Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4450CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLSBi-00061d-Dc; Fri, 08 May 2026 16:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSBa-0005sa-SW
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:52:40 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSBZ-0004xP-7d
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:52:38 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso2078469a34.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778273556; x=1778878356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5i7hNvt3Te0LjpwCUcf5mRdGdAbsnrqbSgkEO5vAfDw=;
 b=aruWgUMIHLFreVuP1VfJrkgj41Ca924hsYnDwbSCsP25UCrPHIt66rZdf7LsVmGFXC
 eZ/yBibYcMqsyk4ElGJYUAwfkY5P5pmnbRmJqgo7fkT8h5tfPLE/UZ6sB7X+4Y2msrFf
 gwTub7as5G4YX4R0M/ZA2YPOCCZnWXGltkxw25TUPeSWh3cr4+HjFlrd3fFNfA7U+Xxb
 wZAVErzrMGIW4UnD7KjcEkrhzDiKBaEaIGB/x36twx5NgCTkrFHuPLtYI1Z9nUldxIEM
 n6oiWBgyuuk8i6uwhDTFKEYyhYOHEFcIMFvEykKzx7y8EIOqzEViniF7tva3RKOV20E/
 p6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778273556; x=1778878356;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5i7hNvt3Te0LjpwCUcf5mRdGdAbsnrqbSgkEO5vAfDw=;
 b=BCNI0sJ3w6DU0280fUUoHRh9a0bROzJMWYvH8GkXvasZqKu9RkodH20gLK2IilnJZ/
 pbDNEIXmFwz/SFB//ySMvectABee+HXIo8CLyWjBTDViqAynaZv2mxrmW8khxpuKdGNv
 ujboSP/2hj/wTYutAHv1455RHt9lzNGSevZWq3J87/iRwiHPH7x6UU0qpwKuvIWrpNeI
 mW/YXYnExhSvwNkT2ixaQE+do5uob015lRAnxMr5axDgCjsinDMRICjazRaNfvxkMwsg
 ojKAp5XkcB71i5laEOyMwnIJkQ7ucm1X6zPS0S/qJm5Y5usCMLDWNeJbzd8eVtuSGoji
 SqfA==
X-Gm-Message-State: AOJu0YxXh7l7upEwmrTyhZpQ0+fZnzLT5BBZbptO8ttI8z2yt+o7QAd4
 QQFSw0sCM49Vox+1B6GT6St1RTISXwTGZ2jh28WOvvXCEp4FhI+fanT0cjXOT+ue5ey1/2Ck3Aq
 aIQad
X-Gm-Gg: AeBDiet/vtMC5NCB2JmrIVGRLhjW9+QdLUHGCFyOk3uWBDVFNA1Lx6Z+K30uPceR0OI
 I3N5spZwwkwYcNXVj/Nwo79R6S6hQ6htrJ2FFCv0RH6lUjEDkcUNrJXy/qjIdBZML5y0X7G4j/r
 0xC7fC0hVDeLs/rmaXwNyT4w8jMbMPYWpRWe/Zv3IGKtgapBCusDwkKH22xtfWt4GTDi3/MNMGL
 qyHpKl65/fW0AXAT1VglHXLn5dAXw1ieii5Ci+lpxskDj35opWo23WDv0YF4TlvDJr5nWkmZegm
 orskzhlAeZjufWgRuM7BRgg1ddlat90jLmBp+f1iKHJ56+3K9vpATgryXxjfQUETGi17McD/HWV
 AxM75DDCfHquBQR5/e4STSEWVF3YyGWnggI/eSMStg7CT/pL3RmGqeON6ItRyw/YgfSN/OsJv5k
 KcX1Za7PLRtj1xO8TuHP5nozzKkYmFEtd6+ConApjlAISB3Dcm5kcVtnxKjl7GasrklOgB6eJ0n
 iqRFgM=
X-Received: by 2002:a05:6830:3110:b0:7dc:c7aa:22bd with SMTP id
 46e09a7af769-7e1deec720emr9308822a34.6.1778273555709; 
 Fri, 08 May 2026 13:52:35 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8fd96sm1812820a34.19.2026.05.08.13.52.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:52:35 -0700 (PDT)
Message-ID: <7e406e82-34cb-4d1e-bfb5-92fca01a885f@linaro.org>
Date: Fri, 8 May 2026 15:52:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tests/functional/test_hotplug_pci.py: Require TCG
To: qemu-devel@nongnu.org
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260507194728.2034696-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 5/7/26 14:47, Peter Maydell wrote:
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
> 
> diff --git a/tests/functional/aarch64/test_hotplug_pci.py b/tests/functional/aarch64/test_hotplug_pci.py
> index bf67720431..9ee1446a83 100755
> --- a/tests/functional/aarch64/test_hotplug_pci.py
> +++ b/tests/functional/aarch64/test_hotplug_pci.py
> @@ -27,6 +27,7 @@ class HotplugPCI(LinuxKernelTest):
>       def test_hotplug_pci(self):
>   
>           self.set_machine('virt')
> +        self.require_accelerator('tcg')
>   
>           self.vm.add_args('-m', '512M',
>                            '-cpu', 'cortex-a57',

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

