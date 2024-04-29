Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2782C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SId-0003XV-JR; Mon, 29 Apr 2024 10:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SIZ-0003Wg-7y
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:48:07 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SIW-00070S-OK
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:48:06 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ed0e9ccca1so4387557b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714402083; x=1715006883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hgo9mtmVYGIPJzeu1XSxfSZQOh0K4+RP9mnvcnoF7Yg=;
 b=JDIEd7vFFG69RLQvbD7NigJcdaZ2ICMXWKsOrY29uDiaf/crxw91lQ82gcidplimdG
 omEz0iE8RBMhqBB8nCq5OMXEcmM4gZpd4PaT5mn4wpjNb3ocksRyEAzIRgrdIDOTCFrS
 0Ndeq9blOkPZu0hVxEW5YEOV4lgu3rPP8pOw65X3yxunC4Ie/c0yA8wb5qmn4cVV5uHM
 jNXfoAH5TRaY9eNvHZyyj3pqkDtoeQDwqGwEnBmvPxW2c7LVoTSKY1Q/X0w1bGhDmGJK
 GVpDrq07T5OYCMlotcNsJYvmJ8bQ0sZWi+aA2VHTKPDYc5aiVG7yV8YU9jNT5ITDvVjm
 z/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714402083; x=1715006883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hgo9mtmVYGIPJzeu1XSxfSZQOh0K4+RP9mnvcnoF7Yg=;
 b=pnxGCMUaKRgPmdAcFei96uckWlyVS8romMAfNMOlvwkICwtnySaHKh+qmNhETQmXB2
 D+DEWMeD8tYZ0dsA93VSMbHyXj0yTqtE6fI+rLr6Fy+yUoH5UNZwyYJx9k76PBOObedQ
 JdNQ/ZkTfMMdA5VgA2XukmoVSxyMcxqHisF1GZzrUqxYSfOJJ7qH2zuIJL5y8VPIVIWc
 SPizq0CFQSlm5nnwa9HXltCvZNJMbPCJ20u27rxziP3LvnLcmEh5dSXX9pqsZoHEN622
 UnulNJcYJLZlYatnP8L7wYFyE8Fmyb9juHu/+b9Ra2rtgSkZGlxhFNJxyKdNCeDPqz/k
 hopQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO6YfzpCgcU9tygT+omQPqS3TVS2p8atTUFs/zoVxnn/KkkNxnAfZohhFmHBc7ZcuAXZ4A4Ya9WWRhybwDRCQaRU6w2HI=
X-Gm-Message-State: AOJu0YwmN0qoAhvq+h/tPAhEi9LDXGbN9A8akZPtAsXORqU7ZGTPRpo/
 kuShWWt1Hf83iO3EvNKj8sQJ12ASKuD8IFHGDBRzCZoP/aqS+dEDr+0YVthwa04kQ/jDRbXwGJ2
 5
X-Google-Smtp-Source: AGHT+IGHKOCk8GJicTIZzQCpvyTQO3NskOpaR/gtgITOVeuccQZQP+CaHSis9GmHRYgCtoaKSbfSIQ==
X-Received: by 2002:a05:6a21:3e04:b0:1ac:3b6e:3e4a with SMTP id
 bk4-20020a056a213e0400b001ac3b6e3e4amr11909474pzc.9.1714402083086; 
 Mon, 29 Apr 2024 07:48:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 bn9-20020a056a00324900b006eceb4cb828sm19357126pfb.180.2024.04.29.07.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:48:02 -0700 (PDT)
Message-ID: <98e9c106-ad7d-46a2-b4ba-17910e8d8cc0@linaro.org>
Date: Mon, 29 Apr 2024 07:48:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] accel/tcg: Restrict IcountDecr and CPUTLB to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-16-philmd@linaro.org>
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
> IcountDecr union, the CPUTLB* structures and the
> "exec/tlb-common.h" header are only required for
> TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/tlb-common.h | 4 ++++
>   include/hw/core/cpu.h     | 9 ++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Though you might mention can_do_io also being restricted:

> @@ -346,6 +347,7 @@ typedef union IcountDecr {
>    * @plugin_state: per-CPU plugin state
>    */
>   typedef struct CPUNegativeOffsetState {
> +#ifdef CONFIG_TCG
>       CPUTLB tlb;
>   #ifdef CONFIG_PLUGIN
>       /*
> @@ -356,6 +358,7 @@ typedef struct CPUNegativeOffsetState {
>   #endif
>       IcountDecr icount_decr;
>       bool can_do_io;
> +#endif
>   } CPUNegativeOffsetState;
>   
>   struct KVMState;


r~

