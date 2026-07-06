Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91486C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdpL-0007rY-R3; Mon, 06 Jul 2026 03:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdpJ-0007rP-QO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:33:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdpH-000259-UY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:33:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6667C4Mi3845005
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2RRukHA7gxZyW4cUrj1MNF5dwXHqQ3MfixQDf+PPxPE=; b=TztC14+usAZRZ/5X
 MO737LztTILk90Tt9Dc4/VxUCWVWuamPascgh9G7A+EW3/fVX9dhb9FYTZBXFoww
 qT13H0nslTK2dvVGrV57Y5gaAR74vwz7DBEVwR0mTft57UCSqJS/m/ywALgF/YZZ
 /UU1Fv7+ChW+SaZ5V8BSmxFAz2Z2cPQbpNBmS0hzNk6cVU1EqL33ODWpN5B9uCZY
 xBmfewASI2x9wFeV3zcBu0v6KyeFilScetjyhpKLu6ba5Iqw0fu+S5aiyBBPKRaz
 /96c1xhtbXQS98CbksqXkcXxndLkeCuPyhXhpIEs2GIgHjcKgFfrweBYP8h1ehfM
 0vD8Fw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxr2q4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:33:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e538afe65so256032085a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783323189; x=1783927989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2RRukHA7gxZyW4cUrj1MNF5dwXHqQ3MfixQDf+PPxPE=;
 b=Dwzl0m9fA39c2o5VL0+BuiRsNFSG6M+YT237VK6RyLqICjSAUz89ixkxgOVoiDPNSg
 I6PsWNve0YsID2MhvOAf828UW33NwJCWGXEdQIyJrAWlnlYrfZlhp1mJtEjIP5kRKgEJ
 UJUqSAvtEsR4FEyUsAb1Alk9y3bBwWMDJIFazuwFY0SqvtrJUiH3jD4OjHet+s30t27c
 X6ZN32TBOgzPjt5YXGN3d4m/ov1aKtffx2VsPwTc07u05Izlue1ww8ijZ/ogEUsrXhS+
 XWCoABdEFtkCj3qiAWQVaDWF7WCtOxrEnjMzG7Mu0NsH3LmsjBA9vaJ9aj/85rMho1Cg
 tYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783323189; x=1783927989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2RRukHA7gxZyW4cUrj1MNF5dwXHqQ3MfixQDf+PPxPE=;
 b=m6UmIch+chQqK/jbcy9aHxIElz5LW+td4me9auTDayMXsEY8Tn1F9PlctkumPMBob2
 ro3NcnYyv8AsHvTiR7Wn7dACLY/jckLbblrLAPvB/kTFAphatFr81wo60dmECl3l9162
 YhfCojm60cVDVqbG2sPiAyticWW3sbEwrT++iAevjW2+dP8Sj5UCxZCJiz+ZeTZ7C+Dd
 9kk46dCY7cSSgvUfEkoAP2pWSqIfkyEW1nN6VYGLGeZnWp9vTZF1IdQikTwP06YvUhJ/
 U6GiLtjrD5QiycS4NxgGTnnYn5xLKQpRvyFAFKNIyZr2cNidQ9Xp4E6VVS1Q9Xb9OVEC
 DQJw==
X-Gm-Message-State: AOJu0Yw4IvVLmBt/6pwvvN7Du3iXUYZL1lYbhormiz/Ov15DR5Ii3CoV
 a4/bqCnwt0gvOu2+nJ3miUN5gs+b8GTVmDEvxenfLAi/MeaLPnTYKceRttLpTYwziAhyuz6XMvC
 h8u34wpOAud61YT2HTZ1mQj/frEVqWHLXQMViE8wMZrPaYMOt8naOsozLvw==
X-Gm-Gg: AfdE7cnQxUwUPFQDEUz5PNbWLpDkcOppQUwFBt1KDRxt8NI7pYkGx47kOZgbrgO0h/l
 HHy2yrweyZfn0jT4F5i83R4WphCLmVcE2LPQm0DRhkNp7PxA0s+b1/5VH0iU0YVSoUvuRpAeJcn
 WpCFuZu1wPQCwkPc/T1fDD63tbW6AOZAubScx++3pY/Cbb3B2hhYH5RV06XkI2BfQBd7JH2+8fy
 /HYZgLRdHlSqzISu/GnStHOyNYgEqHEnPc+PBrKL4c97mvgXHhnP0W+77XPUxQOzVqL4JhSBOYC
 cpEnbGa6mENCHDuPW46VJONagWip6pFSioS8Gv7Oa6CadAgojPfumnDZDtdaWIj67PGAPUKGPX/
 goVZgpbX1lAS6G2l9WMlOlGX2jQ+I7zJHP+Peadws4+jG8oOrxwGd5t5ZccrwQQ==
