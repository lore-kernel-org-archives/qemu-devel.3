Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C666CC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1BI-0000wl-OW; Tue, 11 Mar 2025 11:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts1BH-0000wQ-13
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:06:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts1BC-0001YG-5t
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:06:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39140bd6317so2141588f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741705560; x=1742310360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V4xeRGjEFsgqkoiQZNkXJzWrqF+c0kZU5Qa9D4av9Nk=;
 b=DeVHpiCZ9jBR/oLNYK4ydWxKi1GGnFi+GjivW/43j9Oo6E+jmbyCRE0eDupUnwMvP5
 eBI98cExR2rrerwMT3kpIXmcTUNuDMz92Tok+TaPgxAFq0/Wcfnjl184gMEsSN/tKpeP
 N4athfPdYBCjLUMdA+bRGosuJw15KFfiQZ/Ztan+FW/C0myx/ykQia9VJffwtmiS3BTh
 Z/TE/Htf+F+7BVek0f+Kb8dIFnjjTZY79slb2LwKGQHRhnXlFtws7brLzc+28+jt7vrP
 LfMXjOfZL2uHDfljFGIWNcKtqhz+iAmWYp3DIZw5ZHxh3Yp4BzAOdOIaf29yoeZ5Mqgr
 A/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741705560; x=1742310360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V4xeRGjEFsgqkoiQZNkXJzWrqF+c0kZU5Qa9D4av9Nk=;
 b=QqlAj1ggmI5SH9qbZZtMxAHs9fBIVGQ+sappJ8207h0HxdcSGsf9itqzsx2VJEQ/z4
 4cyh7VFMjaSxfEzMSzdEqgsRuuLTAH5OUEXnBTr07CcBLb9FsjMID2/2AOCvsTSQOq5w
 NrJPTIPiIBP4WlZ7Vc8jrnwfuI1A1gaS+7M3DyNFz67atykZKq2FVRk/mQtkUDg1c09I
 r0wFWpOKZmfzNr+ZJuZNHlYsDMfgOmXv1sjbaThSIIdOFEu2XXwSj+FUd3vyHJKpiE8k
 JMk/RCOFpOHd8k3JhYix5S1ZZ1ieczEl5eoG4dh029pqIMBd0oXkAm7odTBSjBNLF+Cq
 qzvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/tDtpJg80o4J7SDHJOejxUd35xb5bzuiukHcUDLq/7SAZ0yz22gBPYQq4O+zi1m/8xRQOHgcykU6O@nongnu.org
X-Gm-Message-State: AOJu0YwWVG3rKRTsqaKDkzsmt+Bv1imcHMVnKFcAa7W9c6N5NgTBX/9G
 Ab6uqP9xpALPGeErratvJS7Wm19euXfStrxfayU4xmmLwGvZ5PxnGymMjnK1sNI3Ts3gNGfynjw
 2zug=
X-Gm-Gg: ASbGncsqwvhELilXz1Xsy8IlIU226iIFhH8HjpKE9NBdYwvMNIdrqP+HaOVsIViUNT+
 jjUV6h7/IYr3q6h/Uz0K1Bvdci09GDTQNomXlikY8tgGVIAxhxjtcEcW83sIkDisLIFZYXNGOXm
 MJjld9tWu2Ph5SHx4T69hqm8+sTwKTAS9kxfKTuNqFW5al+E9MN9QhQHw/j8DvcjdN3mPtKsU0Q
 vy1UrVAygOLBU0u20DQ8HjoN2Ih3YWqe+9RDwTiyP0ka1OF1IZo5LX/oK4J+f3EBZq+5jXRnHtm
 3J7dvq9y2DF7qxSS+aJiO1V+4LiyO53vc/jVDUrfz9f3X/jMFSk0URRtGbrr1YsD5H62Gi58COm
 AMdNKsuqc13+2
X-Google-Smtp-Source: AGHT+IHNa12kI+fH6zt93B5q2a+mSQlQFSOW0J7tJkApAruJh0mlb9pffNZtz++Hv9gwk+saVPYaZA==
X-Received: by 2002:a5d:64ce:0:b0:391:3bba:7f18 with SMTP id
 ffacd0b85a97d-3913bba8128mr7841333f8f.12.1741705560054; 
 Tue, 11 Mar 2025 08:06:00 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfddcsm18698919f8f.35.2025.03.11.08.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:05:59 -0700 (PDT)
Message-ID: <f957fbdb-c7c3-4a31-a76a-144ff31ea158@linaro.org>
Date: Tue, 11 Mar 2025 16:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] hw/hyperv/hyperv.h: header cleanup
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
 <20250307215623.524987-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307215623.524987-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 7/3/25 22:56, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/hyperv/hyperv.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
> index d717b4e13d4..63a8b65278f 100644
> --- a/include/hw/hyperv/hyperv.h
> +++ b/include/hw/hyperv/hyperv.h
> @@ -10,7 +10,8 @@
>   #ifndef HW_HYPERV_HYPERV_H
>   #define HW_HYPERV_HYPERV_H
>   
> -#include "cpu-qom.h"
> +#include "exec/hwaddr.h"
> +#include "hw/core/cpu.h"

I don't see where "hw/core/cpu.h" is used.

>   #include "hw/hyperv/hyperv-proto.h"
>   
>   typedef struct HvSintRoute HvSintRoute;


