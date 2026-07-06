Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58598C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgePJ-0008Fy-0i; Mon, 06 Jul 2026 04:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgePH-0008Ec-O9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:10:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgePE-0003GF-Sh
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:10:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641Swb3459096
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NCqjXVBAcphH6bgcVF/FSO75xoQ/plzIdNFfJIMVrsY=; b=eu3qy3rS5QeAtwpE
 JfAPe8inwcPZ0eOYYFj3lJZ1Qzc9iIA4ELDEwSShdxqkq55zh4EQCQqI70sorDuD
 gfvB/t6GSZco1640nw5Na1jq32rEt25qiUvwPrtDU2PC2yd3i8UXtNAoHN9kYVnR
 SL/YdDLedbeG489oeKEFWYsAfTmZqHk9axfN3QnmYvbjD1QMeIjaf3a+/rc24UBy
 a4to5ig9ii+b4AFJPjdvhhS0o9tR2otz6NQg01llcL5Uu5H74SSIW0dG/Hwnnpjr
 YoE4WjYtSBbU84KTeB+bV33jsInfJCa+wQQaHAkCouVAgyCOqtnpAQtyOJbTraZI
 6XKcTA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf8529n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:10:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e632390d2so523777385a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783325418; x=1783930218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NCqjXVBAcphH6bgcVF/FSO75xoQ/plzIdNFfJIMVrsY=;
 b=P/GCTI/jYqj3O4DFLri/KG9db/0UuwviQ0Hkx6B4ChyqQrSFQBiUaRT8gN9P8Gm37r
 OxSPTNVULEHWHIuVWOfe1UwygQtxuFLjWRfKBD7nv56a3/TTboonwVlBmVMQftG/ZHjZ
 8wRZgttcO1SZ7iDWGcFKENfpoy25WO+mx/HIoauont7ZG2lOjX/huLbvPVqsR15OY3gc
 vcUZTygDiEHeShKXZERDl7cITX1opVwXKAixk/FyitEwMdqV06O3xWF8xdsOO2LFPBS5
 cNNo5vwJ+LeGqMGX3t9lRkUI2IL6TMjKUfThC2j0KkQoKI+uChLbSKHyXs2Qbc5wPnk9
 UlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783325418; x=1783930218;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NCqjXVBAcphH6bgcVF/FSO75xoQ/plzIdNFfJIMVrsY=;
 b=UDrpr3Oz0XjfRUXHbyjwOw05zS47Yqh/3xPk7A0Sm/HWEy3t2KBPcHUlG3oGGzDnqW
 OuEI/Snl0U57uptUQVx7Ai7k4ZiXLF9PyvAJpgKOAM+cL4Vb5HloTyUpwFTSxS7KEutn
 Bl5c4jC7GauTAQDoTorMfkbYbo7Sw1VF/IZAf2FsvX5pzkkY9Dxnbbu+RdIf5d8X6pEr
 Pkl1EWQxSaVw0JAlsFxF5VN83efql4af8z3Pqgoo49q0BQPQJh70qUnOw6zbO+s1o6En
 Nea6uIZEahRnwudvVx3fq0iakJA7+uNMGEi/VGerJR63VgH1KL6zpHhkQlPvRjSD5tMz
 JBDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHWl6zYzxvXjN/gfUBeJLRAUvDNQ3lWc4FPYyJhEmYSXCVQOQzXja35HV0arjv6qvRShilBchCIIpD@nongnu.org
X-Gm-Message-State: AOJu0YyxZ4Z8LMIeDPdNCLTf4MBf15vwr5x4VXwkCLtJPyr8aQyv8nrE
 CTNPh+Qn3P9qLu72kLLjcRgJ16Qyvh4w3FhXYAj4y6Q4KDz1WkWzFGGY4it5oZA5QFb642Zl4gP
 y4NqoTHdkyCjMFMiyDK/oz1UlePF7dcecfWMhCzxYzMlY32QTHt+0PbN8vQ==
X-Gm-Gg: AfdE7ckz/iPSm1nUfXPCUC1kP5e/l3tM9C82+SPDtxrMjpDZardsv9te/PZlY+85NrV
 8rkkis3Qi654a2j34fH8spn8vgkbw5cGT1zzZPqx1zmSO1v9/bNgK1PhNwYcr7aWd79bi/is3ft
 CCKw5AptE8yXCblXxGAb3kHWyyEg29RzCkFrKM1DkzN32YYU3cfe+8kETXY7VK3wxns2OUTlHZg
 kj+RJIHsR5/vwyjSKzirC8kKL0fvfNB+aVotV0J79bCWv+5v9cCHG+n7j5YGkH+a1ftHEzQVAjA
 pm1PcD7f/fyIgSkCClUwiLS5NP2nfiTfjknqw3SsemGYvj8j6M8GPHZagA8pqV5eIcK8mCk95sO
 xgwKOonq6GZ9dCTjuASX9JRoO3Zm2X3DlcG71JnYoaJ5c8KsG+ngjoiogg5wSRA==
