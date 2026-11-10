Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0B606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h7IAdyHB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SpUF6O6N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQrGN-0005Xr-FV; Tue, 10 Nov 2026 14:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQrGJ-0005W8-RI
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 14:12:07 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQrGG-0007iF-Sr
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 14:12:07 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAJC3KP708805
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 19:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 266sQg9DwF6EKhuofx+571ODkyk4mp2cecLrNxfP7Us=; b=h7IAdyHBqk9ccu1x
 gAFZPJXXtaJXSBSSonvz3JuswnoZpeIiGMHacNDEKPsUF9wxb99DPs3N0C2rFGNC
 ebz81a9sUz/LnxqJZpZyiln1KDkmcYPKAGIopkWv0xVcdm3gT4ytet83tfxHvwBM
 iOJYnayyy+zcjE9wQ6GUnJWLKhOwpVF0919kDrCzP2dmEBz5qbbhW3kgMBBwG9R3
 kddb3nfD39qwW9U8UYFz6d3n85xfn3gep8nNVYHBzDPBVIL8EPuPe0BQaVjQII5B
 k2QXSUZqSkXtSfXCgxuq0ppLz1L9xgDHFHC6zfo/GEXczu3rOZBZ3mzwMCGBnubb
 bU+IPg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97c801b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 19:12:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5363b06bcb2so50576931cf.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794337922; x=1794942722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=266sQg9DwF6EKhuofx+571ODkyk4mp2cecLrNxfP7Us=;
 b=SpUF6O6NRugzt/MCz5UIMPe7Aac2CJuAL8wiVGmP4MMRLllaby6VddfcTvgq6N4OOR
 Gm6jU7+N91y73Ju+NQ6/l04ZM3Rmv/mA3mIZLfJWji62H1UIjYHFj2phTgQ8MqjXAfOu
 BWhOZSPAZKTxpcgryfLrLZ2qvCKBindgmoAjfhMYyaUoOKD+hh2S4invT5iVmJ5Nz+ET
 kml5l36djClZNTtD42EP7l6JGzkFYTwtiGUm+dKV79QaLl3UJYcTmJ3QZb83OkCb6rJk
 95/EveAj+lqjO4aEOtcZmwttWG+TsIXe1jBC2mt+PMfBrNBFFLVd/9N328rGWHBC3qYn
 evOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794337922; x=1794942722;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=266sQg9DwF6EKhuofx+571ODkyk4mp2cecLrNxfP7Us=;
 b=kv4BvS/vD81le/mdJZHlhTbUKh7icWSY8pkOeuMeAno5wa2RdkZNpzM+FHCM4Otanx
 8FjhgqszXiRC8UFQetwGxFfJCYWhayY39+PC0HUuiwCf5h6AaPcAT+Y1tPDZRFQT2Jk3
 cvSekT/5LWfOq0ZIxSwXDJyLVu3i2LSVZa4ykOCzeYrksViwbBQtXU+gpLP4yvc1UGeB
 p6Um5h6m9moRKY2PJWHiMxwF+1GruzR5ud7MjZt/Mk7JcOxiqXmUqBTVSoNVFbmLDDF9
 jgUM/T6eRWBNqinUcyPw0KuYKTeoyB72gWmcxCHfZ/V5RR2J38h59RkNwlRVl4rH8PPK
 bGKA==
X-Forwarded-Encrypted: i=1;
 AL+hErHAQ9c+Th74Mn9fWVFisd5JzdEWNA8fW1CTMEFerktef019Y3d5VIHK9G4Vj3iEVI/eLzVkVXmL3aEH@nongnu.org
X-Gm-Message-State: APuU4Z/svPkFHjf4l8lc054JbYPLwTSWOqMM7KxfoaxqLCbBagc78TYp
 HNj1aqhCCw5VFeoz1RHnhrmDqfU7ekCrazb7pvGxyyxV82bGyHbVV/gJCMxtDdESwah02Y+o0dJ
 ryU1VmqQVQfNihdsrtCDuH0911/qr7Xz0ngYXRZv5Wlwrr6o0vw8RRCR6xg==
