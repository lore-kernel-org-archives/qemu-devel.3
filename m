Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280ACFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJuuZ-0002XQ-8y; Mon, 04 May 2026 11:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJuuX-0002X3-Jg
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:08:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJuuV-0007IF-UV
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:08:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644B4JXb771426
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 15:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fnnEdttfIc21uIqaYc0xeYVzsUTBbNgaI1HwALGu0cU=; b=EQxpbNtyFPYCMIb8
 h5cze+UedB89ipKpq2dr2aEHVDRvf6w8TnHGMS4h667kQFASQEnqUaKH8EG3l2R3
 Z0O8gn34fddIT/ljuolvKojjh4u0ZtZzIP8n5kyjENZvGxebqFZpb0QO1xoMfrPO
 LHTMWxNSzm9Y7zrN5/7MBy/2n6CH7w/p/hFqP0hBVB0LXRFVrYgvPUhqtGiI8/aV
 lxeuF+Ajnh2Zz45IRl97YbHjLTrmec7oWOSwQUBUr4mS6ozQ95s/h8WH9u98Jagd
 QBgpLOLCTInz4zf5HfYn18ziMg4bS05jVM9X9kW8KnVHbXE6tl0bvJVlj2cczKnw
 4jm1OQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaejp5yk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 15:08:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2eebb099efbso6477608eec.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777907316; x=1778512116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fnnEdttfIc21uIqaYc0xeYVzsUTBbNgaI1HwALGu0cU=;
 b=IL09xORSwicxPaah5JW5RcdCcjoQYvjsd32/BCM6Ik4bm8DM0YI8FiwVHJqcZ32nN+
 CM4UohHuqw5S3lsSWB3sAHcB5601eLskLhgAtArqTZKWIeftP8bW/FnfdUH7GnFgfdN9
 OLhdoi85JrdLspLJoTtRWMhvhVHmg8M/p+VXbmdvRJSuXbDu5UnMxB06X7E+g3CFn3r2
 YXDTz0bIca0ntmPxtvTNqFqIFfnthnjVx2Xme1+pcxOpCUeDQjn43ALyu09VqLA2Sho/
 upasnDiIV6BiMhbl06qSHVovC5TW4q8COdqZLGtERv5uEBV03McwlypXCWy5W5RxrnOP
 kohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777907316; x=1778512116;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnnEdttfIc21uIqaYc0xeYVzsUTBbNgaI1HwALGu0cU=;
 b=s0IfSilGa56VjrUd50EVLnmBSA7pDj7AlyyETN3i00geU+OLzx0J+OXd0Sj17khy7w
 z0TF5sgzBvf6kxGYSm1HqRsPiawRNpaJnmL357T8HjkcVtySi/q5aAQ+ULGbE6Yr3DYf
 YYKtuStjB+ttN5KZZrs1IuJrqd3z8DYfJl+lLssn4/gDenMGnSeTEeRMeU0fHevkEGUP
 ljAhp5tNOUDH/mKF82MB9+ybHGTE8aqlP14Xnp26NP9qcPCl24AWP0LwuNylbnV3JquK
 MGE1ak/IeEclQ/ipFqbSYDW/x6WSbGrjdgq2Hd0kxNGDJrzKnnoFryGXZMPQb4feAu9J
 LQDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/t17j392474iOrdubdFxDtL3ZwRoLS0EeLJzAgn6evI190hcignACPxubimwDemSN1Ust1EeblhSGP@nongnu.org
X-Gm-Message-State: AOJu0YzN0Wr+oAN0cdbMOcAJgclt4HQQC6xuf8iHojfP1wbjAhkk9MZK
 CmlwBgSIwF+8gBKf96i5qxyTV55derCfBkJjTyUPpN7bSsMm/OPdZsyVl3Q/W0dfQenlVzJMGSZ
 lm1EXvwKDhXT24Hu31hqzxa6i7M6RBdlIfzfzrcx3JC7YYxO6fk8u+SX8yw==
X-Gm-Gg: AeBDievdRVL4vQybpVD3bGAG8fcTVJlX6Arauy0CwqKRycGMwMtoVNXPSUXWAchTAST
 8o08CjTQZ7uFtoyNZrYjcqWmkIP8KBCq+cfMugC+d9E7M9ToHO1Iec96mOn/Edc+fBWClR3QsO6
 pHltKZvJQC47udaDbWOsuRN1H67r9Lwez56FKG9mpKFrBXJGgygt3eOqpQy9c5dxQnFoTfbveyC
 xbkFz24oEqBsFUHVu6lLFGUpUjzfzhqgmaMkwenKsfwVxzUHaHOsxkEUzaCHtw43DQrnQdJ32jw
 WttsthScRsxyV4QVbGzDXU8b0yi6XlHb0Ap1Qy0yvP7vs4JDkDwGmVWjAj66cgbRby/YZKIUmMD
 k4BYYTpZFQWWZx2mevwU7q/NIjcg5gfeq931T7aobi1j2RKJiffkN+cfi04dTSm8fC6D7CiN56d
 jiLJT7Z/NNI5Jr+EEBG5ZlfXyK
