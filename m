Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECA7C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7dp-0000ab-Ft; Thu, 20 Aug 2026 14:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7do-0000aT-P8
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:37:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7dm-00016v-7X
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:37:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJ7Wi352066
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E0xkh1oi/hJEjm9jsp4un8Owl7h+SYXOBCslSfNC+k0=; b=JdNKt1UnISgnLoMY
 zWGV7KjXBqI/rM5giNolKuCWEnM0zBKAqXbQ+8ybzUzaZmcbKdiZWAkCc31M2Eq8
 zk0voaE3+HFKcAXYZZmyBmcsfiHUGXfYgTCegqysJ+e1fZevr+V5IitgAE4Aj2Hf
 bNlK6DQ2VIIrgvC9i0cJMbVg1xVSpWE5QizNPVWbZG0uTqO0dwLdQ8PoeMJF0Ncy
 9mtxWT+Hdi1qslNiBH34wz07RzDHh3+YqkZFru7kHiGsLXVrCBj939X59531iFCP
 B3CjW+Z2DbgXYk0wV2DIJhNhBKKOMXInhMoHzNYK+a3rmU3UjaydN2s4TPXOEaKc
 oRTMHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8a9qb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:37:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so2283605ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787251043; x=1787855843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E0xkh1oi/hJEjm9jsp4un8Owl7h+SYXOBCslSfNC+k0=;
 b=OadBLZ8cC4pObYuwgIQ9zZ9XMQVmydIukTo/PEOKICPjccd3fwfGFijE5+oja2H2d4
 PFhsOOU+rxO/UYtd9kpRqpexe8Z63OU0mMYYdJHJIHXunEPzjK9+oMddiwNXnfLI6SAG
 kL2VwrQvolyraIgBwuZccLQ64fkuWFq6mUdVj+3JhaJyd6yNgHnjjQYlQPdMTckxrwAw
 w1Clej3bqMAEsiYMsGovb0t6OELIahHRAgU2L6Qek7PoqaMakPdaLFENFVGAmv/ZuDr1
 vvGN/aNH5X8i3ayOu/lzx+Wv9n1U1Dzds5A84qEbWB8sxyIJL3z+DNa1kvALgfo4le3E
 h6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251043; x=1787855843;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E0xkh1oi/hJEjm9jsp4un8Owl7h+SYXOBCslSfNC+k0=;
 b=O8/fVnJR7oCrYC5swAPvvekVKUCJ9eH673ma/nT/zDuI7lwqB13Yn8C2LOQ2gD4cur
 8xkGdpNRSfhJjtN1MYb31SstV026y+VXiHAkgJ9P+atAZDBthmd95XVarXFxAw6q6eMx
 tJQWbpA0Hp07ephj2HMOXzmOCKxIKhKI4Q2xxZv+dvKYUbFgnkOQPQrfxTykF7MJoSK3
 S4W1W44HTH8Wiu1G56730/L+5Vz6Fm9rNnyrqRB/mORYEwgs5ClyubRWdzd+3Kh3Ox4s
 8zNZL2pjfRd0if73Y3aCdk+fVWB/KOEkR2MBfGJw60tUMhPAtK+gKdkZQr2x5lVL87Np
 rtHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoW/zFFPxAhXZZWJ5Tw+pNYKXIfebcVZhOqVkM2fcNdClM3fNDaVM4Z0kmCjImnHoF0F60PWbWqVAhE@nongnu.org
X-Gm-Message-State: AFuF++mRCIBOAsXCa8XLk6seo1UACfHyamCqvSxjPcCeoHlp85PugFYE
 wJCxf2LNWQq+U0In0zkhmsXE5xiMHGuyIhdsC//zl6fAWvWg1G9RIBpyWJDCBSCV+GNtL5hw28I
 RrFrD8MpoHPQbtGhGtGqSeKphT3v1BQ4EajnLbgHVA1vudV9TSuR1hZhzy1xsDA/WgA==
X-Gm-Gg: AR+sD10HAnr+gVQ8YSIT3WztxQmm2HfxAGF81Dd5F3x8JsMg3Zue4kwPFpCuo2aHdr7
 i07/R2Rrb7KEGxg34H3q18tmOhz93Y7SIB4yajiggbBsjAyV/dXK7xxS04FnnPE8n0wG5Mi5i+l
 EBaOkJST+n/4FQHIkPq71d7QIYWxRRcq5Qywy6H8dFd9PEjQN+KEmcbanls9Nk4PcguHTcFCdAW
 Dx4yMkz6SR57pz5OaJBH396qePMprbF58IAQCSUNNQWJVDFPCPcRmNcbdnU4G6nfjpk3bKV+fqU
 mzPSQa+44F7zcbqQ4jmOYdDIdwdlmSCYoiNTwKFflSJzBpvSMz2F61KQjTiZD+Ps8KcN9FQmfP9
 7fp/pkq/CZgL+yRDy6IrFSe/VcJkQoibO+TBMOK37COf2pfQTc0Npety9ZpHQ5qjpDOou
X-Received: by 2002:a17:903:b4b:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2d64a9a1b03mr15575635ad.0.1787251042930; 
 Thu, 20 Aug 2026 11:37:22 -0700 (PDT)
X-Received: by 2002:a17:903:b4b:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2d64a9a1b03mr15574715ad.0.1787251042365; 
 Thu, 20 Aug 2026 11:37:22 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327cb5a9831sm11903474eec.21.2026.08.20.11.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:37:21 -0700 (PDT)
Message-ID: <39d5f3bf-4f04-4e90-8c32-8132ced0b4cb@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: invalidate translated code for user
 icinva
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
 <20260819045339.3661773-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819045339.3661773-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfX546BzStMqfms
 E5KI+q1RT3F2svwZlW2jngWOoBfDeuHF8QMvaCaGNYHXUHz25/+3nqnwpJjAFc59EH0Ff6J3xoM
 2U5iH4xu7y0976Lyt8/wZQSNWoMoiJc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfX44LQflLpCk2D
 UYHTvKPiK6WNGxpLo8SgyYUSOLPmlm1eDJtNcVILmri6pQ94NgqBc6B8Om2h8Tc/hE8uunEzpWw
 QcmuoQXCNaKln2tRQi4Qfsy2HI7eiXz9bH8pjBpRivubDbrbf1kwCkUYy0qL9EIHzJoYxM212+h
 TH+jFgaihGxVhxl4HQMHPDkte+9bk8/ISxTcP8sAQuD2mLtOGlkkZ1Syk5hnw7L8F7u6kme+ac3
 Oqf569gQHP1oteGrlIsiiUB2xwyiTWyR0jIw99yL/ZJwhswNySkVz7h09Vr362iE6lRsuRh22tX
 Rm7+RC6SdELy8Il5boO43tEeQ9avYqjlybS6/f665uIryjOepqc2cxs0pJldVxUY8rDk6EVGy4M
 71xgemxjaUuFlLyCBCZX9ltndjwZkynxfDVDDhYUnYJj43Z9nS2LJIIbyzayuGqY+xy2sgO3Leq
 +pEObAOxmGZ+zI0Uqsg==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a874963 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=euVgU6OCQpvlH6gg5l8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Pbw09bqJ3IjJp6GqwwZ46IP4VBTrktow
X-Proofpoint-ORIG-GUID: Pbw09bqJ3IjJp6GqwwZ46IP4VBTrktow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/18/2026 9:53 PM, Brian Cain wrote:
> Route linux-user icinva through a helper that invalidates the addressed
> icache line under mmap_lock
> 
> For system mode icinva has nothing left to do, so it stays a nop.
>

Why does system mode icinva is a nop?
Shouldn't we invalidate translated code also?

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h   |  9 +++++++++
>  target/hexagon/helper.h    |  4 ++++
>  target/hexagon/op_helper.c | 15 +++++++++++++++
>  target/hexagon/translate.c |  3 +++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
> index 40e03781d36..1d25391282a 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
> @@ -497,8 +497,17 @@
>      do { RsV = RsV; } while (0)
>  #define fGEN_TCG_Y2_dccleana(SHORTCODE) \
>      do { RsV = RsV; } while (0)
> +
> +#ifdef CONFIG_USER_ONLY
> +#define fGEN_TCG_Y2_icinva(SHORTCODE) \
> +    gen_helper_insn_cache_op(tcg_env, RsV, \
> +                             tcg_constant_tl(insn->slot), \
> +                             tcg_constant_tl(ctx->mem_idx), \
> +                             tcg_constant_tl(ctx->pkt.pc))
> +#else
>  #define fGEN_TCG_Y2_icinva(SHORTCODE) \
>      do { RsV = RsV; } while (0)
> +#endif
>  
>  /*
>   * allocframe(#uiV)
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 78dc28ca9e5..a5a5c123533 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -113,6 +113,10 @@ DEF_HELPER_FLAGS_4(gvec_sabsdiff_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_uabsdiff_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_uabsdiff_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  
> +#if defined(CONFIG_USER_ONLY)
> +DEF_HELPER_5(insn_cache_op, void, env, i32, int, int, i32)
> +#endif
> +
>  #if !defined(CONFIG_USER_ONLY)
>  DEF_HELPER_3(raise_stack_overflow, void, env, i32, i32)
>  DEF_HELPER_2(swi, void, env, i32)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 23894ff3d28..84f5564b1e6 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -23,6 +23,9 @@
>  #include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
> +#include "exec/mmap-lock.h"
> +#include "exec/target_page.h"
> +#include "exec/translation-block.h"
>  #include "fpu/softfloat.h"
>  #include "exec/cpu-interrupt.h"
>  #include "internal.h"
> @@ -311,6 +314,18 @@ int32_t HELPER(vacsh_pred)(CPUHexagonState *env,
>      return PeV;
>  }
>  
> +#ifdef CONFIG_USER_ONLY
> +void HELPER(insn_cache_op)(CPUHexagonState *env, target_ulong RsV,
> +                           int slot, int mmu_idx, target_ulong PC)
> +{
> +    target_ulong start = RsV & ~31;
> +
> +    mmap_lock();
> +    tb_invalidate_phys_range(env_cpu(env), start, start + 31);
> +    mmap_unlock();
> +}
> +#endif
> +
>  int64_t HELPER(cabacdecbin_val)(int64_t RssV, int64_t RttV)
>  {
>      int64_t RddV = 0;
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 06a8159d283..1560c412732 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -354,6 +354,9 @@ static bool pkt_ends_tb(Packet *pkt)
>      if (pkt->pkt_has_cof) {
>          return true;
>      }
> +    if (check_for_attrib(pkt, A_ICFLUSHOP)) {
> +        return true;
> +    }
>  #ifndef CONFIG_USER_ONLY
>      /* System mode instructions that end TLB */
>      if (check_for_opcode(pkt, Y2_swi) ||


