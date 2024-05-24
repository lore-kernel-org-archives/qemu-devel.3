Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27487C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAW0B-0006rq-Va; Fri, 24 May 2024 10:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAW0A-0006qe-Cd
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:34:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAW08-00043J-S2
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:34:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f33d84eaefso15118275ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716561271; x=1717166071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aOi5DO0ynZrldhHkTnJLJjt3Xy80eq1C4F7P/Jhn5cM=;
 b=RFO4P91gy7TM/bEuLqwufWMB30xgqmKyI2PMVozOKJovwytUt7U9H5nXAasx6i/H4F
 bkOjbOjP/5Y+VUPgaVv5DZMy3gsSLSFFNst4YeNQBVtBcY4wA16rxDWCldG2VujveyIC
 TGfE1QoOryYSerLnQUmSYQDf/n+r4R1/Qt8PTFbw9MA8yhAsQ4ItqDb6GN5R/uGcze0I
 +sZ7e/ShaUZ5T4pJBJpU5Lhp+7u+euoU3PBORgllmsMPXiLaVcpNwVhH69ARMlp/dqEt
 YAXj3r8EmSsgDOxqIY1mbbkdOKjE5cZOfDJe16NLkcHL2atqKLcY8D8Y4qoGWEbq70e5
 e85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716561271; x=1717166071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aOi5DO0ynZrldhHkTnJLJjt3Xy80eq1C4F7P/Jhn5cM=;
 b=Y5qc9ThcRYCafohG+Isv2mMJXbkiGf7cMPGXp7sXtZ7CqKfj462hE+qHUeHB0iXRFE
 QPr1XooxkxEemPbvqaQKcuFQJ2KjQnRoTD3t6PTT+to3CuPX2FJ53xlEJeZ5sp3gzD62
 hm2c7yXF9LiufaYh61fIA1tLPgiXZSrb6c713oVsTk/qWx/mNmVi7V8s86uju8ugNYFO
 dOE8oLEVCZ09nyheZvQbVoiS6KbYAcGxuQy+lXorCdtKoUEknjjvZNyswr/VJfFC05Xy
 lhA7j0aLmv7L7TpBPG09i6bYRrNbYq9TmL1H2g6J8ZDu1/y87lQwyjT3ELyyUIgVEURA
 VNVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZbh2r27pQ91knZk82aZfnrEG+8TG8tHq2+1M5doGo+hU0ED48w4iwT0YXkFdJABVWZzKtueQ/1jF5TavCQQMXNwM6XnE=
X-Gm-Message-State: AOJu0YyC+RZAXSnUCqYT8pkqRI2xG6vxXr3NjDP1FhJoT/qMEQ/v1JoS
 4g9nV7g55P30nXn3HPC4aldkJNQK7iozm5Vz3lffpVjXBOT9Lrhx4mUOScUImLA=
X-Google-Smtp-Source: AGHT+IG3lOXpg3MVjBP5U8lTxcVH2eeeC5wwi940fZiNZPXSWfvhPVxEAvz08RWiQVO8ScXQas8CFw==
X-Received: by 2002:a17:902:e892:b0:1f3:4073:9b08 with SMTP id
 d9443c01a7336-1f4486c6236mr35212245ad.13.1716561271228; 
 Fri, 24 May 2024 07:34:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9a881fsm14485015ad.219.2024.05.24.07.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:34:30 -0700 (PDT)
Message-ID: <cd2172a1-5836-4479-8d7e-49192518d440@linaro.org>
Date: Fri, 24 May 2024 07:34:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] target/i386: split gen_ldst_modrm for load and store
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> The is_store argument of gen_ldst_modrm has only ever been passed
> a constant.  Just split the function in two.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 52 +++++++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

