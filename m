Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6895FCA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7vu-0006Ij-Nc; Mon, 12 Oct 2026 00:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7vp-0006Fh-Eq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:46:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7vn-0004Lx-2t
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:46:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lR3L3646352
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zYKgaE2RlTZGHl2KVTOwWt9XY2uRm7PCZIKt3Yoi6ac=; b=XDDTQ0pSxB/l6qK9
 PUAX9arYzXBv78B8k92kSA3Ub4fESMVKbOT4XN4M0V1sGQapo1gqowTS30r3DAXq
 Zgw2r4kDqFURLXeeTzb1TYtnjT7vOK/WONUWbvSGvmoSXHv3Yrl5JHMDuATRftlT
 JY1Jf5X/iItl9nSFBgLWTjN4Xto6FakPkteHg+86AkfuSVsHNJNuWAwxZt3RceAF
 mDq0k7MQhnmUlWZeSLOT9S0TkVyJ5tpXHyL/4hs10hrJAcDNCqeLPDCTU6X+9DPT
 LH3NL5tlCH8noKGMkOuD3Yqjd4ZZHhKvpLnCYw8SftN8jeNXsr2iUFXtW1PQLA/L
 aPfUeg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjmm00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:46:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5351f1b26e6so25584811cf.2
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791780392; x=1792385192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zYKgaE2RlTZGHl2KVTOwWt9XY2uRm7PCZIKt3Yoi6ac=;
 b=PwZqzp4MVtDrSJbbiEjqwWM2EpMOMEN87H+GsSoMrJQ+rjplS7d9r4GV22RwKROUbT
 I4PfaVSwYO80DRNclZ2TORQ90moy2ZcBzKFplGok5TwFAEjaOI4pMRnoLdpc5omHVtlM
 +CKG7Q6MmxiDQFfJ5+3Z3VTYuZrC8tEAOoZ4PMMvt2mqF8RM/4QEgXmVeN1c9dQ2iI78
 1BZ8Hp6a9j2yPoLlAy9uJfXuwehJoOIA6OV6ZR0aR41noE8uHZiN2ADqhmnlFHQ84g4k
 /Rwf9IQJfTpYFGvwPQE+yOkM2J2mbU0u537LjVCKLERoLZOI/pIWy99CDbjwp7MLbOEM
 VPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791780392; x=1792385192;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYKgaE2RlTZGHl2KVTOwWt9XY2uRm7PCZIKt3Yoi6ac=;
 b=0f5ALX7c6Er8RqHzYtEpwxfGvLehB9v/tY966a/lmbrmTwnChKg6coEQG/i163UZaG
 dw9mRuBjLEmaqxSSAcPgTH9puuSgLruhXE8fnuHwL74x52lELeK/UZL73sAEqNP009Ky
 ljCh2t4Wu+wkA20mq67uCfeRYx73+MFi9Gi91CQxUzTIAsl3rth51L6PQ48Jk2syDUsw
 GFID7DYHFhEL5BKC8JkTor3sIDh+2xiNd0bIbVvLfp2xSoCD05GlAZV1EhGRnvgATFT7
 w3qSpmD/RWVkY7YexiYgDZecjBOGVA8ad/ym3oO+N5a5soojqoIk7M5tOtknaWIAk7sy
 0Orw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfSArWEVQb7Q5Id+iCFrj+UGDNI+aKWFyorrGgJi+tngZNxfCnBvGQuYT8k0PpSWee85GotZew+MNM@nongnu.org
X-Gm-Message-State: AFq9FYLekDKJ+O5zDxiAmwm/EE51GZN8P3/keJjbqo/fJeXTQRitEcNE
 JFYHJ5BdFkN6enktTCmz191RT/5gGqzLraIXoy0ezqtNo5IrWc8eZD5qbH9xbo0qPdIPvLFyMhC
 0JhfFmJF9Eg4V3WR40xADKYN948qD8WVyf4S+mdblOzmA+8OmEr+Vor7J+A==
X-Gm-Gg: AYBFou3GFPbLi8BJ/sAh5LiSteAnDq3FjRdLRRBAtO5/99OYNt27+UnubZTVhNVB7eQ
 FQF2W8FLpX+jB3j2FjmY3G8RgBSzRm0Y7B9s1vpyPkqNZ50MuKRyAJNSG4fmODyFHVO6GmQTfHW
 jzlYA9zH8/WDUQ7tTRmCKanam/W33cJWtHTL2mKiQvLVCDWVk4gZq3ug4f9ogwL0wGiUAQIIT7M
 7YJa6QwhtBjDgovQ+/ie045xsAZJO5nwKpE/ptDg8C/+8yspOTdkWYVXfHgnV97yJHKLRqg4ljH
 QKOPo2D4GXvoM0g3pMHwtR2Sodpy0G3rBnr+uvEQ5SOch83PN7zDCR4m2hQyTu9sUvW4h2o8z1x
 zED42zAKkejoyRpM/F2U9PJOLaVvHy/1/SlBqh/eebjWAso2EvLD47HcNGQLggdF6zv8qBYZM7A
 Yf3C0=
X-Received: by 2002:a05:622a:1f8b:b0:535:175c:523f with SMTP id
 d75a77b69052e-5359fddabaemr134715651cf.53.1791780391701; 
 Sun, 11 Oct 2026 21:46:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8b:b0:535:175c:523f with SMTP id
 d75a77b69052e-5359fddabaemr134715571cf.53.1791780391227; 
 Sun, 11 Oct 2026 21:46:31 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7dd1a0sm70323891cf.27.2026.10.11.21.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 21:46:29 -0700 (PDT)
Message-ID: <18d21520-f13b-48f2-8dc2-366a4c2dbafd@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 23:46:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/hexagon: prefix helpers conflicting with
 other arch
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-2-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX+YBX8sFa78xa
 k+Ofs90WGRcg55xm+cm3/jbegqK01XFXpnV2g7tlic8WXinpDOJVLYPX5Z8z5xExIEAxWs/onZ0
 OMNWuEJmbQWw2SAmiUpOlVCe++wpPnE9yc4oTTYNoG/nePFuE2bZXtd9Q1WLWB9q7Mcs8TVuZl1
 5L2QkQSsOBsoQqhZeKOMn0zfjOPlRFOvrUhZHfomqYnbZkscnORKkoukoT5UOF6V7hMgwUTKNJU
 Xl7mFsR31UiTISRunJYGR62EWXetOx6/UlUttglaXUDpj05oPBPLx05oA5fXid5i6i9LfM03UyN
 eJa2kWPXQuHyp5P0OWVWx0pxHURXWMGa3vHQqtDXuwhWCKcOBlv7iozYPyPw2m5fk4MznC66JxA
 pSBeLq0WnzVA6EoCBtCh20lY5KKTbKJyT45dJPx7Arj+UIxajbcElf4FBZT/sE0G4jnU6XVNJzy
 6C1t6+i9M1zB7cOaCCQ==
X-Proofpoint-ORIG-GUID: rfpaWWR2sALAwTLcJL_Esim3clicHizB
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acc6628 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=PN3tC0wU8gDiEMfZ2HMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: rfpaWWR2sALAwTLcJL_Esim3clicHizB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX2OazFL7YxHZG
 yWVEFl8rmtApbuFq8m7vyMmGK9gz0aOIuV4y9rMUY5tUs4wkroneAkti3KRa+zKjYPzGo0eTWbg
 Plf7POQGtXTimj+rpqGSg2ozlLcLS2M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120018
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/9/2026 5:52 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/gen_tcg_sys.h | 2 +-
>   target/hexagon/helper.h      | 4 ++--
>   target/hexagon/hex_mmu.c     | 2 +-
>   target/hexagon/hex_mmu.h     | 2 +-
>   target/hexagon/op_helper.c   | 4 ++--
>   target/hexagon/translate.c   | 4 ++--
>   6 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
> index af5032214c4..5163da2f6b3 100644
> --- a/target/hexagon/gen_tcg_sys.h
> +++ b/target/hexagon/gen_tcg_sys.h
> @@ -80,7 +80,7 @@
>   #define fGEN_TCG_Y2_wait(SHORTCODE) \
>       do { \
>           RsV = RsV; \
> -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
> +        gen_helper_hexagon_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
>       } while (0)
>   
>   #define fGEN_TCG_Y2_resume(SHORTCODE) \
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 71c8da4c46d..a2b3d8950f4 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -18,7 +18,7 @@
>   #include "internal.h"
>   #include "helper_protos_generated.h.inc"
>   
> -DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
> +DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
>   DEF_HELPER_2(commit_store, void, env, int)
>   DEF_HELPER_3(gather_store, void, env, i32, int)
>   DEF_HELPER_1(commit_hvx_stores, void, env)
> @@ -136,7 +136,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
>   DEF_HELPER_3(setprio, void, env, i32, i32)
>   DEF_HELPER_2(start, void, env, i32)
>   DEF_HELPER_1(stop, void, env)
> -DEF_HELPER_2(wait, void, env, i32)
> +DEF_HELPER_2(hexagon_wait, void, env, i32)
>   DEF_HELPER_2(resume, void, env, i32)
>   DEF_HELPER_1(resched, void, env)
>   DEF_HELPER_3(modify_ssr, void, env, i32, i32)
> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
> index d6ee7c40798..0c341f04936 100644
> --- a/target/hexagon/hex_mmu.c
> +++ b/target/hexagon/hex_mmu.c
> @@ -117,7 +117,7 @@ int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
>   }
>   
>   #ifdef CONFIG_HMP
> -void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
> +void hexagon_dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
>   {
>       HexagonCPU *cpu = env_archcpu(env);
>       hexagon_tlb_dump(hmp, cpu->tlb);
> diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
> index 56b2c4a89d0..b477bfcc0ad 100644
> --- a/target/hexagon/hex_mmu.h
> +++ b/target/hexagon/hex_mmu.h
> @@ -24,5 +24,5 @@ extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
>                                    uint64_t index);
>   extern void hex_tlb_lock(CPUHexagonState *env);
>   extern void hex_tlb_unlock(CPUHexagonState *env);
> -void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
> +void hexagon_dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
>   #endif
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 4f00ca773f3..3d55e5674d2 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -93,7 +93,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
>       do_raise_exception(env, exception, pc, 0);
>   }
>   
> -G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
> +G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env, uint32_t excp,
>                                           uint32_t PC)
>   {
>       hexagon_raise_exception_err(env, excp, PC);
> @@ -1836,7 +1836,7 @@ void HELPER(resched)(CPUHexagonState *env)
>       resched(env);
>   }
>   
> -void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
> +void HELPER(hexagon_wait)(CPUHexagonState *env, uint32_t PC)
>   {
>       BQL_LOCK_GUARD();
>   
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 827859e052c..e58a12dbc5b 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -141,7 +141,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
>   static void gen_precise_exception(int cause, uint32_t PC)
>   {
>       tcg_gen_movi_i32(hex_cause_code, cause);
> -    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
> +    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
>                                  tcg_constant_i32(PC));
>   }
>   
> @@ -1143,7 +1143,7 @@ static void check_imprecise_exception(DisasContext *ctx)
>       TCGLabel *label = gen_new_label();
>   
>       tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
> -    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
> +    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception, PC);
>       gen_set_label(label);
>   }
>   #endif

