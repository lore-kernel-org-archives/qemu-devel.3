Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E59C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MmM-0004Y0-Cv; Fri, 10 May 2024 05:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MmL-0004Xp-9d
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:43:01 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MmJ-0007ip-S9
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:43:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34d8d11a523so1153188f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715334178; x=1715938978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQzZTZdJSm8Nmq8HILM3PNirrsLGQ2TIjaHN8g+Slj0=;
 b=P1JgHU4/s3REZoTO4KyUdcPql12ZbG/ZAUhrqZWY+gspHIljp9364liUldyM6CqPmm
 PS4qWaG6zcsozUJQPfFPKGhCKggq7zRM00a95k9NLrbQ+v3b7K5dRu6naAfaOAVycNp6
 dqCx/pc2vxy+9w7S3LcOOtsozKBSiDuUGZgdpaA62x2X8M4Cou+/OzPHAPADJ5F6b0Se
 oKMUY4G8q8Dy9eBxDVRnWQnsVc2rgL81vQZ0dd+RCQK+BU2gMEn/vF1gcTiQonySXUzA
 mKxSroV4nlUNl1SxUCQk96g1bKTtWEkILL5Dk9fH2HiQAPADdCW9jPoK9PLNnZoHG5gC
 xGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715334178; x=1715938978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQzZTZdJSm8Nmq8HILM3PNirrsLGQ2TIjaHN8g+Slj0=;
 b=pYRc9dzKc7g7lXTvEtZUthmBAiTUMXND+Cku6yLoYz9uc0YyGQhlZzyryY2Ec5GMte
 Z1Fwnz8QvjreTrtVvkGH41y7Yhf3q4SPT/LTZr00qbQJk1OrbkvpRiItFN1bJpYEkOSm
 qQjmMEUNnw5IEIafeSNN/Q+1HNORD1K+xD9EVC9LgKkyigc3P5ZvvrYgCFpenbJHaOBS
 3/uW7AkKdbY5Rlpcl0hybAS8kZbq5dXoilanCOTRJt+E37ZXWoaTj2IoN3xlPzy5H/GZ
 8rFBkVbkxCQk9IrP+AUJ5hxUH0ijDdCWy/M+wU5BizrYht+Qws3/h3GMZdsbTD/kp8xv
 tPYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdFokfLRA9ksa5C7aoiINyEKbScJ02n5fyYEpkFQ7uIMU7ERx16D23H+8SuYAvCebxO5u8jw0RQaAGRYkdqsoXwwPZJdw=
X-Gm-Message-State: AOJu0Yyw1K9OIGc5pI33UzrWJGLuk3EWpw4+clqbzPUzhJE+eOmohRpN
 Aat08hvKoV2rHRYoFIsN7bQP+BX7mRizjZMQji1ANDuygeXhBgfdRCkwsb7lSUW5/yAqdMsqH3z
 JOYM=
X-Google-Smtp-Source: AGHT+IFprgrGtOixlMfEr0Kiv+APsssU2Be92N3RwgXnbBCcmhOn8WfiBcMWfenfuhWbLt+5IZ9CZg==
X-Received: by 2002:a5d:5448:0:b0:346:85a0:20a4 with SMTP id
 ffacd0b85a97d-3504a73db7emr1423882f8f.34.1715334178134; 
 Fri, 10 May 2024 02:42:58 -0700 (PDT)
Received: from [192.168.51.227] (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad0absm4047602f8f.69.2024.05.10.02.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:42:57 -0700 (PDT)
Message-ID: <4b45c823-f278-44a0-a98e-176032c8765b@linaro.org>
Date: Fri, 10 May 2024 11:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/33] disas: Split disas.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-19-richard.henderson@linaro.org>
 <a73858d1-c744-4a9b-b688-098e5dda9e12@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a73858d1-c744-4a9b-b688-098e5dda9e12@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

On 5/8/24 17:26, Philippe Mathieu-Daudé wrote:
>> @@ -2,13 +2,17 @@
>>   #define QEMU_DISAS_H
>>   /* Disassemble this for me please... (debugging). */
>> +#ifdef CONFIG_TCG
>>   void disas(FILE *out, const void *code, size_t size);
>>   void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size);
>> +#endif
>>   void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
>>                      int nb_insn, bool is_physical);
>> +#ifdef CONFIG_PLUGIN
> 
> Although implied, could be within the previous CONFIG_TCG block.

I thought about that, but this was the more minimal change.


r~

