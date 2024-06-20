Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E13C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMPf-00070h-Gf; Thu, 20 Jun 2024 14:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKMPe-00070S-EJ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:21:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKMPc-0001Go-U1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:21:34 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6e5fd488d9fso852163a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718907691; x=1719512491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lYybmh9Ei3+1TAs+4NB3zFjNe3lIw6ds/Q6O3NNq/Fs=;
 b=QpOgkBEsyEtmkUTinV7dCnOOZHylp8ASmDiTXp4GuBXkqy/tIeFMZjUjRUDq/gzWTx
 AWED15B9p/rW9YGpSp0X/pTW6JF8nUX2+xoPscMEabYJJkCkwFmqe0u3Z6g+iRxzHIwT
 EORo8ccaiMF5w+/COpYq5Kw5FVClO8TOsKJimsqdKd/nK4Nw+DcWu4a7VBoSqnGzIlKL
 YPFj67TGYJEz2igslIsFhv7bYP7iggyP1a8ZariWVrHiDkU/N+LFNdqjP7ELQlnEpgYn
 gMwvyB/vbpnaJQNduNbPXzAthRCaaZUDDRX/xkIlWeRflPalsLMUPUR8Ut3uprhGZ+DH
 5ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907691; x=1719512491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lYybmh9Ei3+1TAs+4NB3zFjNe3lIw6ds/Q6O3NNq/Fs=;
 b=iIxT7jJDRUdvv9ahLLpnj0tPrxglUq7pD6RdG3j2O4z0SwUS9tLkl8kCCdRWIU/suo
 IQgPZWQM247QjAe53ktT03BJd9hduUb2fPtGJwRUyE7B/ZyDON7vJMJEsmt/zd/fc9B9
 T1tZOtCCzwMT/s5G19pIqIFfxHUWCulMjB9m5eKVrL0JAazoLljLfSv9bDFpCT+1lBTs
 w4KLQYrhOgV5xKuWorKqBmaLxpPz82fO0fTczEjTXfYCw+0eD61GjZq9lYLPCWlue5Vk
 WewhY2YDn0qW3LiYxmz2pH1xfeoNhoYabiBsZqBmc3N+faKwjFOLHPNAwKQQUB/YhTu3
 qs2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzfm/r/JCt3qzf5ikwBrbyqF2eDEGQbzlTaHK0i32mXFDx46YsWriqdgk4fu0HJ2J+qljz8Z+8roAFRIVgRobbwg8aIQU=
X-Gm-Message-State: AOJu0YxRQpv/33/LW8675SmWtBz7NXY6DO9KjsqdsjsEy2iq09+70HFy
 PLpLNnL5J1SaZ4/gFi+Dkmz90438Q1qdtiEswdmRj3KEqi3IysDoYuEH5q814Zo=
X-Google-Smtp-Source: AGHT+IGB86C88pOYbAKBa8c6M8KJ7rxQrgj+2DN4VmCoDmX4rlHi6Qt5VdxKZQa8M5ppTR1YS94c8g==
X-Received: by 2002:a17:902:a503:b0:1f8:393e:8b9a with SMTP id
 d9443c01a7336-1f9aa3faf67mr56947325ad.33.1718907691174; 
 Thu, 20 Jun 2024 11:21:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee6f01sm140888425ad.153.2024.06.20.11.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 11:21:30 -0700 (PDT)
Message-ID: <2af6449a-f4c2-422c-a92b-cfb11a5ae2d5@linaro.org>
Date: Thu, 20 Jun 2024 11:21:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Move initialization of debug ID registers
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: philmd@linaro.org, peter.maydell@linaro.org
References: <20240620181352.3590086-1-gustavo.romero@linaro.org>
 <20240620181352.3590086-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620181352.3590086-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 6/20/24 11:13, Gustavo Romero wrote:
> @@ -1268,7 +1268,10 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
>       cpu->isar.id_aa64smfr0 = t;
>   
> -    /* Replicate the same data to the 32-bit id registers.  */
> +    /*
> +     * Replicate the same values from the 32-bit max CPU to the 32-bit ID
> +     * registers.
> +     */
>       aa32_max_features(cpu);

I think the previous comment is more accurate.

There is no separate "32-bit max CPU". There is one "max CPU", which supports both 32-bit 
and 64-bit modes, and thus has both 32-bit and 64-bit ID registers.

The rest of the patch looks good.


r~

