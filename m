Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2854606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hgwvUjSc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CLgLf3Ve
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRbOq-0002Y2-Fu; Thu, 12 Nov 2026 15:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRbOn-0002Xe-LW
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 15:27:58 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRbOk-0003wJ-FJ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 15:27:56 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACJZlW72822435
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 20:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RNqo+RO9Llb9xh86KMzmx9MTzCETXPCxCBOgf9XgzUE=; b=hgwvUjScCH16SMiE
 MA2zgLQ1lqcunVWhydLd8EtPB4yAjf/uzS4UWiqaQKa4TeO0tGJvwNvuf69AWOzu
 eZiDAaaZaWv/OnB8oxyWvCTFqGZjVZ7lyZOj3tWVnmvS4fNDCj2y7/I1aSdiMndm
 fgq6pdz1YffmpvoD29QyVpH+yUKTWZegnQMO8RrGPppc9dmpaGNdIRtXst4XSPBC
 hh0AE0kZCpwHLxms5vSVQ8cp0NolRqqd756sRISYmdvaFFZe4Z8JOdpLkj+xjDdD
 1vJkB5pBnXKFEOUUpm5I9Pm6yW/IXbh4P2x72/OGDc6q7kKcrRzf9AqH1abp2Y5L
 izOcpw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs02699-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 20:27:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91ea0c20af3so4220826d6.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794515271; x=1795120071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RNqo+RO9Llb9xh86KMzmx9MTzCETXPCxCBOgf9XgzUE=;
 b=CLgLf3VeyKAcLIdYuANqHqHav7OgQCAHtHSoxFronqRZbcpUFXoHDMF9O73qBG7tn6
 /sAV0vC7PSAxinxzqmQwQv76cxKlGdB3MEyCUcF/fW+T/5qU7kQgl9l4C4S4umJFa5L9
 o9IWaRsDVeJrWFGFWneoUWTRCXBK+0qRpsaJCIXjE0fKNvbiiFHJqIOPAeNDIofq9nX2
 P/kQu1cZSj887XMjQ0yf8YwOTAHKRZGefRbk7BTnyECutwbQYKtEypyjB7eROFdRm2mJ
 IdbBk4kdQYXnfI/xmeLT2nQwG0tuvHxp6URMCxdyrtQy51wnIfOp2DslTVPSu+rz5A7Q
 1T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794515271; x=1795120071;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RNqo+RO9Llb9xh86KMzmx9MTzCETXPCxCBOgf9XgzUE=;
 b=xa2a0AT162hRcgqEnBaHFC3hZm6GjySDwejVMHjTtxqarCMR8l/gkTUlKtWJUFjqhZ
 w4ykIDTLXp7cCFqR76TbF706C6RY+NPwxadQoR2P7/ka925Yi/X25RC2M0Z63PEj4/qj
 6zzzaotQmbdDe5Mlh/NdN/KuvaT+TvUQlJrkK9uKLG2ibqu60nPsTLEa4SB8yO6njJ1M
 HmK20Np7ce7AFFHHUD++1qeV+hrfnamLGLqlR4oF3KoRxvwIK6I3cs/SIGdgfVrqHPua
 UvQGb8HzItFVEulmysuPX5GBGoU8FKbkr/0Be4EiZOHGi3KsPgA3UyYDDKB7gNfGShOD
 FgmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFNr767RSmGslJGaBmHhexyBPgzna+hLOEh/TqxAWdjJizqb6LNFitBVc73fulfb4mPRRudB5TEwVum@nongnu.org
X-Gm-Message-State: APuU4Z/tnm0speE1TWdqt1HnDWeMeQhGkUq6OBONKcXINWh2GE2qZWt6
 5ZzbUubj4hg86m42VZdWWqqYwl2hXkpqLKKJGsLG9VL5Yif+qxbQXQzTLFOXamtIT5k5kKfbaaz
 IEMhA7C3L/ujE2DzSCbFfBhru8v8qoZplOjw/IYfk6HVT+6B9eIihcJlhew==
