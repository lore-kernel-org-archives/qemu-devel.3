Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70854FEC0FA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57SW-0007lD-9n; Tue, 24 Mar 2026 15:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w57SU-0007kZ-EG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:30:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w57SS-0005xj-3t
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:30:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCiqt907716
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qVSpTSDDnmh7uyWTT29FqMY4pOiSabeXBJpIkn10Fw4=; b=afnWog7NKMsnAS+n
 Yo/naORMn2vrD9SnzE6qVdxSiD3AlijqnUpJabXmOvcR5R+mwsyDqQScM3x1asi7
 m6PaHQcAOXBAEVMU92ScIfqnEIn5DWzHALBmCD7YPq2Ene6n5pf3XevB0qG0nZ3+
 0aCpOkvMQ0vyujOyJTrDsRQDvh40qIC2vG1W1vYllDGm7ayO9nFv1joQNYdO3QQd
 kH+5hjEvlHxDC2EzIulAeVl2cgr5AXxE/1Q+xGBlltD4JjFZSUuJ8fHWmSfd+vqd
 r0wdK62OR2yU9T8tsxMjv2fhkmRaTkgqQDxhQffn/Gl1CHU5fCP4p1cvygvXarQJ
 rY4e2Q==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3ukm9ds6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:30:30 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-467e00b684eso10847565b6e.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774380629; cv=none;
 d=google.com; s=arc-20240605;
 b=cZl1AV09Rtpr3BX8JqQnc2Xio8A9cA9aB7R+admp6UqBOu0+dCQdf0Ewoit3y8zOJv
 Ppqn/3oZXgGkGloSRxryndhKD3mqK6SBp5ISdmGQfk4jCCKrAdlmcKwv4ctLtcY9/FC6
 hcD50V5Cjy67xK88BtXKK0xzvtzsTjEeZ568a9O+J0sDQGYP4UrGbHpm/ois7D6/0Uez
 o4sZLKXvItS1I8h8FJ6bvwKOnQSKRjWtcu+OQR9yQ8wR7E3nlX7Roqm2d6LpzDmCeaZ2
 pnTSP/PMp/1aV+mNYgP6L43DmjtuSL53KD0oY+JsPV9Az39UcBks+zklyfxM73A8oF8g
 AUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qVSpTSDDnmh7uyWTT29FqMY4pOiSabeXBJpIkn10Fw4=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=isQcRK7J62YkrWdE2/q1rGgy8owulvTt2eX8XtgGGyHOb9waY3ReSwwxCkW/V1NRsu
 2ORLSbN1fV3Y5Ch6b6nnhE8Ke9FtO1lL1t/bfNLQNNnfFd98sLMidyScVLbY4gEfDj81
 qa3Adm3MugIZAC4Q5gies+9713YPPkjlIK++QPEoVxwFw2KD246hMEtuHGgebr4yevOg
 rl9/0686xo3A/MmyDficJTynmPUcnNcl75m2x8SzVbUZLWnkqzu+OsceKpYQWpLHvQz4
 w6tf5+v6jSCXLdOEScvlXblQJ/fVRnwER8deCmX+FuJ3DjU9Y2mVXupOG0ywDiBCEuVf
 MKmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774380629; x=1774985429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVSpTSDDnmh7uyWTT29FqMY4pOiSabeXBJpIkn10Fw4=;
 b=I8UUk+rEc+d9IN5jpQs15nqpc6p+1uxJvociYycJI9F3163OOYXYjx8iFG7wNBboJP
 b+/deFdnXrsZxcB7itilmsV+R01FnPLqKpvUF5NIIIQVBHjH8VKOYzTUY0gwkZhv/F6L
 I5qOfYstUz3+YoGWdbcvPjlDZDxYwqaRijPpOIbysIo5ixMlGs4YjaVTOCPJjkOkhI1D
 sOP6uf5+J936IupvwL+gXnfU/fsAd6K1+UKbJ3OITbICn6rk1vU+CluCuZf8/9/xqQmC
 LysvvnE87Z69pc7q6vXV7wCHb6BOVrp2Y/40LnR7yaPphUa+gwGjcjSfQ94PIahUcKG1
 3OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774380629; x=1774985429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qVSpTSDDnmh7uyWTT29FqMY4pOiSabeXBJpIkn10Fw4=;
 b=YTl7+iA83H/A/eVhsD6eRyAizRuRMygiGTEJKwwfXy6v720g+0Y2ct+aDQmVj4g+xK
 m3AXevoXl+m8tW64oq8VxHXrMagsZHHuN5EFqICgAlVgHEJ9KvaMOBFp54gahrxP7p50
 JDWqZNT7ndrzBfITTdgDIAkMDzDI+Ojf27nNvA1ozWsejTrNPylWnXr/ijBtjoI8YTh9
 mMd1T6h2bVR9pwOVK5ATovCLGw1BwkL85zjNf4w0rBWxKJAkoMY4CmKjNOfgJSy0BFya
 Hq6RD8x+D0bdVlksC6tKf8TQofUCQi7/cm1AKWjCQSkJLbRW4vKzurJfG1TuWc31Xs3F
 X6rg==
