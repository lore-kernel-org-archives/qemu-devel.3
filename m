Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E56C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgeg-00072g-P8; Tue, 19 Mar 2024 17:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmgeP-0006zF-92
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:05:39 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmgeJ-0006cR-SC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:05:35 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so4610258a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710882330; x=1711487130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xLFiRG6i/0q7cUBe44fypC4IiXjI+3Tqfxu8KSDo9D0=;
 b=b2BBTP7w9KbnZLnFqXxeIMfBA5w+NcYzWffWdJzvhFZrzG+5GgO56l1ah539S+7Hjw
 5pnenc7eutQuFHUjTt+GB+zfdB6kt/Zubnp/h782LLWPxonBIQomxmOIofUTDjT0QtL/
 zYZTtUjifwbxm7J0QGGWBLTYXbKLR0B0DrP9IGuwf6RQV2EZY2f4ag57KdRY7SxQyych
 laFgAHPO5icQHKyNIRwrY647lLjf/OrG0kop/cNNEBpJX+5mrOrBwYnDqNEv3JT9AV7q
 miXy6ANNZNJOGaTzsp5brKHzATOVa0Q1MLY+VJs8T66ac40cavU6ziDt8PcjCsW4xViK
 nxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710882330; x=1711487130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLFiRG6i/0q7cUBe44fypC4IiXjI+3Tqfxu8KSDo9D0=;
 b=FVkvM37b4WFJeN+kGgORwVJQFfU21YlXeJlf0lsX0vaOeqQmIUtFWrGNI9DriiQByW
 Y7K6CJyBVee1w753ecAkGd/7I3+Vg/5GtQOc5ykdPjk6RYbVKYgvE1+o5JW2vAU0v5a9
 azWsmhKBrZn+F11yV+KCBY9p5mFMHWBPdVUYvjQkcYg9NIIr/awfBjqghnRDBLCJ0CU5
 EH5n0neK7dahViG7FvU2AHDUSXeSfjbJPU3ogFGWkYvw/m8LS5wmkGgaKdmh/KvMENFO
 CKbQzHpLbzPPvt1pcIE8ng9l3EbKPf3AjN1L6fJFeRt+XlThRpzMI6mddOBQwZAbeoJp
 XRbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW03j4L53lG8Sbx8cA0fDwWg5oVFUF4TNubLLUaLtcCYLDt7KOWZU0KPhJLYcc9lUep6SnFpZePayG7CSvn/UGSVTOdwmw=
X-Gm-Message-State: AOJu0YznSivd8wqQ7zmn6g5Jq9vKt5l6xeSM6g3j7azDfJxDNHI3B3hZ
 pqRjF1EA1UYsHDOxM1516Fn09WKeej/5i3/J6y+GGDmNfosSp7DkPuayhPoJsdo=
X-Google-Smtp-Source: AGHT+IH1CPajUrkShmE1AQ5efMHPaW7klLUPTjnXqS3l630x8KlSSSnYFTKq9kjimwUBeJwBB+t9pw==
X-Received: by 2002:a17:90b:46c8:b0:29b:f01e:b72b with SMTP id
 jx8-20020a17090b46c800b0029bf01eb72bmr12080415pjb.8.1710882330511; 
 Tue, 19 Mar 2024 14:05:30 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w19-20020a63fb53000000b005dccf9e3b74sm9299393pgj.92.2024.03.19.14.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 14:05:30 -0700 (PDT)
Message-ID: <ad0792cc-a782-47d8-9a18-c66883d9f6d1@linaro.org>
Date: Tue, 19 Mar 2024 11:05:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 22/27] target/s390x: Convert to
 TCGCPUOps::get_cpu_state()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240319154258.71206-1-philmd@linaro.org>
 <20240319154258.71206-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240319154258.71206-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 3/19/24 05:42, Philippe Mathieu-Daudé wrote:
> Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().
> 
> Note, now s390x_get_cpu_state() is restricted to TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/s390x/cpu.h            | 30 ------------------------------
>   target/s390x/s390x-internal.h |  2 ++
>   target/s390x/cpu.c            |  1 +
>   target/s390x/tcg/mem_helper.c |  2 +-
>   target/s390x/tcg/translate.c  | 23 +++++++++++++++++++++++
>   5 files changed, 27 insertions(+), 31 deletions(-)

Why is the function in translate.c, not cpu.c (with or without ifdefs)?


r~

