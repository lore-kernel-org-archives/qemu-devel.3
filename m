Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55921C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woco6-0002eE-BK; Tue, 28 Jul 2026 04:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woco2-0002dx-VN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:04:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woco1-00049h-Ao
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:04:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82LCA2359345
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JUvKzoPPJSQEXNprtt+v9VLTLYYz09gPzOrP3XnFb0M=; b=Jbk4TJXVKZX2B5jl
 QQE56do+WUxTT0oIfXws3X8n+v3KOBmRzeNCLVjF56Yv2+uYZyAfcyzfuYZ+vKq9
 wIyQ/nyaGjSp5oLmvlqsNjV2pB6cA/uzy2hFzcrcy+RUPbTpZJkhavsF+l7jg/FO
 2Cm25yuACyyO/N/3ZZrm1B/mChoSSldRk6anUqOKrL8eQJPNGsjeRND3dMUG/b+H
 eOe9FWQhDT32d82zGWrjoBPxV6AOPeePbfNeGk8XVDHO2Jb2PKTN+oa3SLNJxjZE
 5VAR0f7+fVCTJvmqndUn31pMt9FfxUoWejDeJbgOrDczViKwU27kfuzMRPx3GlKX
 UQk9kQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y0uxr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:04:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cceabd70f5so100601825ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785225891; x=1785830691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JUvKzoPPJSQEXNprtt+v9VLTLYYz09gPzOrP3XnFb0M=;
 b=e99br2VYc2b6atWYHRuRe3kU3vJEgnSOoeY13Y6kUJR0Cj3lystKQ/8rd8itk4ueLm
 g6RzKEdD3UbXng5KAoxS75hp1QqMS6jsPFAmU+JrBeJYns1XmMb9XY+z6Y2+xBgU4uY7
 f4x2UOocfDLgYp6usj3t91++yg9nmrx87RthCZ7coSpcnexukmjzMY7uePFRnR8Hkg2U
 JwWUu6esqVL0DG+KuDQWWXXDwV7QONIMEZpG/4xC9Yn7u2GcGIow+ZM/hLi62xy9QuET
 +IJlhB5LFCMeqxqoKte0MjATdWDquY3ifr+iWeF1AgbcvvzKV5ybMMUQDaDbj4sxAPs7
 ZPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785225891; x=1785830691;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUvKzoPPJSQEXNprtt+v9VLTLYYz09gPzOrP3XnFb0M=;
 b=D/GNLY/mrjJNYWOsOAUYEdtbebARmXfjsct55wtO38DKaXJuHHj3Vk4j8eETfDjjUB
 IT3kJ2UeyDpRjlNZyTRu5m9vVHfEfg+ax+2W+Pjcz8yvY1rrQmWzrRC3eqRl9dwAbu1x
 qIIxzNgM/SIXEXGP9IKTAnoyURnBoPgK75N3dSj5NcBckx9x3ZdEyb0oK4PyXjfQZJ6+
 yFmtGk9W5K7TVBxy4+6rQu+BGhMTyiQROBAqQM9Ydd9crBNhT0fEzdOPq1YB5fBtDs7S
 9ZdK6H2EtYsXwZcG4Z45d/XjCoFZ3fXpr+f/E77JwP0kO2t1XL7XJCrYzHf6Kvjozcuy
 z6+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc86gBEQkJW8LHP6Kp8EfuFkulw7lQDMvoPHpqlvUQKgfxfOUoTdJ0Ytv+S4NDzRDet6DiEChXw4/m@nongnu.org
X-Gm-Message-State: AOJu0Yxbo19Jny/PvzcvMhmSyv6sg84y/C9NTuRJ+Y6j4IJN6PYg5U1m
 Syeqm3AAnQ2oJCz5y7kxXx165p8XgBg8sByZ187YtzPbOBGZZ7oOSTgtXqmFtQlgqsJGbcvjV/B
 sp4WZQYHjpnWw3KUCy1qiAoYqmGBxjQIT4qTYnu7OCCuDS4uQJiFJHOee6w==
X-Gm-Gg: AR+sD125pYFj/eNdpIaE+YHgkfXQ13URvrqWd+808lWitEruA8Pwu8HnM6UIbc4Vfuc
 lqrLp82NSiggOLyrWTxWWhgUuPfX32VBk0q9Jrf0ZlvGbhQMP6sSOFdgt1k1oLmmS7fJDjSbg0g
 nhbatx7uZhDumQQ8DHe2V06rR5Z2N5/6tmXYmRTOeg5TWzWYWV+P2jlpDmXXhlLrf7IN7d/e4rQ
 qwskcgcltmwkLDlUXTUMvIKBZhDW3ER9lfmpztVxWhd/K/+wa0KiW8cl2J2nlED4+bA/GgQzsKX
 MNa6cNVJoMwF6o6rMa3nSE3dH5VWIseA7/DmDmwRQyYGglegLddLIRE3kBTq+JPZCUt0yiygXOK
 vwefMXalBEgM7XGwMI8d3SDERL8f+FUq50J7g5Ej6xOjoFotCNANUMuw=
