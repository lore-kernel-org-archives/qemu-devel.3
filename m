Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF34C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7xb-0002Lc-W5; Thu, 20 Aug 2026 14:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7xa-0002Ku-9F
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:57:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7xY-0002hQ-7n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:57:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJ8Zs3259638
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1YAqQ6A2xSCo1yTT7tbxUU+nm2UdynKQgEd5zZpfMqQ=; b=HvZ91lvqgSLxG1y8
 F8xWkMa9g3bG5TCx+Vv/TXhmdlkbXngEjFgSWs6ppp459Oc8a1G69EzjAcPyEyRN
 PBXTHmloySBu7kLhkk7gB9tM4H0cehAZFKX5jZde10W1JM7WjMwyrylGh7+NZZLW
 SREWGvXRlLonBVqNqp2/EJYT1EE+aT4jrv0pCcZFR3HoHZybM+p5hpXlbpo9e31g
 +t6nn5BIdo7oMiJj1XU7wiTbS1t27ib096j+/tw8IS61eN5KvzttOoOugXRXvSVR
 dDJ77UyBkMIRJPs6QYudKCeFBLN3205afEDlC9kDcfbdW0wCqDkaeUiHIKK8xGto
 bVJZ+g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytcad22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:57:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso2161085ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787252269; x=1787857069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1YAqQ6A2xSCo1yTT7tbxUU+nm2UdynKQgEd5zZpfMqQ=;
 b=S/8wsLrlhOUtCqo/5y226UMoIv/6mxs40wkJuksjZiCHH8p8ubWWFoMNdMaLTlvWA6
 XJ+UcL6fwRf4qGxoGBMghRbEzsSUu5LVmfxt0FhTxkmUuAa5w2g7gAROo/2JmIZ5VVM9
 N9wWjW5YCJm0bK1HZiuD9Dincisy3BuGmU39gYa4n3GCGSA2dHe/xA2bMdUG9F3BlakU
 UnzHYraRox3xx2c3ta1Mg2fqbR3gse9iTeV0BC8XKQuqRYFN6Z6L4H5yXXjIUQtNlziL
 L4ten+gnPSREOJcvfZW+dCgROcnqS7IfvmyFVyBqz6HTRrPR/FJQUwpgr8YSEX89VPfO
 wcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252269; x=1787857069;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1YAqQ6A2xSCo1yTT7tbxUU+nm2UdynKQgEd5zZpfMqQ=;
 b=eBH8G3rMzHf+u4iYqCQttLHLpDuH50eoGt5bOtTlo3DajAC6Ef2sfP3HY0+vpkk/D1
 1uuoTyLdJRHu5kaW0dasHlH/xGepa0CS1sbPGvLFVMFkRMcfba/4zoIKZG2gdpzOr3ZF
 vb8vSvgwL8cOmuF/ij05Nj7vkoCxL+HHxPmtR5u6OhXycQEnLPvPvij53wkQcXBjTehM
 uWCcPSr6AB35cfQO+nHHgbXz2HUDSt0p4wrjG6nEKeCqhwuYHTph883DxxIBujHwLLAF
 wlFrLpFYTei/2DeLATvFdfESK8xin58PIHJ2xnXInXAyYjuKxqFkiZoLhE9xz8to3EP2
 PrKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQZg6MplYGh0dztyAMbVr0NXFhY0WlkFiDQrK1MEmLQ4pu/RpZEO7EnJ2s+P+MM0iRtnzZk2iikZoA@nongnu.org
X-Gm-Message-State: AFuF++mvdIiEc2O6DhgIrddxowm81rBKP9veulT76q7Kjd8z2mODmF8P
 2BV0TkS7q4GSQJxBcJBxmCElqgDX1mM4At/ZpBejqdUaGbrLW7EhDIvbD5PzdmDUMcy3Q4uR/EJ
 /v9uJgNrxqM8F4k6mCkMJZawP5LeIssQcYmVdzqXKt/C5xTfrW7m5K209Sw==
