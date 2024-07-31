Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64F0C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 04:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ0yE-0000pF-Kx; Wed, 31 Jul 2024 00:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ0yD-0000o5-Qu
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:29:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ0yC-0002Jd-DD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:29:49 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso4664696b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 21:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722400187; x=1723004987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RrcvB/2N6QRAt7REXOCYL+sKYE9m4S4VffXyA3NgLUQ=;
 b=jhcWjdOFM5APHEOqYDl2qu6ii20qff4vMMDCAbzhcGnOqyUrMxYCbJN/UVmqnrlIo2
 3cc1L1zCqtTwaif/7COAvOXSTeEpxKul8rw87wyPhrrdBLt9A7DgaJ7tYEZUId8aLEtI
 6hnObuhSiBqhgBAkXXRz690/xGGFdR/+F4YdJFzbAvA+TJvT3jrcc0yguNs3d/RE/X/x
 0J3xZFqM6rdAEuijKi6fDWkk7Xn/nClveqtIpEcU1/wIObP0L4kfYlz+gYm6tgsUGeUP
 iijM5zujWdxQccS5XUeOIfMMQZjYRJmMFyewsIRGY5BPTVnH7k9psjrBjFwsZYbNrAL4
 +lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722400187; x=1723004987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RrcvB/2N6QRAt7REXOCYL+sKYE9m4S4VffXyA3NgLUQ=;
 b=crcOggTUKy+E0a27tugMdEpeOI5QZ/Vpx46C2zm4Z42G3/opnkjO8EuhVibbAhP87s
 Fq8ZcqAchcZ93rNE4kbjAU24XGOMx1oYsm4OWyKdYdYgJeE6VK6kZdOz8h8Mxbqi7p6k
 bT4kdqOE7S8EgavJOLOqgAbCRLARZmmR5EtMJlYlqmVk0J2iPj02JAg/FcxesSYqbkv8
 by3V8qkcxyAtldIfKVbFMNgJgvEy13kTFfJLbjNdBUBoBMTyDgNkxw9Qy9mT64jrrpop
 mxJrAPT/8t1nhF1qdXtm9QhBAnTpgqrD0d6TznYpsO56f/uODxFSLAHLaE/okb4RgIKq
 pFhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJDriniXfaBw3gr1coCSUHJJeL5nHCknjIZ0YcCv47JW8n2FOOeD3OYKwfdo29pUQ4/USrDRaDuYRv3+o3ppvaf7TX4NI=
X-Gm-Message-State: AOJu0Yy1K8VF27FvCyyHGps7eYSJ8CzOc6/39aiGvtYdafbdUt87Zeah
 v/mkatMlIQNyKMhFNkHPsdMxyblk1rlJ8NsbSSNOjYUq807RVmKBu1stP0VllcU=
X-Google-Smtp-Source: AGHT+IFeT58ktmjImyJ6aGv87PT6HOHzCZ1z1xmoGqWW6y/KEwZGs4Wzp57IEwAoX1UZI3sJs8mxww==
X-Received: by 2002:a05:6a21:3483:b0:1c4:818c:299d with SMTP id
 adf61e73a8af0-1c4a1179127mr15376064637.11.1722400186570; 
 Tue, 30 Jul 2024 21:29:46 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ce6869sm110715255ad.78.2024.07.30.21.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 21:29:45 -0700 (PDT)
Message-ID: <b1e5571d-1b61-4ef0-af52-10bcdd2487a1@linaro.org>
Date: Wed, 31 Jul 2024 14:29:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 1/5] hw/sd/sdcard: Explicit dummy byte value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org
References: <20240730092138.32443-1-philmd@linaro.org>
 <20240730092138.32443-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730092138.32443-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/30/24 19:21, Philippe Mathieu-Daudé wrote:
> On error the DAT lines are left unmodified to their
> previous states. QEMU returns 0x00 for convenience.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/sd/sd.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 07cb97d88c..c02f04f1ea 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2478,20 +2478,22 @@ void sd_write_byte(SDState *sd, uint8_t value)
>   uint8_t sd_read_byte(SDState *sd)
>   {
>       /* TODO: Append CRCs */
> +    static const uint8_t dummy_byte = 0x00;

A zero doesn't need to be static.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

