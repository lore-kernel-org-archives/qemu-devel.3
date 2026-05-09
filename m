Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C210ACD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 16:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLk79-0004Ud-Ed; Sat, 09 May 2026 12:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wLk71-0004Nc-SE
 for qemu-devel@nongnu.org; Sat, 09 May 2026 12:01:13 -0400
Received: from 10.mo533.mail-out.ovh.net ([46.105.72.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wLk6y-0000L1-3p
 for qemu-devel@nongnu.org; Sat, 09 May 2026 12:01:07 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gCW1T3fBQz5x42;
 Sat,  9 May 2026 16:01:00 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sat,  9 May 2026 16:01:00 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.27])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gCW1S5bLHz1xqZ; Sat,  9 May 2026 16:01:00 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 8202B1B43553;
 Sat,  9 May 2026 16:00:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S00167d56ed6-7904-431a-9a01-6d0788867be9,
 3D272E53171ADE400D76652CEA3707ABC032970B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c04147a8-795c-420d-abd9-2f56c62dbd09@kaod.org>
Date: Sat, 9 May 2026 18:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID assembly
 during ENTDAA
To: Ashish Anand <ashish.a6@samsung.com>, qemu-devel@nongnu.org
Cc: komlodi@google.com, jamin_lin@aspeedtech.com, nabihestefan@google.com,
 saurabh@samsung.com, vishwa.mg@samsung.com, y.kaushal@samsung.com,
 ashish.anand202@gmail.com
References: <CGME20260505134412epcas5p1ccd2bd43c50ec651636847fa8c516072@epcas5p1.samsung.com>
 <20260505134002.509037-1-ashish.a6@samsung.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260505134002.509037-1-ashish.a6@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 6502071965185256552
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFqewUzqd5f9m+fdOrVh631dS3Gv4Bw10eSBuwUUR4hg2vxWE4JfBPZNlaYETdbu2d5R1IuzkaRerEIMGZYEO3ID7mYmyIy474RzmChlVLF4CgEDBJ/ykVI19yXbVrbBizGvYN9i4JKQYIeFolI1veZeU2+X4KOqjPHAu3P9gKHlVO02NXJD4xpah0VUZcHhXaWEj58xq2FhVdVJBhSgZnR13wRuLqHnnM81vj1onw5BY0ygnz3VB6QC90ZXDFNqnyff1Lf1pIsNuvs7+jpCc5HRkGjMmVtje1EQdFFlAAV3fTAXCcdsB8TD5Lq0UJe7fFD3oRAv2uaZDvj8upel4OVDFb1BZzzf+bX+HSyC58uXrfCCa4dXBCRe1NHAPTTXZdcTxdm/Fwyl5SKDFiIi4zuEc+XmeOxN28/oT0QT97gFxcJVcywC0MLOAkwzcFuFp/oEdmPcwdGW2D0Jy9dt9y/Lsezd+E0HArLbJ7Bj2S4cZu5yW4/oeLa3NLvVmt5fryP8JiOSbQMmYhxNBllQmNQXEYO73VKC450okb3dbPmn7UM64nBOURLQlenyirq3YQ4LMdDtmyiE9+BIt4NbJaF0ExFkg91Viu10zAD1dMriIcC2EonUoKtCvxzOjgjiijRn3vf9y5uQtlKbtNmsdJhOFJZ3Lii9o02Dy2v9y1TEA
DKIM-Signature: a=rsa-sha256; bh=udzx5XDz+9IWzy5TwXK1lIJZ81nRNZFaXf9XaK67jNY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778342462; v=1;
 b=ofwUtS5vkL7K2hW3l1hfRO4axJrJ64GmYtdWPAe8NuxgTV3tzzvpKFE+KDsQiuge+TY/UbXS
 wQIThODvKfzrqPEd0nC42UQwCYHDqBfrH53Tk4bbA9WRvUaUGBQ4yFW6wt4fbLSGZklt7apumWU
 axQPf0vwnTnoEdc9qm9jBx4yDtO/h7O6YE3E6xgv/nAtOsqgB7sVyKuEPoZiI2FkEI0k3qTIo3k
 KMPRNyzWHm5PBAE9inoPjOfKzoRm3HWsa1ykBkfwf/ebqixNqVN1R/JBTSIT6CFoLcTj8TWoZzY
 Mb6JFNZXi6IA6jmPz5FqccRnOxn9UBXkXrVkpACmeSN+A==
Received-SPF: pass client-ip=46.105.72.194; envelope-from=clg@kaod.org;
 helo=10.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Jamin,

Does that look good ?

Thanks,

C.

