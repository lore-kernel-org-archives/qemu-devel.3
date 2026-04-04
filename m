Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313FBE88D6E
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 00:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8pFz-0007zr-SR; Fri, 03 Apr 2026 20:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w8pFx-0007yn-FO
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 20:52:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w8pFv-0002z5-J1
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 20:52:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 633Jlt64918065
 for <qemu-devel@nongnu.org>; Sat, 4 Apr 2026 00:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c4RFcW1FNO2bAe9Vymc9qJlNkvk1l3b2jnWcAO8gOdE=; b=gZo0NRufKN7OS6ZM
 dnl7aKwWlG/YtBLq10FWzSn+1NyqnKUqefEQdaLx3v0L+pUQZQogx0h1MuDj2u7S
 7BXB1ZdOsbPWI+FzcsCGK66MkWZhsL2n0dSPHeGl1z+oCJr29l5AKf6uSIseGjYG
 22iBIZx46c6tRmQ9kKeplFWIHpTtdAKm/aRpKY0eXn8dXLGKgenqgh1aJJLG0T0i
 dO0XdlA8ZUO62LvqzylyBVIkGQ/YClgFi0ZrYoz8kUp/jp3TyrmVc32ZpLeCv+db
 Ou78cywphIecnQ+6KG3U17zEDKlNAPGEPkadE6pYgtyb89TJXomPn1PbeHb9qyCN
 tvpfHQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dam160jmm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 00:52:51 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7900fc7033bso41265297b3.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 17:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775263970; cv=none;
 d=google.com; s=arc-20240605;
 b=Z4AJdlUXbx/sh8nSNZFlvCyRzY1WxZNcML7Mw2j+LGd0bxCcfTVO7KTBKoyx1WghNu
 MHfCN7u1iaMxSb+olM9vkFJ2jeGcraY1PvQIYyfsWoyt/jp3JK22zZCC8XwEtTQCpin7
 VEBc+tp2t0vbEtT630wrlCjyCHNbmxmvkyCRWUhLACniP+qFIXmkliv2DUcLmzGyrlMy
 uTgnHaGOzNpMcK74gl+0kkPJEWuFrkJVVyMRLqioRoA7L1dl6g7nhC8z1BnIKkX2flr2
 UZd528mbQlW4BHUuIm9R7AVjlwnx6pU7mezfzJR2jBlKq3oqibLoaoj98fTmWmdudq9E
 IEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c4RFcW1FNO2bAe9Vymc9qJlNkvk1l3b2jnWcAO8gOdE=;
 fh=uV0EhJYM2i9jJGd+E+t12qwhXF+jC75b45QOXLh37oM=;
 b=BYnU9WqmE6ZHeG6e8tIh3oWJwToHSKb6KPiD5qY71dLTFSWvAy3l5rIRRe14RK+N3Q
 HcfS4VhMnosHpXX8jsj7lQh4FWHomGa0gDoshKwhePIKBxKEmqE6yCzI++HulN6plfD2
 e6aMANOyBqJA3DqpBitHmDdT4t9/AYYfhfpb/jYDIT4sZXNNNdlvDg2is6hK8kVRv8Qe
 OVIKvdRi+aGAgJ830qB+2QdJKzYbvGMj+T0DfWFfYliOhZHMA07s9bTTM4A5Iito1G84
 Y/r7vgTkKMvzCn6F72phtbV9EnogjmU/20okf8aSfobGQXt0aMU2o0OFBfjf69WwIyL+
 Of7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775263970; x=1775868770; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4RFcW1FNO2bAe9Vymc9qJlNkvk1l3b2jnWcAO8gOdE=;
 b=U2Pq4EyS5/WvjEfk8sDdOtPxUXA8OkvFhoVn+LpqhCu2DLi/xp20EqS9DIZXmIOG79
 hLTV2LNFFQqvi3Ds2JMYru4uqW4Vrn+4fSgqZQKGaOobtyEGvHtEuW6LExuslD7QV+2z
 mSPW2xSmHNTNdKqiwEaXKoUxSOvUkNTFRKAJLHFcuzFn3lxEgJQp2Z8B08yW1aXpYkcx
 KNzi4id1MBx+NZEn/rkssldsGlyDsi0/xFbmyDAu5MnrPfHGfgPatRaCeLgEeLXjuhj+
 8zq9SMphXnqiTnYCb5aig+SrcKH9VTIFJrXXf6h/ad0mzkh9gSBk8GO+1deQnYSDjXT8
 vixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775263970; x=1775868770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c4RFcW1FNO2bAe9Vymc9qJlNkvk1l3b2jnWcAO8gOdE=;
 b=gcOS5zvcNy0EkcqBAUyBu95fI8Gw3zgRi4mPgZSI6zqaCRn5y21CoqR0qQuBr0Aquj
 5dzMoO6PpYEh/EMXMh9ruuV16Bl+iyNi7nxDxUnU5FV05IcHYo2xzxSMkWUJixbTWMfp
 Y3c3rTHfCluqNFUAx1f568xOeU8L/6WyjN48js8hqXGnq4vHVCCM98VoS5SkdatcKhea
 vnHpmJP+LN/heDJe91l2PCUERlZnzzlIZ7HLYzlXv1pEpki9pzgr6wrgVtbnKcD53yQm
 hStTT3/4kNrrC+p1KBzwFTPHX0cFY/d2eXqH56vuAHeHBNugSfla2UxHWxZaqTuWRAh2
 jEww==
