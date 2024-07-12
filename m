Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E164C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCvl-00089w-BG; Fri, 12 Jul 2024 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1sSCvj-00089A-Be
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:51:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1sSCvc-0003Xz-Eb
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:51:07 -0400
Received: from loongson.cn (unknown [10.20.42.120])
 by gateway (Coremail) with SMTP id _____8AxG_Bz_JBmqaQDAA--.10465S3;
 Fri, 12 Jul 2024 17:50:44 +0800 (CST)
Received: from [10.20.42.120] (unknown [10.20.42.120])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxBMVv_JBmarlFAA--.17314S3; 
 Fri, 12 Jul 2024 17:50:42 +0800 (CST)
Subject: Re: [PULL 0/9] loongarch-to-apply queue
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240711074829.3338879-1-gaosong@loongson.cn>
 <78d9f6d3-9257-40a8-b9e1-6690b80e122b@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <14a28322-e803-d4e0-bdfe-461837d23c24@loongson.cn>
Date: Fri, 12 Jul 2024 17:50:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <78d9f6d3-9257-40a8-b9e1-6690b80e122b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxBMVv_JBmarlFAA--.17314S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxur4xGrykAw4kCFWfGryfAFc_yoW5XFWxpr
 WSvF17KrZ5Grs7Jr1UtrW5XFyjyw1xG3W2q3WUXFy8ZFs8Ar1Yqr90gr10gFy3J395XF1Y
 vF10yw1UZFsrZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.862,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Philippe:
> Hi Richard,
>
> On 11/7/24 09:48, Song Gao wrote:
>> The following changes since commit 
>> 59084feb256c617063e0dbe7e64821ae8852d7cf:
>>
>>    Merge tag 'pull-aspeed-20240709' of 
>> https://github.com/legoater/qemu into staging (2024-07-09 07:13:55 
>> -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240711
>>
>> for you to fetch changes up to 78341408e705e1b8dc92eaae2071ae0023d586b0:
>>
>>    target/loongarch: Fix cpu_reset set wrong CSR_CRMD (2024-07-11 
>> 15:56:50 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20240711
>>
>> ----------------------------------------------------------------
>> Bibo Mao (2):
>>        hw/loongarch/virt: Remove unused assignment
>>        target/loongarch/kvm: Add software breakpoint support
>>
>> Dmitry Frolov (1):
>>        hw/loongarch/boot.c: fix out-of-bound reading
>>
>> Feiyang Chen (1):
>>        target/loongarch: Remove avail_64 in trans_srai_w() and 
>> simplify it
>>
>> Jiaxun Yang (1):
>>        MAINTAINERS: Add myself as a reviewer of LoongArch virt machine
>>
>> Song Gao (2):
>>        target/loongarch: Set CSR_PRCFG1 and CSR_PRCFG2 values
>>        target/loongarch: Fix cpu_reset set wrong CSR_CRMD
>>
>> Xianglai Li (2):
>>        hw/loongarch: Change the tpm support by default
>>        hw/loongarch: Modify flash block size to 256K
>
> Please hold on before merging, I'd like to check with
> the author for migration issue regarding the flash block size
> change.
>
I performed a live migration test on the local environment. The test 
steps are as follows:

1.Create A network file system between PC A and PC B.
2.Replace the qemu binary of PC B with the version with the modified 
flash block size.
2.The network file system enables PC A and PC B to access the same test 
qcow2 file.
3.Create a VM on PC A using the test qcow2 file.
4.Add a boot item stored in the flash. Use the BIOS GUI to save the boot 
item, shut down the VM,
    restart the VM, and check whether the boot item exists
5.The migration function of virt-manager is used to migrate VMS from PC 
A to PC B.
    After the migration is successful, stop the VM, restart the VM,
    and check whether the boot option exists and the VM can be started 
normally with the boot option.
6.Perform the same test as Step 5 to migrate the VM from PC B to PC A

After the test, data in the flash of the VM is not lost, and the VM can 
start normally.
Therefore, I believe that the current patch does not affect the 
migration function.

Thanks,
Xianglai.

> Thanks,
>
> Phil.