X-Gm-Gg: AYBFou0F6CHhkJIsuQeU8sw2AdShThDajGGfTm64W+C//yt3R+wWHtpH3XA/8hELZKN
 mK9+ZryLkMlv3p0aVpNn9+2hchEbeKt+qGLi8qZcBZ/HsSwXgMO/i9tw7qnV8ReOx5iHBasAaT0
 XKcp4631ey8RNgEEdAslec/9nzgnRGmfEwCW1cBscIAMZ8vd5Bk5jz+6yZ1lGboV63IOIXK5E5R
 n7LWcUh/2ywUMbveTQ3N5I4ZI3nR4NCgmKc8xe2fTNbi1afCWKEVDq4lDUPJPn0IlHS9PeSbJPI
 ZSy/9HxBuVq0wJnTRsAq11hp8AyaQOvoNnZdE3Whb9Ow+YonwFVyhudB5jRsplGvQae0EUyS9UY
 GPEEjt19h7vgG3f4vvbZT50tN8RtkzQM0e8JW68MYv7Bt5EsxatYf+c8J9n2JAPYXkf8ofCKUqZ
 TU9Ihh2oyCzA==
X-Received: by 2002:ac8:5e06:0:b0:535:84ec:baaf with SMTP id
 d75a77b69052e-5552a35eebamr54625001cf.43.1794337922365; 
 Tue, 10 Nov 2026 11:12:02 -0800 (PST)
X-Received: by 2002:ac8:5e06:0:b0:535:84ec:baaf with SMTP id
 d75a77b69052e-5552a35eebamr54624221cf.43.1794337921485; 
 Tue, 10 Nov 2026 11:12:01 -0800 (PST)
Received: from [192.168.68.105] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04ab626sm28513346d6.15.2026.11.10.11.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 11:12:00 -0800 (PST)
Message-ID: <d76ec165-fb11-4e63-8e20-a8ee5062701d@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 16:11:57 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix icount trigger exception PC
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20261108110107.1752051-1-himanshu.chauhan@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261108110107.1752051-1-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3NiBTYWx0ZWRfXwuQsXbT98TYX
 S1VhqZwFHf8GVxLIpBjIwvHChaeUQQDcWgSk/d51+73QFGR/twIvM684pDZX19GuFv08v/bYbgZ
 aZtYXzTzy7iMpm5hmFQwRcnweXUb2JCGMK9fhKU2LLjXEwZvNzQobES+YfLtEGcaOG/beSQJIRU
 lhwGQLu1/Gk/gUi1Dmn/JRWjHdX9bcM23CmIxXRiSQ3/B52qRaALOvvUhcU4x12aZ19ixkaRF6N
 AOlTm3HDxf7Wx+3l7n0fGjuqCZ1yO83O77FP15wve6nx4ckfhRCPFswmNC4q+KwheF056OVl5UQ
 O2+BeIGljdZyCYNo8kSIWBVSnM78qWWdmRnENhBo2VnIwpN3K5RGFPPAaQRzhQF1AP45wEUKMw5
 Xbch8M906Byanyg8jgdNLdgqB6sm9Q==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af36c83 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=8OJyc8wFlYHFoqYmSOsA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 68cXri-1BRrb014Q3ado43LOsPDAmbqa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3NiBTYWx0ZWRfXwlurhgFxUx27
 zbHV1UuFRLxfoYI1eAfxyIyVhXFEd66moLq/QbEz1MhHenVKBV9+cJcYbizaf9DAnGrkFIyCEt7
 qY6hLlY7aAhf/lMMU8g6StBnblbjMPk=
X-Proofpoint-GUID: 68cXri-1BRrb014Q3ado43LOsPDAmbqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611100076
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



On 11/8/2026 8:01 AM, Himanshu Chauhan wrote:
> Per the Sdtrig specification, on a breakpoint exception with icount, the
> xepc must contain the virtual address of the next instruction that must
> be executed to preserve the program flow.
> 
> Since SBI DBTR exposes these trigger encodings to supervisor software, an
> icount trigger used as a one-instruction step must fire only after the
> counted instruction retires and the architectural successor PC is known,
> which for a taken branch is the branch target, not the trigger install
> address or fallthrough.
> 
> QEMU previously disabled the translated-block trigger flag when icount was
> enabled and relied on timer and privilege-change callbacks to update the
> count, so the trigger could fire outside instruction retirement before the
> guest PC advanced, causing Linux to observe the old PC and re-enter the same
> breakpoint while single-stepping with icount.
> 
> Fix this by
>    - publishing the icount trigger flag in translated blocks even with
>      icount enabled
>    - making the helper decrement the trigger count after the
>      instruction has committed its successor PC and raise the trigger
>      action only then
>    - privilege-change callbacks refresh cached enabled state because itriggers
>      tied to privilege mode.
> 
> Also make trigger data CSR availability depend on an implemented trigger slot
> rather than the currently selected trigger type, so software can disable a
> trigger with type zero and still write the rest of the slot state before
> selecting another supported type.
> 
> itrigger timers are completely removed as they are not required now.
> 
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---


