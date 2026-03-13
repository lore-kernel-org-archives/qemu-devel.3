Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73E4107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Xw-0002Ka-EL; Fri, 13 Mar 2026 12:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Xa-0002Ad-Da
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:13 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15XY-0001s9-U2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:10 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so2373202a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419947; x=1774024747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CfL4RbPjs7BCAirjtivs2Hf7NGH/6S8Su6j1ilwnuTI=;
 b=qd8PdahXoht0VBI783pOZqhmqsrh+H5Ri3RAt1gtlnp8bOOo7Hilzcs6Yzl1Ep3/0n
 Fecjpe+frdbfHa7HET4XfzL+pO9e9XOqhW2NlkRhhNcIvVD/1NJsnAJEwbeZksQWE2Co
 mTdD1MmdJMncpITXewvZprXFMepjiiYsP5f70GkMTFFUlkkrmK+GIts2a7i8wVh6nOn+
 /2LmQm6qXB18mNeIGqKQ/ajT+uc7K0Xf1uHiIHKQEwSEOIwlb45AMRc7ISnZXTZ4VIUq
 o+U7uEr576HuCiE+4KkVcmB1nDxyLzKZQDY///01PESQ31JDFeBUHl8Y/y5t0TtY1sbc
 LLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419947; x=1774024747;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CfL4RbPjs7BCAirjtivs2Hf7NGH/6S8Su6j1ilwnuTI=;
 b=FGxJxkVpAYxBefqtKYRMqmbOlXkxhjWXrEgbDInwP3Jhj4+49WQMBbbyyIvGH6Dybv
 w+E/NmVj4H7v3bobLzkLOksCFedGNDw2G4s2ksfLUVYWha92ibdtNGEzE4z67qmoqFKE
 6dcph7Txgw0xR1S5XgI5ahCiNAchz+xLlvoDF8Zx5eMZVSBlePpYNwV30Zr1k3yNJCJN
 raQeHAojx4EPDdF0Q431qfQkHGR4ZE4sHsCL+mbkYLWDemP6/ARXjS+SsEmHZeshMn9o
 sLRWaEDr/mn8aVHOTillGGNNFcpm46nN1Ln9+L0BacthD879NolAu8SX9AP0wL1zv9v3
 RBaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDVuomXXLvWBtEmJvULVrIpy/BW9wC1+lFefB2IaQTHm6m7npbd0YagtbAxyBAJeuW125hZR/F7SL8@nongnu.org
X-Gm-Message-State: AOJu0YylwsHf0Vxa9jznx1DbJAsdRYMWQgWIzS8viM7juBg76xBWwcQz
 XFxllCer6DYLHZSOoXr0TTZ4hi6OymDHeKaI3a6OGw4OYeJPeVZMlxqlVDxgeRVOQsc=
X-Gm-Gg: ATEYQzy7vabss5/xj0jH8vEBPmywXNrtmIS3gjTfiBbTUCfE/zYS3aqg4VbNrxTw+xN
 FDLl2n1UKNZLBeoRFIH9UgPBr7qIxFhUeDBMYzadWnKToBNFBWMNO4zNWpoDHSXZI9Iw8xy6lOX
 3rSg/lJvWyWJHqrEMA/YKgksZGj4EaL9zKw/TlPF5fL4eBpIRsL8p6w2cwtPNRASmm8qWVYwS74
 gHaR2f0RlhvkHdR8mBJS8u54xg47kSoYrx9Gy1iufjvhoE6bkFOGKzBDGipuxvCHGALCqSqenI6
 ABmcuS+Gzoit/m0Of9qpEQYONtqUSOKu57vLCD06MNI1giv93O2YeA/69cbGGDkAtTjqKXtCtbc
 MKJfDUjVv+1Cxid5q/awtSQLsyTRz1p49R0NIURJy185qZ0vqDwfWawUMBI0XyVtMAjsqoxbDhO
 3sRYgDnrQbcMwpWFzU3hCD6yxAFW3x6kf4NgoV+vFFmmmFBmQkmiQIs0qPZvq/Aj9MsUAt
X-Received: by 2002:a17:90b:3b87:b0:359:9073:c368 with SMTP id
 98e67ed59e1d1-35a22081e73mr3629927a91.28.1773419947400; 
 Fri, 13 Mar 2026 09:39:07 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e9861csm9294691a91.8.2026.03.13.09.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:39:06 -0700 (PDT)
Message-ID: <a972b8f6-095b-4cc3-b7d3-dcb9285694df@linaro.org>
Date: Fri, 13 Mar 2026 09:39:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/38] hw/arm: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-22-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/digic.h           | 2 +-
>   include/hw/arm/fsl-imx6.h        | 2 +-
>   include/hw/arm/fsl-imx6ul.h      | 2 +-
>   include/hw/arm/fsl-imx7.h        | 2 +-
>   include/hw/arm/fsl-imx8mp.h      | 2 +-
>   hw/arm/boot.c                    | 2 +-
>   hw/arm/exynos4210.c              | 2 +-
>   hw/arm/mps3r.c                   | 2 +-
>   hw/arm/omap1.c                   | 2 +-
>   hw/arm/realview.c                | 2 +-
>   hw/arm/smmuv3.c                  | 2 +-
>   hw/intc/arm_gicv3_cpuif.c        | 2 +-
>   hw/intc/arm_gicv3_cpuif_common.c | 2 +-
>   13 files changed, 13 insertions(+), 13 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

