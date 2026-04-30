Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6FBFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISYh-00040p-Hz; Thu, 30 Apr 2026 10:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISYf-0003rE-0y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:40:05 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISYc-0003LO-6j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:40:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so574191f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777560000; x=1778164800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ts9cI2gqtYsZYFh/1UeW4GmwV46pLpuX7ykP8d7YV3E=;
 b=IOdM5gmApTvJyObVWVmCkbVNgIqx0iCb9QsBvaht7uY7CkQU20fkjZwxOBKH7G3W8l
 gskMegf319PmIgwQ7xq+doQ5KRTav9pE4TWHbqGzHRpyMeYm47ckaNkLTroyy428rJvJ
 LWLyzdwrGDfPfCEdaOKXuUgO9VN6/D5oC+j7udS45VNx4poBvG260W5VUEKx6Q05Sxz2
 hGWEMdcmOE0MGz2a+I41PK4OaJv92Z3pTQQAyIMGckPVR5kygIsESAkisyDNz42lGjwC
 l/t9z63i6KrNkH0ZyeIaSlrVW0LE3CzjroYTxbY9bIsOOLhOpK+uLVMcrF66rDvrqlQz
 tQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777560000; x=1778164800;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ts9cI2gqtYsZYFh/1UeW4GmwV46pLpuX7ykP8d7YV3E=;
 b=jwtWcKLE6E9ppnBjrjcP/M09wUDvX2qs6g/mZR+F9GRcTU6M4I/XtoYCCk5Oq0Xiro
 dmR+P4vqxiGyu0HJ1jY0Ya1KepX7CWv3OeU/eSdovkA4LiiJIvf34blHEiDohUNEn1hz
 pOMagALB4baynz/AonP+hcVxkd0K4IqA+rUOUgn7mqhMFCHMCoL5Pdd9Gcznq27H12Ik
 XAc4RCP9uIVGhI5c0gY3bnZwcM/5a1an/VzNadn4GM9/l33EzP1q7Kb9rJc33ZHBgdqP
 AmOq5a8cEes6t92k2qb7M2P015gOhMOK5uZyXR22mPvNbDfHtclqyO1Sq60s8ecfwEYa
 9wbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o/GIesrdj397NtH9lCFIjiUfD0ZHTlYzx1lUB/Oo8ju/oMu2o9MAv7gnInpgdAe56E67MRqKZXjgb@nongnu.org
X-Gm-Message-State: AOJu0Yy2jgjMbKWaUpvP5WD3jvGjMR5pg3BlmqVYfIcbl4dKng3CpO3J
 c5uxqmapZMCeEf0Msw7iw4psuCJRCqkJrz34xfOz8tZMtm04inhnaSMt/pTAOJmrhfg=
X-Gm-Gg: AeBDieu/GGAsOFS7RYBN8zCESlI6agcFYkuNeotcbLAFe1E8L6v3t9a6E8Hk4RWIvX5
 aK5tIjh6AI/cOpBdpd4XwVKobWaexd823oBBSB6NkctlPtBNLVb9gd5hWP7lp2yjM1yfU1PSzvA
 bNgE7PbFu/m2vqerbCx/xKhH0C3tG6DCKyRFC2RtNvMQcoggFJTGj7c0OuEheSUCrwJPViBY6LL
 YPMzXo1nZJRRTKisV23YMsKuhzd/GIXvaeUd7Vo0shyUimYqKEf1mWrynxd6Y+nb6JkAwuywnJa
 SBj1AufSbRRmZOGQhDcS+LYVNmNb9GELeaMHyiqJhR5KKt7MDAZe/jRNYt1rnf69vRns/pFQ4y6
 Xodu2IZ35sKaNfbEvqSqkITjT2osuVIUle98/iVP+yCBOLE8N1o0/2YVULFr2QbtHPgPHsx4USv
 1KpxcMdDdZzEr9q6nBRgUU5Bg9a1ACA0/5DON/u2hBEZal5je/iYl/Lcwa6Sbp/6otzeOl4ZGFW
 5Ve
X-Received: by 2002:a05:6000:1a8b:b0:441:1e1e:a050 with SMTP id
 ffacd0b85a97d-4493ded5902mr5468908f8f.16.1777560000244; 
 Thu, 30 Apr 2026 07:40:00 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d4843bsm13113482f8f.7.2026.04.30.07.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 07:39:59 -0700 (PDT)
Message-ID: <df7125a9-a3ac-4127-875d-b2e81978ccc8@linaro.org>
Date: Thu, 30 Apr 2026 16:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/25] Remove cpu_get_phys_addr_debug() and
 cpu_get_phys_addr_attrs_debug()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-26-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430093810.2762539-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/4/26 11:38, Peter Maydell wrote:
> All the callers of cpu_get_phys_addr_debug() and
> cpu_get_phys_addr_attrs_debug() have now been updated to use
> cpu_translate_for_debug(), so we can remove them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c  | 20 --------------------
>   include/hw/core/cpu.h | 34 ----------------------------------
>   2 files changed, 54 deletions(-)

Yay \o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

