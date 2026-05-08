Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BD3CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLS22-0002NT-Vv; Fri, 08 May 2026 16:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLS20-0002Li-Kf
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:42:44 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLS1z-00028X-9h
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:42:44 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479e4835e26so1432225b6e.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778272962; x=1778877762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZY08kjeEB1QHlu1/qz+t9b5kSi5aT/9Gh1rhRn4u3IU=;
 b=gg7Sdbs9RzeJd4TjOiJhfgPKMAJXLMJSay9Jmn97gvD8yvAFobHykVmVG9rnUkBKGG
 ehrxg8ndAQaaZKUHS+xw2QPyu7UisaPcOeIGkJ/xf2OYW65YKEYa3vBSs3CQMxnYGR9H
 +ztYqTRVwaB/6p8lDOAP5/BSkW6x8jdkISmJGY4msjRSc3mbFJQlfCjWmDV/3WP7rH8j
 3GGtFNHBWbBzKBElOrBwtMxxlhDyEiDOaCg4GqeVLgaJPTWzmr8egIxvZk1J8nqbv47H
 R7iwU77gVRR+tK4v3DJPE62ax+zeEk/uZB5umZje1T5xcpyaFJkD+wUHCtvZdGZkclA1
 fGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272962; x=1778877762;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZY08kjeEB1QHlu1/qz+t9b5kSi5aT/9Gh1rhRn4u3IU=;
 b=iGpjDRoVsWgwX+Vw0TbaKi3fjUpOQ656doN3jAyRb6xNF66sDwzAT59w/9bI22uCb0
 EbhBqx9k9p4XmEIPJYQIQVuST+FbONhUlYsIbflO6AOyUdC+qBpe+un+XC3+TLnYnXCE
 kOE1plR6BcCL2hGfyNr9W+KPi4vkOqXw7SIySFvaQmegjX5vvhFa3cLOLfvZMC1ckU/i
 sb4GZ4eqkqxc3tkDARwDT2HNKFfWpcyHr5t1S1sbhv7ZJeoW5XjC85wfh3Jjf25WBhua
 oUR1ggT2pqtQWGerT2go8cxCIyxCx7OdhfNlCIMEBiqSe25Uvn8ejZz9L+tPua8HLwoT
 MtMg==
X-Gm-Message-State: AOJu0Ywcl6H7EqPq68IbQAzDfRlMI1o5gxUQpfqywduUJ+aOwtQ/dWkO
 ijtQvAsHMd9Fv2HtrJxgHZlbjkrqI09jc3VRQFNofU/4q09CDDUvwGVUuggjLWFjZkP83/navlZ
 9OveC
X-Gm-Gg: AeBDietL1/ZxDurMC1/6XAAtz4Hu1d+ujONfyKcOx501kA8zeA8DUePOVp5BfQFUPAR
 /3hDdJOy7eWXv1ei2Pli09iR2hD9W5MHuej5SC54eKjiyBbH8JD5kQK+RAA+4oUrUsefUxmKoTW
 8axGkwETmjy/7D/7HStWy4cRFiEQLOEuRmWnq10yA4L2j1v+wpcF7p4NHZP5P8X7bRGaUG5+gLb
 I3FbrMQrcwyAXGDCotFkbQrlNgaFSI9VPFrNVAAfNAYQeBWK+Jwqcl4v2CrouZFyvUlxVb1UBTP
 D9ldrwyur9hH79EeJOrf6tE1yQq9u0O+xLhJzTbIFJ4744rruhevvrn7/uDoL2CbD2ctXLRTPuQ
 oxzXh269ScaRknbJdE9EGzXG7jOcFS8xV8PGfHE3eEBCGkDI7uBa3UF+FL24ZDPeHmr+yvbYZLz
 1iPK+RPGqYdM0XCBkuWsD+fWwg5Zu+0F1wrxKROKCQ8rAgPKd5+XI4NgrFDhqW8Rpex1HqUKrIe
 h08XnrahfEDKdr+hR3TQ4zF3KAL
X-Received: by 2002:a05:6808:222a:b0:45e:f443:dc3d with SMTP id
 5614622812f47-4804221c48bmr7472832b6e.13.1778272961796; 
 Fri, 08 May 2026 13:42:41 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76400690sm15555018b6e.7.2026.05.08.13.42.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:42:41 -0700 (PDT)
Message-ID: <d2a8c024-38d3-42f4-acd1-2db2ad99a758@linaro.org>
Date: Fri, 8 May 2026 15:42:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/display/exynos4210_fimd: Assume display surface is
 32bpp
To: qemu-devel@nongnu.org
References: <20260508162013.2751001-1-peter.maydell@linaro.org>
 <20260508162013.2751001-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508162013.2751001-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 5/8/26 11:20, Peter Maydell wrote:
> For a long time QEMU has guaranteed that the console surface is 32bpp
> and not anything else.  This old display device still has code
> assuming it might be something else.  Remove the code that made
> put_pixel_toqemu a function pointer indirection, and use
> put_to_qemufb_pixel32() directly.
> 
> This removes the last hw_error() in this file.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/display/exynos4210_fimd.c | 62 ++----------------------------------
>   1 file changed, 2 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

