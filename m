Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E54C52D7D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 14:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdVeC-0001Nw-2x; Mon, 12 Aug 2024 10:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdVeB-0001NH-1N
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:03:43 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdVe9-0004An-7V
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:03:42 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef2cce8be8so47368311fa.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723471419; x=1724076219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dUPhA4BDSTdkGLq4zR25nvD9Ssoiwc0qX6DhwLQaJx4=;
 b=mxDL6wzYXqEN0Ee830QVfFwmQ0ox2YQyIZ19zRe5Rzc71Srt6XQYtwMC8Wg4qFvUOq
 v6cEkIufaHY+SoY1RupZtFVxQDcPrDnGenIWiV62jFSWMRL+l6J/cZUJhyFGYNqA+U8J
 wD83Q1cEGQyJS0otwye9mRNOwSgCopqa1iY2ZnrM3qnaqnMVmB8grbqrcGfsby5Nlk/3
 rELCBIix6d8ccQ9wRCWnxISPS7646zkAZgmJRj9jH6oWzAOMF0oLXPu1PofCmsfI9Lx2
 BeIOeBZ7QhaMUFDAJujBofhK+mHFn9fapgRCxIhfNY/v8nlYvM18O9RV6G1HqO0lHyHd
 paRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723471419; x=1724076219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dUPhA4BDSTdkGLq4zR25nvD9Ssoiwc0qX6DhwLQaJx4=;
 b=f/72X77oP2gXZUZuJJB70zRtulGUBkb99W3fa6EnbKDizfj35xhid1lEJFuvFVMpHP
 TWaMgiCT0mfz90PB+AvnJDR3ZXJ/dmE/MlnBz/aSZFyXuBtRcuvRkbXNGN0mUr49kdTe
 KpTi5Yh+6eTEZ6uLz7XP5+pt43T3NGWhpHICNasRCBeYwZV8fIg9HLxGk3iYKC06MK5a
 lrk0Jb/LKIKpqGmoe3mwruGR+C7wpjNMkaGX7Lkmc4Cb67ArPDv3VTIHS5sDGgLQ+8VI
 aK4vtHsorWfVvrYlaRDzR4mpBoS1PbDae7FEHcar7yj5uf4YDdaS9urox4kJWc6UOYiL
 xyMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFNTyaKJs3uNzwgJQJFbxTgevruAt7oCiboveEvCdykhJD/Vekh/EammqHBdBfHcOrEoQeacaa96X/ExRdQVAurbYTlak=
X-Gm-Message-State: AOJu0Yyh7qGyVF3ePDjpUFX4Czm1PMSMfTmjrrRREc2mN6eja9AiYsa3
 59D/Khqi2K4oShsaP3pyu4xA+B44HpeyJ6Xc1NY/k0fC/PQmAHe6F/xDoKP6Lzw=
X-Google-Smtp-Source: AGHT+IGYTQHhp5BLtPSHHYxjs9WBl3ut2OLBRTJBHy+aOTUd7rLQekSRx4yQIj+IosOOzr5IC24vxA==
X-Received: by 2002:a2e:3e18:0:b0:2ef:32bb:5375 with SMTP id
 38308e7fff4ca-2f2b714cc6amr2850861fa.12.1723471418787; 
 Mon, 12 Aug 2024 07:03:38 -0700 (PDT)
Received: from [192.168.249.175] (198.171.88.92.rev.sfr.net. [92.88.171.198])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c77510asm196448595e9.33.2024.08.12.07.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 07:03:38 -0700 (PDT)
Message-ID: <03b07fd0-2dbc-4c08-baac-58ccabae25c6@linaro.org>
Date: Mon, 12 Aug 2024 16:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/ppc: Make divd[u] handler method decodetree
 compatible
To: Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20240812085841.1583-1-iii@linux.ibm.com>
 <20240812085841.1583-3-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240812085841.1583-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 12/8/24 10:53, Ilya Leoshkevich wrote:
> This is like commit 86e6202a57b1 ("target/ppc: Make divw[u] handler
> method decodetree compatible."), but for gen_op_arith_divd().
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/ppc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