X-Gm-Gg: AR+sD12P8QqifvuZ+FElXNBLzdYyBkeTmkcp2yaLxMnx6QeyHDEJnBF65PFm3L6hdp+
 2f2wrFR817ilnwsNLuI3v0BO60gj+5K5Aj0ex77LvAlher5QMhZJ2vM5Pfe/epyy3IQa6hQF9o3
 R3PJZ6Hw1ao+2CnhgWZ/H5b0o0ZUbF5XcNGGa3EKgOUojXwRrY/0Lf8eXnrmermIgahNN+cKlLY
 9Qa+OcQFhGupOkJYCMyPKHrpsRrs9WOibnJLoKBfcbZ574B2XK6GP1b6jc8Sdewjzrq2RNw1xBV
 CT6YbTkNp1bTrrYvFz38nQG6HGPn6mmdy8narG9gRLwERDLrQEQTA6CwTVu+lMKNb42UMLUx3bb
 U92hEBmzVrE9+F9CfVpqy6npPuAbseA8tFtU4K7AEYPeXW/Gds5e6vuLsPtO4B+zKrzRd
X-Received: by 2002:a17:903:19e8:b0:2ca:e9dc:7357 with SMTP id
 d9443c01a7336-2d64b01dbc5mr16305025ad.9.1787252268924; 
 Thu, 20 Aug 2026 11:57:48 -0700 (PDT)
X-Received: by 2002:a17:903:19e8:b0:2ca:e9dc:7357 with SMTP id
 d9443c01a7336-2d64b01dbc5mr16304125ad.9.1787252268492; 
 Thu, 20 Aug 2026 11:57:48 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327cbb46ff8sm13722011eec.23.2026.08.20.11.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:57:47 -0700 (PDT)
Message-ID: <cfef4655-01ac-4cc2-b2d4-a45cd7294622@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:57:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] target/hexagon: implement direct-to-guest interrupt
 delivery
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-10-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-10-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a874e2d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=3NKNWfcY5tkQpwYz8W0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfX8T4oms1qbzwh
 r61r4VGiKPqnzFIU8LHH1oUwryClmjHAlYD0/uxao1M66n/S8WOFfCi+xYFH1J4Sk+Iah4Cu4Lf
 RgBXk7hu12jEiroDlNtNFHRzEhnPUqrMGDiz/y0BlU4di2JrMP1B3u9gn6ojwc8346gPsZnb7ox
 CTcHE52JQziyrOOZMlxbdWSEoRoSemW6vFb9B53lvdYlP8snXwJ/jttVN50mFdGQdAu1CcOHnxs
 tiPS6nmn7aMKhkGD4VSdliKapZgFCatM8d77vN1wVlMq6+ZHWY71xEohdABr+/H+m9Ns6dKNXkh
 /o2zzhoLqVIzCCHouhnRVkW3sJFi/gxwjwRri05UNo82A0iqbj+8IP5SZT1Y0JqLG8FIzl1C46u
 yM1GQiQwj3lDA42GiBJpJ3PoLbvVGuSQx0fBMCFA6UXXy4J2iLDdzWSjKG2YoFEXynJTUZQz3PM
 BQN7we6WZc9MCrMngcQ==
X-Proofpoint-ORIG-GUID: bhUrLyJYeGFcgu_cTCwe42UKsh5bmJfh
X-Proofpoint-GUID: bhUrLyJYeGFcgu_cTCwe42UKsh5bmJfh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfX6tZHBJD37JO8
 ZSHgPkZTUdVE1vIsSBwXwZuN5TxuGvzvM2EJGoR+Km0VzZ/axCgfB9yvx/MTVabpF1bij5s3zaz
 pxg1gpALxXDUIiEhJuuWSFO7zStcgJw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> Interrupts 3 through 5 are routed to guest mode when CCR:GIE and the
