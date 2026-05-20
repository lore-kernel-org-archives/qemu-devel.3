Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0AECD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 15:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPibz-0004mp-NY; Wed, 20 May 2026 11:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPibx-0004iJ-UE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 11:13:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPibv-0006hZ-Ux
 for qemu-devel@nongnu.org; Wed, 20 May 2026 11:13:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuSJE3680286
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 15:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uiqDFmSF12hV1l/3z70GNLy6Waf8qPMa9wrvakt9KKw=; b=NJ+Ccp+8OKLfHFGF
 JwBJG6UoItUwdrBF7jVQ3BKh70H7YtlDr398Fr0QePnxdKQgnMX1PSal28eHmxRH
 iBmMupLjjzB8f4oNHS5k9DgMWc4/FY+OyPCyV6AyrK22JvLd64KLYLtcGnj37ReP
 eSo+TiQSpvKc9/YibuKA6EQBoU5/HpjhzVn12f1zP6nOjoDnwzGLYIT0ITLXRh0a
 nGp6c5VBw7Ge91/HVMAxZu0t2b3qBp9uj01OaLsN/NcuPVjr2IfWngh7MtSmzvcp
 FR4vks1h9DQjI3oyHweVX/hWO25OSmgC9RxkC77qb3p3QvnYynkw/4QjzYEACs7/
 OJmrew==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j0beh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 15:13:26 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-132d631edaaso31720942c88.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779290005; x=1779894805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uiqDFmSF12hV1l/3z70GNLy6Waf8qPMa9wrvakt9KKw=;
 b=Ibt6kBbwRoh+YQModpwZi50jpqT4sxveT38yH9gs0Q4x5csB1a5nyYImivw/DNZKdP
 NxRULMrvdhgnSt0mk36ztmqxcnvf6bA9zjkSG6UGnZBZ5yRTGbN1gmlRSE2+M9FA1f3H
 TZLBuR2M0mu8dIoL7U04F65CCdGcZH9esv88EA0rQ5DXregmAxHQgCkCIQkhrgeUqAiz
 yPsASeXx7RG5PIRxLlcengd8C3oqHc4Osl6yYAYujmT18xsKdNPjR/bXiCeyqQMJqnBD
 yVOHkcsyDrpJJEZbYL5VQLmqiiH4wvJ2VfUex+bKx5948qLwFX6Y+rHfFE4nSBHKD1YB
 nPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779290005; x=1779894805;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uiqDFmSF12hV1l/3z70GNLy6Waf8qPMa9wrvakt9KKw=;
 b=HFRguL081n9dmyA4z/GYBuQUurMh0Hc1OZhU/i3KhPPuP2vGMyXESRzcSa330lUTSQ
 rE+PLu5i3W3UT5JiPHLy1qcp8iS5n9in+ogGHRH4wAENHQYRgw3RXUDIkK05futg5SO4
 OT9mQgBnNfomkVhb7oMGUdSvG8MLGq6q5oMhZ7UrDoZSnK5ljsnOz3ZZBejITiAXMktE
 jUCgz9nwoRRh7DRVRzxpdXCiaxjzPwMHDXio7aShc5oMkM5fJrpGue69Y1imdBasnfuY
 m0o/uIngw23h9RilnQOJJCGkazJNUWlrDqYWlDySqasliuJMny60NjivspQkZMYZjYeK
 xGFg==
X-Gm-Message-State: AOJu0YyGsoEGnRrGTFzA0nktyBEHMKneFeJFJu7CGh142S/ROHugAwCF
 KnevAZjqhIiUWDxlVDnRQJ1tnVJ11dOTfreC9J8vXwrLU1DSWj8y0Z4delxRc13np7RvWmPBW4y
 1GCng3L7tV+Go7ZVkowrSHCDpKn9IUtFOcICrYgfTpOvgA3FND+FOjA7PyIJdABxcnQ==
X-Gm-Gg: Acq92OFcIg39Zh9di9Ome9TadZIeCWUU4GhSwH6kfeAmRl9qWBIKPyaVi02xS/jfEFq
 Vwoy+7TSc4VgBlbzaclkKkGF/3sUreotSUEgHPewl2PZUrd9PqCnitZWcp/+ge6WFTWqs0wdMJU
 WT60Mjuc7p4+miez5/dWRumBuZvwCmW04lBcxFXHou2DEV6kBxJJUmMMJxcmb7iNx/Jrk2T58CW
 Qz/f/0slv8/KGraP0khm6sWxOB84VMC7/GonYwHXnlTGPSNOCZmRifc3brB9RTgJ7+iy+m7HXNo
 wGiNrv+Hg3gu+T/gbXMK84KrP3aQ2LGMNFrwVizejF8srvBPwd/+/7LEBB17ohPkFh4mT3h9noI
 3c29jbtuMmk9gfgMWIHbMK8cBjiuRpxarNKlxfB1WlqNKWtUh51x0I5Hxaeaj8qGbZQ==
X-Received: by 2002:a05:7022:ead3:b0:130:6904:e817 with SMTP id
 a92af1059eb24-13504a52c62mr10209535c88.39.1779290005076; 
 Wed, 20 May 2026 08:13:25 -0700 (PDT)
