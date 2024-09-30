Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AB1CEB2CB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 23:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svPRg-00057I-36; Mon, 30 Sep 2024 19:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svPRd-00056n-UE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 19:04:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svPRc-000082-03
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 19:04:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7198cb6bb02so3568901b3a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 16:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727737482; x=1728342282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lhPtAn0FNIgR8zD7aBydQZI2nciEOVwJhYhwxleCpSM=;
 b=AdtutiuO9xoISY0qKfwhVsgK3YX3cBc4Q2Zvrn1N3UdJQczlqOjk2yisTNhB2MlK5c
 3peOcBhNFw3GH0H4o8810Sr2EicvnEL1sp8ijpYeZdyOAu8LTK43Niojx3jraSOFgV7d
 /5Z10buvwCamjw5DuL4oFi5/HvyhOPswof+XGCApAJIG49lJugoK92qr4gT7tMoXAZLe
 4lGNR6nYYP5LNO6DWoWQcySlU1YEC7FklHpwwBvDXsH9Y+os7DjXFnucLwSDNwtJLW4Y
 tFXbc/mUbkPloWql93+E0eZ/VPJr3SYlArLDkFND1L1U0/f7k6X4vwFiC5aDoPkcctax
 vPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727737482; x=1728342282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lhPtAn0FNIgR8zD7aBydQZI2nciEOVwJhYhwxleCpSM=;
 b=cIU1mtgKjuFFNxunkXukLTPgCM2QKL37ICkyoJY9hcs8KDfBJ/LITycRW4JGsC8TpD
 oTg1VVv/Knr61xAj5JvP8eOSK80t0bMULc3q3AGrYXEOj1E93GgcrUXDjfCDyiqJmQ1V
 VjCLssalEvTKPPVsYYdl1zrUE1bIz/UZ2F5PjGZS0Sdt6v421phnuyS/ajJCww9uUd3K
 E38U5V/7URLbnC7RnPTMFaHIybbEJpjedZ+t1OgcZv1u30FDMLAXsgUaOrID/65mTC7m
 rh+L9H64gJDxdIfIB4DYUCOZfS1g9ekdbYVEsksIoS5zIV4cOdDDz1gNewkEp+Xr5j9M
 dSLA==
X-Gm-Message-State: AOJu0Yxp+LbJ+BsySQfA8c6Q4p4JuzjuDktJgNenSGuJx++V6RAJzSDg
 V8+SUaHbJlz+i7l0cv1ZdjjOZCDtb5/Iy5ZOTG4k5kPtmW53zTAcY7/b1nGcLjo=
X-Google-Smtp-Source: AGHT+IGgK4tkIUyAtsqOC3hXi9OR10OvZWowuB67XE7pRB5gSYLCug3DUy0yqqw3gjT4zXa0pFKohA==
X-Received: by 2002:a05:6a00:3d09:b0:717:9897:1405 with SMTP id
 d2e1a72fcca58-71b2605d8c8mr22189840b3a.17.1727737481532; 
 Mon, 30 Sep 2024 16:04:41 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b26515dbcsm6743994b3a.138.2024.09.30.16.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 16:04:41 -0700 (PDT)
Message-ID: <25d74ba0-d13a-4a13-be03-d57f53dd1bce@ventanamicro.com>
Date: Mon, 30 Sep 2024 20:04:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
 <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
 <4e3ab59f55937b846fc214f3c3ca3e15c4afb19c.camel@linux.ibm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <4e3ab59f55937b846fc214f3c3ca3e15c4afb19c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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



On 9/30/24 9:10 AM, Ilya Leoshkevich wrote:
> On Sat, 2024-09-28 at 17:40 -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 9/28/24 8:34 AM, Peter Maydell wrote:
>>> On Tue, 24 Sept 2024 at 23:18, Alistair Francis
>>> <alistair23@gmail.com> wrote:
>>>>
>>>> The following changes since commit
>>>> 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
>>>>
>>>>     Merge tag 'pull-target-arm-20240919' of
>>>> https://git.linaro.org/people/pmaydell/qemu-arm into staging
>>>> (2024-09-19 14:15:15 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://github.com/alistair23/qemu.git tags/pull-riscv-to-
>>>> apply-20240925-1
>>>>
>>>> for you to fetch changes up to
>>>> 6bfa92c5757fe7a9580e1f6e065076777cae650f:
>>>>
>>>>     bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML
>>>> Files (2024-09-24 12:53:16 +1000)
>>>>
>>>> ----------------------------------------------------------------
>>>> RISC-V PR for 9.2
>>>>
>>>> * Add a property to set vl to ceil(AVL/2)
>>>> * Enable numamem testing for RISC-V
>>>> * Consider MISA bit choice in implied rule
>>>> * Fix the za64rs priv spec requirements
>>>> * Enable Bit Manip for OpenTitan Ibex CPU
>>>> * Fix the group bit setting of AIA with KVM
>>>> * Stop timer with infinite timecmp
>>>> * Add 'fcsr' register to QEMU log as a part of F extension
>>>> * Fix riscv64 build on musl libc
>>>> * Add preliminary textra trigger CSR functions
>>>> * RISC-V IOMMU support
>>>> * RISC-V bsd-user support
>>>> * Respect firmware ELF entry point
>>>> * Add Svvptc extension support
>>>> * Fix masking of rv32 physical address
>>>> * Fix linking problem with semihosting disabled
>>>> * Fix IMSIC interrupt state updates
>>>>
>>>
>>> This fails the riscv qos-tests on s390x. My guess is that the new
>>> IOMMU support has endianness bugs and fails on bigendian hosts.
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/7942189143
>>>
>>> full test log (4MB) at
>>> https://qemu-project.gitlab.io/-/qemu/-/jobs/7942189143/artifacts/build/meson-logs/testlog.txt
>>>
>>> The assertion failure is
>>> ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset:
>>> assertion
>>> failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)
>>
>> The root cause is that the qtests I added aren't considering the
>> endianess of the
>> host. The RISC-V IOMMU is being implemented as LE only and all regs
>> are being
>> read/written in memory as LE. The qtest read/write helpers must take
>> the qtest
>> endianess into account. We make this type of handling in other qtest
>> archs like
>> ppc64.
>>
>> I have a fix for the tests but I'm unable to run the ubuntu-22.04-
>> s390x-all-system
>> job to verify it, even after setting Cirrus like Thomas taught me a
>> week ago. In
>> fact I have no 'ubuntu-22-*' jobs available to run.
>>
>> If there's a way to run these ubuntu s390x tests, let me know.
>> Otherwise I'm inclined
>> to remove the IOMMU qtests for now until I'm able to verify that
>> they'll work in a
>> BE host (I'll install a BE VM to verify).
> 
> You can get a free s390x VM here:
> 
> https://linuxone.cloud.marist.edu/#/register?flag=VM

Thanks! This was surprisingly easy to set up and run. Please send my best regards
to the LinuxOne Community Cloud team.

Peter, in fact there were some endianness problems in the code like you hinted
before. I fixed them up and the tests are now (apparently) passing. I'll clean
stuff up and see if I can send a new version of the whole series in the next
few days.


Thanks,

Daniel

> 
> Best regards,
> Ilya
> 
> [...]