> matching CCR:VV bit are set.  Enter through GEVB rather than EVB,
> record the pre-entry state in GSR and the return address in GELR, and
> read the vector ID from the l2vic.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/reg_fields_def.h.inc |  7 +++
>  target/hexagon/cpu.c                |  5 ++
>  target/hexagon/hex_interrupts.c     | 87 ++++++++++++++++++++++++++---
>  3 files changed, 92 insertions(+), 7 deletions(-)
> 
> diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
> index d2c706d56b5..29497fbcc4d 100644
> --- a/target/hexagon/reg_fields_def.h.inc
> +++ b/target/hexagon/reg_fields_def.h.inc
> @@ -136,6 +136,13 @@ DEF_REG_FIELD(CCR_VV1, 29, 1)
>  DEF_REG_FIELD(CCR_VV2, 30, 1)
>  DEF_REG_FIELD(CCR_VV3, 31, 1)
>  
> +/* GSR fields */
> +DEF_REG_FIELD(GSR_CAUSE, 0, 16)
> +DEF_REG_FIELD(GSR_CFI, 28, 1)
> +DEF_REG_FIELD(GSR_SS, 29, 1)
> +DEF_REG_FIELD(GSR_IE, 30, 1)
> +DEF_REG_FIELD(GSR_UM, 31, 1)
> +
>  /* ISDB ST fields */
>  DEF_REG_FIELD(ISDBST_WAITRUN, 24, 8)
>  DEF_REG_FIELD(ISDBST_ONOFF, 16, 8)
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 0a677840bcb..efaf569c6f8 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -475,6 +475,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>          error_setg(errp, "hexagon cpu requires 'tlb' link property to be set");
>          return;
>      }
> +    if (!HEXAGON_CPU(dev)->l2vic) {
> +        error_setg(errp,
> +                   "hexagon cpu requires 'l2vic' link property to be set");
> +        return;
> +    }
>  #endif
>  
>      qemu_init_vcpu(cs);
> diff --git a/target/hexagon/hex_interrupts.c b/target/hexagon/hex_interrupts.c
> index 3534481da24..ea1ba0903dd 100644
> --- a/target/hexagon/hex_interrupts.c
> +++ b/target/hexagon/hex_interrupts.c
> @@ -11,6 +11,7 @@
>  #include "cpu_helper.h"
>  #include "exec/cpu-interrupt.h"
>  #include "hex_interrupts.h"
> +#include "hw/intc/hex-l2vic.h"
>  #include "macros.h"
>  #include "sys_macros.h"
>  #include "system/cpus.h"
> @@ -215,19 +216,75 @@ static void restore_state(CPUHexagonState *env, bool int_accepted)
>      }
>  }
>  
> +static bool int_should_dtg(CPUHexagonState *env, int int_num)
> +{

What does dtg means?

> +    uint32_t ccr = env->t_sreg[HEX_SREG_CCR];
> +
> +    switch (int_num) {
> +    case 3:
> +        if (!GET_FIELD(CCR_VV1, ccr)) {
> +            return false;
> +        }
> +        break;
> +    case 4:
> +        if (!GET_FIELD(CCR_VV2, ccr)) {
> +            return false;
> +        }
> +        break;
> +    case 5:
> +        if (!GET_FIELD(CCR_VV3, ccr)) {
> +            return false;
> +        }
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    return GET_FIELD(CCR_GIE, ccr);
> +}
> +
> +static void guest_interrupt_entry(CPUHexagonState *env, uint32_t cause,
> +                                  uint32_t event_pc)
> +{
> +    uint32_t old_ssr = env->t_sreg[HEX_SREG_SSR];
> +    uint32_t new_ssr = old_ssr;
> +    uint32_t ccr = env->t_sreg[HEX_SREG_CCR];
> +    uint32_t gsr = 0;
> +
> +    gsr = deposit32(gsr, reg_field_info[GSR_CAUSE].offset,
> +                    reg_field_info[GSR_CAUSE].width, cause);
> +    gsr = deposit32(gsr, reg_field_info[GSR_SS].offset,
> +                    reg_field_info[GSR_SS].width,
> +                    GET_SSR_FIELD(SSR_SS, old_ssr));
> +    gsr = deposit32(gsr, reg_field_info[GSR_UM].offset,
> +                    reg_field_info[GSR_UM].width,
> +                    !GET_SSR_FIELD(SSR_GM, old_ssr));
> +    gsr = deposit32(gsr, reg_field_info[GSR_IE].offset,
> +                    reg_field_info[GSR_IE].width,
> +                    GET_FIELD(CCR_GIE, ccr));
> +    env->greg[HEX_GREG_GSR] = gsr;
> +
> +    fSET_FIELD(new_ssr, SSR_SS, 0);
> +    fSET_FIELD(new_ssr, SSR_GM, 1);
> +    env->t_sreg[HEX_SREG_SSR] = new_ssr;
> +    hexagon_modify_ssr(env, new_ssr, old_ssr);
> +
> +    SET_SYSTEM_FIELD(env, HEX_SREG_CCR, CCR_GIE, 0);
> +    env->greg[HEX_GREG_GELR] = event_pc;
> +    env->gpr[HEX_REG_PC] = env->t_sreg[HEX_SREG_GEVB] |
> +                           (HEX_EVENT_INT0 << 2);
> +}
> +
>  static void hex_accept_int(CPUHexagonState *env, int int_num)
>  {
>      CPUState *cs = env_cpu(env);
>      HexagonCPU *cpu = env_archcpu(env);
> -    uint32_t evb =
> -        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
> -                               env->threadId);
>      const int exe_mode = get_exe_mode(env);
>      const bool in_wait_mode = exe_mode == HEX_EXE_MODE_WAIT;
> +    uint32_t elr;
>  
>      set_ipend_bit(env, int_num, 0);
>      set_iad_bit(env, int_num, 1);
> -    set_ssr_ex_cause(env, 1, HEX_CAUSE_INT0 | int_num);
>      cs->exception_index = HEX_EVENT_INT0 + int_num;
>      env->cause_code = HEX_EVENT_INT0 + int_num;
>      clear_pending_locks(env);
> @@ -235,15 +292,31 @@ static void hex_accept_int(CPUHexagonState *env, int int_num)
>          qemu_log_mask(CPU_LOG_INT,
>              "%s: thread " TARGET_FMT_ld " resuming, exiting WAIT mode\n",
>              __func__, env->threadId);
> -        set_elr(env, env->wait_next_pc);
> +        elr = env->wait_next_pc;
>          clear_wait_mode(env);
>          cs->halted = false;
>      } else if (env->k0_lock_state == HEX_LOCK_WAITING) {
>          g_assert_not_reached();
>      } else {
> -        set_elr(env, env->gpr[HEX_REG_PC]);
> +        elr = env->gpr[HEX_REG_PC];
> +    }
> +
> +    if (int_should_dtg(env, int_num)) {
> +        int vic_group = int_num - 2;
> +        uint32_t vid_packed = l2vic_read_vid(cpu->l2vic, vic_group / 2);
> +        uint32_t vid = extract32(vid_packed,
> +                                 (vic_group & 1) ? 16 : 0, 16);
> +
> +        guest_interrupt_entry(env, vid, elr);
> +    } else {
> +        uint32_t evb =
> +            hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
> +                                   env->threadId);
> +
> +        set_ssr_ex_cause(env, 1, HEX_CAUSE_INT0 | int_num);
> +        set_elr(env, elr);
> +        env->gpr[HEX_REG_PC] = evb | (cs->exception_index << 2);
>      }
> -    env->gpr[HEX_REG_PC] = evb | (cs->exception_index << 2);
>      if (get_ipend(env) == 0) {
>          restore_state(env, true);
>      }


