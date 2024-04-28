Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2016CC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19cH-0007u6-7L; Sun, 28 Apr 2024 14:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19cF-0007ts-Fl
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:51:11 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19cD-00059S-69
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:51:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so25539285ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714330267; x=1714935067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ef/heoSvXkV3NjaCBSlK26aJKvnoHFwiZuVmjPshe4=;
 b=fwqd3w1bjcUzNoiv4PFDwEdnwR/dkx8bOMCijZ3bfKgic2OpoYFoDeF71uRTQletje
 SItKHQtUwa0Pns4dRvW2owLNmv+cDVrk7K2qccc4yo9kHCaJBKQJRm4qxaHCMwoMI+qc
 KKbKMC68VdRzlTArSGhWHGTN+rXmJ5JKqdTgtnTgXrilYjCR1WRhx1OmMA0Hw2FaoOzL
 ZMt8LxHWQ8rfyYHiL2J3yqA4VVc5QQeuUpNwwfKgBSBPqYizC4ECkTSc385mvB689EGd
 Wdek7mrMwPZqVI/+bS/LRK+oQmNhZICuMSr5UljoiPAEfob2IG4NMR0+HuQrAh6lhYWo
 89Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714330267; x=1714935067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ef/heoSvXkV3NjaCBSlK26aJKvnoHFwiZuVmjPshe4=;
 b=tMsJ3DJ1ORnfMqCTfjI83LezA7eEk6cweOgE3Gi+ROS0BVaLc7vqu0gO4b86MyZjx8
 q6O5ogq5VqggZioWquWDAqmIN1U24eKem+C8OhFwThwdLsnkL1bGz/Eraq3r1K0gD8Aq
 mfQTiTKrCPBpE2ZcHQlhD6bPSBggq7M9Z+8M5Pt5/Rz07xjQjb00sUFL4FXtYIbAIPjw
 7u87jbw/8DkzjwzEXRo+0jhNrr8Ktj+51+Cg1hUD1ppvgu5StBrysFElP/F67hDR+gJS
 amsWTwihhG64eyDZTb58aiQXtFmNaBGtLhV6edbfDS18iC5gz9ZcYGkmobr22ckVkbsW
 Ud2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbZYFpg20cXwPwEDuaJN+JUlAmyjBaP0RLxHSdxVsdHO80ujRsHipqwQvNnwtaIW+xUFDpwdpxWmjve52iX2xSMv5HMWI=
X-Gm-Message-State: AOJu0YxHABb+XdlbuQev5ixZBxfgnpd6rRKWn91NAKdxkzy1feqEFkhx
 O29zfdp79zv3Xte8Ur1A6LDup5cBouR0LHqzE4J0X+lK79bDjakMJ7BXsa5DEIBhRKH2bkfzMP5
 d
X-Google-Smtp-Source: AGHT+IGiw0Ae6tnN2oZ7qj8lGsZbJMNBdniXvtQVg5EFMRWH8cOFYvtxPuZ4MQ9cuxIAkgqUGHzfig==
X-Received: by 2002:a17:902:d48b:b0:1e5:c131:ca0e with SMTP id
 c11-20020a170902d48b00b001e5c131ca0emr7650389plg.6.1714330266935; 
 Sun, 28 Apr 2024 11:51:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a170902e80900b001e7c05cf1a2sm18756470plg.112.2024.04.28.11.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:51:06 -0700 (PDT)
Message-ID: <fbd99f54-c5ef-481e-a184-c17da72b5be4@linaro.org>
Date: Sun, 28 Apr 2024 11:51:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] accel/tcg: Access tcg_cflags with getter / setter
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> Access the CPUState::tcg_cflags via tcg_cflags_has() and
> tcg_cflags_set() helpers.
> 
> Mechanical change using the following Coccinelle spatch script:
> 
>    @@
>    expression cpu;
>    expression flags;
>    @@
>    -     cpu->tcg_cflags & flags
>    +     tcg_cflags_has(cpu, flags)
> 
>    @@
>    expression cpu;
>    expression flags;
>    @@
>    -     (tcg_cflags_has(cpu, flags))
>    +     tcg_cflags_has(cpu, flags)
> 
>    @@
>    expression cpu;
>    expression flags;
>    @@
>    -     cpu->tcg_cflags |= flags;
>    +     tcg_cflags_set(cpu, flags);
> 
> Then manually moving the declarations, and adding both
> tcg_cflags_has() and tcg_cflags_set() definitions.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