On 5/5/26 15:40, Ashish Anand wrote:
> The target_info union in dw_i3c_addr_assign_cmd() declares pid, bcr,
> and dcr as separate union members, causing them to all alias b[0]
> rather than their correct positions in the ENTDAA response buffer.
> This results in dw_i3c_update_char_table() being called with BCR and
> DCR both read from b[0] instead of b[6] and b[7] respectively,
> corrupting the device characteristics table on every ENTDAA operation.
> Fix by replacing the broken members with uint64_t d and extracting fields
> per the I3C spec ENTDAA wire format.
> 
> Additionally, dw_i3c_update_char_table() incorrectly splits PID across
> LOC1 and LOC2 at bit 32. Per the Linux kernel HCI driver
> (drivers/i3c/master/mipi-i3c-hci/dct_v1.c), the DCT layout requires
> LOC1 to hold pid[47:16] and LOC2 to hold pid[15:0]. Fix the split
> accordingly.
> 
> Signed-off-by: Ashish Anand <ashish.a6@samsung.com>
> ---
> 
> Changes from v1 :
> 1. Replaced broken union members with uint64_t d, added wire format comment.
> 2. Replaced loop with be64_to_cpu(target_info.d) >> 16.
> 3. Fixed LOC1/LOC2 split at bit 16 in dw_i3c_update_char_table.
> 4. Added comment to i3c.h clarifying how core.c transmits t->pid during ENTDAA.
> 
> Link to v1 - https://lore.kernel.org/qemu-devel/exdu52mug6fh3bwj7ofo3jlltyuwjfnddxobio4w3jhaq6uv7k@boxo3j5ocef2/T/#t
> 
> This bug was discovered during end-to-end ENTDAA testing where BCR and
> DCR values observed in the char table register did not match the target's
> actual BCR and DCR values.
> 
>   hw/i3c/dw-i3c.c      | 16 +++++++---------
>   include/hw/i3c/i3c.h |  7 +++++++
>   2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index d87d42be89..17ff484c5d 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -1459,11 +1459,10 @@ static void dw_i3c_update_char_table(DWI3C *s, uint8_t offset, uint64_t pid,
>                                             P_DEV_CHAR_TABLE_START_ADDR) /
>                                             sizeof(uint32_t)) +
>                                             (offset * sizeof(uint32_t));
> -    s->regs[dev_index] = pid & 0xffffffff;
> -    pid >>= 32;
> +    s->regs[dev_index] = (pid >> 16) & 0xffffffff;
>       s->regs[dev_index + 1] = FIELD_DP32(s->regs[dev_index + 1],
>                                           DEVICE_CHARACTERISTIC_TABLE_LOC2,
> -                                        MSB_PID, pid);
> +                                        MSB_PID, pid & 0xffff);
>       s->regs[dev_index + 2] = FIELD_DP32(s->regs[dev_index + 2],
>                                           DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR,
>                                           dcr);
> @@ -1507,10 +1506,9 @@ static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
>       for (i = 0; i < cmd.dev_count; i++) {
>           uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index + i);
>           union {
> -            uint64_t pid:48;
> -            uint8_t bcr;
> -            uint8_t dcr;
> +            uint64_t d;
>               uint32_t w[2];
> +            /* Per I3C spec: b[0]=PID MSB, b[5]=PID LSB, b[6]=BCR, b[7]=DCR */
>               uint8_t b[8];
>           } target_info;
>   
> @@ -1544,9 +1542,9 @@ static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
>               err = DW_I3C_RESP_QUEUE_ERR_DAA_NACK;
>               break;
>           }
> -        dw_i3c_update_char_table(s, cmd.dev_index + i,
> -                                            target_info.pid, target_info.bcr,
> -                                            target_info.dcr, addr);
> +        uint64_t pid = be64_to_cpu(target_info.d) >> 16;
> +        dw_i3c_update_char_table(s, cmd.dev_index + i, pid, target_info.b[6],
> +                                 target_info.b[7], addr);
>   
>           /* Push the PID, BCR, and DCR to the RX queue. */
>           dw_i3c_push_rx(s, target_info.w[0]);
> diff --git a/include/hw/i3c/i3c.h b/include/hw/i3c/i3c.h
> index 6ba90793ad..dcf8d9b143 100644
> --- a/include/hw/i3c/i3c.h
> +++ b/include/hw/i3c/i3c.h
> @@ -138,6 +138,13 @@ struct I3CTarget {
>       uint8_t static_address;
>       uint8_t dcr;
>       uint8_t bcr;
> +    /*
> +     * Provisioned ID. Since core.c sends this LSB-first during ENTDAA
> +     * via (pid >> (offset * 8)) & 0xff, targets must store it
> +     * pre-reversed so that pid[47:40] goes on the wire first, as
> +     * required by the I3C spec.
> +     *  e.g. for a device with pid 0xAABBCCDDEEFF, store 0xFFEEDDCCBBAA.
> +     */
>       uint64_t pid;
>   
>       /* CCC State tracking. */


