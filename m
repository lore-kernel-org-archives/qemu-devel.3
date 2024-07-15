Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B8EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHHr-0007PL-49; Mon, 15 Jul 2024 04:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sTHHq-0007Nc-0r
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:42:22 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sTHHo-0003TI-29
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:42:21 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so2288446a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721032938; x=1721637738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CGDhaG0NpDJG3bWBLY8SGx5YYH/4JmtjwzsnutvPFJI=;
 b=Qj1fTwWvCxW7yjmgHyLl/cFSKEcBPyL1s7WTgg8m8xAYhW+pCm8l4ufR66K7sHMkZV
 9dnNqSIUpFVrtWfz8y/KpMEUXdoZOMiLQqFrt7jk+8Zx5WQ687LyQbbKjdMtp/I3CBoy
 EpYNb6j0/fJJSFB43qx7+PEnrQuJ0XB+qgSxCQuQ6GvVGvxhODEdNUkLAG9wfIzuxOIg
 2TQt2HlMpAkCfLs65FvwGNTooooiNe1MD4Wq8h3E7D8e5r7/7N1WeTZ0mVQbbMEqiwL0
 2ooCT5iouZNDZaaiC7vdYGouzizo36RQjOFt2VrWU99gUrZB2WIBHcLjJHVaj32sF1BS
 uCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721032938; x=1721637738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CGDhaG0NpDJG3bWBLY8SGx5YYH/4JmtjwzsnutvPFJI=;
 b=U8W+TTJwQ47ognh6kQ8MqhV+wJtoB6ZhHHbnYjQehkRZMozxTK4+e/wj4i6+WY2HiY
 ePl6af4lVrsRSL4R6YH79nSENiPHR6CdSz+nW6ApCYDSbO6xwhtohdqCYcYUoTiemjXy
 DiIDGAO7ZWzA3TD25B/S4p/aYI+95kPV1pyQ4uvXNTgS8HT+A8bWyZl9vpFso3aQp9n8
 Nnp8Rwi3ajocnFGxhTp8ubVsRazNTBal7E5ts7t14lEVvb+q9zBoidQ2hp0sojf+HqKf
 DiuX+3Xix1NA7OX85JBoeN8EGOW4lU+wZmzmyobpX/s6RwOpxuO95btc6BAYkZ/+DKLX
 Y5Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU520V9gRJAvXRGlkFNjx7OTWz2kTnrmMxzYFZFEnnBuvLnalMmrNCwrx7TmNJkKQ3vAmdTeNZr/+H7b7YsYCuyFConJ4o=
X-Gm-Message-State: AOJu0YyrLDgfHVxAWEQrJdhaoZki+31yIJnmo4dQtELQU5BNcR+ioQAk
 Oe5yWVMqhZn9OgWPuMJ6TXEpnLGbMoT60IlvCutK5g/Sqs524FeYKYwXK1842ltXbEUcLvHL5BF
 4
X-Google-Smtp-Source: AGHT+IE2tnvEMRZziG9kMNf/IX5ggC+D8w84DG8KgfX8KDcH4aa1P7mO9s3Sz8qk2/jZXilAyESgKA==
X-Received: by 2002:a05:6a20:9f49:b0:1c3:b212:3326 with SMTP id
 adf61e73a8af0-1c3b2123388mr12570740637.8.1721032938151; 
 Mon, 15 Jul 2024 01:42:18 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd2d056bsm5862952a91.1.2024.07.15.01.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 01:42:17 -0700 (PDT)
Message-ID: <76ed7965-f496-4c23-b5bc-e09b28412575@ventanamicro.com>
Date: Mon, 15 Jul 2024 05:42:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] tests/avocado: Add an avocado test for riscv64
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240710022430.1306-1-zhiwei_liu@linux.alibaba.com>
 <20240710022430.1306-8-zhiwei_liu@linux.alibaba.com>
 <fd2448ed-072f-43da-838b-995beb73be37@ventanamicro.com>
 <77745ae0-ad0d-4bd0-8b01-b40795206e89@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <77745ae0-ad0d-4bd0-8b01-b40795206e89@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
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



