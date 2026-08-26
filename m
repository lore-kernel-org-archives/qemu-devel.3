Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1D5C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 23:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzN3U-0003Nz-2F; Wed, 26 Aug 2026 19:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzN3R-0003Nr-R7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 19:29:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzN3Q-0000IW-0k
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 19:29:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdchH2020614
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 23:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wtOcBxEfrUJeZeTj5z1VzkZmQ+zC13s4Kb/SqCP4+W4=; b=UNCeDf2yjmagw+Kn
 EZUc0SQDMilpqTBUSLWzS9NKp0gHvCeBhzgvU4nhlSzk2s9DvKWHr8IxVQpYY0W2
 ZuMxJ6PSkHbwYT0mEg/i5KkBxOLobZEAkY/VCAtOlznma8A1ot6Tz1Sd+9lCTkwJ
 dM58GVSE292yorRznsc9uRuNgdhV1VTWBe+VHlek2OnS2JwFPuzO63VS4211wzds
 Ld+txUTPAhy4hKWo9DOufO3cHDsnrC/JiPD/yF2IQUkjKmdbogq0wkqJqUOAh0wA
 HXpWNdhPPGKbD+4yplWZJc29xTGuKNM/+igaTAfd9rooAfFTmzz4rUaV+tOeaEi3
 tO708Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga075ac1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 23:29:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1d85c012dso212490a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787786949; x=1788391749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wtOcBxEfrUJeZeTj5z1VzkZmQ+zC13s4Kb/SqCP4+W4=;
 b=L8cH/9ZXrQWkeBQz4RCXunUClPIN9UMZdiBdjMpqa6yN8fSInbEOcTZL9mRipYB2k8
 ImEcltl0/c3l1xzZfNkgcMScAJbL28rzOFiMgjbuIAN1I7quVlEmThGmLW9mdKzZnTK8
 SvPsftVdHMxgJOl4fqDcYEnM10zwXK6VGXLFViOBxniSiJJ8yYhgrlu4VpD2ZxkA+Xyu
 32BId1mIAEp/DmOPOnnfFAtCKTVRCIDPFE5PTpHbDbUDEyjidQuBudASZ4CQDCiIdlvk
 ZUF4WfyZf7ou312vtFV52IIPNi3KE7fb99vjQrBU+KC9HG00+vB14VRgMRlXiuOLnxU9
 omlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787786949; x=1788391749;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wtOcBxEfrUJeZeTj5z1VzkZmQ+zC13s4Kb/SqCP4+W4=;
 b=SohxkoyA7dtz4AUhO8jtfouWAQ+r/qtvsUQCm2tN60tumdUfzHrEo1siBK1ox4y5EU
 eOMiHUBkWXtxtC4bq53NY2t8Bvdcn17IxMPzOz1QtFxjVHSpRTCytfgS7E+7+n2UtKtD
 M2dAJ4FoB8dk+C6hor8b0COzg7VO1tbdFwlKZES1Zh+EIZsnF6222RGvNM4B9DS+x4wl
 Q03H28cLk3OdIOL1owCh0RNsFAJJw7SuqNHLbcJOZTn32PnmpDccbW3rRiW701cfdrr9
 8wib3BxRgJ8TouJA8gC79MBAq1y4NP3a9RPp2V3ef+pSx7oZw3HIL/njHyaDAV8hi3YX
 /EfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdGdheDkNj9hX4BqYkICbIOyO7iCFgnK5RLkSlL7seD9grbzvKIIJOnH1IKeiqpQ8O7G8OF/e5oXVo@nongnu.org
X-Gm-Message-State: AFuF++kd16UrBCaW+CZ8bcZ1FIW1uC13ahq9wor8q6yAgKdlFMfQCdOi
 Nty3uTwsLsFKsi++RLW2Um/jKRzH5U50qlDQHkmEgu77injeup5/loEct5R1jiGSYoisd38pcp1
 0w4WhavJ3u1LZAqOxGf4po3Xgoqp9ZS4T0W4rkKskpUbGi1DVwpplzSvhHA==
X-Gm-Gg: AR+sD11miiD74vO0HP6in2eARgoFjWma76bW+fth6bWFUODuZgYuew9GO4LCCl0x7os
 hwPIf4UJxjAQjaLjvdM3Jr5huAY3GvDZo5PHIqsBk1vn66LszOT5soUdMOG6jkFUXBj0C+4WTfp
 CpRw4DCJranWHcjdRLNU3wH+vnsPsmvmsgVIGdDjiSbv46vP1bwr4enKegTLRl70k0kLYJRD62Q
 uy7GD1cR1tJ4gM5nn1qCsxG+8pI2wNuMWtUObcnq6Vs0Ohs1MgsaiAbVv5f+qQxVWI3SV5h7aI4
 C403COcD5O0035RWpHB5S8tLFrXIuw6o0jUOlhhTBHfpiOJq6uOgT5HNGxEtvTcnXZUENzlQnuc
 /iTOdosAQQsRrZnt/WgBjQERzRktMtGjPylpajw2UvVRZubwLkdt6AFJtejYTvqayAEKw
X-Received: by 2002:a05:6a20:93a0:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3cf83341769mr23026554637.7.1787786949026; 
 Wed, 26 Aug 2026 16:29:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:93a0:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3cf83341769mr23026491637.7.1787786948592; 
 Wed, 26 Aug 2026 16:29:08 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d884ca8sm12764532eec.15.2026.08.26.16.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 16:29:08 -0700 (PDT)
Message-ID: <7c0f6c44-6f60-4d3b-8d04-cc3e9aadb5f4@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 16:29:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
 <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
 <anxvMQpZlBUu5SaB@redhat.com>
 <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
 <anyCswBYBZWeMt3I@redhat.com>
 <e40e5a75-cb20-4608-b628-f363068a36ba@oss.qualcomm.com>
 <b0930315-f3b6-4fcd-82ca-11028856c343@oss.qualcomm.com>
 <9292ce2a-6493-41f9-85a0-b6d90f1fdab0@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9292ce2a-6493-41f9-85a0-b6d90f1fdab0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VGeGU6Kp8ktwD4XwPRgYDAdoTI-4XLQ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5OCBTYWx0ZWRfXwVMGvf/2gAhi
 R5SiKlOgoHElpL7MoVpMCGRUrw67AdQfSlDzx90CkkI0JVfF+YaryNa8xIl6cWWf8lsVNQH0ge4
 TS+rviQZstPOW+7pBRMmgHYJ23Xdq5sMIvlcichvamxgGpYRJOb9jv5i+VHV8FQSO32WcG0JyZ4
 4uTn3DZL7sDni6br7nuVBuiqxxFS96/F5TZ3A+dJoEkfJ3WGwSt3DKavkwTDGRERYtbJ+bRLeOI
 icV5bhq9mOKoUnnbiltVV0awY3TMsEcS2OXjjQ9gA6N7OlvUqo5z6DZLngva4p3BvGivAsCHiV3
 YT6TUFliNSGWzRKDKUrmabQoIY2ahszSgmNVwlVjR6f9sfJYobRWsbeOVWZP8tBeJkOHW59sDgM
 A0Hmlr7h60Q9IOyEB5tFQMKtHHCxWc2CbnpRFfCuAOITb/pdoc7x9/HBvN/FNpVfzn0afNswpfF
 wVElC/nRjShkULlRdDg==
X-Proofpoint-GUID: VGeGU6Kp8ktwD4XwPRgYDAdoTI-4XLQ8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5OCBTYWx0ZWRfX5EMQ1iXtkFxg
 a5FEflGV/05TbUtHqTjm93Pfr03YMi7c+GxW/youhxlbmnRUbX3ytStibIgGOUldyP8OSGorz0W
 MwSXfvGb6rYGNe+t13c2+OH4U9fo6XY=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8f76c6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=MY4d_GLGvT-8iD-6k5AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260198
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/26/2026 4:07 PM, Richard Henderson wrote:
> On 8/21/26 16:53, Pierrick Bouvier wrote:
>>>>>>>>> Based on this, I'm much more in favor or 1. The fact availability
>>>>>>>>> information is in the same location than type definition is the
>>>>>>>>> biggest
>>>>>>>>> advantage for me.
>>>>>>>>>
>>>>>>>>> On example given above, this would give something like this:
>>>>>>>>> static const TypeInfo emulated_card_info = {
>>>>>>>>>       .name          = TYPE_EMULATED_CCID,
>>>>>>>>>       .parent        = TYPE_CCID_CARD,
>>>>>>>>>       .instance_size = sizeof(EmulatedState),
>>>>>>>>>       .class_init    = emulated_class_initfn,
>>>>>>>>>       .is_available  = target_config_X,
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> Would that work for you?
>>>>>>>>> Do you have a 3rd way to offer to solve the problem we have?
>>>>>>>> In the case of user creatable objects, we represented a classes'
>>>>>>>> conditional availablity in QAPI schema. For example:
>>>>>>>>
>>>>>>>>    { 'struct': 'InputLinuxProperties',
>>>>>>>>      'data': { 'evdev': 'str',
>>>>>>>>                '*grab_all': 'bool',
>>>>>>>>                '*repeat': 'bool',
>>>>>>>>                '*grab-toggle': 'GrabToggleKeys' },
>>>>>>>>      'if': 'CONFIG_LINUX' }
>>>>>>>>
>>>>>>>> Now this isn't quite a match for what we want, as QAPI schema is
>>>>>>>> common to all targets and used to control the code generator to
>>>>>>>> turn off output. Thus the permitted CONFIG_xxx are only those in
>>>>>>>> config-host.mak, not any from $TARGET-softmmu-config-devices.mak
>>>>>>>>
>>>>>>>> The other scenario in QAPI is the concept of features:
>>>>>>>>
>>>>>>>> { 'struct': 'SevCommonProperties',
>>>>>>>>    'data': { '*sev-device': 'str',
>>>>>>>>              '*cbitpos': 'uint32',
>>>>>>>>              'reduced-phys-bits': 'uint32',
>>>>>>>>              '*kernel-hashes': 'bool' },
>>>>>>>>    'features': ['confidential-guest-reset']}
>>>>>>>>
>>>>>>>> where again we just have a list of named strings. Features are
>>>>>>>> fully
>>>>>>>> dynamic, and crucially they are introspectable so applications can
>>>>>>>> query at runtime what is available.
>>>>>>>>
>>>>>>>> The introspection concept is something that is highly likely to be
>>>>>>>> relevant to our use cases here. If we have a single binary with all
>>>>>>>> types, it would be very valuable to be able to query it once to
>>>>>>>> discover everything in one go, instead of havnig to query it over
>>>>>>>> and over again for each target. That implies the application doing
>>>>>>>> the query needs to be told about per-target usage restrictions on
>>>>>>>> types it is querying.
> 
> Having read through Pierrick's v2, I'm not a fan of inventing a new
> enumeration, creating a switch, calling exactly the functions we could
> have registered directly.
> 
> I think the misunderstanding here, Dan, is that the filter is for the
> non-heterogeneous '-target foo' case.  In the target-foo case, the
> introspection is not highly likely, because we don't have it now.  The
> only point is to have, at the end of registration, exactly the same set
> of classes as we have now.
> 
> The introspection case is perhaps probable in the heterogeneous case,
> where the filtering will not apply.  In the heterogeneous case we just
> register *everything* and let the magic runtime defined machine pick and
> choose.  Thus incorporating the filter into the introspection is
> pointless.  That said, I *suspect* there will be very little in the way
> of introspection at all -- I suspect that users will simply create their
> machine description, attempt to instantiate, and error out if there are
> missing classes.
> 
> Can we please just have a plain callback?
>

Something like:

--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -494,6 +494,7 @@ struct TypeInfo
     void (*class_init)(ObjectClass *klass, const void *data);
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
+    bool (*is_available)(void);
     const InterfaceInfo *interfaces;

And used as:

...
is_available = target_aarch64.
...

We would keep the exact same set of types registered than today.

Would that work for you Richard?

> 
> r~
> 

Regards,
Pierrick

