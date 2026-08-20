Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BF4C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7oT-00054M-Gq; Thu, 20 Aug 2026 14:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7oS-000548-ID
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:48:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7oQ-0006m9-On
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:48:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJ8uS4024768
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NeE9F1urqY2D+O0OojHOCsvHqgISmyJOjPZ9XQQMARk=; b=GgLIfdT2UxQTUKm6
 g6f1wHm1KL7rDFWSdDewB24u2n4HAwqmVhT+Lg08Orbm8Ci/lbt/6eGviEWasBe4
 oiAG6Sd5diko1RWRQTnZAXK9c/jwfN+78cQ22FTuPwhgdBtEltUZBSsUx2CbXkoB
 Cx03h3c9naYiFPQyS7e4K5IuMzZRkt0J3gsUS19y/uJZNUnmkMPGOu2IOMd5wLKa
 FP7AUKoVRB4QUcE4OF/h2VSuKajx/v2y0w8voXjsWjrAKp96V4oDxI4BOtONnygA
 26CEVmgL/1QP7Fg/Z1hU6aN8oClYOSAe+ajwgLGoRMqNfzpVmXDNnEs6ECt79BAL
 P0gewQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0jbu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:48:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso127924a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787251704; x=1787856504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NeE9F1urqY2D+O0OojHOCsvHqgISmyJOjPZ9XQQMARk=;
 b=cbRgSOuAoyyAdYWZdZrUzrRxwvbNTpoiQ/vqOXOipJYz5jIKD3I8yDoYnQ0CfeSpKi
 Se9Q4mFDcoleWrlZRiDvC5KmpcY6Ryh/OhKzswx3EoWDVSwGc/X96nzQeciGBgUV3Xnf
 nmOonoQ71t9sM03MAaXXKzhf2S+aUwD/89FgA5WqMTwFZQQcGSzcWDmGrRJ8QLX5+soK
 jik2pR5PusrDAYkKMkxbhb+0+o/sjMNcYangvuZPd2UBoSX8blp7zuOfHIP0QDzUtK+2
 KuQZEdY9hQSVky4/TwvliJaduvUp7RgT0Ya9AWg6GVyiETKzSYAXOLCGrEbdTGGac+as
 vuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251704; x=1787856504;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NeE9F1urqY2D+O0OojHOCsvHqgISmyJOjPZ9XQQMARk=;
 b=Wmb2IQjq+JWE6mg0+8N3XKr1DkNB7lbElMb56PjqHIZHmH5wBfQMLa9VpUA5nTbBH9
 U9B5uZpi2wCjaCyVZyxhkv4wByd7CTCWbeD26Z0sq9WRbCDKPpBpRsLf9KKJuaKNJbKq
 Tu/p6VQ/6zS2XoljBqhhs12Cb5KZPUxjF1SkVjoymrOF19HzXPtUm8VPmmnPeU45hhK6
 P1drjHJd8hEeWNOms3MM8I2BpRtGZxZsk2YwO0n/jYMyJG5nWAH3UMMYIOmIgdwwjjRm
 mrEJAuUR3B32NF0aPQ7W9m5FQkqhW3eB239W0mQXKChtdpzHkFkPGX3zH4fy1lcMFOzE
 /aXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvsE60n4pbo8wxG7nxflJKgGx1xbSlUQj7X94UjzvrAK8JK7Y7LEVmTC/pmUAhmYg0lI7zIBDlR4hR@nongnu.org
X-Gm-Message-State: AFuF++nnjgl1HTUuKk6URP9yJRVRSpjCz2JCoPe9vqbLtpSnDmS6rHdU
 qRVQO8hhp5D4BwEvfuwZjW3hKy3ETSJJnY3gDtuYhEZvD/+ShTnDmjhzi41pNwhTsyxBnoBYaQc
 pnVM1LnucIt+/P+IEwP43KdEG0poeYOY9K/nQ5Jez2uSlVyWo/xKjzNUPgA==
X-Gm-Gg: AR+sD13J69g1Lu0a+mVEmc1KNXtQnYlcEjL4ByY91RnEhWlSxG020k+ANO7ykpi0bqC
 SZuMUPogjOIkPPBmji4fuGmX7DqKTy/brRKJeRFLHYF0shCJSsTS0h2T59J5N4fCy/amhStcJ3o
 2uVz8ghvPBT9nqMgH6J9pEAw+ZwvINfCoPhmMenmZfTj8SILiFuURTzUy0MDYZ4YnFfNq6ISUDC
 itZ3dyBzirXZWaLZZlGouB58tXZ86PdmHy4CqQBV31FPY2Xd8EvmPZEBGzz0n///X8Q+Wv5NEgh
 1paWIWlqJB3Gt604Yg6zO8jcs/Tv16kFcSATmf1SJOVLILn3fdrggqfZgdVe6fIeJPRyO6DPnpw
 cA6vVEIRc+fjiCf59lhLGuyPnyLxTWwMQd5IkQ28faFAuPv6qqFupOICuwWUoX0FMo/ng
X-Received: by 2002:a17:90b:2e8e:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-395c3377610mr1207943a91.1.1787251704351; 
 Thu, 20 Aug 2026 11:48:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2e8e:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-395c3377610mr1207839a91.1.1787251703834; 
 Thu, 20 Aug 2026 11:48:23 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416aea2429sm17614141c88.15.2026.08.20.11.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:48:23 -0700 (PDT)
Message-ID: <d43b0bff-52c7-4825-9881-0d09aafc2de2@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:48:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] target/hexagon: read UTIMERLO/UTIMERHI from the
 global timer
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: akKBjFGr_0oHG8t1RgL7qKh4eSFAok-4
X-Proofpoint-ORIG-GUID: akKBjFGr_0oHG8t1RgL7qKh4eSFAok-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MSBTYWx0ZWRfXzHkuZYnNt4dK
 lFAJYGCM0Hzj+/NsLZ57aAs+dYJZy0aa8tbFC+QysGH2hP/6UR2Zphfw2p/H1JC7+53bW9S5NrU
 JzcTxS085Xb0w8E8LSewpCmxt7EiPCgNGK21pYLuPFfuQZv9dXo8wrqxP+lvSbsF561rurTwMeQ
 RPT/bAF0aIGIG819GTenz1luMuuHaRpZkN2VPU62xPWZ/tQRuyiJpvSDm5o6TEcwpSWf3QE/56x
 iEfekfQoRymtR9f43GsqvNUgmUat/atiCi/rQhwnSsakuPIRfuqliJLULhu5WJm8nSUQnqcH/Sv
 11HM1N/Z7Z09doYNwNPw5qEpxHGRYXYOlXXlO66I6c1aeXyQB2Hs7Ta/cjlBAvei6TvOvuWWW1H
 rQlx6EXY5ZVAaJC+C6RskmhL9dKwJt4x9DnstWn+lPtRMjYR+6FtTcLCnvSMbpkaA6AghLD4AHD
 PM4xmvSVlrvJQ5SOXCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MSBTYWx0ZWRfX5S4TXHemOoYC
 /pN9XzuiCL+4gHdj2R/WhkGqMAojWmd483J1Kc6vBq6CTqsWZ2Yp5x27fcU6Emo0WtXbau9i63V
 /E5H5igaxgFm3m6uD77j4tlUjZVdN/4=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a874bf9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=u3QfUsSBYbAdI4HXagAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200141
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> In system mode, route accesses to the qtimer-backed global
> TIMERLO/TIMERHI so guest reads see a live, monotonically increasing
> timer.
> 
> In user mode we derive it from QEMU_CLOCK_VIRTUAL.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/helper.h     |  4 ++++
>  target/hexagon/genptr.c     | 29 +++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c  | 21 +++++++++++++++++++++
>  tests/tcg/hexagon/reg_mut.c | 11 ++++++++---
>  4 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 78dc28ca9e5..e39afd623b5 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -113,6 +113,10 @@ DEF_HELPER_FLAGS_4(gvec_sabsdiff_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_uabsdiff_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_uabsdiff_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  
> +#if defined(CONFIG_USER_ONLY)
> +DEF_HELPER_FLAGS_0(utimer, TCG_CALL_NO_RWG, i64)
> +#endif
> +
>  #if !defined(CONFIG_USER_ONLY)
>  DEF_HELPER_3(raise_stack_overflow, void, env, i32, i32)
>  DEF_HELPER_2(swi, void, env, i32)
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 2a98b13b714..282a697d190 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -411,6 +411,23 @@ static inline void gen_read_ctrl_reg(DisasContext *ctx, const int reg_num,
>      } else if (reg_num == HEX_REG_QEMU_HVX_CNT) {
>          tcg_gen_addi_tl(dest, hex_gpr[HEX_REG_QEMU_HVX_CNT],
>                          ctx->num_hvx_insns);
> +#ifndef CONFIG_USER_ONLY
> +    } else if (reg_num == HEX_REG_UTIMERLO) {
> +        gen_helper_sreg_read(dest, tcg_env,
> +                             tcg_constant_i32(HEX_SREG_TIMERLO));
> +    } else if (reg_num == HEX_REG_UTIMERHI) {
> +        gen_helper_sreg_read(dest, tcg_env,
> +                             tcg_constant_i32(HEX_SREG_TIMERHI));
> +#else
> +    } else if (reg_num == HEX_REG_UTIMERLO) {
> +        TCGv_i64 utimer = tcg_temp_new_i64();
> +        gen_helper_utimer(utimer);
> +        tcg_gen_extrl_i64_i32(dest, utimer);
> +    } else if (reg_num == HEX_REG_UTIMERHI) {
> +        TCGv_i64 utimer = tcg_temp_new_i64();
> +        gen_helper_utimer(utimer);
> +        tcg_gen_extrh_i64_i32(dest, utimer);
> +#endif
>      } else {
>          tcg_gen_mov_tl(dest, hex_gpr[reg_num]);
>      }
> @@ -439,6 +456,18 @@ static inline void gen_read_ctrl_reg_pair(DisasContext *ctx, const int reg_num,
>          tcg_gen_addi_tl(hvx_cnt, hex_gpr[HEX_REG_QEMU_HVX_CNT],
>                          ctx->num_hvx_insns);
>          tcg_gen_concat_i32_i64(dest, hvx_cnt, hex_gpr[reg_num + 1]);
> +#ifndef CONFIG_USER_ONLY
> +    } else if (reg_num == HEX_REG_UTIMERLO) {
> +        TCGv lo = tcg_temp_new();
> +        TCGv hi = tcg_temp_new();
> +        gen_helper_sreg_read(lo, tcg_env, tcg_constant_i32(HEX_SREG_TIMERLO));
> +        gen_helper_sreg_read(hi, tcg_env, tcg_constant_i32(HEX_SREG_TIMERHI));
> +        tcg_gen_concat_i32_i64(dest, lo, hi);
> +#else
> +    } else if (reg_num == HEX_REG_UTIMERLO) {
> +        /* One helper call, so the pair is a coherent 64-bit snapshot. */
> +        gen_helper_utimer(dest);
> +#endif
>      } else {
>          tcg_gen_concat_i32_i64(dest,
>              hex_gpr[reg_num],

Out of the scope of this patch, but seems like we could use a switch
instead of if/else ladder.

> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 2cea1927263..df31ed2488a 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -37,6 +37,9 @@
>  #include "cpu_helper.h"
>  #include "tcg/tcg-gvec-desc.h"
>  #include "translate.h"
> +#ifdef CONFIG_USER_ONLY
> +#include "qemu/timer.h"
> +#endif
>  #ifndef CONFIG_USER_ONLY
>  #include "hw/hexagon/hexagon_globalreg.h"
>  #include "hex_mmu.h"
> @@ -46,6 +49,24 @@
>  #include "hexswi.h"
>  #endif
>  
> +#ifdef CONFIG_USER_ONLY
> +/*
> + * User mode has no qtimer device backing TIMERLO/TIMERHI, so derive the
> + * user timer directly from the virtual clock -- the same clock the qtimer
> + * counts -- at the qtimer's default 19.2MHz tick rate, masked to the
> + * qtimer's counter width.
> + */
> +#define HEX_UTIMER_FREQ_HZ  19200000ULL
> +#define HEX_UTIMER_CNT_MASK 0x00ffffffffffffffULL
> +
> +uint64_t HELPER(utimer)(void)
> +{
> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                    HEX_UTIMER_FREQ_HZ, NANOSECONDS_PER_SECOND) &
> +           HEX_UTIMER_CNT_MASK;
> +}
> +#endif
> +
>  #define SF_BIAS        127
>  #define SF_MANTBITS    23
>  
> diff --git a/tests/tcg/hexagon/reg_mut.c b/tests/tcg/hexagon/reg_mut.c
> index c5a39e55100..9ce18f3ebe5 100644
> --- a/tests/tcg/hexagon/reg_mut.c
> +++ b/tests/tcg/hexagon/reg_mut.c
> @@ -77,10 +77,10 @@ static inline void write_control_registers(void)
>      check32(result, 0x00000000);
>  
>      WRITE_REG_NOCLOBBER(result, "utimerlo", 0xffffffff);
> -    check32(result, 0x00000000);
> +    check32_ne(result, 0xffffffff);
>  
>      WRITE_REG_NOCLOBBER(result, "utimerhi", 0xffffffff);
> -    check32(result, 0x00000000);
> +    check32_ne(result, 0xffffffff);
>  
>      /*
>       * PC is special.  Setting it to these values
> @@ -106,8 +106,13 @@ static inline void write_control_register_pairs(void)
>      WRITE_REG_NOCLOBBER(result, "c15:14", 0xffffffffffffffff);
>      check64(result, 0x0000000000000000);
>  
> +    /*
> +     * c31:30 is UTIMERHI:UTIMERLO, a read-only free-running counter.  The
> +     * write must be discarded; the read-back is whatever the timer says,
> +     * so only check that the written value did not stick.
> +     */
>      WRITE_REG_NOCLOBBER(result, "c31:30", 0xffffffffffffffff);
> -    check64(result, 0x0000000000000000);
> +    check64_ne(result, 0xffffffffffffffff);
>  
>      WRITE_REG_PAIR_ENCODED(result, "c9:8", (uint64_t) 0x0000000000000000,
>                             C9_8_EQ_R1_0);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


