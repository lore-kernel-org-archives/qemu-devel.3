Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC53C3DA49
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 01:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTAYe-0001I5-Gr; Sun, 14 Jul 2024 21:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sTAYa-0001GG-BT; Sun, 14 Jul 2024 21:31:12 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sTAYX-0004oe-En; Sun, 14 Jul 2024 21:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721007058; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=o8mwsmrDAPE2uxngpWqkTFPfLCMePUziNLy9kL+SZ88=;
 b=Uc4pUib8AuVwtNu0zuv5qoGDnBvWBEqwLegpxFVDKYgXT+eU5Xr7Vw0/pidAggQ1GrSul0W40UbKMnCXlbS8NCGXXPQfr9876jRoayGCVStZ/yDvP7rvM3jMgVtgPPFs8zXgZfwaJmEzC10iQcJOEgYSLBmBiTpj7eweAEpTOlA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WAUToJQ_1721007054; 
Received: from 30.166.64.89(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WAUToJQ_1721007054) by smtp.aliyun-inc.com;
 Mon, 15 Jul 2024 09:30:55 +0800
Message-ID: <77745ae0-ad0d-4bd0-8b01-b40795206e89@linux.alibaba.com>
Date: Mon, 15 Jul 2024 09:29:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] tests/avocado: Add an avocado test for riscv64
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240710022430.1306-1-zhiwei_liu@linux.alibaba.com>
 <20240710022430.1306-8-zhiwei_liu@linux.alibaba.com>
 <fd2448ed-072f-43da-838b-995beb73be37@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <fd2448ed-072f-43da-838b-995beb73be37@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/7/12 17:52, Daniel Henrique Barboza wrote:
>
>
> On 7/9/24 11:24 PM, LIU Zhiwei wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> To regularly test booting Linux with rv32 on QEMU RV64,
>> we have added a test to boot_linux_console.py to retrieve
>> cpuinfo and verify if it shows 'rv32' when using RV64 to
>> boot rv32 CPUs.
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   tests/avocado/boot_linux_console.py | 38 +++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/tests/avocado/boot_linux_console.py 
>> b/tests/avocado/boot_linux_console.py
>> index c35fc5e9ba..6d2f3b05cb 100644
>> --- a/tests/avocado/boot_linux_console.py
>> +++ b/tests/avocado/boot_linux_console.py
>> @@ -12,6 +12,7 @@
>>   import lzma
>>   import gzip
>>   import shutil
>> +import time
>>     from avocado import skip
>>   from avocado import skipUnless
>> @@ -1545,3 +1546,40 @@ def test_xtensa_lx60(self):
>>           """
>>           tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
>>           self.do_test_advcal_2018('02', tar_hash, 
>> 'santas-sleigh-ride.elf')
>> +
>> +    def test_riscv64_virt_rv32i(self):
>> +        """
>> +        :avocado: tags=arch:riscv64
>> +        :avocado: tags=machine:virt
>> +        :avocado: tags=cpu:rv32
>> +        """
>> +        kernel_url = 
>> ('https://github.com/romanheros/rv32-linux/raw/master/'
>> +                      'Image32.xz')
>> +        kernel_hash = 'a7ced5c38722481e0821b7cd70719cf53e46c13b'
>> +        kernel_path_xz = self.fetch_asset(kernel_url, 
>> asset_hash=kernel_hash)
>> +
>> +        kernel_path =  os.path.join(self.workdir, 'kernel.riscv32')
>> +        archive.lzma_uncompress(kernel_path_xz, kernel_path)
>> +
>> +        rootfs_url = 
>> ('https://github.com/romanheros/rv32-linux/raw/master/'
>> +                      'rootfs.ext2.xz')
>> +        rootfs_hash = 'dc25ab9d4b233e8e0bcf7eb220d56fd2008fe263'
>> +        rootfs_path_xz = self.fetch_asset(rootfs_url, 
>> asset_hash=rootfs_hash)
>> +
>> +        rootfs_path =  os.path.join(self.workdir, 'rootfs.riscv32')
>> +        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
>> +
>> +        self.vm.set_console()
>> +        kernel_command_line = 'root=/dev/vda ro console=ttyS0'
>> +        self.vm.add_args('-kernel', kernel_path,
>> +                         '-append', kernel_command_line,
>> +                         '-drive', 'file=' + rootfs_path +
>> + ',format=raw,id=hd0,if=none',
>> +                         '-device', 'virtio-blk-device,drive=hd0')
>> +        self.vm.launch()
>> +
>> +        console_pattern = 'Welcome to Buildroot'
>> +        self.wait_for_console_pattern(console_pattern)
>> +        exec_command(self, 'root')
>> +        time.sleep(0.1)
>> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo', 
>> 'rv32i')
>
>
> Nothing wrong with adding a boot_linux_console.py, but if we could add 
> a tuxrun_baselines.py
> testsuite instead I think it would be great.
>
> I believe Tuxboot is now the preferable way of testing a distro up to 
> boot in QEMU. We have
> all other RISC-V CPU boards and CPUs tested in that framework. It's 
> also faster to run.
>
> Here's a diff adding it:
>
> $ git diff
> diff --git a/tests/avocado/tuxrun_baselines.py 
> b/tests/avocado/tuxrun_baselines.py
> index 736e4aa289..589c7f254b 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -533,6 +533,22 @@ def test_riscv64_maxcpu(self):
>
>          self.common_tuxrun(csums=sums)
>
> +    def test_riscv64_rv32(self):
> +        """
> +        :avocado: tags=arch:riscv64
> +        :avocado: tags=machine:virt
> +        :avocado: tags=tuxboot:riscv32
> +        :avocado: tags=cpu:rv32
> +        """
> +        sums = { "Image" :
> + "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
> +                 "fw_jump.elf" :
> + "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
> +                 "rootfs.ext4.zst" :
> + "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
> +
> +        self.common_tuxrun(csums=sums)
> +
>      def test_s390(self):
>          """
>          :avocado: tags=arch:s390x
>
>
> $ make check-avocado
> (...)
>  (01/21) 
> tests/avocado/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i: 
> PASS (22.32 s)
> (...)
>  (14/21) 
> tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_riscv64_rv32: 
> PASS (10.34 s)

Hi Daniel,

Thanks for sharing this test way to us. I'd like to replace our test 
with yours. And this commit will be authored to you.

Thanks,
Zhiwei

>
>
>
> Thanks,
>
> Daniel

