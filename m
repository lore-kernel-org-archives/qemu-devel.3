Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40248C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfOQ-00018I-1E; Thu, 30 May 2024 09:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sCfOO-000185-V8
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:00:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sCfOM-0004Mo-8K
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:00:28 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dxi+pjeFhmjaYBAA--.7079S3;
 Thu, 30 May 2024 21:00:20 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axw8ReeFhmqjgOAA--.26520S3; 
 Thu, 30 May 2024 21:00:16 +0800 (CST)
Subject: Re: tests/avocado: Add LoongArch machine start test
To: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20230515111908.2606580-1-gaosong@loongson.cn>
 <20230515111908.2606580-3-gaosong@loongson.cn>
 <3819e261-646d-467a-b783-85700b0e6842@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <f2840fc6-0a16-b9ba-937e-f381d2c60bdb@loongson.cn>
Date: Thu, 30 May 2024 21:00:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3819e261-646d-467a-b783-85700b0e6842@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Axw8ReeFhmqjgOAA--.26520S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw1xAr48urWfur4kXw17XFc_yoWrGF1rpr
 48AF45GryxJrn3Jr1jg3WDZFyUAr1kG3WDJF1IqF18ur4DAr1jgr1jqr1vgryDJw48Gr15
 Zry8Xw17Zr1UJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.299,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

在 2024/5/29 下午6:31, Thomas Huth 写道:
> On 15/05/2023 13.19, Song Gao wrote:
>> Add a new test in tests/avocado to check LoongArch virt machine start.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Message-Id: <20230513012744.1885728-1-gaosong@loongson.cn>
>> ---
>>   MAINTAINERS                        |  1 +
>>   tests/avocado/machine_loongarch.py | 58 ++++++++++++++++++++++++++++++
>>   2 files changed, 59 insertions(+)
>>   create mode 100644 tests/avocado/machine_loongarch.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ff2aa53bb9..50585117a0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -245,6 +245,7 @@ M: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>>   S: Maintained
>>   F: target/loongarch/
>>   F: tests/tcg/loongarch64/
>> +F: tests/avocado/machine_loongarch.py
>>     M68K TCG CPUs
>>   M: Laurent Vivier <laurent@vivier.eu>
>> diff --git a/tests/avocado/machine_loongarch.py 
>> b/tests/avocado/machine_loongarch.py
>> new file mode 100644
>> index 0000000000..7d8a3c1fa5
>> --- /dev/null
>> +++ b/tests/avocado/machine_loongarch.py
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# LoongArch virt test.
>> +#
>> +# Copyright (c) 2023 Loongson Technology Corporation Limited
>> +#
>> +
>> +from avocado_qemu import QemuSystemTest
>> +from avocado_qemu import exec_command_and_wait_for_pattern
>> +from avocado_qemu import wait_for_console_pattern
>> +
>> +class LoongArchMachine(QemuSystemTest):
>> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>> +
>> +    timeout = 120
>> +
>> +    def wait_for_console_pattern(self, success_message, vm=None):
>> +        wait_for_console_pattern(self, success_message,
>> +                                 failure_message='Kernel panic - not 
>> syncing',
>> +                                 vm=vm)
>> +
>> +    def test_loongarch64_devices(self):
>> +
>> +        """
>> +        :avocado: tags=arch:loongarch64
>> +        :avocado: tags=machine:virt
>> +        """
>> +
>> +        kernel_url = 
>> ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
>> + 'releases/download/binary-files/vmlinuz.efi')
>> +        kernel_hash = '951b485b16e3788b6db03a3e1793c067009e31a2'
>> +        kernel_path = self.fetch_asset(kernel_url, 
>> asset_hash=kernel_hash)
>> +
>> +        initrd_url = 
>> ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
>> +                      'releases/download/binary-files/ramdisk')
>> +        initrd_hash = 'c67658d9b2a447ce7db2f73ba3d373c9b2b90ab2'
>> +        initrd_path = self.fetch_asset(initrd_url, 
>> asset_hash=initrd_hash)
>> +
>> +        bios_url = 
>> ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
>> + 'releases/download/binary-files/QEMU_EFI.fd')
>> +        bios_hash = ('dfc1bfba4853cd763b9d392d0031827e8addbca8')
>> +        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
>
>  Hi!
>
> FYI, the test does not seem to work anymore - apparently the binaries 
> have changed and now the hashes do not match anymore. Could you please 
> update it? (preferably with some versioned binaries that do not change 
> in the course of time?)
>
Thank you,  I had send a patch to fix it.

Thanks.
Song Gao


