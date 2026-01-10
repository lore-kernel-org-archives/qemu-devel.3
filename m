Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D19D25028
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 23:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veiIV-00077a-CF; Sat, 10 Jan 2026 18:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veiIT-00077C-DZ
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 18:23:05 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veiIQ-0001G3-79
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 18:23:05 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29f2676bb21so47579475ad.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 15:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768087381; x=1768692181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eeCP3Pm4K/D8S7yE12PF53EZ+3C71na7s3BLg2EEPkw=;
 b=xv3LvCwDEi73ykR+raE0kzZ0so2ZKV4n3NqylTZ0NMvS3+WB/hw7H8T1doMyD6nsRE
 hrDAqxEu/9GRzPQMjn4ueoeIRFWiKE+aUiInTKiCboOWp6aGxBFnVmNOp2K+2m6+dlfh
 jLX0F1cMMkjX3GioULMTa21dE3qDANIuNScVWlqRcJZAaP6sZAeZMOJGh23dxEbQvWMl
 QlBDiD8YU8xqkpzXH5kZ470MAwvXcykDM85qxKhAFC5IUvH5Q3EPGi3BN4tawsLscOW/
 sVVqT7kPMzgEtT3GmE6nJe2R+TNzA3jYwCla2U8UC2pbcgOhqwCppuujgRSpAgOiT2qb
 drXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768087381; x=1768692181;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eeCP3Pm4K/D8S7yE12PF53EZ+3C71na7s3BLg2EEPkw=;
 b=BkLmyCjXpJ9y5wzqx4EIo7Nlg/lWV91NNS2JTjaR6s5sgFnE2zOTVZ27WuLQfcGqWP
 5GqTLGlZTJLZ+hvbWa9mrhn05RHLViw1ZWUXkGLm+6I8U9r8Ws9qJUGAklD+YqCTxMsx
 dWhfQvo86KDECjGRlr7d6zW/OxzsAaO3OTR6UydvTwdD6RfxsnMY5XVKcogAvL2uYwAt
 lyMdFacn/NQ3nZ5arOAJi9AjFJVJR09kEfIxq36cC+dPeyjcu/eKss2SKF0jSg5Ewdg6
 BZN/NMndSINlPIzhSSqCarh1vKhbFzopYL01sO6p0dsXxCSsbUT3ODVqVNeYpbo15t0K
 +Okw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNvAuR1M7fAZZ9tUkgRa8aE1aA1KAgiHEKkFfa6JyIVJpDV44ngao46rxhHOKio29Vgp9GBaMFJI7q@nongnu.org
X-Gm-Message-State: AOJu0YwqNWtxtHPubcUWmx9ue3JvleRvHmg7wuNr93Hu+RVqtZD8PzTe
 Pn9m9EfjX/RxLzPsh6UW+FxA+xBbQmrPM51cBvkcgwlxfevNGRcNbWdoT/2ARBli/tBAgIF+NSP
 a+9BaJj0=
X-Gm-Gg: AY/fxX6F2TAfJBTk9lmixkJaaK5UI6L5IT/fU0Tgw9V2nMKMe5udSXsaHL1Slx/47MA
 Vkq63CT41Ern+LVjrQFqI7EHsgs5+r873fZQk0Jy5VBhbjFx8syBzhHmKvVlAIXSW5zA3ShQos3
 eKJUETw9vNQjxIIsQu5CkHY8k8hOUB27tdQ3P1vh4cNdDaHu6swLoE/696iNi9XJoPkgHuNgKrN
 S9uKXA0163Iyvn2g43ER91zeNk9yrdWPQ1+RBag/BlzIca/UfX2I74HBonYADjH2ApW996wzbN9
 RofYFmDwjhyMp7oZeodg7JvmDOVr2fk/Wd1NYZuIP08LthZqk8iLfomzwyCIeR+8PocxHnxK6hC
 F4To2gZj1UYh7pIJer0Va6IdXHQN9r0hw/RB8EjgkAo0Qi6cHwp0SagdjJdR0YgqtKaLjDklbGO
 tWFixB5Sy6KdsTn4pej0Ec4ljltw==
X-Google-Smtp-Source: AGHT+IHqS5I2ox0jEJ3yD9cVzeC8EqM4N9zrnMEEgTBjvLnt/G5N4vrg2TsIxr05R6Qvh59j32c6fQ==
X-Received: by 2002:a17:903:9ce:b0:2a2:f1d4:3b64 with SMTP id
 d9443c01a7336-2a3ee4447e1mr142280255ad.21.1768087380598; 
 Sat, 10 Jan 2026 15:23:00 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c5cefbsm133721315ad.43.2026.01.10.15.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 15:23:00 -0800 (PST)
Message-ID: <a73e7011-d8ae-47ce-84b9-7539e7e18a76@linaro.org>
Date: Sun, 11 Jan 2026 10:22:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] linux-user: epoll_pwait2 syscall
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260109090937.599881-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109090937.599881-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/9/26 20:09, Michael Tokarev wrote:
> These two changes implements epoll_pwait2 system call.
> First is a clean-up so the actual implementation is simpler.
> 
> v2: add the get_errno() wrapper missing in v1.  That was a
> brown-paper bag bug again.
> 
> I also checked the CI/build failure of the very first attempt
> to implement this syscall by Zixing Liu, see
> https://lists.gnu.org/archive/html/qemu-trivial/2025-05/msg00054.html -
> the issue was due to incomplete in-qemu copy of linux-headers,
> which is now fixed (by dropping the old copy entirely).
> 
> Michael Tokarev (2):
>    linux-user: cleanup epoll_pwait ifdeff'ery
>    linux-user: implement epoll_pwait2 syscall

Queued, thanks.

r~

