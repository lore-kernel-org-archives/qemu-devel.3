Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A81E64AB6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUPk-0007ja-8C; Tue, 03 Dec 2024 10:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tIUPj-0007hn-6h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:02:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tIUPf-0003XZ-9N
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:02:10 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3E5mnI020044
 for <qemu-devel@nongnu.org>; Tue, 3 Dec 2024 15:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0QRuMr/Lfpvfj4fJvGCIYOswyEK6/mWfdLPMEpGH2a4=; b=ByAFgAl981lI+pbu
 M+4VXolv9shjPSqWT5JmmgsCszJ4rdL0Ps6pbzPQMVoyy9QWyaOsR9f7Yp9Cafh5
 rzwoqpp/ImL3rw7QVUlwGTRB82qIuiQU1YkrEWUjg7ZaeH9NbY3fNlq3W1Yluls3
 xArLJQgFSgp9+uzD2AiZbIXPvx7blLwWgHg1KGscn2OwOYSWBWsCFx7JCeRr/rNR
 Clnr1z/VjdAMjUzUbuECRO/J0P30hvAbrDizc2cd/CLRAztsi57NXwyYZy05fWVg
 SMQn47B+G+iWTnsw5lMdeSLxT20nHa4k97oSsaeFYhDBwXWyY17tg1P5aWBsHbdN
 PgUrdw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3ex844e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:02:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d87cf1f89cso97616686d6.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733238119; x=1733842919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0QRuMr/Lfpvfj4fJvGCIYOswyEK6/mWfdLPMEpGH2a4=;
 b=BB0y7mNEZOv93g+yJocF0ln2h0uYChiHoQnBa77NG5gnAJS1esHxomnxXuV2CNNwz1
 KiwHObSKez5IIiHPj4uGjXnP4yBLQY1vjYkVLxr7UzJ9cAhrxIw25vUdQdm+7wXHPo+e
 k1yX/Am7nM2+NAc8+rC+lrB1Qh4RXmvXvc5Yw02OJWctNrs5LSp1/BtvtEZE/9cLQ0zc
 OKghrW+GGqD11n9b4VPdr/EQAzHxUGLHE4j3BSZS+QItd+sDbgyK0ObPyaFJMeXJ3s3S
 BVcKgsJxNsSYrqt/ln0Ak9/nH01uHGIiBormhSzRozY+DJiZY72xRKXoAC9egANW9GlY
 BPGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWPRaCsPCE2QsExUXupBX4r0tKG2CwzoD0FWz7j/14YrnLn8aaG6BZ6iz6ckjZ/Y6N8iz7ApEyZoE8@nongnu.org
X-Gm-Message-State: AOJu0YwtTTtRjzwyC9olHIAyIV3PiT11oxzitc5reTLdod+259KX+SAp
 e/klhX6yhTbg5SSu8jdSRADVHg3w7lMlxyxYKhIeezM5B60+NUEtTixI710Blw/FydN0UxGXjf/
 KL/UNmCbj3qTY5Qj0dWQ5KYI1+dqALEalZzsTn/USxgusTgnr/95yLg==
X-Gm-Gg: ASbGnctl3xKhjIaCSs+IohE2kYkNFHCjTsVjDAm4Nu+UbR/MHIeXiLAEbq2M70y020H
 TXqGHx/xSeHxrt/74urGg6QO8wytWjyY2eODsgnm8L+fBX5j+gwuvJjXVlARTqIC+5s+IJDF1lj
 p8XyR46wD+bw19xwghZkMGuiJUrMA11EJ58GaBqzfpHxzocVQnzMa+/sX33CGHdcXuS+/7/FPw2
 4LQJCOrfI08qeOdJ4mVvmr3UsMCesYhw1OB/e75NOc2FfKh56IgXCg1Em23j+vqCym+EP/Q8DyW
 MwKiE6vAeYSDMDHV4X/vY65WLYOe8KY4RPP7gVU2KXGDJGkrpdk=
