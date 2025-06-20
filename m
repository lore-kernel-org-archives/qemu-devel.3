Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E930DC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 03:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSS9N-0008Ic-ON; Thu, 19 Jun 2025 23:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uSS9J-0008G8-VT
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 23:10:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uSS9G-0002hJ-R5
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 23:10:41 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxJHAn0VRobCoaAQ--.18710S3;
 Fri, 20 Jun 2025 11:10:31 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxbsUk0VRo3uMhAQ--.41504S3;
 Fri, 20 Jun 2025 11:10:30 +0800 (CST)
Subject: Re: [PULL 00/14] loongarch-to-apply queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250619082817.1517996-1-gaosong@loongson.cn>
 <CAJSP0QWsFx8qcR4k4nb2fBH0Q1aFWwCUU4JEs+NFCGHKhSphMA@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b9f57a29-b13b-cd94-dc92-bc9ea45cc077@loongson.cn>
Date: Fri, 20 Jun 2025 11:13:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWsFx8qcR4k4nb2fBH0Q1aFWwCUU4JEs+NFCGHKhSphMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxbsUk0VRo3uMhAQ--.41504S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr4fGF48GrWfuw17XF47Awc_yoW8Wr13pF
 1fW3WfWFyDAF4UAF4FyF4kWF17twn8tF17Jr98t348GFZ8Zr1Igry3ta1xK3sFvr9Ygr13
 Zrn7WFWIkF1ktagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.648,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

在 2025/6/20 上午4:39, Stefan Hajnoczi 写道:
> gpg:                using RSA key CA473C44D6A09C189A193FCD452B96852B268216
> gpg: Can't check signature: No public key
>
> Why has the GPG key changed? Your previous pull request was signed
> with key B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF.
>
> If you would like to change keys, please sign your new key using your
> old key and upload the new key to the key servers again. That way I
> know that the new key really belongs to you.
Hi, Stefan

I had  sign  new key using old key and send to the key server again
should I need pull again?

Thanks.
Song Gao

gpg --list-signatures
/home/gaosong/.gnupg/pubring.kbx
--------------------------------
pub   rsa1024 2022-09-16 [SC]
       B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF
uid           [ 未知 ] Song Gao <m17746591750@163.com>
sig 3        40A2FFF239263EDF 2022-09-16  Song Gao <m17746591750@163.com>
sig          452B96852B268216 2025-06-20  Song Gao <gaosong@loongson.cn>

pub   rsa1024 2022-09-16 [SC]
       CA473C44D6A09C189A193FCD452B96852B268216
uid           [ 未知 ] Song Gao <gaosong@loongson.cn>
sig 3        452B96852B268216 2022-09-16  Song Gao <gaosong@loongson.cn>
sig          40A2FFF239263EDF 2025-06-20  Song Gao <m17746591750@163.com>


gpg --send-keys CA473C44D6A09C189A193FCD452B96852B268216
gpg: 正在发送密钥 452B96852B268216 到 hkps://keys.openpgp.org
gpg --recv-keys CA473C44D6A09C189A193FCD452B96852B268216
gpg: 密钥 452B96852B268216：“Song Gao <gaosong@loongson.cn>” 未改变
gpg: 处理的总数：1
gpg:              未改变：1




