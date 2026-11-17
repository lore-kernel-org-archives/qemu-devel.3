Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFA606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nrzqm1D7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTQ0K-0001Ny-6J; Tue, 17 Nov 2026 15:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTQ0B-0001Lv-Q4
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:42:04 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTQ09-0000tw-Hh
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:42:02 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2eff29ca765so910895ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794948120; x=1795552920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IWjEVPGSgXNphk6MYfxB9aovQypYuT4qAxzof3QH4ic=;
 b=nrzqm1D7JqmZih/VoB1U5Ixr7nV5yrYcRMaFTYzaWvfek+dEwYy1/v7c6hs3T5JrQx
 U19EdWyO9es/84eTcSVNETSiPttOsgoOkUnEsohIKybCA8fx1TbfSsL4sWKzhoRxIc0I
 7nkDyGclOIzYnInzSwZvxq5tTKsSgGSjMv7EBufPxGWOYlOqFx2Imu0M6+xzB62cpwwG
 IsKsp5X4PHAaX0Px7HVrNc7RbFfgl055eaNLkETQQt17Eo4eYTi/di7bxfCJGlQgzhWs
 sVpwNNdLAGFxAMuGUB2dtTkf8pLWV9hyHRqZb0ozenMiiLCJq/zSPXeVnfOCa8jCNk50
 RdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794948120; x=1795552920;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IWjEVPGSgXNphk6MYfxB9aovQypYuT4qAxzof3QH4ic=;
 b=jbluJN4mAkuwxn7VVZAUNjKfJLkodAiuz6cBVKpQ2MjhL0E8y959QYm5koFTSOVUn2
 j3vC5Z6Z5yyB6nfN4QNPXOOdKhoS/fOptkOH137AHAau/vIZY/9pMG3054+H1idMcpzd
 QtK02bUu81NwGEJU7CZG1jeak8lvcd42PLjytKesFBfDAYwD1BJvm/SD+n3EMSg4ije7
 T9qj+ZukNdab+IpsaefzTvCXpLqH5Sd1BBEgZI8m/d3kcqMfK0H3gUnjeo4zNkViTK7q
 T+4GLROW7OZciTn8Hi820ngkE08Ic0APX0aTorZNf0WLJ8UFN8HCehGgp5PZ2rAA5Rot
 MUxw==
X-Forwarded-Encrypted: i=1;
 AL+hErHs/YZe6B9qscoeUkGGP0CsiBaqyU1MujK3MRwkeMEYjVXT63FKaPpSbdkzE87DgyrNx8tTzuuTpU49@nongnu.org
X-Gm-Message-State: APuU4Z/5zbvNDAn5gWlf9UPw4YZhPGqNarEM1Q8EEqhRcUx1JF8J6WTn
 QbsgpEZhB//3G6bby9uHRQ6bq2kCNLP0GbuevS+zImuJrdHxvEQT+TiYKCkWfjqjSbA=
X-Gm-Gg: AZFdTZd7lfYQsFqCNFFTgHGWtn2F9cj8bMMJAgeSBgUzKwUdE/OthkA8g0MFSXFX5YH
 ehoUUrcixg6uvgOVl4PZgQEEYd32eZzOE7UufH9HbWqGf4seKA9x6IalcYpk1Qcq4NGFn0f7378
 ExRPWOPEzI8T10DRpOfTO+eimpz0TBvOQAXD2GDi1vDtJYGKlqdXRWmcCXyaemrwNdli1Gv3Qin
 GG8NbBN2i+hxrDPveQBm31rHWnkpxmr3LwjLPOG4llmJoQq0mQfq1fyhGyG5sTXLKP1RV25RnpT
 ND3wHrP3idteQr5OeL4x3eIPR86gL5+Sek94XFS6x7lFJ1cQL94eOEpjndXlEomyxNWqi7Z5x9x
 unUKyt/UpdetK3SiJ/zF9po1GSbi9Qrd0OWy3OPzdvpyiObUa5q8yzOBVR8xMd9IHKA9lIsvcGS
 HHFT+S189UmjxOJnwEvZENBLWgBgw8zWUBHcL31LhmQcejymc0ewnWLhPdNygUK9uRw3qm4ZaOB
 RiFWEk3jaOntcOjWHmN3kk6zsLZ000DlmkSUROQZhOR3OaC9oAiKEkGCCDOW1K9rioWLSdg2Exb
 +VvepVdd5wV6317QVrYW+/BMwP6VszZMf2gmpwcA7lFcj43D+6sMrOCGIWZjQ078jOUUQBI=
X-Received: by 2002:a17:902:f541:b0:2e5:54b9:6b5c with SMTP id
 d9443c01a7336-2eff7529867mr4075015ad.20.1794948120025; 
 Tue, 17 Nov 2026 12:42:00 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff62d0068sm2280665ad.70.2026.11.17.12.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 12:41:59 -0800 (PST)
Message-ID: <258dce88-4940-4ad8-8870-457b028b14ac@linaro.org>
Date: Tue, 17 Nov 2026 12:41:58 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Test CF_NO_GOTO_PTR in cflags, not in TB flags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20261117080843.8314-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261117080843.8314-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 00:08, Philippe Mathieu-Daudé wrote:
> CF_NO_GOTO_PTR is a TB cflags bit, but it was tested against
> tb->flags, where bit 10 is HFLAGS_SE. Use tb_cflags().
> 
> Fixes: 46d396bde988 ("target/ppc: enable PMU instruction count")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/ppc/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

