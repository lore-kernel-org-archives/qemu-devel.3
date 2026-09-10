Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751B7C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4fge-0000tH-Gx; Thu, 10 Sep 2026 10:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x4fgd-0000t9-CP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:23:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x4fgb-0008F4-4g
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:23:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AE09XT1334162
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 14:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J1N/uqAFYfACwM6PZBLrAwEG
 fO9dyVbyHFjMJuzekrE=; b=K3/jehSxCD391p45BvHKJf4nx1HsL8UJ7cG1Hima
 J1byTCpIwZ9TCeFOVLnJZLvV05c8ST0J5fJBHyheetHNYmwfhn5oD3W6TnbUiAh6
 14HRofO5kPg0ni16au7uyWADriiMXdaF3B+RBOx0CGQbIDoudM7P4P9TqiEIQMyu
 7AiHZqpvPdm0uEJLPTJA9mWBt+VCNG0hVN94LxUwyN2gRckAXwVZ9rLGhcA+Fm6X
 Q7Y9woWo9GX4ccu1rCo+/JD0MuUcW9ZF7bYREtkyLWjv7fx17a0jTtM0ZRsJ9xUJ
 5/lsMMiP43zHKDcKsNXBFyPreyptDohoWBUYsUdmDtjoHA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwx9r7y2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 14:23:31 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8563c2a53dbso141182537b3.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789050211; x=1789655011; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J1N/uqAFYfACwM6PZBLrAwEGfO9dyVbyHFjMJuzekrE=;
 b=UT2kgbnrgBkc6v1HqtRobafdygjAXYGfO+wtFLMUG+nY2RBlv+DapNBXFxrq1D4TZL
 NUmYjOP/tR+L1jqB1XIkl/FwZTOa8eBzaFlWYXFOvdZEhlj3HTcD0AbsEduFd5rlbYXV
 p/+mu171htxqy/5UQ3aEA0cT6KcD/qQtEVnBdsUtZAUoCvY4KrjH3r2bX0GbwhcZt/s1
 cnKmhjeoN2ZLI/f0DF6OvSSJm4B8531B2WFxtyyWLJVsrSd9rMxgOIeBTehPKv/JXU+X
 E3B55h0x+uG//IZ3tUm5Jb22O/ftOL/MFbeivh5bKriPMF7uxeITQnCg31+6YkE76ISX
 3TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789050211; x=1789655011;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J1N/uqAFYfACwM6PZBLrAwEGfO9dyVbyHFjMJuzekrE=;
 b=jQ1gZJsqs3C/DfVTO4T/aKzuGNOWiQhwkz88PxOeDR2LhM0yfq0Boy/6k/TIqCxqBx
 eWZvMxXvicd+Eu3aQ475016Huyisoi6kSUb4dBYUtpZNgqPTphxUyXHoJQ3u577q8vb4
 wnnCTq7+/ufehYP+9gvaFWA3W3/MivOMgsQOlPoJVCpsRfRfW9JKDRQuRe2dmmxEMWdP
 wAyJikW2JHOi8gdfXtMjwv/w/lWie5vZvCinTqkp6uhZIaiRPC/wKo7/kGOyWzfglOSb
 UyZX7ry6WPPvMGpvdwmMB+gtknwYLdMJxSe1L7pKfb883XUweuzbKP1CytUn3VylVTej
 zDug==
X-Gm-Message-State: AFuF++lu7jRhn6+6HWQ4iMd/+1tfqEfM1UsWEhDwnGH03DWQnzqiiHmg
 g58cw3wYxUaXV9T3VCxsV5qyNGUzYIklyrJXKzRMlFC3Hbjj0XdjzM2hrXy8HdUWw9oc3B/Gi95
 Lw3mwnEyhStja972V62MA6QNMI12vEsSbpe85xb7K4/dJJ3oAZUW2uWEDCGzGSqg3MQ==
