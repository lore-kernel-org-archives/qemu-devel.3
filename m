Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59503C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 03:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7PJK-0000Jl-Kk; Thu, 17 Sep 2026 23:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x7PJB-0000Hh-9K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 23:30:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x7PJ7-00079D-Aw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 23:30:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2UaDr2851866
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lUuxIR+Spd8UuHyJnvNjLhTdBKBUVRrB+8eVVnffD5Q=; b=PJrrHxbgNrspHz33
 xk2GzoIlRp/3rQLPvX3IVGs8ith0tKiZSfrCaLnyBcQ0zS+D4iXa39C5Q3hRdc5A
 zdefDYCXfDn+K7ymLynJq+ITnLacXhq2eKJh2UHoH96iJJZAgWnUKRUDYtIpyEgY
 5nwxd+rRyBrc0L6wfu8UmxUD3duRj4+U1MKgFMnlSd/Cz5NqiU1Xy15XiD9bVpX5
 cds/yXSx9azCV5IoVk23wumZjN8w2KN5HBBQ1ui+fMdX1Y1CpgeryujjWGlSa70v
 LY0N16hijojS5rkaa0cPM4Oh3fCp7g8CTCl8HYqMoINFb9I1hRThOn9vEeybrdFE
 WpqfgQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grq2kshb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:30:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90e98e74535so7455666d6.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 20:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789702235; x=1790307035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lUuxIR+Spd8UuHyJnvNjLhTdBKBUVRrB+8eVVnffD5Q=;
 b=aRQFvSFoAp6S6qGLazTo1hT+6xg6kdy3sylzEHNjeZlDhaIvtNcHHo7hkqU5cv73+T
 l5mc+ClP33zDoq+1dJxg6BXPIqGX44V7O1Nk+9GRJoxcidKF8VbEeJ43BhlADLtUeWkW
 x6uJUqJ0/I+1VcwOU8lMDMJLQF4UeASNOVV12tsUIfKQD8+TcXQ2jLzDbpqPN6KEpW99
 bSlAvVIqJHyNpB+ljeo3IUuWZzqa+yU1PiiNhUXyfHsbt9MJbCOIkXkQ3FsBsdyg6pvo
 LVApTuDlARa9pkJNY/WipU+Z434gFn+R67/+gkkuIajVM0I2DulCbShsBf5awjSnDiKC
 56mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789702235; x=1790307035;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lUuxIR+Spd8UuHyJnvNjLhTdBKBUVRrB+8eVVnffD5Q=;
 b=TcSQrHffG2zO1qbS7JS+Iv6XnEaFiimgpIWV1pNdsrRIEsQK9CvNnERreOO32xw+xc
 GOZRA130/c70PK5rDgSWlPBfaq8nM8OOBEQMgz5NENsKQKYQ/sra3aQGfYD1tGGcttRJ
 3Om2COOaL6BrmNopJ2h6tWcgsFaXiWNP6uEYTkeNjApUI3G3dQnxDUL6c+C8C2FiCdEf
 5ofyPZtcBkx5Im5s17iB2NdB9NuzwHq0h0ZmKVB+g1dvanJ6nlWO+BJCAmfii8axMSUc
 b2N0vWvC9yEepM9USz9e59OxnOiPeq6EwvCUvDVLGYjwpZhhJNcC6WlEyRtvoAKAHuYI
 ZjJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy98WGghb3omQOg7NQrznHPJd9L8W8vGfRrHz6m9n8xnrQcJJxCtlkVStWKs45pRj6i5+VTQfYG3EgF@nongnu.org
X-Gm-Message-State: AFuF++kByxyy7etXIcdySV8AySJDMkHSYzgpfJO9MeZD7wkWnTiktcGw
 0gOVK1KbTUNn3Ly7MA0zMcKZPjJwbHsqIWxdobJh2ZlOD9cQfN47iEGLcf3E1aSH8RbSq3PH+XR
 Lo4B4NJVJ/vISg9fPLtuItbzKx32XYl0PHstS8JdtihauAYTrCUZdHL5UcA==
