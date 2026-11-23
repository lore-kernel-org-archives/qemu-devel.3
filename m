Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB0606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bygXG3Lh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F+4cajU8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXQ1-000511-H7; Mon, 23 Nov 2026 12:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVXQ0-0004xY-Fh
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVXPy-0007Zq-Mk
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:28 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGsoo846530
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BkZ09VXXsRV84lZcTD5XnHjWy+VMa0p3/VFnQBqC2W8=; b=bygXG3Lh+QDTPpq8
 mJlaaL9588D84AtrSI5JMd4ZFPkPOulqrECxQ+Zf6jlujGvRIjTL/AR8JZZgpUCg
 goKH4Zz/GftnQ1oPCZNNe+8M+aJFgcTxxmipXT7E84EtxQDDiCPxpyuxLV1pufOf
 dbYnxlzdavpNOU7RUvCoUKF0r3qDz3rIvM8LcdS3G/mnuJFRWeXbipfxkm0wZpNR
 j6ZEekxjO1gtGrjKGMGL8pn6cLzcK/pIho4HcvXSu/K7o6897hth8gqABjm6XD/z
 PqpFPbEICxZuTnxRzSpe9r+cm9BBWuVcgQ2l7tHAq4qNMys8lXA4CoF4xGrofXmr
 GDUjUQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g742fxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:01:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55d3e7ba879so72205321cf.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795453285; x=1796058085; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BkZ09VXXsRV84lZcTD5XnHjWy+VMa0p3/VFnQBqC2W8=;
 b=F+4cajU8SF2S1R/tv2K+V0gQMZjEcOCNInri1udkiGnio7c9ldK4MKM+Ku9PsXnLmi
 PpWZfLv5X4VSYCBM3H+t2rWXyHsOKTLIvi5JhFTP90D3G9LvoSToigYp3FgF2Gmtsrtm
 b5EfEy39FuBV4hl6Qv3AUJFhv31GMGxsU8irFXH+jAQESGHVZPe1NCcbYy9mwaiUMbqA
 TaeCdB5AuvGWghx8ud+n0h3i/6FKycE2GRo3T5QFdOnpjnYePQgLhjI8qVWMnDFz0jVr
 SP1K1cTKBJ7r4QTtzeoBTSKTD4iU7AqLdcXsuQeziFHL8fbo/MXloPuosj/WQUNuuChd
 /5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795453285; x=1796058085;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BkZ09VXXsRV84lZcTD5XnHjWy+VMa0p3/VFnQBqC2W8=;
 b=q397fsI/EgjeeUT/6DgsrHpiKBDkIo0aeZXg/EDe4hEYoF5w9x8MM2l+ColO1LIW8e
 ceDSYKoaTLNBRX1ONJZPNsFMutDQHp/7Fejedn3bw/p0yKn1NCFAY5h/+CYipynOEJOn
 IThcc8ZrTUBlSKLnxDBxQwMHIeCWKNQCQOd5LZqXb0NaCewS0i2Hf09LtphpLMecPPfL
 wdFTtv/q/zD1kZOoktLiQ+e+Od1QFPhGaq4ZGNCiAbIbOLBOfzkX+NonV/bM77CaC54B
 q0Sr4W7o+qRlP00dhgKeXkzlrLflWRMITxsGP8uQbGURqt0jPY7wXshMrJGpj8qJ+dDQ
 geeg==
X-Forwarded-Encrypted: i=1;
 AL+hErFilgMjyuN+MtohxY2A/YL7K6i2pQnGWDda9dJRxT/2k1eV2csToOm24RzZ9V590aXTgGU6ZTzNLweg@nongnu.org
X-Gm-Message-State: APuU4Z8oXv5K36AHPPw+YGcyiEXcVYYe33edQXTcAuaxRoWx+6NMvxQx
 ibRggCHZlloVZ/nL7Pml0emWPWAKJ3xuvNMpgCKUvx62PE7MUQFnBQZITZpp8CjXSKSxhO2JtDy
 YHpiaLyO3I2iMOTZG3NCBIcB52QyHwLsdGQf8rGngLhYyPp09aYTp+1QS7Q==
