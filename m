Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B506C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 17:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticdY-0002MV-Mn; Thu, 13 Feb 2025 12:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticdT-0002Cz-Qb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:04:25 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticdR-00076f-E8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:04:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso17778165ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739466259; x=1740071059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3KA77/kqES6vJjGvL/XmPfJ4oK7CnZj4zzZ3KQdyNk4=;
 b=M+DGtNpew7T6Bu9QKONT120fyCKNWzO3T4vSVxriTjHk/cWMcvG81nUGtkA0Hzacdw
 BCG01VF0jyb+400HwvV7TF5v+zS2wN3qXYqR96zfZs0xmiAmsICi8HJZGybgheiAl/O7
 NPec2B95gHFSlMJTUcLCc+bKh+LjmJrA9CHUl5ERRMs+BWO0Gw5W4CBQtwy+E4TInkug
 wKp4ZzbF4lUJPw5fLLJ0KymsDhG5H7KUi4GkP4MTWymouGzx9vIO9k+WObWOT7axrTQE
 tGXK+3HkD8SotyVJ6XEMoga0H1XN4Zt+uNHdVb27yP4j52mNy7/JEbNoe3vnEtgD9MRo
 de6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466259; x=1740071059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3KA77/kqES6vJjGvL/XmPfJ4oK7CnZj4zzZ3KQdyNk4=;
 b=MZpKPtGAa0KOzZaL3vMv4vyKt/B0oQp1s+H+lHKAcpZIvcMT/gZct2OuNoYyss20lV
 1yAlpsn2Nv+pWZMwdAYbLdTfn+Z5Ydnj9HbdiUQFapHhB8I1L08diLHPQSvg7d2NoPgs
 aY+6dyJQal/nddBrxiX7M67nFgcIInJha3OGX6TC0AzuzlWKLw2GsFMxXU3bO98WCs8y
 qOtFuI70P7LqXeDz91mt/7DWR6Ref/8/9ujq0YpVNj+eiw2pFKsCg8cimzMxVX6IGSfv
 0ztcuOMSwC8MnYNfdEvFZx2FrcsN7Km/qTV31161drLykKsQlp09Q5mE7dgBzl/5rAyp
 +7xg==
X-Gm-Message-State: AOJu0YwXWd1nzPJDXfRH8P409LLtCEncZ5fkIyNpw0uz31kyUrt4tcjy
 8lRt27TSjcEFHk6MM/zfyKR+tZsmUDEaBLAsY87W772qfNVoLnd4RZYdjkPer2OJIlRms9d/9Ju
 i
X-Gm-Gg: ASbGncv9O8WTSeqRFdD+RCx2hIqgev3iaPaab0ggUTrKcOrYvTjFuEY4M81/RmG02Ib
 Nrw4zWlR7bxkJjiJjIqk0p8a5s7pB5lAS9qd6ceSrmJz5gzBTCiVXse+qOLriHMx+5Oyo3JbdoE
 xfmKKa3KW1K/d5e59X5FKPABpLU6UU14Z9MuViqlbn9b85bZdA6soyXHy855vc2MkvoU0Li9B6K
 roqhbuoFh6BI0EnMe3pfwGPy8FKdaJ1TjvGPQUY2qhFOuITsJO0xMxLSLhHWOAvjFDvucyaJO58
 7M7k3Lmjyx/kMhHfJDR/yM3LAJN0zdoYU0Js6lfNttbKV7ow5Z9gesQ=
X-Google-Smtp-Source: AGHT+IHflHX1ralawknS3pImqtRgIAo125f6g8uOgphtNSGCVld+t/pysGXJxTPtkFBWBPznRyIVlw==
X-Received: by 2002:a17:902:e888:b0:21f:6f33:f96 with SMTP id
 d9443c01a7336-220d33c0cacmr62421985ad.6.1739466259569; 
 Thu, 13 Feb 2025 09:04:19 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348f12sm14795745ad.46.2025.02.13.09.04.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 09:04:19 -0800 (PST)
Message-ID: <651745fe-e32a-4388-8154-c718173a0e0d@linaro.org>
Date: Thu, 13 Feb 2025 09:04:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] hw/timer/xilinx_timer: Make device endianness
 configurable
To: qemu-devel@nongnu.org
References: <20250213122217.62654-1-philmd@linaro.org>
 <20250213122217.62654-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250213122217.62654-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/13/25 04:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
> DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> 
> Add the "endianness" property to select the device endianness.
> This property is unspecified by default, and machines need to
> make it explicit.
> 
> Set the proper endianness for each machine using the device.
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   hw/ppc/virtex_ml507.c                    |  1 +
>   hw/riscv/microblaze-v-generic.c          |  2 ++
>   hw/timer/xilinx_timer.c                  | 43 +++++++++++++++++-------
>   5 files changed, 35 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

