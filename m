Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD2606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OJKbM2uS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WWn436QI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTjl-0007pD-0K; Mon, 23 Nov 2026 08:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVTjV-0007dB-F8
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:05:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVTjP-0001SM-Tr
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:05:20 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANCGFMe2478602
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +mB/uUSXfKtROC6Qw4OOqUL6CsUyj3yzq/doClwtQ58=; b=OJKbM2uS3WAcNgLf
 5J6EibyRk2LUvUDu0zMKXAIdxM905lnT+VskOBmTjfHlXdjYSPcD0IiFcgrxnNzn
 SESqSkfxVXLCg5FgdOKlFGeIAQHXosy+jmS8do3C9jz7cQqlNJcTr+CuLcViwwJc
 zXSuuDkz23UoRzm/MnknbnHOC0mnXruyaRFnqdxg43dCs2sRVgdPI66tEJZbdUlh
 yagHYlUhNg5XfUcwafEm2NSldzQCtS91Zqjd6g4r5SgfAdlIiFDa39KoATFvP7Xp
 VfUbHKI4cx8uDkWK7N26xNnEh20paFJ4z1wjzOlHs0ccB3e0pPg3F33h04OmQgJW
 xcf/Jw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1p9fx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:05:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-536720195ebso58329781cf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795439112; x=1796043912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+mB/uUSXfKtROC6Qw4OOqUL6CsUyj3yzq/doClwtQ58=;
 b=WWn436QIb4jCKNv6LxBh/aKuKEw6BKNDDvxW3xNJMjXPYUx+OeMUa1p0ir9IS74rbL
 m5lNE25nEdfiZOorDLcMW8nn6uN3vegspgF0j8dabZr5/i6OtP1vkZpC92JZ4Kl0GbBK
 IFcswmDt6Td6paziJ5qfnwhlMHawZi6DcXb3d7t2DB8AC5YhIGCbiDenmq6UEFiy9o/S
 v8MuNL5Y/U5qkoCAlsEDqSUBxtK7OIclJqXhPmOl5TKBYBK27sqeeHx+FsfhPJzUCJE9
 TnU6kmwmQkvbO6rT/OBsjD+a4GwHG+0qdMVAsgCHC43xKZ/cx7RnnhawPfHqickO/G5l
 Jn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795439112; x=1796043912;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+mB/uUSXfKtROC6Qw4OOqUL6CsUyj3yzq/doClwtQ58=;
 b=PKmgK0YCqMIgT3F9euA0krxUUtdDvTx0SDbp2p/UYWdxR2ZFw25xyAjjq8hwLp44ZR
 UvZON2m/QmcsPwKIRHUDyX40vokAJouculrmThuE8lOGIlChErrouuPe1JOenoZt9AkX
 +ItLTbdck1bvSeQB2lPBYOm54FVRQwdWuRZE7j2pQBkpi4wno/qbZuW+5lZ/5/SfA41a
 pxksfRe+gc+LMCewTiud7l97N7f/plY077BPCn9isS4V0Q2NOIshkqZcHrCgPvvH/69r
 0NDqC9yXSHCYbOAaGx46j/xqge8QqfbO/4p5kjsyRmy1UjY6d/e/eJKf7HM09LsQJzcr
 IQ7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGedt9+6oK553pEe+0BntWea8UQ8MEQB5s/9e1gKORi+DtfGECgBBlIGFSg9+bJzpytz0K2n36PwG3N@nongnu.org
X-Gm-Message-State: APuU4Z8poISSnYmvNIuEbQz8duAXWveoxxidfg9XK5zfmYFZDGPE1K6U
 XzATT144/oD2YbKFFpeOT6bkkhz9PlNUeabbRfuWeZEQ+YXfOrYsaOXbp5k5aIEIkQxwXqZKP24
 rL5ueRbCYgQWmQr4qayJWGwpc5mRNW4bbV/LtpyK43gutPpaOf+p4Qulo4g==