X-Gm-Message-State: AOJu0YwAEx+dI7m3RNw7Ct/2xd4lFcbo8aRIztBxSZJu78qU4by/KUY8
 Kile9XvsL/sy9dn8YBTfzLh3D9rXqohpKUo2JYh2KHx99YM34+bFerRlyc83Tl+sEIrqhI05dGv
 +eDZAxZhKOvIw/iQaPYurG0y34xd0c5/RkiyHhoXvjWu03KV/oXiTjl+AKHnI0ypD0tGt0wTn99
 qtuYLBMm6414EW1xbreL1jdJeXxoD3XtyI
X-Gm-Gg: ATEYQzyIhhWP40JgjG5EyCIsnmRFSVovohW9GpY27k4jkmjij1f4blEkCUMEPNHVsVq
 xJKMhTXQKebgg6KzfMEY6nmMFWxKdLx0O8uoNNXJckz3gzWRHGfbf7tiXQZ6Tf/vZ/OezGClEY4
 Y4Lemv47JOUkY19Q1ZMWQ3coKQ2Lofn+TZLbWO/podfswYHALINh9ViMh+ETf+O4UnZ84U2hFr+
 cmh8Zk=
X-Received: by 2002:a05:6808:1b09:b0:467:155f:8c34 with SMTP id
 5614622812f47-46a5c79a567mr426087b6e.48.1774380629390; 
 Tue, 24 Mar 2026 12:30:29 -0700 (PDT)
X-Received: by 2002:a05:6808:1b09:b0:467:155f:8c34 with SMTP id
 5614622812f47-46a5c79a567mr426056b6e.48.1774380628845; Tue, 24 Mar 2026
 12:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <831949008a7266559a6f313f99a394cd68cc9846.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrZVn6W0pAyshZ7mhYVcY+gtRk9tJwz5WLLzxoPTDupwA@mail.gmail.com>
In-Reply-To: <CAATN3NrZVn6W0pAyshZ7mhYVcY+gtRk9tJwz5WLLzxoPTDupwA@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 16:30:17 -0300
X-Gm-Features: AQROBzDgwWXSoKFK4mNjgmIiyLdk3HPbQTPNLqehzoBuZcRc1GHL5R_LLagGrPg
Message-ID: <CABrGZ+GmYG2tg0pWDoBuydWG3abTmMT2wxCu=06fXLQJQCS1YQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] target/hexagon: add v68 HVX IEEE float arithmetic
 insns
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NLjYOk6g c=1 sm=1 tr=0 ts=69c2e656 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=m8gCdCbZLl0sIZk3o0UA:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: g1ZN2GshF4C4Q9eHbicPgjmKVAH6kzAX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1MSBTYWx0ZWRfX6cGazzDymUsA
 NzyZCB3SQCLcnzD0iCLY9cg3NHQ4sFUrgNVDLflW/prO3fdOwSbhRouK0ZM/MvmuTUofIfBwJOg
 92gaRCuUTIgdsrD6nb1dEDHoALRqAraPhPaS7rghkYPQtjXljFblyCkVECSotSCf1YgFfko3gtn
 pcbqPCBipGyzSUoobSx1f9cZOo/jj7VqCWyVTzuvNNZFuuSJXpFtOWN3r9dg59ajlFJluEa57qV
 tevKXZigDfrnXkYSVVXeQ0ocjlfqmV87zA1Hr4HgDWeNLHeF2jGqkNiQHGt9Ku4dq/LsX3WlNy3
 TxBbTV5u25mOQ4+MUE/mpwY7eu14D31eRGE8rFnVySw1XwlkcEWaixVFyvEpahWgR1XTxRD1rc1
 do2hqtggCLyXNR7jR2jviG76SNKDFmntAkEc8GkaHw3+5LANEci1ybqC/RwOJktF43KHW5TtvXc
 azyOK3m9BKUVfdYMG5Q==
