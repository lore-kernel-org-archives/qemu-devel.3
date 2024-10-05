Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B42CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAUH-0001jP-4k; Sat, 05 Oct 2024 15:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAUF-0001jD-HU
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:30:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAUD-0005Pv-K2
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:30:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71b00a97734so2977920b3a.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728156640; x=1728761440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2RJZ9IPeu78Rs74hWs7/Z2quAP4eaf0LL8T3+q8Ep/c=;
 b=H0ZusDmRAGSeAb4BR8bivTVRkHZjv9OHa+Sje4AFAHYnb51+Y520NPCPzfNzPp6hme
 RK6qCXxQQPNoAiBKrsSTYf1SDJm5lSEblwcNFgAu2jLrQNyBGHH9DZhz+DC6FM9tpaaM
 LU4O7dqcOqAl2SsH1qQs6KauRVUKsLlyl5NLS2kS0bkDY93CgWsGEXCZ/Mivv3V9DmS4
 WU12VB/7jlxRdutdjGCPXeQeLAGoUpvX4UsP0IMcn64yrHq6sxeFFw/AOAoxuXDA7DP+
 aGyzhM/AoymNx8HC5AqlWHZ1nfLAu0K6HoZn/R0y29UcdAC2BtmnuE3Jfj3jDfac4+MW
 fJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156640; x=1728761440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2RJZ9IPeu78Rs74hWs7/Z2quAP4eaf0LL8T3+q8Ep/c=;
 b=jAz47eqaA0Qb31RS3gx/ynh0K7aIheMcX3be5MLqDlXxf5Lf1a/1QnrUBfeG+APcM/
 si4sxhgjxIYAN0eAHzNK5mGgT2Qfbtis7g0VpKuz61vUWFoKTSEL4ymluBGmqOquS95T
 +d//ZbFzEi2XrTcLv7eq7B5bCxTU4DkxSGAhojpwxxJq/sdOX4wyrcJ8EcAQ58shlgFL
 rI7U/wvPt6mhZWcrJSkH9Q6I8a+e8D034VVnWKO/ycjloSHvUGctygXSaWoqcuZ5jl15
 KEl1JOTb0WYRhuhdharZ7TJjGMJdo1xtHKb479L2vCMCsfpu7StxI68CxoSxm6P0DLTT
 pg8A==
X-Gm-Message-State: AOJu0Yx3Nvu6o0roDyA3tWOgANDhviGSpW71o+ClHvFeHIokNBBby+5V
 f0iHqt7cy07hcqoSMxaueFnIxAc2uNDtWYfZFtPkUDPMoecsnbZvHtrxgl6/+mKvNipzy7eg5fc
 J
X-Google-Smtp-Source: AGHT+IE0IuX+tu8rz7Vj/bqDIUeG0v01kFm+QFLuOQBKSMOu7mrwBrqe5M51HRnhoyZBHMlT42FkTg==
X-Received: by 2002:a05:6a21:1584:b0:1cf:6c64:fb00 with SMTP id
 adf61e73a8af0-1d6dfa41704mr11256293637.19.1728156640245; 
 Sat, 05 Oct 2024 12:30:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cd0b4esm1794185b3a.83.2024.10.05.12.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:30:39 -0700 (PDT)
Message-ID: <b828b4aa-801a-47d4-a8e1-81bb5c65266a@linaro.org>
Date: Sat, 5 Oct 2024 12:30:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] qemu-thread: Introduce QEMU_MUTEX_INITIALIZER
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <20240923162208.90745-7-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-7-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 9/23/24 09:13, Ilya Leoshkevich wrote:
> Allow static initialization of mutexes.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   include/qemu/thread-posix.h | 6 ++++++
>   include/qemu/thread-win32.h | 6 ++++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

