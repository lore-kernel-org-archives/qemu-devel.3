Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E698ECD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKs7g-0005PF-5e; Thu, 07 May 2026 02:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wKs7a-0005Ot-3h
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:22:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wKs7Y-0000Y2-9h
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:22:05 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxLuqIL_xpZGIHAA--.23410S3;
 Thu, 07 May 2026 14:22:00 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxSeCGL_xpaBp8AA--.39454S3;
 Thu, 07 May 2026 14:21:58 +0800 (CST)
Subject: Re: [PATCH 1/4] update-linux-headers.sh: add typelimits.h to portable
 header list
From: gaosong <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 clg@redhat.com, pbonzini@redhat.com, cohuck@redhat.com, thuth@redhat.com,
 mst@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-2-gaosong@loongson.cn>
Message-ID: <0a95025f-7234-ae8f-641d-cf605c5742ce@loongson.cn>
Date: Thu, 7 May 2026 14:23:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260427070029.1059386-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxSeCGL_xpaBp8AA--.39454S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFyUury5GFW8AryDCrWfWFX_yoW8WF4Upa
 s8u348Cry3J3W7JwnrWFyIkFy5XF45JF1agry2grWjyF90gr1Iq3yayrnIgryDta1UCa1j
 qr429ryUC3WkZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwMKu
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.736, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping~

ÔÚ 2026/4/27 ÏÂÎç3:00, Song Gao Ð´µÀ:
> Linux kernel introduced a new UAPI header file typelimits.h in the 7.1
> development cycle (commit merged in Jan 2026). This file is required by
> ethtool.h and other headers that include it.
>
> Since QEMU's update script only copies headers explicitly listed in the
> for loop, typelimits.h was missing after updating to newer kernel
> versions, causing compilation errors like:
>
>    fatal error: standard-headers/linux/typelimits.h: No such file or directory
>
> Add typelimits.h to the list of headers processed by cp_portable() to
> ensure it is properly copied and sanitized into the QEMU source tree
>
> Cc: clg@redhat.com
> Cc: pbonzini@redhat.com
> Cc: cohuck@redhat.com
> Cc: thuth@redhat.com
> Cc: mst@redhat.com
> Cc: peter.maydell@linaro.org
> Cc: richard.henderson@linaro.org
> Cc: philmd@linaro.org
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   scripts/update-linux-headers.sh | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 386d7a38e7..471f9cc71e 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -255,6 +255,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
>            "$hdrdir/include/linux/vhost_types.h" \
>            "$hdrdir/include/linux/vmclock-abi.h" \
>            "$hdrdir/include/linux/nitro_enclaves.h" \
> +         "$hdrdir/include/linux/typelimits.h" \
>            "$hdrdir/include/linux/sysinfo.h"; do
>       cp_portable "$i" "$output/include/standard-headers/linux"
>   done


