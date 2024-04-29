Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B25FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YBD-00077a-Vj; Mon, 29 Apr 2024 17:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YBC-000757-Lq
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:04:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YBA-0007J9-VN
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:04:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41b21ed19f5so35565005e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714424691; x=1715029491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wW0mbKsEQfjC4yJaa5rCiPpCJkkT+sgffueDCdT0AA=;
 b=b4dfNDK3Bhyrd2YWHUUF9seLZRSs+7B9MCPlVrC5bLC4a0ADOHSevtsCmjZiAc4Xsg
 fFLO52p0Ds7Ja6lY9Ae+IYqcO1elSgKrYfoi7HUVDXZA9Rc5R00rfugIV6b82Rnb8U7E
 WK89+Gzzz50d8EmYPbzme1Wel+zJRwHuiueu8X6Z9Dtwsad6UkIIug2APZl/Rm3pd7q4
 vkRt6+bfnVC8jod3LbYXM7gHg030ClvjUPTr57uBA9tv9kchtl6vSD4kFozGt22L9AOn
 fKUNMCcEgT0QJW1J3ldE+XZXj1Mwp7Iq5dVPbR1TgMP8UjPDClkif3U4IDmGwPR/6OQ7
 ro2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714424691; x=1715029491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wW0mbKsEQfjC4yJaa5rCiPpCJkkT+sgffueDCdT0AA=;
 b=oWvKka6fUj9vMVVAhg63yNlF5fairdeOXTJNoQV3tLWpI9tvdSOo3N9SulbSS3YNOl
 mQD/ga+I+Itf9tc3Pc6mlbNgRYz9bUjEOrq+FqoiLqo4Y3889fRhr+En+ZQNbI6YSHa8
 5jjEo1tsQgkHvWAnAmyuhPu2Gg5zxcdXrOo+jmx1C6Yb0Vy9Il+11LI8e5eBEPj63PtV
 TNY2fw8u+blRT24Fd6gIBXV/stb3uQK4gz1Ik3HUFXD/RhUjaEJe25LYbKp/cXspxGNh
 K1uzxuBMQkz3A8Coa+tgHD9kttMl9b5qhHMulRxGbH5PJcIkhsM51O41O1qLeyt3epMW
 p11A==
X-Gm-Message-State: AOJu0Yy3i44+rQbI5MqkIK9o8yEmf0Zv4i3h+CWNZgt9gsfgOi/v0MhM
 +3wCOfFZ9bt9ul1fnYiRFZWcxSqaBGNfTV/yEGMcsKUjtAD1SiDFO8jPrGXmM2lNNf4O3aYgGpL
 Xwj0=
X-Google-Smtp-Source: AGHT+IHLEfwOZ3+gvcs/zgYAD6ID1FBVDOw6ioUOSbPzjrmno3ahx1zkKmfam2smlU2KHrnXjCeZmA==
X-Received: by 2002:a5d:618d:0:b0:346:85a0:20af with SMTP id
 j13-20020a5d618d000000b0034685a020afmr7279228wru.35.1714424690836; 
 Mon, 29 Apr 2024 14:04:50 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 a16-20020adffb90000000b0034af18ef68csm22561490wrr.5.2024.04.29.14.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 14:04:50 -0700 (PDT)
Message-ID: <1ac02538-5aeb-4a4d-a150-1aad084d4f7c@linaro.org>
Date: Mon, 29 Apr 2024 23:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] exec: Rework around CPUState user fields (part 2)
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 29/4/24 00:14, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (24):
>    exec/user: Move 'thunk.h' from 'exec/user' to 'user'
>    coverity: Update user emulation regexp
>    accel/tcg: Move user definition of cpu_interrupt() to user-exec.c
>    accel/tcg: Duplicate cpu_exit() for user / system
>    accel/tcg: Extract tcg_cpu_exit() from cpu_exit()
>    accel: Introduce AccelOpsClass::exit_vcpu_thread() handler
>    accel/tcg: Implement AccelOpsClass::exit_vcpu_thread() handler
>    user: Forward declare TaskState type definition
>    user: Declare get_task_state() once in 'accel/tcg/vcpu-state.h'
>    user: Use get_task_state() helper
>    accel/tcg: Allocate per-vCPU accel state in create_vcpu_thread()
>    accel/tcg: Move TaskState from CPUState to TCG AccelCPUState
>    accel/tcg: Update CPUNegativeOffsetState::can_do_io field
>      documentation

Queuing patches 1-13, thanks!