X-Gm-Message-State: AOJu0Yw6Pfqs0/tf+zC3zThB2CMkL92aGVKQ/yp4h4pPL1o4Qtk7m3HI
 5kzDlOutBi2SDv4I6Ww+au4NkgJ/6N9OQ4NSPBDwBBZJEzpMTVrUxHwYyYITyWuE5/RZaJzC+sB
 fk8tKwQ+iQTvEU6shvzmQCvzViHWXLc939pr+gz5waDw8mpJHmjRibM1AfsoX2z/lkHHyiLtdIT
 oaTenP4MexG5zH5U7QsDbAq2O3Um3CzQ0W
X-Gm-Gg: AeBDievcXP7f0FLWxbortN2U4Gcyaki+yWb7HJAgdUp+mB7kqOiIX95oBAT4cwMYkYN
 XJsmzZIDW7g2EQ0QMnPjEFA7VvdZ60OEk6rabsaKsNoXEwtIDVtlkgb4tS8AYAuokVWzd/F7VZq
 8YBOVfwl+6lsGWaHG1RwyNXGBi7eIi5TrE1sMqkWzt1nf0grudrLwzFfg2HZoECjXClMV/keffI
 w/4+no=
X-Received: by 2002:a05:690c:74c1:b0:7a2:80a9:93b9 with SMTP id
 00721157ae682-7a3be360a9fmr60841307b3.25.1775263970351; 
 Fri, 03 Apr 2026 17:52:50 -0700 (PDT)
X-Received: by 2002:a05:690c:74c1:b0:7a2:80a9:93b9 with SMTP id
 00721157ae682-7a3be360a9fmr60841237b3.25.1775263969925; Fri, 03 Apr 2026
 17:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-19-brian.cain@oss.qualcomm.com>
 <CAATN3Nod_fUbmdgXJefj160D7vW3HbMF-J0P3aG5NqK7kJpsjw@mail.gmail.com>
In-Reply-To: <CAATN3Nod_fUbmdgXJefj160D7vW3HbMF-J0P3aG5NqK7kJpsjw@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 19:52:34 -0500
X-Gm-Features: AQROBzA0EhQksf0OtclFVEIxDZCrRV5Hpr596qcTjgUZjyReIuefGm39hPOuzDk
Message-ID: <CAEqNhNZUMU4KAFc4fosYH9R1GWA6ZrDo=v7Y0u5yFr0SYLm2Dw@mail.gmail.com>
Subject: Re: [PATCH v3 18/32] target/hexagon: Implement setprio, resched
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Kr5AGGWN c=1 sm=1 tr=0 ts=69d060e3 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8
 a=ZJ8rzmASaLEWOddgH_cA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAwNSBTYWx0ZWRfX1hf80v1OOUj+
 RnbBZylX0lemX2Oa699rCtLFxd4zzESmRNXcp5b5OZyZSX5ygDVwlKLMUJtsHjGvWCniGKhvKPt
 nGAv04IQaanZRfAHxJKWgv+tPA+sICWKq3LvA8HBfS++3k4rS3ZoiYnhhJEifzF4gy80P8kfYK1
 oYnoeTmZNonsIm041p2Czu5vJ0Y6wgzuw0q8DeJR6TkAGBx2gNVU+TGVmeri1VYgsWkZUqhB00o
 VqHmp7dyoeo3PWycnQK3qOtczAd5C6FpjFqqkUYivC5xArUMYwJ4XqZIG+1o52LV6ggHFTTVw5C
 lxUkR06Wg6guu28eKtgWMpYD743oHv37W3qDcGRGWxD+yJgmGXc1Yj+DT/I+vCWUaD5We+tAck+
 h7djEi1rESr1dwM6vEMjfGc3kueJz2lWJxNiqxw/aQqA7wuD0TcFt5uYUNeFwYXcTAxOx2JyUIV
 Usk47PfMUPiWxrsVMRw==
