Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6643C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 20:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSjS9-0001Rx-56; Wed, 24 Jan 2024 15:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSjS7-0001Ro-Gc
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:02:27 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSjS5-0005U6-UB
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:02:27 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a27733ae1dfso618830966b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706126544; x=1706731344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNLnvyHySmO7ItePxZVJYmXuwuXv7JxGocbFGTpD6y4=;
 b=bM1PmXxDtP5CRA35yS3Y5EiJI0z7USUYwnpUvblrovLAucluNDFTG0tCWie3c+ELzS
 OcWqMHbrxlT4zqizd+XKtU4jJmOjNfFOf5aCLHY/wn5GOriQ9bUsss6aPWVcayEHTWIm
 6o+2iE/lFdYoe1xpveiTD2yO3zPY5BaWddb5szBfhKc17Iq4Qz69wjAqRsTC1zGmUwvl
 u+xJmKz0g9cs8Ha42WWRWvMHD9d9hsuRWIamXjJhMJhtwqd4Lye+iBZF8ZbC3eYM1apJ
 9pv4ilWQNwoNWjl68zrg7fX4wIEahMlScLjymRh51fh3DQGvzHNYDAqYETnXIiqs8idN
 aqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706126544; x=1706731344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNLnvyHySmO7ItePxZVJYmXuwuXv7JxGocbFGTpD6y4=;
 b=Bgw+Y5y9YkCRm+0CtgSbh+Ku5oCwEMGJusLH68/1ppSDUj9GnnEVrrihsFJWzFDUZR
 wmU12ghHW83x9YdRxi2tj10F0Ei/XuVi+taO+uUb7BtdtsZfnScvVbMtTuC1pLtY5afV
 mqsHwu4XQNLpoPrKCAUPrAGs0jpEQzgp8hfiZGaQO2Lz+pg11xlGLTmsw9t4CGIUTi3q
 cA5U7O1vbPtOpUcE+Q4xhVTnVjIzIcB2GiK7bnkGpp3Ue+nK6x3y4ne/SFGPv2nTSBTr
 /105AZQhRojzEFpFQNVhKEVcqznCKQZXwYEkpqZDt095eNkcWSehmxZ1lrSf1Evq6iWN
 /AIw==
X-Gm-Message-State: AOJu0Yxg7J40jJWHIXA7W0seACiGSysUqiKzJ0qJp6QMEgenF73ctTGj
 sYn+Y4aXrdGpvh2t/MCSDUb7SYq3KOTkKGH19wtqVww9rGqdr9BLxgWNXidqRig=
X-Google-Smtp-Source: AGHT+IF6BIU59JlHK/K4aUcnrMvyBWBa0qLfz0nZGl0uZz845/5GDFaqGhhkaWMGBkeK872hQaVxmw==
X-Received: by 2002:a17:907:a786:b0:a31:1a83:a84f with SMTP id
 vx6-20020a170907a78600b00a311a83a84fmr578036ejc.283.1706126543245; 
 Wed, 24 Jan 2024 12:02:23 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 n7-20020a170906118700b00a2e33a6cbecsm221993eja.18.2024.01.24.12.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 12:02:22 -0800 (PST)
Message-ID: <7b79af6a-515f-486c-be6e-4fb6b6091e5f@linaro.org>
Date: Wed, 24 Jan 2024 21:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/i386: Extract x86_need_replay_interrupt() from
 accel/tcg/
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-8-philmd@linaro.org>
 <45m4n5stmuuyw2bco65l3dkjchtyl4m364j27ov5xjqase2m6r@qgtx77dgbyqh>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <45m4n5stmuuyw2bco65l3dkjchtyl4m364j27ov5xjqase2m6r@qgtx77dgbyqh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 24/1/24 18:17, Anton Johansson wrote:
> On 24/01/24, Philippe Mathieu-Daudé wrote:
>> Move this x86-specific code out of the generic accel/tcg/.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/i386/tcg/helper-tcg.h        |  1 +
>>   accel/tcg/cpu-exec.c                |  9 ---------
>>   target/i386/tcg/sysemu/seg_helper.c | 10 ++++++++++
>>   target/i386/tcg/tcg-cpu.c           |  1 +
>>   4 files changed, 12 insertions(+), 9 deletions(-)

> Ah this makes me happy!:)

There are still few more, but this is a start...

$ git grep -wA3 TARGET_I386 accel/tcg
accel/tcg/cpu-exec.c:311:#if defined(TARGET_I386)
accel/tcg/cpu-exec.c-312-                flags |= CPU_DUMP_CCOP;
accel/tcg/cpu-exec.c-313-#endif
--
accel/tcg/cpu-exec.c:727:#if defined(TARGET_I386)
accel/tcg/cpu-exec.c-728-        cc->tcg_ops->fake_user_interrupt(cpu);
accel/tcg/cpu-exec.c:729:#endif /* TARGET_I386 */
--
accel/tcg/cpu-exec.c:826:#if defined(TARGET_I386)
accel/tcg/cpu-exec.c-827-        else if (interrupt_request & 
CPU_INTERRUPT_INIT) {
accel/tcg/cpu-exec.c-828-            X86CPU *x86_cpu = X86_CPU(cpu);
accel/tcg/cpu-exec.c-829-            CPUArchState *env = &x86_cpu->env;
...
accel/tcg/cpu-exec.c:844:#endif /* !TARGET_I386 */
--

> Reviewed-by: Anton Johansson <anjo@rev.ng>

Thanks!

