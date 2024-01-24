Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC60EC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 22:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmDQ-0007tq-Nc; Wed, 24 Jan 2024 17:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmDP-0007ti-GC
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:59:27 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmDM-0005En-LY
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:59:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d50d0c98c3so1341495ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 14:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137163; x=1706741963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hPe0gk4VIkRQmcM2nfi8+T7Xyrp8CsTq1wIdhyCiS7Y=;
 b=DGU4NqoNlp1NWGxz6rfqYXa/JhFrLg6c3UeYueEph+pam2A9OBDkbRT826dDF9uY1i
 jUHo2CgQQIGdeCi8OditGOGHfyqtEnzej9BTBWY6ho/APQczzN/AnnGihkVZdobM5YZF
 KFOjG/p1Z/qqb/vmAt1wPgerHYLWx5SNpIYWOEUTNfNxYvcQBOzzlEzJ0eE0BMxMFczy
 /olQinNvo1reLgQLyfqnJzZ061ww4F57FYXbX3V8EfF0O5CDyHv126NMqqjlRFl+h0Rt
 /fXMNbgq5/thvcfocMINE2YXPDI34kWP3dhp7xSfGmMW0puEq35qiSU2OhlmJMUZvY4b
 Pt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137163; x=1706741963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hPe0gk4VIkRQmcM2nfi8+T7Xyrp8CsTq1wIdhyCiS7Y=;
 b=hjJhYFX1BaEmxkJi7IfECakvfWF4cV1Xi1nXSsPP25swTCuHhSSYwKYPcojILfXi/v
 2lCne/SkRbQbIelO++x9XosYQ6lah9Qr6+26fxHrshTQstMN94o8nPPnFnHpMlUJFl1u
 Rmo9X0x08Coct2+14/AlR06rCqkEMp6YsZ9mwHJUd/r1x6AveWtWQ+l43JwOrYoHn9AJ
 rMffCXIldGcH3AE9X+8/v36/p0MtjTuXyjnlVpPsl9nxsl5gTf2s6HIoSk8K+VZgF+mf
 HLYTrVrTLpjcM/88QjsTQlTjs+nyEn3DNbZ1Qibh0eLnHAJrLtkZ1kFlcZVXJQy/7KY/
 hCog==
X-Gm-Message-State: AOJu0YxILKCKXjtePnbCpjVcP8TIGUImxb48ZTIyPTcI8EePcEUYFSR3
 pqJa+j/NW3lu35eCVsQ3Ikt4KA+liqS8BgAFs4PRRnGHre/lpQPLpeT0jaY6/q4=
X-Google-Smtp-Source: AGHT+IGbJH9Y3F9FAm8N2ok8mtb2clidRV5k3Rj6FNAyUahXxzxE7Pv6S8f55FxQ9qNzIPp2PIOd8g==
X-Received: by 2002:a17:90a:fd93:b0:290:d248:723e with SMTP id
 cx19-20020a17090afd9300b00290d248723emr254800pjb.36.1706137162974; 
 Wed, 24 Jan 2024 14:59:22 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a17090ad40500b00290cfffee0asm176910pju.1.2024.01.24.14.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 14:59:22 -0800 (PST)
Message-ID: <00177e2f-766f-4adc-b7dc-6b45f6a22c92@linaro.org>
Date: Thu, 25 Jan 2024 08:59:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] accel/tcg: Hoist CPUClass arg to functions with
 external linkage
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> Hoist the CPUClass argument from most of these internal helpers:
> 
>   - check_for_breakpoints_slow
>   - check_for_breakpoints()
>   - cpu_tb_exec()
>   - cpu_exec_enter()
>   - cpu_exec_exit()
>   - cpu_handle_halt()
>   - cpu_handle_debug_exception()
>   - cpu_handle_exception()
>   - need_replay_interrupt()
>   - cpu_handle_interrupt()
>   - cpu_loop_exec_tb()
>   - cpu_exec_loop()
>   - cpu_exec_setjmp()
> 
> to the following ones with external linkage:
> 
>   - lookup_tb_ptr()
>   - cpu_exec_step_atomic()
>   - cpu_exec()
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 82 ++++++++++++++++++++------------------------
>   1 file changed, 37 insertions(+), 45 deletions(-)

I'm not so keen on this.  Does it really make a difference?
What about simply making more use of CPUState->cc instead?


r~