X-Received: by 2002:a17:902:cf01:b0:2ca:61bc:317c with SMTP id
 d9443c01a7336-2d015d0b76emr14139915ad.13.1785225891142; 
 Tue, 28 Jul 2026 01:04:51 -0700 (PDT)
X-Received: by 2002:a17:902:cf01:b0:2ca:61bc:317c with SMTP id
 d9443c01a7336-2d015d0b76emr14139665ad.13.1785225890721; 
 Tue, 28 Jul 2026 01:04:50 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7ee6b0sm47684655ad.63.2026.07.28.01.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:04:50 -0700 (PDT)
Message-ID: <78918898-6037-464c-9bf0-19125714834c@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 01:04:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 000/103] tests/tcg: run tests with meson
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <02bde797-6c3c-4c3f-aa82-121e20360866@oss.qualcomm.com>
 <a3f1ed53-435e-4dde-93db-f526459d83e5@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <a3f1ed53-435e-4dde-93db-f526459d83e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a6862a4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=tMYrcRadqa5rf7f6NCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OCBTYWx0ZWRfX8TFLsGyiAOFL
 WXDTw+rbg0h+xnlncX4/0bbl1ep5KZitBiYkfTkBSoULFGHo/khuLbiPszDj065s47ziiqJsd8W
 JrSzyBurm7PJdqAfwa5Q0BSwj4sGc6o=
X-Proofpoint-ORIG-GUID: wrY4Ty-MRWWajTnOhFFWI7ZjjDBe9a78
X-Proofpoint-GUID: wrY4Ty-MRWWajTnOhFFWI7ZjjDBe9a78
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OCBTYWx0ZWRfX7gZ+F2x8rA/i
 aWwGdhJlXTgGGGriRHNo/PD/loiJX3hm7k3fYNmMH6Su9fFXBRtijbtRDpokv5BnxNJdVEW6iot
 H5SrD/bM2yOVKjSTe0I6aByaruLAwlB1jEP0mH+31XmpJB09dPPzM8JTUI5PDEoSzA4kxVNrjpB
 qs5Z5EIBTJDUEDu5zaqHZRt8jcupMMwAN8ijRwaWMWYxlF+VqDVaru/FsfhrN/6oN41PjRP9N7L
 fOax7yZRclcbutULSht5+i3inObzMgU4RcMsCwowdht4yKz8w+m+Bdydn+o1QCvz9bCLtonr0r5
 GicCfn2CnDcf5WrOXG7+xL6dLcrAjhzIs5S8KRGsuIAn40Tmk2xJYeREEDF5hIfUTf3VSgkUxBU
 cP0y9DU1CkLIEORVsG8ngSVVu+M3FAh1eRSAhY6OrWzDDvcq/ljQAAh9zoI0PC9Fn+I8I1vtgP4
 sJAc2ANY8FHx7FJnOJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280068
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

On 7/28/26 12:41 AM, Philippe Mathieu-Daudé wrote:
> On 28/7/26 06:58, Pierrick Bouvier wrote:
>> On 7/27/2026 9:41 PM, Pierrick Bouvier wrote:
>>> This series replaces TCG tests makefiles with meson, with the
>>> goal of having something more readable and maintainable in the long term.
>>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>>> them with meson directly.
>>>
>>
>> General patches still needing for review:
>> - 4
>> - 29
>> - 96-103 (new patches for configure + makefile removal)
>>
>> Also, most of arch files still need review. If you maintain one of these
>> archs, you can take a look as the series is now almost ready and there
>> should not be any significant syntax changes, so it's safe to spend your
>> time on it.
> 
> IIUC we don't want to partially apply this series. What is the plan
> if archs are left unreviewed?

I'm trying first to get all the "common/framework" part to be reviewed, 
so this part is ready. Once done, I'll email the concerned maintainers 
weekly until we get the full series reviewed. Then, it can hopefully be 
merged quickly before it goes into a new conflict with Makefiles.

Since most of the arch code is just a mirror of existing Makefiles, 
anyone is welcome also to review it. It should just take a few minutes 
per patch to make sure every entry is present in the new meson.build. 
There are ~60 patches: if 3 people help, it should take ~3h of review 
time per people. 1h per week, and before trunk reopen it could be ready.

It's not too much a problem to maintain on my side since I see the new 
conflicts when original Makefiles are modified (thus detecting test 
additions). Usually as trivial as adding one new line to add the test.

Regards,
Pierrick

