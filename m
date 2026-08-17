Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676ABC5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvosf-0005kb-6Y; Mon, 17 Aug 2026 00:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvosS-0005kG-MM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:23:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvosQ-0002Hn-Nt
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:23:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCJgo3656906
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dwRzrqmHWmcdgnzPzG6c0CcJgrAnUaqSWsIMaHAj4j8=; b=I5z5cHHk/y9cF/VK
 WYjxUgLVqF6CHKSfon6L7QYwc+w9s1BXHomIsV6iBgIPN43KXs0eqorDMpYjluD0
 7BVosfaqWOo9d8E9M2MKcPUBLG/HjGVKbe0ds3o5uL0i6k/UR/daYtHBF95KW+2r
 UPhtKyRKyGJmfBNuU1bOy98a7LmnwiRTOwX/omexZBvKrDn6yCDjjJViwqUXK2xE
 PUsuZ6Tk6+vuIXmagjRo8SCE7cxnEIfVVPRoy22W3fGKBJWOGn2NDqTvt/HQj+t/
 WWXtVbh991izhqljuP0AjVywf0t9iDVaEge5B+BTja2bBjGXlYDyoPXUdEQGg5ZT
 VDWLWQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gn1s6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:23:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so57415901cf.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786940587; x=1787545387; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dwRzrqmHWmcdgnzPzG6c0CcJgrAnUaqSWsIMaHAj4j8=;
 b=f8VEjnD5FizEHg9iegYTYiYVCJXDq7BTSBGeywaQ8pjywBNmK6wjVRt9TxvRyrUQFx
 am/kEF3aakBlXyhAk6J30qUYuayBRqnFWqdyzKs7GVpc1rCMF+vwwYnY1GQzSdAQxJx6
 VN3rN01ydYOppM99R2xSShB7k5bceErOecFPtvcGB4PUHcTQ3nQ3i+ZxjrXCXw01luoj
 ZMhcy0xQV3Nvpm3yY2BbChT18nG0cSXY2bVvg98Z65Qq76ja4czfWaFRnW4f+bgsfmeg
 Ag7q3zeC2GCOuKuNnp+gwZHpfo/BwAOKsp36KZlP0M4EDXtaW7orYccWF30iNNvR55mC
 qx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786940587; x=1787545387;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dwRzrqmHWmcdgnzPzG6c0CcJgrAnUaqSWsIMaHAj4j8=;
 b=nUsWHI6PmUsWu32Op8YL64zzERy3ERYnJlytjRYX/rtDWyfgGvUsFUtL8wmxEHpQCH
 zfYPW2VaP5PuZMiZIyr/Tgdxq1nb7JP9EnR7y+YHAWQqj9y5GZCNgoj8/Am10cA0LTAz
 LeH5asoZWF8oFj+h8TA+ZM/rq2EuErgQSyy7aLSyTC+FVlhFL1jwa/E/aKT2MQhalkE3
 dZmy8TSbsEK9Ke8nKm437VqL5MlK8qDu6rB6tGTDGSCnKgRDO7cjioqLodz/QOST4IV4
 X2thh+Kr78aZanDBMP+Z+/awYcNlIUkptLxP1Y3k7q89jPKEyhXWqj6P2z6JMmP1Ri2S
 cRhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RprdIhdUifRXsVr4NHAZ9vU+Xkawp6lHNmkYIYrtfX9tjHxAddslCNT58hLSb0ZUz1Sru91egWBXypN@nongnu.org
X-Gm-Message-State: AOJu0YxTnifwgCQumd7855FoaDcPuplatdzu5mFk7apg/cxVJPxB/fse
 cTs6JM3oBluFCM5PdHec77VD3f2AHOBrIr/Cd6MARVZ4iSkCc0ANcMC6KHaMHNZ0Q8bJJR6/d5H
 yIl0E7k4CLE5q37V6/4FzjABQ9oM/IrwjiCAzhh0840QA7jMBPS5nKqvfXg==
