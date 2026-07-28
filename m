Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9C4C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocqB-0003TM-ER; Tue, 28 Jul 2026 04:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocqA-0003T7-4k
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:07:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocq8-0005Id-90
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:07:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S8204T2071327
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cHfHavqjmM6PsdmmpruU5Dbspba1d4SFBKvfzXBbcAg=; b=exUKMygMaD/MCq5u
 Tt3/hG1UcubYkExIMbSco+pukB1tfeKCMnECRHf2d8RVdJRGgsKSM+1PQwJP6qPZ
 tGXkkAJeNyxD0sWmwZ+Vk+IX7pyAE5ILrxTySTFmvLjDUCx9D94RAS7dBuR9Chk+
 mgGDPeHuoJ+kHZ6EO7h5mdQuhIXCPV7dv/ko0c/gBFI7FAGmpApuyEX3Ed2IiJl0
 xENcVJxRQt47rXgyQyS+2L+kluYXeSf8Fzh9gMHBaXc6Mgrg07C6re30b3BVt4Tl
 82HBlqRnBAyIRAhAeMpoFsBFGByuWSk/oNoCGpbAJGdZFrhzvvn5wKbX4TrvVsHd
 Wc27uw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpqxjg61f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:07:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso42262991cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785226021; x=1785830821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cHfHavqjmM6PsdmmpruU5Dbspba1d4SFBKvfzXBbcAg=;
 b=bBs+eRE3VPzp7l5DPw2XtSqpEgtkBLg1brlM4EpbaoitquUXa5hK+eGz58LNw54Hkg
 P4IMpNIpMUTb3Utk77ZQEmQCN7VAcJtRD0DWVOU+hUsDqA3VAqUBHOu/A1TYp5OeSuq3
 B2sgDE+Xy01v1SPL7frQ1Rjm9QGDIUccCAL1WzfPw08KO97QxLRivVMTxq8gJiNPvYU1
 C0xUlTC5KKL4ZRUlWtENUfv9zO6YOrqRcWraYwDj+8M9AkaipSofNdWgNuDtN/E8+qe6
 5o5a+UhbrzmBT8R5hhaXttTO2PTeTjy8NssCmC+OjorzaKNjoqpDGX7cBj+pZOL+xm2+
 PPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226021; x=1785830821;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cHfHavqjmM6PsdmmpruU5Dbspba1d4SFBKvfzXBbcAg=;
 b=T5bfE467jEP2BNNJsccVa7oFXJDx+ZWxK/tzhYrAncS9WftfTBH2qxQnUh15MbG7rx
 c9mS1SE3U8pN5EZz0G2oJDTq4zDzHz4z0xLAZcjABIG7htZdsUaGsoUcXjS3ubRWiQYJ
 xrxzeCXVCqFtRVcPgKzeAaXZY4ufmeZVF0jSbOFEtZsdfU7GqQNARMNDfhUnP2tvlMQc
 39sTvTqiStRWOAGebXUVvWj3I2mr35X00Co0+DW55noRXDWw+7J5QPW8Xo6ydSt4qtJq
 TR5xbhzqd1u6a2bEzPvmydf1OSr/eABD4NW8w+r5CtABBlhkqNkKhkCVIzsEX4t6sdTD
 iPYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMZhNp10+R0H9kZFrjwhobPalNJb8FriwsnvN5tg7ddMvz5Z9TzhEMEuDtZ2dzeydZVmSh4gDmo+YN@nongnu.org
X-Gm-Message-State: AOJu0Yw8H3LEZxp7sJT60g1uJiT0bcH28Z+y/ZMJ0KHI4FpA9idpW0+z
 zyrOTI46D/wSga4/gu1XgqiXKyD+iT7GOlNUl1CcuifPbnIl9idjAraXSeHkt+fv439FgjfksXX
 4/9inLNi41ABScg53MALFRnnN75lWF/UGkDE9WnzAEasmaRsTXgnfwqUpRA==
X-Gm-Gg: AR+sD12yjvVJa+gNuHeh5rB/6uOya2LclUe5ii1Ic4HcSFvPRpVI+IGeVoMsksn+DCw
 Fx9qrIT2aZxDdbVB2xglwQsfWBGwrDLe3jIfISAHtvthH9xM5oyhyPnYHMa+wkBIJyRmVBM4fr9
 0TOmV6bvNDlB2LdiGCOAdUwWyBXW4DjW7f5t4iPHqyyxg05o1GMeb6FEvQx+a3dfk0FTg31gu87
 XIXXwQpy4R4Vo9DLTBKtQrU+jkNMcWKHpbWNlkWxC5YAPKCOqwffOfYy5uvooKCuOVZnvfD2Vhu
 x6rjY1D/RyUETwoDG+QMjFJO3bhsZIyr+K7EXHxmMEgCegZSNcEYmSkFEDBy2y7+uTe5zYlFy3t
 Ouen6acaOnbNf8KI+5jcTjkrt0DG2lWfU4EpypHOJmUGa7kxSrlA=
X-Received: by 2002:a05:622a:4d91:b0:51f:20e1:137f with SMTP id
 d75a77b69052e-529d6fdf3damr9906051cf.19.1785226020889; 
 Tue, 28 Jul 2026 01:07:00 -0700 (PDT)
X-Received: by 2002:a05:622a:4d91:b0:51f:20e1:137f with SMTP id
 d75a77b69052e-529d6fdf3damr9905871cf.19.1785226020338; 
 Tue, 28 Jul 2026 01:07:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm56501198f8f.37.2026.07.28.01.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:06:59 -0700 (PDT)