X-Gm-Gg: AZFdTZcJ41lodLpFgweqEaRczIjDkyaKrfDp7ZK+N1TLpOmkI+JSV27tw7ikzCi06iB
 nrNzPXo2MOu/i+Wirzwv2xC9YKmoHd7pNfP1bdYO7wOv2EAyi7K/3q2YtzNldiUPX2RDrARFnAd
 DS2njCWdu9chltn/D59LLOEgAnxZ+iKrg3cBqsFLAPqO/uAWcBtSsGUTUbMB+eEN2JmK5vRgs4w
 Sz28ukQtckc50RQD78JmZsjPDXqahQdNHRdQWsetTG/K0hVxJtj6NcuF0MTQBtOkEgbKCZbl1Xi
 aqBORx3Nx0lgIc+7xHvDMmnZgmCWjjhWHptr2l3IxEOSNkh35zOuPO1M9G/3Shqoiqmr4ZyjxNe
 XHXTpOhp7cdJuEAPGXV5b74FBQcJvRHW1HHWSz5KKbEJ35uUT/fhSvCRssIt9Opr3z2RqVw==
X-Received: by 2002:ac8:59d5:0:b0:55d:6cfa:3e85 with SMTP id
 d75a77b69052e-55d76a15e9amr220661261cf.16.1795439111805; 
 Mon, 23 Nov 2026 05:05:11 -0800 (PST)
X-Received: by 2002:ac8:59d5:0:b0:55d:6cfa:3e85 with SMTP id
 d75a77b69052e-55d76a15e9amr220660511cf.16.1795439111083; 
 Mon, 23 Nov 2026 05:05:11 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882c64fsm98638381cf.10.2026.11.23.05.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:05:10 -0800 (PST)
Message-ID: <e731f3d9-d113-4dfb-83e9-ba0c31bf655b@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:05:07 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 07/10] riscv: add RPMI system suspend service
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20261111060403.3777501-8-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111060403.3777501-8-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ockr4uJg-Ak8OxgBAA1a7Z5LzvcWtWPt
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b043a09 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=n5PFcW3B4EN367TUXdoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MSBTYWx0ZWRfX1gndYAP/X0rt
 ITXyngzi4og3lEIoT8/TUOci9c4lydNhIf4+KrF7/IEO1RcsplQmKaksG+zFdZCEeStVXcjtmm0
 2YxbwreRXG2+ck7K8qm+0iXHppJrwbE=
X-Proofpoint-ORIG-GUID: Ockr4uJg-Ak8OxgBAA1a7Z5LzvcWtWPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MSBTYWx0ZWRfXwG6r9qfazgXg
 tM4UZpT4DK/KD8+Cz5c5FQfy/MUIRNJmwieooZ+eC9icHO/gMqg3Q/pgIQKWz3vwToQUExjHIB6
 V7pRvmPtTbS3u1L7GTZVWCLai6nRVoO4gQWdzPpfmyjqLDHHWrHHsPEnS8R//qKwXssEGUN8Gf2
 3S1dMyFf6O9db0aRNfivtgfWuRAbgCUH2Zz6idwvE/uKsBm24zehc+rITrF8zai7Ug2DDvC14AP
 iO95q7TihH4mzASetannCmHyd78kOhGvUHq1i+rLVPbJ2/14BSO/FoPnvOBLaH2UsCVfza3ZmAN
 2fvGVR99a2V89zhBN5ZFHTopv81wIiJ39Og9hRGNwsblyH951wB5mMBrWjBLz2tQvZOzM0hzJos
 Ua01E7kPENfHIF2stmybNWgDzxweMwIsA4Ac4nTDS6hIgj3HoT1/UIGVKda9EB3aA8+VkZLivAu
 jATj4t8zjzPoRX9QfaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 3:03 AM, Subrahmanya Lingappa wrote:
