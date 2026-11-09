Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06285606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lIKASOSp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=euHBAK4T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQYEL-0007T9-OU; Mon, 09 Nov 2026 17:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQYEH-0007Ri-C0
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:52:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQYEE-0005gE-5d
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:52:45 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9L9uvN435362
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 22:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 81T7cZtqfhsjZQtnn9zsXo2jR7505wrsxZRG4PREx24=; b=lIKASOSpdiHiSDGs
 NBWBo3klEVw2ettFQB5lnxnp/jQYSUKO/lJmXe26DNGQGEZhA6BG9P5hN/m+niC2
 h2CapVH5o8Mrgf5Ir0yjECYvDWCXL32hygpl8AAt7tkEkx1FHxwFmHnOF9YEfTdh
 uyKKAq6Tav1TbprokyMxyIf9gVL03Xf1C6uXDiulCEiy/UDsDcKuGIOJYKhRevVC
 M7nBxUdK2jdWuYKdKwdwkXJnMGrAZwih79RSOwMV+XuC4oLTt6UowRz/WDdxzUTG
 xTcwLUdhLUduTNyV2FtQoVFR+BVMojKlXTWP0VWYnEGP41v0qNsny1q7ir06iAXz
 9OhB3w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcjac11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 22:52:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cbf2fd504so259868785a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794264758; x=1794869558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=81T7cZtqfhsjZQtnn9zsXo2jR7505wrsxZRG4PREx24=;
 b=euHBAK4TCLyEqF8QpArWYezjfFyOgcpNiLeO0cIfaP1EODqpAgEDBWcNCW28Qei2rA
 nhKGI4Io6Lx87RtxywHWH/Jy6pBx7JK2mfR1cKlx62Hi79ms5fLANHm8RmaX51sdknfN
 jkEBGrjUBpvzqBqm6HSpZhDfFQDWKO6AXGJZMHsbupkvB9zZC6DwxXYCOKCI/1Tx2UnW
 pA0j0Te4B/xCrQdR05BEE7RQtqPjh8SS3mIHSo8oGB0MxKo1ib948B8BrW3qjDKknaLe
 kOWB4o+s5vG/cdPNzYTa5j5MQzJWThSwFBMx1hyKiMMtlhNN+faSUgVAdG2NCWlwJIh7
 m9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794264758; x=1794869558;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=81T7cZtqfhsjZQtnn9zsXo2jR7505wrsxZRG4PREx24=;
 b=Dn3etErFcazOa+gD+50IXzbBTqhtGNBkT1AE67jQQtDyVGDdsX7VSDOU0YT+GvJZxi
 PmLaHMp+1p/8uYskaCNNIIUkGAxSwsQPOPOyvlxmHqpeVRIAADxfHvYbK/M0Qo9WWX6Z
 OK2bUQ6cfBUwjb05pFgKgD184OevpXoIWY+IkGVPsaFdALC1rUJkHaod0RT2koKXxrnE
 yaemAA/IYPq0tW27DZbmE5LQhX1SidAr5QUNgF3VHy4fivMj4C6zbFmaGS3m3T5uM7rT
 zMuCKl/YJLimhru++aO4FOlLMfcpFlvV9yvLdtA4eHniiAXa2pRtyTDWGIRjuuGU4AmD
 4iAw==
X-Forwarded-Encrypted: i=1;
 AL+hErHDLDtu2+Rwao/uuRuuKX8qrs+d7YKNVpako/Z8UCIY+BmEfhxWHdeTlIeiogvQFNSTS1YygZtmUiS/@nongnu.org
X-Gm-Message-State: APuU4Z9/+P5u6lIMTDpfLqbE/gub/iJfBbdDI2Z6orO9lbQSEMNyRmsC
 bBrNJ8tW1Vgl3/cuEAsWnP3LVdV97lHU7e+ZcetfMGpTZCxdrF0+OhUk2Wq5YlVeQLFRtLE74BW
 SUTsfttAo+9EcNWUcrx05oh2K+y6vwTBQ9HUpRGxeNnUGdjrYmK4HHdAAKA==
