Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA2FC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMSb0-00007k-Kx; Wed, 26 Jun 2024 09:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMSaz-000076-RB
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 09:21:57 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMSay-0000iI-9m
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 09:21:57 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so8003147e87.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719408114; x=1720012914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fdI7oA71sdJ6m6giX5xNvhJ8sHjl3mNUcqVd6fev7xI=;
 b=ejWAyebHmG7Yf8EB7HWkTl1vAK7oDO0ykr235LhTf9tOYKNPcsWMMDjqPDccS43+4h
 aYvlNd7LlEkVJW2MFcvam06YBYQTIXOjz0oIyXRfwkZ0K1QP8fXs0IGjkZD/Dc66dP95
 MQAUsmotqYQpy5ZAgFo6eum3RM5SUBtiipn0JmHktapos7xMYDiE+z7xgC6WXbGRVCeO
 W0oesjxis0YqsKvUgj5rpyLOg4Rj+7q2eUOL4CWdpBlza3Ns0QZedchNbkkGNak6Nj7k
 0GXGi19fU8FFBsswSQT5LunSP/YbQr14xqax3uChcyS6dsfImoQtYQGG8NwImdNh08uL
 PtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719408114; x=1720012914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdI7oA71sdJ6m6giX5xNvhJ8sHjl3mNUcqVd6fev7xI=;
 b=LEa7HMtorBzxiklOMbe5xLBJeRLe3tQ6Vpw+yYtSm9lEYU1DCOGkO/+fS2UDQpuUOc
 iyYX2VkZa/cT+cyAE2hztKmGeHUYUq+m35nPacXFcPt1mxF01ckbwIkhqKc0ZD3Ky/Uw
 XU8u9OjgKPu53Hb+6+Arhlv/W/mqH8iDTUE7lthsOczQGuHW2W0J4O8mnCdIPmi3LjRW
 tA/rzHNhYV2MIZGs6a8S+3fYLm9d4QG9JjdkT4csP9JRVTN+CbFHl6E/k43aecpN6Ytr
 Xc0PAUE6+ahNDPhDB537Vh2ViJBSlYb4o6BR3T+E7cbJ8AbxGMX+zJIWguakk22knO+X
 1DUA==
X-Gm-Message-State: AOJu0YyYKDE7JeOin/QgL+Wjh2YF1LmGcXCnvZg7UB+oNpOTBwpounw4
 2LUkc5vpRKLLtqX9Uyj4O666kRdNaIA0ApKat3b8XKSCcuo/zVYuwupedj7g9CU=
X-Google-Smtp-Source: AGHT+IG7G/SzOC2Lj6QFu/IYrv2VpXXyxLmZ96pSMcUg8PpawfivRFrpEgKFFdw5hQHlJ7yPIwsfuw==
X-Received: by 2002:a19:9115:0:b0:52c:a7c8:ec43 with SMTP id
 2adb3069b0e04-52ce05c23damr9146612e87.0.1719408114066; 
 Wed, 26 Jun 2024 06:21:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424bb91c9d3sm26572855e9.0.2024.06.26.06.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 06:21:53 -0700 (PDT)
Message-ID: <2757fe3c-b629-4190-8ad1-4fff364fb1a8@linaro.org>
Date: Wed, 26 Jun 2024 15:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: fix building on OpenBSD/powerpc
To: Brad Smith <brad@comstyle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZneCVxqGDjKpa5Jp@humpty.home.comstyle.com>
 <c8841c2f-3903-42ee-9bf5-2c74185dc007@linaro.org>
 <86abae67-79ba-487a-925a-de6a55f2b525@linaro.org>
 <a1491c86-3711-4cb4-a6f4-7f586daf5a72@comstyle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a1491c86-3711-4cb4-a6f4-7f586daf5a72@comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 26/6/24 06:38, Brad Smith wrote:
> On 2024-06-23 6:03 p.m., Richard Henderson wrote:
>> On 6/23/24 10:53, Richard Henderson wrote:
>>> On 6/22/24 19:03, Brad Smith wrote:
>>>> util: fix building on OpenBSD/powerpc
>>>>
>>>> Signed-off-by: Brad Smith<brad@comstyle.com>
>>>> ---
>>>>   util/cpuinfo-ppc.c | 20 ++++++++++++--------
>>>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> r~
>>
>> Queued to tcg-next.
> 
> 
> There was one minor change I wanted to make to this. Do I send a v2?

Preferably before Richard post his pull request...


