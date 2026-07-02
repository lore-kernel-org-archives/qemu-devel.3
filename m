Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206ACC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHHo-0001ah-Gu; Thu, 02 Jul 2026 09:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHHk-0001Zb-S0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:16:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHHh-0008L8-Th
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:16:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0XdD527910
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3aRloceSIq4PY+JY12oja1+uP+Ju66pkj1MQEHnk9Js=; b=DcrvWLOZd6cHbXql
 6j2mMCrY5QDHmmE91AqaYH6jxb8Sfg+yOONLiGNfRVu0AsbEYNANFwo2Gu5Czr7h
 0dIwcTxTNR6eecwFyG6ZHNYuYOZANYQ/fXuAmTUPUj3X2pfadK9VA8eAvso8H5HY
 myo8Bh90MkC1xRVTz55lut4Iw3zoZyLHTZunmHz+dcFJVWrz901IRnhTzKwFQyOK
 Mwar2z8F34DXyQuHeNU7Cwja7RpyIxbCkn+zkdUnosCtYjQRC0P00zt/qLs6rmGC
 2tp8RLL3/vQJ0MQkNYiNrHanlNmxSbOEEZIbnCabjcHaUJejIKmql9/dM58d/db4
 6+6n/Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9vfp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:16:51 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bd83569844so2020373e0c.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998211; x=1783603011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3aRloceSIq4PY+JY12oja1+uP+Ju66pkj1MQEHnk9Js=;
 b=hYuzFzci4Ler8+13VuiKE2OgF/6XelitC1hab2T4FapNiZ0nHtzhvh4d7xgBme21PA
 sboUlqQN0wrluCOFydYB1G8v7ZJAirslC3bGMgVxJJi6rkdoj6XQGfOYWk3keiQScgiV
 63h9/dU0xhGrdopZeqU73A+WOLo/HJx6bFSOIX45mB0PDMI1HTKKAIm19gFi4htwuyE2
 Ys+Ui1ite6MqhYlJL5Yb3U1EG32SEe36bIz57I+f1gReAni6q2VochYluiWRY/k39hry
 P+Jd3E7vJRDss0/lUJpbmToY4+efW4ozsR3JQy2o/xYtp8DqxHu/7droILIR1VlPNVZz
 W8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998211; x=1783603011;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3aRloceSIq4PY+JY12oja1+uP+Ju66pkj1MQEHnk9Js=;
 b=ksFDgO01FIPPAgNg8Fs54MSUwnUu4/2XSVIp7+nCPmsUJMGEvV2hXIJuAb7nLTsMBu
 9AQxswqDJVKTXTFQ6umwmSPAR7S+oC7PE8fLvMAmLH67j86UFGkDGwceanbzgKFRyejU
 HToMefBcl6ul7D3NYPcsbYN6AhKblEFxF5/3l+ky3N/LrCaBxS03CBJV+h+U0jRsd0pO
 NxF85ViRpwD7UtDjIVdzzbNHhAtI0lLyzbPhI5SJbz2u5brKKPStDKCxpEtAZcL0MEMp
 4P/+cXivuoMQZBeswaA9Iu9MBlhDP9l8rwPqc36KAJDWYuK3UTi3p4AyWmHeoWfyhVpy
 3YzA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMp+4pB14UJd4KeCE68XMBEV3VAzDIirehCxCAHzoj3X51cyziAE6Djbzvq6RTqcTIY0s9VRNVzbrt@nongnu.org
X-Gm-Message-State: AOJu0YzsP4Lnk9GRy4H/uI0FmQXanr7RQjoRXN3x7VYhwJWacTe9/7f7
 6N8l8GujuiG4pNP0SmTDKrqPWH21V4WY8FjS1IZoZxEcAiQj1xsfLpYAcPE+z5mDEvNcMgZEhOF
 wsHnpDrdrtRTvd8u6jjGAk4JfaOWTdoTKjVXVU+KxgJZbR5KGGhupsxxTeA==
X-Gm-Gg: AfdE7clCcvrh7i0MdGk2yZ5kBSIuZ6DuiGNy+BFF+DrQNHd61d6HIzUhUKKdd/PuZrk
 psvfM6YkPZovVzH2dEG3/bZegmkQuauSzSBVB4vGq+PO7qQA7rHXi59ukNEoEzpCR1bubCy2MM2
 +Qc1MUW4DBQXZogTrFwumt7B6CNoaDZMEihuFvDNaO+2G5BD3gtirwEA8kqJA7T15dDmuXVu7pY
 XBt3YmVWcdiAzqId/E5FM7QejN9AU/9+dhF58wnSUm/Rrz2HfhTUdi/UQGsmr29AXe3tpgFZdaV
 KElXa4Gtn/6XGTYhRaegYCmUzmxaY7O0qYARb5UvnXBmeFEi3rUf++NpldazTKj+jkw5/Fzzu3X
 TMpSCvxk3fX2mR6LoE40EHWJk3zSbexhiR9EOyK4hL5V4
