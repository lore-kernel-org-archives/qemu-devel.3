Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF94606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HXkc0gBH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UvC+9j6V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJb9t-0000Ya-Ml; Wed, 21 Oct 2026 14:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJb9r-0000YB-Rr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:35:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJb9p-00025h-Vl
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:35:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpHg41135444
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xCX46VFmx1bwUB67OuJI0vc27Wx/NwDF8kL5KC9TSLI=; b=HXkc0gBH0j3ExyEa
 QTFx0GMpg1Dlfrnj+T/KI17r6G6u9kKdKG4GUPKGyU4JnHo1OHliIX8St7FyYbw4
 hvhYLjCtRxspeydqIw8FxVHRg/w5uHwNEokb3Ehq+GS8/GLnu6qRTBLBxCAKvX83
 6EHk+rYbkyXhK4QNhOXXQPfoXY+v0gcpa0iy8bqKXxgL3AIiY7PnSQhensJL20wT
 h9FxWV2vDG8/66XRgrYE9TqwWEIooFTR+UaXdo0IBe/iwNk/pBdGGPIeLF/Y+xLt
 Mdt1UrmGJ+pBvFr91kt0L0jz29CyW+3WmEnsJaDfoPlVa5ixgsLpZguKLjUTRXDe
 Znvf2A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2gmxv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:35:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5337b591609so15670401cf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792607723; x=1793212523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xCX46VFmx1bwUB67OuJI0vc27Wx/NwDF8kL5KC9TSLI=;
 b=UvC+9j6VyhjFSi8rVLWE6K+NZ2wjJOH0rFIC3OOQ9j1p+3v6rHQz5mKg0KrD/CodFd
 RgILxRc5wMvVWrh5APKBtunSkrgfJeZkX8IBJLLq3qll5ZGqmRis1zPoknqwkt99YVvI
 w0srwLUqXp3Vztufvm5BawO365udqL3NPzKeUq58cOUOfPUL7HikuBW+gAUQu8yvLscZ
 MwGLyAlt5/p3WpXG0PrU2UauvhvQY5rkRLej4Dd9qgtx7UcQ0m65Z8m7yP0IWJfBdABE
 Qu7xbklYr8sV7a9t0wDM5YDy8Nu6e2UWNzmCz7ulEIkIhufst86mnFmNZaiKQ+hGVHt/
 ylHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792607723; x=1793212523;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xCX46VFmx1bwUB67OuJI0vc27Wx/NwDF8kL5KC9TSLI=;
 b=b62mT4uErtnYyBq3Jnc+QlBI2t3Rb62JLtcibDT06uq6HNiSqYLfrMRZlPsnnERs5/
 mW0gBef5pGaZa5D1iPTYWKK4cogW/U08veSS8e+90UgLYqadZ6YvMfgOrw8aC5oOrbGd
 aqdlabRWsuYOpfDrdlZJig0bFqdS5n/Zwr1hKmxs4QNO6fwhx8D1fh/lHJi5FRZyHftA
 ME3n3rFks1TnsjgDD9+O33yI083MYveFry57nUdOf5pTWUrmcWZatnr+PJ0NoGhDVRuG
 Qg8KLtXJ8nb4EMAN4ooggGn+DQycFcD3wX8RxjofkhKCiaar9vO+7XGNEKefm6DNnk1I
 TNCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAhodtGmuj6jl1p/xAA1SOntP1FubFJQuysWIncorEj9YMQIgojrDvrxbGIQPyOU0RmH5GYtQNXH3S@nongnu.org
X-Gm-Message-State: AFq9FYJWg66NSR7iOjwKh2dLkOhkK6bLLWpg8u4To3RjNuwQloBwLiIX
 PLgrI8XiqQCulMaUKam+tvX7qH4y1b5cq1TEOs70QteK//yDi7mVkPJ2IBkYIa0nuoaEDHmAXiA
 H7owuPuWWzCqbuYAKF6jFiQoLwHMKW8lmBgPOQiquzLHsP1twID2dHCdYwA==
X-Gm-Gg: AYBFou3RYLr1FgPiTz+kOPGQiBBMwAAIxdU4mgTgLFwlF8W+O40q7VB0Ltff8+FNMF1
 FP/x2cvvhaumarqKuH5FXLgk5NVfCiMeAk1VQBTAdTO/MApxG89pC+0E95ShbMObYzUXm0rFJPs
 ipHosMiphDOPN3DpU5LKHiXU91Y3IB2+poEXmO256+JYRCz5xMeTAHW81L4inStLbubmmEwCabu
 +SUdouYHEqg2TVqEqKH9JFfBUGyZFXm2RC54JR1F20gHBfzhxMXZKEgSDe+C1eabSnRFwDiZZQr
 wh90ZlUH0E0iVtxcbMOuuLfNQRhkoQ5olKJcmi9G6VriJL7yY98WmeKpSwSAj0bVH4CAW98N/Fz
 IFQXAdItNC/1mz2kLN4DnW2Gp6NXrj6IuHeOt3EXaQX2qJrXQ4Dbc5Qv40OorWvu9UEbY//4a
