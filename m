Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBF606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RveFks/D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E9AHUbt5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOtO-0006yu-Qs; Tue, 17 Nov 2026 14:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOtH-0006yd-Eu
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:30:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOtF-0006qX-8s
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:30:51 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHJUjCn1083094
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 19:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yMxRdluc3ifaXqlswg+BQ4apmcOjofQOMcHK+mBZ0HM=; b=RveFks/DYxG5ZCo5
 AgnBJ2juEkjgoCTsylBKCKvUtjJ4yjae9uVNxqC3L+xrT3y/uO5hZ21GwLBPxlAB
 CIPv7DdFsvel7Rv62SmO0xHNncwB2dVFrbMJi+bAgnT03I+Hgch8Wxvil+uDc2DG
 iGlxrCfUGMRlTYIM2Bg8a/H0OXFkMPlu6Bzo1f1v+Wsgf+p+FCaUySLo9XUv682K
 1r/f/3PGkdMcsR7AS27/iL6iQtTMy1X+VwuGKKer9N4Rhzu58pNEA4fDztMXzemC
 9pyPI4Y7ZrKLQvQ1qacFxWIxoh6yEdC+pw8enoRvcWmztBDkBbQGt62rJJwiAEnd
 FqzzKg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0w58r00g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 19:30:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91eb0610cb9so899296d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794943847; x=1795548647; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yMxRdluc3ifaXqlswg+BQ4apmcOjofQOMcHK+mBZ0HM=;
 b=E9AHUbt57jdRyxuzjI74sy7/Leo5pueNK29n1ON4B76/o7flMyUImeaNxv17/uh8A2
 QJjRMhiy4MDTBLgZQg7Zv4JMZ/LHIU/I/BQHW6UeNwnxF1uwqXiZrR0McPWPOmyQvgl+
 bI20ypO9smu/kjZB8H4vqSlPx0ytaE+pssvm4uTajP5NykG5hXOWowWdX9nNrS6A037G
 JhCBZFe8XiC3SQ1KhAtUAMjw8O6FO265ivHvoRDiGJzwKGN1kh08lXSQulpCWbr/iry8
 wlxAwnWxlAEQsXT6278sek/QefRAjIZAk4Ex0Qk/p3vzuqvwlGlrvjOPof3XdGtCQ/BY
 m7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943847; x=1795548647;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yMxRdluc3ifaXqlswg+BQ4apmcOjofQOMcHK+mBZ0HM=;
 b=jwsNP5HonDpuZ9FSG+m6L9/DIo8yGg+n4fX/vcvw7PA1ttf4Glccp1dJ0byo7o3HFC
 ppmwCb7h3P3J0nqCCmVqncPBZi8wtTc3DDKtRXNiVhTjqgiqTs5CzopWu78uhYNo+vmb
 EdD7LqCFCB7T/7gIQA9cbCfMSF8U60IJJZI+lDuf/NC6JLuo+2sTFDgHib/0f8vjw6RL
 F7TGNaHSbyhz0NCYm2IXhQG60TR8EjgxDLJjKEPjVsU16zilOwkutLpdwvvrKdcJdJpD
 2JpW/E96Kwr3P62lHAFI8PRS17Mj66z4rDwn24AtKmr7fvVKIeAC8edivl4+8FmduJqJ
 APQw==
X-Forwarded-Encrypted: i=1;
 AL+hErFGHMExrPoQvrSbVNGjKFaNdWTwxsLAkWUXvt6HHM9pNmE7O+cYHEFPXCoJJ+x8c3QoA4w6DHdMPbau@nongnu.org
X-Gm-Message-State: APuU4Z9tvebV6Q5Vwt5HWrwm0SN7jHCuh26Z+YEm33vJNemiy5N9I0ta
 ZNR1MxXIi/Q+6quj2MKFTytDLjUDJK9vc1IVXHLljbIOdDP+aGlwQGjLRYsMU+ADdKfg1tQsjFW
 JNgq2F7Czc7YP1H8bFMTaKPEV9nV1HxaA25tVrxnJzDtO/ahbYtLg1jFvYkq+Ulke4Q==
X-Gm-Gg: AZFdTZdGN9Tmq0tCMG5PmvCUWXSlpyHbbmbnrLnjvaclbUT7ai/MHpkazl7BM6hTky3
 e2Fm4hxDv5XZxV30j+5TyOU0GYsQ7fcjEDh+fBxtha665/9Jcsbdd47RrAsI2tRUd7hVQTFyPHr
 YiTfX+fyHc3N21EMl2m39YLNropStVAckVtx3Rr1jxmAfRmuyXyRUgm+/tmQfzYo/A3aCBikifi
 MZjUUt4eyxq1UyLbU6biyG+uny6jE+n2hWwPgPTx6ITCir8CtrnHGEvDQ06kz3y2sLTCzkhB2Pr
 GYtm+kSgMlU+6xOss6F3iWpVfI2lN62SKjoREZ6RCGi5hxhn8D3wc2WVtNwgebJXK3E6gt+jQRi
 WMBH3z2WMV0S4BEREfGpEdzt9Kg1RNpzTGGTMkrXmf9hkSz8pTCwFzFz6E1+IecNvnvGnZVhBpt
 ZoVkQ/Xi9Tjl1cqO9qJnRdW/QS6Ip/LUaL+/KHig==
X-Received: by 2002:a05:6214:2621:b0:91e:7bb7:fd65 with SMTP id
 6a1803df08f44-92114f088e6mr2369466d6.56.1794943845746; 
 Tue, 17 Nov 2026 11:30:45 -0800 (PST)