X-Gm-Gg: AYBFou2iVeOGmGDDUkIFNtg0BNI0nYI9WiQk/8oct4r07zv6l7UwnRYdS5I+Vfwx0DO
 5IqnSyzW3ew0+qURXH8zYL/yRLj6i0DJKqhL/91P2B4cuzlOv/bbeldmnTDWpvsycvCvGiHRkkf
 b7pGSji0bEVTcJutu68yf6U+uGhf1U2rP0VCmITprTMvMjIkW9QnVAbL37uqaTX5YTOqGfIxZOi
 mTvCy/LxwWJ+IANaTCUVMPmwP/YdzNYaSWtaAQbbV0newKd94C3uLGMxGSJYicbMON0Dk+Qa0Fk
 0/R8Pa8rwUsCJxu0namk/6CFGttJMme4O9svLmym2c7jjrNKldIgU6UIv0UJFKifHVnI4Q8th4J
 O9MVX3xejDcjBg7wmk7PHwb0+0hEMheGMNHolbvWv88Xoyg4us4RDkxtU3xdRkqi9Icl4DWvFVD
 6dLgvttw==
X-Received: by 2002:a05:620a:2b9c:b0:945:ad43:1d59 with SMTP id
 af79cd13be357-9479f415644mr147649585a.75.1794264757967; 
 Mon, 09 Nov 2026 14:52:37 -0800 (PST)
X-Received: by 2002:a05:620a:2b9c:b0:945:ad43:1d59 with SMTP id
 af79cd13be357-9479f415644mr147646685a.75.1794264757420; 
 Mon, 09 Nov 2026 14:52:37 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02242bd9sm15649025e9.15.2026.11.09.14.52.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 14:52:36 -0800 (PST)
Message-ID: <eeca9023-2a9d-47cc-bbbb-df53d804c893@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 23:52:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/26] target/mips: make CP0 interrupt state atomic
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
References: <20261101142723.41346-1-kirill@korins.ky>
 <20261101142723.41346-2-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261101142723.41346-2-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SrZygpyGWISK_e4MZOjCGv-zPWyL2vXK
X-Proofpoint-ORIG-GUID: SrZygpyGWISK_e4MZOjCGv-zPWyL2vXK
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af24eb7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=nqqsyrCoW0VvShOTVbMA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MSBTYWx0ZWRfX6KKTyMMxckMN
 ZMXZR1a1HvOU/ESIDIk9AtPn2JbJgH8vIfkKUcMmgy9kxUxyy1pPK/qJEX/9gGApFU3GEZOOn49
 pcE0+nOIHWF1GrizkfD5KPxXvB8j5Kk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MSBTYWx0ZWRfXzvELTmk2gWg5
 RnSNNls+C77uK+vB/cjaxKwFYY+4R3i3kWRaEH4U576TgKwkzrXOaAcVZFaKjEwTkGGUXDFPcE6
 aGgGHkHJJhvrL/3JO1IMwf+VIkVEIUd6tbPA4nGeggGJyN0kfBGcUqdP2dLs1U+Owtzq64teg8Q
 p2p0Pxw6J6Wm96ZiRxLb0nsG4q+jD4kCVqqEmiDI4KAx5j7CkW8DYtFZ9xCs7Dd+s9Ww5DYQ1Jo
 aLY0Jx5kof/2T1q6OKeGCFSiW3zHPdBXoYlEueeaOwUrfAy3yDjfXWWvSk9iBrmPjyyDlVdyG9k
 WjEp95LJD0cONQ6odMDvJksSwPRi+3F6BI7gdA4cAYtyRAlJNPGve/GtGSQbytTtjyKJCylV95A
 5nVloW1gE+NETSxwq4EUm2O3ulZifqYjzWuOmLTnSWMrsxzXR+t28fnn5rU6ZtutksLx1EEc90l
 plNdCEKj8A/qBEUIumw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 1/11/26 15:23, Kirill A. Korinsky wrote:
> MTTCG lets interrupt inputs and timer callbacks update CP0_Cause,
> CP0_Status, and CP0_Count while a vCPU checks interrupt state.
> 
> Use qatomic accessors for CP0 fields that participate in interrupt and
> timer decisions, and kick remote CPUs explicitly after raising a hard
> interrupt; MIPS interrupt line updates no longer depend on taking the
> BQL.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   hw/mips/mips_int.c                      | 17 +++++++------
>   target/mips/internal.h                  | 13 ++++++----
>   target/mips/system/cp0.c                | 27 +++++++++++++--------
>   target/mips/system/cp0_timer.c          | 32 ++++++++++++++-----------
>   target/mips/tcg/system/special_helper.c | 17 +++++++------
>   target/mips/tcg/system/tlb_helper.c     | 21 +++++++++-------
>   6 files changed, 75 insertions(+), 52 deletions(-)
> 
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 26e7dd6d5f..537394c8fd 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -21,30 +21,33 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "qemu/main-loop.h"
>   #include "hw/core/irq.h"
>   #include "target/mips/cpu.h"
> +#include "target/mips/internal.h"
>   
>   static void cpu_mips_irq_request(void *opaque, int irq, int level)
>   {
>       MIPSCPU *cpu = opaque;
>       CPUMIPSState *env = &cpu->env;
>       CPUState *cs = CPU(cpu);
> +    int32_t irq_bit;
>   
>       if (irq < 0 || irq > 7) {
>           return;
>       }
>   
> -    BQL_LOCK_GUARD();
> -
> +    irq_bit = 1 << (irq + CP0Ca_IP);
>       if (level) {
> -        env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
> +        qatomic_or(&env->CP0_Cause, irq_bit);
>       } else {
> -        env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
> +        qatomic_and(&env->CP0_Cause, ~irq_bit);
>       }
>   
> -    if (env->CP0_Cause & CP0Ca_IP_mask) {
> -        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    if (qatomic_read(&env->CP0_Cause) & CP0Ca_IP_mask) {
> +        cpu_set_interrupt(cs, CPU_INTERRUPT_HARD);
> +        if (!qemu_cpu_is_self(cs)) {
> +            qemu_cpu_kick(cs);
> +        }
>       } else {
>           cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>       }
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index a302fc0c20..eb726bd5e3 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -8,6 +8,7 @@
>   #ifndef MIPS_INTERNAL_H
>   #define MIPS_INTERNAL_H
>   
> +#include "qemu/atomic.h"
>   #include "exec/memattrs.h"
>   #ifdef CONFIG_TCG
>   #include "tcg/tcg-internal.h"
> @@ -168,9 +169,11 @@ extern const VMStateDescription vmstate_mips_cpu;
>   
>   static inline bool cpu_mips_hw_interrupts_enabled(const CPUMIPSState *env)
>   {
> -    return (env->CP0_Status & (1 << CP0St_IE)) &&
> -        !(env->CP0_Status & (1 << CP0St_EXL)) &&
> -        !(env->CP0_Status & (1 << CP0St_ERL)) &&
> +    int32_t status = qatomic_read(&env->CP0_Status);
> +
> +    return (status & (1 << CP0St_IE)) &&
> +        !(status & (1 << CP0St_EXL)) &&
> +        !(status & (1 << CP0St_ERL)) &&
>           !(env->hflags & MIPS_HFLAG_DM) &&
>           /*
>            * Note that the TCStatus IXMT field is initialized to zero,
> @@ -187,8 +190,8 @@ static inline bool cpu_mips_hw_interrupts_pending(const CPUMIPSState *env)
>       int32_t status;
>       bool r;
>   
> -    pending = env->CP0_Cause & CP0Ca_IP_mask;
> -    status = env->CP0_Status & CP0Ca_IP_mask;
> +    pending = qatomic_read(&env->CP0_Cause) & CP0Ca_IP_mask;
> +    status = qatomic_read(&env->CP0_Status) & CP0Ca_IP_mask;
>   
>       if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
>           /*
> diff --git a/target/mips/system/cp0.c b/target/mips/system/cp0.c
> index ff7d3db00c..6f222ad586 100644
> --- a/target/mips/system/cp0.c
> +++ b/target/mips/system/cp0.c
> @@ -22,6 +22,7 @@
>   #include "cpu.h"
>   #include "internal.h"
>   #include "exec/cputlb.h"
> +#include "qemu/atomic.h"
>   
>   /* Called for updates to CP0_Status.  */
>   void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc)
> @@ -61,7 +62,8 @@ void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc)
>   void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
>   {
>       uint32_t mask = env->CP0_Status_rw_bitmask;
> -    target_ulong old = env->CP0_Status;
> +    target_ulong old;
> +    target_ulong status;
>   
>       if (env->insn_flags & ISA_MIPS_R6) {
>           bool has_supervisor = extract32(mask, CP0St_KSU, 2) == 0x3;
> @@ -77,9 +79,11 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
>           mask &= ~(((1 << CP0St_SR) | (1 << CP0St_NMI)) & val);
>       }
>   
> -    env->CP0_Status = (old & ~mask) | (val & mask);
> +    old = qatomic_read(&env->CP0_Status);
> +    status = (old & ~mask) | (val & mask);
> +    qatomic_set(&env->CP0_Status, status);
>   #if defined(TARGET_MIPS64)
> -    if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
> +    if ((status ^ old) & (old & (7 << CP0St_UX))) {
>           /* Access to at least one of the 64-bit segments has been disabled */
>           tlb_flush(env_cpu(env));
>       }
> @@ -93,8 +97,9 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
>   
>   void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val)
>   {
> -    uint32_t mask = 0x00C00300;
> -    uint32_t old = env->CP0_Cause;
> +    int32_t mask = 0x00C00300;
> +    int32_t old;
> +    int32_t cause;
>       int i;
>   
>       if (env->insn_flags & ISA_MIPS_R2) {
> @@ -104,10 +109,12 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val)
>           mask &= ~((1 << CP0Ca_WP) & val);
>       }
>   
> -    env->CP0_Cause = (env->CP0_Cause & ~mask) | (val & mask);
> +    old = qatomic_fetch_and(&env->CP0_Cause, ~mask);
> +    qatomic_or(&env->CP0_Cause, (int32_t)(val & mask));
> +    cause = qatomic_read(&env->CP0_Cause);
>   
> -    if ((old ^ env->CP0_Cause) & (1 << CP0Ca_DC)) {
> -        if (env->CP0_Cause & (1 << CP0Ca_DC)) {
> +    if ((old ^ cause) & (1 << CP0Ca_DC)) {
> +        if (cause & (1 << CP0Ca_DC)) {
>               cpu_mips_stop_count(env);
>           } else {
>               cpu_mips_start_count(env);
> @@ -116,8 +123,8 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val)
>   
>       /* Set/reset software interrupts */
>       for (i = 0 ; i < 2 ; i++) {
> -        if ((old ^ env->CP0_Cause) & (1 << (CP0Ca_IP + i))) {
> -            cpu_mips_soft_irq(env, i, env->CP0_Cause & (1 << (CP0Ca_IP + i)));
> +        if ((old ^ cause) & (1 << (CP0Ca_IP + i))) {
> +            cpu_mips_soft_irq(env, i, cause & (1 << (CP0Ca_IP + i)));
>           }
>       }
>   }
> diff --git a/target/mips/system/cp0_timer.c b/target/mips/system/cp0_timer.c
> index 6aed5d3af2..622fee357d 100644
> --- a/target/mips/system/cp0_timer.c
> +++ b/target/mips/system/cp0_timer.c
> @@ -23,6 +23,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/core/irq.h"
>   #include "qemu/timer.h"
> +#include "qemu/atomic.h"
>   #include "internal.h"
>   
>   /* MIPS R4K timer */
> @@ -31,7 +32,7 @@ static uint32_t cpu_mips_get_count_val(CPUMIPSState *env)
>       MIPSCPU *cpu = env_archcpu(env);
>       int64_t now_ns;
>       now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    return env->CP0_Count +
> +    return qatomic_read(&env->CP0_Count) +
>               (uint32_t)clock_ns_to_ticks(cpu->count_clock, now_ns);
>   }
>   
> @@ -56,15 +57,15 @@ static void cpu_mips_timer_expire(CPUMIPSState *env)
>   {
>       cpu_mips_timer_update(env);
>       if (env->insn_flags & ISA_MIPS_R2) {
> -        env->CP0_Cause |= 1 << CP0Ca_TI;
> +        qatomic_or(&env->CP0_Cause, 1 << CP0Ca_TI);
>       }
>       qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
>   }
>   
>   uint32_t cpu_mips_get_count(CPUMIPSState *env)
>   {
> -    if (env->CP0_Cause & (1 << CP0Ca_DC)) {
> -        return env->CP0_Count;
> +    if (qatomic_read(&env->CP0_Cause) & (1 << CP0Ca_DC)) {
> +        return qatomic_read(&env->CP0_Count);
>       } else {
>           uint64_t now_ns;
>   
> @@ -86,12 +87,13 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
>        * So env->timer may be NULL, so treat timer as disabled in that case.
>        */
>       MIPSCPU *cpu = env_archcpu(env);
> -    if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer) {
> -        env->CP0_Count = count;
> +    if ((qatomic_read(&env->CP0_Cause) & (1 << CP0Ca_DC)) || !env->timer) {
> +        qatomic_set(&env->CP0_Count, count);
>       } else {
>           /* Store new count register */
> -        env->CP0_Count = count - (uint32_t)clock_ns_to_ticks(cpu->count_clock,
> -                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        qatomic_set(&env->CP0_Count,
> +                    count - (uint32_t)clock_ns_to_ticks(cpu->count_clock,
> +                            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)));
>           /* Update timer timer */
>           cpu_mips_timer_update(env);
>       }
> @@ -100,26 +102,28 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
>   void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value)
>   {
>       env->CP0_Compare = value;
> -    if (!(env->CP0_Cause & (1 << CP0Ca_DC))) {
> +    if (!(qatomic_read(&env->CP0_Cause) & (1 << CP0Ca_DC))) {
>           cpu_mips_timer_update(env);
>       }
>       if (env->insn_flags & ISA_MIPS_R2) {
> -        env->CP0_Cause &= ~(1 << CP0Ca_TI);
> +        qatomic_and(&env->CP0_Cause, ~(1 << CP0Ca_TI));
>       }
>       qemu_irq_lower(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
>   }
>   
>   void cpu_mips_start_count(CPUMIPSState *env)
>   {
> -    cpu_mips_store_count(env, env->CP0_Count);
> +    cpu_mips_store_count(env, qatomic_read(&env->CP0_Count));
>   }
>   
>   void cpu_mips_stop_count(CPUMIPSState *env)
>   {
>       /* Store the current value */
>       MIPSCPU *cpu = env_archcpu(env);
> -    env->CP0_Count += (uint32_t)clock_ns_to_ticks(cpu->count_clock,
> -                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +
> +    qatomic_add(&env->CP0_Count,
> +                (uint32_t)clock_ns_to_ticks(cpu->count_clock,
> +                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)));
>   }
>   
>   static void mips_timer_cb(void *opaque)
> @@ -128,7 +132,7 @@ static void mips_timer_cb(void *opaque)
>   
>       env = opaque;
>   
> -    if (env->CP0_Cause & (1 << CP0Ca_DC)) {
> +    if (qatomic_read(&env->CP0_Cause) & (1 << CP0Ca_DC)) {
>           return;
>       }
>   
> diff --git a/target/mips/tcg/system/special_helper.c b/target/mips/tcg/system/special_helper.c
> index cc46542806..fe3111fb54 100644
> --- a/target/mips/tcg/system/special_helper.c
> +++ b/target/mips/tcg/system/special_helper.c
> @@ -24,21 +24,22 @@
>   #include "exec/helper-proto.h"
>   #include "exec/translation-block.h"
>   #include "internal.h"
> +#include "qemu/atomic.h"
>   
>   /* Specials */
>   target_ulong HELPER(di)(CPUMIPSState *env)
>   {
> -    target_ulong t0 = env->CP0_Status;
> +    target_ulong t0 = qatomic_read(&env->CP0_Status);
>   
> -    env->CP0_Status = t0 & ~(1 << CP0St_IE);
> +    qatomic_set(&env->CP0_Status, t0 & ~(1 << CP0St_IE));
>       return t0;
>   }
>   
>   target_ulong HELPER(ei)(CPUMIPSState *env)
>   {
> -    target_ulong t0 = env->CP0_Status;
> +    target_ulong t0 = qatomic_read(&env->CP0_Status);
>   
> -    env->CP0_Status = t0 | (1 << CP0St_IE);
> +    qatomic_set(&env->CP0_Status, t0 | (1 << CP0St_IE));
>       return t0;
>   }
>   
> @@ -103,13 +104,15 @@ bool mips_io_recompile_replay_branch(CPUState *cs, const TranslationBlock *tb)
>   
>   static inline void exception_return(CPUMIPSState *env)
>   {
> +    target_ulong status = qatomic_read(&env->CP0_Status);
> +
>       debug_pre_eret(env);
> -    if (env->CP0_Status & (1 << CP0St_ERL)) {
> +    if (status & (1 << CP0St_ERL)) {
>           mips_env_set_pc(env, env->CP0_ErrorEPC);
> -        env->CP0_Status &= ~(1 << CP0St_ERL);
> +        qatomic_set(&env->CP0_Status, status & ~(1 << CP0St_ERL));
>       } else {
>           mips_env_set_pc(env, env->CP0_EPC);
> -        env->CP0_Status &= ~(1 << CP0St_EXL);
> +        qatomic_set(&env->CP0_Status, status & ~(1 << CP0St_EXL));
>       }
>       compute_hflags(env);
>       debug_post_eret(env);
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> index 0ff0c9c871..9e01c07609 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -1106,7 +1106,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
>           env->hflags &= ~(MIPS_HFLAG_KSU);
>           /* EJTAG probe trap enable is not implemented... */
>           if (!(env->CP0_Status & (1 << CP0St_EXL))) {
> -            env->CP0_Cause &= ~(1U << CP0Ca_BD);
> +            qatomic_and(&env->CP0_Cause, (int32_t)~(1U << CP0Ca_BD));
>           }
>           env->active_tc.PC = env->exception_base + 0x480;
>           set_hflags_for_handler(env);
> @@ -1134,7 +1134,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
>           env->hflags |= MIPS_HFLAG_CP0;
>           env->hflags &= ~(MIPS_HFLAG_KSU);
>           if (!(env->CP0_Status & (1 << CP0St_EXL))) {
> -            env->CP0_Cause &= ~(1U << CP0Ca_BD);
> +            qatomic_and(&env->CP0_Cause, (int32_t)~(1U << CP0Ca_BD));
>           }
>           env->active_tc.PC = env->exception_base;
>           set_hflags_for_handler(env);
> @@ -1148,7 +1148,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>                   offset = 0x200;
>               } else {
>                   uint32_t vector = 0;
> -                uint32_t pending = (env->CP0_Cause & CP0Ca_IP_mask) >> CP0Ca_IP;
> +                uint32_t pending =
> +                    (qatomic_read(&env->CP0_Cause) & CP0Ca_IP_mask) >>
> +                    CP0Ca_IP;
>   
>                   if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
>                       /*
> @@ -1246,8 +1248,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>       case EXCP_CpU:
>           cause = 11;
>           update_badinstr = 1;
> -        env->CP0_Cause = (env->CP0_Cause & ~(0x3 << CP0Ca_CE)) |
> -                         (env->error_code << CP0Ca_CE);
> +        qatomic_and(&env->CP0_Cause, (int32_t)~(0x3U << CP0Ca_CE));
> +        qatomic_or(&env->CP0_Cause,
> +                   (int32_t)(env->error_code << CP0Ca_CE));
>           goto set_EPC;
>       case EXCP_OVERFLOW:
>           cause = 12;
> @@ -1305,9 +1308,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>                   set_badinstr_registers(env);
>               }
>               if (env->hflags & MIPS_HFLAG_BMASK) {
> -                env->CP0_Cause |= (1U << CP0Ca_BD);
> +                qatomic_or(&env->CP0_Cause, (int32_t)(1U << CP0Ca_BD));
>               } else {
> -                env->CP0_Cause &= ~(1U << CP0Ca_BD);
> +                qatomic_and(&env->CP0_Cause, (int32_t)~(1U << CP0Ca_BD));

IIUC casts are not necessary because qatomic takes the raw value.

>               }
>               env->CP0_Status |= (1 << CP0St_EXL);
>               if (env->insn_flags & ISA_MIPS3) {
> @@ -1333,8 +1336,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
>   
>           env->active_tc.PC += offset;
>           set_hflags_for_handler(env);
> -        env->CP0_Cause = (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) |
> -                         (cause << CP0Ca_EC);
> +        qatomic_and(&env->CP0_Cause, (int32_t)~(0x1f << CP0Ca_EC));
> +        qatomic_or(&env->CP0_Cause, cause << CP0Ca_EC);
>           break;
>       default:
>           abort();

Missing cpu_mips_store_count() and HELPER(mtc0_count)?

Also comments in CPUMIPSState that these variables must be accessed
with qatomic.