X-Gm-Gg: AYBFou3iCTew2cl54dqyR0pdKKx+rB69DBNCW2XB5wAoJBWcwWyqT9qFVUh479YP0mG
 GLhK9vNKavlC4GWtmDd0+KJwUzoA8zPrNSOzEItIQB4LgRVb4xuT8IjoajLU+ddEyjQhHIza7wg
 NTTy6X4xn+dz+/AuQXG5Uk0uI92fT2Z9EiSyNBPDJc2af7LarsHiM+fUVEmc4OBPGJUlJKg8wjA
 HzgFkxyitMZC5CqSl8u64YG2Yoe6q7zeB6aH/3fYmW4h23TMnIN97zkchuMckuOM7QXeyGX05np
 5yf4mWE4U4+Ydf+s0HZsRo5lLtuja9dj+ZDLTnzVbHUhn5Bjd88bLFnkz38QNCjPuKSy4CmIYOr
 ++ODBOSLkaDF8OLe9b2D0g96TppcXtq4JiCMeSw==
X-Received: by 2002:a05:690e:16cf:b0:66f:c1bc:4096 with SMTP id
 956f58d0204a3-66fc1bc47a3mr9897899d50.89.1789050210684; 
 Thu, 10 Sep 2026 07:23:30 -0700 (PDT)
X-Received: by 2002:a05:6122:4689:b0:5bd:81fc:ebe9 with SMTP id
 71dfb90a1353d-5c7ed087c0cmr24063590e0c.0.1789049864293; 
 Thu, 10 Sep 2026 07:17:44 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d6e1c93sm922489866b.63.2026.09.10.07.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:17:43 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:17:42 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Icenowy Zheng <uwu@icenowy.me>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v11 2/5] target/riscv: add riscv-server-ref CPU
Message-ID: <w44ujiuswgc4adzlmgimorjgad34vav6vdfcgqtbkbifjjczqa@43b4y5n5pqwv>
References: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
 <20260909210756.1767711-3-daniel.barboza@oss.qualcomm.com>
 <7jkwao2hlaqtkdi44zkvgfe6rij7rpz6dd7qqwm6gw7xmta6vp@biexkhgtrofw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7jkwao2hlaqtkdi44zkvgfe6rij7rpz6dd7qqwm6gw7xmta6vp@biexkhgtrofw>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3MyBTYWx0ZWRfX8ZV6Jd0iAplo
 UUNjcIjQvNw/6z4MZNSOs46/pnsLxsKQzlc6HNfl/OoqiKt5Pvy5g3/UMaY2GQEitEOTqHyRe4H
 ZQGJvV7GKqA0ZoAwRR9sbseCpgMFIC3Z1MPeJgk7X8fYgsGJIzuejs4dTvMw8KDMXisTc814bPZ
 I0xOxEhehkIzs6G4zH9JIQ+8FO5P4xrM71GMRHmi1X2X+uDYIz6GNTDlFHn+Hdh5NrJttMoU/iq
 6YeDTjBZQETiN8L8NK8OJYkEWoSD6HMoakM8OnPo/IHumD9alk4cvrtsRwan1PCeWCRH8esHzAx
 Y1XgoCZSxDfmNe+ZA0ksyavwwSQVjeYNuOU/AOgGzRHCR2ajP68zcyBIIJHWprtVcxl7TgueWsd
 bOn6zyO0pikmLVWwe8+isH7NsmdexqO0BiXvsMf5O5ZmpjT2ndqCTWVxAnBiOn7kf6iYQ//Rtw1
 PmHztWso3l1OZCMh52g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3MyBTYWx0ZWRfX67eYBgd3RQ4y
 ykf9HqUxBznTf21/8V685n3wwuSCpnG+EIMXmH/Oeuiy4Od0rIwszUg7jCLMnVHm9meH75iMbSd
 /zBiH+QIDarK96JURKxSsQOYOb3EG8A=
X-Proofpoint-GUID: SFfiOi7cTw1_w6df_lRFNK4gMPn6-N2c
X-Authority-Analysis: v=2.4 cv=TupzFzXh c=1 sm=1 tr=0 ts=6aa2bd63 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=PXcuKL70AAAA:8
 a=FRSEYCzRAAAA:8 a=lvWoAcddulKRHkWN8sIA:9 a=CjuIK1q_8ugA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=xVlTc564ipvMDusKsbsT:22 a=1qLaeP4TCVy2vqIEy19U:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: SFfiOi7cTw1_w6df_lRFNK4gMPn6-N2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100173
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


More comments...