X-Received: by 2002:a05:620a:450f:b0:92e:8a8d:ec1f with SMTP id
 af79cd13be357-92e9a350504mr1294561285a.24.1783325417885; 
 Mon, 06 Jul 2026 01:10:17 -0700 (PDT)
X-Received: by 2002:a05:620a:450f:b0:92e:8a8d:ec1f with SMTP id
 af79cd13be357-92e9a350504mr1294558085a.24.1783325417409; 
 Mon, 06 Jul 2026 01:10:17 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b628d632sm682303466b.31.2026.07.06.01.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:10:16 -0700 (PDT)
Message-ID: <7410bfdc-e1b8-4cb7-8e55-5908104290de@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:10:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/ssi: xilinx_spips: Fix dummy phase handling
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <20260630135729.466264-7-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630135729.466264-7-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TtX_TSudRL29zTPv27V_x6RSLlteVpW2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MSBTYWx0ZWRfX048MX7ywD1rF
 IHbSgqAVsh1B8xrGgp3Mm69Dkh2CkwHIOhkOA1OjkuoDvZSPQSWii1KqS3bNZ1RQj4IWKFF5TJi
 oECcuFGTjBIdNWX/ToIFOxMZGC8w6b8=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4b62ea cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Am4ss40yAAAA:8 a=FRSEYCzRAAAA:8 a=ZmCK42fXN8tGheKeWVsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=lf-hbUz_c89dky27wAWH:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: TtX_TSudRL29zTPv27V_x6RSLlteVpW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MSBTYWx0ZWRfX2+9lqCdsfhrP
 pw6YaWwt6VtNypO7RZX7E5WsmWdZGF7bhf8jbMhRzc9O7rAQqIROkos9RxaXUux+5zwsKalqQVV
 VAZHytSyYoGAvNCgwvydSWMxKIq1tsy/OugaaQzOS+AmsGzqe2h9J5pALZGyv6Odcje/dv7XVrd
 pvGLjbREDF+Hxnbwq5kjYs66nd10dRGt7OoeG4ie/eVl45HKAHx5P+oTCJaHjwx2WVvAqAMM3YC
 wLsfhgqyuJDfopKHeEFHQoD6iuwFcTzURvqU7dY4e3BJkxRq0dattVC117HiN1LMIM7RcDPnHEo
 bLhDAgtrFXvmu/a3TelJN6TLcDu6ndLENZPLcJNB+/YCzffOVBTfqmWFS1s4I6qjysUzm+vNcSg
 kBigTyRe/OkVKeX99sJwG2Pqnv909e9EOCQxuQqXTira+UF3E8j+1O+36OXXeJp6goqKuVqPBwR
 bCV/wsuVs4LO5eTehUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/6/26 15:57, Bin Meng wrote:
> The ZynqMP generic FIFO encodes dummy phases as a number of
> dummy cycles. QEMU's SSI bus transfers whole bytes, so the
> controller model must convert the programmed cycle count to the
> number of SSI byte transfers needed for the selected SPI, dual SPI
> or quad SPI mode.
> 
> The legacy Xilinx QSPI snoop paths had the opposite problem after
> the m25p80 dummy handling was fixed. They still treated each dummy
> byte queued through the FIFO as a request to generate several SSI
> transfers based on the current link width. The flash model now
> consumes dummy phases as byte counts, so the manual FIFO path should
> forward one SSI transfer per dummy byte.
> 
> Update the Xilinx QSPI dummy accounting consistently for the generic
> FIFO, manual FIFO and LQSPI direct-read paths. Also make the command
> table report the dummy byte counts consumed by m25p80 for dual and
> quad output reads, and account for the mode byte before LQSPI data
> reads begin.
> 
> This matches the ZynqMP TRM (ug1085, v2.2 [1]) description of the
> generic FIFO dummy cycle entry and keeps the controller side aligned
> with the flash model's dummy byte ownership.
> 
> The description of the genenic command fifo register says:
> 
>    When [receive, transmit, data_xfer] = [0,0,1], the [immediate_data]
>    field represents the number of dummy cycle sent on the SPI interface.
> 
> [1] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
>      table 24‐22, an example of Generic FIFO Contents for Quad I/O Read Command (EBh)
> 
> Fixes: ef06ca3946e2 ("xilinx_spips: Add support for RX discard and RX drain")
> Fixes: c95997a39de6 ("xilinx_spips: Add support for the ZynqMP Generic QSPI")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   include/hw/ssi/xilinx_spips.h |   2 +-
>   hw/ssi/xilinx_spips.c         | 120 ++++++++++++++++++++++++----------
>   2 files changed, 88 insertions(+), 34 deletions(-)


> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index f6e717bc01..fa98dc2dd8 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -192,6 +192,10 @@
>       FIELD(GQSPI_GF_SNAPSHOT, EXPONENT, 9, 1)
>       FIELD(GQSPI_GF_SNAPSHOT, DATA_XFER, 8, 1)
>       FIELD(GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA, 0, 8)
> +#define GQSPI_GF_MODE_SPI     1
> +#define GQSPI_GF_MODE_DSPI    2
> +#define GQSPI_GF_MODE_QSPI    3


> @@ -457,6 +461,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
>           int i;
>   
>           if (!s->regs[R_GQSPI_DATA_STS]) {
> +            uint32_t prev_gf_snapshot = s->regs[R_GQSPI_GF_SNAPSHOT];
>               uint8_t imm;
>   
>               s->regs[R_GQSPI_GF_SNAPSHOT] = fifo32_pop(&s->fifo_g);
> @@ -484,7 +489,54 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
>                   }
>                   s->regs[R_GQSPI_DATA_STS] = 1ul << imm;
>               } else {
> -                s->regs[R_GQSPI_DATA_STS] = imm;
> +                /*
> +                 * When [receive, transmit, data_xfer] = [0,0,1], it represents
> +                 * the number of dummy cycle sent on the SPI interface. We need
> +                 * to convert the number of dummy cycles to bytes according to
> +                 * the SPI mode being used.
> +                 *
> +                 * Ref: ug1085 v2.2 (December 2020) table 24‐22, an example of
> +                 *      Generic FIFO Contents for Quad I/O Read Command (EBh)
> +                 */
> +                if (!ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT) &&
> +                    !ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE)) {
> +                    uint8_t spi_mode = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, SPI_MODE);
> +                    /*
> +                     * Some ZynqMP GQSPI drivers, such as Linux, use the data
> +                     * bus width in the dummy GENFIFO entry only to configure
> +                     * the controller mode. The immediate value is already
> +                     * the number of dummy cycles for the dummy phase, which
> +                     * follows the address bus width. Reuse the previous TX
> +                     * phase mode to convert cycles to SSI bytes.
> +                     *
> +                     * This does not make the model Linux-only. U-Boot emits
> +                     * the dummy entry with op->dummy.buswidth, so the entry
> +                     * mode already matches the dummy phase. Its opcode and
> +                     * address phases are immediate entries, not DATA_XFER TX
> +                     * entries, so the override below is not taken for U-Boot.
> +                     */
> +                    if (FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
> +                                   DATA_XFER) &&
> +                        FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
> +                                   TRANSMIT) &&
> +                        !FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
> +                                    RECIEVE)) {
> +                        spi_mode = FIELD_EX32(prev_gf_snapshot,
> +                                              GQSPI_GF_SNAPSHOT, SPI_MODE);
> +                    }
> +
> +                    if (spi_mode == GQSPI_GF_MODE_QSPI) {
> +                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 4, 8) / 8;
> +                    } else if (spi_mode == GQSPI_GF_MODE_DSPI) {
> +                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 2, 8) / 8;
> +                    } else if (spi_mode == GQSPI_GF_MODE_SPI) {
> +                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 1, 8) / 8;
> +                    } else {
> +                        qemu_log_mask(LOG_GUEST_ERROR, "Unknown SPI MODE: 0x%x ", spi_mode);

Is it safe to let the previous s->regs[R_GQSPI_DATA_STS] value?

Alternatively simpler as:

  if (spi_mode) {
      s->regs[R_GQSPI_DATA_STS] = 2 * (spi_mode - 1) * imm;

> +                    }
> +                } else {
> +                    s->regs[R_GQSPI_DATA_STS] = imm;
> +                }
>               }
>           }
>           /* Zero length transfer check */
> @@ -550,7 +602,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
>       }
>   }

