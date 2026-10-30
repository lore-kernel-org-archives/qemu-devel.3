Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CD606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BnVYDJ4D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kp2+xv4V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMaMT-0001og-P8; Thu, 29 Oct 2026 20:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaMR-0001o6-Cx
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:20:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaMO-00027F-WE
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:20:47 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKY634163177
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wS1CQm6uT+cL7emN36oMQ0vMXGCU/zw4yFn2erntLA0=; b=BnVYDJ4DWt4iDkjQ
 wwbwF2CwdymHz1w5zUwAwVdwhyZ3/eMjW1ZRhgri7A2F/8WOvGF/QbSvecBQpqiv
 g2vfvO1HjztHmioZyIzNdvH+Z33cxvdzutiXDy3ElHoYGKUrRCEBBdpYvyQ1vodi
 AmuayuiFg46YvX/M4r+lMCKoLiANP1f70UXD4qwk8VDq3RE7seohGT06oBbMuVcF
 GdMR41XyNMcp0+sRyFeQ5zKHFwzBOtO+a6/7PDHMg1THCWj9Y1zcToQLJ2skcEVQ
 5Iql4G/FRnnrCPDLYlZQ381tq4+CEXUH/NknchCgwnNEKQA1js/pEko8nXEIGRbP
 8TarAQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pgedp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:20:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso19564685a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793319642; x=1793924442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wS1CQm6uT+cL7emN36oMQ0vMXGCU/zw4yFn2erntLA0=;
 b=Kp2+xv4VUeqeyi0gK3YKOEjBEt+qpvLvrVDkotGEuzW4+nH67jfIii50NlvJcpX5oJ
 hnfAtLCLEgW72YmHGtjp79XQ9q5VdVLQaH8fPoPFx6Xvp0Sg2JD3qU/N8mrOQ8Jtt6wq
 Kd19Ny/v9LDgCHYHM2lwtaRnq5Ucc+ToO+Xtxdi0Jik2QqUgiQ5BCa7Bjl7g1Ci4be1L
 QE6qVN3BeXvIAn5e3pM5Z1SdPT9L6uyTsOE52HVzzXQCrAE12Rj1/+aCChY/QhoU2DiW
 tVMYCbb1/RnSXuLE89fCOyBfbX1GeBrccb2QasaUatzWBFs17cGIWA1eL4wRJrk6HvSY
 AJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793319642; x=1793924442;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wS1CQm6uT+cL7emN36oMQ0vMXGCU/zw4yFn2erntLA0=;
 b=OEtYmOYPzOnWlplBSm6tPWjLu9LUcALcECmQQZACKbnh5NUTnNLMMFs0TlqG1t+AJY
 pCHKMlItUaqJY9ixK77kgawXRxo7fJGrbp/7ewUNY3fINYXKTSUBWwni2aKmr7M/rN6V
 tNH3jddIlRJzRF1s7kShp6O7tOBKxJootZpB3QcvwSyKzuwtZLU+k5dzjN+i4ABDSP/+
 vnaWIflDp5CrTxxL0+u2phhcFlmf+AsVtqIfvY9HyYXZV58jbIOIbmSO/MYmwVgZriuA
 LX/0RhuXcwt51D0HpaqnXm/LoV2UKj/dtrmQDhneUec7WTERjas9hRff+Eq9dOHGBxpH
 gQEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFSxXac+XVqr2MYmT4Nb1Gyr1wiVUFrxwlLNU0+VynwgIlT/LI3gt8sILfHdSxcx2DuFX8OTp44Axm@nongnu.org
X-Gm-Message-State: AFq9FYIINekbgvU4kufy2l4qNbW5lNQTcT5qHuN08nY6Xq6o7KNAkjGN
 TYk3FqXmwK3ntSw+GmwhtvWASdnKlZGUEoi8I3JEO6fLXZE/o3z5+vcm6V0Ao8JevuHai2gwRkQ
 c6ZWAta35bZ7WK+TG8Rus58qkHK4X7BnL5fXD8eBRtyGZs0gvUeZBXfQ2ew==
X-Gm-Gg: AYBFou2NJnx4d+pN7Cbl+kLcKEy9dC77QBIUVD3wYUemwY0bjrR5zKKkNbMHMteygQ/
 v6klfHvi51DrelmsLCcsrp3WviJaDPpagex+6SrweXORg92SoH+zzGiy1Ar6vA9Hsy25VAZdbK1
 RbCqZPFJBHp5yX/H9+znwkyVL4/reUJUnGmp+71k+WM61QbHsfE52KgW6XI5zIPbTKfiB8RQVJi
 S1WvHPzH/1m6b1wsZdlW4dRoiPpqC2STb+YyPHaMlAQBc+GSeUtrK/zbuGILCuN/JoBqU6lOZrC
 BrQv1YOLMjNcNaRGgcbUt1HCMl3aUMTbXNWZytQ3xdTFHP5knZMVQ0hJ+9/hnGIVAMvKPr7h+xM
 A2rKF+UarYS/KcTP141N5BlGKnYsPU0TExVbCF6GTaSTfo/SAOtgZCN+tLjANe3NTAdaJoJMKz5
 WjRRX8grGEqjbmR1hS1FQYGhdjGCwyJGd3yMeQ9oTnN7fEayZVpct3
X-Received: by 2002:a05:620a:31a6:b0:93e:8614:bbe7 with SMTP id
 af79cd13be357-944214d6b44mr155209685a.12.1793319642202; 
 Thu, 29 Oct 2026 17:20:42 -0700 (PDT)
X-Received: by 2002:a05:620a:31a6:b0:93e:8614:bbe7 with SMTP id
 af79cd13be357-944214d6b44mr155207485a.12.1793319641723; 
 Thu, 29 Oct 2026 17:20:41 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9442586685esm1367185a.23.2026.10.29.17.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:20:41 -0700 (PDT)
Message-ID: <c463c10c-b3bb-4e1f-8051-47e6c501b870@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 19:20:39 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] target/hexagon: translate packets with HLX
 instructions
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-12-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-12-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfXzWeLLILFp8ua
 iOM8UUY15Y/xFsapQfZ1tVYBRuNmofkB6fTkM/glluYRd1pKDuCDgfX/LBP+1KL47Y+S0ns0SVg
 hoGpyI+xa2Bl33Nin/JT8zL5RpNTWiDep5k+FNexBgyZV6jJ4J2gOfUfxTcdOgXD1yTEv0WDCJ3
 2EANzHCRCYTqJLjEAN5vCicBvat9e7vwchw3YJJ6N3vpkzC/uyobBBMKFpN0iRrc680Cpi457ZP
 TtNWRGx7OUYH3NgTwc6/YUeXDV6AtNjc08LSx6z1EkBZPqKAOhJ8d8BcUFRv/ODQir9JRjp8NW0
 5sVYi5tLbDI4IRPUW6kraCyzui7MohYwwHpY0o0odA8D3UQU82zmUqLf5UYX4RR3d2Ot5cnABNX
 9Nu8Ahxjs89jhg0yjuDsfWq8+sY2UsSFgak3GIdhGP0q0jZ8arI6hrlR1q5RxMik50u5CQ6Jj7A
 Xtmq3Jo/MCh3gwGhQEw==
X-Proofpoint-ORIG-GUID: YWFQ9jkd_BBTQvjJiOzlwV1R97DXs8Qh
X-Proofpoint-GUID: YWFQ9jkd_BBTQvjJiOzlwV1R97DXs8Qh
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae3e2db cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=mofBcHnhcE-rAXqJ63AA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX8Z/Vwxwpsrmz
 oEH0aBIcU8bU7YMfl9nX0owgHT4izWxBNqgALF866tepZjGstnVYNxgffIN1MnsRVCNpMj0fxwH
 6NtERgbCrq7Jbb/95oTptIEx3k15bG4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300001
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Track HLX register updates and commit them at packet end. Run .tmp
> loads, other instructions, and stores in separate passes.
>
> Raise the disabled-coprocessor exception without an active context.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/translate.c | 108 +++++++++++++++++++++++++++++++++++--
>   target/hexagon/translate.h |  48 +++++++++++++++++
>   2 files changed, 153 insertions(+), 3 deletions(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index ed246e226f..41b7d3b0fb 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -18,6 +18,7 @@
>   #define QEMU_GENERATE
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> +#include "hw/hexagon/hexagon_hlx.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
>   #include "exec/helper-gen.h"
> @@ -33,6 +34,8 @@
>   #include "genptr.h"
>   #include "printinsn.h"
>   #include "exec/target_page.h"
> +#include "hlx/hlx.h"
> +#include "trace.h"
>   
>   #define HELPER_H "helper.h"
>   #include "exec/helper-info.c.inc"
> @@ -341,6 +344,26 @@ static bool need_slot_cancelled(Packet *pkt)
>       return false;
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static void gen_hlx_check(DisasContext *ctx)
> +{
> +    TCGv xe = tcg_temp_new();
> +    TCGv_ptr hlx_ctx = tcg_temp_new_ptr();
> +    TCGLabel *raise = gen_new_label();
> +    TCGLabel *enabled = gen_new_label();
> +
> +    tcg_gen_extract_tl(xe, hex_t_sreg[HEX_SREG_CCR],
> +            reg_field_info[CCR_XE3].offset,
> +            reg_field_info[CCR_XE3].width);
> +    tcg_gen_brcondi_tl(TCG_COND_EQ, xe, 0, raise);
> +    tcg_gen_ld_ptr(hlx_ctx, tcg_env, offsetof(CPUHexagonState, hlx_ctx));
> +    tcg_gen_brcondi_ptr(TCG_COND_NE, hlx_ctx, 0, enabled);
> +    gen_set_label(raise);
> +    gen_precise_exception(HEX_CAUSE_NO_COPROC3_ENABLE, ctx->pkt.pc);
> +    gen_set_label(enabled);
> +}
> +#endif
> +
>   #ifndef CONFIG_USER_ONLY
>   static bool sreg_write_ends_tb(int reg_num)
>   {
> @@ -678,6 +701,12 @@ static void clear_pkt_ctx(DisasContext *ctx)
>       bitmap_zero(ctx->qregs_multi_write, NUM_QREGS);
>       bitmap_zero(ctx->qregs_uncond, NUM_QREGS);
>       ctx->qreg_log_idx = 0;
> +    ctx->lreg_log_idx = 0;
> +    ctx->lreg_tmp_log_idx = 0;
> +    bitmap_zero(ctx->lregs_updated, NUM_LREGS);
> +    bitmap_zero(ctx->lregs_multi_write, NUM_LREGS);
> +    bitmap_zero(ctx->lregs_updated_tmp, NUM_LREGS);
> +    ctx->hlx_base_loaded = false;
>       for (i = 0; i < STORES_MAX; i++) {
>           ctx->store_width[i] = 0;
>       }
> @@ -701,6 +730,11 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
>           return true;
>       }
>   
> +    /* HLX instructions are unpredicated, so multiple writes conflict. */
> +    if (!bitmap_empty(ctx->lregs_multi_write, NUM_LREGS)) {
> +        return true;
> +    }
> +
>   #ifndef CONFIG_USER_ONLY
>       if (!bitmap_empty(ctx->gregs_multi_write, NUM_GREGS)) {
>           return true;
> @@ -742,6 +776,17 @@ static void analyze_packet(DisasContext *ctx)
>       ctx->need_commit = need_commit(ctx);
>   }
>   
> +static bool pkt_has_hlx_store(Packet *pkt)
> +{
> +    for (int i = 0; i < pkt->num_insns; i++) {
> +        int opcode = pkt->insn[i].opcode;
> +        if (GET_ATTRIB(opcode, A_HLX) && GET_ATTRIB(opcode, A_STORE)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>   static void gen_start_packet(DisasContext *ctx)
>   {
>       int i;
> @@ -776,6 +821,11 @@ static void gen_start_packet(DisasContext *ctx)
>       if (need_slot_cancelled(&ctx->pkt)) {
>           tcg_gen_movi_tl(hex_slot_cancelled, 0);
>       }
> +    if (pkt_has_hlx_store(&ctx->pkt)) {
> +        /* An earlier fault can leave a store logged. */
> +        tcg_gen_st8_i32(tcg_constant_i32(0), tcg_env,
> +                        offsetof(CPUHexagonState, hlx_store_pending));
> +    }
>       ctx->branch_taken = NULL;
>       if (ctx->pkt.pkt_has_cof) {
>           ctx->branch_taken = tcg_temp_new();
> @@ -860,6 +910,14 @@ static void gen_start_packet(DisasContext *ctx)
>           gen_precise_exception(HEX_CAUSE_NO_COPROC_ENABLE, ctx->pkt.pc);
>           ctx->hvx_check_emitted = true;
>       }
> +    if (ctx->pkt.pkt_has_hlx) {
> +        if (!ctx->hlx_coproc_enabled) {
> +            gen_precise_exception(HEX_CAUSE_NO_COPROC3_ENABLE, ctx->pkt.pc);
> +        } else if (!ctx->hlx_check_emitted) {
> +            gen_hlx_check(ctx);
> +            ctx->hlx_check_emitted = true;
> +        }
> +    }
>   #endif
>   }
>   
> @@ -1206,6 +1264,17 @@ static void gen_commit_hvx(DisasContext *ctx)
>       }
>   }
>   
> +static void gen_commit_hlx(DisasContext *ctx)
> +{
> +    int i;
> +
> +    for (i = 0; i < ctx->lreg_log_idx; i++) {
> +        int rnum = ctx->lreg_log[i];
> +        gen_helper_hlx_commit_reg(tcg_env, tcg_constant_i32(rnum));
> +    }
> +
> +}
> +
>   static void update_exec_counters(DisasContext *ctx)
>   {
>       int num_real_insns = 0;
> @@ -1332,6 +1401,9 @@ static void gen_commit_packet(DisasContext *ctx)
>       }
>   
>       process_store_log(ctx);
> +    if (pkt_has_hlx_store(&ctx->pkt)) {
> +        gen_helper_hlx_commit_store(tcg_env);
> +    }
>   
>       gen_reg_writes(ctx);
>   #ifndef CONFIG_USER_ONLY
> @@ -1342,6 +1414,9 @@ static void gen_commit_packet(DisasContext *ctx)
>       if (ctx->pkt.pkt_has_hvx) {
>           gen_commit_hvx(ctx);
>       }
> +    if (ctx->pkt.pkt_has_hlx) {
> +        gen_commit_hlx(ctx);
> +    }
>       update_exec_counters(ctx);
>   
>       if (ctx->pkt.vhist_insn != NULL) {
> @@ -1404,9 +1479,31 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>           }
>   #endif
>           gen_start_packet(ctx);
> -        for (i = 0; i < ctx->pkt.num_insns; i++) {
> -            ctx->insn = &ctx->pkt.insn[i];
> -            gen_insn(ctx);
> +        if (ctx->pkt.pkt_has_hlx) {
> +            /* Run .tmp loads first and stores last. */
> +            for (int pass = 0; pass < 3; pass++) {
> +                for (i = 0; i < ctx->pkt.num_insns; i++) {
> +                    Insn *insn = &ctx->pkt.insn[i];
> +                    bool tmp = GET_ATTRIB(insn->opcode, A_HLX_TMP);
> +                    bool store = !tmp && GET_ATTRIB(insn->opcode, A_STORE);
> +                    if (pass != (tmp ? 0 : store ? 2 : 1)) {
> +                        continue;
> +                    }
> +                    ctx->insn = insn;
> +                    if (GET_ATTRIB(insn->opcode, A_HLX) &&
> +                        trace_event_get_state_backends(
> +                            TRACE_HEXAGON_HLX_OP)) {
> +                        gen_helper_hlx_trace_op(tcg_env,
> +                            tcg_constant_i32(insn->opcode));
> +                    }
> +                    gen_insn(ctx);
> +                }
> +            }
> +        } else {
> +            for (i = 0; i < ctx->pkt.num_insns; i++) {
> +                ctx->insn = &ctx->pkt.insn[i];
> +                gen_insn(ctx);
> +            }
>           }
>           gen_commit_packet(ctx);
>           ctx->base.pc_next += ctx->pkt.encod_pkt_size_in_bytes;
> @@ -1426,6 +1523,11 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>       ctx->num_packets = 0;
>       ctx->num_insns = 0;
>       ctx->num_hvx_insns = 0;
> +#ifndef CONFIG_USER_ONLY
> +    ctx->hlx_coproc_enabled = hex_cpu->hlx != NULL &&
> +                              hex_cpu->hlx->contexts_bitmap != 0;
> +    ctx->hlx_check_emitted = false;
> +#endif
>       ctx->branch_cond = TCG_COND_NEVER;
>       ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
>       ctx->short_circuit = hex_cpu->cfg.short_circuit;
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index bc5f202163..fa7e627200 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -91,6 +91,7 @@ typedef struct DisasContext {
>       TCGCond branch_cond;
>       target_ulong branch_dest;
>       bool is_tight_loop;
> +    bool hlx_check_emitted;
>       bool short_circuit;
>       bool ieee_fp_extension;
>       bool read_after_write;
> @@ -101,10 +102,57 @@ typedef struct DisasContext {
>       TCGv dczero_addr;
>       bool hvx_coproc_enabled;
>       bool hvx_check_emitted;
> +    bool hlx_coproc_enabled;
> +    TCGv_ptr hlx_base;
> +    bool     hlx_base_loaded;
> +    int lreg_log[NUM_LREGS];
> +    int lreg_log_idx;
> +    int lreg_tmp_log[NUM_LREGS];
> +    int lreg_tmp_log_idx;
> +    DECLARE_BITMAP(lregs_updated, NUM_LREGS);
> +    DECLARE_BITMAP(lregs_multi_write, NUM_LREGS);
> +    DECLARE_BITMAP(lregs_updated_tmp, NUM_LREGS);
>   } DisasContext;
>   
>   bool is_gather_store_insn(DisasContext *ctx);
>   
> +static inline TCGv_ptr ctx_get_hlx_base(DisasContext *ctx)
> +{
> +    if (!ctx->hlx_base_loaded) {
> +        ctx->hlx_base = tcg_temp_new_ptr();
> +        tcg_gen_ld_ptr(ctx->hlx_base, tcg_env,
> +                       offsetof(CPUHexagonState, hlx_ctx));
> +        ctx->hlx_base_loaded = true;
> +    }
> +    return ctx->hlx_base;
> +}
> +
> +static inline void ctx_log_lreg_write(DisasContext *ctx, int rnum)
> +{
> +    if (test_bit(rnum, ctx->lregs_updated)) {
> +        set_bit(rnum, ctx->lregs_multi_write);
> +    } else {
> +        ctx->lreg_log[ctx->lreg_log_idx] = rnum;
> +        ctx->lreg_log_idx++;
> +        set_bit(rnum, ctx->lregs_updated);
> +    }
> +}
> +
> +static inline void ctx_log_lreg_write_pair(DisasContext *ctx, int rnum)
> +{
> +    ctx_log_lreg_write(ctx, rnum ^ 0);
> +    ctx_log_lreg_write(ctx, rnum ^ 1);
> +}
> +
> +static inline void ctx_log_lreg_tmp_write(DisasContext *ctx, int rnum)
> +{
> +    if (!test_bit(rnum, ctx->lregs_updated_tmp)) {
> +        ctx->lreg_tmp_log[ctx->lreg_tmp_log_idx] = rnum;
> +        ctx->lreg_tmp_log_idx++;
> +        set_bit(rnum, ctx->lregs_updated_tmp);
> +    }
> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
>   {

