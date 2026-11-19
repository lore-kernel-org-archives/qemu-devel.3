Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB2606A336
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=piXXCuqI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KlQ53k/f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBFB-0005bJ-N0; Thu, 19 Nov 2026 18:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUBFA-0005b4-NL
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:08:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUBF8-0006en-Pb
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:08:40 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1kod3148673
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VTCUPy8p8uMFPcNzR2EDQkaoxriQ047Yxinc4QenFXE=; b=piXXCuqI3vO36xNQ
 4NK6M8ZfcupCu4+w2Xh2dje5vLlXxglisnL3AmOPgbpBO+yN7Cf8kJclBWqLQTZF
 2+vCmXbUICwN7TPhaApvd0TdY6lzUe0gqwEPdAPLLhvwmS4JSaQNChjVuyQ0CUVd
 xiq+FaxjHSDbLfJ9OrHmyX557YUWj+60QXkQpyG+8mrX8sbMNVdpscNAgLQabjBa
 DZU3YbBj9Ta7IExgdzuviqNByi5KlGPRZysZfnGJAMtVyNmRKqrOvpGA+9jPuPNo
 luZxHSnzZUCy4HgIjE/tA4AccD8q04BT7z8y/6G1alF/7K3Mj+16fqgA3+yt0FY6
 5LQ/kg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx6b87u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:08:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-382af5cfc58so764526eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795129715; x=1795734515; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VTCUPy8p8uMFPcNzR2EDQkaoxriQ047Yxinc4QenFXE=;
 b=KlQ53k/fKe34H3pXdOBgU/petLiWgrjW73Pd53xxan1vkYJlK67yOvRwgCX8EjP4ww
 NccP2X8uHwWlib65MRKziAti3vyg8wzt0V+QJP6hQ6FGLWs0b/od06yEIhxQBcltp5pp
 CefoPFqJkMt7c14LhS2ECRY0BP7+XL7iLl8A4/J8l4Ix7YS5C7DfEA7Uf0n4ORwItk7r
 +QUvWwuQsLP6auQto+WqJlmZKB0dqWmtLFb0YssCpUpyMcdpl7bieGOe2B31Auws4aCl
 OGo1WAyj4b3Af1dkQ1pHswhkrZItHP6hkksBqVPP0KhKAv3urnjVefSJjRQFq7m3yUxx
 AlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795129715; x=1795734515;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTCUPy8p8uMFPcNzR2EDQkaoxriQ047Yxinc4QenFXE=;
 b=Uh6k69yytfmlhvpPPYXIdOrb2x6Q5KU1ORpOdPocwpLUc5LfOTEIvrjSqMcE5/MAnC
 wkoWGZ0lHRSgWtr3Z3+ZOghTPvzCnvClqFcutDB86wqMIExkbBaijBIuWkF0HNKO8WT2
 KIUrGT93up0ikUAby1pBQt3WMuKj0JK3J5gU0mP7ghi1GrQx664DdRsl/InwK7t1k3V3
 fhHOsOSCeTlPOPT12ulMoasSqy4v/9S/D+0TCzciDRilA9yQVlfUhQ10rVV2an3YaHm3
 mJsEtr7953qSRyQeHLnkm2pV7zCwkOlEQk87Hslz/BK7mqSq3d12TD/Zdy/fvUBULYeS
 fSbg==
X-Forwarded-Encrypted: i=1;
 AL+hErHehY99O8Ho/uO87s4Puh43IRsl5zPsf6wHlNzIlIgjBe7E/boscY+9EES2HTpJiOMqJ72QHhxpXziy@nongnu.org
X-Gm-Message-State: APuU4Z8CVyR9jSYG0G6HnDHum4FYVMYiE+FUspsBCAXmULTZHvssGVSE
 EdssFwAdD/BSsrZVtvauUQau2+kj1ob86qm0laDbdm9JEF3qDBON3A2L36MKubb0POq9XOr7Di2
 pAp9KlxnkP2hAon7cdKvO3KM2XIXMMQaCHK6IxnF3GoSqO6zAnnNTugH9gA==