X-Gm-Gg: AZFdTZdJm84WZmjYfrJ/VSinkqph2EBjJkLYQ+ApvJRhrGyWnu8B8G3nvEeVEUchte1
 cdMkNY67HUUm7Y9NEm0Qnh6XlKOs9JoyXwEORYWE0/oLx1160ukRpslG8cnm/Fdr4SLgnfnMsMK
 caODTzNOSwyIUwF1d6i1FwWK6InEXgGHuXdgB9DPvx0nTooArsqxsUHuNFqYBgzgo1ZndWKWRok
 Xh5ye/W959XXlTjZwLkX6oez7bwCIMvEXSPI0xSy8WLDuvqDvdN1tzGvrzLhC1h1W5hszTQJEtv
 iwaLxQHQO9odlVkXnULO/IRYge6uE/SE39T1buNm7+UQP5WDBrOcLGEEBdL91Gf3vbL0Fa/DDYv
 tpZD/ZAk4Fes/XOmi8jwsLf+NTx+YuOtgElIB404v8jjGegcegzcsXttpNJeuXDcVPiu8Izku+R
 dP/ohX3rcr
X-Received: by 2002:a05:622a:4d8f:b0:538:68d:2557 with SMTP id
 d75a77b69052e-55d76a50bb4mr207452791cf.52.1795453283179; 
 Mon, 23 Nov 2026 09:01:23 -0800 (PST)
X-Received: by 2002:a05:622a:4d8f:b0:538:68d:2557 with SMTP id
 d75a77b69052e-55d76a50bb4mr207451941cf.52.1795453282517; 
 Mon, 23 Nov 2026 09:01:22 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882ea2dsm103331111cf.15.2026.11.23.09.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:01:21 -0800 (PST)
Message-ID: <7cb533fc-c548-4672-aee9-845a20110196@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:01:19 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] target/riscv: Write zero into mtinst/htinst for
 SSPUSH/SSPOPCHK faults
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261117132638.1452474-1-alvinga@andestech.com>
 <20261117132638.1452474-3-alvinga@andestech.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117132638.1452474-3-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XkyzwDlsi_qGO8ViCTAPO6won1lVQvEm
X-Proofpoint-ORIG-GUID: XkyzwDlsi_qGO8ViCTAPO6won1lVQvEm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NyBTYWx0ZWRfX6gL+gcn8Jb3J
 64DFPCbyyWJ+a1YqIjpFef0dnQ9FaqIUcspeHeiUaZ0kh3kDtXcFzG8kMGuci2LOHcXB5DbmM+P
 qDOVaVvX2Hq7LufiQQ0H9Uj7MzlZNrQ=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b047165 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ZT-azI6cAAAA:8 a=EUspDBNiAAAA:8 a=BsD7GTkV_ejyhaxPsnQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NyBTYWx0ZWRfX/xTXGxe2LNGo
 PtCHF8g7uA8uz0dxTlWMo6A6wY5YWajVpaSZCdOXMqRAa95CkaubUH/2c/gurj1Nski6JD+aEqc
 F/H+Lxtwgo/vMpTj5+ow6sd7DhyKOc5kIX6Wz92f7Af4dbV5VDIgL/5n/UtFrmUTwBcr7TqtIj9
 qFf7vzdWL27OxCDYuhdv3+W0LIhfds4HSHh0pC2/NK/XgIG2sfGG0N9B9VnNrKibfBqiXqvWEmd
 VO0aldMbx0tR7uW+JZkX/mCUxc4DYUJ6UyLfXiaR7UcRHRI+bA6twE0bX64gmZKJE/FHmMJYCnb
 ngpftOj1SYsfL8L+KaPHVXmHoKosABld7LjiPvYSe1QhtkHDw0nVBY927aNNhAJzeqYY0fyKQwF
 rqYMwtbvNhhn5kCz8wmfeZlnOoRX0s+0PuLOduIT1YYbjWPLux7lYLzYKIo/RuZc8Ize3xl521F
 1qgf++FN4DDRiYDjzow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/2026 10:26 AM, Alvin Chang wrote:
> The privileged spec defines transformed instructions for standard
> virtual-machine load/store instructions which do not include SSPUSH and
> SSPOPCHK. The spec also says: "If a synchronous trap occurs for a
> standard instruction for which no transformation has been defined, the
> trap instruction register shall be written with zero".
> 
> So mtinst and htinst should be zero for SSPUSH and SSPOPCHK
> faults. The previous implementation only compares opcode and funct3,
> which is not enough to distinguish SSPUSH and SSPOPCHK from
> virtual-machine load/store instructions. Now we compare opcode, funct3
> and funct7 together.
> 
> Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/instmap.h        | 15 ++++++++++++++-
>   target/riscv/tcg/cpu_helper.c | 14 +++++++++++++-
>   2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
> index bddcf313df..107e7c5a83 100644
> --- a/target/riscv/instmap.h
> +++ b/target/riscv/instmap.h
> @@ -170,6 +170,8 @@ enum {
>   };
>   
>   #define MASK_OP_SYSTEM(op)   (MASK_OP_MAJOR(op) | (op & (0x7 << 12)))
> +#define MASK_OP_SYSTEM_FUNCT3_FUNCT7(op)   \
> +    (MASK_OP_MAJOR(op) | (op & (0x7 << 12)) | (op & (0x7F << 25)))
>   enum {
>       OPC_RISC_ECALL       = OPC_RISC_SYSTEM | (0x0 << 12),
>       OPC_RISC_EBREAK      = OPC_RISC_SYSTEM | (0x0 << 12),
> @@ -187,7 +189,18 @@ enum {
>       OPC_RISC_CSRRSI      = OPC_RISC_SYSTEM | (0x6 << 12),
>       OPC_RISC_CSRRCI      = OPC_RISC_SYSTEM | (0x7 << 12),
>   
> -    OPC_RISC_HLVHSV      = OPC_RISC_SYSTEM | (0x4 << 12),
> +    /* HLV.B and HLV.BU */
> +    OPC_RISC_HLVB        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x30 << 25),
> +    /* HLV.H, HLV.HU and HLVX.HU */
> +    OPC_RISC_HLVH        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x32 << 25),
> +    /* HLV.W, HLV.WU and HLVX.WU */
> +    OPC_RISC_HLVW        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x34 << 25),
> +    OPC_RISC_HLVD        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x36 << 25),
> +
> +    OPC_RISC_HSVB        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x31 << 25),
> +    OPC_RISC_HSVH        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x33 << 25),
> +    OPC_RISC_HSVW        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x35 << 25),
> +    OPC_RISC_HSVD        = OPC_RISC_SYSTEM | (0x4 << 12) | (0x37 << 25),
>   };
>   
>   #define MASK_OP_FP_LOAD(op)   (MASK_OP_MAJOR(op) | (op & (0x7 << 12)))
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 94e385261b..9a1ce61a2f 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -2100,11 +2100,23 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
>               access_size = 1 << GET_FUNCT3(insn);
>               break;
>           case OPC_RISC_SYSTEM:
> -            if (MASK_OP_SYSTEM(insn) == OPC_RISC_HLVHSV) {
> +            switch (MASK_OP_SYSTEM_FUNCT3_FUNCT7(insn)) {
> +            case OPC_RISC_HLVB:
> +            case OPC_RISC_HLVH:
> +            case OPC_RISC_HLVW:
> +            case OPC_RISC_HLVD:
> +            case OPC_RISC_HSVB:
> +            case OPC_RISC_HSVH:
> +            case OPC_RISC_HSVW:
> +            case OPC_RISC_HSVD:
>                   xinsn = insn;
>                   access_rs1 = GET_RS1(insn);
>                   access_size = 1 << ((GET_FUNCT7(insn) >> 1) & 0x3);
>                   access_size = 1 << access_size;
> +                break;
> +            default:
> +                /* Not a transformed instruction, e.g., SSPUSH and SSPOPCHK. */
> +                break;
>               }
>               break;
>           default:


