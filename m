Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9666CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc61r-0000ym-Uj; Tue, 23 Jun 2026 14:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc61l-0000yL-V7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:39:17 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc61k-0007Wh-AZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:39:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c88d4606ec8so57409a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782239955; x=1782844755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThMKzJTAG1c5xvEXBJLtS1+3PgM7a6xiZBA3o8LR0ik=;
 b=OQtZbCPtYlivWU4zpspe8aeg2Q2f4WErHuwYa2csxdV+eKPMsOfwjYeKFfGxEqChGm
 6HghqQyA7uUCvZNsc+AH7DqY3cmp4KYRUHcHkb6VxWm/E890fV8qkDXxF1IbaK33CtZ2
 gfC3LVClJgVsqWPZ6cFJWNx8b3AKvA4OsbQqNrv9qRNDh4zMYOG/zD9J3vV/Ezfcgezs
 8pVpoYi/Ka6BzBFD3cJwi5sxdLKvPg0NW/LoKDVliOTb+qi0M9MwskCwifXtBtK83OXT
 sjE/ZF5ameh4HDI0YP12ulNLNOO4bCShB8fg8JiHhmyQbYGzv4HKmWxPreyyyeOHeMy/
 hhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782239955; x=1782844755;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ThMKzJTAG1c5xvEXBJLtS1+3PgM7a6xiZBA3o8LR0ik=;
 b=KtWW5dw8BIO9TYzSVDMaexS9RYnQfY3zn+TcLhetnYUPSIjKF0Uw+kD+EG3e/384P7
 KZ4SNd79H8ZyWJeeMkLA93BN4rQuYl+OtkjsQY/ouG3+MTGX0DQxqF2u/GhNLsFfk2Vz
 RdG42BR7gVSZA33lmWaFqjUehG3mtMX2LBslDgIRg6AS9Z6QnIpTRgd/zdDOZ8pihCaM
 1XsnOm2F9b70Wvfg0eDJwVQtHXjBZa5L9xDDOt2isbYpIHcwXujcOpKo4oXdbx5ZN8eT
 vr+TCB2gilVIhC5dDA6NITRYvy5f/KCeww0Z9g97MmaLCVWeKwyZulefAfCitK5LJF1M
 siig==
X-Gm-Message-State: AOJu0Yw7gO49bSM5DwmmEhiHtNBLJU5/q286TgrHQt0a0mScJtEsjzhV
 6LhFT/YyOxWE19h5kKC5bqgqN82p/s7ivwfkmRS54NYZJGZqJRqXIylDPM1dCac3Q4EH2i8RxS7
 PqqNs
X-Gm-Gg: AfdE7cn3EhbSE3V/hgvR7/bxKJYCmPKumJAfukDLJlyo9J7ov7u2AUPLafJ+LuG3xrF
 lToZMol+0k6Nc4sfFVpzsgXYZPaOeiaZ1RxeJBEZJbXDAfzQ8W232vdCRVHojRDd1QNCB49m2m+
 m/WASMM8UJdBFdL+5VYiPYUEF7etGyV0b0LabMbH3L29747IDKlHY358PGawtl6wj5rDE0XODYT
 SFDFFHkXdQ4exO7v9w6FrtJfzFFkA0X7XhwSP1sYSQGU30J3wrH3ldHR6ZwR11Ko3K5Qp9hp0pU
 0XPZ8+FM2P1w9W3S+uSjO8ySkEHA2HIzN/WJ0dZmU4HRLFSlBhQ127gPwRUoJS7IoufRWp7bv1T
 v3LK/W5+RdPWPn2u1C0KlgnPjvHoUWszlqf8A3+do3uwtptA0VXfzCo4Dr9bVLe//Y4Y17YkqoE
 ksMSntvI4DqdvJVQbY4aX7dmw96/lWw4rUwhlvbOuPikbrVbQ+yY3yVlihVO5Y3Rguu7Z7
X-Received: by 2002:a05:6a20:9d8e:b0:3b4:b216:2b1f with SMTP id
 adf61e73a8af0-3bd191b40d4mr5300665637.28.1782239954619; 
 Tue, 23 Jun 2026 11:39:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8de8bsm10360669a12.6.2026.06.23.11.39.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:39:14 -0700 (PDT)
Message-ID: <f3fc1629-03c8-4d96-9356-4af0c3bd2395@linaro.org>
Date: Tue, 23 Jun 2026 11:39:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/40] bsd-user: Add signal system call dispatch
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-7-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-7-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/20/26 21:19, Warner Losh wrote:
> Wire up the signal-related system calls in the FreeBSD syscall
> dispatcher: sigaction, sigprocmask, sigpending, sigsuspend, sigreturn,
> sigwait, sigwaitinfo, sigqueue, sigaltstack, kill, and pdkill.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Kyle Evans<kevans@FreeBSD.org>
> Assisted-by: Claude Opus 4.6 (1M context)
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

