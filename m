Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE54C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 02:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trSYl-0007it-Mi; Sun, 09 Mar 2025 22:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1trSYj-0007hj-C4
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 22:08:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1trSYg-00064J-G3
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 22:08:01 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxdXBxSc5nJ0uQAA--.50354S3;
 Mon, 10 Mar 2025 10:07:46 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxu8RtSc5nifhAAA--.42415S3;
 Mon, 10 Mar 2025 10:07:44 +0800 (CST)
Subject: Re: [PATCH] hw/elf_ops: Use physical address about kernel entry
From: bibo mao <maobibo@loongson.cn>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250219021758.190644-1-maobibo@loongson.cn>
Message-ID: <48052bda-45f1-4dcc-6dfb-ed47ff9a8124@loongson.cn>
Date: Mon, 10 Mar 2025 10:07:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250219021758.190644-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8RtSc5nifhAAA--.42415S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruF1DZryrZFy8uw4rXw1rZrc_yoWkJFc_Aa
 1xJr4kur4DXFy29FsxAF1kJr1Sv34rtr1ru3WfJFWxJa45JF4DGr10g3s5uFWfG39YyF18
 Aan3u34Yyr93WosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.702,
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


Gently ping :)
On 2025/2/19 上午10:17, Bibo Mao wrote:
> With load_elf() API, if input parameter translate_fn is set, loading
> address is converted to physical address. It should be the same for entry
> address, since MMU is disabled when system power on, the first instruction
> of PC should be physical address.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   include/hw/elf_ops.h.inc | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
> index 9c35d1b9da..37ce7845a9 100644
> --- a/include/hw/elf_ops.h.inc
> +++ b/include/hw/elf_ops.h.inc
> @@ -388,7 +388,11 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>           *pflags = ehdr.e_flags;
>       }
>       if (pentry) {
> -        *pentry = ehdr.e_entry;
> +        if (translate_fn) {
> +            *pentry = translate_fn(translate_opaque, ehdr.e_entry);
> +        } else {
> +            *pentry = ehdr.e_entry;
> +        }
>       }
>   
>       glue(load_symbols, SZ)(&ehdr, fd, must_swab, clear_lsb, sym_cb);
> 
> base-commit: db7aa99ef894e88fc5eedf02ca2579b8c344b2ec
> 


