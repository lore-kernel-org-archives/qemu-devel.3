Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D127CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqPJ-0003Lf-4S; Mon, 05 Oct 2026 17:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqPD-0003L2-H9
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:39:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqPB-0002VH-Ko
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:39:31 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KMjTr2989233
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zb3C06zGcTh30UiV9I8U8PQ2ELJ9z6bSQ6XHbHODDB8=; b=okHCZT7x15RKXJts
 iDPEaJfL3n8ljBuhqpTvXqW/miQrp6qbBCJxaWwbd3nasfohDRw6W9skiRaV6j2t
 jSVmoWALCEX0XvKZRqXtDVX5iy7AAmkKFbCK4TkZWpPMQxG0qrPYmBecn1DJy7e9
 uh+kG47ipnr1TKjFl1aFwA36BLtOz8O6pggts4xyBJULY5JTrwKm1T1i//h0wKch
 l4lftCea9K18GSQ4ouWTUZ3gJQqhRHbkfL6ULo4wqh0EiuKGdKZID9utpjCxZHUR
 Z66wTvZf/80BV93azO+DrkYLG3FbCDYGw1uHn0BEEBS/WvcJ85VRj1KcCwdzSC99
 Hk2OAA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3gqs6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:39:27 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso3479653c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791236367; x=1791841167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zb3C06zGcTh30UiV9I8U8PQ2ELJ9z6bSQ6XHbHODDB8=;
 b=gJverr0JXnS2GgqAEmfVZwbO9Tp7hsZbi/0Midx0WvuIZLMGXb1ulAYWDUrbaD8fFA
 j28btA1TOXRFEBhYM8t+n5/pGAOq+l3tH5Zs0RucLvgPFJXgUSlm5Z6e3dEa1AxF51F3
 4Vmi9GP/cQog+JlS0zYXYwRZ/ElUviEg588fVHZcfUAOEsl+2eWMR0QlkyrSTlVkJa5K
 kTxJPUZbaWe9ikduzOFmSX1ld7GQwYOUkySjWQ9FGO2shbLIC9NRCsjkulrhdYzZd6vw
 SOitH/9tiwljIKzIrJ7trKvBm4wFQx+fu6BMpAhkDxMxhs+qwcJYS/mv4ViIygUgKina
 AXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791236367; x=1791841167;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zb3C06zGcTh30UiV9I8U8PQ2ELJ9z6bSQ6XHbHODDB8=;
 b=PrMbYBe6Os4lQBHFpENSa2W283PTI60d2h23867oodb1hAmKlb+epHQLA/x5JaXIPs
 BetiLbxD3E3Ucql4Ne+AHJifMsqL3nl11pyBuzuQ/cWgu7So4/41R3TAumMORY4pSZnI
 lXE9a8knejxFvIFrMgUer07B5hPwuAE95zjWGGNG2JEpoO1YjBHSy5Hk3IXlWOk7ej4r
 cP26C9p43Dq4yryAUWwX2jVe//1EZIk/Jn5ZK6ecskw/xHAY8KA2CZZgaXpI8eNMXZ3j
 xGDs4tvKvCO1XLhRi/5F+qRp4Ue7CgFl88FYUxY7PrCdprULa8yuddyWNlQczmFqaOuJ
 z/ZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzG+2BILrwJ38qf40n74yrTiPngEt1hf3IjXb6QY/96bjgXu0noivkFiYPO4xDypLqMo+ptItpn4nw@nongnu.org
X-Gm-Message-State: AFuF++lG3kGQiO3I8/ZE1eB59et/2aCx7zCAUXbBDW4rG0EsyX6E2m7W
 bJu5PuQEEHopiUHOiv5AN/UnTfA4D8atJrTK+7Lpz9fM+cBO9QFYQHiaXNuChNiIGn0fxe5YeC0
 8L2ATZVPt8GljJGAEog8g9S77X2u6YfoLzEG95aZdZCORTZUXyvEFtwj9IQ==
X-Gm-Gg: AYBFou2LpAcYGsxpgwMDqpiMyQ16c28FHHDXT5xuQrro0pm1kh2vTKZSIn7WBZ0vCur
 KJaYeH9yOVKXXsvw5o1hnxEaXI9WDF2q4INGvooeNIwES6zaBAlITsvRyLyjmhfkT2rzlwp2JsU
 w115rBTJJKXC1Uf1xF3MCcOb+8cPOpYUEZuGD79X6P2iyD1nl2l2OP4hnVAlW+EROfrGcFceInj
 5xVfcYOYQ6whJXDDPK3NfDhhtMVuU1F3aO2FMvjw6omZCGKifca0wC2FBIz6CFzxdkFjf0hKOfi
 XZa0xMo2ValqiUmo23dnMa6o4+QI5LygZN8l5OJ+QfD2L+RGf7N+y4RC455ZHuzdtdVUUepJLri
 EqOu4tng7k6s/3DgJ02MVkYhFrSFtckYUpAKLla5Gbzi1a2enToFOmjYKKmYjto1qLbX3TA==
X-Received: by 2002:a05:701b:4253:10b0:151:2e62:fe95 with SMTP id
 a92af1059eb24-151c36c254amr12941970c88.30.1791236366712; 
 Mon, 05 Oct 2026 14:39:26 -0700 (PDT)
X-Received: by 2002:a05:701b:4253:10b0:151:2e62:fe95 with SMTP id
 a92af1059eb24-151c36c254amr12941925c88.30.1791236366014; 
 Mon, 05 Oct 2026 14:39:26 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d84ec510dsm1300100c88.13.2026.10.05.14.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 14:39:25 -0700 (PDT)
Message-ID: <d8b1b432-3f11-4870-90d5-d9d4c34b0e5f@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 14:39:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] target/hexagon: reserve internal HVX vector
 state for QFloat
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, richard.henderson@linaro.org,
 Helge Deller <deller@gmx.de>, marco.liebel@oss.qualcomm.com
References: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
 <20261005032616.1293829-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261005032616.1293829-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rBvY92VNFCBYTrJC0TKNSOxAjNtJnu2W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfXybD22jQQspRZ
 S21WrmPWEgJbWRpQwMOPRWyVCjtpvleNEd58cD3+ZTauwik0wGA9Ktp8Rx6YNEdyASVuonaR0qR
 vkJe/33c2EliUwjjhbjkJ/TwVIyvTKU=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4190f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=mRR4RHvrE3b9SbVWK9IA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfXyQMj1Tct/fiz
 6sN/dwD1WkrDgOkk/Q3NyvIDErrDDmBD6px0/2jMYH44xkHk47B+gOluR/Wv7L8YOTWaBoLJtbs
 5JYVsu3W9WDD5apb4w4iquDCLHlfgFucaKcPPeYyXOKl9BeWfdPKvlabET9ZxAjKh3TrKOxU3PZ
 EZdWhfkPSUHAAZfsgFR2neVCfVqC03gF2urIuTTMMnW6vMd4Y8HI6pWxkcx26WDC2Hf7PVTq/zK
 7/rUnpR15k2asQ1OvyVUOcrh2y/Jjca9beEaXQmJ3A1nu6crZVibdK2YkilzeEMawxMxGkMfxWA
 4EXcBd8B1VT02nr5q39dgNmoic2hKhE6T2MDgyf4A+eLvGBmOiqDq9ZdclamGUZFx5FZpXgG3ku
 Mfto9CyJBInK/NuHyvEJZPrzBFSAHZcPabqErbVFAatUqypZTUU59/s2B60iIxVDlDMl+P9mOeS
 ZWGAAncU7RTJNaAsqNw==
