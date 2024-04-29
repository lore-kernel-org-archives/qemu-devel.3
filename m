Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE82C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 01:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Fam-0001nm-UC; Sun, 28 Apr 2024 21:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Fal-0001nY-5H
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:14:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Fac-0008L0-IE
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:13:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso3693973b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 18:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714353233; x=1714958033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bDWSHayx83RC8hrQzKgUcYdiN6Pv+s1X0Oy/tY/CEZ4=;
 b=YJ9QlWe6JOFARmJrJGONY5yVixq7blEQkvZXVar5GUAu/gCx9zLU9v5LUX52VYTtom
 diokyjXXMRWFJf8iNyyDL3iK2wNvg+rP5SbpPFsCip7OvpW69weAzGoYXiceHHKBYma/
 F5a7U39yZwE9UBbGCBtg2cuH+hhHF6b8bn9sp1hzbVySwh2uuDK2dwA3tnR5RdT3NjHf
 j6gjHdFqrMw62uWMyM5dTQjBQ6sHSwqq7YCqbd5oDW0m0MEClFI2YI7eOOC+SnuCnHgK
 95vf8BlJv8j+PBs5R6Ryo5nKScJfCYy7kNq5JVtlYK9r5zIfE4LDaXvM3yAc68I/mAql
 yqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714353233; x=1714958033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDWSHayx83RC8hrQzKgUcYdiN6Pv+s1X0Oy/tY/CEZ4=;
 b=mYWf1YUn8GdcpqFnGprP/O5Az/y5xJcJkHpuY0WEIb5XbR9rjpnHnyPQhYKXYZW4p3
 2ypeldevNxxwbil3GN93MjH8+DOrwdsB+ryv6FPPJWJM5M5QgRCmCYbNSwC2ioIMeqFK
 foCTWPPivA/gLlv0IS8b7r1u5eYojnF3fgvoLRuSGbVCS/sPV4YJnBV15Fvl/GfIM5PW
 3bAWlxNpTtoFjt7dTs9uiKlr9P5hcOko99LX3dUirEbtcLLeWldbLnUYRxGWp2pn5HA7
 gxcAIDDJopx1JY85JrVPYTkZFzDPCZ1IPfflIPwwT7pULQ4jqcl1MiodBguYOUvKvAPp
 cs+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPpSjXu7dssAEgSFrVh+rwJMVPA6j2g76kifLN+NbYbGCpt6jvyyIhMp3Gnz5gQ8xE/tnpNzMf1JGk/fAw2rhQKviMeVc=
X-Gm-Message-State: AOJu0YyacDg6JBFI5umLZA/MAQXHqXP9lDOfA0Rf8Uwj2IxVlcbp9KfE
 E+uqz7hvvO0Vn1q3cdgFzqu7FYavkG4V59ziynR4IzafL5ZfE5WuBXxHG2+BSUc=
X-Google-Smtp-Source: AGHT+IHsqduSLYhu4sOi/Tz+HStUWQI5hPgMcTNvN3szyLLK/rnnZ8M2PKMuiRzf7lH2K8MOhDgv2w==
X-Received: by 2002:a05:6a20:2d06:b0:1ad:5325:d9b7 with SMTP id
 g6-20020a056a202d0600b001ad5325d9b7mr11319668pzl.52.1714353233132; 
 Sun, 28 Apr 2024 18:13:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 jw37-20020a056a0092a500b006ecf0ad97bbsm18730441pfb.17.2024.04.28.18.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 18:13:52 -0700 (PDT)
Message-ID: <48191f0e-a3ce-47a3-ad6f-8f93fa9cfb81@linaro.org>
Date: Sun, 28 Apr 2024 18:13:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] user: Forward declare TaskState type definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
> Forward declare TaskState in "qemu/typedefs.h" so we can
> use it in generic headers like "hw/cpu/core.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   bsd-user/qemu.h         | 4 ++--
>   include/qemu/typedefs.h | 1 +
>   linux-user/qemu.h       | 4 ++--
>   3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index e562adde65..be57374b41 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -76,7 +76,7 @@ struct emulated_sigtable {
>   /*
>    * NOTE: we force a big alignment so that the stack stored after is aligned too
>    */
> -typedef struct TaskState {
> +struct TaskState {
>       pid_t ts_tid;     /* tid (or pid) of this task */
>   
>       struct TaskState *next;
> @@ -114,7 +114,7 @@ typedef struct TaskState {
>   
>       /* This thread's sigaltstack, if it has one */
>       struct target_sigaltstack sigaltstack_used;
> -} __attribute__((aligned(16))) TaskState;
> +} __attribute__((aligned(16)));
>   
>   static inline TaskState *get_task_state(CPUState *cs)
>   {
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 50c277cf0b..36f2825725 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -134,6 +134,7 @@ typedef struct SHPCDevice SHPCDevice;
>   typedef struct SSIBus SSIBus;
>   typedef struct TCGCPUOps TCGCPUOps;
>   typedef struct TCGHelperInfo TCGHelperInfo;
> +typedef struct TaskState TaskState;
>   typedef struct TranslationBlock TranslationBlock;
>   typedef struct VirtIODevice VirtIODevice;
>   typedef struct Visitor Visitor;
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 4777856b52..16d9f6ae8c 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -95,7 +95,7 @@ struct emulated_sigtable {
>       target_siginfo_t info;
>   };
>   
> -typedef struct TaskState {
> +struct TaskState {
>       pid_t ts_tid;     /* tid (or pid) of this task */
>   #ifdef TARGET_ARM
>   # ifdef TARGET_ABI32
> @@ -158,7 +158,7 @@ typedef struct TaskState {
>   
>       /* Start time of task after system boot in clock ticks */
>       uint64_t start_boottime;
> -} TaskState;
> +};
>   
>   static inline TaskState *get_task_state(CPUState *cs)
>   {