X-Gm-Gg: AYBFou35n23DqsvCcGaIMrL2xmqsevEzXI8q4uFm3a5oYw7Fblu9U5iAsuLwKb7K7M/
 Yo3mgO37iuzttwULDZPkip95JVYK5VStTdTVBTas8wl/yBW3A5oHUDNdnT+TubLXp2fIX7W8jKJ
 /DFJf5aJQNJTymrRtm1IprprSyq/HsNjZmqJUq8ZM/jFfht3YdV72HcpbhHNfzeGEGFNdKMAjbs
 Cgzw/Ug7aJh5JIzmtZtHAugEjmLf/v0138wfS2CB3/z4jV9I611DgD6PbgsnzhAARfefuqvAfJJ
 I0+I8EW7BZPH2JPdFdDBFVYo0sDLQaOU6rEBxiLP7BW/6ASWmdhLjUBQy0gg6AgXAOQGgGN5jcs
 u6iLDRhm2DaCySTstGOkhpyx8pzKXKM/NBTEcQFWTFVMnQYWfhmJGtM6hhcRg7q/FmvBdjdkoCe
 cse89vXq+fVb9x9n1LnDo2KrzeTwvvtmklRjA/oZTPm/Q=
X-Received: by 2002:a05:620a:6f01:b0:947:b201:fabb with SMTP id
 af79cd13be357-9494bc3b4b6mr86891085a.58.1794515271050; 
 Thu, 12 Nov 2026 12:27:51 -0800 (PST)
X-Received: by 2002:a05:620a:6f01:b0:947:b201:fabb with SMTP id
 af79cd13be357-9494bc3b4b6mr86888085a.58.1794515270543; 
 Thu, 12 Nov 2026 12:27:50 -0800 (PST)
