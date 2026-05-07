Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52577CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuft-00085L-Fj; Thu, 07 May 2026 05:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wKufr-000857-86
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:05:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wKufp-0003mC-2Y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:05:38 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxzendVfxpk20HAA--.22254S3;
 Thu, 07 May 2026 17:05:33 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxGMHZVfxp3S18AA--.25450S3;
 Thu, 07 May 2026 17:05:32 +0800 (CST)
Subject: Re: [PATCH 01/14] scripts/update-linux-headers: Add typelimits.h
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-2-avihaih@nvidia.com>
 <2145c818-53f3-4c05-9e96-c070ad5a2429@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3c542432-69d1-3423-7142-4aab689a3ce7@loongson.cn>
Date: Thu, 7 May 2026 17:07:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2145c818-53f3-4c05-9e96-c070ad5a2429@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxGMHZVfxp3S18AA--.25450S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw48GF4fur1DWrWDCr1ktFc_yoW5JFyrp3
 WkGr1UJry5Jr18Jr1UGr17AryUJr4UJw1DtryUJF1UJr1UJr10qr4DZr1Ygr1DJr48Jr1U
 Jr17J34UZr1UJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 b18UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.736,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

I take this patch for my series and update the linux-headers.


在 2026/5/7 下午3:54, Cédric Le Goater 写道:
> + Song Gao
>
> On 5/5/26 10:14, Avihai Horon wrote:
>> Upstream Linux added include/uapi/linux/typelimits.h and includes it
>> from ethtool.h [1][2].
>>
>> Teach update-linux-headers.sh to install that header into
>> standard-headers to be able to update kernel headers to versions that
>> include the above changes.
>>
>> [1] ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
>> [2] a8a11e5237ae ("ethtool: uapi: Use UAPI definition of INT_MAX")
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   scripts/update-linux-headers.sh | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/update-linux-headers.sh 
>> b/scripts/update-linux-headers.sh
>> index 386d7a38e7..da367acee7 100755
>> --- a/scripts/update-linux-headers.sh
>> +++ b/scripts/update-linux-headers.sh
>> @@ -60,6 +60,7 @@ cp_portable() {
>>                                        -e 'drm.h' \
>>                                        -e 'limits' \
>>                                        -e 'linux/const' \
>> +                                     -e 'linux/typelimits' \
>>                                        -e 'linux/kernel' \
>>                                        -e 'linux/sysinfo' \
>>                                        -e 'asm/setup_data.h' \
>> @@ -250,6 +251,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
>>            "$hdrdir/include/linux/pci_regs.h" \
>>            "$hdrdir/include/linux/ethtool.h" \
>>            "$hdrdir/include/linux/const.h" \
>> +         "$hdrdir/include/linux/typelimits.h" \
>>            "$hdrdir/include/linux/kernel.h" \
>>            "$hdrdir/include/linux/kvm_para.h" \
>>            "$hdrdir/include/linux/vhost_types.h" \
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> Thanks,
>
> C.


