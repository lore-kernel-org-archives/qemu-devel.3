Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA0CC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsUQ-0002D9-EQ; Thu, 25 Jul 2024 03:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsTw-00025t-1Q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:01:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsTt-00027t-9V
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:01:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4280854e236so425875e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721890898; x=1722495698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OMG/ajioR5kVp5gUE/XSbPZbqWF3BPUaIvWKHTBzci8=;
 b=C3NK90Au7xzk59IY4khMnIZi3jucy/Z66Z/r0wsJcxhU8rXkMDC0Kq7LcnfpfTuYhR
 RCloUoTSAIJ6AXy2f4qJLOohPMX4D/z0XlJOIu+plqVawk5FWowqtKxw7DXIm8OyZMkM
 O5ddMxGPKky2RL7HDVJ53wtDEfrnU5pux/Io0FbYhH6IE0ueOQLV11QYxA1bZiVqZ8w0
 BOj3YFKjPwnBhIAkuavY70NoRPXJ8GH2XFXUIsEZFMFixVou3w9doOSR7g+hGTiREl9v
 ICZFqyQ/oLvDUi9PmN/p/vP19nghmLSPicB5X6ko2xpZ0x/WZHITLAVlDknFF29+4QuD
 uQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721890898; x=1722495698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OMG/ajioR5kVp5gUE/XSbPZbqWF3BPUaIvWKHTBzci8=;
 b=GcY7Rvvvyj3q5J2FSzmjxus4YCNy+DaFjoAJSDJ6j0BlYcnYI5/Z2GKrchCjlBVWIu
 dcYatnEi7psR3pTlv52cU4L6Rq4FJmI74JOU5g3oHJg3XmFaz8FBxlxF5xL4PSntA37y
 J7jF8Cl+/Fzhhd+/3RcWGnHkbjDqm3EauVwjnh6/ZSkp8xUV98QwfY+tCssT0sbKzH6n
 2OvrSEqshpJcTtjqOLE7Ig5MUldfiaWYB4fEmwfAZlZV+aei6xZzNF8XFnX6M8p17dA4
 nIzv0aQQulqUEZsSYoXBDIXGAENdEKr4VXRcPijUSc6KrcG27RdQYr5UV/sstZyclElH
 gZ7Q==
X-Gm-Message-State: AOJu0YxLsqNotHv3SBDa02GNpcOP6UOx/5BChn15831z9VsV/1gs+mrJ
 dW3qUbwQ3Ow9KozDQ9DJ4PQyL5Nf6Lz1jiYGzslxG5VRg2gaKM18GrwP7/CZIWo=
X-Google-Smtp-Source: AGHT+IEDzli1lX56qcdBIAu5fVMARTN7rpYCVBUvGngvXsQj7/BkqXDvyrDQZjpu7QpRciq69UU/+w==
X-Received: by 2002:a05:600c:4f51:b0:426:5b21:9801 with SMTP id
 5b1f17b1804b1-4280574219amr8850295e9.27.1721890897761; 
 Thu, 25 Jul 2024 00:01:37 -0700 (PDT)
Received: from [192.168.114.175] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573f447sm19542095e9.16.2024.07.25.00.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 00:01:37 -0700 (PDT)
Message-ID: <0d864b83-be52-479f-bd4a-5019425e98b4@linaro.org>
Date: Thu, 25 Jul 2024 09:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] target/riscv: Expose RV32 cpu to RV64 QEMU
To: Alistair Francis <alistair23@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com,
 bmeng.cn@gmail.com, alex.bennee@linaro.org
References: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKN=S9o32K0G8k5NqyMs=Xm+gSNBgnbRi3AjbvOubXoDwA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKN=S9o32K0G8k5NqyMs=Xm+gSNBgnbRi3AjbvOubXoDwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Alistair,

On 24/7/24 04:44, Alistair Francis wrote:
> On Sat, Jul 20, 2024 at 9:15 AM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>>
>> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
>> qemu-system-riscv64 can directly boot a RV32 Linux.
>>
>> This patch set has been tested with 6.9.0 Linux Image.
>> And add an avocado tuxrun test in tests/avocado.
>>
>> v6:
>>    Use TUXRUN test case instead of boot_linux_console
>>    Add any32 and max32 cpu for RV64 QEMU
>>
>> v5:
>>    Rebase to master and add tags
>>
>> v4:
>>    Drop UL completely in PATCH v3 2/7, 4/7, 5/7.
>>    Avocado: Add "if=none" to "-drive" option in QEMU command line
>>
>> v3:
>>    Rebase to the master branch
>>
>> v2:
>>    Remove the line that was inadvertently left in PATCH v1 4/6.
>>    Add an avocado test.
>>
>> v1:
>>    https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00501.html
>>
>>
>> LIU Zhiwei (2):
>>    target/riscv: Add any32 and max32 CPU for RV64 QEMU
>>    tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
>>
>> TANG Tiancheng (6):
>>    target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>>    target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>>    target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>>    target/riscv: Detect sxl to set bit width for RV32 in RV64
>>    target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>>    target/riscv: Enable RV32 CPU support in RV64 QEMU
> 
> Thanks!
> 
> Applied to riscv-to-apply.next

Please don't add the 'any32' CPU type, we are removing 'any':
https://lore.kernel.org/qemu-devel/20240724130717.95629-1-philmd@linaro.org/

