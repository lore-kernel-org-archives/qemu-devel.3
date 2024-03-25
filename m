Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616E2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 18:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rop40-0006sN-Os; Mon, 25 Mar 2024 14:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rop3z-0006rq-9X
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:28:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rop3w-0006hI-ME
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:28:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ea9a616cc4so1288609b3a.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711391326; x=1711996126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Z6u3rCpcYmisJciN/U9LZhSUUbITBpUfbXyuvhwYN0=;
 b=W/X0RQqJqwiGkvS2vhxQkdQKYQe1HnizQcBLQ2HriqJP7dAAcl1UcR4mRmD0IOUf5B
 TLO3GtXRjH19JHCRa3cZztN61VYFD6px+vU8Dy4ijXjzD7T0URoHJDfh4UUYi9JTOQbN
 82cOCmf/VX5i8sf+JvTW6KwyxnKlcVwy7579qxLYpErjAPDsCA4KYGfpoAgL7kogBtiH
 +dww3mIfGGxOIDgnExqjM0lpl2dbE1FR5yRbXnt0549fwSQvNpU37a892gJCwusa/Yw3
 Zmc01spGVUFRPbp5jw/AEmyTj0mtqiHzU8+lwtuIRXMCQ+FkyaEzUuIZ5lkbrmovkRbR
 kWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711391326; x=1711996126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Z6u3rCpcYmisJciN/U9LZhSUUbITBpUfbXyuvhwYN0=;
 b=OCXa6f5dJPQC+1nR6NHcb1jmpp2ELT+Lu25YC7X8opBH9ZEmH+VHi19o/exxvov8ru
 n39OXWmeFQ9F37kQz8/jOZbc7xCz68Mn/QMJuQwfn2jSRaqxMf+g4Fr3wuPUsCAxFiQ1
 jW8doTr/j5Ruvn9klN/YDfIBAApkqW2dc/kbmmH4OMPht+yXFvGKwWkflpL8FFUh8o/H
 ZcEj5QkYnPGVCKKPKd4OTe5Qk/Lk6nNTtyTWvDMYrswpE3T4UmJM1CSSX76hB6TEKpLB
 WA/68erXKC8+y3xFup92FsN0Rq2dPtGRHTh+6H9tn/RQyW/EKF/aQjXlfeSrmqCcQ9m/
 EuUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrqL3sd5Pp3U6+D8ZXkWBFJ0DpIhiZkSmnBUrz02cqkWySgtbzzRex7swgZoL4K3hHElsd+dijnBweSWPJYcFlr43iNNQ=
X-Gm-Message-State: AOJu0YzXO2HPhqydpQQsMMigc4k8i8LRQ0RUNzIpbQuzOGxFYyRRUkUu
 akCyOKlUzBWHCxMdJ5obPyM13LCcaW1rczxxykzMN/yvFFYRVFzFjH7MVMZNZybv0yK8T/9D5UK
 x
X-Google-Smtp-Source: AGHT+IFw10NpYZ4iDTHaVs8UPOFEO0+1oYl4wlhio1gghANweCvVJPBwstqITxNc/6hqaL/0mYw3gw==
X-Received: by 2002:a05:6a00:3d51:b0:6e6:9af4:409a with SMTP id
 lp17-20020a056a003d5100b006e69af4409amr9127825pfb.33.1711391326476; 
 Mon, 25 Mar 2024 11:28:46 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 a9-20020aa78649000000b006e681769ee0sm4515061pfo.145.2024.03.25.11.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 11:28:46 -0700 (PDT)
Message-ID: <eb736a6e-59fe-4b3f-9338-fb94d13fce32@linaro.org>
Date: Mon, 25 Mar 2024 08:28:41 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/arm: take HSTR traps of cp15 accesses to
 EL2, not EL1
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240325133116.2075362-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325133116.2075362-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/25/24 03:31, Peter Maydell wrote:
> The HSTR_EL2 register allows the hypervisor to trap AArch32 EL1 and
> EL0 accesses to cp15 registers.  We incorrectly implemented this so
> they trap to EL1 when we detect the need for a HSTR trap at code
> generation time.  (The check in access_check_cp_reg() which we do at
> runtime to catch traps from EL0 is correctly routing them to EL2.)
> 
> Use the correct target EL when generating the code to take the trap.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2226
> Fixes: 049edada5e93df ("target/arm: Make HSTR_EL2 traps take priority over UNDEF-at-EL1")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

