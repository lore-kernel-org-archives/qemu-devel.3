Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE150C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 04:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5FOa-0004nU-Ba; Sat, 12 Sep 2026 00:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5FOY-0004nI-4y
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:31:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5FOU-0004Rz-TZ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:31:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68C4U4mA1335339
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLe3/XFw3UbXsViRn2xKZn9tYDcZseGFQ9IAr76ZP60=; b=n/6FzabAmo60QM3l
 lGsVpiSHgWHlIbPgTeeRsq3T/GYTkXkiwd8Q5XB7LZ8Dl+UejfVbCI+ZzMpZXjm6
 jFnLKdBO4IyxRtQPWDSL9JgaXKBtCD1LTL9x3Snv6qnpsHnJ8uhw7e1nS2XDikYn
 DycpEH6G7/hnh0jreL5bLN/QnNCBX6W1UjNJCSDpU99BPCdXAzgIbonO/Gfio+47
 3YKGKBrvQjeePl+j4oAVRqO7NOj8MInJfKPoAhf4FtIMPZm+o3dAorwXywRuYSDK
 LBbeeOKd0TkeDIcOdYjvxzXbVpBDuwPVbiBLt8JsmTR9QZVi5eHLuClaG11m7lxy
 lafmBQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9br20y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:31:12 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-671163d46bcso2488862d50.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 21:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789187471; x=1789792271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tLe3/XFw3UbXsViRn2xKZn9tYDcZseGFQ9IAr76ZP60=;
 b=AyL3yOJUHWD5pTcUOzbPYNExzW+5chKJ2EngbU5FSL7nW0Gha8TDYeLd0zi+G9zIKQ
 OnkqdSUxj7iZwBYWTNJrY/LHn8xCCPMMcMRlMlZGvsoULs0Xo46OkBOv5ntR7b4+yFP3
 8fZUcGlf/1ETiG3SqMfAqsAl3CmV5DJ92PX2n7S/NNLjc4OoeZKRjJU6YdN1lgV5KHnv
 ZiJLIYeen//YURoLsfYVgPmL1d8Br+4ZoDGZCgIS6gK9rFOu5rWfhM5O3T79spi3It7F
 ZVc9C3ZKOgupQrBoWIxd3zmiQ5Pm/7cS4nsk3zyY7EA0Ael4MgnQeLSflEMPHsIZequq
 XyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789187471; x=1789792271;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tLe3/XFw3UbXsViRn2xKZn9tYDcZseGFQ9IAr76ZP60=;
 b=JqQDpT/TchRVuqWYq43p95l1+wL7Fem8GZ5kRooOl+oXq0KdHjCQUn+6utP46VFxjB
 2xCv/dASmJfkiMA1Z7ZgzmitAZprmlSOo93aOTO53w/bAwZ3XvPOXwZ+6DuqIEifwOEz
 jY/XFgpb7buJywpfqs4whVEFQO9MukSI4pP7jKQ4M7UwY287oO6/jV3kwiTOwA79EM39
 xhoeaGMnOH8GF7kLZQQMq3UgMC7HpMlvRomhoF4CU/W/mt/2QEqmX/W95gZMASug54OQ
 kyg0BpHOUhwciAlxLeMnLtXgYBdOMdPk/BdkjuY0U+RGrd27PwEgDJlg7HLvt1USP1Qs
 3oRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwslUX45Q6XCS0lbLZTCIlfDcHjQwgwdSGhDhx45q2BVLiQ9MeV7C9RRSdZnwsq27DdIIeGOwvPRTFw@nongnu.org
X-Gm-Message-State: AFuF++keGrTOR7RQtku01Xn2fVDHNB958misob3Vwqct7bKDwomtFyVq
 0UXSHVe/dbXVH3KnJeoUxnA0qfTsjopWPgeX8f6mrnfdzwQcsboUgGjD2logBRe7m+u9TLhNYhg
 dMOvo9imh9r7ugwJb3WxNY8QW2neDO7/GPUE1Tf9hOe4KqefzvuGDIudcNA==
X-Gm-Gg: AYBFou1GeEDtrrmwd8IJPuWyf/OXCiWP6vkX+UwcNpM94QoZEqajR8F3MDy2te2ON4L
 dSSScTLxh/vrsJy/rb5HnFomOd3jOECtqEumIIKhzes9d0VWvAvyr54Yf70uvq/nTiNXVhatRo1
 ZkbwZP1tNLCw8HNZ7O9f1O/K6wJnFInVh+6FE9qIvTcOV+ByopzMQYIV6XwzBzDNIIIpnL0FdGc
 NpfYaHvpRKKCkShofDGSpGsnGr+DozjmDMP8BaFCjYW2uT8MDvOBGKbAabzTK9phUORd2f4V4VT
 DGqyz4dAu6IdVhaaW/WQssgWBC5S84YdP0iH3mAQzuRGo5m48Iza0hFz9lxm/GUOXHC0Q9y1caT
 vf/1sAVyyjE9QFpKLCPJx8/FeUTUELr0v9iuE6wjA2CSXclNr20w3TYAmrvoG