X-Proofpoint-GUID: L7jldC2DSkpI8atDEyxYFe0Fxp-UIcCE
X-Proofpoint-ORIG-GUID: L7jldC2DSkpI8atDEyxYFe0Fxp-UIcCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040005
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 16, 2026 at 11:49=E2=80=AFAM Taylor Simpson
<ltaylorsimpson@gmail.com> wrote:
>
>
>
> On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualc=
omm.com> wrote:
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> The hardware-assisted scheduler helps manage tasks on the run queue
>> and interrupt steering.
>>
>> This instruction is defined in the Qualcomm Hexagon V71 Programmer's Ref=
erence
>> Manual -
>> https://docs.qualcomm.com/bundle/publicresource/80-N2040-51_REV_AB_Hexag=
on_V71_ProgrammerS_Reference_Manual.pdf
>> See =C2=A711.9.2 SYSTEM MONITOR.
>
>
> This document doesn't have a section 11.9.2.
>
>>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>  target/hexagon/op_helper.c | 75 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index 9090a5c20ab..36822219b4b 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -1575,6 +1575,62 @@ static void hexagon_wait_thread(CPUHexagonState *=
env, uint32_t PC)
>>      cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>>  }
>>
>> +static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)
>> +{
>> +    uint32_t schedcfg;
>> +    uint32_t schedcfg_en;
>> +    int int_number;
>> +    CPUState *cs;
>> +    uint32_t lowest_th_prio =3D 0; /* 0 is highest prio */
>> +    uint32_t bestwait_reg;
>> +    uint32_t best_prio;
>> +
>> +    BQL_LOCK_GUARD();
>> +    qemu_log_mask(CPU_LOG_INT, "%s: check resched\n", __func__);
>> +    HexagonCPU *cpu =3D env_archcpu(env);
>> +    schedcfg =3D cpu->globalregs ?
>> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SCHEDCFG,
>> +                               env->threadId) : 0;
>> +    schedcfg_en =3D GET_FIELD(SCHEDCFG_EN, schedcfg);
>> +    int_number =3D GET_FIELD(SCHEDCFG_INTNO, schedcfg);
>> +
>> +    if (!schedcfg_en) {
>> +        return;
>> +    }
>> +
>> +    CPU_FOREACH(cs) {
>> +        HexagonCPU *thread =3D HEXAGON_CPU(cs);
>> +        CPUHexagonState *thread_env =3D &(thread->env);
>> +        uint32_t th_prio =3D GET_FIELD(
>> +            STID_PRIO, thread_env->t_sreg[HEX_SREG_STID]);
>> +        if (!hexagon_thread_is_enabled(thread_env)) {
>> +            continue;
>> +        }
>> +
>> +        lowest_th_prio =3D (lowest_th_prio > th_prio)
>> +            ? lowest_th_prio
>> +            : th_prio;
>> +    }
>> +
>> +    bestwait_reg =3D cpu->globalregs ?
>> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_BESTWAIT,
>> +                               env->threadId) : 0;
>> +    best_prio =3D GET_FIELD(BESTWAIT_PRIO, bestwait_reg);
>> +
>> +    /*
>> +     * If the lowest priority thread is lower priority than the
>> +     * value in the BESTWAIT register, we must raise the reschedule
>> +     * interrupt on the lowest priority thread.
>> +     */
>> +    if (lowest_th_prio > best_prio) {
>> +        qemu_log_mask(CPU_LOG_INT,
>> +                "%s: raising resched int %d, cur PC 0x" TARGET_FMT_lx "=
\n",
>
>
> Don't use %d
>
>>
>> +                __func__, int_number, env->gpr[HEX_REG_PC]);
>> +        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO, ~0);
>
>
> Is ~0 the correct value here?  Seems like it should be best_prio.

As tasks wait, the kernel can update the mutable BESTWAIT:PRIO field.

But when the scheduler is activated, then the bestwait priority resets.

>> +        hex_raise_interrupts(env, 1 << int_number, CPU_INTERRUPT_SWI);
>> +    }
>> +}
>> +
>>  void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
>>  {
>>      BQL_LOCK_GUARD();
>> @@ -1680,8 +1736,27 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *=
env, uint32_t reg)
>>      g_assert_not_reached();
>>  }
>>
>> +/*
>> + * setprio/resched - See the Hexagon V73 Programmer's Reference Manual,
>> + * Section 6.4 "Interrupt and Thread Scheduling"
>
>
> Neither the V71 (mentioned above) or V73 PRM contain section 6.4.

I'll remove the section number references to avoid confusion,
especially since they're not stable.

>> + */
>>  void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t pr=
io)
>>  {
>> +    CPUState *cs;
>> +
>> +    BQL_LOCK_GUARD();
>> +    CPU_FOREACH(cs) {
>> +        HexagonCPU *found_cpu =3D HEXAGON_CPU(cs);
>> +        CPUHexagonState *found_env =3D &found_cpu->env;
>> +        if (thread =3D=3D found_env->threadId) {
>> +            SET_SYSTEM_FIELD(found_env, HEX_SREG_STID, STID_PRIO, prio)=
;
>> +            qemu_log_mask(CPU_LOG_INT,
>> +                          "%s: tid " TARGET_FMT_lx " prio =3D 0x%x\n",
>
>
> Don't use %x
>
>>
>> +                          __func__, found_env->threadId, prio);
>> +            resched(env);
>> +            return;
>> +        }
>> +    }
>>      g_assert_not_reached();
>>  }
>>
>> --
>> 2.34.1
>>

