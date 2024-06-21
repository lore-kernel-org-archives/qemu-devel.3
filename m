Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877CFC2BD05
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKh1v-0005NG-0M; Fri, 21 Jun 2024 12:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh1c-0004qI-Oa; Fri, 21 Jun 2024 12:22:12 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh1a-0003kf-I3; Fri, 21 Jun 2024 12:22:08 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5N0q6Hzqz4wc5;
 Sat, 22 Jun 2024 02:22:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5N0n4DMGz4w2Q;
 Sat, 22 Jun 2024 02:22:01 +1000 (AEST)
Message-ID: <58ab84cb-29a7-477b-a0bd-c28a5b46df22@kaod.org>
Date: Fri, 21 Jun 2024 18:21:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] hw/sd/sdcard: Inline BLK_READ_BLOCK /
 BLK_WRITE_BLOCK macros
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-20-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=9ak7=NX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/21/24 10:05 AM, Philippe Mathieu-Daudé wrote:
> These macros only save 3 chars and make the code harder
> to maintain, simply remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 8d63a39a54..ca2c903c5b 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -816,8 +816,6 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>       }
>   }
>   
> -#define BLK_READ_BLOCK(a, len)  sd_blk_read(sd, a, len)
> -#define BLK_WRITE_BLOCK(a, len) sd_blk_write(sd, a, len)
>   #define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
>   #define APP_WRITE_BLOCK(a, len)
>   
> @@ -869,7 +867,7 @@ static void sd_erase(SDState *sd)
>                   continue;
>               }
>           }
> -        BLK_WRITE_BLOCK(erase_addr, erase_len);
> +        sd_blk_write(sd, erase_addr, erase_len);
>       }
>   }
>   
> @@ -1901,7 +1899,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>           if (sd->data_offset >= sd->blk_len) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
> -            BLK_WRITE_BLOCK(sd->data_start, sd->data_offset);
> +            sd_blk_write(sd, sd->data_start, sd->data_offset);
>               sd->blk_written ++;
>               sd->csd[14] |= 0x40;
>               /* Bzzzzzzztt .... Operation complete.  */
> @@ -1927,7 +1925,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>           if (sd->data_offset >= sd->blk_len) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
> -            BLK_WRITE_BLOCK(sd->data_start, sd->data_offset);
> +            sd_blk_read(sd, sd->data_start, sd->data_offset);
>               sd->blk_written++;
>               sd->data_start += sd->blk_len;
>               sd->data_offset = 0;
> @@ -2075,8 +2073,9 @@ uint8_t sd_read_byte(SDState *sd)
>           break;
>   
>       case 17:  /* CMD17:  READ_SINGLE_BLOCK */
> -        if (sd->data_offset == 0)
> -            BLK_READ_BLOCK(sd->data_start, io_len);
> +        if (sd->data_offset == 0) {
> +            sd_blk_read(sd, sd->data_start, io_len);
> +        }
>           ret = sd->data[sd->data_offset ++];
>   
>           if (sd->data_offset >= io_len)
> @@ -2089,7 +2088,7 @@ uint8_t sd_read_byte(SDState *sd)
>                                     sd->data_start, io_len)) {
>                   return 0x00;
>               }
> -            BLK_READ_BLOCK(sd->data_start, io_len);
> +            sd_blk_read(sd, sd->data_start, io_len);
>           }
>           ret = sd->data[sd->data_offset ++];
>   


