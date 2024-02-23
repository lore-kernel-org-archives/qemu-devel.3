Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B701AC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdcHS-0001Nj-8s; Fri, 23 Feb 2024 15:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbwl-0003GJ-Kg
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:15:03 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbwj-0005yt-HZ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:15:03 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso12469885ad.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 12:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708719300; x=1709324100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8uDi7gCXvxb+kzzxAh5BpmLIXt9IBNHlQ6pVHKq6Q+U=;
 b=OtxNRgTk/GtkmXr24nPC7SWvfP1eddo64yYY48jSH/eiwwr1a8O/ZIXABLuhUrPV4R
 oofXpSQIyEsByQWYu78RwLHzU1H/tPa3tLCD22Rc3x/u9S39/er8WlrsoYRmBHJ0V/Mq
 oXesgawqET0rd9uptPRwlyqZsT6SOPU+I6tZ4R6BskRmZR/HjyqmVfElH5B1AFp0daVI
 YfV99cHNXlbW2/eBSxfkd0VX0NYt4vTW2KLNQBoN0ApknEyolGE2dCy1G2WXjN10tl+0
 aY2yAsPiwbkkHt9mnl62/1mAmKIk3gZQHWJ+XjhBE2e9ymuXq69OMiHdKGKftKhk/Cit
 OQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708719300; x=1709324100;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8uDi7gCXvxb+kzzxAh5BpmLIXt9IBNHlQ6pVHKq6Q+U=;
 b=qM4Fek+qmU//HTebTcboDyB4SFFLSOItPsk/D6HvUUhij0ow6YY+OswlDvci8U8rEK
 6hst7hklhvEmR+vSducW2x7+RNUUUifxvHGz7TwZW5GbfVRJw21Br+9u/PpIbONRXPyO
 ltxkuEP5IczUXNpatwpQMtEYMyWoZT3qzZHAoVJ8jqUmC9U0I/C0PAqkg7Cb9sMpYscc
 6dU/LR9evJcomgV6Q7bgh0YX94+WNnRXb5Egep/f6RvyGoHcldP06Zo0EenbqDlSs3zM
 YA/XrMLUYNRVHG2DkIg2pdPX+R/BEWPyxJT7BMOzx6ep8af9w947D7ni0REQuJT7Xkua
 CX6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVBzMdmwoVLoYHTM0VyC++1pZJxfPUfqINOD9GEj/w0rgvO3FfiPnj9ZMzsLGEn57Bs2QTBZl3hnNZWBxuJNaZ+hG6s+4=
X-Gm-Message-State: AOJu0YxXN8H0tbsuIG9/FsoOTTqrAuzBCIIQ5Akwkh9POj1/sZ99upS4
 D/YnvlzJjTyQmAsThtXA4vbHJnI0KtuoKu9N+s3Z4iV5hWgUUtrx8x/6gO/lXEe9xOQrb0D6X1w
 c
X-Google-Smtp-Source: AGHT+IFVPuVonaTebBGJ+P5Go1YcOHQTjBxXR7SDvJZPrce+401Fyo+zWYk0nl22uCWw8EYK87yMPQ==
X-Received: by 2002:a17:902:da8c:b0:1d7:5943:21b8 with SMTP id
 j12-20020a170902da8c00b001d7594321b8mr1041613plx.16.1708719299837; 
 Fri, 23 Feb 2024 12:14:59 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 z28-20020a637e1c000000b005dccf9e3b74sm12361418pgc.92.2024.02.23.12.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 12:14:59 -0800 (PST)
Message-ID: <eee38cfe-5d3d-4015-ae30-744dd21e8935@linaro.org>
Date: Fri, 23 Feb 2024 10:14:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 16/21] hw/intc: Enable FEAT_GICv3_NMI Feature
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-17-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-17-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> Added properties to enable FEAT_GICv3_NMI feature, setup distributor
> and redistributor registers to indicate NMI support.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
>   hw/intc/arm_gicv3_common.c         | 1 +
>   hw/intc/arm_gicv3_dist.c           | 2 ++
>   hw/intc/gicv3_internal.h           | 1 +
>   include/hw/intc/arm_gicv3_common.h | 1 +
>   4 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

