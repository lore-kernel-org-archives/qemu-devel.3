Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300C5C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 01:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCrSA-0007SE-0G; Thu, 30 May 2024 21:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sCrS8-0007S2-CV
 for qemu-devel@nongnu.org; Thu, 30 May 2024 21:53:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sCrS5-0002FI-ET
 for qemu-devel@nongnu.org; Thu, 30 May 2024 21:53:08 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx_ep7LVlmRfkBAA--.8355S3;
 Fri, 31 May 2024 09:52:59 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRcV4LVlmrcMOAA--.27698S3; 
 Fri, 31 May 2024 09:52:58 +0800 (CST)
Subject: Re: tests/avocado: Add LoongArch machine start test
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: QEMU devel <qemu-devel@nongnu.org>, Chao Li <lichao@loongson.cn>,
 bibo mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>
References: <20230515111908.2606580-1-gaosong@loongson.cn>
 <20230515111908.2606580-3-gaosong@loongson.cn>
 <3819e261-646d-467a-b783-85700b0e6842@redhat.com>
 <f2840fc6-0a16-b9ba-937e-f381d2c60bdb@loongson.cn>
 <bd599efc-1b5a-47a1-b0e9-15c59907a256@app.fastmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <f80b55c3-f527-fe1a-4033-d9dde1ee0b01@loongson.cn>
Date: Fri, 31 May 2024 09:52:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bd599efc-1b5a-47a1-b0e9-15c59907a256@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxRcV4LVlmrcMOAA--.27698S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gr1rtryUCF1kWryDKrW5twc_yoWxtwcE9a
 1SyrZ7C3WDJa1q9FsY9w4rZrn7XayUJrZ0yryjqr43Jwn7Xr4UuFsrGrWvq3W3JayfJF9I
 yFZYq3W5XrW2gosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
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

在 2024/5/30 下午9:16, Jiaxun Yang 写道:
>
> 在2024年5月30日五月 下午2:00，gaosong写道：
> [...]
>>> FYI, the test does not seem to work anymore - apparently the binaries
>>> have changed and now the hashes do not match anymore. Could you please
>>> update it? (preferably with some versioned binaries that do not change
>>> in the course of time?)
>>>
>> Thank you,  I had send a patch to fix it.
> Hi Song,
>
> As LoongArch EDK2 support has been merged long ago, do you to make a clean
> build and add it to pc-bios directory?
EDK2 LoongArchVirt under OvmfPkg is being committed to upstream.

PR:
https://github.com/tianocore/edk2/pull/5208

Thanks
Song Gao
>
> Thanks
> - Jiaxun


