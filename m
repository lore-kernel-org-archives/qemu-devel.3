Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F088D68BF5
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 16:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCLoR-0005CL-HJ; Sat, 16 Nov 2024 11:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCLoQ-0005CB-5i
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 11:38:18 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCLoO-0000tV-9B
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 11:38:17 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7206304f93aso528140b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 08:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731775094; x=1732379894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XfvmhD4I+KmUe4zmGLDYCpnNZFBIScibQeCVWnxTVas=;
 b=QoLgtTz8QShF6aMK2hpGgK2YK4/aH32/iP0IZSZ5Tf5tC6AMyFCDUABx6sjW0aPSE9
 U7MV1+9j4KU5Oi6fnHXyCyTm9JoaZYW9sNrN1fW+T6GBBB3yYW6AKqk4w1Y/b9q4HtH8
 VrZlFtX6YOpp0h+t+GJJX0DhPZNtf80THfqCFbsBJPoHfYxFXDvG8//u6maEsdm8/6lu
 Q7eGnWOOlNSEMw+Z5HRgQ9QAsqt2hntrB8idoTLBLf+UJ7iUv+3v6XDvuF2Soub6uuWq
 0DMzabWOrLwUq8Hx35Hh+bfxWgekTYlpxGTu1CBPCbd7SMfvcXFV+LIbut38USsZHHt2
 qbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731775094; x=1732379894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XfvmhD4I+KmUe4zmGLDYCpnNZFBIScibQeCVWnxTVas=;
 b=HfxEsTXoKl80NPWH+VXIwual6S/wps2T+/kMxc0M+CtY8f07DNE3ACnfBD2afC3iP8
 6R6cO5FPtOONDle/Bm9btYUl5m1pEOwJtsXk0PT4atW+difpIyImbicII4MpYlJDLWyY
 +IRpVXFQqtYJ/XQ+BcWUFSiPDOjmZ4+JirzFoJ15tEBJO/ypqwOmht+skVZB7siKiKBo
 8QSt5XfHOjJvfi2cIqCJyQI/LVQjq+hJQ9vweA8MbobnpQuo+6o/He9H2puPMDxGyGRz
 A/DA2BujKqUBPg+0E0cBoOv5sSdj4R1KzOFd2reeAj+L5gLDPPHBmzhzX4VfWMK1vqlK
 aLNA==
X-Gm-Message-State: AOJu0YxHHU3pb8QzNZiyywSm835tMcSbqeQOyAoSdti6GnHacT7iD2ra
 wnKCJy5R4oWwDhIDBDsB0hKTESgGfMRYU4C1P+kaVuk8rwnLeYy3BKXEzs4+s10=
X-Google-Smtp-Source: AGHT+IHIbBYv3O2RB1h0SvxeYOvDsKBZOqxJVCnDSR66rXVqIE+QCycfxhDAtqEj3N/pEs3pIlfIiw==
X-Received: by 2002:a17:90b:388d:b0:2ea:4e67:5644 with SMTP id
 98e67ed59e1d1-2ea4e67588emr968099a91.20.1731775094229; 
 Sat, 16 Nov 2024 08:38:14 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024c0739sm4778261a91.37.2024.11.16.08.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Nov 2024 08:38:13 -0800 (PST)
Message-ID: <792d5b73-beeb-497f-991f-c58bdb3bfb9c@linaro.org>
Date: Sat, 16 Nov 2024 08:38:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] tcg + linux-user patch queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241115205849.266094-1-richard.henderson@linaro.org>
 <CAFEAcA-Og4proAP_LR60B__V-KvSLLaNwE5xO=mF8Qi+W1jPdQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-Og4proAP_LR60B__V-KvSLLaNwE5xO=mF8Qi+W1jPdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 11/16/24 02:39, Peter Maydell wrote:
>> cpu: ensure we don't call start_exclusive from cpu_exec
>> tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc()
>> accel/tcg: Fix user-only probe_access_internal plugin check
>> linux-user: Fix setreuid and setregid to use direct syscalls
>> linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
>> linux-user: Honor elf alignment when placing images
>> linux-user/*: Reduce vdso alignment to 4k
>> linux-user/arm: Select vdso for be8 and be32 modes
> 
> This asserts on the user-mode tcg tests:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8388145379
> https://gitlab.com/qemu-project/qemu/-/jobs/8388145391
> 
> TEST catch-syscalls-with-libinline.so on aarch64
> **
> ERROR:../target/arm/tcg/sve_helper.c:6321:sve_stN_r: code should not be reached
> timeout: the monitored command dumped core
> Aborted
> make[1]: *** [Makefile:185:
> run-plugin-catch-syscalls-with-libinline.so] Error 134
> 
> Does this need "target/arm: Drop user-only special case in sve_stN_r"
> now? (I'd picked that up into target-arm.next but feel free to slot it
> in here if something in this series depends on it.)
Yes it does.  I should have double-checked that was merged, not just queued.

I'll re-spin with that sorted before "Fix user-only probe_access_internal plugin check", 
which is of course what exposes the target/arm issue.


r~

