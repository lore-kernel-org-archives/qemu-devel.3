Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8B4CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlV6-0001Uz-CD; Mon, 05 Oct 2026 12:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDlV4-0001Uk-3H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:25:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDlUz-0008JW-FS
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:25:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP0LT2014391
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 16:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JiQMXOL8IiKWJSGfdzkZPQGb1Z2PbljBA8tcNw3ywWg=; b=DeOxwqHEvjM/JUpz
 ORawMXqw/gsGv3hjXddGwo3azTMrhRq6rb2gbNx+1sA+nSX/mixtnH9c9nqvRiK+
 AyjHGeKNukVn8KJPxUc7KQAi+P1G0WIzwstq07Id2+3q1Um2F33ac0WXOAilNx45
 Z9Qwtsb4oq4ci4mTX1Jah/FxM3SLxyTb7CEni85EpCHn2nlZHOAei1lb8LjPMxbE
 ncR+/1wAqn4ACRYYi9P1fkJox4S8+tZukXlYp7390G7oBBec5mHfxB0liDqzcyiK
 N78j0VcD+K+g6/lIsQuCWUtUfFRT5+4po+xNtXXj29LvDctNuui1VrazjsBrTRp0
 Y1E6cA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs30cp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 16:25:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3825723eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791217506; x=1791822306; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JiQMXOL8IiKWJSGfdzkZPQGb1Z2PbljBA8tcNw3ywWg=;
 b=cqlNWLjuulwbNUDMzoTtbO0AVm6wLbKc5ZEIAvheiRucae/QW7T5rPdy2mjsxUBKZp
 0hgUREPnHLWPOK4kVOxyuhPv5OhsQocV686dT9LiYwj+a7blOW/p/BHCKtUbT1KKDKrr
 uhdsV2fk9XNqXp/YfiHC+DF98XM2zENR/bzveNYT5A6Qa0tQs2tD+P8G0+PZxfhWvxj9
 MeRJkN/oXKBgdSJeRCAVrT8Wc7ZbZc4m1SFDS99ej27CovrTx90OF9olZ6BsD+5oEEVC
 G9wQgqr8CzP0lG8siW2h5wF5zvO86cuxe7SNEoJvGMclXBp4XEtDo7vJhM6q0iVDejSb
 6D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791217506; x=1791822306;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JiQMXOL8IiKWJSGfdzkZPQGb1Z2PbljBA8tcNw3ywWg=;
 b=HpuQ9Icpz4MZCDjdRkn07eN1asKE8eBg2o1SR1WkBCJUOD89UZNBM4nDwwRNl4MG8x
 tHbP8/pbEVDx73LkqDYX4yKOK6kAQZNp51iybBLhOKdNuJxq77cq8/U8k6Xj//kntuaN
 U9n5mVYrkf81GJzYdqsXQ2NtELA39QaJ9F5ICUJQpyJGORLNA9bGWvoLAU9IqtJjCADs
 4Sbye95yHNniUopLWxuE3gUEX82dLp4V1POnTlL/7TFJtYIN6axr/o/LJ0VGpXx/ek63
 RQDq+ynd2v3x4b0IVJuPzDgr3B+p8+2hkKPET/BiZ5FbjRrDy+HK1aql//DF6wgO7Yt7
 wufw==
X-Gm-Message-State: AFuF++lgU1C86QXFJ0+t4fkTBYB1GiCjvuyh6K0yHp+jWJQyOWcVijZA
 xEaxtjPbjStr1ATFsr7jO+86cdklTp4F0e731MPz1IBiTgZNcUvF9mb15TO+GuqYeVZIeJKseOh
 8/19ynBjGcTup6lopivJUPmiy/K7c4yqsggHKdg8Qn/kGPEnt/43JLvHDeg==
X-Gm-Gg: AYBFou2kHNT2TWCQY/RLbycrToOZjRl7wZ24OfgwnSulivXLSUIDSU37u5IutsXXy87
 fYOkthFBgtAPvOsSqzkXgfDAfYqnDTLm2qjx5J77/raaQvLeyb/uVP2xHO+1tBHE6kBtYjFsYM2
 q+XxC9RiKTi/C+vqYb9b9QiBsElsrnrG01k9sGa8rWvJb4FNBltGfAoxOdaT/PNKmkgY5n6XLyo
 sL3W2aHZ78UN/jOUusc16crS6eTiFxQieM5Md2356Km8U3KoM1hYN1QD5umjxmPUWRzVepaqKOK
 H8EsglAcRDZcAiy+lT4VnJ4gVkgkUTnhhKN3DBp+k11qXN0ewIR8qv3Gi7DFrsqS+OnunHDTcpb
 D6SOIBQQpA1S2TNrmiu1rGDdnJ0io5lyHve/2ZExZM9bLE9zbiGLocgfbqKRvWfDuyvpO1Q==
X-Received: by 2002:a05:7023:a56:10b0:152:92c6:8b0c with SMTP id
 a92af1059eb24-15292c68cb2mr9648480c88.43.1791217505424; 
 Mon, 05 Oct 2026 09:25:05 -0700 (PDT)