X-Gm-Gg: AR+sD132ZBPNL4s/x33RdCinOLD71jZLdx1lv+6wc0wREd516G/ZxWVA7s9TuCgryNS
 ghY5IyNYnvxXa/H5UJp/6eCb/ZQeVxn6GWbyIhlwQ34hznDaFcrHJYitfk5w3eiHYzoJytcL/lk
 dRpMZaTrnwwx81q+rGrqRDSW/7PsgQJLlDTBVVlASugJRn2jaUzV75I8lOVhuiPTp0xLd21kzSE
 lFEoT1Hz/GQgSmmlKcYhUmF1mdpoZ7H2dH5nfSkQCIPsHcVDMUv3yAZvkNmfiFAjy9Bx9hcp3Gs
 vCLSvkcyRYI57r2xrJ9dZSY/mUFKISc7+60gFY76ga5u6FyYt1x6IkxUrFq/YfdfHgg/4dG30Sk
 Eeilk9tj60+l6/rIJAjx1lq1PqCL2QTaoQZ0=
X-Received: by 2002:ac8:5855:0:b0:51a:6feb:dc8f with SMTP id
 d75a77b69052e-52d8530da31mr236972711cf.9.1786940587345; 
 Sun, 16 Aug 2026 21:23:07 -0700 (PDT)
X-Received: by 2002:ac8:5855:0:b0:51a:6feb:dc8f with SMTP id
 d75a77b69052e-52d8530da31mr236972471cf.9.1786940586916; 
 Sun, 16 Aug 2026 21:23:06 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b572sm515560f8f.13.2026.08.16.21.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:23:05 -0700 (PDT)
Message-ID: <bfe5d191-734a-43e2-9c2e-96196c4e2aa8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] target/hexagon: add semihosting support
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
 <0c46c3d9cf8215dc9249a8a583bad3eacad47639.1784568922.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <0c46c3d9cf8215dc9249a8a583bad3eacad47639.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DYWiMZfo4dPKHvGW1_bQxBExDFqKVtpa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMCBTYWx0ZWRfXzluHdWVi9G+7
 krX5fQ0px895sdbb4aWGQa9OPNqdtxIjDh89jOPGHTPOAqHhj9xuSy9D9tKqFPij5DBNs25m5FN
 szLVDE8APG5ALZ1CBcBRngYi1xt+96Y=
X-Proofpoint-GUID: DYWiMZfo4dPKHvGW1_bQxBExDFqKVtpa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMCBTYWx0ZWRfX0Th70RQT7fX+
 JXz2FkPgy78Kp60n/1OfS6jNliMjcwFnytjgge/+x2Mf2iNlebISVDLrU1y1E8d5wlOgfAYqHsa
 C/xDHkjxyhYADiqBzS6VrmEah06Cq/k3IzUCdA97hpPw5zNXREzRr1jV8r4Fvn9M46WFtQ60Dul
 R2Z+JZV8bzctdmvW9HrV4oQsYwVUoXs56KJWAp12C4/H8buXHtMP54xo3pMbWbd6U3fJpdYKlFH
 dskGSGDKbEKZhp9eY0QarHdlDqFyzE+3DR+bVPlW5RjOUgH7zn2C9ZxwgelkA1unBuzqutdGypI
 z9HlsGm0QckBRL8VwvzRK7ljXyMVWLwcAFEZbnZ08OpTuJwKJ/V942N5/SgSyOKzsyYsm2t0LhL
 XMkqDy9g5FVvDMD8/rJeXQd3iEB8qRemXHpx7gcXsuLrVVuUZJoz6fo062RWcT8+uddV+0buuB1
 IKN328cmHR1Jyf2Z3rg==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a828cac cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VKHMEzHhSxK4k6l3i1YA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170030
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Matheus,

On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> Baremetal Hexagon programs use trap0 #0 to invoke
> semihosting calls for I/O and process control.  Wire up the
> arm-compatible semihosting framework for softmmu by enabling
> CONFIG_ARM_COMPATIBLE_SEMIHOSTING and routing trap0 to the
> semihosting handler.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   docs/system/target-hexagon.rst      |   8 +-
>   configs/targets/hexagon-softmmu.mak |   2 +
>   hw/hexagon/hexagon_dsp.c            |   2 +
>   target/hexagon/common-semi-target.c |  51 +++++++++
>   target/hexagon/hexswi.c             | 167 +++++++++++++++++++++++++++-
>   hw/hexagon/Kconfig                  |   1 +
>   qemu-options.hx                     |   8 +-
>   target/hexagon/meson.build          |   3 +
>   8 files changed, 232 insertions(+), 10 deletions(-)
>   create mode 100644 target/hexagon/common-semi-target.c


