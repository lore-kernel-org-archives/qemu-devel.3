Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF7C7115C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 02:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTX5t-000074-Mr; Sun, 22 Jun 2025 22:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uTX5q-00006Z-Tb
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:39:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uTX5o-0003VQ-0W
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:39:34 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxWXFXvlhoOmAbAQ--.62261S3;
 Mon, 23 Jun 2025 10:39:19 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMDx_MRTvlhoFKYmAQ--.48746S3;
 Mon, 23 Jun 2025 10:39:17 +0800 (CST)
Subject: Re: [PULL 00/14] loongarch-to-apply queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250619082817.1517996-1-gaosong@loongson.cn>
 <CAJSP0QWsFx8qcR4k4nb2fBH0Q1aFWwCUU4JEs+NFCGHKhSphMA@mail.gmail.com>
 <b9f57a29-b13b-cd94-dc92-bc9ea45cc077@loongson.cn>
 <CAJSP0QXGg9_hcdNVJ4LyVNB8ujFSX5jMfYSwbsfX2xQ2XAJdCw@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <79e720ca-ef28-c7cd-9226-00f9264da81e@loongson.cn>
Date: Mon, 23 Jun 2025 10:42:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXGg9_hcdNVJ4LyVNB8ujFSX5jMfYSwbsfX2xQ2XAJdCw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------3A0F83BD6630CC6A4EB9A5E3"
Content-Language: en-US
X-CM-TRANSID: qMiowMDx_MRTvlhoFKYmAQ--.48746S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWrWktrykGF4DAw18Xw4rtFc_yoW5WryxpF
 saq3ZYvFWDAF48AF45tFykXr12y343tF17JF98t348JFZ8Zw18Wry3t3WxGry2qr9agry3
 Zrn7WFWIkFsYqagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C267I2x7xF54xIwI1l57IF6x
 kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
 6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
 vIr41lFcxC0VAYjxAxZF0Ex2IqxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
 I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
 xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
 jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
 67AKxVWUJVW8JwCE64xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07URmhwUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.112,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------3A0F83BD6630CC6A4EB9A5E3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/6/21 上午2:12, Stefan Hajnoczi 写道:
> On Thu, Jun 19, 2025 at 11:11 PM gaosong <gaosong@loongson.cn> wrote:
>> 在 2025/6/20 上午4:39, Stefan Hajnoczi 写道:
>>> gpg:                using RSA key CA473C44D6A09C189A193FCD452B96852B268216
>>> gpg: Can't check signature: No public key
>>>
>>> Why has the GPG key changed? Your previous pull request was signed
>>> with key B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF.
>>>
>>> If you would like to change keys, please sign your new key using your
>>> old key and upload the new key to the key servers again. That way I
>>> know that the new key really belongs to you.
>> Hi, Stefan
>>
>> I had  sign  new key using old key and send to the key server again
>> should I need pull again?
> Thanks!
>
> The pull request does not need to be resent.
but I find the pull  key not sign wi/th the  old key. /
> I wasn't able to fetch your new key with the signature from the
> keyservers though. Did you `gpg --send-keys 0x452B96852B268216`?
yes,  and I send it and tested recv the key

gpg --keyserver hkp://keys.openpgp.org --search-keys 0x452B96852B268216
gpg: data source:http://keys.openpgp.org:11371  <http://keys.openpgp.org:11371/>
(1)	Song Gao <gaosong@loongson.cn>
	  1024 bit RSA key 452B96852B268216, created: 2022-09-16
Keys 1-1 of 1 for "0x452B96852B268216".  Enter number(s), N)ext, or Q)uit > s
gaosong@loongson-pc:~$ gpg --recv-keys 0x452B96852B268216
gpg: key 452B96852B268216: "Song Gao <gaosong@loongson.cn>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1

> Alternatively, you could attach your new signed gpg key and send it as
> an email attachment.

Attached is the key I exported

Thanks.
Song Gao

> Stefan
>
>> Thanks.
>> Song Gao
>>
>> gpg --list-signatures
>> /home/gaosong/.gnupg/pubring.kbx
>> --------------------------------Attached is the key I exported
>> pub   rsa1024 2022-09-16 [SC]
>>         B8FF1DA0D2FDCB2DA09C6C2C40A2FFF239263EDF
>> uid           [ 未知 ] Song Gao <m17746591750@163.com>
>> sig 3        40A2FFF239263EDF 2022-09-16  Song Gao <m17746591750@163.com>
>> sig          452B96852B268216 2025-06-20  Song Gao <gaosong@loongson.cn>
>>
>> pub   rsa1024 2022-09-16 [SC]
>>         CA473C44D6A09C189A193FCD452B96852B268216
>> uid           [ 未知 ] Song Gao <gaosong@loongson.cn>
>> sig 3        452B96852B268216 2022-09-16  Song Gao <gaosong@loongson.cn>
>> sig          40A2FFF239263EDF 2025-06-20  Song Gao <m17746591750@163.com>
>>
>>
>> gpg --send-keys CA473C44D6A09C189A193FCD452B96852B268216
>> gpg: 正在发送密钥 452B96852B268216 到 hkps://keys.openpgp.org
>> gpg --recv-keys CA473C44D6A09C189A193FCD452B96852B268216
>> gpg: 密钥 452B96852B268216：“Song Gao <gaosong@loongson.cn>” 未改变
>> gpg: 处理的总数：1
>> gpg:              未改变：1
>>
>>
>>


--------------3A0F83BD6630CC6A4EB9A5E3
Content-Type: text/plain; charset=UTF-8;
 name="public_key.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="public_key.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptSTBFWXlRcGZBRUVBTHB6
K0l1NHpEbTk2K1BQTGhmb1BrRzBmdzFSbTZFMU5yRGJTVjJPUGpEOEhvTllTZGJTCi8yUWEy
ekVxZUZBNkNBVi9VLzR0S2V4ejRjT3REeld1Mkc2d2xRd1NKUkhIdjcrbGNiR0hlWXFJUDdx
M0xhZm0KYVNncjA0ZnZwL00yUzhRdXN6c0YzL3FCT0hPcE5aUHRTZjkrUWJ6VVRhTVF5QVhV
enNmdXpTVnhBQkVCQUFHMApIbE52Ym1jZ1IyRnZJRHhuWVc5emIyNW5RR3h2YjI1bmMyOXVM
bU51UG9qT0JCTUJDQUE0RmlFRXlrYzhSTmFnCm5CaWFHVC9OUlN1V2hTc21naFlGQW1Na0tY
d0NHd01GQ3drSUJ3SUdGUW9KQ0FzQ0JCWUNBd0VDSGdFQ0Y0QUEKQ2drUVJTdVdoU3NtZ2hh
eVBBUDVBZU9VNDJ0MGQrYVovb09kOG45V1BFY2hpV0ZER2JOa1FxOE1OZkpJaHJMOApWVnNq
c3BIUVJNVEhBekJXYTk4QklXeHBrNWY0UytwT0ZIdHJ2ZTJxWFhnS05EMytaTkdEY0dsd21k
eGt3ZU9YClZCd1JLNnRUV092c1dHOXdUZ3MrbWdPVE1ZTCtRS1F2ODZHeWNzZVpPb3dNcUNa
eDVTbDQrRjlua0Y0U2gveUkKc3dRUUFRZ0FIUlloQkxqL0hhRFMvY3N0b0p4c0xFQ2kvL0k1
Smo3ZkJRSm9WTGxUQUFvSkVFQ2kvL0k1Smo3Zgp5eHdFQU9IRTJqWVR3aEJUdktUZjZZZXo2
N3JRZXBNNk9ZbXNhRjczeExGVTJyZ2MremNOc0dxV0lzT2d1azhhCk5ONUhHT1RYa29aT1pY
eXB2TGh0TGJ0b2FwbWJ6UC90Z1RkbjhFekVKSW9VVnJ3UHB3cEk3M0Q4RXVyUWI3SUEKazdl
eU5MdzFmQ3J3Wk1wU1dPaXd1TzFFb2lXblNsNS9ZbUZwRmwxQ2tSa2F4WWhMCj0vdFFJCi0t
LS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
--------------3A0F83BD6630CC6A4EB9A5E3--


