Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A14C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZn4v-0004sR-ON; Fri, 02 Aug 2024 03:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZn4u-0004rR-5y
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:51:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZn4s-0000FV-Gv
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:51:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd640a6454so62531565ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722585112; x=1723189912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U2QOgJG/TYTxJgYznq50ekAAgKItyqMUufOFqN9k8PI=;
 b=XE15qSqne/BhbisWwZr/0hnm+6vI/6gJakZRtR6rG3llbCVg1n4AD6k/57kA0B6r3B
 EPueqz02t/tw1mGl4HsLYGUsLsTtRhTfMP3kru6iIK5zZY7lONxNlbhec00FkGaoFsUh
 FAmd5QVcNVQdUFfc8oaD0M004j143rJ6ygkOM35pMhsjhKvzSZt+ih2FoJKRBZTuG20b
 kMBnTaqAO6AeSthUx1u7GAySp2RMz6V26XwwX6SDtQerYve4L8o/neL2ICKtWHalRsIV
 xZQMI0y85490S/fgaKER17/MtkdT81+i0ZSByk/YaxqBeQaY5v55WX9T5NdqjwbSkNza
 S3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722585112; x=1723189912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2QOgJG/TYTxJgYznq50ekAAgKItyqMUufOFqN9k8PI=;
 b=ZXhcKB54QpNQeaxY4SF7puwtDZs6cAybU5fW/RHQffcov62NiOsYWIx0bnFcOtZXdv
 mmacP+2BBEzll9ARfDtHR5h8Niugh8WB7vLDFNQOyIpBW5d6ijOFNBCl0Aa3f+VaC0o7
 4TTLhzs4y0ioHeHFaqGqpO0mpbjYhg3Su8fLgttDDqeWQVF1+X5wRNFLT/Ssif+8Az05
 PnlDXQe1BWiAjrkwPsIvfWynWqKu4A2c25JO0FnDG9WsZwOv2zFTlc2AdullqCMshhMD
 OpXPuof5/RDv63ND7LJxumrLInc0EbLa6ZfaB2slM9t/FyiUH0almBj/u2IHi5Ns+rjM
 x5Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzyeKRepqxJCQeIXyOOFFQa1rMCK5A8xUvnQaoC1d+m3BhIpRkEpsdPHMmdQN3AyboP8f0xgTbEl+RExoILPQ2XGjOEp8=
X-Gm-Message-State: AOJu0YziS5C5PJRPRrqOQC7XXNszsqInK2qvpriYwaclIAHkkVxPbnGf
 3sgZrHWTun2c9iwl8+CTmjiYDSqt5zJ+sDIT4fIpm5viLwP8ldXGa0lVXjhg0zpz7wiUTWXs5e/
 TZS7I9Q==
X-Google-Smtp-Source: AGHT+IHLDqUhXTo0BShtHsam/aq1U9p3aZlHYtqyudxSwG6/1tuLD5ghJUMaARQkY7Hvqwb8N5J1HA==
X-Received: by 2002:a17:902:e18b:b0:1fb:81ec:26da with SMTP id
 d9443c01a7336-1ff574cf79dmr27634075ad.58.1722585112397; 
 Fri, 02 Aug 2024 00:51:52 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5916eaffsm10886535ad.194.2024.08.02.00.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 00:51:52 -0700 (PDT)
Message-ID: <f8ccb6da-e3d5-4717-8b7b-b20249cf5290@linaro.org>
Date: Fri, 2 Aug 2024 17:51:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/21] hvf: arm: Raise an exception for sysreg by default
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
 <20240730094020.2758637-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730094020.2758637-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 7/30/24 19:40, Peter Maydell wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Any sysreg access results in an exception unless defined otherwise so
> we should raise an exception by default.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 174 +++++++++++++++++++++----------------------
>   1 file changed, 85 insertions(+), 89 deletions(-)


This patch fails to compile:

https://gitlab.com/qemu-project/qemu/-/jobs/7489527235

../target/arm/hvf/hvf.c:1283:42: error: incompatible pointer types passing 'uint64_t **' 
(aka 'unsigned long long **') to parameter of type 'uint64_t *' (aka 'unsigned long long 
*'); remove & [-Werror,-Wincompatible-pointer-types]
         if (hvf_sysreg_read_cp(cpu, reg, &val)) {
                                          ^~~~
../target/arm/hvf/hvf.c:1175:71: note: passing argument to parameter 'val' here
static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
                                                                       ^
1 error generated.

This snuck in while our Cirrus build minutes were exhausted, but it suggests that the 
patch was never tested at all.


r~