X-Received: by 2002:a05:7300:570b:b0:2ce:f3d7:221 with SMTP id
 5a478bee46e88-2efb99a1503mr4618387eec.17.1777907316260; 
 Mon, 04 May 2026 08:08:36 -0700 (PDT)
X-Received: by 2002:a05:7300:570b:b0:2ce:f3d7:221 with SMTP id
 5a478bee46e88-2efb99a1503mr4618363eec.17.1777907315691; 
 Mon, 04 May 2026 08:08:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38e71cedsm19313323eec.9.2026.05.04.08.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:08:34 -0700 (PDT)
Message-ID: <3cc5256b-d1b8-4c2c-ab7d-4c345b860e2e@oss.qualcomm.com>
Date: Mon, 4 May 2026 08:08:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] qemu/module: add a new QOM_EARLY init step
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430203842.29156-2-pierrick.bouvier@oss.qualcomm.com>
 <75c8fcab-61eb-4c27-ad10-0180f335e85c@linaro.org>
 <1592077a-28c4-4575-8f47-8b3fbf49c112@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1592077a-28c4-4575-8f47-8b3fbf49c112@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MSBTYWx0ZWRfX/kCab+62GO9h
 Mbu0I15r6SxLG9xPW2aCaXvdjUX9IuTG9ROHD1eoeZ4XlQGpEqmmul6Et+gnbwpGiAL+90Up0Nq
 J1neiqehB+CuBvfE7IhvejPtcVJftduLASvT5BB5bLcoEefm1Wo72xbRJeq0m8QICDUzxa+odlL
 mYp1P7lWcSPqLg6AJuHfVZWv2/BsqjdDK6Bz9L8U4UbHV4gTSI0HylF5wufhPMmb/+pt6roxmCL
 fThhKYQ2fNi9MFPuwlNHEAKkNEUxRONGwmdOjXgNlt+0F0HwKisDdqm6A3YNqrZo7loSh+xB+kk
 vK/gAU7s8NFi3WscKfVjmWisEWys8mKFRTrTfk/XfyKYuyd5erQu42Wechz4Yal9mBcUqhXpI+Y
 65kbg6WZFWTosHAcYHL5uZ3rEvIveZR+iCEsCNZwr+SbU+AkWCns2fRXRRaZVTE44S9eChZjdVw
 u3B95/j/RFmo9yo7o9w==
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f8b675 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=96Nzv7qHb7vBX3kg6fIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: T8ow-OTTYW4as4UJYQgaeEkPMtOGqhge
X-Proofpoint-GUID: T8ow-OTTYW4as4UJYQgaeEkPMtOGqhge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040151
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

On 4/30/2026 2:48 PM, Pierrick Bouvier wrote:
> On 4/30/2026 2:11 PM, Philippe Mathieu-Daudé wrote:
>> On 30/4/26 22:38, Pierrick Bouvier wrote:
>>> This step will be used to initialize fundamental QOM types, like OBJECT,
>>> INTERFACE or TARGET_INFO that will be introduced in this series. It may
>>> be used in the future if needed.
>>>
>>> We need to patch all call sites to module_init(MODULE_INIT_QOM) to call
>>> module_init(MODULE_INIT_QOM_EARLY) as well.
>>
>> Just wondering, could we add some module_type dependency, so
>> when module_call_init(MODULE_INIT_QOM) is called and
>> modules_init_done[MODULE_INIT_QOM_EARLY] is not set, then
>> it calls module_call_init(MODULE_INIT_QOM_EARLY) first.
>> Modifying module.c for that is trivial, but I couldn't find
>> where to register such dependency (keeping module.c generic).
>>
> 
> I was not too fond of introducing this "early" concept precisely because
> I felt this commit was going to be quite ugly.
> 
> If we go down the rabbit hold of adding such implicit dependencies, I
> think I really prefer to switch back to original INIT_TARGET_INFO and
> static registration for OBJECT/INTERFACE. It's simple, clear, and does
> not require patching 50 lines in 40 files.
> For the last 15 years, QOM didn't need any early step, and now it seems
> it's a new mandatory thing to be future proof.
> 
> I'll let Daniel pick the solution he prefers, between current commit and
> reverting back to v2.
>

Daniel, what would you prefer from here?

Regards,
Pierrick

