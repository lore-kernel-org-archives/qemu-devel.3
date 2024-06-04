Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C3FC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKEJ-0002Ax-5L; Mon, 03 Jun 2024 22:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sEKEG-0002AZ-TH
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 22:48:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sEKED-000647-N3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 22:48:52 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dxi+qIgF5mVEEDAA--.13957S3;
 Tue, 04 Jun 2024 10:48:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXceFgF5mOKUTAA--.50075S3; 
 Tue, 04 Jun 2024 10:48:39 +0800 (CST)
Subject: Re: [PATCH] tests/avocado: Update LoongArch bios file
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, clg@redhat.com,
 maobibo@loongson.cn
References: <20240530125744.1985487-1-gaosong@loongson.cn>
 <CAFEAcA_L=WKSRTF7EhW8DEO1=c+KF=NTx4tHVMh2HwNgLnvJ_g@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e15bb196-243a-74cd-3dde-8e604e189f98@loongson.cn>
Date: Tue, 4 Jun 2024 10:48:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_L=WKSRTF7EhW8DEO1=c+KF=NTx4tHVMh2HwNgLnvJ_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxXceFgF5mOKUTAA--.50075S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrykJF4UXw15ur1rKw4DAwc_yoW8CryfpF
 yay3W5KrZ7tFnxKrs7u3s3ZF4furykKFy8GFyxtr1rurZ8Ar40qFWktrW0yFyDAws5Wr4a
 vr92k34rJF4DXFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTm
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.522,
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

在 2024/6/3 下午11:58, Peter Maydell 写道:
> On Thu, 30 May 2024 at 13:59, Song Gao <gaosong@loongson.cn> wrote:
>> The VM uses old bios to boot up only 1 cpu, causing the test case to fail.
>> Update the bios to solve this problem.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   tests/avocado/machine_loongarch.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/avocado/machine_loongarch.py b/tests/avocado/machine_loongarch.py
>> index 7d8a3c1fa5..12cc5ed814 100644
>> --- a/tests/avocado/machine_loongarch.py
>> +++ b/tests/avocado/machine_loongarch.py
>> @@ -38,7 +38,7 @@ def test_loongarch64_devices(self):
>>
>>           bios_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
>>                       'releases/download/binary-files/QEMU_EFI.fd')
>> -        bios_hash = ('dfc1bfba4853cd763b9d392d0031827e8addbca8')
>> +        bios_hash = ('f4d0966b5117d4cd82327c050dd668741046be69')
> This doesn't look right -- the file has the same URL but a different
> hash. This causes problems because the test suite on older
> versions of QEMU (eg our stable branches) will still be using
> this same URL but the old hash. So instead of running the test with
> the old BIOS version as they should, they'll skip the test if Avocado
> doesn't have the old file in its content cache.
>
> Is it possible for this test to use a file which doesn't change
> its contents arbitrarily? e.g. some fixed released version with
> a version number. Then if we need to use a newer BIOS version
> we can update both the bios_url and the bios_hash, and the
> old stable branches will continue to use the old URL and hash
> to download the old version they expect.
Thanks  for your sugesstion.
I will send a patch to fix it,

Thanks.
Song Gao