On 7/14/24 10:29 PM, LIU Zhiwei wrote:
> 
> On 2024/7/12 17:52, Daniel Henrique Barboza wrote:
>>
>>
>> On 7/9/24 11:24 PM, LIU Zhiwei wrote:
>>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>>
>>> To regularly test booting Linux with rv32 on QEMU RV64,
>>> we have added a test to boot_linux_console.py to retrieve
>>> cpuinfo and verify if it shows 'rv32' when using RV64 to
>>> boot rv32 CPUs.
>>>
>>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>   tests/avocado/boot_linux_console.py | 38 +++++++++++++++++++++++++++++
>>>   1 file changed, 38 insertions(+)
>>>
>>> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
>>> index c35fc5e9ba..6d2f3b05cb 100644
>>> --- a/tests/avocado/boot_linux_console.py
>>> +++ b/tests/avocado/boot_linux_console.py
>>> @@ -12,6 +12,7 @@
>>>   import lzma
>>>   import gzip
>>>   import shutil
>>> +import time
>>>     from avocado import skip
>>>   from avocado import skipUnless
>>> @@ -1545,3 +1546,40 @@ def test_xtensa_lx60(self):
>>>           """
>>>           tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
>>>           self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf')
>>> +
>>> +    def test_riscv64_virt_rv32i(self):
>>> +        """
>>> +        :avocado: tags=arch:riscv64
>>> +        :avocado: tags=machine:virt
>>> +        :avocado: tags=cpu:rv32
>>> +        """
>>> +        kernel_url = ('https://github.com/romanheros/rv32-linux/raw/master/'
>>> +                      'Image32.xz')
>>> +        kernel_hash = 'a7ced5c38722481e0821b7cd70719cf53e46c13b'
>>> +        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>>> +
>>> +        kernel_path =  os.path.join(self.workdir, 'kernel.riscv32')
>>> +        archive.lzma_uncompress(kernel_path_xz, kernel_path)
>>> +
>>> +        rootfs_url = ('https://github.com/romanheros/rv32-linux/raw/master/'
>>> +                      'rootfs.ext2.xz')
>>> +        rootfs_hash = 'dc25ab9d4b233e8e0bcf7eb220d56fd2008fe263'
>>> +        rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
>>> +
>>> +        rootfs_path =  os.path.join(self.workdir, 'rootfs.riscv32')
>>> +        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
>>> +
>>> +        self.vm.set_console()
>>> +        kernel_command_line = 'root=/dev/vda ro console=ttyS0'
>>> +        self.vm.add_args('-kernel', kernel_path,
>>> +                         '-append', kernel_command_line,
>>> +                         '-drive', 'file=' + rootfs_path +
>>> + ',format=raw,id=hd0,if=none',
>>> +                         '-device', 'virtio-blk-device,drive=hd0')
>>> +        self.vm.launch()
>>> +
>>> +        console_pattern = 'Welcome to Buildroot'
>>> +        self.wait_for_console_pattern(console_pattern)
>>> +        exec_command(self, 'root')
>>> +        time.sleep(0.1)
>>> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo', 'rv32i')
>>
>>
>> Nothing wrong with adding a boot_linux_console.py, but if we could add a tuxrun_baselines.py
>> testsuite instead I think it would be great.
>>
>> I believe Tuxboot is now the preferable way of testing a distro up to boot in QEMU. We have
>> all other RISC-V CPU boards and CPUs tested in that framework. It's also faster to run.
>>
>> Here's a diff adding it:
>>
>> $ git diff
>> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
>> index 736e4aa289..589c7f254b 100644
>> --- a/tests/avocado/tuxrun_baselines.py
>> +++ b/tests/avocado/tuxrun_baselines.py
>> @@ -533,6 +533,22 @@ def test_riscv64_maxcpu(self):
>>
>>          self.common_tuxrun(csums=sums)
>>
>> +    def test_riscv64_rv32(self):
>> +        """
>> +        :avocado: tags=arch:riscv64
>> +        :avocado: tags=machine:virt
>> +        :avocado: tags=tuxboot:riscv32
>> +        :avocado: tags=cpu:rv32
>> +        """
>> +        sums = { "Image" :
>> + "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
>> +                 "fw_jump.elf" :
>> + "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
>> +                 "rootfs.ext4.zst" :
>> + "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
>> +
>> +        self.common_tuxrun(csums=sums)
>> +
>>      def test_s390(self):
>>          """
>>          :avocado: tags=arch:s390x
>>
>>
>> $ make check-avocado
>> (...)
>>  (01/21) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i: PASS (22.32 s)
>> (...)
>>  (14/21) tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_riscv64_rv32: PASS (10.34 s)
> 
> Hi Daniel,
> 
> Thanks for sharing this test way to us. I'd like to replace our test with yours. And this commit will be authored to you.

Feel free to use this diff. A "Suggested-by" reference in my name is enough :D


Thanks,

Daniel

> 
> Thanks,
> Zhiwei
> 
>>
>>
>>
>> Thanks,
>>
>> Daniel