LGTM.  I took a look at other instances of itrigger_enabled and seems like we're
missing one instance in this patch:

target/riscv/machine.c, debug_post_load():

      RISCVCPU *cpu = opaque;
      CPURISCVState *env = &cpu->env;

     if (icount_enabled()) {
         env->itrigger_enabled = riscv_itrigger_enabled(env);
     }


Since itrigger_enabled is no longer reliant on icount_enabled() we need to
remove the icount_enabled() from machine.c too.


Thanks,
Daniel

>   target/riscv/cpu.h            |   5 +-
>   target/riscv/tcg/cpu_helper.c |  10 +-
>   target/riscv/tcg/debug.c      | 169 ++++++++++------------------------
>   target/riscv/tcg/tcg-cpu.c    |   7 +-
>   4 files changed, 59 insertions(+), 132 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 49a1186bdb..3109d71470 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -484,8 +484,7 @@ struct CPUArchState {
>       uint8_t trigger_cur;
>       /*
>        * num_triggers is the length of tdata1, tdata2, tdata3,
> -     * cpu_breakpoint, cpu_watchpoint and itrigger_timer
> -     * arrays.
> +     * cpu_breakpoint and cpu_watchpoint arrays.
>        */
>       uint32_t num_triggers;
>       uint64_t *tdata1;
> @@ -493,8 +492,6 @@ struct CPUArchState {
>       uint64_t *tdata3;
>       struct CPUBreakpoint **cpu_breakpoint;
>       struct CPUWatchpoint **cpu_watchpoint;
> -    QEMUTimer **itrigger_timer;
> -    int64_t last_icount;
>       bool itrigger_enabled;
>   
>       /* machine specific rdtime callback */
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 58e98e975c..0375b930be 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -940,10 +940,6 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
>       g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>   
>       if (newpriv != env->priv || env->virt_enabled != virt_en) {
> -        if (icount_enabled()) {
> -            riscv_itrigger_update_priv(env);
> -        }
> -
>           riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
>       }
>   
> @@ -982,6 +978,12 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
>               riscv_cpu_interrupt(env);
>           }
>       }
> +
> +    /*
> +     * Icount triggers are scoped by U/S/M and VU/VS mode bits.  Refresh the
> +     * cached translated-block flag after privilege or virtualization changes.
> +     */
> +    riscv_itrigger_update_priv(env);
>   }
>   
>   /*
> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> index 8b58cbd07a..2c9c251643 100644
> --- a/target/riscv/tcg/debug.c
> +++ b/target/riscv/tcg/debug.c
> @@ -32,8 +32,6 @@
>   #include "trace.h"
>   #include "exec/helper-proto.h"
>   #include "exec/watchpoint.h"
> -#include "system/cpu-timers.h"
> -#include "exec/icount.h"
>   #include "accel/tcg/cpu-loop.h"
>   
>   /*
> @@ -53,20 +51,6 @@
>    *     1 |    2 |         tdata1, tdata2 | Address / Data Match
>    */
>   
> -/* tdata availability of a trigger */
> -typedef bool tdata_avail[TDATA_NUM];
> -
> -static tdata_avail tdata_mapping[TRIGGER_TYPE_NUM] = {
> -    [TRIGGER_TYPE_NO_EXIST] = { false, false, false },
> -    [TRIGGER_TYPE_AD_MATCH] = { true, true, true },
> -    [TRIGGER_TYPE_INST_CNT] = { true, false, true },
> -    [TRIGGER_TYPE_INT] = { true, true, true },
> -    [TRIGGER_TYPE_EXCP] = { true, true, true },
> -    [TRIGGER_TYPE_AD_MATCH6] = { true, true, true },
> -    [TRIGGER_TYPE_EXT_SRC] = { true, false, false },
> -    [TRIGGER_TYPE_UNAVAIL] = { true, true, true }
> -};
> -
>   /* only breakpoint size 1/2/4/8 supported */
>   static int access_size[SIZE_NUM] = {
>       [SIZE_ANY] = 0,
> @@ -165,13 +149,17 @@ static inline target_ulong build_tdata1(CPURISCVState *env,
>   
>   bool tdata_available(CPURISCVState *env, int tdata_index)
>   {
> -    int trigger_type = get_trigger_type(env, env->trigger_cur);
> -
>       if (unlikely(tdata_index >= TDATA_NUM)) {
>           return false;
>       }
>   
> -    return tdata_mapping[trigger_type][tdata_index];
> +    /*
> +     * tdata CSRs belong to the trigger slot, not to the currently selected
> +     * trigger type.  A type-zero trigger is disabled, but the slot still
> +     * exists, so software must still be able to write tdata2/tdata3 before
> +     * selecting a supported trigger type.
> +     */
> +    return env->trigger_cur < env->num_triggers;
>   }
>   
>   target_ulong tselect_csr_read(CPURISCVState *env)
> @@ -729,6 +717,30 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
>       }
>   }
>   
> +static void no_trigger_reg_write(CPURISCVState *env, target_ulong index,
> +                                 int tdata_index, target_ulong val)
> +{
> +    /*
> +     * OpenSBI programs DBTR slots by first writing type zero to tdata1, then
> +     * writing tdata2/tdata3, and finally writing the desired trigger type.
> +     */
> +    switch (tdata_index) {
> +    case TDATA1:
> +        type2_breakpoint_remove(env, index);
> +        env->tdata1[index] = 0;
> +        env->itrigger_enabled = riscv_itrigger_enabled(env);
> +        break;
> +    case TDATA2:
> +        env->tdata2[index] = val;
> +        break;
> +    case TDATA3:
> +        env->tdata3[index] = textra_validate(env, val);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>   /* icount trigger type */
>   static inline int
>   itrigger_get_count(CPURISCVState *env, int index)
> @@ -754,21 +766,6 @@ itrigger_set_pending(CPURISCVState *env, int index, int val)
>                                      ITRIGGER_PENDING, val);
>   }
>   
> -static bool check_itrigger_priv(CPURISCVState *env, int index)
> -{
> -    target_ulong tdata1 = env->tdata1[index];
> -    if (env->virt_enabled) {
> -        /* check VU/VS bit against current privilege level */
> -        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_VU) == env->priv);
> -    } else {
> -        /* check U/S/M bit against current privilege level */
> -        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_U) == env->priv);
> -    }
> -}
> -
>   bool riscv_itrigger_enabled(CPURISCVState *env)
>   {
>       int count;
> @@ -776,7 +773,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
>           if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
>               continue;
>           }
> -        if (check_itrigger_priv(env, i)) {
> +        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
>               continue;
>           }
>           count = itrigger_get_count(env, i);
> @@ -803,7 +800,12 @@ void HELPER(itrigger_match)(CPURISCVState *env)
>           if (!count) {
>               continue;
>           }
> -        itrigger_set_count(env, i, count--);
> +        /*
> +         * This helper is emitted at TB exit after one guest instruction and
> +         * after the translator has committed env->pc to the successor PC.
> +         */
> +        count--;
> +        itrigger_set_count(env, i, count);
>           if (!count) {
>               /*
>                * From the 1.0 spec: "When pending is set, the trigger
> @@ -822,61 +824,21 @@ void HELPER(itrigger_match)(CPURISCVState *env)
>               itrigger_set_pending(env, i, 1);
>   
>               env->itrigger_enabled = riscv_itrigger_enabled(env);
> -            do_trigger_action(env, i);
>               itrigger_set_pending(env, i, 0);
> +            do_trigger_action(env, i);
>           }
>       }
>   }
>   
>   static void riscv_itrigger_update_count(CPURISCVState *env)
>   {
> -    int count, executed;
>       /*
> -     * Record last icount, so that we can evaluate the executed instructions
> -     * since last privilege mode change or timer expire.
> +     * Icount triggers are matched from translated code after an instruction
> +     * has committed its successor PC.  Timer and privilege-change callbacks
> +     * therefore must not decrement count or fire the action here; they only
> +     * refresh the cached TB flag state.
>        */
> -    int64_t last_icount = env->last_icount, current_icount;
> -    current_icount = env->last_icount = icount_get_raw();
> -
> -    for (int i = 0; i < env->num_triggers; i++) {
> -        if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
> -            continue;
> -        }
> -        count = itrigger_get_count(env, i);
> -        if (!count) {
> -            continue;
> -        }
> -        /*
> -         * Only when privilege is changed or itrigger timer expires,
> -         * the count field in itrigger tdata1 register is updated.
> -         * And the count field in itrigger only contains remaining value.
> -         */
> -        if (check_itrigger_priv(env, i)) {
> -            /*
> -             * If itrigger enabled in this privilege mode, the number of
> -             * executed instructions since last privilege change
> -             * should be reduced from current itrigger count.
> -             */
> -            executed = current_icount - last_icount;
> -            itrigger_set_count(env, i, count - executed);
> -            if (count == executed) {
> -                do_trigger_action(env, i);
> -            }
> -        } else {
> -            /*
> -             * If itrigger is not enabled in this privilege mode,
> -             * the number of executed instructions will be discard and
> -             * the count field in itrigger will not change.
> -             */
> -            timer_mod(env->itrigger_timer[i],
> -                      current_icount + count);
> -        }
> -    }
> -}
> -
> -static void riscv_itrigger_timer_cb(void *opaque)
> -{
> -    riscv_itrigger_update_count((CPURISCVState *)opaque);
> +    env->itrigger_enabled = riscv_itrigger_enabled(env);
>   }
>   
>   void riscv_itrigger_update_priv(CPURISCVState *env)
> @@ -911,18 +873,10 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
>   
>       switch (tdata_index) {
>       case TDATA1:
> -        /* set timer for icount */
>           new_val = itrigger_validate(env, val);
>           if (new_val != env->tdata1[index]) {
>               env->tdata1[index] = new_val;
> -            if (icount_enabled()) {
> -                env->last_icount = icount_get_raw();
> -                /* set the count to timer */
> -                timer_mod(env->itrigger_timer[index],
> -                          env->last_icount + itrigger_get_count(env, index));
> -            } else {
> -                env->itrigger_enabled = riscv_itrigger_enabled(env);
> -            }
> +            env->itrigger_enabled = riscv_itrigger_enabled(env);
>           }
>           break;
>       case TDATA2:
> @@ -937,27 +891,10 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
>       }
>   }
>   
> -static int itrigger_get_adjust_count(CPURISCVState *env)
> -{
> -    int count = itrigger_get_count(env, env->trigger_cur), executed;
> -    if ((count != 0) && check_itrigger_priv(env, env->trigger_cur)) {
> -        executed = icount_get_raw() - env->last_icount;
> -        count += executed;
> -    }
> -    return count;
> -}
> -
>   target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
>   {
> -    int trigger_type;
>       switch (tdata_index) {
>       case TDATA1:
> -        trigger_type = extract_trigger_type(env,
> -                                            env->tdata1[env->trigger_cur]);
> -        if ((trigger_type == TRIGGER_TYPE_INST_CNT) && icount_enabled()) {
> -            return deposit64(env->tdata1[env->trigger_cur], 10, 14,
> -                             itrigger_get_adjust_count(env));
> -        }
>           return env->tdata1[env->trigger_cur];
>       case TDATA2:
>           return env->tdata2[env->trigger_cur];
> @@ -995,6 +932,8 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>                         trigger_type);
>           break;
>       case TRIGGER_TYPE_NO_EXIST:
> +        no_trigger_reg_write(env, env->trigger_cur, tdata_index, val);
> +        break;
>       case TRIGGER_TYPE_UNAVAIL:
>           qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
>                         trigger_type);
> @@ -1147,8 +1086,6 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>   
>   void riscv_trigger_realize(CPURISCVState *env)
>   {
> -    int i;
> -
>       if (env->num_triggers > RV_MAX_TRIGGERS) {
>           error_report(
>                   "Invalid configuration: 'num-triggers' must be less than %u",
> @@ -1161,12 +1098,6 @@ void riscv_trigger_realize(CPURISCVState *env)
>       env->tdata3 = g_new0(uint64_t, env->num_triggers);
>       env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
>       env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
> -    env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
> -
> -    for (i = 0; i < env->num_triggers; i++) {
> -        env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                              riscv_itrigger_timer_cb, env);
> -    }
>   }
>   
>   void riscv_trigger_unrealize(CPURISCVState *env)
> @@ -1177,11 +1108,6 @@ void riscv_trigger_unrealize(CPURISCVState *env)
>   
>       g_free(env->cpu_breakpoint);
>       g_free(env->cpu_watchpoint);
> -
> -    for (int i = 0; i < env->num_triggers; i++) {
> -        timer_free(env->itrigger_timer[i]);
> -    }
> -    g_free(env->itrigger_timer);
>   }
>   
>   void riscv_trigger_reset_hold(CPURISCVState *env)
> @@ -1209,7 +1135,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>           env->tdata3[i] = 0;
>           env->cpu_breakpoint[i] = NULL;
>           env->cpu_watchpoint[i] = NULL;
> -        timer_del(env->itrigger_timer[i]);
>       }
>   
>       env->mcontext = 0;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5834ec1524..027fe5b46a 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -181,8 +181,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>                ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>       }
>   
> -    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
> -        && !icount_enabled()) {
> +    /*
> +     * Publish itrigger state even when QEMU icount is enabled.  The helper
> +     * runs from translated code after committing the guest successor PC.
> +     */
> +    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>           flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
>       }
>   #endif