Message-ID: <4edcec7b-30dd-474a-9030-ce5574c027e6@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/xilinx_axienet: Don't write checksums off end of
 packet
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowangio@gmail.com>
References: <20260706162704.787495-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706162704.787495-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TyVVkx98MrpHjdMtaBN_M7d90uB3gJmZ
X-Authority-Analysis: v=2.4 cv=MORQXsZl c=1 sm=1 tr=0 ts=6a686326 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=4-0obO580vcbkjo-hbIA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXxZYkcsUWFMNY
 PTsPu4oFgshRJi5jHacO1J4/XdlpSDTOYTRXlIwYpgb5o6DGRszu03i4c7N80wrgsFqIcHLrcix
 ZlNEIB/BdUVRBQOZ3W5Ckg2F/kft2F8=
X-Proofpoint-ORIG-GUID: TyVVkx98MrpHjdMtaBN_M7d90uB3gJmZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXyxh3BkfEpL2u
 nDN+sDt2qZD1hvDE3fooU7dZZHMGTCKKGniqBO45PQxjbVHKH+U54MBKqss98nJSW4DkaqpcaEP
 Zv+/eHQbnEnP6iuFc2eHsGScStuRCfPTTh1oHe7RxAAwuyc+2YlLAO4G3Mt/Mj1YISFpWTh3G3c
 QEXnA1bJRnKUdvSuL0sACLxsN7K4w17tHiF4pSiRJ5azs/SGXQ/8Sp/mZFOJudG+gYXuRWZlIgn
 Nb7mMSwwuFN3p2pQSZemytGcr1zhDc/046l1694KshfjoMzHzEbJ1uMOnQdvvEq1zoseAueNbTw
 JVlV+/KSc19M4/eIPlg/kMWDdQgvC4zz5GyKriNyUYIwNgIrRFK6pQd4h+mPu8Gl/It8lacAFQr
 2DpTRwpUwDaFf4paGNqIqNmZjMXd94XWHKIHZpy81EtTfeQBLmkL1C7Jrk6t6txW/D3kY2g8w9c
 cQhDx+OpggInl1H+bZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 6/7/26 18:27, Peter Maydell wrote:
> The xilinx_axienet device has ethernet checksum offloading, with a
> mode where the guest provides the offsets within the packet where
> the data to be checksummed starts, and where the final checksum
> should be written into the packet.
> 
> We don't sanity check the TX_CSINSERT offset before writing the
> checksum data into it, which means the guest can pass us a value that
> is larger than the packet itself and cause us to write the checksum
> off the end of the buffer.  We also don't explicitly check the
> TX_CSBEGIN offset; this doesn't currently cause any problems because
> we will pass a negative length to net_checksum_add() which does
> nothing, but it's a potential trap for the future if the type
> used for the length gets changed to be unsigned.
> 
> Explicitly check the offsets.  The datasheet doesn't say what happens
> if the guest misprograms this, so we choose to log an error and send
> the packet as-is.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3599
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/xilinx_axienet.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 970732b162..a44dda5385 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -919,20 +919,27 @@ xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
>       if (s->hdr[0] & 1) {
>           unsigned int start_off = s->hdr[1] >> 16;
>           unsigned int write_off = s->hdr[1] & 0xffff;
> -        uint32_t tmp_csum;
> -        uint16_t csum;
>   
> -        tmp_csum = net_checksum_add(s->txpos - start_off,
> -                                    buf + start_off);
> -        /* Accumulate the seed.  */
> -        tmp_csum += s->hdr[2] & 0xffff;
> +        if (start_off > s->txpos || write_off + 2 > s->txpos) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: offsets outside packet, skipping checksum\n",
> +                          TYPE_XILINX_AXI_ENET);
> +        } else {
> +            uint32_t tmp_csum;
> +            uint16_t csum;
>   
> -        /* Fold the 32bit partial checksum.  */
> -        csum = net_checksum_finish(tmp_csum);
> +            tmp_csum = net_checksum_add(s->txpos - start_off,
> +                                        buf + start_off);
> +            /* Accumulate the seed.  */
> +            tmp_csum += s->hdr[2] & 0xffff;
>   
> -        /* Writeback.  */
> -        buf[write_off] = csum >> 8;
> -        buf[write_off + 1] = csum & 0xff;
> +            /* Fold the 32bit partial checksum.  */
> +            csum = net_checksum_finish(tmp_csum);
> +
> +            /* Writeback.  */
> +            buf[write_off] = csum >> 8;
> +            buf[write_off + 1] = csum & 0xff;
> +        }
>       }

Output of 'git-diff --ignore-space-change' of this patch:

-- >8 --
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 9f5f65ecfac..d35f4a847d6 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -923,4 +923,10 @@ xilinx_axienet_data_stream_push(StreamSink *obj, 
uint8_t *buf, size_t size,
          unsigned int start_off = s->hdr[1] >> 16;
          unsigned int write_off = s->hdr[1] & 0xffff;
+
+        if (start_off > s->txpos || write_off + 2 > s->txpos) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: offsets outside packet, skipping 
checksum\n",
+                          TYPE_XILINX_AXI_ENET);
+        } else {
              uint32_t tmp_csum;
              uint16_t csum;
@@ -938,4 +944,5 @@ xilinx_axienet_data_stream_push(StreamSink *obj, 
uint8_t *buf, size_t size,
              buf[write_off + 1] = csum & 0xff;
          }
+    }

---

Queueing via hw-misc, thanks.

