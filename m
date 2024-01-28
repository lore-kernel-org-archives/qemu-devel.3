Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EC2C46CD2
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 00:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTtIP-0004ho-Az; Sat, 27 Jan 2024 19:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTtIN-0004hC-KK
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 19:45:11 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTtII-00081T-G2
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 19:45:11 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-290a55f3feaso1261020a91.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 16:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706402704; x=1707007504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F7rBobLVGNUalgOF8L/NQKUskxN54oKJXb8lMs5nVQA=;
 b=EdiKCBasEPo7ulOtUjfDMrOk+1q9pcyBxggNadAnQWwR5K878ptVZ2mONNo/o25fEu
 iGlf+cHlLXA2ko3r7miWQ0XJ9jRaanhEHaa6yUHf84YZEzzyDf9rI7I3frAsYA/L66r2
 lBCsYEg5LYKxHAs/p9KTt9B5JFD7+FI/kQBBPq/g3wAvOWj/899jQmCWk0UIdYMpo3ga
 1JjHIeBADQ5Umgya3c3Xzy9xDVwacKV+RAfF7lKRfTlOLNm9M5UK5ggVnkvsx6bvNatX
 HDYi0ZGAvijmcmSiGBXiQoSBp32SU3aQmfJY5XQgpiFNOEmJYJR0YdYqS7p5zHjwCVuA
 Zu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706402704; x=1707007504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F7rBobLVGNUalgOF8L/NQKUskxN54oKJXb8lMs5nVQA=;
 b=E/1vii/J67/ylvFDBB4REX2EfKbBu4XPIbPYJdbJdVk2CsEJwbOziUhfr3MWg3rjrK
 32HhuV+jB3qjlpjsgHzzl3eKcZ3axprO41MGJnLZsWSgMWXDZ/IV9YoGjkRK6Vdyv0qL
 wTNfdQe/fG3SpH/nz0InWDY7qdMeRv2nRMgJc0y32oOa1RnRw/CNj4oPNeYnEQSK88AV
 VNz9vF9OstdlyyN0UU1sz4u1IuF2vdXBupTeNjYnUONv914f5yHShsCtaEjjF9egnyiK
 jeYoi+rtAVKGrOEjX44MEYdGfppynWginXQLkQsAlonwycvFc01avfMgrey7PjrIVCq4
 BmrA==
X-Gm-Message-State: AOJu0Ywx6rkwQZnC0Y6bC8rzBMgYHnvpK/5mvlrpRrX305/7v8Q1XSea
 A4m19lJSGmIMONjwcA6wFyTM6JEnBB9RawOUYzq5d7qNBj9X4gkralrkxkRIB0o=
X-Google-Smtp-Source: AGHT+IF0S+Ra5udkCxuDxsXeQJuJcn9ruDI3fnfeqSAUdMNHA44+oGlD8ydK1Art+3Z2M3ElbLQ7LQ==
X-Received: by 2002:a17:90a:8a18:b0:294:9a03:6d13 with SMTP id
 w24-20020a17090a8a1800b002949a036d13mr1458365pjn.15.1706402704433; 
 Sat, 27 Jan 2024 16:45:04 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5c13:51aa:e666:7387?
 ([2001:44b8:2176:c800:5c13:51aa:e666:7387])
 by smtp.gmail.com with ESMTPSA id
 pb18-20020a17090b3c1200b002954b669007sm616816pjb.11.2024.01.27.16.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 16:45:03 -0800 (PST)
Message-ID: <2a0f2eae-dab0-4235-95ba-310c3cd12ec2@linaro.org>
Date: Sun, 28 Jan 2024 10:44:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] linux-user: Allow gdbstub to ignore page protection
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20240109230808.583012-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240109230808.583012-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/10/24 09:05, Ilya Leoshkevich wrote:
> v1 -> v2: Use /proc/self/mem as a fallback. Handle TB invalidation
>            (Richard).
>            Test cross-page accesses.
> 
> RFC: https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg02044.html
> RFC -> v1: Use /proc/self/mem and accept that this will not work
>             without /proc.
>             Factor out a couple functions for gdbstub testing.
>             Add a test.
> 
> Hi,
> 
> I've noticed that gdbstub behaves differently from gdbserver in that it
> doesn't allow reading non-readable pages. This series improves the
> situation by using the same mechanism as gdbserver: /proc/self/mem.
> 
> Best regards,
> Ilya
> 
> Ilya Leoshkevich (3):
>    linux-user: Allow gdbstub to ignore page protection
>    tests/tcg: Factor out gdbstub test functions
>    tests/tcg: Add the PROT_NONE gdbstub test

Queued, thanks.


r~