X-Received: by 2002:a05:7023:a56:10b0:152:92c6:8b0c with SMTP id
 a92af1059eb24-15292c68cb2mr9648441c88.43.1791217504683; 
 Mon, 05 Oct 2026 09:25:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fd2b2a95sm23467164c88.17.2026.10.05.09.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 09:25:03 -0700 (PDT)
Message-ID: <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 09:25:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mAou9Vgqs7L4tzctQ3128NqQ8epQw4Wp
X-Proofpoint-GUID: mAou9Vgqs7L4tzctQ3128NqQ8epQw4Wp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2NCBTYWx0ZWRfX5fHWNAl4PYUc
 AansaHpE/xeyWZ+A4yT2FoO0/u08RNroRcqCBIaSeBWNajc3Hc2heF96m3DAN5SWglKdOpEUk+Y
 ChZ7YcudIoZSjAtJI45ZWhAe2+m2wz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2NCBTYWx0ZWRfX2gzYcasdiiHA
 G1vomZNaG6G1LxgH8nJ/nncN/RhAC67guJjStob0rttBmt8lz4tErFE+xkPtIF/hcgKWhketP8F
 eg/pDuQeEXrSFgZa6Ren8d1Rbd8aAS8UZPk8+fa/Cm0MP7efnEu5ND/JEAihJTW843dk1ZnKmK5
 DXzyUvWuaLu0j/+w6/CV1n31GoJf+QJLUQudpz4aNiAT4hSARfStCVuYbnqb5DBKPYQeleUMZ7t
 Q/39rSV/Yl/64o9KeMCxM+yu8L2+SSqcKZ9G1j8uKwG1ZhIPKNd0clm1xjqyYeeVCDChlqTxejs
 N/8wlyG+JiT1Y6nLtrFb+AakcJMRV/XGh7IMreaTMk2QFLPoAsGnOGwiQ3ugmiBH6fGagDoukGP
 94tvkzlhXYESfKd914dgEhLaOTwmOs9m8qcszUSZn0i0t6q1m/obviAQUl0hxKIZJDdBGmWEB+l
 GH4Mgq6LcMNeueIYNmw==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac3cf62 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=y1I8XtfQHUGU1im4zcoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050064
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

On 10/5/2026 9:19 AM, Yonggang Luo wrote:
> On Tue, Oct 6, 2026 at 12:12 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/5/2026 9:10 AM, Yonggang Luo wrote:
>>> On Tue, Oct 6, 2026 at 12:03 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/4/2026 12:29 AM, Yonggang Luo wrote:
>>>>> `TARGET_ARCH` identifies a base architecture, not necessarily the full
>>>>> system-emulation target. For example, `mipsel-softmmu` uses `TARGET_ARCH=mips`,
>>>>> which caused `query-target` to report `mips` instead of `mipsel`.
>>>>>
>>>>> Generate `TARGET_SYS_EMU` separately. Softmmu builds use the full target name,
>>>>> as `SysEmuTarget` enumerates system targets. User-mode builds use
>>>>> `TARGET_ARCH`: user target names such as `aarch64_be` and `mipsn32el` do not
>>>>> have corresponding `SysEmuTarget` values. This means `mipsel-linux-user` now
>>>>> reports the base architecture `mips` rather than `mipsel`; its executable name
>>>>> remains unchanged. Initialize `TargetInfo.target_arch` from this token and add
>>>>> a qtest to check the `query-target` result against the target name of the
>>>>> running QEMU binary.
>>>>>
>>>>> Yonggang Luo (4):
>>>>>   Revert "target-info: Statically initialize target_arch"
>>>>>   Revert "meson: Add TARGET_ARCH to config_target_data"
>>>>>   tests/qtest: check query-target architecture
>>>>>   target-info: preserve full softmmu target identity
>>>>>
>>>>>  meson.build            | 11 +++++++++--
>>>>>  target-info-stub.c     |  2 +-
>>>>>  tests/qtest/qmp-test.c | 13 +++++++++++++
>>>>>  3 files changed, 23 insertions(+), 3 deletions(-)
>>>>>
>>>>
>>>> Why should we do this for user binaries? Current work around
>>>> single-binary only concerns system binaries, where all targets are
>>>> correctly covered by what exists.
>>>
>>> From my personal point of view, keeping target_arch as
>>> SYS_EMU_TARGET__MAX for user binaries
>>> is a better option. I am doing this is for replica of commit
>>>
>>
>> Ok, but I'm not sure it answers the why.
>> Could you explain the benefits?
> 
> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary because
> The following original code would return -1 for some user-binary
> +    SysEmuTarget arch = target_info()->target_arch;
> +
> +    if (arch == SYS_EMU_TARGET__MAX) {
> +        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
> +                               &error_abort);
> +    }
> +    return arch;
> So basically assigning any value for the user binary is valid.
> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarget.
> -1 is another option but easy to confuse.
> 
> 
> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> "target-info: Statically initialize target_arch"
> doing that, I am not sure.
>

I guess there is a (good or bad) reason for which sub variants of
targets are not reflected in SYS_EMU_TARGET enum. We should double check
that before doing any change, as it might have other consequences.

> 
>>
>>> "target-info: Statically initialize target_arch"
>>>
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>>
>>>
>>
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo


