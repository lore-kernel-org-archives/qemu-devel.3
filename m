Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C7606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OxODRH46;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TNYC0oUQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBIM-0006IX-3P; Thu, 19 Nov 2026 18:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUBIK-0006IO-De
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:11:56 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUBIG-0008Pe-GJ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:11:55 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1LfR3655801
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MjSDIGqRxpfwMIdkM/M2nJAmWN6l/uQl+NyB1GsL5SE=; b=OxODRH46xZwnJuZi
 WrlgGbQvmgGMg50K0yIOhw3sHoEwoHEodn5lKqL8wLEBOWLDCq3PpROb+qM/TvY5
 9ku+aKoJTxtQ2XB7TYUpJ/cI6t/hqR4IywBBj68OJfSw9yqZkI9XvX+SM0mmy/iS
 rzmbw/IPl7I8c5y+AOxBenvSk40n67mOtNupBX5ak62BniRMI9ABXsh7/9itGPp2
 wjBdEjaldva+2Hdu+R+GGP698T6+2r2tJMN4gRMDgUEyHEGjZU9d1yw0lSSEox0O
 zqSAkNFlX72UHUKjanfX8zdmHbRa/tUbCo1Pw27O9qQdzAYPDnGZHsfeuzzv26zu
 eD//rQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j20gub9ff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:11:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso257531eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795129907; x=1795734707; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MjSDIGqRxpfwMIdkM/M2nJAmWN6l/uQl+NyB1GsL5SE=;
 b=TNYC0oUQhPHNxaiElRk6Kj024t54HIRjliYlijli/o3k2AJVWp4GeL74L918EL1at2
 qkVTtb8QhsDjeJAH2XrG935L0QZPhgDFEa9uYeoDrf7SrOIPyMeD5RH5jcEWWsQZfTKg
 yc7/Z0qhYbi8pNuD9mmkneLqM2zCNRA5+HXq85zGj26CpI2G/Px6MMucwnoJH0QmHNdZ
 JEgKQ6fMHfY27GOEyyX/+5VdBYUhH4kCwJeEncR9VX9GMWu1Nu8S6WFE/GqWpoO2ylBg
 UGDlv+AVLhAC45vgy9R+6wxEAUlWqz145F2WJZcPz2uTHLwa6FZiY+4EEetjrMvLTzZn
 gAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795129907; x=1795734707;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MjSDIGqRxpfwMIdkM/M2nJAmWN6l/uQl+NyB1GsL5SE=;
 b=P9B/6GjtsMloW7LTvCRCUXVUeggVb+msElYSB+6sv459jtxN/39yqhYHhWFurBBsqd
 SH2k/QKzW4Q4Y+2DVFVI9kE1SSz7kf3v3pLOMyATRSP+rRL4ul6D6nbwhdJ9RueK/kl/
 MnYJE6v77HEG6pZVlH9pkca7hwbB1COfHNI0BHCV2Bx2sRr9PgyEQyObWz8snJJkzru+
 scj/IP70hWCX+0zl2XDb+zXn6MSwuKVeIgEhpNI8fK4dTVSsrpdoN3knuulIVUw6jc6Y
 hfeNkxMArm/NUhkVlgFEyOYNUBf0rJsQQPAifzo2S9rs28dMT0JApfxcrtB37VtGsq9R
 ivjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEQaXZuUVE1ePq1PKkgSk4JhGTeCZSyJb1sXQxjx1wAWDWLuZhQqxZ6x+lT90DMbz5w5cYJGeZUqCKX@nongnu.org
X-Gm-Message-State: APuU4Z/v+YQr6urU1kC9P5gOCGb2AKmhMW5lRNUtYLyLvbCmrygCzGLr
 rXaioBzRwSMcdhJIaOUiYoCf8IwxeXHMLJzcJQGLzt78GcMWMa3udIhdwSRruYq+3gTOdzMC7x6
 kahXg8Xxk7oPEwgUlsy3wqKjubrX8QIwI+L67FwFs5KVxu4VdE//dZzjzPr1HWUXx7A==
X-Gm-Gg: AZFdTZczb23beGILV+/OvDpPVPxcRh+pEX6ksnqfcnY//41bEQvyIq6IVk4UQT4KdQX
 VG/9IDOs5jxkI5aAnldf8lokAEiaTjhE7/N4X1Zb4c8m60Fsisoh/h7EPdWP6ypFbAgCFqy+8kO
 YWucyYXUAQpPxaUY90AJjqoOayqNDfqf4k3xuzQjnJUAQLYBQ6Oh/C4+nNXVLoc2qlDgiwQn0X/
 2MbR+/Ec7a4Ki3zYF8lAFeL291zYgR5CS/RPjqsim0HbnaMu3NreGf9A4lB8Y+JSiwDEujeu29J
 0E+IOGUnTGy7+dos7O2yFKVpR4sxOJ39x3XGExAjwg9XqBXqShSK0RkqBkWrC05G8KNFKELnzBo
 VkoyHCePwMxpZnFop2OvTC0y3XFPZOcMeNqymCevr0D4bicQFDdcQr6Oit3ZgaxZVWsbWBnvnGo
 yPoAdqJMTcNbjpKmcxcg8zyI5cqJEfDOqNYX7s
