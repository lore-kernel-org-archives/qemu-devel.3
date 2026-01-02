Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93E0EEEC1C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 00:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbSi7-0004ZC-V7; Thu, 01 Jan 2026 19:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vbSi5-0004Y3-JB
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 19:08:05 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vbSi0-0003aN-PC
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 19:08:02 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c2f335681so8804679a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jan 2026 16:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767312479; x=1767917279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rIhi9WhjgbaFWggk+VAtbf5K3E6RZxm1OJZcPwIqQ7I=;
 b=VYUvikQPeHrqCx0AGvuxdw+rhYw0FkyybbOa7TW5cjN/jrau9ov+0AORwcLFYPqBHY
 BI2BDUwAy28tmx4jhOr32zO3l1sKWxIngQQoK+FisafNtXZrl/ruTKF3o723z+2dUSDg
 PG4nGEC4TsMEv+ObGQZ9lHjuMD9UfUWNq2JhFZ500xu4Xj0ckImYyeYhgEDuPQ0xXhzz
 bOmArgKPUSSf7mDGYVNfI0e2zMfyY6ThyWNikzEi9lPxEaL23cheBvBMLGgsrdPkCt9Y
 uLOBdaNh5XtbABBsNF5lTmGntB9ST58uPU1tbsGNQ8Wc9v54ggMkDng8QU58uwSdPXlL
 V5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767312479; x=1767917279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rIhi9WhjgbaFWggk+VAtbf5K3E6RZxm1OJZcPwIqQ7I=;
 b=hk+IEXWJqbqteS/6NG0B4iZQbAwYb0kLwuAFvITzEnJZGQNyECpQdpbwgHrR3lpFMH
 9zzNSMBZBs4DR9UeDFJeUtC7SJZPMLj2+PjRczPF7l/tYupMFgURlqP9P1C7vzmXmyVf
 1NG/G06EyLUmPh6QArRpnwPAWpDnbQCowa3z8lFKLX0ZL05CGdyML6tNaYepD3BdAbS8
 67+/ZIeFK641+WGZw7+ZDHLYy6kYeN4DUQ2g8qfD+xk1B3NJ1jK7PeQiloffjXb6QDAV
 hrP/82TLstPSoE1LycGWqWfP9m7IXZtn29UUGMNhQ/8GmF8BhqkiXCOdSyUxcQmnS32h
 zauw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP7iur3yIN/vXPeAg4Sj3yZ5yCEZolAyxgzA8cRnNb/IOKxc6xQRMg0HwfewgCiNLIn8586OvbChoW@nongnu.org
X-Gm-Message-State: AOJu0YwDTQqq97GciaK31kRZR7DIHTIv7TySnIP/j/6+Cg98Zo0UAnuv
 U7Pk2ASvoPIJhiORaq+bTtBU0mRinhQAxRMAArca+jsyMGm62cGUwstR
X-Gm-Gg: AY/fxX49w+u7rJQa+va2eiiRmr3bs1PyfzJCY4j+DBviWU8e3T2lpimqb+xdqyjMlbV
 hxgHMRGgUJghR7j397D4a1FT6PhMZ56L7aqUw5wwj85DRhLvGsBwIKC1zp2eO1ULnmA9GJ5VTq0
 eySA2UQ5dfBqHUpvJf9JGCr7GYJSYRsdRV5Aa4qaiy4rYu86ocf1RMcQrf/u7HAbKWQjeqUHUzr
 rgrzdU5KnBO1EsLjOy+QgXN52FGokjUDYN4df2zozLFYqxz92RCwg5WyjLprqnjKLl6o/SGxXj8
 Cc4onkeu/hsnCoPiD44UUhkoaRf7h/TiihMVlk2+QCbf3niuyaHCwtg6igiSTv0V+OD6P5rGkxV
 lrtgJ/sQjN28ErGU7jdY7u8/PDltvjLiM7U/ds9JPZQH6GxQKZTjbMRGKIR3lXzAM8Y6i/XIRUb
 CIA4SfaEtXrvyhCV2bkVNFt+2JVjm5IzrLSlaUOcY=
X-Google-Smtp-Source: AGHT+IGDFeLuJtZjEdfw4fAlyrGMuyX5w2vnHKO5/Zke2uqKY3nZiz941Joax1U+n/Vf39YArayj+w==
X-Received: by 2002:a17:90b:4b43:b0:340:e8e9:cc76 with SMTP id
 98e67ed59e1d1-34e92144873mr35188431a91.11.1767312478792; 
 Thu, 01 Jan 2026 16:07:58 -0800 (PST)
Received: from [192.168.0.22] ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e76de1c3csm20215241a91.2.2026.01.01.16.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jan 2026 16:07:58 -0800 (PST)
Message-ID: <43c7dfcf-9b5e-4d2c-89a7-339fb147df12@gmail.com>
Date: Fri, 2 Jan 2026 09:07:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/ufs: Fix mcq completion queue wraparound
To: Ilia Levi <ilia.levi@intel.com>, qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20251222123559.3387-1-ilia.levi@intel.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20251222123559.3387-1-ilia.levi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 12/22/2025 9:35 PM, Ilia Levi wrote:
> Currently the completion queue processing routine in UFS does not check
> whether there is available space. This can cause CQ entries to be discarded
> and overwritten. This series include a fix for the issue based on how NVMe
> processes completions. It also includes a test to illustrate the issue.
>
> Before applying the fix, the test will fail with:
> ERROR:../tests/qtest/ufs-test.c:801:ufstest_mcq_cq_wraparound:
> assertion failed (completed == num_requests): (0 == 32)
>
> Ilia Levi (2):
>    hw/ufs: Fix mcq completion queue wraparound
>    tests/qtest/ufs-test: Add test for mcq completion queue wraparound
>
>   hw/ufs/ufs.c           |  20 ++++++-
>   hw/ufs/ufs.h           |   9 +++
>   tests/qtest/ufs-test.c | 125 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 153 insertions(+), 1 deletion(-)

Hi Ilia,

Sorry for the late reply. Thanks a lot for the fix and the test.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>