X-Received: by 2002:a05:622a:301:b0:533:3627:49fd with SMTP id
 d75a77b69052e-5369b8055a9mr51623451cf.18.1792607722770; 
 Wed, 21 Oct 2026 11:35:22 -0700 (PDT)
X-Received: by 2002:a05:622a:301:b0:533:3627:49fd with SMTP id
 d75a77b69052e-5369b8055a9mr51622831cf.18.1792607722062; 
 Wed, 21 Oct 2026 11:35:22 -0700 (PDT)
Received: from [192.168.68.101] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab4af6eesm6395981cf.1.2026.10.21.11.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:35:21 -0700 (PDT)
Message-ID: <00404c44-38ed-494a-ac31-1ea236780485@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:35:17 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/riscv: add riscv_cpu_has_supervisor_mode()
To: Ralf Ramsauer <ralf@vmexit.de>, qemu-devel@nongnu.org
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
References: <20261021110838.3097959-1-ralf@vmexit.de>
 <20261021110838.3097959-2-ralf@vmexit.de>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021110838.3097959-2-ralf@vmexit.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX6OaHibbb2yrb
 12mdizXDVLWp7QHQ7wqLM3n4dmAFucp60FY7INIQAbt8SvRcyZ40vhpjvrct8dLjvrkJZdTslvq
 y98HqeljKpb1aM39fW1U0w8T2GDGdJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX9o/qHNpdneem
 RvHA1mbsd79B1tJhmJddw7S+KLHuyc8GD7PCq+HhGpNE3QaPae7nJMJVpOi+zfXiovXywQh7cxV
 DwcLQAuJ8O/btxh1gucJy67QZiMfK5D3yKc+W9y7a3aYqHGhAgT/hCNqbTkuEwFbxewGcpzkqHR
 X8/nPtz2B1ppMqT2MDUiGC2ru9tVtcIALvU1LY6/uz5T6utjdqDU7oUNF0LEPvjA9gBAOgedlFP
 zXEfC32EnVDMP8ryGzeFAOtJkrRPF6IVxvLmyVrIJFAKCS62nvI827Tg470SBtIL2qiNLtY/TWF
 bgUsVghgltQ5pYNZi49faanI2SCOGDuBf3bXgZFiYllrt6xK4LX0NUZHkLFW/9tS6PtMW+nF6Bx
 V6DKiLpX+kUmOX+d1W/2dTEJPqF/3gn9Ld9Il4VMRPWaF1Vc/TlOBOcy1eg1bOoJXTH9XYslnH+
 UKLN8erOXVU75OXFjSw==
X-Proofpoint-ORIG-GUID: H6Sh1HYYPgPGKG18jenwiIHieod8erXE
X-Proofpoint-GUID: H6Sh1HYYPgPGKG18jenwiIHieod8erXE
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad905eb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ffQtN6DDJp9pZQXGl-YA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/2026 8:08 AM, Ralf Ramsauer wrote:
> From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> 
> Whether a hart has supervisor mode is decided in two places: KVM harts
> always have it, and for TCG it follows from RVS in the ISA string.
> riscv_plic_hart_config_string() already spells out both cases.
> 
> Board code needs the same answer to describe the interrupt controller,
> but it should not have to reach into CPURISCVState for it.  Add a helper
> next to riscv_cpu_is_vendor() so the next patches can ask the CPU
> instead of inspecting its internals.
> 
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 14 ++++++++++++++
>   target/riscv/cpu.h |  1 +
>   2 files changed, 15 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index da4c1a090b..19b6553e04 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -334,6 +334,20 @@ bool riscv_cpu_is_vendor(Object *cpu_obj)
>       return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
>   }
>   
> +bool riscv_cpu_has_supervisor_mode(RISCVCPU *cpu)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* KVM always provides supervisor mode, regardless of the ISA string */
> +    if (kvm_enabled()) {
> +        return true;
> +    }
> +
> +    return riscv_has_ext(&cpu->env, RVS);
> +#else
> +    return false;
> +#endif
> +}
> +
>   const char * const riscv_int_regnames[] = {
>       "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
>       "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8c8ffe94cd..535e56345f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -964,6 +964,7 @@ void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
>   bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
>   void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
>   bool riscv_cpu_is_vendor(Object *cpu_obj);
> +bool riscv_cpu_has_supervisor_mode(RISCVCPU *cpu);
>   
>   typedef struct isa_ext_data {
>       const char *name;


