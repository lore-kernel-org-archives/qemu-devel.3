Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B57D4661E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 19:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgTSy-0007Qw-GS; Thu, 15 Jan 2026 14:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTSw-0007Px-Ax
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:57:10 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTSt-000215-Ne
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:57:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so13090765e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 11:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768507026; x=1769111826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CDxOeLsQUuAwAJ99EWFZG2ThaQnSS1JvO0kW03wqPq8=;
 b=AHsfLohBTAZdR03V5k7GiLcc9BXadX96XcXZrMNhy0Sa2G9Vjz66shlzzT6y2XDu53
 GtgYH6a15LlTb4kwgGlJnpE1+WYlU27EV5hrXloeBGSf9LKozZIf+XsyCsDpcnVIk2g/
 dxTK8WeogYyvLAg0e2Fil4zqSEhOapU2tBWhnhLXuaHEcUDjz3obgQDKUG90jSb+lrII
 T6BCuaW7gMkNZJqIFOp2SIovYDHga/f1qbLRn01jsrpuuOm4KX+k3JP1SRpe7POKkOyo
 Of/+29evedMkXz3P8zBXfXMNwhzEnWhZefXkk2DjtFv96HUiJxEiDj0IuwYGZ8WTisZD
 coEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768507026; x=1769111826;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CDxOeLsQUuAwAJ99EWFZG2ThaQnSS1JvO0kW03wqPq8=;
 b=gh093YNwgcIQGkkC1qSZtoOykkquQWlDsw2/zmLWeyy0WJZakhA3BSu5sP4jftULtk
 7WucEvPWEBTqCbrhYrJ0s1PK0IXKP5+AOxeBA+2b4wjPEUh+jHtioRehQKxh2wr1BMww
 sm1nXUCKp0x/JBDgQGvv11dzCkLoE0ZJeSCftMxeOwCTMRrjz5hccDEA0UivkRthwUqj
 /Pv+txZKIVWExqpxBNy0VBiri8lYWDZelvM0KydRfzpsGniC9ILl8s/KFDV2DpqIHNJ4
 lAlcAMAVr+qcvMg6Ioq9tNVYrBnoCc6B8uvYuohLP+Z2XEJntBrLHUBxiNNFWFU3G8ee
 TZvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaQLLC6VpSf08uWUrwC9NVHvheVcbj9NpZYCf1MeaO/NyRgkWBVO7oaxmQrEkZ0hOhsZ2D6LY4VpVV@nongnu.org
X-Gm-Message-State: AOJu0YzsDBR1GRjWfmdydz+1nvEQNIBwNSVXhTam1RsiwNY1kzSbclBs
 BpBmWUeM6TdC6Rf8X+Z5m9FTucKiLo2Fca/wMm/ZUdSoEzYtS22Nm5S0dTeYQV3lzexQ4repyHW
 R4X5808w=
X-Gm-Gg: AY/fxX7Gqt/MsggS7fRCyQcn6Vy53MbGCcESTfctDLA9pCFohDqz7p3fePLws6ifi5Z
 jTBqWnOineCynDvGApLP5uot+96K+k6H1D98McDtOkL8voE5prmt10xCjG17GQjXgGyI4e1Pqax
 BEURX/bRVSF2EdeSlpO2pIz54Wb1sTa2DX2uiVFvXRJq61oKImOkuqNLwNx95SJn71jlEjHtTy2
 zbLJ0AUjhjL3umQpA8mObRI9WkRKmJKBhr1tYKNZQBy8wZKfbGjQyFhKrrQARwk2cEw8ry3ZU74
 JsmQu2duPf8OsBEQ2uwIPd2St2ZFAA5yspbmSddaKmswMEpY0TFRU/+vfaGpUOc2WWCD9TFuy5P
 kR7KpHp0Qnpjr4Vo1aojVHkHmIysY3+dWbq2KevoH1yUkSZB+8SuyfkwEAmFnQwiOQ3R21+GPA2
 QhuuDdx7Bq1DJkCxK76qJreAhLryLEscPSH62ng7/YgvKKE0iaLNmvGg==
X-Received: by 2002:a05:600c:8b09:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-4801e2f90efmr9940725e9.5.1768507025849; 
 Thu, 15 Jan 2026 11:57:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe44b37sm268585e9.12.2026.01.15.11.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 11:57:05 -0800 (PST)
Message-ID: <ca306386-d793-4617-9ffa-d12749a4fe8c@linaro.org>
Date: Thu, 15 Jan 2026 20:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/i386/tcg: remove dead constants
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20260115113306.126905-1-pbonzini@redhat.com>
 <20260115113306.126905-4-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260115113306.126905-4-pbonzini@redhat.com>
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

On 15/1/26 12:33, Paolo Bonzini wrote:
> NB_OP_SIZES has been dead since the conversion to TCG, REG_L_OFFSET
> since 2015, the others somewhere in the middle.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 24 ------------------------
>   1 file changed, 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

