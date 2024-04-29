Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD529C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SWs-0004LU-5E; Mon, 29 Apr 2024 11:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SWq-0004Hw-71
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:02:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SWn-0001sI-6t
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:02:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1eb66b6953cso16696075ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714402967; x=1715007767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fhDQOoaCRXHIqRUSRABFLCYOp6C0uUNzqTLTSoqMEpo=;
 b=XpXUMz+MpPDw+eRxpJtCZMZHLlGW3gmjMNUy1qUaAwSljbPbu2Pm/TH4lSgYwDfy1B
 hM+o1kEGHXGlrFdeUqE6jJTeQ2r7qXVMwE07Jfil33Rse8f8bGdRbV4Wd0dj9qn0QkoR
 LHzX23OdwtLPsU1E8HXHgtx6rre7sJhw36iL1eSqPot6/Q0CAvGNmN+szWq3tL92/b4G
 UOimhnQl+vfCb5/9IDNzWSfXGIroCRp6Bu6DUo4bTbukj0VUqJQ+nLlh7/iSjBsnc9+F
 WLQjoXg6ghFPEyRT01i1p60dr3bPY3WrgDysU/Mpd53jV/IJZ3Rv+/0zmPZTFpAkOLny
 5JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714402967; x=1715007767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fhDQOoaCRXHIqRUSRABFLCYOp6C0uUNzqTLTSoqMEpo=;
 b=Hi2JyJy3GmIsfEK782K4HH2OQLApQzmWQ3Fke+kd4n3ArRI76f5yqp1r1t6wMBBaJ7
 9hKLcPfJ+9L3POenyUFHmcQVBama4oscDEepZLu8evluYLbjt+HSEpZrH+SrA0JHWiYl
 EgvrdXT6CdFA2y0XHNXEKoHA7BGNTQ3igTkQ80UsaJdSwKlz/Leg+4CgWMcOKPAPT+Ap
 Fc5JVhIdD5UhFSxQHb8tNeep0bP/dY3ywSJbyRe+oj2iUS3TfPXA71NMi1N0lum2IrpM
 S6f4AA6mG485tRGW5fVUiAhxGwHXqvuDfyfFkKZF6kT81M/DgsLhR18KIuwA9JYjBPUu
 APxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5ItxbA7WRlmb9jK4YBpDgWtraH5iquQcRVwWLqhXfPQNABFEARNQO8tVA9mW+G4ELKdCQ+usZXcytM22hiyl5NzXTmPc=
X-Gm-Message-State: AOJu0YzcWxrfOjGaoxmuo+ctyN8jgDTQIDc55oyjPAKfWgNKGyYm+Zpr
 9Vfl23rfP5JKDYRZPh6QPrH98AVSihgUYpGnTYOgdXb7Aecb79c60xBjq/Sz7LOmQh7fQiUUcbE
 d
X-Google-Smtp-Source: AGHT+IGEnGdAZGCd+sZ/nlXOQ+0DAPAcnIkRIQS6tJKAiRlgMbl/nqqhxuiTZeOyFqNeVumPy4BSIQ==
X-Received: by 2002:a17:902:e88e:b0:1e2:3720:e9b4 with SMTP id
 w14-20020a170902e88e00b001e23720e9b4mr13443946plg.54.1714402965341; 
 Mon, 29 Apr 2024 08:02:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a170902d2c500b001ea02645bc9sm12325387plc.148.2024.04.29.08.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 08:02:44 -0700 (PDT)
Message-ID: <3aa8075b-3222-48fb-b411-99e03bc06da8@linaro.org>
Date: Mon, 29 Apr 2024 08:02:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] accel/tcg: Move @mem_io_pc from CPUState to TCG
 AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 48d1513a35..6c188ea94c 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -30,6 +30,7 @@
>   #include "qemu/log.h"
>   #ifdef CONFIG_TCG
>   #include "tcg/insn-start-words.h"
> +#include "accel/tcg/vcpu-state.h" // ???
>   #endif
>   
>   void cpu_sync_avx_hflag(CPUX86State *env)
> @@ -518,7 +519,7 @@ static inline target_ulong get_memio_eip(CPUX86State *env)
>       uint64_t data[TARGET_INSN_START_WORDS];
>       CPUState *cs = env_cpu(env);
>   
> -    if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
> +    if (!cpu_unwind_state_data(cs, cs->accel->mem_io_pc, data)) {
>           return env->eip;
>       }
>   

Not good.

Although considering

https://lore.kernel.org/qemu-devel/20240416040609.1313605-3-richard.henderson@linaro.org/

we should probably merge mem_io_pc and plugin_ra.  So the value to be accessed by i386 
would not need to be in a tcg private data structure, but in CPUNegativeOffsetState.


r~