> Add the RPMI System Suspend service group for RISC-V virt.
> 
> The service advertises suspend-to-RAM support through librpmi, registers
> QEMU wakeup support, and routes the finalize callback to the generic system
> suspend path. Process only the accepted System Suspend event instead of
> polling every RPMI service group from an unrelated doorbell request.
> 
> On wakeup, publish the suspend event under the BQL and defer the HSM hart
> resume until vCPUs are ready to run. Cancel stale wakeup work during
> teardown. Machine reset removes and recreates System Suspend around HSM
> reconstruction so the service always references the current HSM object.
> 
> Reject malformed resume addresses before accepting suspend. Require the
> target hart's configured instruction alignment and address width, and
> verify that the resume PC is backed by RAM in the active system-memory map.
> 
> Validate the librpmi hart index and target CPU before accessing hart state.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/misc/meson.build           |   2 +
>   hw/misc/riscv_rpmi.c          |  30 +++--
>   hw/misc/riscv_rpmi_hsm.c      |  15 +++
>   hw/misc/riscv_rpmi_internal.h |   8 +-
>   hw/misc/riscv_rpmi_syssusp.c  | 210 ++++++++++++++++++++++++++++++++++
>   hw/riscv/virt.c               |   5 +
>   include/hw/misc/riscv_rpmi.h  |   9 ++
>   7 files changed, 271 insertions(+), 8 deletions(-)
>   create mode 100644 hw/misc/riscv_rpmi_syssusp.c
> 
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 6d93cd4ab0..1dc7aa7c67 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -188,3 +188,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
>     'riscv_rpmi_sysreset.c',
>     'riscv_rpmi_hsm.c',
>   ), librpmi], if_false: files('riscv_rpmi-stub.c'))
> +specific_ss.add(when: 'CONFIG_RISCV_RPMI',
> +                if_true: [files('riscv_rpmi_syssusp.c'), librpmi])
> diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
> index 1bf9d77b04..56a092e49e 100644
> --- a/hw/misc/riscv_rpmi.c
> +++ b/hw/misc/riscv_rpmi.c
> @@ -214,6 +214,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
>           .service_group = RPMI_SRVGRP_HSM,
>           .add = riscv_rpmi_hsm_add,
>           .remove = riscv_rpmi_hsm_remove,
> +    }, {
> +        .service_group = RPMI_SRVGRP_SYSTEM_SUSPEND,
> +        .add = riscv_rpmi_syssusp_add,
> +        .remove = riscv_rpmi_syssusp_remove,
>       },
>   };
>   
> @@ -256,6 +260,7 @@ static void riscv_rpmi_init(Object *obj)
>   static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
>   {
>       RiscvRpmiState *s = RISCV_RPMI(obj);
> +    bool reset_syssusp = s->syssusp_group != NULL;
>   
>       s->doorbell = 0;
>   
> @@ -263,9 +268,15 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
>           memset(memory_region_get_ram_ptr(&s->shmem), 0, s->shmem_size);
>           memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
>       }
> +    if (reset_syssusp) {
> +        riscv_rpmi_syssusp_remove(s);
> +    }
>       if (!riscv_rpmi_hsm_reset(s, &error_abort)) {
>           return;
>       }
> +    if (reset_syssusp && !riscv_rpmi_syssusp_add(s, &error_abort)) {
> +        return;
> +    }
>   }
>   
>   static void riscv_rpmi_cleanup(RiscvRpmiState *s)
> @@ -309,13 +320,6 @@ bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
>       return false;
>   }
>   
> -void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s)
> -{
> -    if (s->context) {
> -        rpmi_context_process_a2p_request(s->context);
> -    }
> -}
> -
>   bool riscv_rpmi_context_add_group(RiscvRpmiState *s,
>                                     struct rpmi_service_group *group,
>                                     const char *name,
> @@ -340,6 +344,18 @@ void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
>       }
>   }
>   
> +void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s)
> +{
> +    if (s->context) {
> +        rpmi_context_process_a2p_request(s->context);
> +        if (s->syssusp_event_pending && s->syssusp_group) {
> +            s->syssusp_event_pending = false;
> +            rpmi_context_process_group_events(s->context,
> +                                              RPMI_SRVGRP_SYSTEM_SUSPEND);
> +        }
> +    }
> +}
> +
>   static bool riscv_rpmi_validate_config(RiscvRpmiState *s, Error **errp)
>   {
>       uint64_t queue_bytes;
> diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
> index 42a4f3b096..08e78e1ee7 100644
> --- a/hw/misc/riscv_rpmi_hsm.c
> +++ b/hw/misc/riscv_rpmi_hsm.c
> @@ -42,6 +42,7 @@ static RiscvRpmiHsmHart *riscv_rpmi_hsm_hart(RiscvRpmiState *s,
>   
>       return &s->hsm_harts[hart_index];
>   }
> +
>   static void riscv_rpmi_hsm_wfi(CPUState *cpu, bool entering, void *opaque)
>   {
>       RiscvRpmiHsmHart *hart = opaque;
> @@ -342,3 +343,17 @@ bool riscv_rpmi_hsm_reset(RiscvRpmiState *s, Error **errp)
>       s->hsm_group = group;
>       return true;
>   }
> +
> +void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index,
> +                           uint64_t resume_addr)
> +{
> +    RiscvRpmiHsmHart *hart = riscv_rpmi_hsm_hart(s, hart_index);
> +
> +    if (!hart) {
> +        return;
> +    }
> +
> +    hart->start_addr = resume_addr;
> +    run_on_cpu(hart->cpu, riscv_rpmi_hsm_start_cpu,
> +               RUN_ON_CPU_HOST_PTR(hart));
> +}
> diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
> index e56dba5b1a..8739c3f041 100644
> --- a/hw/misc/riscv_rpmi_internal.h
> +++ b/hw/misc/riscv_rpmi_internal.h
> @@ -20,18 +20,24 @@
>   extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
>   bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
>                                   enum rpmi_servicegroup_id service_group);
> -void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s);
>   bool riscv_rpmi_context_add_group(RiscvRpmiState *s,
>                                     struct rpmi_service_group *group,
>                                     const char *name,
>                                     Error **errp);
>   void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
>                                        struct rpmi_service_group *group);
> +void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s);
> +
>   bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);
>   void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
>   
>   bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
>   void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
>   bool riscv_rpmi_hsm_reset(RiscvRpmiState *s, Error **errp);
> +void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index,
> +                           uint64_t resume_addr);
> +
> +bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp);
> +void riscv_rpmi_syssusp_remove(RiscvRpmiState *s);
>   
>   #endif
> diff --git a/hw/misc/riscv_rpmi_syssusp.c b/hw/misc/riscv_rpmi_syssusp.c
> new file mode 100644
> index 0000000000..0754f4b570
> --- /dev/null
> +++ b/hw/misc/riscv_rpmi_syssusp.c
> @@ -0,0 +1,210 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * RISC-V RPMI System Suspend service.
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "riscv_rpmi_internal.h"
> +#include "system/address-spaces.h"
> +#include "system/memory.h"
> +#include "qemu/timer.h"
> +#include "system/cpus.h"
> +#include "system/runstate.h"
> +#include "target/riscv/cpu.h"
> +
> +static const struct rpmi_system_suspend_type riscv_rpmi_syssusp_types[] = {
> +    {
> +        .type = RPMI_SYSSUSP_TYPE_SUSPEND_TO_RAM,
> +        .attr = RPMI_SYSSUSP_ATTRS_FLAGS_RESUMEADDR,
> +    },
> +};
> +
> +static enum rpmi_error riscv_rpmi_syssusp_prepare(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_system_suspend_type *syssusp_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +    RiscvRpmiState *s = priv;
> +    CPUState *target_cpu;
> +    RISCVCPU *cpu;
> +    unsigned int alignment;
> +    MemoryRegionSection section;
> +
> +    if (!s->hart_ids || hart_index >= s->hart_count) {
> +        return RPMI_ERR_INVALID_PARAM;
> +    }
> +
> +    target_cpu = cpu_by_arch_id(s->hart_ids[hart_index]);
> +    if (!target_cpu) {
> +        return RPMI_ERR_INVALID_PARAM;
> +    }
> +    cpu = RISCV_CPU(target_cpu);
> +    alignment = ((cpu->env.misa_ext_mask & RVC) ||
> +                 cpu->cfg.ext_zca) ? 2 : 4;
> +
> +    if ((resume_addr & (alignment - 1)) ||
> +        (cpu->env.misa_mxl == MXL_RV32 && resume_addr > UINT32_MAX)) {
> +        return RPMI_ERR_INVALID_ADDR;
> +    }
> +
> +    section = memory_region_find(get_system_memory(), resume_addr, 1);
> +    if (!section.mr || !memory_region_is_ram(section.mr) ||
> +        memory_region_is_rom(section.mr)) {
> +        if (section.mr) {
> +            memory_region_unref(section.mr);
> +        }
> +        return RPMI_ERR_INVALID_ADDR;
> +    }
> +    memory_region_unref(section.mr);
> +
> +    /* The accepted request needs one targeted event pass to finalize it. */
> +    s->syssusp_event_pending = true;
> +    return RPMI_SUCCESS;
> +}
> +
> +static rpmi_bool_t riscv_rpmi_syssusp_ready(void *priv,
> +                                            rpmi_uint32_t hart_index)
> +{
> +    return true;
> +}
> +
> +static void riscv_rpmi_syssusp_finalize(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_system_suspend_type *syssusp_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +    qemu_system_suspend_request();
> +}
> +
> +static rpmi_bool_t riscv_rpmi_syssusp_can_resume(void *priv,
> +                                                 rpmi_uint32_t hart_index)
> +{
> +    return runstate_check(RUN_STATE_RUNNING);
> +}
> +
> +static enum rpmi_error riscv_rpmi_syssusp_resume(
> +    void *priv, rpmi_uint32_t hart_index,
> +    const struct rpmi_system_suspend_type *syssusp_type,
> +    rpmi_uint64_t resume_addr)
> +{
> +    RiscvRpmiState *s = priv;
> +
> +    s->syssusp_resume_hart_index = hart_index;
> +    s->syssusp_resume_addr = resume_addr;
> +    s->syssusp_resume_pending = true;
> +    return RPMI_SUCCESS;
> +}
> +
> +static const struct rpmi_syssusp_platform_ops riscv_rpmi_syssusp_ops = {
> +    .system_suspend_prepare = riscv_rpmi_syssusp_prepare,
> +    .system_suspend_ready = riscv_rpmi_syssusp_ready,
> +    .system_suspend_finalize = riscv_rpmi_syssusp_finalize,
> +    .system_suspend_can_resume = riscv_rpmi_syssusp_can_resume,
> +    .system_suspend_resume = riscv_rpmi_syssusp_resume,
> +};
> +
> +static void riscv_rpmi_wakeup_timer(void *opaque)
> +{
> +    RiscvRpmiState *s = opaque;
> +
> +    if (s->syssusp_resume_pending) {
> +        riscv_rpmi_hsm_resume(s, s->syssusp_resume_hart_index,
> +                              s->syssusp_resume_addr);
> +        s->syssusp_resume_pending = false;
> +        s->syssusp_resume_addr = 0;
> +    }
> +}
> +
> +static void riscv_rpmi_wakeup_notify(Notifier *notifier, void *data)
> +{
> +    RiscvRpmiState *s = container_of(notifier, RiscvRpmiState,
> +                                     wakeup_notifier);
> +
> +    rpmi_context_process_group_events(s->context,
> +                                      RPMI_SRVGRP_SYSTEM_SUSPEND);
> +    /*
> +     * Wakeup notifiers run before vCPUs resume. Defer the HSM kick so
> +     * OpenSBI can leave WFI after QEMU restarts execution.
> +     */
> +    timer_mod(s->wakeup_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 10);
> +}
> +
> +static bool riscv_rpmi_syssusp_create(RiscvRpmiState *s,
> +                                      struct rpmi_service_group **group,
> +                                      Error **errp)
> +{
> +    if (!s->hsm) {
> +        error_setg(errp, "RPMI system suspend service requires HSM service");
> +        return false;
> +    }
> +
> +    *group = rpmi_service_group_syssusp_create(
> +        s->hsm, ARRAY_SIZE(riscv_rpmi_syssusp_types),
> +        riscv_rpmi_syssusp_types, &riscv_rpmi_syssusp_ops, s);
> +    if (!*group) {
> +        error_setg(errp, "failed to create RPMI system suspend service group");
> +        return false;
> +    }
> +
> +    qemu_register_wakeup_support();
> +    s->wakeup_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> +                                   riscv_rpmi_wakeup_timer, s);
> +    s->wakeup_notifier.notify = riscv_rpmi_wakeup_notify;
> +    qemu_register_wakeup_notifier(&s->wakeup_notifier);
> +    return true;
> +}
> +
> +static void riscv_rpmi_syssusp_destroy(RiscvRpmiState *s)
> +{
> +    notifier_remove(&s->wakeup_notifier);
> +    timer_free(s->wakeup_timer);
> +    s->wakeup_timer = NULL;
> +
> +    s->syssusp_event_pending = false;
> +    s->syssusp_resume_pending = false;
> +    s->syssusp_resume_hart_index = 0;
> +    s->syssusp_resume_addr = 0;
> +
> +    if (s->syssusp_group) {
> +        rpmi_service_group_syssusp_destroy(s->syssusp_group);
> +        s->syssusp_group = NULL;
> +    }
> +}
> +
> +bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp)
> +{
> +    struct rpmi_service_group *group;
> +
> +    if (s->syssusp_group) {
> +        error_setg(errp, "duplicate RPMI system suspend descriptor");
> +        return false;
> +    }
> +
> +    if (!riscv_rpmi_syssusp_create(s, &group, errp)) {
> +        return false;
> +    }
> +
> +    if (!riscv_rpmi_context_add_group(s, group, "system suspend", errp)) {
> +        s->syssusp_group = group;
> +        riscv_rpmi_syssusp_destroy(s);
> +        return false;
> +    }
> +
> +    s->syssusp_group = group;
> +    return true;
> +}
> +
> +void riscv_rpmi_syssusp_remove(RiscvRpmiState *s)
> +{
> +    if (!s->syssusp_group) {
> +        return;
> +    }
> +
> +    riscv_rpmi_context_remove_group(s, s->syssusp_group);
> +    riscv_rpmi_syssusp_destroy(s);
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 32aa13325e..53a31d1abd 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -490,6 +490,11 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
>           .compatible = "riscv,rpmi-hsm",
>           .service_group = RPMI_SRVGRP_HSM,
>       },
> +    {
> +        .node_name = "suspend",
> +        .compatible = "riscv,rpmi-system-suspend",
> +        .service_group = RPMI_SRVGRP_SYSTEM_SUSPEND,
> +    },
>   };
>   
>   static uint32_t virt_rpmi_service_count(void)
> diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
> index 3a240941cd..3aaaaf68ae 100644
> --- a/include/hw/misc/riscv_rpmi.h
> +++ b/include/hw/misc/riscv_rpmi.h
> @@ -13,6 +13,8 @@
>   
>   #include "exec/hwaddr.h"
>   #include "hw/core/sysbus.h"
> +#include "qemu/notify.h"
> +#include "qemu/timer.h"
>   #include "qom/object.h"
>   
>   #ifdef CONFIG_LIBRPMI
> @@ -84,9 +86,16 @@ struct RiscvRpmiState {
>       char *platform_info;
>       const RiscvRpmiMachineOps *machine_ops;
>       struct rpmi_service_group *sysreset_group;
> +    struct rpmi_service_group *syssusp_group;
>       struct rpmi_hsm *hsm;
>       struct rpmi_service_group *hsm_group;
>       RiscvRpmiHsmHart *hsm_harts;
> +    bool syssusp_event_pending;
> +    Notifier wakeup_notifier;
> +    QEMUTimer *wakeup_timer;
> +    bool syssusp_resume_pending;
> +    uint32_t syssusp_resume_hart_index;
> +    uint64_t syssusp_resume_addr;
>       uint32_t *hart_ids;
>       uint32_t hart_count;
>       const RiscvRpmiServiceConfig *services;


