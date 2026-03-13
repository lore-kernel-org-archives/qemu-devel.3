Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A856A107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Y8-0002pE-Vb; Fri, 13 Mar 2026 12:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Xf-0002CY-GM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:19 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Xe-0001sW-5Y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:15 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35a04d6aeb0so1475336a91.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419952; x=1774024752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PtPkE4LGp4gZ0JZYX97SmUxoCyC7TVKfPqG4+ft3w4M=;
 b=VRHK/2Fq4gn/pA8jYACySN7FgSHL4yNg1B6ZHUVQK6TToRJEhb71v6RfbD67f+1THU
 S8pD8VmchYNt9HiK00UTT2fl+tLEsPc6tvIqqydBFMfnAjouePf8aTbfIWcfAwNGHTqW
 rDZyzSV4PjtbmgEiGvitRlBQ8e9r4BPcodeWIniPNSzLeeL5/FROgIfcnK+VDgdI3jpB
 jZ8OPK9N+EU8k8RPBRUbq+jVPuL5PiAHwnaGyQZmG0TgH94nZWSeglsRCaX1dLc8YVdq
 mI7gP9vqrIJMbKvnKdQ5n6IcIHrVQ1dZ4MQjCczK/9kq5pm1AD0bU9JGZAG714OVk0y7
 hnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419952; x=1774024752;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PtPkE4LGp4gZ0JZYX97SmUxoCyC7TVKfPqG4+ft3w4M=;
 b=HJijL0o8aGSaa2Za4MFTNh8FR3KRRR/CRNYOQrxpHcJ6u/ASxfRZu1WgZctjNLBOql
 RBLonvPFYz8rFvYc0p65zEfZteBUXIoYwIxT21HXNM8aGXByj9XRgD7UOzVM8DM1F3si
 M9t8nsrM9CsrRaRcb9QZnyqLhQOpEJ1qlEWtxkxt3svPlUUxZp4uMuVP0bVn8fLMW8pC
 Rul2wIM9U+XuET1G55aNxXNcmyNvv/Q97TJ4vYtRgSblERauZ/0sLDKnW8d1VckoOC7/
 LVg7NhpiMXRJab6kxb1TQuN7Rdw4LqLvDhHhJKmeRj1v7/6b/L8Q67K9SEPO+snngp5T
 r21A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWg8QBZ1d/M7V/S59PJyKMQyi3ls9h8V6xEw9DhLv+OlaoMC/cp69u9l9zFpW80OOMZy/ZrpTarOzu@nongnu.org
X-Gm-Message-State: AOJu0Yz3zg2BlWjNMfbqtwwkB22kmNyAvF8Xo2TWi5kv27zK7FAxZGq3
 yD1gxO29Pns5+1xhVhRo9E7syumIjFCsbgHeHapaS5KdhodVZ+rMesrs3Ul+p4dSi7A=
X-Gm-Gg: ATEYQzwOurSu4cqBx/QG5UP4WbK7/hPV9U4jQDHRmxJJgqO2G3By6pcDRmvNSTImivt
 rqs/qdVFIEVFXhegi997EYnxOhBhXkXUnPM3CVcF/r+ozfITf2Z1iQS1LTjfGgwYOmCjB6/wivy
 abe5AiqwoDjm4vPx879YxIrIWH+3n5ag+YBUI4lDaerVg3d5utZixiQzUMHllDMH+rATyXKc8iG
 hp4bhMapyrGqkvzWAYyC1ZVsV1XCw0SW2tCHe/jJy/XF2ts1LruDfvZHCNfWdHd5EF123u+GCN3
 iTtK+LLXGavbR+PhiAX0cjjxf3plaobdd5sqmNIf/s/mNQUIayKV1ywVN4j9dRc1tv7D2uIhsFi
 odAoDBF1sFtgft8CTksrer7u8VJkNZb3C2dOOYpuSTY1BdrbhOEwcujWiYRaVuxF1elY8H8xUJf
 JTeClWH6BAypcpzvEu3fQiB2VBMKOxj9M4zV3vNVI1TtgiFVVljpx+RI6G0YY28tjaAaAl
X-Received: by 2002:a17:90b:4c4d:b0:359:849a:7357 with SMTP id
 98e67ed59e1d1-35a22063fa2mr3599646a91.20.1773419952409; 
 Fri, 13 Mar 2026 09:39:12 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e9861csm9294691a91.8.2026.03.13.09.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:39:12 -0700 (PDT)
Message-ID: <b1daff6f-605d-4591-a7c6-f92a46172791@linaro.org>
Date: Fri, 13 Mar 2026 09:39:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/38] hw/avr: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-23-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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
>   hw/avr/boot.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

