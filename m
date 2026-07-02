Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC516C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLV1-0003hR-SS; Thu, 02 Jul 2026 13:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLV0-0003gW-F8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:46:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLUy-0004gJ-VA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:46:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c7cfa17fedso21933365ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014411; x=1783619211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q0zqAYiXHciRxIDXcHiXm6Dqqu+wfpe9iRkuzshjIwk=;
 b=TE2sgJtUvqEF5l9I0e6mHm/yE+hojg6wpyIQpTptx5uSoogkaCio9DFMylga1TFEiV
 V+SE5VVNe5PzIoIzOVVugsq8fTXbXITKtz0E4dQFN5zcL8B/lPjYiYQ0SBOzIy2EOd3Q
 +zLJUryy6vPoymYHH6G+0YHSPR+Gy2ucigAAV5j+fPckV0kToCHn+RbV6EO3vXlR42bV
 lkw0DctXHq/T9y9y9ZHmGY5z92p4hXMagzFdYgyRUhdHnaLqVJ1XmyWWuNWfSMJpwuRu
 zST84FlOZnae9ldUXxfsoZf664YxKE86+keN9z0r6to7agVZ/0JVNAj9Key3n9vTRV5K
 mtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014411; x=1783619211;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q0zqAYiXHciRxIDXcHiXm6Dqqu+wfpe9iRkuzshjIwk=;
 b=WCry0eiZqt9BMTdK23KLZnQtutRjKfOuZQ2x0uHu94SpcX1sfg+rhImY5RKSsSIWtg
 uQ91+Xn3v+oz9tZKsPWP7FQSvuYezXh2a2W0ddJk3tqfIxu8h8ZHnMYU5nQ9i7oMN6Jh
 XRr0djhOOSSI9L5cwhAkTzm8OnLHMSu62Y0gS4izzhLgayLYy6oOicGGHMAPXIr7SmF7
 lkBqgXlEvTSV/A740Q/IMFNDeTfOQN4uzyUPTZwfi9QFMG+nuqpsiDzQb5aFVlgbcbSK
 SNVAs6JPU5lwbTfLzt2xuAhts3bZwZgG1d292mwk9KhTnj8Z/r5v3Vv5ao0NnHr4RsKx
 GAlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJLj2TaFzFlDV0FLa6I0S1n1luaOYZkrLdVqItEJqumsNLZ30+Ek1LlbIBBim66soOE89pmpj8ZNZj@nongnu.org
X-Gm-Message-State: AOJu0YybtkAjzX2F0F9Rhwg4vJCr3KC59S50piUVOPTXv3TaMcyQJ0nX
 8HSMME0sPovira0bzFrj6AM6UeB+Bz3qilrp0Btu8s7vcNNB9sAUdDqPBIY7BiO7G0I=
X-Gm-Gg: AfdE7ckvyzFHWZRbVXKUwPlBbX4u0wmRf9Jqdy6lYGT1viKL/Slz6p8Nuj0J0baGBKj
 d1S+9XZUT/i4fSYxtfedu2aimW/FZsPtYpk7fWsv4BnSVY7+13ByOwm16bcZ52uBNMv8E0ofdJc
 4K+YjJ/IlUdPL0sb0BTx4TMhJ26ayZzgAg+BvSarG/3FPikznYmh2zdQyAAT7ZXNjoywsSP1I1u
 /Wgal5LWZ5w8E3yDuKNFPHIGyyDJdLcwgCgzqS97RLJz0qPYkHfiLWui2lcbBiMiOtzC3UZNuq7
 zFargtmJ4E/C0ZLfZ+aBrQD3oBuo1Va6txD9B0E/LulbexayQWgTEqiS6cvsuR5JWYjrqMokMrs
 9oCNwYEbGcETWAdpCeTG7XfPF5CUC0+KfflQGDjfkcyXXVEah1KvoqSwfmZTi+HDCKXuID0nyro
 wsh5vzDHHmzZy64cctR8AwZs2+9GyIGRt5qGyWj7tKih4cBaOE6E033eAeAg==
X-Received: by 2002:a17:902:e885:b0:2ca:5a42:d8c5 with SMTP id
 d9443c01a7336-2ca7e8b3a60mr72126105ad.46.1783014411397; 
 Thu, 02 Jul 2026 10:46:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a9e96a5sm16943575ad.63.2026.07.02.10.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:46:50 -0700 (PDT)
Message-ID: <5e57be18-cd9e-44ab-a001-fa835a4b7023@linaro.org>
Date: Thu, 2 Jul 2026 10:46:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] gdbstub/user: Directly call
 gdb_breakpoint_remove_all() in user mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-21-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-21-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> No need to deref external methods with unused argument to
> end up calling a method defined in the same unit file, call
> it directly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   gdbstub/user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 299388b9f71..90d6ee49fb5 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -557,7 +557,7 @@ static void disable_gdbstub(CPUState *thread_cpu)
>       close(gdbserver_user_state.fd);
>       gdbserver_user_state.fd = -1;
>       CPU_FOREACH(cpu) {
> -        cpu_breakpoint_remove_all(cpu, BP_GDB);
> +        gdb_breakpoint_remove_all(cpu);
>           /* no cpu_watchpoint_remove_all for user-mode */
>           cpu_single_step(cpu, 0);
>       }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