X-Received: by 2002:a05:690e:e8b:b0:66f:c1be:84d6 with SMTP id
 956f58d0204a3-67135a3fe04mr211262d50.68.1789187471296; 
 Fri, 11 Sep 2026 21:31:11 -0700 (PDT)
X-Received: by 2002:a05:690e:e8b:b0:66f:c1be:84d6 with SMTP id
 956f58d0204a3-67135a3fe04mr211259d50.68.1789187470808; 
 Fri, 11 Sep 2026 21:31:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:1d0:c210:bc8f:aa56:8c4:fb36?
 ([2600:1700:1d0:c210:bc8f:aa56:8c4:fb36])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67125b8bf2asm1924235d50.1.2026.09.11.21.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 21:31:08 -0700 (PDT)
Message-ID: <edf37742-23fa-41cf-abc5-47eedecaec4b@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 23:31:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] Hexagon (target/hexagon) Remove old way of
 detecting register multiwrites
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-11-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260911220825.143115-11-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDA2MSBTYWx0ZWRfX7n+Kkr9l4Xri
 nlKCM9WnWSojYKVuHwmlYqHUQjbZt6CWd98322uXJLn4TI5avAOfKCAbwyRiQSH1uTuQ8yKyQW+
 eSo9q0zbwK/10PrKK1BQWAWstD1hUs1+/4jRwg2Tjhzf4Bf/oqoPZOTC0DlDVbGRcNTl4DCGl3K
 MTX+ADYKuaTKwth/usa2AK68U9E4JzfgUHK9gXF3WnVLhG0gGDjJt2Ttb4yFI8bgBjRy2qQ3PAN
 cOvW+meX4PmBIpm69eEz0SuXd+otI3MIHpAWKhqggQt+Om0UpGA0bpaqh2sWu44EXaahp82pgBg
 tEgZKKLcrId1eTbXt1nRzAH5smMlw0o8vmbxP7aapQwA3E0eJfzDCcsxEo9oEQGstgeVVoNrhK/
 4qW4QJFXXUQwXoFXXX4O3wSxKh3Kw80ejgiHw+dAzbMjtZbdHQ8R9DdXXVOFfRf324PpA86FfeS
 V7bD3NIK8QwRxJjFG7g==
X-Proofpoint-ORIG-GUID: FVazhj7UjUCle6SpWDlnSBg0vngHoiG0
X-Authority-Analysis: v=2.4 cv=R96WitRX c=1 sm=1 tr=0 ts=6aa4d590 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=V5pVMqplg12vC-y-oNEA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: FVazhj7UjUCle6SpWDlnSBg0vngHoiG0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDA2MSBTYWx0ZWRfX7iXpqlHScnmj
 RbpKEsbYxug+1bZ0m3l3TTW6Qc7vVQstDJ5R71/iBNjCo0sonwMMM9Te7QhJaOwUr2Y5wFn/Phs
 yaNu4VdAhAhtKNTqFHX2hlqgxlI2IKM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_02,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120061
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 9/11/2026 5:08 PM, Taylor Simpson wrote:
> We now detect register multiwrites in packet analyzis instead of
> packet decoding


typo "analysis"


