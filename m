Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491DCC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgmy-0002JT-Qx; Tue, 19 Mar 2024 17:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmgmw-0002Hz-Tp
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:14:26 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmgmt-0008Cm-GR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:14:26 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6b22af648so225228b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710882861; x=1711487661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mNvi2tmZ8zJngxfI5KhlPbVp84w4oyI5JdITFeSXGR8=;
 b=TylFaU36l1QVDUTppyWw4V/pbaB3INFAKBsPiDaLtDTy9WTef1pG1sn8nzBU5QQjdo
 Y1/ymDhaiZugTJ12zHhnwgRQawlse9cRDkQ0O2yfcfvAFMSQv3T7/zbXdg4G0ehZeG0B
 PFVKPybtLLvAeZuxlWsrWrvX7lbNTjk1lJs7QUAVuLw/BCU4YfV/808IsPJzfNzggiYl
 N70rWh++BZ8mKUcaMUcGva2h7j45jvdovyEBTIUl3LV9OREW8+7FIf6W5Lnntr9j5TZ/
 1rE6hIhu/PjmdYOg9lVm72e8KB5HCwbmamZILRbT9FMKo2B8FUNwFvW686pCQ/uDbrpn
 3rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710882861; x=1711487661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mNvi2tmZ8zJngxfI5KhlPbVp84w4oyI5JdITFeSXGR8=;
 b=jrZzTm5IKRzfo9ts+j0LNZ9KYbCizvM/Kq/ezfzLW3EtsdoufGdIJcUydPuRYfIzUV
 lqfaERBeI4lKrgPU/jNfE2PX529xuiNDSlmUgLYVNpQ4LSVwsjLDfxwpcPIgJaf7MJWT
 bK6YsaxyH9HpseapoAR6QwcgHSNowsuGwcxHC6oIRFCYTaoGpm2imbb6yFF3dZdYtCJw
 uBlDa9QmjcHxwmykh6+7rxBixxtXsb8iJK00BLwymIFk1bufaf5/wzVSFeksFx08WJAz
 X6KJWXCIuVonAssz0noo0JOOi65LSdASB8iPa0KE0YDR5Phq91cc4Kf5nwEACUS6mSQt
 uO4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZTMvkswKcsOqsOgRu3zmDxDPPbK9lNlOiF5CLBjwOFMDi3Yt7K4j6ZhLsEmZHXcRNc3VeVUAWekUAUIpcp3v9YHbBnz0=
X-Gm-Message-State: AOJu0YxvFesLYbd+ee1Mh+bf61I6o4TV7GZNLTdQG+VI5QNZEN50ad7V
 S5JTPGxL2gINiDYTlvf8ahrXav3seA9C9Rafm5sk4KS87Xoqon8nfjEuyoOx6Oc=
X-Google-Smtp-Source: AGHT+IGCYV9Z/bxiIAC6PB4I+CCedOi4j/ITh+O85iRlB7FvzQYPOOGOGghToGhjNSms0BhvovF1uA==
X-Received: by 2002:a05:6a20:2d11:b0:1a3:6644:df05 with SMTP id
 g17-20020a056a202d1100b001a36644df05mr5750034pzl.16.1710882861462; 
 Tue, 19 Mar 2024 14:14:21 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 h3-20020a654043000000b005dc49afed53sm8259622pgp.55.2024.03.19.14.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 14:14:20 -0700 (PDT)
Message-ID: <9b23f721-7ea4-4f12-8f8c-3d87aa9ebefd@linaro.org>
Date: Tue, 19 Mar 2024 11:14:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 24/27] target/sparc: Convert to
 TCGCPUOps::get_cpu_state()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240319154258.71206-1-philmd@linaro.org>
 <20240319154258.71206-25-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240319154258.71206-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/19/24 05:42, Philippe Mathieu-Daudé wrote:
> Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/cpu.h       | 37 ++-----------------------------------
>   target/sparc/cpu.c       |  1 +
>   target/sparc/translate.c | 33 +++++++++++++++++++++++++++++++++
>   3 files changed, 36 insertions(+), 35 deletions(-)

Again, why translate.c?

r~