Received: from [192.168.68.105] (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c5fd154sm22125385a.2.2026.11.12.12.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 12:27:49 -0800 (PST)
Message-ID: <085470c7-8917-41c2-8fc9-2a6f11f1e5a0@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:27:46 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: change mstatus bits for read-only if S
 or U unsupported
To: "Christian S. Lima" <christianslima@proton.me>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20261112202356.23980-1-christianslima@proton.me>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112202356.23980-1-christianslima@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA4MSBTYWx0ZWRfX8Yp2uHJylAZ/
 Un9QS3DChJiFXej9QEoaJy3VWPl3tPSXfMHbhevEmjI2Qu8ZMmfGBM5RjZGsOkaLt2/62xQQyZ+
 tbfGHnifZAjwARee1IMUy8looXMLJHV1Gnke0WcrNfVLE9Cf1qtFt1QcVKl3Z9Qa4wBhQ7c5UOM
 /HRpGl+PjI0G9YQHQdKVd7GKUrKx/jC/SxEStbQsSjfiqSiSXYt+bG6y+PMbaZa5UJwr6+0oUCy
 jxK1m0vhmjH3x4GKNFzWS7UIGRltXvWcHyhvwoQbd7B12936mlf7HSKyVhE82qL25tKJvRXSRia
 dUK+C+Jnmi5UNYFwuzSj/Ved34CGFvSWxyARjK+sQZdssQvHGFATTP6UCJYcOvP/How5cZow3Y2
 CzpMpjWl2Jnv/bATUoer6WaH2b+w5g4Yo0oQYoqnVs+h9cWthWla/MOmCmnM6ySf/xP3GfP2pQA
 1fm1ExGKBJ89NQcw0CQ==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af62147 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KPDRrMschBuxgPRWLJUA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA4MSBTYWx0ZWRfX5MB3THiXhKC4
 WA3s7fZ32AMtA1PYtDazUUXpAoTD8VdKcRoYYF6+C2HoYtzoJgvBk1lwm6tBtT9a0ube3BdaieN
 hKGfOdCEAJREpF/0LYFu1htnkBSVr3g=
X-Proofpoint-GUID: gZQltF4MQXqDTTu8yX8_vplDw8wTFs9I
X-Proofpoint-ORIG-GUID: gZQltF4MQXqDTTu8yX8_vplDw8wTFs9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/12/2026 5:24 PM, Christian S. Lima wrote:
> The risc v privileged architecture says that mstatus.SXL, UXL, TSR,
> TVM and MPRV should be read-only when S-mode or U-mode are not
> present.
> 
> changes in v3:
> - Fixed grammar mistakes and now Daniel can be credited correctly by the tooling

Oh! Just now realized that the tag was wrong in v2:

"Suugested-by: Daniel ..."

> 
> Link to v2: https://lore.kernel.org/qemu-riscv/20261110232614.83050-1-christianslima@proton.me/
> 
> changes in v2:
> - Don't change bits in target/riscv/cpu_bits.h
> - Add checks to S-Mode in the mstatus.SXL and U-mode mstatus.UXL in
> the target/riscv/cpu.c file that were suggested by Daniel in the
> review [1]
> 
> Link to v1: https://lore.kernel.org/qemu-riscv/20261104223049.86286-1-christianslima@proton.me/
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4456
> 
> [1] https://lore.kernel.org/qemu-riscv/20261104223049.86286-1-christianslima@proton.me/T/#mddbb34a3ea837e3c707131a2e354c63c989ab029
> 
> Signed-off-by: Christian S. Lima <christianslima@proton.me>
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c     | 12 ++++++++++--
>   target/riscv/tcg/csr.c | 17 ++++++++++++-----
>   2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 15c27f4ce4..50bdfbe025 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -997,8 +997,16 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>            * The reset status of SXL/UXL is undefined, but mstatus is WARL
>            * and we must ensure that the value after init is valid for read.
>            */
> -        env->mstatus = set_field(env->mstatus, MSTATUS64_SXL, env->misa_mxl);
> -        env->mstatus = set_field(env->mstatus, MSTATUS64_UXL, env->misa_mxl);
> +        if (riscv_has_ext(env, RVS)) {
> +            env->mstatus = set_field(env->mstatus,
> +                                     MSTATUS64_SXL, env->misa_mxl);
> +        }
> +
> +        if (riscv_has_ext(env, RVU)) {
> +            env->mstatus = set_field(env->mstatus,
> +                                     MSTATUS64_UXL, env->misa_mxl);
> +        }
> +
>           if (riscv_has_ext(env, RVH)) {
>               env->vsstatus = set_field(env->vsstatus,
>                                         MSTATUS64_SXL, env->misa_mxl);
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index af444e3e6f..24eda54bac 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2081,18 +2081,25 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>           tlb_flush(env_cpu(env));
>       }
>       mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> -        MSTATUS_SPP | MSTATUS_MPRV | MSTATUS_SUM |
> -        MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> -        MSTATUS_TW;
> +        MSTATUS_SPP | MSTATUS_SUM | MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TW;
>   
>       if (riscv_has_ext(env, RVF)) {
>           mask |= MSTATUS_FS;
>       }
>   
> +    if (riscv_has_ext(env, RVS) || riscv_has_ext(env, RVU)) {
> +        mask |= MSTATUS_MPRV;
> +    }
> +
>       if (riscv_cpu_cfg(env)->ext_zve32x) {
>           mask |= MSTATUS_VS;
>       }
>   
> +    if (riscv_has_ext(env, RVS)) {
> +        mask |= MSTATUS_TSR;
> +        mask |= MSTATUS_TVM;
> +    }
> +
>       if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
>           mask |= MSTATUS_SDT;
>           if ((val & MSTATUS_SDT) != 0) {
> @@ -2111,12 +2118,12 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>           if (riscv_has_ext(env, RVH)) {
>               mask |= MSTATUS_MPV | MSTATUS_GVA;
>           }
> -        if ((val & MSTATUS64_SXL) != 0) {
> +        if (riscv_has_ext(env, RVS) && (val & MSTATUS64_SXL) != 0) {
>               mask |= MSTATUS64_SXL;
>               val = riscv_write_uxl(env, val, MSTATUS64_SXL);
>           }
>   
> -        if ((val & MSTATUS64_UXL) != 0) {
> +        if (riscv_has_ext(env, RVU) && (val & MSTATUS64_UXL) != 0) {
>               mask |= MSTATUS64_UXL;
>               val = riscv_write_uxl(env, val, MSTATUS64_UXL);
>           }