On Thu, Sep 10, 2026 at 09:47:27AM +0200, Andrew Jones wrote:
> On Wed, Sep 09, 2026 at 06:07:52PM -0300, Daniel Henrique Barboza wrote:
> > The harts requirements of RISC-V server platform [1] require RVA23 ISA
> > profile support and others.
> > 
> > We're going for a profile-based implementation, instead of a regular CPU
> > that can inherit RVA23, to allow future CPUs to use it internally as a
> > starting base for their own extension sets.  There's also a new
> > 'rvserver-ref-1.0' flag that can be used to set the extensions in the
> > command line for other CPUs, which can be used for testing/debugging
> > purposes.
> > 
> > Note that for all intents and purposes "riscv-server-ref" is a regular
> > CPU and no, we're not trying to set a precedent of calling the riscv
> > server platform spec a profile.
> > 
> > [1] defines in rule SEE_020 that we must support at least 11 debug
> > triggers (4 for insn address, 4 for insn load/store, 1 for icount,
> > one for int, one for excp).  We're going for the minimum.  If more
> > triggers are needed users can set any trigger amount with:
> > 
> > -cpu riscv-server-ref,trigger-count=N

s/trigger-count/num-triggers/

> > 
> > Note that N must be <= 128.

Why? Isn't the limit RV_MAX_TRIGGERS == 1024?

> > 
> > [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> > 
> > Suggested-by: Icenowy Zheng <uwu@icenowy.me>
> > Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
> > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> > Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> > ---
> >  target/riscv/cpu-qom.h |  1 +
> >  target/riscv/cpu.c     | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> > index 1a28f1369c..61234842e3 100644
> > --- a/target/riscv/cpu-qom.h
> > +++ b/target/riscv/cpu-qom.h
> > @@ -42,6 +42,7 @@
> >  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
> >  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
> >  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> > +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
> >  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
> >  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
> >  #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 773aeba8da..0b0b8e0a99 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -2424,11 +2424,36 @@ static RISCVCPUProfile RVA23S64 = {
> >      }
> >  };
> >  
> > +/*
> > + * This riscv-server-ref entry isn't a profile per se but its
> > + * CPU definition can be modelled as a profile that extends
> > + * RVA23, with additional things on top of it, and allowing
> > + * future CPUs to derive from it via
> > + * ".profile = &RVServerRef1_0;".
> > + */
> > +static RISCVCPUProfile RVServerRef1_0 = {
> > +    .s_parent = &RVA23S64,
> > +    .name = "riscv-server-ref-1.0",

rva23 mandates Ss1p13, so shouldn't we have an explicit

 .priv_spec = PRIV_VERSION_1_13_0 

here?

> > +    .satp_mode = VM_1_10_SV48,
> > +    .ext_offsets = {
> > +        CPU_CFG_OFFSET(ext_zkr),
> > +        CPU_CFG_OFFSET(ext_sdext),
> > +        CPU_CFG_OFFSET(ext_sdtrig),
> > +        CPU_CFG_OFFSET(ext_ssaia),
> > +        CPU_CFG_OFFSET(ext_ssccfg),
> > +        /* ssstrict is always enabled for PRIV_VER_1_12 */
> > +
> > +        RISCV_PROFILE_EXT_LIST_END
> > +    }
> > +};
> > +
> > +
> >  RISCVCPUProfile *riscv_profiles[] = {
> >      &RVA22U64,
> >      &RVA22S64,
> >      &RVA23U64,
> >      &RVA23S64,
> > +    &RVServerRef1_0,
> >      NULL,
> >  };
> >  
> > @@ -3766,6 +3791,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
> >  #endif
> >      ),
> >  
> > +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> > +        .profile = &RVServerRef1_0,
> > +        .misa_mxl_max = MXL_RV64,
> > +        .cfg.max_satp_mode = VM_1_10_SV57,

To stick to our minimalist approach, we could default the number of
counters to six

 .cfg.pmu_mask = MAKE_64BIT_MASK(3, 6),

See RVA_060. The user can get more counters with pmu-mask/pmu-num.


> > +        .num_triggers = 11,

Outside the scope of this series, more debug-trigger work is needed for
complete SEE_020 support. In particular, QEMU still needs interrupt and
exception triggers and the required VMID/ASID filtering. The 11 slots
configured here provide the intended capacity, but do not by themselves
provide all the required trigger capabilities.

> > +    ),
> > +
> >  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> >      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
> >          .cfg.max_satp_mode = VM_1_10_SV57,
> > -- 
> > 2.43.0
> > 
> >
>

Thanks,
drew

