Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A2FC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsRi-0006Jv-TE; Fri, 02 Aug 2024 09:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsRZ-0005dK-70
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:35:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsRX-0000gJ-1z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:35:40 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso61621285ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605737; x=1723210537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LKrwR8gdaG9Uoy1hyc7+RxHYBQ8ZoRth1RsaxTsnTd8=;
 b=noxxMtIkNmJJSQ7QaN1vnywOU7pgA2XVfH4agdFkKWbQYaAfSe2AJu7nuqVCF7tJlu
 7LrKzAspFzvU31I9V2HymW3g/0kubUCQq+eZuDUBbjfCAinsLqBcUhF4DixuoAfHSUNm
 d0+eOolcmrcm3p14GWUOc68gi8X2vg1ygbP+Aa3sGD1DrBOiEdRrqXquBtsN3If/bODm
 EJGURe8It67sdAmiuO/Q9/wdBmgy3zFO0godV7drZd4t06m+xa+Zt90i9ASSEsfE6dCd
 T1Oj5cikwULP+bGp+hKxErkmmcnk53gmmTJ92AsdVrVur1jsY4OMRYTmKdu3bqBf0Fb7
 7qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605737; x=1723210537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LKrwR8gdaG9Uoy1hyc7+RxHYBQ8ZoRth1RsaxTsnTd8=;
 b=KwoiAuBXsTda+lrrsckTKLKfUz399TznbG1ez5QpAi2lZR0vRwoTmtftWM3JcI10tB
 FSCWzpYZx79Jg8e2wel/8ZMjjmA78oSrDFx1OH683tP3D440lnF9zYC8AvGhpqq1E2oN
 9Hl29ELMqxucmQQiPTLZwlWjpSaEuGPk138c9dCgR8P3yEVs7GoY3taaGPYMH5/nRLhL
 mJmcGyc5PtH162ZN3ylimrYL0X03Os4pothT8E+VhxH/S3pdku3tr3llKUczhcnunReV
 //13Y2VykeVrbd8z4MUH7cKjF+ry515fpgvqqwoKi++ysO8c4On44+I6r+UwTFJFS0p8
 Chew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv4z72mBv/OefsHG8v6lbt7UY4RMQ4DoB+xM6QDKEM6UFFbt0QQwcucZj4Z6csOFRUPmcYUHYInf0y6u+RrXzW9swSfZQ=
X-Gm-Message-State: AOJu0YxviF4cMMVueCQMBeO3t0PIU6jpgodFVaoCxmBAFCCET7JaGolL
 N1hiYRvWCzf/qMlZxkv3cQN2Uwb3rJwFUinadTQ5ZfTAnBZOVeTKJA2GFi5X+MkwrjecKXsdtGh
 Qd80ncg==
X-Google-Smtp-Source: AGHT+IHJnVTI9MxgJlUqMAHjhwWJFwrZ4F9N9z8vPkaD35GxU/i/Ydj09C2FNpsRg0aXOJ+Xe8SnEA==
X-Received: by 2002:a17:902:f54b:b0:1fd:8904:ecf6 with SMTP id
 d9443c01a7336-1ff5728c53fmr50351265ad.21.1722605737330; 
 Fri, 02 Aug 2024 06:35:37 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f219easm17075735ad.58.2024.08.02.06.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:35:36 -0700 (PDT)
Message-ID: <95ddcb59-4e50-4c7a-b0cf-5a82dce5d7a8@linaro.org>
Date: Fri, 2 Aug 2024 23:35:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] bsd-user: Add generic RISC-V64 target definitions
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-14-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-14-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
> From: Warner Losh<imp@bsdimp.com>
> 
> Added a generic definition for RISC-V64 target-specific details.
> Implemented the 'regpairs_aligned' function,which returns 'false'
> to indicate that register pairs are not aligned in the RISC-V64 ABI.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/riscv/target.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>   create mode 100644 bsd-user/riscv/target.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

