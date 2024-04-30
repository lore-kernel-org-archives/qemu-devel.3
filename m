Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07029C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 21:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ujb-0000A8-FA; Tue, 30 Apr 2024 17:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ujZ-00009t-Kd
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:09:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ujY-0004sW-38
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:09:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34d9c9f2cf0so761445f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714511390; x=1715116190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jguxh0Ekn0HtIV7fJ+h+3AzTKJigWr76TPmo2hxPDzk=;
 b=Lxnq5RzmaZzDZniSWv9fnaI36O8D4gcW7Lo1agEgNqdND6O8L5AYJwDLhqZcIvH/V8
 TtjxTrts6hFtYn/eX009HV6pLFvVRaLB1u6E4YKIR8BxYpewEA+lV4EvQ7ydLBCYhdT1
 hqFzuK2zEvEIPD8uPXcjq8HlS8/ntzcnd/1y47fFDLSqGyo8/ujI7IVZnXmG5NfgbqbZ
 6Jdi6jFey1YuCTWSEwkODZ/Jvm9KR1JrWlf0h2WQQOU3xBH6wkokhzZ8hYDdVpmmyuaw
 UryKLqoKD6JMbuWQ1NO6ayqZ0OC3VpeyIji4hyO+SDhb1TWHHIt8jqZavbo+LWS9g2Q9
 hM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714511390; x=1715116190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jguxh0Ekn0HtIV7fJ+h+3AzTKJigWr76TPmo2hxPDzk=;
 b=p7AeFkrqQbsUorjIX2S2S7rmIxNxkH5YP87G0Pp+cdn7pGzGOxfh5behLg+ztt7eeP
 urXj5cIAiiXTrV8H8lYde953ryLt4QVnkO7xoejM3xu3ZjbxSPuBxYn43q4skpevr2zw
 Q6hq2uP1mG2M79bpUWRFfAvCsHjuHIG3ZAsNYbTawk+aWKgeL8hvDEIybL7fodX0IFby
 e5GemkjMjp9nuqvlnc+ye5po+pUyeCb9iyYyi7+bH7QOxoZDpdCcniI6t/PNrt+nA+Vm
 KCV34vXfzNuOtf9Os1ZG+a40QcXld28gIrX7wV32ss09u+7W2O2PtFP02/NhZtkFLLCf
 bRHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzguUpuIVMKFda1zzDCMrUJtjYhBW+H6KUKnYbSIEHH2Q2+qfa5cRzSKIdNaPdq67H+ly7vRj/2UcFMcC0Egr4inm8SLU=
X-Gm-Message-State: AOJu0Yx4SokLchSfaPdGXwO4NOm6qyCTVFj+DpYk8KpOVZA3gj+MJxMv
 KvZ6fiw9zZq+usUEhIDlHSl1CE+KEMQweH/AkfTcLx3ND0Qkw4rsC8m/C1au//A=
X-Google-Smtp-Source: AGHT+IGNgrTkG4VRB4r7Hdp8F/eYqNWzbYoWvrknbSkkPKTG+bbpLMJ0VwsLCDU+c2X+rBoeYSEvjQ==
X-Received: by 2002:a5d:595e:0:b0:347:2b42:a397 with SMTP id
 e30-20020a5d595e000000b003472b42a397mr676912wri.4.1714511390026; 
 Tue, 30 Apr 2024 14:09:50 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 wr5-20020a170907700500b00a58f4be4279sm3766070ejb.74.2024.04.30.14.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 14:09:49 -0700 (PDT)
Message-ID: <e48cafa3-8d54-42fd-b7f7-6ec861d1f2e1@linaro.org>
Date: Tue, 30 Apr 2024 23:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240430194253.904768-1-richard.henderson@linaro.org>
 <20240430194253.904768-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430194253.904768-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 30/4/24 21:42, Richard Henderson wrote:
> Because the three alternatives are monotonic, we don't need
> to keep a couple of bitmasks, just identify the strongest
> alternative at startup.
> 
> Generalize test_buffer_is_zero_next_accel and init_accel
> by always defining an accel_table array.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/bufferiszero.c | 81 ++++++++++++++++++++-------------------------
>   1 file changed, 35 insertions(+), 46 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


