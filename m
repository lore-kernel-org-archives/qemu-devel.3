Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EF606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wlfwA27P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSoU-0000zx-M4; Thu, 29 Oct 2026 12:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSoK-0000te-S0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:17:06 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSoH-00013H-Rl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:17:04 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-48ed0b68895so1339598fac.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793290620; x=1793895420; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h8mDuiS0d0rGPBJWHfJNxPhXCB6ASRYdU0JZKRE3iAg=;
 b=wlfwA27PR1HW5bSFs4KhXd9Nix10KnKRKTUhepMIJbxKz2slUlzVycyDcBE26rbZeE
 kn6jFReMyamFCb+LwnLaIPwiGKU8Ejfh7+o9zGOF4USUu+tRUHqSdUjatOJ/LgaOaGq1
 R7LxYLJQU+EisIX2Fe4aangSGfQMQ7Cuema6NmUZ+A+5vdUv5cvVBVd81VVqr3RFBHjK
 A5I0mx5FaVqk7H7I6rhavsneHBq+QNKWMSpXNotxns8GMcjrex+0jq/JyL71PZialcjt
 QLfPm7fRZBPLDyITbyiJnIJ3G65Wg+dbQjYb9xPD6ZQO6Xc+owkYTcxPqYnU9h39t8Zl
 bawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290620; x=1793895420;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h8mDuiS0d0rGPBJWHfJNxPhXCB6ASRYdU0JZKRE3iAg=;
 b=gn9seBmztI5ERNJrpaXo3+6mrmC42CRKkk3JPq0lK5fhljm1wAuSycWr8PQJ83Hv5M
 XHNJNFi05E3Jja6UaoGlMzAHICOfr8zBN/S25vS9JVCgcmY5NOfK84X5AHi64SOx1U/S
 K0TNZxizQkfqnQlFi8PHOu9evNrM4ufPXRk8/ptduI0IugcdFiPqc5McQHKgVXUxWsnq
 iq0IXAisnnSH1KCWrvKiEr0AU+4/lsgbwDO2YdKgj+hILI0+6Ve6WAsCrQcUnSfElT4d
 NAjOKmm+PljE48WVJtOtb6H0d0Hxyu9zXbMNODQvzRV/FpbpgMiFPxdBxAc+wNWgybMy
 W5gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjuqEEiR2SdcV4xF8pnxGU+oF71h3Leu3DtovBShM50c2HmA2fi520p6xCL37Bhb7JFHsYj9rX4C8Z@nongnu.org
X-Gm-Message-State: AFq9FYLKeHES6QK6EeEWupoTbV2uN7RYPa4mdavZSQKxwb2Z7Sg2bcVv
 L9WH7gcHFol0IThLx2ZpIg2EE6BC8F5StwhXlG/hJ3dPwfIRxvxeJ/CuHFndIrmOzGk=
X-Gm-Gg: AYBFou2rYdqODHvPzTdtOVBqcbVhqAELvUYTPBoatQC6JeRnu2wzdYWTJlzdSQ4diyP
 GAHAjWI+WmdNBtmuVeYRicvQEi6Ir5uOYuj7CjOMCWmd7eLqxT7pCb634mFk0P4Y4qD/roL3rEF
 toj+qH/5xTnIxle0R9v6vWZXZNgpMdHw8CSrGYjnRhzQw0pB/wAaCV5+FyfMXGK6kcz9+lV94ZP
 y+3o+XULCEX2agLIchDNV467xyrjnvzp1LYzelsAav81jA4z6KgNLHzYw96zsWTEA0MQ6OPdMX3
 9/D7NOGaeENClPgwYHv0iOxY4TdIJvWpkNJCCuxOF/LhDA52nHoFkONNkFOWDhifX1u9fh0QMUk
 dGcPIl3aAA6mfZDiiUEsdYM0Gha9W6MwdRdcF/xL0wnNPgGWLDbMzSgRneh8Bd24uNpofpyxJ3/
 L2bvd5aPHcPh3mJ47PInKUsC+hV6TywbLkUiwKICtvh44QjmamUEuwSXjzcBpLH9FcPrYGpo10x
 tJ1shF8mj/5QhqHPWZYqNDQcnsnduVNUuzBYPMjopWfxU81Hw0kHiIKYAgW+nlWqJ9gpTiBlbJ9
 gaVKaKmBgDpe+6QlRTkhYXAwIoFobKd0na1kK1MgDI0u
X-Received: by 2002:a05:6870:8116:b0:498:f70a:b54e with SMTP id
 586e51a60fabf-4a8bb57e87bmr4486698fac.43.1793290620004; 
 Thu, 29 Oct 2026 09:17:00 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9022461bbsm236396fac.14.2026.10.29.09.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 09:16:59 -0700 (PDT)
Message-ID: <41e8449f-755f-4308-9b8f-256eed37db9d@linaro.org>
Date: Thu, 29 Oct 2026 11:16:56 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/arm: hold bql when SEV sets the event_register
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029161310.2065290-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 11:13, Alex Bennée wrote:
> There is a race in qemu_process_cpu_events and sleeping on halt_cond
> where we can miss the setting of the event_register which would cause
> arm_cpu_has_work to report we shouldn't sleep. As by definition the
> bql has to be held when we go to sleep against halt_cond guard the
> kicking of the cpus by the SEV helper with the BQL to ensure things
> are properly serialised.
> 
> The other places that set event_register are fine as they are either
> in the same vCPU context or are already serialised by the BQL.
> 
> Also use qemu_cond_wait_bql like the other halt_cond users.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/4660
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/4670
> Cc:qemu-stable@nongnu.org
> Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M")
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - drop pointless cs assignment.
> ---
>   system/cpus.c              | 2 +-
>   target/arm/tcg/op_helper.c | 5 ++++-
>   2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

