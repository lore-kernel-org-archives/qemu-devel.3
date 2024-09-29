Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB39CF6497
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 20:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv0vC-0007TL-QD; Sun, 29 Sep 2024 16:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sv0vB-0007Sf-Hr
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 16:53:37 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sv0v9-0004FS-KQ
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 16:53:37 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e07d85e956so3225328a91.3
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727643213; x=1728248013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fTFQlkJrJVrpzlGSwxjon+8wlDep549zB/F+gjHjH1k=;
 b=P04QU/lAAAFtBBlvsw6/LyMxy/MLcmlVqv2w9eLN5N2g3PrkovyikxjkQNS7CLOrQC
 coucBRN6TgloaG1WE3lyqfm//sv78uhTAgN7cPI5B0P5+MO/FglglaupjbUjwTvifaz9
 jjrlkpA75CUnQffN5lR71svzCzDjp8o49uW3gCoZDyuiTaOgCMKABftuRp/muea+HCHk
 35ftIbu/tuvKNhASAoAOm0Zvr52gX0MmIIxalsWurbwq3BLl+J95KA20AsLY+hdvehnD
 FlEcoiyK1Oh8oln7OAcWYJEaXkZWKhCcko/iu1CaDVCXQSCat7ulEfmpHTdeHKxJih0G
 D1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727643213; x=1728248013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fTFQlkJrJVrpzlGSwxjon+8wlDep549zB/F+gjHjH1k=;
 b=sU2P1nKjEE+2uoE+roF+L0nHJzMU2acYUtTvpFFDZwTLzMYrz87GH4Yfcd9w0/2LgJ
 TgfCDKHprJkdiECvz4zwGdCrVNhYXoAYKHB+PGhTbboeIJAp0PFqBb5ukCO5dWARWt6N
 RMhWz13T20A+wbRMWfcZp8qsXyFz7R0BAriXxotAgbtfoAiWZrpnF72uow0S1AS2WG1w
 vWJD0gMPgQShKeoxZnlA2eRVUf10ieTUW/HVaPiuZwinmyHB/J/Zae9lp/Xte+qT62Xn
 lxCVQONvRdLZMwZ5AxPSCkibhE91wo1gUT94+uH/zmF+Ws96re0V89Tgrqcy78mC0PMY
 ydzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6mBF3sV+S84k3XlI7Csufs/uVzXb9CrsjM/EZXN/wjuXsg39hqRGrUlp5sEhBFKHInmkD6RcadtgM@nongnu.org
X-Gm-Message-State: AOJu0Yxl63iTGulUWiDNitL4Hc3PC7FpCJtrW8nn1JuYoFILmynIaUaY
 KB8gxxLA0NRGgUUGbSylNqDixPUhrTfg5IqH6/92MMzRps7gJWSzrg42vVnA8GK9aBdkPDelK7X
 a
X-Google-Smtp-Source: AGHT+IGHIOPgVWQSEnL5NI6wgsqyMOKvcBhtcLHjLnrvMbjbARhRfknwEPRgbcjS3D5tnwg0mTnHKA==
X-Received: by 2002:a17:90a:f006:b0:2d8:ea11:1c68 with SMTP id
 98e67ed59e1d1-2e0b8ea0f26mr11759993a91.31.1727643213269; 
 Sun, 29 Sep 2024 13:53:33 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e1bae46sm9832426a91.22.2024.09.29.13.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Sep 2024 13:53:32 -0700 (PDT)
Message-ID: <096029d7-269c-44f8-88d3-6f0c52af58fa@ventanamicro.com>
Date: Sun, 29 Sep 2024 17:53:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
 <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
 <CAFEAcA_nn2fUyo9Pkd8jW2NG1oJLbAJrfiC7sziuhGthqL3=4Q@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFEAcA_nn2fUyo9Pkd8jW2NG1oJLbAJrfiC7sziuhGthqL3=4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1035.google.com
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



On 9/29/24 12:38 PM, Peter Maydell wrote:
> On Sat, 28 Sept 2024 at 21:40, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 9/28/24 8:34 AM, Peter Maydell wrote:
>>> The assertion failure is
>>> ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset: assertion
>>> failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)
>>
>> The root cause is that the qtests I added aren't considering the endianess of the
>> host. The RISC-V IOMMU is being implemented as LE only and all regs are being
>> read/written in memory as LE. The qtest read/write helpers must take the qtest
>> endianess into account. We make this type of handling in other qtest archs like
>> ppc64.
>>
>> I have a fix for the tests but I'm unable to run the ubuntu-22.04-s390x-all-system
>> job to verify it, even after setting Cirrus like Thomas taught me a week ago. In
>> fact I have no 'ubuntu-22-*' jobs available to run.
> 
> It's on the private s390 VM we have, so it's set up only to
> be available on the main CI run (there's not enough capacity
> on the machine to do any more than that). If you want to point
> me at a gitlab branch I can do a quick "make check" on that
> if you like.

I appreciate it. This is the repo:

https://gitlab.com/danielhb/qemu/-/tree/pull_fix

If this is enough to fix the tests, I'll amend it in the new IOMMU version.
If we still failing then I'll need to set this s390 VM.

By the way, if you have any recipe/pointers to set this s390 VM to share,
that would be great.


Thanks,


Daniel



> 
> thanks
> -- PMM

