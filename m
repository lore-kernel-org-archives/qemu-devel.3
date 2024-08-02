Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986AEC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsGh-0008UT-Sz; Fri, 02 Aug 2024 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsGg-0008Ox-ES
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:24:26 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsGf-0004dR-1L
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:24:26 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39865a15900so28884495ab.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605064; x=1723209864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrihyRuy+CwxVGFss/M9dc/jM42ZvT8fG1e3xd0HuLM=;
 b=CwU7qsIXecoF7Qj53F6CX5nSpXilA1PxTPyFkJX4yXduYP9awlcDp9rd+cPOmDo+Qy
 /Ocvc8T8fvAEAofEqy/0jD4f6apeYs8lAUkqn4/UUso+Ajc0sfeCecb7Ee620NYFr8nn
 mbBEXWvb+F5eRSpCysk+3cXczT/HtKsPbk8XusoLBAai6hNdEGBVTcp2L58QrolYqecG
 B5DsZWoVxQuU004kKuS46uNV7JzTLOacL0Vs6H88ucFCN46PBVbe+Fgs+k2nZYezjG5Y
 KJd3LiBk1DESyPQ5Ip54ptskNYVY+agI/7XbJO1FJStVK3yjDArpWxE0yF/nTb/iQP84
 i6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605064; x=1723209864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrihyRuy+CwxVGFss/M9dc/jM42ZvT8fG1e3xd0HuLM=;
 b=Gov4hgYCFGninUj67OvWYiSKV15z4L8W6wvcv3ABEz48ch17r/7tdxi/wq+GJlZBrD
 5hRUCalj9GSluWPOJ4eHdryJ4e4Z00FZp+KZfq3RWFE+hXZ4APy6x+6W+Jf2HKOMLs95
 iDTqANs+lwLkr6K1Dbci7bVURCufZQYk2jBGGhSReKsZz/n2nJd1sU+XYRZV+Y+Mjuqe
 kPtMFyxiDk6rY8X7Mjv52HLJAfmwaUIfRz9QgNhw/QYI0RaBqe4San3K92BVO7Q6bIeJ
 YFQaeqPcep0MKXNzn17YW7srhiEDS8Nm7N/rCuLpCuxlsJwLVwrbT+nmc5Z76/MfO+5G
 D/9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQleHNCxmFi0NsTPOUW8Cghv3IuIKe8vE4xGSHtBsGN8POcVapNCZuCjltR25gMP6EFLW9rgQn3mMgVlD6aLhXssFaoy8=
X-Gm-Message-State: AOJu0Yyi8OnebsFXKSwpG+QpNVAEmgK0Bn+GJQnJQoWF6z4KbW0tSHNy
 wbP31eGwMmMLaMY+i8TFCiTJ6Ma+OgesAlhf8o22xYhMaqBgw7vvSAI92UvbSQY=
X-Google-Smtp-Source: AGHT+IF4SmZqiGgoGHqJggDMzlOunDSPqw8iwFvFR56D3no2sSKXxRh7v8zjjtsaVg7g1DEWfSbGbw==
X-Received: by 2002:a05:6e02:5c1:b0:375:d79c:16c7 with SMTP id
 e9e14a558f8ab-39b1fbbf253mr38002905ab.14.1722605063581; 
 Fri, 02 Aug 2024 06:24:23 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b76346dc17sm1353451a12.24.2024.08.02.06.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:24:23 -0700 (PDT)
Message-ID: <e5017e02-0045-4594-9808-43eb233b909b@linaro.org>
Date: Fri, 2 Aug 2024 23:24:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] bsd-user: Add RISC-V signal trampoline setup
 function
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-9-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-9-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin<mark.corbin@embecsom.com>
> 
> Implemented the `setup_sigtramp` function for setting up the signal
> trampoline code in the RISC-V architecture.
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_sigtramp.h | 46 +++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_sigtramp.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