X-Received: by 2002:a05:7022:ead3:b0:130:6904:e817 with SMTP id
 a92af1059eb24-13504a52c62mr10209525c88.39.1779290004450; 
 Wed, 20 May 2026 08:13:24 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb93f3sm27381140c88.3.2026.05.20.08.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 08:13:24 -0700 (PDT)
Message-ID: <2e4a55b8-f47f-4c93-a592-6cf0c4ee7361@oss.qualcomm.com>
Date: Wed, 20 May 2026 10:13:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260520123947.12711-1-philmd@linaro.org>
 <87fr3ms0oi.fsf@pond.sub.org>
 <f52ebf28-1921-4ada-a7c5-ec3342cd3acb@linaro.org>
 <57f7a25a-dce1-452f-8529-187d66a6d8de@linaro.org>
 <87fr3mkz26.fsf@pond.sub.org>
 <8bf4fb20-d675-4569-92c2-b8921b2991e4@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8bf4fb20-d675-4569-92c2-b8921b2991e4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dcf96 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=qCV0K8a36pde3p9_Zp0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mwQpP0Ok1BJiCrC1ELxppKHbMMGYaIXf
X-Proofpoint-ORIG-GUID: mwQpP0Ok1BJiCrC1ELxppKHbMMGYaIXf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0OCBTYWx0ZWRfXwmm+hZXSBTJp
 Js0iE+f1iHBIKC4zvmAvw7HKRPUNpUQ1G2E5LE7lp56xo8WMB3s2dM/TifMsPpFxxmV/IPRfoDo
 wmz/T8dl0b05iaE0M59ub8iQujlKKoAA1S8tpvsCSwRnJqDK41OcfS8fU4uTEZK6CEvUDr98oco
 DY+jt+WDT8zUuC/34e5pFL32aZJKpOz343Z/zi5SBMzQGOp4Ud5kBukqySZFvzxs6jOnDX8myMI
 XMZCyPDEV+59LchAhi8fL4EJlcIIGG05BGim+KNTafJGVs9xH2CiEFq4jpqPRjkIhwb38bWiKDz
 M2Rwxgg617tOcdh5dI5tszQq4cu9kBAFwq+5SP9K1Y+eZhx9Yf0kF5ScZTQf+HhLDFRRY5+a1oT
 eqIcBqku3L0HVSLFx+JG3FMnfl3vzPLNBYamImSi4yEzoxKDShr6Ag8Rxg27B6HHSJ1ZPob/WyX
 +Jy7kYNO9+LHpCozK+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200148
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

On 5/20/2026 9:05 AM, Philippe Mathieu-Daudé wrote:
> On 20/5/26 15:09, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> On 20/5/26 14:57, Philippe Mathieu-Daudé wrote:
>>>> On 20/5/26 14:52, Markus Armbruster wrote:
>>>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>>>
>>>>>> Fixes: 812b31d3f91 ("configs: rename default-configs to configs
>>>>>> and reorganise")
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>    MAINTAINERS | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index b75f3222f2f..2a4d124fb3c 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
>>>>>>    F: linux-user/hexagon/
>>>>>>    F: tests/tcg/hexagon/
>>>>>>    F: disas/hexagon.c
>>>>>> -F: configs/targets/hexagon-linux-user/default.mak
>>>>>> +F: configs/targets/hexagon-linux-user.mak
>>>>>>    F: docker/dockerfiles/debian-hexagon-cross.docker
>>>>>
>>>>> This one's wrong, too.
>>>> Already fixed in Alex's tree:
>>>> https://lore.kernel.org/qemu-devel/20260518102222.80735-2-
>>>> philmd@linaro.org/
>>>> Pierrick suggested to repost patch dependencies already queued in
>>>> maintainer tree when posting series; while this seem counter
>>>> productive it could indeed have saved us time.
>>>>
>>>>> I have an unsent patch fixing both.  In fact, I have an unsent series
>>>>> fixing *all* F: patterns that don't resolve to any file.
>>>
>>> I looked for your series without success, then realized you mentioned
>>> it is "unsent". This patch is still valid then.
>>
>> Yes.
>>
>>>                                                  Why mention unsent
>>> work?
>>
>> To avoid duplicated work.
> 
> I'm not sure this thread is making sense o_O
> 
> Let's try to figure what you meant here. I'm not racing to get
> this patch in nor enjoying duplicating work, but this is the
> mailing list rules (due to the intrinsic email workflow latency,
> not to mention subscriber processing their INBOX in FIFO mode).
> 
> See for example last week at least 3 developers fixed the same
> GCC warning issue. Generically, how could we improve that?
>

Ideally, by merging such fixes faster (in one hour, not N days).
More realistically, having a daily CI job that tests latest (stable)
version of compilers before they hit stable distros. This way, all build
issues/warnings would never impact anyone.

For some bugs, some duplication is inevitable, but it should 99% of
those easy build fixes.

For the rest, sending "unsent" work seems like an easy fix :).

Regards,
Pierrick