X-Gm-Gg: AZFdTZdI7P/TVVXCEXgZiMUCHzc4VYYi2A/fWYheiumDlBz/PrHl0sLUog4JV3bft2/
 RGYYdG6nTmMWVr6YY3Hv8Z16YotWuw9M8M+JsJl2BXLkjKhanQVPuXhKXzz2fiWs01kOE/5t/oK
 rGIvzPMZBSJclyrHHwzIuzjY5fpfB4xt9wgNuFC1raZKu0giwB+Piwo/jODfNbf5zKOqTzzKoJd
 MWmgSML11IY5DNhr2SxwCYorwb5tECQwMsNya/ZqUv92o0/V465v+2TkjAkTvZNUFfheYOPHhuH
 4gHkgoQ4GC111i9KQ/oJRVP1DsFM0HKxXc2+qepwEfnQly6Yn97RZpblUPE9WEEneAqT9M4yIJh
 dK2wU33a+eHvWKwvK1JInT4h3mNPQLxXgBnyWPU7lm5Oc7nobDcEE494MDL7FE1eXR23E21zRkL
 MdwrmQ4YLA3bMeor619hC5djODILOsJ2FszixB
X-Received: by 2002:a05:7301:162f:b0:36e:a265:8ee with SMTP id
 5a478bee46e88-3856eb49291mr882145eec.18.1795129715382; 
 Thu, 19 Nov 2026 15:08:35 -0800 (PST)
X-Received: by 2002:a05:7301:162f:b0:36e:a265:8ee with SMTP id
 5a478bee46e88-3856eb49291mr882116eec.18.1795129714781; 
 Thu, 19 Nov 2026 15:08:34 -0800 (PST)
Received: from [10.248.104.162] (160.sub-174-226-161.myvzw.com.
 [174.226.161.160]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm1660216eec.8.2026.11.19.15.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 15:08:34 -0800 (PST)
Message-ID: <c3ac9d48-cf67-49bb-bb7c-f24fd001e4b1@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 17:08:30 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] target/hexagon: validate both stores before
 packet commit
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-14-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119215853.987158-14-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xDfjLQ7OwjZW-Bq0HGcVV5cXS0DeRFYl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX/6Qp4ZnsAgrw
 IayP4x6Lqn/YqkEp+5UPYVC8qR1U4DvSzSIMvRd7Q8N/tUbYPLFLJw8sOfy3+9cjpebYdcuRbMD
 lwGUW2HWHv78TMqQqM/C96WLSqo/OIc=
X-Proofpoint-ORIG-GUID: xDfjLQ7OwjZW-Bq0HGcVV5cXS0DeRFYl
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6aff8174 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=GMQ7njlnOdzlMr1UnwV+Pw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=unu_lMr3q8iU9D5BRR0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX/vp7UAANRqL0
 feiWgSvmbfGqFE7kthFTxG9qG3MrnczfeOhhWdvFRbnavkHcTfsppgskJTwQBpP8VU1wUog1EX7
 0gzepp9oH48c3FrsEK+cIzhSK/fwknchk3eSiA0COEMbELg8we2AA9E57AnroveN9CW2L76Lvom
 vYIReDqXtC3C4s2vKUPmsheAqweDRY14EsQesE56hIRFMt4DNJW1VtmSP07/fcSTSavWiKAamxJ
 JP3hndfiKizlYbGMInFpoO7Yu+GAOu37m40P0S3/QhUtCkrlQmtH79aVmLeSaVw2PjtoAq93zs9
 SdGZ9AqAKaoW0s5DWZ7eWSEZVtLPgk4+Mu3JG4W1cB//QWGBfUdiZeBYXsa6uvOEg0eIT1X2kRw
 4h1lHGgRmKAGTaPcJLWDGSvny3VLg5SrjBCrj2RvLrPg9Z66DYzMVUkesYdbxtLxYNs43PV9HSv
 BHFu1MUa3je0GWKPCKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 11/19/2026 3:58 PM, Marco Liebel wrote:
> Check alignment in store probes and validate both logged stores before
> committing either one. This also covers stores without generated
> address preflight code.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/helper.h    |  2 +-
>   target/hexagon/op_helper.c | 16 +++++++++++-----
>   target/hexagon/translate.c | 15 ++++++++-------
>   target/hexagon/translate.h |  5 +++--
>   4 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 292ca8eb7c..0303ea9bba 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -143,7 +143,7 @@ DEF_HELPER_2(vwhist128m, void, env, s32)
>   DEF_HELPER_2(vwhist128qm, void, env, s32)
>   
>   DEF_HELPER_4(probe_noshuf_load, void, env, i32, int, int)
> -DEF_HELPER_2(probe_pkt_scalar_store_s0, void, env, int)
> +DEF_HELPER_2(probe_pkt_scalar_stores, void, env, int)
>   DEF_HELPER_2(probe_hvx_stores, void, env, int)
>   DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
>   
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 354b9a2c91..31e1140270 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -446,6 +446,9 @@ static void probe_store(CPUHexagonState *env, int slot, int mmu_idx,
>   #endif
>           uint32_t width = env->mem_log_stores[slot].width;
>           target_ulong va = env->mem_log_stores[slot].va;
> +#ifndef CONFIG_USER_ONLY
> +        hexagon_check_alignment(env, va, width, slot, MMU_DATA_STORE, retaddr);
> +#endif
>           probe_write(env, va, width, mmu_idx, retaddr);
>       }
>   }
> @@ -472,13 +475,16 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
>   }
>   
>   /* Called during packet commit when there are two scalar stores */
> -void HELPER(probe_pkt_scalar_store_s0)(CPUHexagonState *env, int args)
> +void HELPER(probe_pkt_scalar_stores)(CPUHexagonState *env, int args)
>   {
> -    int mmu_idx = FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX);
> -    bool is_predicated =
> -        FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED);
> +    int mmu_idx = FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, MMU_IDX);
> +    bool pred[2] = {
> +        FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, S0_IS_PREDICATED),
> +        FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, S1_IS_PREDICATED),
> +    };
>       uintptr_t ra = GETPC();
> -    probe_store(env, 0, mmu_idx, is_predicated, ra);
> +    probe_store(env, 1, mmu_idx, pred[1], ra);
> +    probe_store(env, 0, mmu_idx, pred[0], ra);

If there's only one store in this packet, probe_store() is able to 
figure that out?


>   }
>   
>   static void probe_hvx_stores(CPUHexagonState *env, int mmu_idx,
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index db87b05afb..63ecd38d50 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -1486,19 +1486,20 @@ static void gen_commit_packet(DisasContext *ctx)
>                                                      tcg_constant_tl(mask));
>           }
>       } else if (has_store_s0 && has_store_s1) {
> -        /*
> -         * process_store_log will execute the slot 1 store first,
> -         * so we only have to probe the store in slot 0
> -         */
> +        /* Validate both stores, including alignment, before commit. */
>           int args = 0;
>           args =
> -            FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX, ctx->mem_idx);
> +            FIELD_DP32(args, PROBE_PKT_SCALAR_STORES, MMU_IDX, ctx->mem_idx);
>           if (slot_is_predicated(&ctx->pkt, 0)) {
>               args =
> -                FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED, 1);
> +                FIELD_DP32(args, PROBE_PKT_SCALAR_STORES, S0_IS_PREDICATED, 1);
> +        }
> +        if (slot_is_predicated(&ctx->pkt, 1)) {
> +            args = FIELD_DP32(args, PROBE_PKT_SCALAR_STORES,
> +                              S1_IS_PREDICATED, 1);
>           }
>           TCGv args_tcgv = tcg_constant_tl(args);
> -        gen_helper_probe_pkt_scalar_store_s0(tcg_env, args_tcgv);
> +        gen_helper_probe_pkt_scalar_stores(tcg_env, args_tcgv);
>       }
>   
>       if (ctx->hex_def->hex_version >= HEX_VER_V83) {
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 0c729d719b..b259cd7d80 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -446,8 +446,9 @@ void hex_gen_exception_end_tb(DisasContext *ctx, int cause);
>   
>   void process_store(DisasContext *ctx, int slot_num);
>   
> -FIELD(PROBE_PKT_SCALAR_STORE_S0, MMU_IDX,       0, 2)
> -FIELD(PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED, 2, 1)
> +FIELD(PROBE_PKT_SCALAR_STORES, MMU_IDX,           0, 2)
> +FIELD(PROBE_PKT_SCALAR_STORES, S0_IS_PREDICATED,  2, 1)
> +FIELD(PROBE_PKT_SCALAR_STORES, S1_IS_PREDICATED,  3, 1)
>   
>   FIELD(PROBE_PKT_SCALAR_HVX_STORES, HAS_ST0,        0, 1)
>   FIELD(PROBE_PKT_SCALAR_HVX_STORES, HAS_ST1,        1, 1)