X-Proofpoint-GUID: rBvY92VNFCBYTrJC0TKNSOxAjNtJnu2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/4/2026 8:26 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/mmvec.h     | 55 ++++++++++++++++++++------------
>  hw/hexagon/hexagon_hvx_context.c |  5 +++
>  target/hexagon/hex_common.py     | 29 +++++++++++++++++
>  3 files changed, 68 insertions(+), 21 deletions(-)
> 
> diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
> index 662f9d1597e..462d66b686b 100644
> --- a/target/hexagon/mmvec/mmvec.h
> +++ b/target/hexagon/mmvec/mmvec.h
> @@ -33,29 +33,42 @@ typedef uint32_t QRegMask; /* at least NUM_QREGS bits */
>  
>  #define VECTOR_SIZE_BYTE    (fVECSIZE())
>  
> -typedef union {
> -    uint64_t ud[MAX_VEC_SIZE_BYTES / 8];
> -    int64_t   d[MAX_VEC_SIZE_BYTES / 8];
> -    uint32_t uw[MAX_VEC_SIZE_BYTES / 4];
> -    int32_t   w[MAX_VEC_SIZE_BYTES / 4];
> -    uint16_t uh[MAX_VEC_SIZE_BYTES / 2];
> -    int16_t   h[MAX_VEC_SIZE_BYTES / 2];
> -    uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
> -    int8_t    b[MAX_VEC_SIZE_BYTES / 1];
> -    float32  sf[MAX_VEC_SIZE_BYTES / 4];
> -    float16  hf[MAX_VEC_SIZE_BYTES / 2];
> -    bfloat16 bf[MAX_VEC_SIZE_BYTES / 2];
> +/*
> + * Fill value for a vector's qfloat extended-precision bits (MMVector.ext,
> + * below) whenever an instruction that isn't qfloat-aware writes that
> + * vector: architecturally the ext bits are unspecified in that case, and
> + * this repeating, recognizably-not-zero byte pattern is used instead of an
> + * all-zero fill so stray reads of stale ext state show up distinctly
> + * rather than silently looking like a valid (all-zero) qfloat result.
> + */
> +#define V_EXTENDED_BYTEVAL 0x0a
> +
> +typedef struct {
> +    union {
> +        uint64_t ud[MAX_VEC_SIZE_BYTES / 8];
> +        int64_t   d[MAX_VEC_SIZE_BYTES / 8];
> +        uint32_t uw[MAX_VEC_SIZE_BYTES / 4];
> +        int32_t   w[MAX_VEC_SIZE_BYTES / 4];
> +        uint16_t uh[MAX_VEC_SIZE_BYTES / 2];
> +        int16_t   h[MAX_VEC_SIZE_BYTES / 2];
> +        uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
> +        int8_t    b[MAX_VEC_SIZE_BYTES / 1];
> +        float32  sf[MAX_VEC_SIZE_BYTES / 4];
> +        float16  hf[MAX_VEC_SIZE_BYTES / 2];
> +        bfloat16 bf[MAX_VEC_SIZE_BYTES / 2];
> +    };
> +    /*
> +     * Extended precision bits for qfloat: one byte per qf32 element (only
> +     * the low 4 bits, the LREQ nibble, are meaningful); two qf16 elements
> +     * share a byte, 2 bits (LR) each.  Any instruction that overwrites this
> +     * vector without itself being qfloat-aware fills these with
> +     * V_EXTENDED_BYTEVAL, since they're only meaningful as the tail end of
> +     * a qfloat computation.
> +     */
> +    uint8_t ext[MAX_VEC_SIZE_BYTES / 4];
>  } MMVector;
>  
> -typedef union {
> -    uint64_t ud[2 * MAX_VEC_SIZE_BYTES / 8];
> -    int64_t   d[2 * MAX_VEC_SIZE_BYTES / 8];
> -    uint32_t uw[2 * MAX_VEC_SIZE_BYTES / 4];
> -    int32_t   w[2 * MAX_VEC_SIZE_BYTES / 4];
> -    uint16_t uh[2 * MAX_VEC_SIZE_BYTES / 2];
> -    int16_t   h[2 * MAX_VEC_SIZE_BYTES / 2];
> -    uint8_t  ub[2 * MAX_VEC_SIZE_BYTES / 1];
> -    int8_t    b[2 * MAX_VEC_SIZE_BYTES / 1];
> +typedef struct {
>      MMVector v[2];
>  } MMVectorPair;
>  
> diff --git a/hw/hexagon/hexagon_hvx_context.c b/hw/hexagon/hexagon_hvx_context.c
> index 3b73498298e..575ea74fc94 100644
> --- a/hw/hexagon/hexagon_hvx_context.c
> +++ b/hw/hexagon/hexagon_hvx_context.c
> @@ -15,6 +15,10 @@ static void hexagon_hvx_context_reset_hold(Object *obj, ResetType type)
>      HexagonHVXContextState *s = HEXAGON_HVX_CONTEXT(obj);
>  
>      memset(&s->regs, 0, sizeof(s->regs));
> +    for (int i = 0; i < NUM_VREGS; i++) {
> +        memset(s->regs.VRegs[i].ext, V_EXTENDED_BYTEVAL,
> +               sizeof(s->regs.VRegs[i].ext));
> +    }
>  }
>  
>  /* gvec needs VRegs/QRegs 16-aligned within the struct. */
> @@ -26,6 +30,7 @@ static const VMStateDescription vmstate_mmvector = {
>      .minimum_version_id = 1,
>      .fields = (const VMStateField[]){
>          VMSTATE_UINT64_ARRAY(ud, MMVector, MAX_VEC_SIZE_BYTES / 8),
> +        VMSTATE_UINT8_ARRAY(ext, MMVector, MAX_VEC_SIZE_BYTES / 4),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index d344284e8a2..b418aa716b8 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -448,6 +448,25 @@ def helper_arg_type(self):
>          return "void *"
>      def helper_arg_name(self):
>          return f"{self.reg_tcg()}_void"
> +    def gen_clear_ext(self, f):
> +        f.write(code_fmt(f"""\
> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
> +                    {self.hvx_off()} + offsetof(MMVector, ext),
> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
> +                    V_EXTENDED_BYTEVAL);
> +            """))
> +    def gen_clear_ext_pair(self, f):
> +        f.write(code_fmt(f"""\
> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
> +                    {self.hvx_off()} + offsetof(MMVector, ext),
> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
> +                    V_EXTENDED_BYTEVAL);
> +                tcg_gen_gvec_dup_imm_var(MO_8, {self.hvx_base()},
> +                    {self.hvx_off()} + sizeof(MMVector)
> +                        + offsetof(MMVector, ext),
> +                    MAX_VEC_SIZE_BYTES / 4, MAX_VEC_SIZE_BYTES / 4,
> +                    V_EXTENDED_BYTEVAL);
> +            """))
> 

According to previous patch, do we want to use sizeof(MMVector) here?