X-Received: by 2002:a05:620a:4087:b0:92e:5cfd:154c with SMTP id
 af79cd13be357-92e9a4ed889mr1255801285a.53.1783323189240; 
 Mon, 06 Jul 2026 00:33:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4087:b0:92e:5cfd:154c with SMTP id
 af79cd13be357-92e9a4ed889mr1255800185a.53.1783323188812; 
 Mon, 06 Jul 2026 00:33:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm23438533f8f.26.2026.07.06.00.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:33:08 -0700 (PDT)
Message-ID: <a7a19a9c-8280-4c11-803f-bc846280e279@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs/system: rewrite gdb breakpoint and watchpoint
 explanation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260626094237.3788189-1-alex.bennee@linaro.org>
 <CAFEAcA-LvWsadHomHBNzjUatsiU1sDg85V4gTCDTpoDJE+EXuw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-LvWsadHomHBNzjUatsiU1sDg85V4gTCDTpoDJE+EXuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PccZRTrbibzmydAFSoYmAicuqTCWtLgu
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4b5a36 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=FzVvuSu8mCvtmyl0nhkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3NCBTYWx0ZWRfX8MUBu0d17rCE
 3Q7RW49D5S0VLQf1eYCafD7S2DiTY18jKoygJvmZO7QtPWM3LCfMH/2jdkBaymJTRuq9ujhD7Tm
 A0Rw39mIpCCfOM82IM616XBtgImubRc=
X-Proofpoint-GUID: PccZRTrbibzmydAFSoYmAicuqTCWtLgu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3NCBTYWx0ZWRfX7alPvyxxJtYW
 1uLWjnxPpam7TFfo1SIJKB91TSglf+FoAHEUD/M4MBU9EkLdRxeIQKWBo+YD3Hcot/vEcHY0xd4
 ceZp96krVQNslw7SjnFUCkLV7qd8iLma0uM6YyHbkGF2J9UeSWJBNT3BEfV6hYu7IPT5Ef0MgI0
 E4FVPG29HK57dJextuolYI9KrybygSN/KcvjJp0oEenurugQzPn1BbuMMCBkcifz5LG0GDGBKSL
 pArgW5y1ROpo//j+tNROMR3gmIaabbgKzH5Dg0yNO1U6Q/+SXNRH4YaUE7HihLlzeyxYoU+a6ZO
 pzG/GKs7hoUQIEMtyQtt5lQigXVuMZU7NH9WJS76vxNbEe9ql/7Uvu5kiFa7s/xjJoinA9pkHeL
 YI8aNPiVUKpgCVkFKCcVSjRHDHgxndedmM7ldBGjL/FGQXdXoeqlwk2Ub66vA61LPmfp8ee7Yrm
 GbmzxgK9ZKVmuzMiVgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 26/6/26 15:47, Peter Maydell wrote:
> On Fri, 26 Jun 2026 at 10:43, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> There are a couple of gotchas we should point out:
>>
>>    - software breakpoints can fail on early boot
>>    - TCG treats all breakpoints as "hardware" breakpoints
>>
>> Rewrite the text to explain this more clearly and call out the gotchas
>> in a Note! section.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3596
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   docs/system/gdb.rst | 35 ++++++++++++++++++++++++++---------
>>   1 file changed, 26 insertions(+), 9 deletions(-)


>   Due to the TCG accelerators complete control
>> +  of the system all breakpoints are treated as hardware breakpoints
>> +  and the number of them available is for all intents and purposes
>> +  infinite.
> 
> I think this bit about TCG should be a separate "note::".
> 
> Maybe rephrase it something like:
> 
> If you are using the TCG accelerator, there is no limit on the
> number of hardware breakpoints, and QEMU handles requests for
> both software and hardware breakpoints identically, as if they
> were hardware breakpoints.
> 
> ?
> 
>> +
>> +Watchpoints allow the debugger to watch for reads and writes to
>> +various memory locations. The number of watchpoints available will be
>> +a factor of the architecture and support of the accelerator. For the
>> +TCG accelerator running system emulation we can support as many
>> +watchpoints as memory allows. As TCG cannot track all memory accesses
>> +in user-mode there is no support for watchpoints in that mode.

I noticed and reviewed v2, but wanted to clarify here, if we ever get
SoftMMU in user-mode then we won't have this restriction.