X-Received: by 2002:a05:6214:2621:b0:91e:7bb7:fd65 with SMTP id
 6a1803df08f44-92114f088e6mr2367706d6.56.1794943843931; 
 Tue, 17 Nov 2026 11:30:43 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92114dbef06sm1378136d6.45.2026.11.17.11.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:30:43 -0800 (PST)
Message-ID: <5a7e606a-18b4-4357-a70d-8ec9960003fa@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 13:30:42 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] target/hexagon: reject HMX operands outside VTCM
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-5-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261117183629.2002840-5-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfX/LsETtVWmahV
 rTpWPsLMMMx7S/rtABlenrFfHuToHtKUovz5G96idWVWwaSg780AEQ/IOFfX+pZS44PHDE+vYlW
 yshirTF2wUUrLTF76bzWcUgKa248P7mcxMJBCzbq2XX1GpxhvNnIFP0nQwRATT7JhxbB38fmJrd
 SmfhkyoIuXlKxO/RH0crZibChZBlbTC1y24k64Tf+jwWjwjaIMczHY2wYRe7wbuHkkMB4qjzw1K
 eCmsAAeeIiwI6W5YzF7YNYFfvYzfeP8gVNg/vhOvJ0rNptIAtBWBe8dF6LSD7ABymWLj/ohpReI
 N9CaVpMGrFqekexs0U0WW4OsYFyVyK6B7XFxrplaWYxxl/kV4LxWiQ7Pil2TdjZYxM1mWAApNVq
 ksxpOF8PY4KPkpP3R13WHzKsM2XEzj6VS7fa7QRjoAlfKl0uqmagSvRVxfPPrAQAy3l3VMFgF/L
 zOPQ7V76wge3VIpy+xw==
X-Proofpoint-ORIG-GUID: R370hpcmpTII6qqZXfN3rZoSMR3JQsHr
X-Proofpoint-GUID: R370hpcmpTII6qqZXfN3rZoSMR3JQsHr
X-Authority-Analysis: v=2.4 cv=fIqsTpae c=1 sm=1 tr=0 ts=6afcab67 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2lr0pSPp7RyiNU-4YqwA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfXyZc/AenViNfl
 HGd5lnyxE3S3iyIibbzQpVxz6jbtM662y7BZa9E1dO8TEdOtXJZZp9lGdGg+82EoqsuMYayAQoi
 1FP+iiKPYr5Uzx70UH0ZXW4zk5KCKuk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/17/2026 12:36 PM, Marco Liebel wrote:
> Check activation and weight addresses against the machine VTCM range
> before executing packet instructions. An invalid operand raises the
> precise coprocessor VMEM address error and prevents packet commit.
> HMX arithmetic remains unimplemented.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/helper.h    |  3 +++
>   target/hexagon/op_helper.c | 19 +++++++++++++++++++
>   target/hexagon/translate.c | 11 +++++++++++
>   3 files changed, 33 insertions(+)
>
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 292ca8eb7c..eddde9ab34 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -22,6 +22,9 @@ DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
>   DEF_HELPER_2(commit_store, void, env, int)
>   DEF_HELPER_3(gather_store, void, env, i32, int)
>   DEF_HELPER_1(commit_hvx_stores, void, env)
> +#ifndef CONFIG_USER_ONLY
> +DEF_HELPER_3(hmx_check_address, void, env, i32, i32)
> +#endif
>   DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32)
>   DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
>   DEF_HELPER_4(sfrecipa, i64, env, f32, f32, i32)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 71b27ef07f..8ed9aff7ee 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -52,6 +52,25 @@
>   #include "hw/intc/hex-l2vic.h"
>   #include "hex_interrupts.h"
>   #include "hexswi.h"
> +#include "system/physmem.h"
> +#endif
> +
> +#ifndef CONFIG_USER_ONLY
> +void HELPER(hmx_check_address)(CPUHexagonState *env, uint32_t va, uint32_t pc)
> +{
> +    HexagonCPU *cpu = env_archcpu(env);
> +    uint32_t config[2];
> +    uint64_t base, size;
> +
> +    physical_memory_read(cpu->globalregs->config_table_addr + 0x38,
> +                         config, sizeof(config));
> +    base = (uint64_t)le32_to_cpu(config[0]) << 16;
> +    size = (uint64_t)le32_to_cpu(config[1]) << 10;

If you give these cfgtable values as properties to the vCPUs, then maybe 
this whole thing can be in TCG instead of a helper?


> +    if (va < base || va - base >= size) {
> +        env->cause_code = 0x26; /* Coprocessor VMEM address error */

I think this is HEX_CAUSE_COPROC_LDST.

If not, please add this as a new HEX_CAUSE to target/hexagon/cpu_bits.h.


> +        do_raise_exception(env, HEX_EVENT_PRECISE, pc, GETPC());
> +    }
> +}
>   #endif
>   
>   #ifdef CONFIG_USER_ONLY
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 10ed73590c..de5baf9f6e 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -946,6 +946,17 @@ static void gen_start_packet(DisasContext *ctx)
>           gen_precise_exception(HEX_CAUSE_NO_COPROC2_ENABLE, ctx->pkt.pc);
>           ctx->hmx_check_emitted = true;
>       }
> +    if (ctx->pkt.pkt_has_hmx) {
> +        for (i = 0; i < ctx->pkt.num_insns; i++) {
> +            Insn *insn = &ctx->pkt.insn[i];
> +            if (GET_ATTRIB(insn->opcode, A_HMX) &&
> +                (GET_ATTRIB(insn->opcode, A_PAIR_1OF2) ||
> +                 GET_ATTRIB(insn->opcode, A_PAIR_2OF2))) {
> +                gen_helper_hmx_check_address(tcg_env,
> +                    hex_gpr[insn->regno[0]], tcg_constant_i32(ctx->pkt.pc));
> +            }
> +        }
> +    }
>   #endif
>   }
>   

