Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDB6C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lFV-0007B9-6I; Fri, 04 Apr 2025 13:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lFS-00074y-A3
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:54:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lFQ-0004IL-IR
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:54:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso1398999f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743789270; x=1744394070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZX0Lr9OVlkNk7na0AoYdrbG7qeo+QcJrYa7Zt+3GDwc=;
 b=W01doRc/fhNvc7HdqR/Wjn5L/PxyV/wFsBBUgz6RfzV3Y2fXc1iZnMPQc0psDBt4Ca
 e24udtpX8d4lXiC8d4JnwDDBBGnGMTvJvOLKyL1FHX6f4LRzhwAgIVMpenfEc/aPXHm+
 ygC5p6Wu4KvR4+q/kMtNDlrvKauOJKeNQ817+mQk1fwtIby/fTEpfTqH5sRBeg+9LWNq
 YWWsF4piYSSaZgj63jXfrQRb3HZpYW+p6JrwNV2nQxQs3pAElxA3JGMy741JRB8agFBD
 SZnGxeBHZZpViTRJ8xxBNikOUq9pl33ThRrrTX/3XkVYSuw2TCjZ0qTP6uyIYKswTXx5
 UOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789270; x=1744394070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZX0Lr9OVlkNk7na0AoYdrbG7qeo+QcJrYa7Zt+3GDwc=;
 b=Si2q2SQOJZTlU1DFOQQXKaXf+MML9ms0yTXj238LsasAlNJbWIGnCSztpJoZbYGWVr
 V7YZecQf/yvKCQM1MfuSvo+GhPUotnfkCpIWCeyxms4OXgvE9pUwUHZjnzuhBZQskfsd
 T6QH7INVhT3Gk4ERmTDct4isdMFSAxMtIljrMsa/+Sj0vUsvxtuvC7bq9R/+U8Y4RonF
 xa7bk/AsW8tZ/HxT7jL8jdd+cjw1TBU50mJZqSkueIYkgSP2p4Tw4XtDzLv0CIS5qS5S
 hb5p5lMFT3s4Zn9eTg78pNLmKOBeyUgVdp+RmkU3iemJhE9o99haz1DuE/PrnPEjDm8i
 hvzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV47+GSz3nWiG5tx2VJJnQXae7RskE5dmqvGh+yGA8tTYs+uKc69E7BTSPWBUMF7zPxPk5eiYi+KH8@nongnu.org
X-Gm-Message-State: AOJu0YysyVikqlPMl4g91U3uNkV6yHeyjHZoCuCYeAFNVMr1f5le3H8l
 eY8H9BPxyvkV30FSD+2smVjq/qIHH/FnlKa7Gqyv2hvIbfFoz7T045ppCRwXOLU=
X-Gm-Gg: ASbGncuisgwldiDP0cA2utyHpQPUwO17l6uwR4v65yGHMo4mp1B58B+gNhQBRLnRAJb
 2Tc449nXd6GjBFj0b+6kZBH7p1zTUSS/D2cOsfSDG9pj7SoMVnJX9mY0SglaHvJ/tv/jGRpFi1Y
 t3HczcJWqf1reMOH9UKNouTSl1/ZHyJtOAHo2D597jI+pcEAHvGcNeBiWq6nBDog2v1bysSk8mg
 TnV5BqUS3mKasSzGQTlN8ujAcrUSNzKLagQZ6P82GcFC2sYBbIYA+49Fro/S7qoVGmBhKuLNH2d
 eEDHiV6FOmn+F6A5AO+MiK1IALISIzP4nK5K3lDdheHJfmd0ctW2S/A2QEqDXrkahLuGuS4T1j7
 Jgiy6/T4ao3pKfqK2tuYrz+3A1Is2
X-Google-Smtp-Source: AGHT+IHzHon+CjY6Q0mOlrdWLbt0C5TsubDgSxfux1Hjx2m77yELTcUCUjjxI2uRYZ5buSjViVzvqA==
X-Received: by 2002:a05:6000:420f:b0:39b:f44b:e176 with SMTP id
 ffacd0b85a97d-39c2e65a08bmr8175710f8f.24.1743789270024; 
 Fri, 04 Apr 2025 10:54:30 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096861sm5023215f8f.14.2025.04.04.10.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:54:29 -0700 (PDT)
Message-ID: <4598285f-a05e-40c3-b112-b2ca5713681e@linaro.org>
Date: Fri, 4 Apr 2025 19:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 08/19] target/riscv: Replace TARGET_LONG_BITS
 -> target_long_bits()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-9-philmd@linaro.org>
 <2fd3d997-156e-4af8-8461-6d03c5e5a9ba@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2fd3d997-156e-4af8-8461-6d03c5e5a9ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 4/4/25 18:48, Pierrick Bouvier wrote:
> On 4/3/25 16:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/riscv/riscv-iommu.c | 3 ++-
>>   hw/riscv/riscv_hart.c  | 3 ++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)


> The temptation is good, but please do not touch any target code at this 
> point. We want to focus on defining the API first, and we can perform 
> codebase changes as a second step, without letting any occurrences of 
> the old macros/functions, instead of just adding "another way to do it".

I meant to remove these patch before posting, to focus on ARM, but
apparently forgot to do so...

