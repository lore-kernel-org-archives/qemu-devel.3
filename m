Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C27FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 17:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v56S9-0005zl-PY; Sat, 04 Oct 2025 13:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v56S7-0005zO-Fg
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:53:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v56S5-00086W-9r
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:53:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7835321bc98so3368818b3a.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759600427; x=1760205227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y6Q2HRl/SME04nvnRxfsLSBx9qlKBJpScKR3Rt7EIKU=;
 b=ob27k5n5w6uCHHsbYdqItaolAlNCd7R0IS5h2RZjdZ0BVWxoXlSpcEP1DclL5/ejO9
 RK5EoseWGkCb6HkW6BJcn4R9tqMHO355yiBguXUN93TTxdvPXcXkLCaV75Nu1SMm1/T+
 1fEEP44n/sVGZTttilzWdLbn4qtO0wPjiZJ1NY0qsDJJIfkIGpk3+tc/EhLzk1qsb0Zb
 sJ1sibGtPMP+7zyEpHpRSXqPlKYP/VkfsJM+2HLLN6rY2WSDENWf7+vFk1s3kCLc7fo5
 6eAIZEttCkEI6u5cIExM1Bf2zYkpeAgu8/siLxDxA3to71MQcBlyNue7TEsAbvRb/kWf
 2dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759600427; x=1760205227;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6Q2HRl/SME04nvnRxfsLSBx9qlKBJpScKR3Rt7EIKU=;
 b=sIjfZXWGJKNJ4yAYg+7iRk4UO+n9oenjhrDmm/I2lWqgx+qukP7pKMQCMTdhIXfNAH
 SeiRUbw41NMUNrbtTa3SaVTRhH2HPB4mP2L2CqrkY0S/FI6ePzppBZnp1JMhzKAHyhCc
 D4i8sDg5F1OaSx1OC3pBG1G/QZcZ5ukanGiJURVM9spPJ7MZhbvCeHXaDkKz1w7C75K/
 jkQVPkzqHNYPevFXVWeGNQ5QiKD8npE4P8zHay3W+eBq3iCi5wzd8bhJfymb71BULt3j
 Nb0E3OHPmJfmgKx/rbxw+oYQDEk5iJyqbgMF89iWVuHsjXHFMx9hFe0E0mgYCAIM+C5L
 P06A==
X-Gm-Message-State: AOJu0YzeQXRxCvvj+j28+bSNR/2bLAPF6bCdZyYvxnK4pi/rCFtkPdiK
 oKkHhDyo4NERE7ua9JQtNb4l8AlaX87q2AIHhL3GZSToZsFamuuGJ2i3Nok1QpC1del5xlAWb4j
 LUzmVc04=
X-Gm-Gg: ASbGncvvS+14Vcrc+s673b62+cXflCZ7a6HB3a8oyk6r2qzffbpdy+NR1/gFP2UeWSZ
 8Bz28LWeWafdqpgtmfr7o6jkFX9dYzPgKcqNtEhGZ3pLbBSW7J9CNwiPx/5wcRxZDVUvW70mjwV
 rDq/i3wwg19EzdaZZJYKHntVlOMdhhbhu8l8LdhkdE2R4AhNG+nG9O6yHVb43pSFM2gYLzk9pUK
 8RsNhwYGjgalxQ/N/zFdPR0zVUi9UXejqYgj3BxUD4MZ2p0kogXFLyRnmKm/mXdkiJj6Xay6xrO
 6TdOotNLQ3n4u4GXyn5wDWC3FPGvA9nuTqN99vgwiIuSZJ5cQrYnnuN3I00kkez/6Gypy5HCgbI
 NtEtEJ5tNoAZO8wOe47azz4p+pCIC733Q8Sea/sj7TyeG0JhLBYDjGJrVSOezr1n1g08dHQe1RB
 o=
X-Google-Smtp-Source: AGHT+IGk4VS6yBRYbaOtw2LcidIZMu8mLS5iwPX9Xs3/sf6p1el8mm4Vfzst0lOCH066ofAffYjpRA==
X-Received: by 2002:a05:6a00:238b:b0:781:8832:9159 with SMTP id
 d2e1a72fcca58-78c98d3304dmr9047475b3a.4.1759600426827; 
 Sat, 04 Oct 2025 10:53:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01fb16e4sm8008075b3a.21.2025.10.04.10.53.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Oct 2025 10:53:46 -0700 (PDT)
Message-ID: <a46a3fa5-3b29-44fb-9fd2-b4716f952886@linaro.org>
Date: Sat, 4 Oct 2025 10:53:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/45] Staging patches
To: qemu-devel@nongnu.org
References: <20251003153948.1304776-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 10/3/25 08:39, Peter Xu wrote:
> The following changes since commit 517e9b4862cc9798b7a24b1935d94c2f96787f12:
> 
>    Merge tag 'qtest-20251001-pull-request' ofhttps://gitlab.com/farosas/qemu into staging (2025-10-01 15:03:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/staging-pull-request
> 
> for you to fetch changes up to 27cffe16354816d57710d2d4357f16139405c749:
> 
>    migration-test: test cpr-exec (2025-10-03 09:48:02 -0400)
> 
> ----------------------------------------------------------------
> Migration/Memory Pull for 10.2
> 
> - PeterX's fix on tls warning for preempt channel when migratino completes
> - Arun's series to enhance error reporting for vTPM and migration framework
> - PeterX's patch to cleanup multifd send TLS BYE messages
> - Juraj's fix on postcopy start state transition when switchover failed
> - Yanfei's fix to migrate APIC before VFIO-PCI to avoid irq fallbacks
> - Dan's cleanup to simplify error reporting in qemu_fill_buffer()
> - PeterM's fix on address space leak when cpu hot plug / unplug
> - Steve's cpr-exec wholeset

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