> +static void sim_handle_trap0(CPUHexagonState *env)
> +{
> +    target_ulong what_swi, swi_info;
> +    CPUState *cs = env_cpu(env);
> +
> +    g_assert(bql_locked());
> +    init_semihosting_guestfds();
> +
> +    what_swi = arch_get_thread_reg(env, HEX_REG_R00);
> +    swi_info = arch_get_thread_reg(env, HEX_REG_R01);
> +
> +    qemu_log_mask(CPU_LOG_INT,
> +                  "sim_handle_trap0: swi=0x%" PRIx32
> +                  " info=0x%" PRIx32 " PC=0x%" PRIx32
> +                  " thread=%" PRId32 "\n",
> +                  (uint32_t)what_swi, (uint32_t)swi_info,
> +                  (uint32_t)arch_get_thread_reg(env, HEX_REG_PC),
> +                  (uint32_t)env->threadId);
> +
> +    if (!is_hexagon_specific_swi_flag(what_swi)) {
> +        if (what_swi == HEX_SYS_READ || what_swi == HEX_SYS_READC ||
> +            what_swi == HEX_SYS_WRITE) {
> +            /*
> +             * Avoid page faults if the buffer is not in memory yet.
> +             * NOTE: Counterintuitive, but a WRITE must be able to LOAD from
> +             * the input address. The contents of that buffer will be
> +             * directed to the SWI interface.
> +             */
> +            do_preload(env, swi_info, (what_swi == HEX_SYS_WRITE));
> +        }
> +        /*
> +         * ARM-compat semihosting SWI numbers are all <= 0x31.
> +         * If R0 holds a value outside that range (e.g. guest code
> +         * executing trap0(#0) with an arbitrary R0), treat it as an
> +         * unrecognized request rather than forwarding to
> +         * do_common_semihosting() which would abort.
> +         */
> +        if (what_swi > 0x31) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "trap0(#0): unrecognized request in r0: "
> +                          "0x" TARGET_FMT_lx "\n", what_swi);
> +            return;
> +        }
> +        do_common_semihosting(cs);
> +        return;
> +    }
> +
> +    switch (what_swi) {
> +
> +    case HEX_SYS_EXCEPTION:
> +    {
> +        uint32_t ret = arch_get_thread_reg(env, HEX_REG_R02);
> +        arch_set_system_reg(env, HEX_SREG_MODECTL, 0);
> +        gdb_exit(ret);
> +        exit(ret);
> +    }
> +    break;
> +
> +    /* TODO: implement other hexagon-specific semihosting calls */
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,

LOG_UNIMP

> +                      "unknown swi request: 0x%" PRIx32 "\n",
> +                      (uint32_t)what_swi);
> +        common_semi_cb(cs, -1, ENOSYS);
> +    }
> +}
> +
>   static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
>                             uint32_t exception_index)
> -
>   {
>       HexagonCPU *cpu = env_archcpu(env);
>       uint32_t evb = cpu->globalregs ?
> @@ -95,8 +257,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
>       switch (cs->exception_index) {
>       case HEX_EVENT_TRAP0:
>           if (env->cause_code == 0) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "trap0 is unhandled, no semihosting available\n");
> +            sim_handle_trap0(env);
>           }
>   
>           hexagon_ssr_set_cause(env, env->cause_code);
> diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> index 52065ab3b22..3a8ff17812b 100644
> --- a/hw/hexagon/Kconfig
> +++ b/hw/hexagon/Kconfig
> @@ -2,6 +2,7 @@ config HEX_DSP
>       bool
>       default y
>       depends on HEXAGON
> +    select ARM_COMPATIBLE_SEMIHOSTING

Here we select explicitly ...

>   
>   config HEX_VIRT
>       bool


> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 59cb09c1070..69f01bd2f70 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -262,6 +262,9 @@ hexagon_softmmu_ss.add(files(
>       'machine.c',
>   ))
>   
> +hexagon_softmmu_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
> +                       if_true: files('common-semi-target.c'))

... so optionally including this file is odd. If we still want it
optional, then we need stubs for symbols with external linkage.

