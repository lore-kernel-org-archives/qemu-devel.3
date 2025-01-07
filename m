Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA8BE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7Pd-0006nf-QE; Tue, 07 Jan 2025 06:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7Pc-0006n5-0l
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:06:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7Pa-0008IN-Eh
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:06:15 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso102466555e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 03:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736247973; x=1736852773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UEYemaaBKryt1ztq9F9+c3TQl2Hj6Atc3fbTmLfWMJY=;
 b=kjzlR2Q2NYbHsyAYfkWvEboF2jksYkLKzrtb35/bND+EIAPxSGL/9ZD+YpdbPuOwuc
 EFPUHJz02WTsZPav6PEowZBjjX7Q+cG0XLfYoGsPK7IL7LKS6K2R8Mg+MTt6KN95SL9W
 uqDtLdYUID8+YNYjMKOltfmFS7a7VSdBbauPUv1+OqWTwPe1T1XQkL6mLiJvYWn52Xkp
 itKlV3dyn8wfswgz4wOCEctkW0KieKDm6BOUfMShai4FczmKSRHgtLiCWa5C7Q6qGKs5
 MSYslZDRTTaCwF9jkKcJmwQkcKDNr53CiR3dvOnfpdtsVxpF+y6RiopVg8h4znp/AKkS
 +qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736247973; x=1736852773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEYemaaBKryt1ztq9F9+c3TQl2Hj6Atc3fbTmLfWMJY=;
 b=jt1w8YhrX6PUTe2mnZyOJFrDQd8Wiccp09ybp6sjNsDtACNVDfQl6Hg4azybeG7MT0
 +Y5CXJr59G0olpoM+H28UF6WGg8OpituXJgqMxHaTRyY+RQhr7j0MKLCW0Yu8T/CrBDO
 IZsAHPaZ2Ls18ywK3Ctt+BdP/NllCFg6hJrpT9XTFkhJZOEXv4dkWEYPuxly8sk6aGR3
 le1T4HfCaQwnGSyROVqkLVPyNf2HMmEOFoIXc9nIsCIRDfF0mm3+5plk3HYpdpPeTPVJ
 KiP/9vNYynqGEaMr/u6jSu6u2Q/bSse3T1lPbmLPkWPkguH+zgi3CVRCr965xTfQeQqd
 BKEA==
X-Gm-Message-State: AOJu0YyI4n3WSeeQyavI9jInLwYVMuQh/f8mi31X/GkmA+XobbfFHxJ+
 F6qP2lvyhzpyIWzjNSQD3mYOQ/35tt5sB1EmULCvTdPiB1Ub91D1kBje2nVbpyYGdYCRc/rOqFp
 ECiM=
X-Gm-Gg: ASbGncujp1umu8g25Sf5ijDrCSoR4HwpJaycx3RcZHr5reyy2fP7DDZkuKFHt741Fky
 XNkXTErSis4Vj29S4EcFkRet2varUAB561AWC4q3kpxkvGjJ3CvlgVuKyvA1LZjSvIqMiIru1kQ
 6s8naIfxKaXk0l08WauxcoJSnKw6p/JIXrNYSpzjWzYd/ReBj8ACz6qoc61Iy5uCBOEuSg1cZ5V
 gySE0XhSPybGIe7KxyIFQYnR8QbIEB58aQTcugwUiitZp52g2EESegBHMupbuYkFA9oY6zPHJTQ
 rnRHxgdVkHpAH2U6aXmGcUYk
X-Google-Smtp-Source: AGHT+IFiwgdSH3+htR6Xuj6jgX725ZydMrTVsOeWsNK9QtvtlEGrihhVhYQMe9yO0X1snlMS7/Ha6Q==
X-Received: by 2002:a05:600c:46c7:b0:434:a1d3:a331 with SMTP id
 5b1f17b1804b1-43668b5f36amr498158915e9.22.1736247972881; 
 Tue, 07 Jan 2025 03:06:12 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661200abesm591890615e9.18.2025.01.07.03.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 03:06:12 -0800 (PST)
Message-ID: <93dfbe7d-77b6-4abf-a364-f48fb7b2da6f@linaro.org>
Date: Tue, 7 Jan 2025 12:06:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] hw/s390x: Remove the "adapter_routes_max_batch"
 property from the flic
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250103144232.520383-1-thuth@redhat.com>
 <20250103144232.520383-11-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250103144232.520383-11-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 3/1/25 15:42, Thomas Huth wrote:
> Now that the s390-ccw-virtio-2.8 machine has been removed, we don't
> need the "adapter_routes_max_batch" property anymore and can remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/s390x/s390_flic.h | 2 --
>   hw/intc/s390_flic.c          | 9 ---------
>   hw/s390x/virtio-ccw.c        | 5 ++---
>   3 files changed, 2 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


