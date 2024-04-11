Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D3EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1j5-0004vf-8w; Thu, 11 Apr 2024 17:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1j3-0004uu-9T
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:12:53 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1j1-0000QF-Qh
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:12:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so333882b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712869970; x=1713474770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IO5y9BOeUpOg4opmprf8Wn9TVP+GesVv+Rv2EFnHtxk=;
 b=fjCOknDD4ZqJRoU0VK9WzgFAQ/+C4Jj/JMAg/hhLPbProEzERuS0v8WWMNmdrqK7p6
 tkKrEr2XbNCFhxjiLJn4GDme6SQtoFVUKSESa3H8fflFv9pnFEipD5/P+uGG76e/fiNt
 mcCNFXSGFAgSy/Q2l90MN6qB+G8ZT/9k4YTeHffO0Aez0kmMkmruH9VYX8mejNI04yn/
 fSH8nBvXP9XERxTd94gtmE0kznh/fAtXyk3o6LquJbSs/QvqeUrJ++T+62zWYOPu85P1
 M/rE2Y8XrY3IOKEPljocKWF9Z99fG9w7ai14n0aNMAJaWVXoCdw0Vj6S0NrjTDmTMNDp
 za/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712869970; x=1713474770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IO5y9BOeUpOg4opmprf8Wn9TVP+GesVv+Rv2EFnHtxk=;
 b=ga7htiHiG5pkOBS62ElqFBynX4VC/hqL931eRg8t/vHwBFmTMBz3f9FZr5jVDMw0qs
 7jx8EhcGsKjv7Iuigdch4wJARPtQjAhqLojJRtRJMYgcBih2lhBg7elYnqeYUZKj4JiI
 wKDUg61VtnrvzjEENwnHdhtjXgPFywXJhrel5LVi3Pg5kkpXJeKNUPyNK9+bdPAXSm6+
 5/BG0j87fZNgZX+iwLrNdWu2QG2PAhkgo3bnLmoRJsO8ndfONZ7FPdkBO4HjCvY2NJ6f
 PfKVPcZRIeuKhdzKtB/L7ka7rMXfuNPDqgWs9jIxiqd1CumXNKRiOxD6x0f5UARRKbUc
 rYkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJOtoIU4aLGDpb1CVHYWqAiL7J6G73Z5CHxmlC07jvHf5gBcYh1oFcr+DgE97CbNxocTNzMn5V8xXN8y1WddLJ9+aR154=
X-Gm-Message-State: AOJu0YyIZgzBt1t34/Sa9eKRaJnYQTYOjvH8Q97zWdNAWsZvgX+jo6bN
 +SimZg1BK/zIwfqhNg1BiT2pEwbr1UYqwHV5aZtv3hhh2bZovW2wcFve4Ga9LuM=
X-Google-Smtp-Source: AGHT+IGzdIYgV3Na5q5MzmV+cfDFiNV6yWPObDqDB4j2pRZ6CHBSwidelo6UMGTLPAswbtjZvdWO2w==
X-Received: by 2002:a05:6a00:399d:b0:6ea:c2c7:5d6a with SMTP id
 fi29-20020a056a00399d00b006eac2c75d6amr1158217pfb.2.1712869970227; 
 Thu, 11 Apr 2024 14:12:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 z128-20020a626586000000b006ed9d839c4csm1677534pfb.4.2024.04.11.14.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:12:49 -0700 (PDT)
Message-ID: <3b100155-89e7-4229-8c76-4b1b428225f3@linaro.org>
Date: Thu, 11 Apr 2024 14:12:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] disas/riscv: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411104340.6617-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/24 03:43, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   disas/riscv.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Ug.  Repeated strlen+strncat?
All of format_inst should be rewritten, probably using GString.


r~

