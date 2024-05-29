Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC14EC25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCot-00039b-KY; Wed, 29 May 2024 02:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCoo-00037u-Me
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:29:51 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCol-00064J-7H
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:29:49 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a62614b9ae1so187847666b.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716964186; x=1717568986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lHgV8nV6yjHY6t4YgcodedbTudDpaZFOcY1Jxo/uA1M=;
 b=RT0kih+Zz5ip8y4w155xTxkLN9Kp28SI2t3YIxI16w/S6jSZbvWjNvvPsFIVIa1M9U
 0g8C0hcwBF5fUR6keuEFMpS40kIaAWg/Dw5FCbSY6DzBSHULO7wcPLEkmip/izPfGnLh
 HIqxK2Y35S+wgzhGGmLUcVrK00H+Xop3xgRSOZU4OBWGtQ1xCEOwOkk/aXlnwV4sS4wM
 iq6C4LpXvt4jXjJcgu9fJYWIe/SPc41kWEfqmh/B91WZxKEbLcmgsmn0zDgStpCltM6w
 pN5DD1Ovl/nh4SPs7OZ+ltWwXtUWtF5svTMnta4vRnZIpQNMX2UV/JI7MI/74vbcWE+7
 cv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716964186; x=1717568986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHgV8nV6yjHY6t4YgcodedbTudDpaZFOcY1Jxo/uA1M=;
 b=KLTGBQ618VJX9HT+mXiMzUXhNzWEHrUqG3evhaiHgTb6CpCtUpRZao1vOhsB4diGbC
 pf1OrLqrbMtCxDi38K1IYMnvzVjPINd2/nTlHTq9ooq5lidqXG9jCsdeTIxLQT+WcmiF
 +ZaYQ1t8Y7dku0QD88Vz5Ac8pjA2dh214zoTfUHXhF1boOShknBRo2q97vZC/rIi698Q
 3IO/UYF34Ls2Rp3d7Ufn03CpqB9G5u3w7FKIB/pWnbN84LmkhKV/DG1rzjuR/7DrqEOZ
 C/YXY9PlO1gdXt9NOVDiUW9gjYFUYX29BBnGpEvRAZTK19sXOd/F4tBR5C0ZS4V5sDSZ
 kYFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+vnse2TJDoGGnOpwP2V4k2d/sDYiiIeo3f75L4a2D1gunEgpQKyuIBjMnfaQERvlUpfV04DfW4tral/g2Y2Rak/p1oA4=
X-Gm-Message-State: AOJu0YzKqgyvVmHhZEDkvmkKvIdgey5zv5LlPxNL5Q7qBJq3e8obT9O9
 O3KJvisNKvCBxxnIXIRTxnStI4VAUbKn08MQ7wjBiqCb2/+p9rGMECzudYJJ3mUtoOjOoly3SQG
 J
X-Google-Smtp-Source: AGHT+IHHkDL51WpsozIE6NthOhQSs/B7MN7RHxyWmOjhEsE4odZhwpR7p/0bTwOkYvvibSvqMEtMdg==
X-Received: by 2002:a17:907:86a2:b0:a62:c2a5:cff5 with SMTP id
 a640c23a62f3a-a62c2a5d017mr821584466b.56.1716964185803; 
 Tue, 28 May 2024 23:29:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc51489sm681130366b.128.2024.05.28.23.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:29:45 -0700 (PDT)
Message-ID: <aa713d70-dc48-4e23-8a33-aeaa65e488a7@linaro.org>
Date: Wed, 29 May 2024 08:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] util/loongarch64: Detect LASX vector support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527211912.14060-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 27/5/24 23:18, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/loongarch64/host/cpuinfo.h | 1 +
>   util/cpuinfo-loongarch.c                | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