>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/insn.h             |  4 ---
>   target/hexagon/decode.c           | 54 -------------------------------
>   target/hexagon/translate.c        |  6 ----
>   target/hexagon/gen_trans_funcs.py | 10 ------
>   4 files changed, 74 deletions(-)
>
> diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
> index 835b1c954e..5d59430da9 100644
> --- a/target/hexagon/insn.h
> +++ b/target/hexagon/insn.h
> @@ -41,8 +41,6 @@ struct Instruction {
>       uint32_t new_value_producer_slot:4;
>       int32_t new_read_idx;
>       int32_t dest_idx;
> -    bool dest_is_pair;
> -    bool dest_is_gpr;
>       bool has_pred_dest;
>   
>       bool part1;              /*
> @@ -74,8 +72,6 @@ struct Packet {
>       bool pkt_has_hvx;
>       Insn *vhist_insn;
>   
> -    bool pkt_has_write_conflict;
> -
>       Insn insn[INSTRUCTIONS_MAX];
>   };
>   
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index b12e91fe6a..89e961331f 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -691,55 +691,6 @@ bool opcode_supported(uint16_t opcode, const HexagonCPUDef *hex_def)
>       return true;
>   }
>   
> -/*
> - * Check for GPR write conflicts in the packet.
> - * A conflict exists when a register is written by more than one instruction
> - * and at least one of those writes is unconditional.
> - *
> - * TODO: handle the more general case of any
> - * packet w/multiple-register-write operands.
> - */
> -static bool pkt_has_write_conflict(Packet *pkt)
> -{
> -    DECLARE_BITMAP(all_dest_gprs, 32) = { 0 };
> -    DECLARE_BITMAP(wreg_mult_gprs, 32) = { 0 };
> -    DECLARE_BITMAP(uncond_wreg_gprs, 32) = { 0 };
> -    DECLARE_BITMAP(conflict, 32);
> -
> -    for (int i = 0; i < pkt->num_insns; i++) {
> -        Insn *insn = &pkt->insn[i];
> -        int dest = insn->dest_idx;
> -
> -        if (dest < 0 || !insn->dest_is_gpr) {
> -            continue;
> -        }
> -
> -        int rnum = insn->regno[dest];
> -        bool is_uncond = !GET_ATTRIB(insn->opcode, A_CONDEXEC);
> -
> -        if (test_bit(rnum, all_dest_gprs)) {
> -            set_bit(rnum, wreg_mult_gprs);
> -        }
> -        set_bit(rnum, all_dest_gprs);
> -        if (is_uncond) {
> -            set_bit(rnum, uncond_wreg_gprs);
> -        }
> -
> -        if (insn->dest_is_pair) {
> -            if (test_bit(rnum + 1, all_dest_gprs)) {
> -                set_bit(rnum + 1, wreg_mult_gprs);
> -            }
> -            set_bit(rnum + 1, all_dest_gprs);
> -            if (is_uncond) {
> -                set_bit(rnum + 1, uncond_wreg_gprs);
> -            }
> -        }
> -    }
> -
> -    bitmap_and(conflict, wreg_mult_gprs, uncond_wreg_gprs, 32);
> -    return !bitmap_empty(conflict, 32);
> -}
> -
>   /*
>    * decode_packet
>    * Decodes packet with given words
> @@ -759,10 +710,6 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
>   
>       /* Initialize */
>       memset(pkt, 0, sizeof(*pkt));
> -    for (i = 0; i < INSTRUCTIONS_MAX; i++) {
> -        pkt->insn[i].dest_idx = -1;
> -        pkt->insn[i].new_read_idx = -1;
> -    }
>       /* Try to build packet */
>       while (!end_of_packet && (words_read < max_words)) {
>           Insn *insn = &pkt->insn[num_insns];
> @@ -837,7 +784,6 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
>               /* Invalid packet */
>               return 0;
>           }
> -        pkt->pkt_has_write_conflict = pkt_has_write_conflict(pkt);
>       }
>       decode_fill_newvalue_regno(pkt);
>   
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index c40ca86810..ca23cc6d9e 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -1247,12 +1247,6 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>           clear_pkt_ctx(ctx);
>           analyze_packet(ctx);
>   
> -        /*
> -         * Check that the new method is a superset of the old methond
> -         * Remove in a later patch
> -         */
> -        g_assert(!ctx->pkt.pkt_has_write_conflict ||
> -                 pkt_has_write_conflict(ctx));
>           if (pkt_has_write_conflict(ctx)) {
>               gen_exception_decode_fail(ctx, words_read,
>                                         HEX_CAUSE_REG_WRITE_CONFLICT);
> diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
> index 19c1f9fdea..45da1b7b5d 100755
> --- a/target/hexagon/gen_trans_funcs.py
> +++ b/target/hexagon/gen_trans_funcs.py
> @@ -91,8 +91,6 @@ def gen_trans_funcs(f):
>           new_read_idx = -1
>           dest_idx = -1
>           dest_idx_reg_id = None
> -        dest_is_pair = "false"
> -        dest_is_gpr = "false"
>           has_pred_dest = "false"
>           for regno, (reg_type, reg_id, *_) in enumerate(regs):
>               reg = hex_common.get_register(tag, reg_type, reg_id)
> @@ -106,12 +104,6 @@ def gen_trans_funcs(f):
>                   if dest_idx_reg_id is None or reg_id < dest_idx_reg_id:
>                       dest_idx = regno
>                       dest_idx_reg_id = reg_id
> -                    dest_is_pair = ("true"
> -                                    if isinstance(reg, hex_common.Pair)
> -                                    else "false")
> -                    dest_is_gpr = ("true"
> -                                   if reg_type == "R"
> -                                   else "false")
>               if reg_type == "P" and reg.is_written() and not reg.is_read():
>                   has_pred_dest = "true"
>   
> @@ -137,8 +129,6 @@ def gen_trans_funcs(f):
>           f.write(code_fmt(f"""\
>               insn->new_read_idx = {new_read_idx};
>               insn->dest_idx = {dest_idx};
> -            insn->dest_is_pair = {dest_is_pair};
> -            insn->dest_is_gpr = {dest_is_gpr};
>               insn->has_pred_dest = {has_pred_dest};
>           """))
>           f.write(textwrap.dedent(f"""\

