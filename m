Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147EA606AA1F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HMggEgSt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLher-0006gE-00; Tue, 27 Oct 2026 09:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLheo-0006fq-Du
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 09:56:06 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLhem-0001j3-Bt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 09:56:06 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b056d58f2aso38146777b3.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793109363; x=1793714163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NEevmbCnJstUCjW8gLmLnt3Xbl6DJN9C92WzswXg/fY=;
 b=HMggEgStmLRhwSpF7bJ8Jzzt9nL5gbn0yRCwPxB+qrN9DFawrSKgRlKfAcP7Bd1yJ3
 qNPiKBlD8tizNeWfDDlOhqgU8brY8ho8TsihJgJtf+5EEfgdN8hHy2sAT9dcKIBnz5CI
 dK64OaNws4RnuW0Y6of2KSdUAYbuMQ9KoB7gDmhpkXjs/RZge7qslXpb534KkzNU3SfM
 7geRf9OjP7ZDMJcgVzE37epOJc7AKroUGLBgSITD9ZfuIkJH5k2Jg6G/+gHTUWUsHRoL
 RzJsi3gFCF8UZshYItSvcA2Egt9u2Od776mLO/0yxNuWdKZvm1q5pFJMCYP6VZacTOYi
 WgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109363; x=1793714163;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NEevmbCnJstUCjW8gLmLnt3Xbl6DJN9C92WzswXg/fY=;
 b=vF9sJZUnHyulvIC+sOH/tpnc/JRPD7V7FXYlMNKEOpaIvDF4JRWXhZiUlXO93CyRyl
 678Mgt10yfDDM4bDTRNdCfmJV9OypVewjyfYrVyU9N5nIpVvZ2jh2BEg1zgcAQoUlJok
 BKXP20/7ytMdewFJN430BEUssTn39fWQ+LMCLx3x/DGo8IOqHPx2o4HiaSvlpgd2FRGa
 vxAnpR9KdVQtnejfoJ0+uUuRlO6CM9kr3rVyfdGQofsQGK0quP08aLvxXrrtsdgWE0HI
 1+bs84Cau1/e/GIh5Y2ydJx4WcJzsIhTBjOGb7J+rqFmHL3u0UE9rjeSWY7XsiZHV5Ry
 kx6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/oAr5eZyBAyoTJcCcQKJxKXya6td6ISr0nMSebPreC0xPBVH+rFe1ygELRqG63fN3RM+aZpDiZG5u@nongnu.org
X-Gm-Message-State: AFq9FYJIhWDKWbA6PpV1vJWnbG4A3aY/fx02VwfJCNF5pD6QCU4qRWmy
 /cEtg1/hyOEF/xpNm1xsLvyM3cbusDg+SMQ3CHSgMC+kJXXkJNtyTLk4xy9WloRI8b8=
X-Gm-Gg: AYBFou3hR8OcZIuFGh+06JkwCTlJiDhi35+lbOsLqrdLCrZX+LymekxHHCDxGQ8s092
 iS61n0fJmHFO8dXpG0gXfvbFdQxLDlSw3yEp9y3jSIjCWjNWwDp/x1Fxq5S7JjdiScpYmZdD4rR
 Zh0gOtouy26Y7RebE6+NAdkJvYTUPi5PgZ+477sHkLwaklipDdjOoa5zjU6QPvFsgoB0+T3GJBl
 oyZg+w0KRnJ3jL7o7HV6NuYZkWPtUIAx0wAbvK+oAK6soMztKv96xVgZFPJ3oMNlgUkvcdjE5LV
 p4ksh3NtugIQ1tjUgbz+/RfhXXTcqezIgR/4+8QcRPeYU3J5Cgjd4qPoK/Vn8enKuRPKguiurai
 L7u1MdUdHcCIZxXY6J/4ZA3C5tRcy+1rL4PtHbbcOnD/2q/SvgCN43gOZeQ6vhNtI6FBzHA/cK4
 2byOdq3593/xQNZqfF+KJoMuf5ISDcuupw8QRwCVnOWdkgATDeQG+jcNkk2otAXoKNYJq2c3lnS
 38T1jq/xAnBfVJpt1EOWSPTeqdL05odGBGzOPJKT5NiZV01eUa1dRF1AezQ1B0jY/3BGmk=
X-Received: by 2002:a05:690c:2788:b0:8a9:977a:4142 with SMTP id
 00721157ae682-8b166c6ee3cmr43718197b3.77.1793109362539; 
 Tue, 27 Oct 2026 06:56:02 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b19e57122esm11748347b3.19.2026.10.27.06.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 06:56:02 -0700 (PDT)
Message-ID: <e9bf474d-c5b6-4e0e-8aa8-5cbe57bbaf53@linaro.org>
Date: Tue, 27 Oct 2026 08:55:59 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/41] hex queue
From: Richard Henderson <richard.henderson@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
 <60fc7388-5884-4c38-a2ca-5a09a78d4627@linaro.org>
Content-Language: en-US
In-Reply-To: <60fc7388-5884-4c38-a2ca-5a09a78d4627@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1130.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 06:06, Richard Henderson wrote:
> On 10/26/26 22:28, Brian Cain wrote:
>> The following changes since commit 
>> d73149283205645625bfa9fe029cfb68e4c4a9ae:
>>
>>    Merge tag 'samuel-thibault' ofhttps://people.debian.org/~sthibault/ 
>> qemu into staging (2026-10-24 16:09:37 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/qualcomm/qemu tags/pull-hex-20261026
>>
>> for you to fetch changes up to f6beebf1bb08b43d9bb8248ae49fbb9bbd4006d5:
>>
>>    hw/intc/hex-l2vic: find the next pending irq a word at a time 
>> (2026-10-26 18:28:35 -0700)
>>
>> v3: added "serialize config table as little endian" fix for test
>> failure in "ubuntu-24.04-s390x-all-system".
>>
>> ----------------------------------------------------------------
>> hexagon: v85, DSP machines, singlestep, bugfixes
>>
>> - v85 scalar: atomics, CFI/_rb, vector stack
>> - new DSP machines: SM8975 NSP, SA8797P NSP0, SC8480XP NSP0, SA8775P 
>> CDSP0,
>> QCS6490 CDSP.
>> - bugfixes:
>>      - coverity, ubsan findings in semihosting, decoder
>>      - handling framekey w/dealloc_return
>> - handle singlestep exception
>> - performance improvements: TLB flush, l2vic
>> - test coverage
>> - MTTCG fixes: enabling MTTCG exposed races in lock/interrupts and ciad.
> 
> Not sure what's going on, but there are new python failures in 
> functional testing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/17499788773
> https://gitlab.com/qemu-project/qemu/-/jobs/17499572582
> 
> As a warning, I'm now going to merge Pierrick's tcg helper patch set, 
> which conflicts with this patch set, so you'll need to fix that up too.
Ho hum.  Those failures are not your fault, as they persisted across the 
next job.  They appear to be fixed now via flushing the runner caches.

You'll still have the merge conflict though, sorry.


r~

