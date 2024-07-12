Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B88C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHN7-0005FJ-9f; Fri, 12 Jul 2024 10:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSHN0-0005Bh-BJ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:35:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSHMv-0008PO-5r
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:35:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so16699985e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720794926; x=1721399726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nXTW8Y7xDGTJbltVsZgOeBPaLF5vHVmmMPg9Uy7rRPE=;
 b=L20aIAtxWNEelW8592NsUVVnTh/4kT/HzLuOb9Iikmpm7/5ZFOpOh3sgv8Tv0Q/xLi
 uFCAlpdhmUT1u0ffqfWWuGr/axNujHyHptgcMFz5uIjYeiExAHXkJz7p709I8Iu9xidB
 wzqSbTYDsGmCUQlJG5KX+akm7gUGLaMmtpI5iOzB08NhyejOdwHzk6bMivfqUY8JqnQB
 dj0gd+G1nwON25vGyzuPX6MCtJWmGHoGHGuyM3TLeVU5/HrZDBO0XOfp4Xrbc/xgxn0P
 DwxEFRA0EN98rgy5C1PIN+fkmosRC+0ly9yzMhAPlIfM6tCtz6ISkynzQ8kr3Z5NcAOI
 mGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720794926; x=1721399726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nXTW8Y7xDGTJbltVsZgOeBPaLF5vHVmmMPg9Uy7rRPE=;
 b=ZPsdIEkLA9Lo432q9rTRsfoMu6KkFx7HgxyEMuXSRrTExhdvZFQNWCZAukrC1R1y97
 sjTQXunhFZumx4YxUeBE3XzZO+XOFmZUVTDaG43j69R1ZkRFOZG/LXM+5l1oebh2kmZ3
 c82AVPV0e6UBuu2NjSnPIfsaTKUNkqfz5//J4S7wF41w7UcEP4zuBF3mkc6ORT0pP5sZ
 o/aneZ1MKGjx4+XOTKomlYEwzuJXSCcIZUvYajzTp7dY8WzHLq9VuH5bQhFQOpWTcGL1
 W+3rHkP58m0yefWqs+nA/91WaSuQobuupCDjsCRdbg8GIQZ444OlpTTX3lwH8Uden6aT
 vfoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYPuM8R0Y5eMJN3CXTUr+OyaTaECoKjZQmkOWtINeHvIH8dyxiw0oI4Hz+4SsLvWT99ksKH8Q3GcjcxlqvCU5Xkh+Wy64=
X-Gm-Message-State: AOJu0YzFLbebOAUSqYN0K+oMTF5CNz/D/nQ9G8eSi+qMKueExOpWAWD4
 D8EO0SrGB2J+7Lt34V+uw57q9zoUcxs6qt9aNryiUxp90ZGqHMVyR3cI0aihNP0=
X-Google-Smtp-Source: AGHT+IGme2LdP8pchxf+Iq1C31H0YvA4kgw7N1rnjXKJkEl8MwLR/QeQXiYmRnXJ/05OBacjyF3GYQ==
X-Received: by 2002:a5d:67ce:0:b0:367:9020:51ef with SMTP id
 ffacd0b85a97d-367ceadd5e9mr8968676f8f.64.1720794925994; 
 Fri, 12 Jul 2024 07:35:25 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr.
 [176.184.54.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde89198sm10250898f8f.60.2024.07.12.07.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 07:35:25 -0700 (PDT)
Message-ID: <cfe56e1e-a9c3-4ab3-a857-7c0d08d5c9cc@linaro.org>
Date: Fri, 12 Jul 2024 16:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/19] system/cpus: Add cpu_pause() function
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240712120247.477133-1-npiggin@gmail.com>
 <20240712120247.477133-17-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240712120247.477133-17-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/7/24 14:02, Nicholas Piggin wrote:
> This factors the CPU pause function from pause_all_vcpus() into a
> new cpu_pause() function, similarly to cpu_resume(). cpu_resume()
> is moved to keep it next to cpu_pause().
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/core/cpu.h |  8 ++++++++
>   system/cpus.c         | 30 +++++++++++++++++-------------
>   2 files changed, 25 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