X-Received: by 2002:a05:6214:240d:b0:6d8:a258:68bb with SMTP id
 6a1803df08f44-6d8b72cf660mr35383246d6.6.1733238119496; 
 Tue, 03 Dec 2024 07:01:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm8ell3sNMG264RiPbskY4kK7Zv9rNEU56A0O9PDuSmiQx+8HD4o+KENAQgA8MRBmk4ZE20Q==
X-Received: by 2002:a05:6214:240d:b0:6d8:a258:68bb with SMTP id
 6a1803df08f44-6d8b72cf660mr35382836d6.6.1733238119078; 
 Tue, 03 Dec 2024 07:01:59 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8c271ef14sm3023686d6.22.2024.12.03.07.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:01:58 -0800 (PST)
Message-ID: <30601832-c8df-4d28-af97-cf9f2bdf775d@oss.qualcomm.com>
Date: Tue, 3 Dec 2024 09:01:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: update email addr for Brian Cain
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org, quic_mburton@quicinc.com
References: <20241123164641.364748-1-bcain@quicinc.com>
 <20241123164641.364748-2-bcain@quicinc.com>
 <014e9959-4995-4bf2-9a2c-ace318673804@linaro.org>
 <c559ec82-2ed2-4d38-93b4-9b5076181c9b@oss.qualcomm.com>
 <CAFEAcA_C5HXvMzVXQvQEpcFS67AZCa0dJL0Ek4X4tXtQfA6z+g@mail.gmail.com>
 <d06babd3-5aa9-4a6f-a265-45170edc7039@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <d06babd3-5aa9-4a6f-a265-45170edc7039@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2WRi8QyG-y2or2LX18KgIyxrtFDH2jPS
X-Proofpoint-GUID: 2WRi8QyG-y2or2LX18KgIyxrtFDH2jPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 mlxlogscore=558 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412030128
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 12/3/2024 8:53 AM, Philippe Mathieu-Daudé wrote:
> On 3/12/24 15:31, Peter Maydell wrote:
>> On Tue, 3 Dec 2024 at 14:23, Brian Cain <brian.cain@oss.qualcomm.com> 
>> wrote:
>>>
>>>
>>> On 12/2/2024 2:43 PM, Philippe Mathieu-Daudé wrote:
>>>> On 23/11/24 17:46, Brian Cain wrote:
>>>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>>>>
>>>>> Also: add mapping for "quic_bcain@quicinc.com" which was ~briefly
>>>>> used for some replies to mailing list traffic.
>>>>>
>>>>> Signed-off-by: Brian Cain <bcain@quicinc.com>
>>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>>> ---
>>>>>    .mailmap    | 2 ++
>>>>>    MAINTAINERS | 2 +-
>>>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>> Forgive my ignorance here -- this T-b is - stronger than a R-b? or
>>> weaker than a R-b?  Or wholly orthogonal to R-b?
>>
>> They mean different things -- T-b says "I tested this patch
>> and it works for me", and R-b says "I looked at the code
>> change and think it's a good change with no bugs".
>>
>> T-b is a slightly odd thing to have on a MAINTAINERS
>> change, though I'm guessing Philippe might mean they tested
>> that the .mailmap change affected the commits the way it
>> was supposed to.
>
> I tested oss.qualcomm.com is a valid MX and we can send
> emails to it.
>
> Then I looked at the recent github changes from quicinc
> around oss.qualcomm.com, and that this email was posted
> from your bcain@quicinc.com address. For that I could have
> used a R-b tag I guess 🤷
>
Ok, tyvm Peter and Phil for the explanation :)


>>
>>> Should I still seek a R-b before making a pull request with this 
>>> change?
>>
>> Philippe put this into his pullreq he just sent out, so you
>> don't need to do anything more on your end.
>
> Yes, sorry I forgot to notify you here first.
>
Thanks for picking it up ;)


>>
>> thanks
>> -- PMM
>