X-Proofpoint-GUID: g1ZN2GshF4C4Q9eHbicPgjmKVAH6kzAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On Mon, Mar 23, 2026 at 5:29=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> Add HVX IEEE floating-point arithmetic instructions:
>> - vmpy_sf_sf, vmpy_sf_hf, vmpy_hf_hf: multiply operations
>> - vdmpy_sf_hf: dot-product multiply
>> - vmpy_sf_hf_acc, vmpy_hf_hf_acc, vdmpy_sf_hf_acc: multiply-accumulate
>> - vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output
>> - vadd_hf_hf, vsub_hf_hf: add/sub with hf output
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
>> ---
>>  target/hexagon/mmvec/kvx_ieee.h              | 47 ++++++++++
>>  target/hexagon/mmvec/macros.h                |  1 +
>>  target/hexagon/mmvec/mmvec.h                 |  2 +
>>  target/hexagon/attribs_def.h.inc             |  4 +
>>  target/hexagon/mmvec/kvx_ieee.c              | 87 ++++++++++++++++++
>>  target/hexagon/hex_common.py                 |  1 +
>>  target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
>>  target/hexagon/imported/mmvec/ext.idef       | 93 ++++++++++++++++++++
>>  target/hexagon/meson.build                   |  1 +
>>  9 files changed, 254 insertions(+)
>>  create mode 100644 target/hexagon/mmvec/kvx_ieee.h
>>  create mode 100644 target/hexagon/mmvec/kvx_ieee.c
>
>
> I'm curious why the prefix is kvx instead of hvx.

Actually, not sure either... These files were imported from the arch
simulator. Brian suggested it was a left over acronym that didn't
catch on. I'll rename to hvx_ieee

>>
>> diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_=
ieee.h
>> new file mode 100644
>> index 0000000000..e92ddebeb9
>> --- /dev/null
>> +++ b/target/hexagon/mmvec/kvx_ieee.h
>> @@ -0,0 +1,47 @@
>> +/*
>> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + *  SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HEXAGON_KVX_IEEE_H
>> +#define HEXAGON_KVX_IEEE_H
>> +
>> +#include "fpu/softfloat.h"
>> +
>> +/* Hexagon canonical NaN */
>> +#define FP32_DEF_NAN      0x7FFFFFFF
>> +#define FP16_DEF_NAN      0x7FFF
>
>
> These are the same as the scalar core, right?  If so, there's already a c=
all to set_float_default_nan_pattern in hexagon_cpu_reset_hold.
>
> If the patterns are different, you'll need to call set_float_default_nan_=
pattern before each scalar FP instruction and before each HVX FP instructio=
n.

Not the same, no. I'll adjust the set_float_default_nan_pattern call
accordingly.

>> +
>> +/*
>> + * IEEE - FP ADD/SUB/MPY instructionsFP
>> + */
>> +uint32_t fp_mult_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_statu=
s);
>> +uint32_t fp_add_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status=
);
>> +uint32_t fp_sub_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status=
);
>> +
>> +uint16_t fp_mult_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_statu=
s);
>> +uint16_t fp_add_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status=
);
>> +uint16_t fp_sub_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status=
);
>> +
>> +uint32_t fp_mult_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_statu=
s);
>> +uint32_t fp_add_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status=
);
>> +uint32_t fp_sub_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status=
);
>> +
>> +/*
>> + * IEEE - FP Accumulate instructions
>> + */
>> +uint16_t fp_mult_hf_hf_acc(uint16_t a1, uint16_t a2, uint16_t acc,
>> +                           float_status *fp_status);
>> +uint32_t fp_mult_sf_hf_acc(uint16_t a1, uint16_t a2, uint32_t acc,
>> +                           float_status *fp_status);
>> +
>> +/*
>> + * IEEE - FP Reduce instructions
>> + */
>> +uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
>> +                  float_status *fp_status);
>> +uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t =
a3,
>> +                      uint16_t a4, float_status *fp_status);
>> +
>
>
> Consider using macros similar to the ones in the .c file to create these =
protos.

