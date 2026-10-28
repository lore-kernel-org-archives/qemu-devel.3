Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A8606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MH7Rx2Tz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kTZ9w1mc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9oF-0000y7-6G; Wed, 28 Oct 2026 15:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM9oB-0000wU-8G
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:59:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM9o8-0000WA-70
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:59:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPjmV848564
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gMzvjR8asBcUnu8BI/zhu68U5fL5XTnOpItUHF2C3WI=; b=MH7Rx2TzIW1qTzU/
 x4OxMWmJTJTozyiuZ3I5Yf2IsRRkX2XkMZUuJm5unolrdWpUurgaQOP23s2RcHki
 HA+P/GRGX+Kk/dKpD2jhfiIX206UCxB14ZKnpRseRerDaQmkemiA/42Ecc85+Zdb
 U/uAQIVU6mL+I3pP6+/TNezP0sCl/HloNJT88uT0NXvbP4eVeiqWgJ+ZvkKFRxSX
 5chCYuRD71ZHtVgXrJbBO6j1X9eRvavT/oHdHJZdruhKxh5Ss7kgzS43wGZ5tpKF
 4cyjAJuWgPm4UBOL5gWADY3Kdu1EYNSKCwhjaudMnbwVUsRdwPE/N7hARyakZ21m
 QI5vrg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdsp2ppm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:59:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso2937297eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793217573; x=1793822373; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gMzvjR8asBcUnu8BI/zhu68U5fL5XTnOpItUHF2C3WI=;
 b=kTZ9w1mcw2d6jFdSgDFzCc2oJ/vmMIGYVAp4xr5kMV7bN5OsmYAq1BMDGta+urNSQo
 5fwrL3AOIwT36yC13Mc5c+ScYmEpMZo+exu5VykMHjpapNQZ+b9WSyueL3cNmqFD2TeD
 bFwS4OuStctN+xrWVeMdrvWdHWCGueWcTY94aAVlMTBxT56pbR138kd/Nr8TSaiOLVaj
 DEQAab61dLH6xI2UZE+c6uWqpoL9rapzW2wMVYRXU3KlYVe3UjQt6ExeTJ6dVjkT5jhR
 usDdJiigJN9l4GrwT0ykfIa2yj+zTqGFNcfRuINL0GjKriJb+hAaQz8/B5H4loNjXHJl
 LzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793217573; x=1793822373;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gMzvjR8asBcUnu8BI/zhu68U5fL5XTnOpItUHF2C3WI=;
 b=yloC+OmmJ/11EjuUqLjmTPdNEsaNANZsuEzR1NSDjst5gqlI2fNo+z/4U9b6sK2yjH
 Dugu0HkivGPycv8syFS0kU+NlWqCUiLX1ez6tStuZ3dj+dynGlmGZvJbHrrALA6eD0fh
 POLmCepeneoJa5q1h/qVnO5gHMu5Cnr3a9JvcL6awXeHW3J6ldnEMHNGkoVTbT9tSrUP
 JB9w+LvRJdUcvcbdiR7GEON4yBivtkCEoknAMtM7ZZi55bqWegmubP4C+ue3NgKE68U4
 V9ggFYyGV9sO4mnFDhRQeuQK6iWGgVm+DK7YatpzMdDXv15VkzItUHgRK0n1dvztWv42
 RKVQ==
X-Gm-Message-State: AFq9FYL2tKDXRDt4nkUrOfS5LZwTax9SDq/nPnb2GLqPjbqOvq5/E1p6
 fE5Y8Ewm/tZy86c/RXt3BHMa45mjKIlke+uHegjSuP5nuXB81poUCFBI/MQTb6RreECUiFJiBRw
 c/9mFKZ0kdCHDp8Q7gvqBZvgprx3rToDaEv1iXLb/tp8BbXdhCPVBCdHj+Q==
X-Gm-Gg: AYBFou1Qzlc20h1Os+bTWH/AzZjoUfxJDS6VWcayetGAya2IG0ygPs/kr0ZeaAifL4M
 oZd2kt2qOVhzE9xa4FbqEOf8ZPeOa9kCABUVUCiFnXSn6oYjr939DOyo5TQCgy1VTi0EE41qol2
 tS1iHl5b2/EwRH7+4aX9qxgKgqDrgpZLIYmYQGQfo0RAauY6snY19N4qUkj69MgMl/yi8/ooDXb
 qANjzo7NYfuhIljWTG9lCnaIFV6hDG6cInynG7m1aJongWbWp6bWmQ4LybW2s/tVd9+TdEyI/qM
 +/T2p87v32A4UqKSXH3nMreOJcli97SvtdAMtnh/U4Cy0YIe4YVCDwfmySOQvXNawi6IR2D617A
 e9/tsoNpScr/khmAfiOF8FrhoAtTTzGpThj2VwZ86Kv5a2QcOng4ONg1mrWTKIwD0XbBbahL3eD
 KnTfXTofp4VpEM8U8G/28xH1rO51JxHnwJ2hsopXDn3uY=
X-Received: by 2002:a05:7300:7a8d:b0:369:d84e:eba5 with SMTP id
 5a478bee46e88-36a20391cf7mr4150279eec.11.1793217573209; 
 Wed, 28 Oct 2026 12:59:33 -0700 (PDT)
X-Received: by 2002:a05:7300:7a8d:b0:369:d84e:eba5 with SMTP id
 5a478bee46e88-36a20391cf7mr4150212eec.11.1793217572225; 
 Wed, 28 Oct 2026 12:59:32 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23641e78sm9864920eec.0.2026.10.28.12.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 12:59:31 -0700 (PDT)
Message-ID: <f4cc75c8-c947-48dc-a1cd-93b03e3af157@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 11:59:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel: register CPU parent for each target
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Weiwei Li <liwei1518@gmail.com>
References: <20261028063049.2530-1-luoyonggang@gmail.com>
 <20261028063049.2530-2-luoyonggang@gmail.com>
 <bc5bad6e-fbc2-44e1-a4b4-41bdfd41d33a@oss.qualcomm.com>
 <CAE2XoE_r3gZXzS+TFUd+GRs-8ZtCTajsJK0wJpTHNoXx_Cf3dA@mail.gmail.com>
 <7bd5d577-63db-4356-a19e-4b7e030d58d9@oss.qualcomm.com>
 <CAE2XoE-0zECt6yYURkTbUDBWfG63r_6Dr1oxc5XUcUXr9Wk61g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-0zECt6yYURkTbUDBWfG63r_6Dr1oxc5XUcUXr9Wk61g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JIFdd4raBP3w4rh2lEANk3z2T8rZmaZ7
X-Proofpoint-ORIG-GUID: JIFdd4raBP3w4rh2lEANk3z2T8rZmaZ7
X-Authority-Analysis: v=2.4 cv=Cssq4X4D c=1 sm=1 tr=0 ts=6ae25426 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=hdkVIfFkLkAALpxKQBQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3OSBTYWx0ZWRfX+GNem8+2/rdv
 rq4S9GiKQH8BUiOMOi7CywTBuOc501X+e4YY2nl+c6gU/pTGf5WlhR/qokokr7/YS13ud0ngIcm
 oY1Zqslk7PnrGOnmIN8aZAWP42aDjqlzVcjgi+ltsY1NvXxVkkiPCBuTaTo8Fe/Pjgw1+nkuTB5
 INOLYRXobueKh/sicUe9mRjsvtcFOrwLTsdU7MMbNocZkFhzDlxaHqRwttCz004Ej7Pe1lL1W6w
 lBG62wRI4KM1To49Yu6xEMhHNWS6ysvMzrTLfulCiuMFpqMB2m62oZUGz/ka+TjIjakEoZ7RjJB
 +BH3APaseuqKcmS01TitoZUsu6f3QNWmOwyvcahf7xEYvZ7PyUrVg8cSSVE/VVvNodj1rJn+4wr
 +Ah37ksNwHGm6VQy/YLN0LClFO+IjA0oyqI9SNo5fIrfcFBKPB6LXBvHfXXUDl6MR7yhFEazJDL
 EvtsFBhG88R9eGXJHtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3OSBTYWx0ZWRfX44f8L5foDdxT
 wHRqTeYaK1sx89ROAvRRL9XNygsmiUpqYoog7hhkULYKSX2LdditpkjPcPwXsHq5dLcYr9RBKvv
 KLNsrL2ChPAHc74ANGfRlG/DAlUF+X8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 11:18 AM, Yonggang Luo wrote:
> On Thu, Oct 29, 2026 at 3:06 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/28/2026 11:02 AM, Yonggang Luo wrote:
>>> On Thu, Oct 29, 2026 at 2:25 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/27/2026 10:30 PM, Yonggang Luo wrote:
>>>>> A multi-target binary registers one accel-$cpu_type parent per linked
>>>>> target. accel-target.c is compiled once per target and calls
>>>>> accel_register_cpu_type() with that target's target_arch and
>>>>> CPU_RESOLVING_TYPE. A bool array keyed by SysEmuTarget records which
>>>>> arch already registered. Targets that share one CPU_RESOLVING_TYPE
>>>>> reuse the parent from the earlier arch.
>>>>>
>>>>> test-multi-target checks that each target's accel parent exists after
>>>>> QOM init.
>>>>>
>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>> ---
>>>>>  accel/accel-common.c           | 31 ++++++++++++++++++++++++++++---
>>>>>  accel/accel-internal.h         |  2 ++
>>>>>  accel/accel-target.c           | 21 +++++++++++++++++++++
>>>>>  accel/meson.build              |  1 +
>>>>>  tests/unit/test-multi-target.c | 22 ++++++++++++++++++++++
>>>>>  5 files changed, 74 insertions(+), 3 deletions(-)
>>>>>  create mode 100644 accel/accel-target.c
>>>>>
>>>>> diff --git a/accel/accel-common.c b/accel/accel-common.c
>>>>> index 00a400243f0..0d04b8c5749 100644
>>>>> --- a/accel/accel-common.c
>>>>> +++ b/accel/accel-common.c
>>>>> @@ -130,9 +130,9 @@ static const TypeInfo accel_types[] = {
>>>>>
>>>>>  DEFINE_TYPES(accel_types)
>>>>>
>>>>> -static void register_accel_target_type(void)
>>>>> +static void register_accel_target_type(const char *cpu_type)
>>>>>  {
>>>>> -    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
>>>>> +    g_autofree char *name = g_strconcat("accel-", cpu_type, NULL);
>>>>>      const TypeInfo accel_cpu_type = {
>>>>>          .name = name,
>>>>>          .parent = TYPE_OBJECT,
>>>>> @@ -143,4 +143,29 @@ static void register_accel_target_type(void)
>>>>>      type_register_static(&accel_cpu_type);
>>>>>  }
>>>>>
>>>>> -type_init(register_accel_target_type);
>>>>> +void accel_register_cpu_type(SysEmuTarget arch, const char *cpu_type)
>>>>> +{
>>>>> +    static bool accel_cpu_registered[SYS_EMU_TARGET__MAX];
>>>>> +    static const char *accel_cpu_types[SYS_EMU_TARGET__MAX];
>>>>> +
>>>>> +    if (accel_cpu_registered[arch]) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Keyed by target_arch. Targets that share CPU_RESOLVING_TYPE already
>>>>> +     * have a parent from an earlier target_arch.
>>>>> +     */
>>>>> +    for (int i = 0; i < SYS_EMU_TARGET__MAX; i++) {
>>>>> +        if (accel_cpu_registered[i] &&
>>>>> +            g_str_equal(accel_cpu_types[i], cpu_type)) {
>>>>> +            accel_cpu_registered[arch] = true;
>>>>> +            accel_cpu_types[arch] = cpu_type;
>>>>> +            return;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    accel_cpu_registered[arch] = true;
>>>>> +    accel_cpu_types[arch] = cpu_type;
>>>>> +    register_accel_target_type(cpu_type);
>>>>> +}
>>>>
>>>> No need to do this, just move the whole type registration in
>>>> accel-target.c and type will be present at runtime for all present targets.
>>>
>>> The issue is that CPU_RESOLVING_TYPE is not unique for each
>>> target_arch, you may not realize it.
>>> for example:
>>> arm/aarch64 sharing same
>>> ```
>>> #define TYPE_ARM_CPU "arm-cpu"
>>> #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
>>> ```
>>>
>>
>> Oh right. In this case, the accel-target has to be added once per base
>> architecture (in each target/*/).
> 
> So you mean call register_accel_target_type at each target/$base/cpu.c?
> too much duplicated code scattered.
>

You may need a new file as cpu.c will run for each variant.

>>
>>> And the same name can not be registered twice, that's why this
>>> accel_register_cpu_type should be
>>> in a global shared place. We need accel_cpu_registered/accel_cpu_types
>>> for deduplication.
>>>
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>>
>>>
>>
> 
> 


