Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0306C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfUz-0003zA-6m; Tue, 18 Jun 2024 16:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJfUy-0003z0-5x
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:32:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJfUw-0003j4-Ee
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:32:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f480624d0dso46836195ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718742729; x=1719347529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1gnJIKkeYeE59GCBknJMToqb41XXegygF9Kpwwxv6IQ=;
 b=y9nY4SKQOYr/ycvhNHSuymTaLUn1gKMgQ6aj5zrEWlLxiovDeY/UFb9KFp38FoPPWm
 FCeZ54FEZkAL6PeQw2EahYpW6JzWhP2f5C0QclJhXTkIHKnsnHJpuPcPf+PY1evIGu4v
 DZ+J29+QMS98nCIVpuPgfTRq8YmVKvpNpEFDV7GIwUxrrLeTdVPQw9w+ZXWi08XJZ8Ez
 s70JrnX+1ZjMKpqRBGqz43SpqsborQDoliuJUp4a8IpaN2U52sOnnhcpgjfISNbYecew
 xBK8vNoSdv1bHKkCvr443AM8xWPs1vfayHqeT7mrPKXjI0sW+ncYyvJRTnUZmOBmbnVM
 D5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718742729; x=1719347529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gnJIKkeYeE59GCBknJMToqb41XXegygF9Kpwwxv6IQ=;
 b=u2aZ2r4rRrhZJxHwf2rqvLm7SjG/DwDBUZwMpzmiagRv4mlhQWJBMnRDuIIxCdZkpo
 fMXm1fRWcCBKFLOz+Hn2bDL3UV1i9cqm77exzqlrAKYPlZTKxzpUBNGs9MGWpCS3Ruid
 wb2E+ZqVC7DWi4VjjGUo9Rhi0CoctE5+rWu7ApmAFRRhIwlY7x6HtKrDy7b0WyaSqMzP
 awIDvzY+/4QXKPS5pZuCd+kg0ocrIsVbhMwp0w/M3PVWHGR6ZpFSD+BeWTjjAgbKKEJ/
 +umcL/j26lwkZspkNE6rivyq2o4TB+fMFNmEOmyk8n83TEjHUKa/N8qNNbLpjp3RPyv4
 S8fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWMYbA55Wpfe9TSCAIrpoGFOUr0r1zzua2qTlsb2poJGB0xtHarU79Gm8QJU91hCn+K97nR9CshcQAaT3o8/0z4S56w1k=
X-Gm-Message-State: AOJu0Yz0iiSNW31JyjN1cFkuOj8beRh00yXJIHNTP14DhriTwcQa+ghK
 WrMaaJ8nF2H0no5XsyelDmoA9fnXNAthUW0by+032uI1d91RzKIy7ysM4KDnL08=
X-Google-Smtp-Source: AGHT+IEh69eUzk46VwWXixKTdyh41RRrOayr00Hf905U7XYaZq13J45lJziFR9swn9BB7vH9Hd7FPg==
X-Received: by 2002:a17:903:249:b0:1f8:55dd:3c44 with SMTP id
 d9443c01a7336-1f9aa47156cmr8411255ad.61.1718742728571; 
 Tue, 18 Jun 2024 13:32:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e70b52sm102120905ad.88.2024.06.18.13.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 13:32:08 -0700 (PDT)
Message-ID: <68014035-47e7-48b4-b11b-83b219f4ef63@linaro.org>
Date: Tue, 18 Jun 2024 13:32:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/76] Misc patches for 2024-06-18
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
 <5ae93d7c-0fd2-4ead-b903-6b5838e0c24b@linaro.org>
 <6dfa4bb0-e4c5-46c9-93e5-d30f3a26592a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6dfa4bb0-e4c5-46c9-93e5-d30f3a26592a@linaro.org>
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

On 6/18/24 13:15, Philippe Mathieu-Daudé wrote:
> On 18/6/24 22:06, Richard Henderson wrote:
>> On 6/18/24 08:59, Philippe Mathieu-Daudé wrote:
>>> The following changes since commit 900536d3e97aed7fdd9cb4dadd3bf7023360e819:
>>>
>>>    Merge tag 'dirtylimit-dirtyrate-pull-request-20240617' 
>>> ofhttps://github.com/newfriday/qemu  into staging (2024-06-17 11:40:24 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/philmd/qemu.git  tags/misc-20240618
>>>
>>> for you to fetch changes up to 02ad1f5b04bf2941852f405c87535307365f7041:
>>>
>>>    ui+display: rename is_buffer_shared() -> surface_is_allocated() (2024-06-18 17:54:40 
>>> +0200)
>>>
>>> Spurious warning (3 times):
>>>
>>>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>>
>>> Deliberately ignored in ui/ (also 3 times):
>>>
>>>    WARNING: line over 80 characters
>>>
>>> ----------------------------------------------------------------
>>> Misc patches queue
>>>
>>> . Remove deprecated pc-i440fx-2.0 -> 2.3 machines (Phil)
>>> . Always use little endian audio format in virtio-snd (Phil)
>>> . Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info (Phil)
>>> . Introduce x-query-interrupt-controllers QMP command (Phil)
>>> . Introduce pnv_chip_foreach_cpu() to remove one CPU_FOREACH use (Cédric)
>>> . Set arm_v7m_tcg_ops::cpu_exec_halt & mandate TCGCPUOps::cpu_exec_halt (Peter)
>>> . Constify few uses of IOMMUTLBEvent (Phil)
>>> . Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
>>> . Fix inclusion of tracing headers on s390x/TCG (Phil)
>>> . Add few shortcuts missing to readline (Manos)
>>> . Update ui/display entries in MAINTAINERS (Gerd)
>>> . Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
>>> . Fix Standard VGA screen blanking and cleanups (Gerd)
>>> . Fix USB/MTP reported "free space" value (Fabio)
>>
>> Fails testing:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/7129004955
>>
>> qemu-system-tricore: ../accel/tcg/cpu-exec.c:1082: tcg_exec_realizefn: Assertion 
>> `cpu->cc->tcg_ops->cpu_exec_halt' failed.
> 
> Doh sorry, I tested but hit a libusb issue on this target and mingw64,
> tested there and thought this was the only issue and missed that.
> 
> Hmm cpu_has_work() is defined inlined. I'll just drop the 3 lines
> I added to Peter's patch and send his unmodified.

No, the assert is exactly correct, and caught a bug in the previous patch (55/76).
Without your assert, we will just SEGV in cpu_handle_halt instead with patch (56/76).


r~


