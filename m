Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30889C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVzK-00068s-Az; Fri, 24 May 2024 10:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVzF-00067v-Q8
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:33:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVyw-0003wK-Gs
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:33:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f6bddf57f6so4172255b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716561197; x=1717165997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TyL3b6dgriPwYPv8kypAxbai1ZpI4zhyyboeJzPa1J4=;
 b=V6fap6DgpF7Fx+JgCi23g0qgZ+kgcQ1xYBK6A1LoBhr3OxT9WwaWbLQWLcVT4xrflP
 vQWYrXfBu0fYzFqJea+Pz1+aDOiXk78cpmJabxbBOKL8XrEybwke6c/wyLfbhwYosz9T
 82bXvHBVXpbx86MO7Y8b4EazJ/GYbJmAZqByCFpCFT0CGdeBVKiloPCkhz2vIGRnH2bk
 4kHMb8hkxagWIjHfLuRF6Wc2inR23Bo9E7BODkTqxy3jIj0dBhJOkunfmjzl0pmhv5L/
 rxFZE+qjShDiY0a8ck0+nUq7UXju2GQkI1APTQ45+qkFzowsokJ6m3KZ/a8JCJqJm5R6
 x/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716561197; x=1717165997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TyL3b6dgriPwYPv8kypAxbai1ZpI4zhyyboeJzPa1J4=;
 b=R0anSaPTSMPNWVTF5O0Vz/lL9wsuKOEkcbXjF8tLcU2m+PTaQRjTwXQURccF7b8fZi
 3xbgK3PeVv1BK5AFsQJXAaChfjEXZwN1PcqdsU6OZsw9s8Q7jPKT1XZsc01pf9pbYph5
 jlkbY6TWLLigRIKyOUlIw6EcatBtRxM6yfUZ2APpmUiXeLAD+btkGfA66ap2wuFde8E5
 THKg38byr82P6OWsOWYB7lwzGjJCIlqsxJqFeM8J4vfuuwM/eRRtGWWPgT3Yll1XVs3A
 3m14CGQXtXjkNGa2AgVgJA/oRQAtWyM5d0ragSRodaynN62FDL0RPX3MAaoIQ3JAGZ1Q
 JCCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUvbg7WzAU3vflySLwdkzhRwzPB9fmogYoWwMTabeBoiZf130N1rncrSSlXdhabw5X0MISNqoSPvjr/d2b48HKjDl27Yw=
X-Gm-Message-State: AOJu0YzWSLjrnv/lzlNkuJ/ZIC6XY8qnnoJ1axG1Fu0aM854BeL2zqnf
 +XEF9jnHWclqH8dGYy17u7XZzjHepQaG/IuzT3RA415P9Rmn/0JnMM/VjWrgvxhM0XKCpVJM5Bf
 6
X-Google-Smtp-Source: AGHT+IGa6W3KhVYHbT+hidmoIzBq2g9igBdTEKWmiEfjcGrTEUuTpT/Pm+YvgaVljiNPq+qtj9M+7Q==
X-Received: by 2002:a17:903:32ce:b0:1f2:fb28:9d2c with SMTP id
 d9443c01a7336-1f4497d7a35mr29260115ad.44.1716561196923; 
 Fri, 24 May 2024 07:33:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7b53bcsm14599165ad.90.2024.05.24.07.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:33:16 -0700 (PDT)
Message-ID: <18fb816c-d4cd-4f7b-8bcb-44a20f0f20e9@linaro.org>
Date: Fri, 24 May 2024 07:33:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] target/i386: reg in gen_ldst_modrm is always OR_TMP0
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-9-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
> Values other than OR_TMP0 were only ever used by MOV and MOVNTI
> opcodes.  Now that these have been converted to the new decoder,
> remove the argument.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 33 ++++++++++++---------------------
>   1 file changed, 12 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