X-Gm-Gg: AYBFou0pce9kgEBTaB/vEI52Meoebi8X14lc57Sg6+913BaDQH7VQVk1PdKBr4DV/Eq
 odSlNd/IrZNeHhkBplAl5GtoO2/gW3o3JbYeWpbxLWfmkHrSRT4w65VfgoH4faOC4+BroEJIBTD
 H96GZDjk4Sgzuut2ag+1I6rw3FEPOIJNtoM8cAoP8xdqYFffNBm5GpA6oyJTbN4+VpodQtRRnqj
 fq9oU/CD4t4+sIEGfSOFDHilBu2NNlQWsNjbLaua8svBBDmNSG6Hwrp5n+Pdbc2ntzU/OjKUTde
 M1vdnLNY+Gz68MRLZsUNJM1Zpy6CwxJYLS8KNXHgYNm3B7cthguH56tTWH/4J20CXb3HVBIig93
 T/yXZs8dIdo0AXleyDfXuUAYgtIgxKkKm06Z2rmOtjBM/JKKWER7Y5j8OQt0YPXuOiz5QLR4VY6
 OhJgU=
X-Received: by 2002:ad4:5c69:0:b0:912:517b:918 with SMTP id
 6a1803df08f44-91254cf9991mr20878126d6.55.1789702235097; 
 Thu, 17 Sep 2026 20:30:35 -0700 (PDT)
X-Received: by 2002:ad4:5c69:0:b0:912:517b:918 with SMTP id
 6a1803df08f44-91254cf9991mr20877776d6.55.1789702234507; 
 Thu, 17 Sep 2026 20:30:34 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91257dd713csm3246986d6.0.2026.09.17.20.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:30:33 -0700 (PDT)
Message-ID: <3afab26d-2c31-44ff-907c-2a742f9ef3f7@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 22:30:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] target/hexagon: convert raise_exception to
 hexagon_raise_exception
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Nicholas Piggin <npiggin@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-12-luoyonggang@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260918004225.827-12-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA0MyBTYWx0ZWRfX3PWJn4lVc6yc
 RIss+3cXQovtTNcwq34bKN8sLNjuZANoA6VoDkOYomxH/jK1l3HIph72ubUEDCkPYgL4KfqyF5g
 ILLq2cX8BoAG7KGEd68zVFtV74kD/TZxlHxaiYhLEmN20uBMjLcxAAnajRw4uCSXErSiGdDHNAH
 gU0tfn62Pe3wZ6UyyMTOWiBnlRTgjNJAURset/tcW8n/itWhatyyYYOPX6beV2OMujJsSpMw0Ad
 0HFX+OH8kBCl3UmqPnZdRsvN8+Co+ZC2K9OJXrXPuwDmCw7rptQszfvlN+aWtIrxdLGcyFB4jqp
 3yPaNmHA9aNgSy8p2q0JCrPdQa01WcadgfTa8U8zEpHqDsqs7qrHx08yNPVDKtTcQXfRxqGI5yr
 cWy9rtQe6tRWrQfVbwZkGsLOxUIfK0WiVO/xrNwWugP4B8duaD7GIzlT32fnuuJUz32F6yVAoU7
 CXVuc+9Fp8h75wjWWXA==
X-Proofpoint-GUID: ZYj9mC85d8lh2SID4gobEpcgackY9pR3
X-Authority-Analysis: v=2.4 cv=bcD+w+PB c=1 sm=1 tr=0 ts=6aacb05b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Tw5p6zTscUE-M7vGI2sA:9
 a=mLuBspt1sgg2Fw9-:21 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA0MyBTYWx0ZWRfX7QRFelX9nzy8
 cGEwQD7Sw2+aCSiW4oiJjjoDgQV2tNK3k7vgDiyZ0hjKPXK/a9ezGv6aPiioU8mVQrIfMP3MFAK
 /v2ETrwdhPw0fz6qZuqbxvxWYjsMqLY=
