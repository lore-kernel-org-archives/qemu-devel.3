Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FD0CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAUv-0002Z0-68; Sat, 05 Oct 2024 15:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAUt-0002U8-1X
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:31:23 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAUr-0005T3-HE
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:31:22 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e18aa9f06dso2300164a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728156680; x=1728761480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yk+xDusrUm4vJIOmxpzAbuL6CKJSHOqdORFFssZef10=;
 b=cCBM3ynVSc9i+rFwuyH7rfIFBXZPeVv9Ho7n9Ag3hNDr2uiewquGi77yX4UF+XkwSK
 4tviqMuLq1VykaqKxiZgoq3eWwabdLTN5SflojiU4lXiqfiS8THPZ5AwrQHpFJ6JNqw6
 gdSSC7qGIQsFInoPilJUSo9zVXLBKVuKS2mD8iIGzp7AiveQj/8Qs2ODwiIGY1oiDESx
 SMqObSQ8vWjoBQBNarqC14KMV1cqmQmbpyrmN9yFFUnKaZm2CeNkfgk/JqM+7/qtVGtg
 kA0mqCpiNw50fhRIah1hp2AQOulbncLvdiThHswhwQp3Rs1uXgc/yvBaibbu5izxDFWW
 6RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156680; x=1728761480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yk+xDusrUm4vJIOmxpzAbuL6CKJSHOqdORFFssZef10=;
 b=pRuUBOvLEl0E/hZL8OmLRTci1bitelN11mjVN+0xnUf49otQlEWSXWgRF71KkXHBeU
 PjfY+bZskrMIm6rmh8LtI4PGP0VNcvIvR5UQMHjIrSxBTdGZTdRRoBOYMGE5AmpXLuXD
 rC8R/vc4+1JS+L8uPbGfYnJLS3kWYsatYU/Dru/K3BXtTepnwLBBlvs8vr94R1pBjebQ
 aZGygjnxHN3PWoQJcvtSRLD5QLTZJqsqT79gyW3CzPRWM2P+RELoo1q8fkj7w4+gH92M
 C7g0S6aZQKaTQ7+KaF5jCAM6fK7m/Wfu3q84P5+8+ld45pX9+/Hp1lKZ1VbAgCbQQG1g
 sS2A==
X-Gm-Message-State: AOJu0YzQbnrCM+fOIZuj/c5PDYCmxO7/k9TXh5kW4WCysQhaveiSVtxv
 LKY/iha2WxPnkBoAeTqMVP5QKIxLrudtHABUKWsdv1a2qdhZK5La2cuHfM2lUX4=
X-Google-Smtp-Source: AGHT+IEkyxW3fmHv3huPw89eyqr/jn25qkB4sbaGE0y5JoqkbMyGiNGCSTgBwV6N3QxFdekxz9E2Aw==
X-Received: by 2002:a17:90b:108:b0:2d8:adfc:b3d3 with SMTP id
 98e67ed59e1d1-2e1b35ebf10mr16857839a91.0.1728156680041; 
 Sat, 05 Oct 2024 12:31:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e60a39aasm2731043a91.0.2024.10.05.12.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:31:19 -0700 (PDT)
Message-ID: <0326313a-4122-423e-b02e-c65f12e4ccea@linaro.org>
Date: Sat, 5 Oct 2024 12:31:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] accel/tcg: Unify user implementations of
 qemu_cpu_kick()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <20240923162208.90745-12-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-12-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 9/23/24 09:13, Ilya Leoshkevich wrote:
> linux-user and bsd-user have the same implementation.
> Move it to user-exec.c.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   accel/tcg/user-exec.c | 5 +++++
>   bsd-user/main.c       | 5 -----
>   linux-user/main.c     | 5 -----
>   3 files changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

