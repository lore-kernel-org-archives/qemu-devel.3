Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2931C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCxma-00060L-Ub; Fri, 31 May 2024 04:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sCxmY-000600-Vb
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:38:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sCxmV-0008Qe-Po
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:38:38 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Ax3eqHjFlmdRQCAA--.8748S3;
 Fri, 31 May 2024 16:38:31 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxJMWDjFlmECYPAA--.28714S3; 
 Fri, 31 May 2024 16:38:29 +0800 (CST)
Subject: Re: tests/avocado: Add LoongArch machine start test
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: QEMU devel <qemu-devel@nongnu.org>, Chao Li <lichao@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230515111908.2606580-1-gaosong@loongson.cn>
 <20230515111908.2606580-3-gaosong@loongson.cn>
 <3819e261-646d-467a-b783-85700b0e6842@redhat.com>
 <f2840fc6-0a16-b9ba-937e-f381d2c60bdb@loongson.cn>
 <bd599efc-1b5a-47a1-b0e9-15c59907a256@app.fastmail.com>
 <f80b55c3-f527-fe1a-4033-d9dde1ee0b01@loongson.cn>
 <9fb052b6-5787-4e70-9af7-e579bda0bb73@app.fastmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d4972016-fd91-765d-7446-a20556e11426@loongson.cn>
Date: Fri, 31 May 2024 16:38:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9fb052b6-5787-4e70-9af7-e579bda0bb73@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxJMWDjFlmECYPAA--.28714S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF18uw1kKF1fZrWDuFW7trc_yoW8Ar4Upa
 yxuF1rCF4Iqrs7t3y0g3WI9F1j9rs5Xr1YqFn8Jry8Za4qvr18AFW0yr4kKrnrZrn3uFyj
 vry3Xr97tas0vFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
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

在 2024/5/31 下午1:34, Jiaxun Yang 写道:
>
> 在2024年5月31日五月 上午2:52，gaosong写道：
>> 在 2024/5/30 下午9:16, Jiaxun Yang 写道:
>>> 在2024年5月30日五月 下午2:00，gaosong写道：
>>> [...]
>>>>> FYI, the test does not seem to work anymore - apparently the binaries
>>>>> have changed and now the hashes do not match anymore. Could you please
>>>>> update it? (preferably with some versioned binaries that do not change
>>>>> in the course of time?)
>>>>>
>>>> Thank you,  I had send a patch to fix it.
>>> Hi Song,
>>>
>>> As LoongArch EDK2 support has been merged long ago, do you to make a clean
>>> build and add it to pc-bios directory?
>> EDK2 LoongArchVirt under OvmfPkg is being committed to upstream.
>>
>> PR:
>> https://github.com/tianocore/edk2/pull/5208
> I meant here:
>
> https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios?ref_type=heads
Sorry, I didn't explain it well.

We already send a patch[1] to the QEMU community, this patch create a 
submodule 'roms/edk2-platform',
because the LoongArch BIOS code is all in edk2-platform repo. but the 
QEMU community think that
the edk2-platform project is too large. so we plan to move the LoongArch 
BIOS code from edk2-platfrom to the edk2 repo.

The PR[2] is to move edk2-platform to edk2 repo. but not merged in yet.

[1]: 
https://patchew.org/QEMU/260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn/
[2]: https://github.com/tianocore/edk2/pull/5208

Related Discussions :
https://lore.kernel.org/all/1f1d3d9f-c3df-4f29-df66-886410994cc3@xen0n.name/

Thanks.
Song Gao
>>> Thanks
>>> - Jiaxun


