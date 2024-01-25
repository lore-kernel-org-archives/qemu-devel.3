Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB20C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 04:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSrd1-0002vQ-UL; Wed, 24 Jan 2024 23:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrcz-0002re-Fi
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 23:46:13 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrcx-0004Zk-8O
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 23:46:13 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e7e2e04f0so68671705e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 20:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706157969; x=1706762769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZyqofPTExVY5+AUvxwvkWlwvtNGB0iFAXRO/yw5vUE=;
 b=WMO/NIf5iQNAV2Bi8PkfDs1+Yoy3mcQ0qTqWRNmFdY/V9Lx7RYfmz33NALdSp88YNf
 RZxc5/LMhz4sSsEyCGzgEQ6CyNSwBxt/RK+6m01gQfH1TO6qIbATpanWqJzmTjaEaOM+
 fy+8FaR5G2EjhviPFziz8VUOy4yYda73GCW2SIxMJQYW7PuK3hG1K2F0iO1v7ZR9PXl9
 V4IqjMNsmItKfH8fj+atlPmqxCjmKQCTATgsfW/BzQdyy4zTt5jD3RcQMMU/Fh/yx2/4
 IqzgmyQJfsRExUrCQydApfoTO7FOTU6EiU1/OOc7R5cP/EvySFOcbBS6TQ2eFxGO+laY
 U2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706157969; x=1706762769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZyqofPTExVY5+AUvxwvkWlwvtNGB0iFAXRO/yw5vUE=;
 b=i0lzhn2etDhYYOkG0zlmcVQVCfpqETKeo8DiRezxH4MBTXYSuY4S3QM/1dxKLSTp/A
 Z/sm4RnzmdjSUGOqfth26u/Vk3dUCMExVPpDN4EX7v04kp9nCstnhJY8FfvucoUpqh7L
 evENKygde870Pq2haAtfadPbGmukkU8yGr/o2Ob7BKcQrE3/eMjXcCpFG5OmkLCk9avj
 DGQrHgLOs51Vihx/TH8y6/xbgFWM7SdIEjsc8yZ9GysnmtiFW4kfOhLyjO4QWb3wyzHY
 ZlTp8AHOc+W/x/QaTlvVvFHNa1mk7W+vMABOZ6L0lPlCmGLBftEvb48VPfoGpT3UHwSn
 w0dg==
X-Gm-Message-State: AOJu0YwTXfWXadydFWmiTqd5Pqd+TqP5jBYDesliCgKMOi4XQvG7YOXT
 96ghr5zm3CS2pwkIoCamj19HSu+ZbykEv5pnW5CngCJTJwwf/Txl0rYy1i9necQ=
X-Google-Smtp-Source: AGHT+IHn4NSTcR7zU7h6T0ENR1igZw1VdvphTM2Jfh+nzsYvYAeyTxJ0NWU/cybMT23GE/M/wwiyyg==
X-Received: by 2002:a05:600c:c0e:b0:40e:c564:a9ea with SMTP id
 fm14-20020a05600c0c0e00b0040ec564a9eamr1258408wmb.20.1706157968767; 
 Wed, 24 Jan 2024 20:46:08 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 df10-20020a5d5b8a000000b0033947d7651asm4750596wrb.5.2024.01.24.20.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 20:46:08 -0800 (PST)
Message-ID: <2c5bb08f-8cd9-4c4e-b2b8-39d93daeb03a@linaro.org>
Date: Thu, 25 Jan 2024 05:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] accel/tcg: Hoist CPUClass arg to functions with
 external linkage
To: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>, Markus Armbruster <armbru@redhat.com>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-6-philmd@linaro.org>
 <00177e2f-766f-4adc-b7dc-6b45f6a22c92@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <00177e2f-766f-4adc-b7dc-6b45f6a22c92@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 24/1/24 23:59, Richard Henderson wrote:
> On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
>> Hoist the CPUClass argument from most of these internal helpers:
>>
>>   - check_for_breakpoints_slow
>>   - check_for_breakpoints()
>>   - cpu_tb_exec()
>>   - cpu_exec_enter()
>>   - cpu_exec_exit()
>>   - cpu_handle_halt()
>>   - cpu_handle_debug_exception()
>>   - cpu_handle_exception()
>>   - need_replay_interrupt()
>>   - cpu_handle_interrupt()
>>   - cpu_loop_exec_tb()
>>   - cpu_exec_loop()
>>   - cpu_exec_setjmp()
>>
>> to the following ones with external linkage:
>>
>>   - lookup_tb_ptr()
>>   - cpu_exec_step_atomic()
>>   - cpu_exec()
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   accel/tcg/cpu-exec.c | 82 ++++++++++++++++++++------------------------
>>   1 file changed, 37 insertions(+), 45 deletions(-)
> 
> I'm not so keen on this.  Does it really make a difference?
> What about simply making more use of CPUState->cc instead?

TIL CPUState->cc... Which makes me wonder why this isn't handler
generically via QOM macros.

> 
> 
> r~


