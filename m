Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47516C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTrM-0005zr-LZ; Sat, 29 Jun 2024 04:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTrG-0005yu-WF
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:54:59 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTrF-0007sg-4R
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:54:58 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-376e6c5ce0eso5089435ab.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651296; x=1720256096;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ujM5NeqxIU+FF+Llp0SkjKhIDMNdKBIzCQWyIWYrJIA=;
 b=nzKiM/0hZu8ZW/n71AUmmkRwa/qnopQEmo9BpDZpn1fZmZd5LImwh1ysBjOom5u/Vf
 6C0T6Z/WxNJkSycc13p7XzknG7iWCbguZ87zKgni82Fml4zB+rdBfJaOPheCpTWvEmAO
 6koDYAo+bJo2qgwV42ZqxPPzsiI7S0fkBUAmBUY3YrcUsPD8eOuK/jgJr119Rq4aCMUT
 7TQOUmFrO16fjQBaEbdy7NMEpd0oFP1LEDgUyVi68MPCc63QHKs51pg+d7qG6hzh8aet
 4+h2ojvHPqlDYpREAK7Jd90MRvoXtretpQ3CA6xjckN9JW841/WFr99I6QTy4hL3NSmT
 GJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651296; x=1720256096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ujM5NeqxIU+FF+Llp0SkjKhIDMNdKBIzCQWyIWYrJIA=;
 b=RFjmjgBWgogThpjlQzifPpEfeZzS20OqZYagKEWYXTrPynR5zRTIaaTPSk2mMQz/4v
 ZlyZDuhZFm8jmtCo9pr36BcH0n564EHNHu1Ukxx/TuCa0AVSZLcG5gzOIHizjkycOaN2
 UfeXw2QOIsncbKEdBy2whJFwN7M4g7BCCg84j5/pSlS4jUj55i2cfxzAZIaVfV9FZ6lX
 Sck9+SKnmCAUV2iv2tKmxdC/Rg2D0YLjDAvxg7BRpPp6fL9O2dL3YWFE9b+MjGFPWees
 u0aOn+QuvVp0+wEIlw9bt0T8dOH7JBtQDSPVZ5DxPmGS+zYyNOQji5Z8V/1gV69UaJX/
 siEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8+JTW3N5lZJ5ly6ACeUs8t5/575X0xCEQKeZ7fgR3leEIB07xEBM7dsmElH+YRTloYBh+JwOZjc/ZIPMHpBBoqfwH4Gs=
X-Gm-Message-State: AOJu0YyKLlPheWavK32vufif8gOZXPPQowivOCopUlWNJ03s5AT/UdBb
 kulZ1PjRMRO+Nzwy7wDJkMASJsmaLcX0chiikMm6Q3JfF4lLlg3VaOFrig4TfRw=
X-Google-Smtp-Source: AGHT+IFEtOJ9Iio5NGLvHctjKhp7kJwDIdlO0qtG0Vz93bm0oNGM99zS44ydQIEXmJPVKOTWEMAZQw==
X-Received: by 2002:a05:6e02:152d:b0:374:ada1:296b with SMTP id
 e9e14a558f8ab-37cd0cea1d9mr4803075ab.8.1719651295810; 
 Sat, 29 Jun 2024 01:54:55 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6c7f76fbsm2287731a12.73.2024.06.29.01.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:54:55 -0700 (PDT)
Message-ID: <02efb133-d288-4bbb-8950-48438c929c9d@daynix.com>
Date: Sat, 29 Jun 2024 17:54:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] tests/tcg/aarch64: Explicitly specify register
 width
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
 <20240627-tcg-v2-3-1690a813348e@daynix.com>
 <2438d654-dd76-4555-98a8-52d0fa006d08@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <2438d654-dd76-4555-98a8-52d0fa006d08@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::130;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/06/29 2:19, Richard Henderson wrote:
> On 6/27/24 06:58, Akihiko Odaki wrote:
>> clang version 18.1.6 assumes a register is 64-bit by default and
>> complains if a 32-bit value is given. Explicitly specify register width
>> when passing a 32-bit value.
>>
>> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
>> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   tests/tcg/aarch64/bti-1.c | 6 +++---
>>   tests/tcg/aarch64/bti-3.c | 6 +++---
>>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> This is true of clang 14 as well, so perhaps remove the version 
> statement entirely.

I noted the version because I think it is totally fine for clang to 
choose an appropriate register width instead of complaining about it and 
a future version may do so.

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks for reviewing this series,
Akihiko Odaki

