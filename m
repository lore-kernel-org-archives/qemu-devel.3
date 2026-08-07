Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF9BC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMFr-0006OB-9b; Fri, 07 Aug 2026 11:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsMFo-0006N8-1i
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:13:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsMFk-0004l6-Mi
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:12:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CgIwh943008
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BTwkOrmxEGHfXBg2R4ZnvDkntQbyu8KMxZeWXabhPJo=; b=kTvGoqa1ShlDErLG
 B6kHgZhxENiiLzOLZIGKwaLaAad0qj5e/3aULYSFiUWIO2jbaPjeonO/E4BCNQYT
 TbuJQT7i+6otEuqs218EiFvvhalGbrX5C11p2KIwVula9vcTVHdaIiGKQaOOXI9z
 2EfVrtQrfvwjE5hrcTxUImPur0AHeJ40FSi43CcJLF2RqiufV2spjz0WtjZfk9HD
 ZLNJ2pt6AXBwGCtViQjbi8HYUXq5PJk24XM48Y4+GZKSs3AFPHKWgJXPdGi48yPi
 8oFhN9AejvlpC2BuKR2lrWNQ/b79BX0jQudF5VVTmByJ6On8+178zy75ulReboMS
 F6Lp1w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hckb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:12:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9349c5af52bso611308785a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786115575; x=1786720375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BTwkOrmxEGHfXBg2R4ZnvDkntQbyu8KMxZeWXabhPJo=;
 b=SiuCZD3gAzYZ8kerTqWSvOENTXuBEp9/GW/QDjXj12hmo5skL5UhFPQHonJLAX4C6z
 L9naFTUVC95bo84JriW1vw/NLIycujHzzgc/XOcx/ULHERaQzy5HvC5IQ4Wot4PmtowU
 FCjKg/YC8ncFDEWJ98wxJCvaTs/Q1p4umZtOoP2QjNAVRvC0ZFCeZLBjMq7CFpCglRLm
 ORp5eOu04Adi3XTHN2CmqcrzFYAidUInG1IA8uiCPqUcMu9QJQ8X80Amah5GgZsPOb1t
 wHLU2bclcETsNS0ZjxWRNRhDzyPTSPMbhGFDruYenDdCyV/UoM6kmU5n4q0JfkAkDFsC
 ZHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115575; x=1786720375;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTwkOrmxEGHfXBg2R4ZnvDkntQbyu8KMxZeWXabhPJo=;
 b=qxLxQTgXT591nXu4AUQ5R5Dtp399e7e/aPNQ46EGr/yLin/zIY3jceYlaJfKdqarbJ
 LeXdPA+aTgfhFlo26ehdKn3Oo0ASbDnQoVdSH0t1hQo+HOGb0SYmK7533FyzdASyyGVx
 R/Rie5HIKM1B7hSQXKg9dg2BfjejF3Qoyyl+/WBQV6dxOgOyi4m/cxNi+YBrVeXSnkyn
 zv3+4vx6lmeRy/GGTgVNMZhmbRqsSEvzkRjPSDCz9oJl61T4kH58NuLwvhD0G1zlYO0k
 2H8O7o/pN8lkeXxgqLDuP7UBt2JHXqw/MZ3iVFEnf4ntTYMfWXpPq92xqwWh2oV82GK5
 YjUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiTcrJuDIvnWHQUZHAuhN2vdVUFVgpFhdfQYYEFXH4Idjb0f3oOFh/0hQW4gBFY940auOOmyme+JDu@nongnu.org
X-Gm-Message-State: AOJu0Yzr5moHUdfh3K5uH6R8Vb1KqRbYkkj4a71rDXyctwsBikhicey8
 pvvauTRpepEUBfvCqHPWpQT9sdGCLF5Y4ibYba+6jQOV/Epwh22a3e01pNkIPycjd9WztF8Vxvq
 rKHFmdBThUyjzPuncbUbm1DrFJULsRM8j+pZY3bg3cSW+JO+OIjqb82E+Jw==
X-Gm-Gg: AR+sD12QbIkUIX4aXX4/c/0Y2j8+sFCFJjmxmavK/teZNWV2Vp4DkY5CRIDbToargiB
 FvYR3Jz/G2Vvii19d8EFE9MujYFjIYvpTiBoXfnKhVGGgL0UeQcS8u4WkXnKGjqRvTYo6a02FmH
 28awcMLKpWUEm0qLT7D2s+vI/K3lKurRFtqeXLMS9B6Mym46uR0EN2xdFxfKH6T2fyjecrJmqSK
 TiksJprRVxUjezG9vGkrbbvmgpXNVHnBpmtwP4DGvrpEGiiy9OhGIT49joKw6wNT5YGX87T+jbL
 Qhs6r9b/m/EWJ1xsHresOzW9J1T/mWYYpq4mgqiwuqejRxyRAj8Q2nqJt/L21yw0L38eiZIN9QN
 bQ6wz87kYhcKbOyHBleETmPvzwKbQyWtteX8o
X-Received: by 2002:a05:620a:950a:b0:930:a718:bafb with SMTP id
 af79cd13be357-9367978f467mr83403485a.10.1786115574665; 
 Fri, 07 Aug 2026 08:12:54 -0700 (PDT)
X-Received: by 2002:a05:620a:950a:b0:930:a718:bafb with SMTP id
 af79cd13be357-9367978f467mr83396885a.10.1786115574157; 
 Fri, 07 Aug 2026 08:12:54 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e274b3asm166688585a.37.2026.08.07.08.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 08:12:53 -0700 (PDT)
Message-ID: <7d5e3e9f-136e-4082-998d-9f035ff2f170@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 12:12:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] target/riscv: Support raising misaligned
 exceptions for floating-point loads/stores
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
References: <20260805164345.698208-1-frank.chang@sifive.com>
 <20260805164345.698208-6-frank.chang@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805164345.698208-6-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -0xDQN7sXca4KRWc60Hwo8TAJXiHLUeh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfXz9myiMcDdUds
 pLCznBcmb8FraZl1Kaaazk9zQMYVLqvADV2VJ9p7Z8QLZNxOm2jd4bLlr3tOgF3lNgoA7yW5Yki
 /jBQxcBlG5kPYljDm/XcGY25VCi1mDT1kU7tXBCHmwfmVhTKhH8+SSVOoHGfSU83JseOKWx/qZR
 7J+ljNU18KxjEaUrYu0ZISDzdqGUXRgsPUIPNqfyj/4eP0iREvxRJTCoS4wsHogBbWdKARwosqQ
 1OiRbuKmGJ0WcIHEYx4xtSJWKxCal42IZ5zc2RlKA3MO6rXl3gr0KS4uTPTojmXRHWn20ZJXaii
 /WU+a7Cm/+hrcbLHf9NrIOThu8hd5bWPeV2iN9iSRY5PrJ/NfU1GgW8UIn02w8r4pb4Fo9a7sFb
 6gMSoU3lrSyRLSn4MQAS9eJG8/Y0dB/6X+q3Ixww6mL5Pp5p0Ly7P/Yk7B6czCMTekl5aJoLzns
 CpBXMHWLE0nP5WJW0fQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX+I0u+qedRzOM
 MXlDs59SkVLf/I6MAIWHVv+uXFiIrEm5NWws3jNq74zScZSE9A8nSre9aUz2EIevmKQgG1DNxtG
 1JJmtbgrSFqKziW687nFotIXtOuWE7w=
X-Proofpoint-ORIG-GUID: -0xDQN7sXca4KRWc60Hwo8TAJXiHLUeh
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75f5f7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=1n3FIi9wMlNCWemWLOcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 8/5/2026 1:43 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> When the Zicclsm extension is not enabled, raise misaligned load/store
> exceptions for misaligned accesses from floating-point load/store
> instructions (RVF, RVD, Zfh).
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/insn_trans/trans_rvd.c.inc   | 6 ++++++
>   target/riscv/tcg/insn_trans/trans_rvf.c.inc   | 6 ++++++
>   target/riscv/tcg/insn_trans/trans_rvzfh.c.inc | 6 ++++++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
> index 3b9a745520a..1be2bee9465 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
> @@ -61,6 +61,9 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>           memop |= MO_ATOM_IFALIGN;
>       }
>       memop |= ctx->mo_endianness;
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |= MO_ALIGN;
> +    }
>   
>       decode_save_opc(ctx, 0);
>       addr = get_address(ctx, a->rs1, a->imm);
> @@ -86,6 +89,9 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>           memop |= MO_ATOM_IFALIGN;
>       }
>       memop |= ctx->mo_endianness;
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |= MO_ALIGN;
> +    }
>   
>       decode_save_opc(ctx, 0);
>       addr = get_address(ctx, a->rs1, a->imm);
> diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> index e935523c93c..481f7282da7 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> @@ -52,6 +52,9 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |= MO_ALIGN;
> +    }
>   
>       decode_save_opc(ctx, 0);
>       addr = get_address(ctx, a->rs1, a->imm);
> @@ -75,6 +78,9 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |= MO_ALIGN;
> +    }
>   
>       decode_save_opc(ctx, 0);
>       addr = get_address(ctx, a->rs1, a->imm);
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> index f36b46c2118..88711fb0769 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> @@ -50,6 +50,9 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
>       REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>   
>       memop |= ctx->mo_endianness;
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |= MO_ALIGN;
> +    }
>       decode_save_opc(ctx, 0);
>       t0 = get_gpr(ctx, a->rs1, EXT_NONE);
>       if (a->imm) {
> @@ -75,6 +78,9 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
>       REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>   
>       memop |= ctx->mo_endianness;
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |= MO_ALIGN;
> +    }
>       decode_save_opc(ctx, 0);
>       t0 = get_gpr(ctx, a->rs1, EXT_NONE);
>       if (a->imm) {