X-Received: by 2002:a05:693c:60d4:b0:37e:fac6:7ef1 with SMTP id
 5a478bee46e88-38571120627mr866582eec.39.1795129906939; 
 Thu, 19 Nov 2026 15:11:46 -0800 (PST)
X-Received: by 2002:a05:693c:60d4:b0:37e:fac6:7ef1 with SMTP id
 5a478bee46e88-38571120627mr866541eec.39.1795129906336; 
 Thu, 19 Nov 2026 15:11:46 -0800 (PST)
Received: from [10.248.104.162] (160.sub-174-226-161.myvzw.com.
 [174.226.161.160]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm2039387eec.26.2026.11.19.15.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 15:11:45 -0800 (PST)
Message-ID: <c4bf850b-f631-4310-a78e-54f32254612b@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 17:11:42 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] target/hexagon: probe VMEMU upper transactions
 before lower ones
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-15-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119215853.987158-15-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MyBTYWx0ZWRfX01/IqDrTdvyX
 se0Djk6X1xd3cfEYVb7CzDbRbWbDK0O2OMp1rjxhNKtgmaljtuUefDHHehw2zNS5JjfulQMx2lD
 yNRI58gJYEeuNYezA0tG9nED7c4Xlrs=
X-Proofpoint-ORIG-GUID: uqUKDsArU6ZtzmgOHsk_8dZa8FouJg6s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MyBTYWx0ZWRfX2QDv8IS39yk4
 kWqrHZa1j91HzcimH4zGypRQT9hycLAWTGWDHTOjK0BfdA7OqzwspcFE7oVZ2Pm51H5Mk+xhjyv
 xnqwoiFEedpDVosPyXyzg/erdq9c1PN5NMgMv6Yn0B57eMhlLNEFQNYm3XcRrsV/6ho1eV95E2D
 04AyH6XmPCZyZi4zkkyZO6Zm3e5sHDXJzXfyCDmIP1m+OREowwkd/RqpLSfNBy1DP4+RTUTAyh/
 n1Rm5R0CIIRoe4sWg+0hSGpQR98rltiT/h1ZiWDqzkqYs+TYmGFSJKFMzoNgenBw5fiN0Idx1pM
 3+MFP+XlwbseEdOLu3P8pUYJyGxvvK+y58GoBBUWDhIbsJ3/vBNlgaV7lX4j9TDz63V2Kgnm4qr
 jI6ntX6DFmTdidFWSvMg617CG6mMZ+0icqE4IY36Wv1IaYKNIr2gQUA+E0wK0JzxdYSdXJjQSxi
 kJbaGSxeEiikYiX7oeA==
X-Proofpoint-GUID: uqUKDsArU6ZtzmgOHsk_8dZa8FouJg6s
X-Authority-Analysis: v=2.4 cv=XutvqlF9 c=1 sm=1 tr=0 ts=6aff8234 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=GMQ7njlnOdzlMr1UnwV+Pw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=SFsQfBXkJAIU8DLS2pcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190093
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


On 11/19/2026 3:58 PM, Marco Liebel wrote:
> Record both unaligned VMEMU addresses and probe the upper transaction
> first. Report the architectural address, not the page boundary found
> by a split TLB access. Preserve both validity bits on load and store
> faults.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c       |  4 +++-
>   target/hexagon/genptr.c    | 10 ++++++++++
>   target/hexagon/helper.h    |  3 +++
>   target/hexagon/op_helper.c | 38 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 1eb0fc588c..9146b27708 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -763,9 +763,11 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
>           for (int i = 0; i < 2; i++) {
>               if (valid & (1U << i)) {
>                   env->t_sreg[HEX_SREG_BADVA0 + i] =
> -                    i == slot ? VA : env->mem_access_va[i];
> +                    (env->mem_access_valid & (1U << i)) ?
> +                    env->mem_access_va[i] : VA;
>               }
>           }
> +        env->t_sreg[HEX_SREG_BADVA] = env->t_sreg[HEX_SREG_BADVA0 + slot];
>           SET_SSR_FIELD(env, SSR_V0, valid & 1);
>           SET_SSR_FIELD(env, SSR_V1, (valid >> 1) & 1);
>           SET_SSR_FIELD(env, SSR_BVS, slot);
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 339f43b7ae..077319a7b6 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -1635,6 +1635,11 @@ static void gen_vreg_load(DisasContext *ctx, TCGv_ptr dstbase,
>                             intptr_t dstoff, TCGv src, bool aligned)
>   {
>       TCGv_i64 tmp = tcg_temp_new_i64();
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_probe_hvx_mem(tcg_env, src, tcg_constant_i32(ctx->insn->slot),
> +                             tcg_constant_i32(aligned), tcg_constant_i32(0),
> +                             tcg_constant_i32(ctx->mem_idx));
> +#endif
>       if (aligned) {
>           tcg_gen_andi_tl(src, src, ~((int32_t)VECTOR_SIZE_BYTE - 1));
>       }
> @@ -1657,6 +1662,11 @@ static void gen_vreg_store(DisasContext *ctx, TCGv EA, TCGv_ptr srcbase,
>           return;
>       }
>   
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_probe_hvx_mem(tcg_env, EA, tcg_constant_i32(slot),
> +                             tcg_constant_i32(aligned), tcg_constant_i32(1),
> +                             tcg_constant_i32(ctx->mem_idx));
> +#endif
>       tcg_gen_movi_tl(hex_vstore_pending[slot], 1);
>       if (aligned) {
>           tcg_gen_andi_tl(hex_vstore_addr[slot], EA,
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 0303ea9bba..1c4de477fe 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -22,6 +22,9 @@ DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
>   DEF_HELPER_2(commit_store, void, env, int)
>   DEF_HELPER_3(gather_store, void, env, i32, int)
>   DEF_HELPER_1(commit_hvx_stores, void, env)
> +#ifndef CONFIG_USER_ONLY
> +DEF_HELPER_6(probe_hvx_mem, void, env, i32, i32, i32, i32, i32)
> +#endif
>   DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32)
>   DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
>   DEF_HELPER_4(sfrecipa, i64, env, f32, f32, i32)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 31e1140270..3492c99c08 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -54,6 +54,41 @@
>   #include "hexswi.h"
>   #endif
>   
> +#ifndef CONFIG_USER_ONLY
> +static void log_mem_address(CPUHexagonState *env, uint32_t va, uint32_t slot)
> +{
> +    assert(slot < 2);
> +    env->mem_access_valid |= 1U << slot;
> +    env->mem_access_va[slot] = va;
> +}
> +
> +void HELPER(probe_hvx_mem)(CPUHexagonState *env, uint32_t va, uint32_t slot,
> +                           uint32_t aligned, uint32_t store, uint32_t mmu_idx)
> +{
> +    uintptr_t ra = GETPC();
> +    uint32_t base = va & ~(VECTOR_SIZE_BYTE - 1);
> +
> +    if (aligned) {
> +        log_mem_address(env, base, slot);
> +    } else {
> +        /* VMEMU uses both slots; BADVA records the unaligned addresses. */
> +        log_mem_address(env, va, 0);
> +        log_mem_address(env, va + VECTOR_SIZE_BYTE, 1);
> +    }
> +    int first = aligned ? slot : 1;
> +    int last = aligned ? slot : 0;
> +    for (int s = first; s >= last; s--) {
> +        uint32_t address = base + (aligned ? 0 : s * VECTOR_SIZE_BYTE);

Hopefully we can get away with just checking pages that would be touched 
instead of every byte in the vector element?  If it's tricky/expensive 
to find the page size I think we can be pessimistic and pick the 
smallest page size.


> +        env->mem_slot = s;
> +        if (store) {
> +            probe_write(env, address, VECTOR_SIZE_BYTE, mmu_idx, ra);
> +        } else {
> +            probe_read(env, address, VECTOR_SIZE_BYTE, mmu_idx, ra);
> +        }
> +    }
> +}
> +#endif
> +
>   #ifdef CONFIG_USER_ONLY
>   /*
>    * User mode has no qtimer device backing TIMERLO/TIMERHI, so derive the
> @@ -493,6 +528,9 @@ static void probe_hvx_stores(CPUHexagonState *env, int mmu_idx,
>       /* Normal (possibly masked) vector store */
>       for (int i = 0; i < VSTORES_MAX; i++) {
>           if (env->vstore_pending[i]) {
> +#ifndef CONFIG_USER_ONLY
> +            env->mem_slot = i;
> +#endif
>               target_ulong va = env->vstore[i].va;
>               int size = env->vstore[i].size;
>               for (int j = 0; j < size; j++) {