Hmm, I think in this case, the boilerplate size will outweight the
benefit of the macros.

>>
>> +#endif
>> diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mmvec/kvx_=
ieee.c
>> new file mode 100644
>> index 0000000000..b763899aa3
>> --- /dev/null
>> +++ b/target/hexagon/mmvec/kvx_ieee.c
>> @@ -0,0 +1,87 @@
>> +/*
>> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + *  SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "kvx_ieee.h"
>> +
>> +#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \
>> +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
>> +                           float_status *fp_status) { \
>> +        float##a1t f1 =3D make_float##a1t(a1); \
>> +        float##a2t f2 =3D make_float##a2t(a2); \
>> +        \
>> +        if (float##a1t##_is_any_nan(f1) || float##a2t##_is_any_nan(f2))=
 { \
>> +            return FP##rt##_DEF_NAN; \
>> +        } \
>
>
> These nan checks shouldn't be needed if you're using QEMU softfloat prope=
rly.

Ah, indeed. Just checked that. Will change

>> +
>> diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imp=
orted/mmvec/ext.idef
>> index 03d31f6181..3f0d8e366e 100644
>> --- a/target/hexagon/imported/mmvec/ext.idef
>> +++ b/target/hexagon/imported/mmvec/ext.idef
>> @@ -2895,9 +2895,102 @@ EXTINSN(V6_vprefixqw,"Vd32.w=3Dprefixsum(Qv4)", =
  ATTRIBS(A_EXTENSION,A_CVI,A_CVI_
>>      }
>>      } )
>>
>> +/* KVX - IEEE FP Instructions */
>>
>> +/* Single pipe, 32-bit output */
>> +#define ITERATOR_INSN_IEEE_FP_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
>> +EXTINSN(V6_##TAG, SYNTAX, \
>> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_32),=
 \
>> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
>>
>> +/* Single pipe, 16-bit output */
>> +#define ITERATOR_INSN_IEEE_FP_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
>> +EXTINSN(V6_##TAG, SYNTAX, \
>> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16),=
 \
>> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
>>
>> +/* Two pipes: P2 & P3, single output: P2, 32-bit output */
>> +#define ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(WIDTH,TAG,SYNTAX,DESCR,C=
ODE) \
>> +EXTINSN(V6_##TAG, SYNTAX, \
>> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_3=
2), \
>> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
>> +
>> +/* Two pipes: P2 & P3, two outputs, 32-bit output */
>> +#define ITERATOR_INSN_IEEE_FP_DOUBLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
>> +EXTINSN(V6_##TAG, SYNTAX, \
>> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_3=
2), \
>> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
>> +
>> +/*
>> + * single pipe, accumulate instruction, produces 16-bit output, require=
s 16-bit
>> + * accumulate input
>> + */
>> +#define ITERATOR_INSN_IEEE_FP_ACC_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
>> +EXTINSN(V6_##TAG, SYNTAX, \
>> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HV=
X_IEEE_FP_OUT_16,A_CVI_VX_NO_TMP_LD), \
>> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
>> +
>> +/*
>> + * single pipe, accumulate instruction, produces 32-bit output, require=
s 32-bit
>> + * accumulate input
>> + */
>> +#define ITERATOR_INSN_IEEE_FP_ACC_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
>> +EXTINSN(V6_##TAG, SYNTAX, \
>> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HV=
X_IEEE_FP_OUT_32,A_CVI_VX_NO_TMP_LD), \
>> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
>> +
>> +/* IEEE FP multiply instructions */
>> +ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(32, vmpy_sf_sf,
>> +    "Vd32.sf=3Dvmpy(Vu32.sf,Vv32.sf)", "Vector IEEE mul: sf",
>> +    VdV.sf[i] =3D fp_mult_sf_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
>
>
> Do these instructions interact with the FP bits in USR (e.g., rounding mo=
de, FP exceptions)?

They do not. I'll add a new env->hvx_fp_status and use that for the
default nan. This way we can avoid messing up with the scalar
fp_status.