X-Received: by 2002:a05:6122:3c4b:b0:5bd:a247:49e2 with SMTP id
 71dfb90a1353d-5bddf516577mr2696067e0c.1.1782998210841; 
 Thu, 02 Jul 2026 06:16:50 -0700 (PDT)
X-Received: by 2002:a05:6122:3c4b:b0:5bd:a247:49e2 with SMTP id
 71dfb90a1353d-5bddf516577mr2696008e0c.1.1782998210349; 
 Thu, 02 Jul 2026 06:16:50 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bdec77b3eesm848360e0c.9.2026.07.02.06.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:16:49 -0700 (PDT)
Message-ID: <d8560f38-63db-467e-afad-fd7353fc91c1@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:16:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] cpu: Constify CPUState::cc (cached CPUClass pointer)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-2-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzOCBTYWx0ZWRfX70QHumc0L8gR
 VI4whbt4jdiBAVt/OoE+qxtD5Pac4mZLvOS1Pztlg+BJQDKlNgKKdRSeyZx1knPaUWKfl+OXsZ2
 j8O84iNOw0ckG/BAIN+EvN5bvFXLnypeWBT51PhtVV/7LDpNW876PC1ubmKWS2cPRE1fcTnlhGg
 i85eFdmB1CY/5TE3HIupspRd+l96cix3v7QyRBIJm2583Tk395d+PRWFbTX7vRGDsRPuQ1qcG+t
 /wZnF0EwRfweSxwK9b1SqQSHQREyjzRKS0S376efoYxFIE3SK2HMrfGfkLUWBrmBBXzZjqPLUva
 vglar1Uh3FL+B1h/mSzhgXKXEYqMrHixpk5EndivcuYeF2aSthrvOmI5/i0QKjMVinflWCAfaVc
 dRmlZck1Nv2fvTR7vFuhz5vOEbPe6UpQSEbO1F/9xoDDzeV2Uic64l9zNn8B28fNOjRBzn42+JA
 etI99vJyHkn5idvV/GQ==
X-Proofpoint-ORIG-GUID: DUAeK99_pCmFhGvOfMj-e8vNO4iwHDL5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzOCBTYWx0ZWRfX27VlF0JMyreP
 RflM/ZAWSeoM4v8b/puz1zCVMo5utaMDUltkvzPq6o8lfdCfjF/hv8mpvbiCkwl6JKNEqvCwcZp
 s5UH0O1TjZCL216nLkpZLls6kKptzIQ=
X-Proofpoint-GUID: DUAeK99_pCmFhGvOfMj-e8vNO4iwHDL5
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a4664c3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ARCOixZDCGajkiXeM4AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020138
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Various CPUState can share the same CPUClass parent,
> and must not update its fields. Protect the CPUClass
> by marking the CPUState pointer const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/core/cpu.h     | 2 +-
>   accel/tcg/cpu-exec.c      | 2 +-
>   accel/tcg/translate-all.c | 3 +--
>   gdbstub/gdbstub.c         | 2 +-
>   4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 59d601465b4..60a23d6f38b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -480,7 +480,7 @@ struct CPUState {
>       /*< private >*/
>       DeviceState parent_obj;
>       /* cache to avoid expensive CPU_GET_CLASS */
> -    CPUClass *cc;
> +    const CPUClass *cc;
>       /*< public >*/
>   
>       int nr_threads;
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 9c754b03656..d7f91dce9db 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -460,7 +460,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
>            * counter hit zero); we must restore the guest PC to the address
>            * of the start of the TB.
>            */
> -        CPUClass *cc = cpu->cc;
> +        const CPUClass *cc = cpu->cc;
>           const TCGCPUOps *tcg_ops = cc->tcg_ops;
>   
>           if (tcg_ops->synchronize_from_tb) {
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 3f1a3a28438..328d96aba30 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -575,7 +575,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
>   void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>   {
>       TranslationBlock *tb;
> -    CPUClass *cc;
> +    const CPUClass *cc = cpu->cc;
>       uint32_t n;
>   
>       tb = tcg_tb_lookup(retaddr);
> @@ -591,7 +591,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>        * to account for the re-execution of the branch.
>        */
>       n = 1;
> -    cc = cpu->cc;
>       if (cc->tcg_ops->io_recompile_replay_branch &&
>           cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
>           cpu->neg.icount_decr.u16.low++;
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index c3c944e965b..26366acb674 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -578,7 +578,7 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
>   
>   static const char *gdb_get_core_xml_file(CPUState *cpu)
>   {
> -    CPUClass *cc = cpu->cc;
> +    const CPUClass *cc = cpu->cc;
>   
>       /*
>        * The CPU class can provide the XML filename via a method,