X-Proofpoint-ORIG-GUID: ZYj9mC85d8lh2SID4gobEpcgackY9pR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180043
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 9/17/2026 7:42 PM, Yonggang Luo wrote:
> Fold C do_raise_exception into hexagon_raise_exception_err with
> vaddr pc and a retaddr parameter, and exit via cpu_loop_exit_excp.
> Prefix leftover TCG raise_exception to hexagon_raise_exception so
> translate keeps the CPU_LOG_INT log and ASSERT_DIRECT_TO_GUEST_UNSET.
> Prefix leftover TCG wait to hexagon_wait with vaddr pc.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/cpu.c         | 13 +++++++------
>   target/hexagon/cpu.h         |  2 +-
>   target/hexagon/gen_tcg_sys.h |  2 +-
>   target/hexagon/helper.h      |  5 +++--
>   target/hexagon/internal.h    |  5 -----
>   target/hexagon/macros.h      |  2 +-
>   target/hexagon/op_helper.c   | 37 +++++++++++++++---------------------
>   target/hexagon/translate.c   | 11 ++++++-----
>   8 files changed, 34 insertions(+), 43 deletions(-)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index fad526ccfb5..0d2441b1671 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -333,7 +333,7 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
>       }
>       if (pc & PCALIGN_MASK) {
>           env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
> -        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc);
> +        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc, 0);
>       }
>   
>   #ifndef CONFIG_USER_ONLY
> @@ -711,14 +711,15 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
>               return false;
>           }
>           raise_perm_exception(cs, address, slot, access_type, excp);
> -        do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
> -                           retaddr);
> +        hexagon_raise_exception_err(env, cs->exception_index,
> +                                    env->gpr[HEX_REG_PC], retaddr);
>       }
>       if (probe) {
>           return false;
>       }
>       raise_tlbmiss_exception(cs, address, slot, access_type);
> -    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC], retaddr);
> +    hexagon_raise_exception_err(env, cs->exception_index,
> +                                env->gpr[HEX_REG_PC], retaddr);
>   }
>   
>   #include "hw/core/sysemu-cpu-ops.h"
> @@ -761,8 +762,8 @@ void hexagon_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>       CPUHexagonState *env = cpu_env(cs);
>   
>       raise_misaligned_exception(cs, addr, 0, access_type);
> -    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
> -                       retaddr);
> +    hexagon_raise_exception_err(env, cs->exception_index,
> +                                env->gpr[HEX_REG_PC], retaddr);
>   }
>   
>   #endif
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index b1533680bd7..e79d8000304 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -210,7 +210,7 @@ FIELD(TB_FLAGS, PCYCLE_ENABLED, 4, 1)
>   
>   G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
>                                               uint32_t exception,
> -                                            uintptr_t pc);
> +                                            vaddr pc, uintptr_t retaddr);
>   
>   #ifndef CONFIG_USER_ONLY
>   /*
> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
> index af5032214c4..489d2780470 100644
> --- a/target/hexagon/gen_tcg_sys.h
> +++ b/target/hexagon/gen_tcg_sys.h
> @@ -80,7 +80,7 @@
>   #define fGEN_TCG_Y2_wait(SHORTCODE) \
>       do { \
>           RsV = RsV; \
> -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
> +        gen_helper_hexagon_wait(tcg_env, tcg_constant_vaddr(ctx->pkt.pc)); \
>       } while (0)
>   
>   #define fGEN_TCG_Y2_resume(SHORTCODE) \
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 71c8da4c46d..cf1b977f33c 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -18,7 +18,8 @@
>   #include "internal.h"
>   #include "helper_protos_generated.h.inc"
>   
> -DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
> +DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn,
> +                   env, i32, vaddr)
>   DEF_HELPER_2(commit_store, void, env, int)
>   DEF_HELPER_3(gather_store, void, env, i32, int)
>   DEF_HELPER_1(commit_hvx_stores, void, env)
> @@ -136,7 +137,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
>   DEF_HELPER_3(setprio, void, env, i32, i32)
>   DEF_HELPER_2(start, void, env, i32)
>   DEF_HELPER_1(stop, void, env)
> -DEF_HELPER_2(wait, void, env, i32)
> +DEF_HELPER_2(hexagon_wait, void, env, vaddr)
>   DEF_HELPER_2(resume, void, env, i32)
>   DEF_HELPER_1(resched, void, env)
>   DEF_HELPER_3(modify_ssr, void, env, i32, i32)
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 05d1129916e..4b7a784fbc7 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -36,11 +36,6 @@ extern const char * const hexagon_sregnames[];
>   extern const char * const hexagon_gregnames[];
>   #endif
>   
> -void G_NORETURN do_raise_exception(CPUHexagonState *env,
> -        uint32_t exception,
> -        uint32_t PC,
> -        uintptr_t retaddr);
> -
>   #define hexagon_cpu_mmu_enabled(env) ({ \
>       HexagonCPU *cpu = env_archcpu(env); \
>       cpu->globalregs ? \
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index a5b9c24c6bb..4a87f6d72f1 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -637,7 +637,7 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
>   #ifdef CONFIG_USER_ONLY
>   #define fTRAP(TRAPTYPE, IMM) \
>       do { \
> -        hexagon_raise_exception_err(env, HEX_EVENT_TRAP0, PC); \
> +        hexagon_raise_exception_err(env, HEX_EVENT_TRAP0, PC, 0); \
>       } while (0)
>   #endif
>   
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 0d08ac77361..715dfd3ce13 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -72,31 +72,24 @@ uint64_t HELPER(utimer)(void)
>   #define SF_MANTBITS    23
>   
>   /* Exceptions processing helpers */
> -G_NORETURN
> -void do_raise_exception(CPUHexagonState *env, uint32_t exception,
> -                        uint32_t PC, uintptr_t retaddr)
> +G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
> +                                            uint32_t exception,
> +                                            vaddr pc, uintptr_t retaddr)
>   {
>       CPUState *cs = env_cpu(env);
> -    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08" PRIx32 ", @ %08" PRIx32 "\n",
> -                  __func__, exception, PC);
> +    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08" PRIx32 ", @ %08" VADDR_PRIx "\n",
> +                  __func__, exception, pc);
>       ASSERT_DIRECT_TO_GUEST_UNSET(env, exception);
>   
> -    env->gpr[HEX_REG_PC] = PC;
> -    cs->exception_index = exception;
> -    cpu_loop_exit_restore(cs, retaddr);
> -}
> -
> -G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
> -                                            uint32_t exception,
> -                                            uintptr_t pc)
> -{
> -    do_raise_exception(env, exception, pc, 0);
> +    env->gpr[HEX_REG_PC] = pc;
> +    cpu_loop_exit_excp(cs, exception, retaddr);
>   }
>   
> -G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
> -                                        uint32_t PC)
> +G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env,
> +                                                uint32_t exception,
> +                                                vaddr pc)
>   {
> -    hexagon_raise_exception_err(env, excp, PC);
> +    hexagon_raise_exception_err(env, exception, pc, 0);
>   }
>   
>   void log_store32(CPUHexagonState *env, target_ulong addr,
> @@ -1733,7 +1726,7 @@ static void set_wait_mode(CPUHexagonState *env)
>       SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask);
>   }
>   
> -static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
> +static void hexagon_wait_thread(CPUHexagonState *env, vaddr pc)
>   {
>       CPUState *cs;
>   
> @@ -1760,7 +1753,7 @@ static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
>           return;
>       }
>       set_wait_mode(env);
> -    env->wait_next_pc = PC + 4;
> +    env->wait_next_pc = pc + 4;
>   
>       cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>   }
> @@ -1828,12 +1821,12 @@ void HELPER(resched)(CPUHexagonState *env)
>       resched(env);
>   }
>   
> -void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
> +void HELPER(hexagon_wait)(CPUHexagonState *env, vaddr pc)
>   {
>       BQL_LOCK_GUARD();
>   
>       if (!fIN_DEBUG_MODE(env->threadId)) {
> -        hexagon_wait_thread(env, PC);
> +        hexagon_wait_thread(env, pc);
>       }
>   }
>   
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index fd1de87405c..2774a01a47c 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -129,11 +129,12 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
>       return offset;
>   }
>   
> -static void gen_precise_exception(int cause, uint32_t PC)
> +static void gen_precise_exception(int cause, vaddr pc)
>   {
>       tcg_gen_movi_i32(hex_cause_code, cause);
> -    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
> -                               tcg_constant_i32(PC));
> +    gen_helper_hexagon_raise_exception(tcg_env,
> +                                       tcg_constant_i32(HEX_EVENT_PRECISE),
> +                                       tcg_constant_vaddr(pc));
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> @@ -1071,11 +1072,11 @@ static void update_exec_counters(DisasContext *ctx)
>    */
>   static void check_imprecise_exception(DisasContext *ctx)
>   {
> -    TCGv PC = tcg_constant_tl(ctx->pkt.pc);
>       TCGLabel *label = gen_new_label();
>   
>       tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
> -    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
> +    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception,
> +                                       tcg_constant_vaddr(ctx->pkt.pc));
>       gen_set_label(label);
>   }
>   #endif

