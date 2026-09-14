Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E145C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6BSy-0002vq-Jv; Mon, 14 Sep 2026 14:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6BSu-0002vO-Uh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:31:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6BSs-000251-7v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:31:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EHBhQq2087358
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kksa0/kzQYXxRPAHQnpv0WgNyqJRYyD3q0imJIP8a3M=; b=Z5nSPduFO439xpjO
 G/Mor2Wukdweg21WQJ8KzhjFbtQOjYsOB93LljY+AMcbzpo52L44kuwRHU76/oRn
 aRvIZsFzjZj+AV24nyecSOQ4MOjOcdk76cXzFiuNp0gJ96QZhoVYwC4PxJnMNeOQ
 5yMriR31sjgem4CzCMYgOc9Ccnd01AX6Skrlv82noAxIHQXTODqkBubZg7zIxrvA
 Qx5GljSrQ5mggOtPLkPmtze8qQRJZ00A92eCIj99xXT0ioax+9XZc5cK+SIwVzty
 Awgswtz7yrGk7FNB9aPL244VE4ZrCnYmEV+aqdD6SuMTanXDwbg6LDAIaJ3m2NSe
 zrDRnw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpn41ra2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:31:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9393ac4961fso400856285a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789410695; x=1790015495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kksa0/kzQYXxRPAHQnpv0WgNyqJRYyD3q0imJIP8a3M=;
 b=iQCdUqJNxAdu1k7xgxFTfFgtPDBCy85udM6AezsmmThB6rar65ZnD1GRiyZSDo1hZA
 d47+BMg4PtWCLK7YqFTaTpNMMlDhesBhuorOEmqHgknrUbQTKITFk+v7mBZfqplmBtvj
 5gHJo6yY/lvzjvX2DtL/atWaZ9dITaX9Dv5+mHFBwyqh63Avg4t+DM1pymjhxi0H1wFA
 NydQ7U3HyU3tTRwCiwHl+lWy8H4dBfCOTXN+YIag88OcF06/YTusVvI9VzqK6u+kIPes
 AwOY2+6qyMsYKzcjCf+RtGOwWnpL/A5a+1eVY9XWUzihN6l4l6xXJbUbGpdr+0XBru6D
 yrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789410695; x=1790015495;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kksa0/kzQYXxRPAHQnpv0WgNyqJRYyD3q0imJIP8a3M=;
 b=qEeKSC/v1XZAA31gIYvlY4UrKo3JIDzOhchMLmfd98oWFBFIiIPjslDxGJ3oU/mpJO
 Pkd1XGgab+VKzFJ1ZffW8Egm8eC6HqFRsVLyCIDtrYule7WqTJq4+P22qQ4LmcbDzn7T
 BJXa3/MHqvmcNtskODKdxVEuAREJfsnx2UwT0z6IBvDYwScdfSQX+AtlNLgLhwMlijG2
 1XmYUcJ58dxP18Tsi3PAZCNcVNDeq+kn9bsAOb7yhfzlUV5nVHnwzjdWw+PD3xXs8V7X
 zaioGwQa2erqnvsOZPa6hNnXuuE14H1tQvR2ghYjooCuft5G4gkkkxztGWwDg5a8lYSt
 07Yw==
X-Gm-Message-State: AFuF++mX6fneKzMrfTGEuwwD7d2LJ/Vzc/M0zV8GYy7QEoIwb0kgSdh+
 6aR7YQTuOPyEAx5gyRjcxZQXW/btABs093N3jm0tWL+rcxtVP/Zc/TPr8MXNT8wPtZ1oVbVL4zJ
 N/4ILy8KRwo8aFFIog0ZBg6bXx6pqy2pQUlqIXRLwbSXtDWNxSb7qdHWdIw==
X-Gm-Gg: AYBFou33HF84MfON90gypc5IJZ7Y1IPhrK8SCyRg8+NeGHjCFwNU/PZugJmgV24Ix64
 xPn0BF0GU++oIjMLP22q5Fiv+IO/vR2Anr3ys9ZQ4GIBpwoMorwiTtPC84pkANQbxiQjia0Sia1
 7i6S9j8EKLgvjh7BLhF9cf3hDsUHfAg3ewNofCrSwS0Q+kkRySHSRQdIUMZNCX1uUIKKFLgHY0x
 029S7ze6j/Axy7LsRvmk000u1TCQbzMNQkgDUOL8s3mS8Nu30EF6br+MIlBw2wX88JVeLXXuPoJ
 FbvcUmgscSB6Qvuf4qvjOrbCum+F+HigIL4UunQWT394dtQl7LUQquiQlgSNqlUp9SRr8GGUWmp
 w0qepJumosyVp6WN2n0Uwaq4uOGS8MmHzDa1AYvqD8ZbQ42TDkBf7+V7aQIXGhIHJ
X-Received: by 2002:a05:620a:4481:b0:939:ec25:e58d with SMTP id
 af79cd13be357-93a29839133mr552831785a.12.1789410689821; 
 Mon, 14 Sep 2026 11:31:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4481:b0:939:ec25:e58d with SMTP id
 af79cd13be357-93a29839133mr552826385a.12.1789410689301; 
 Mon, 14 Sep 2026 11:31:29 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e80801c0sm1044159985a.30.2026.09.14.11.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:31:28 -0700 (PDT)
Message-ID: <32ecd071-2dc7-47ef-bbbb-abc8305916b9@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:31:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/hexagon: select the HVX register file with
 SSR:XA
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-9-brian.cain@oss.qualcomm.com>
 <CAJ+KCYPb+en46bQs0TszcN7kP4pASyM+YWbYchdc_RkZpBETwA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYPb+en46bQs0TszcN7kP4pASyM+YWbYchdc_RkZpBETwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI2MyBTYWx0ZWRfXyMJNq+AYiO0P
 K7REvyuh986dlfa5KKA+s+fqDZpbaAVU9JZ1Mx+jR83If2aeeqjqIVvg1sIHMQHWcPOhzhQlObD
 svmDkRZ1avmp8LHBU++Ku6uTu35rm0GFFtP9nkmy7bScTzXr4Dw9JH/Qc2svc36VwZlxcaaH0N6
 mgyXejtnRgZIZErhu3OtvLwxCulOgLiGChwEk4W/Droko2x1ZrtjhSrFwVAC6YYv+4gdq9T1rdl
 KcPZ4TFDb0Id0Tdrh24JqWx1cbWC2EcTNzUE+hANLXwcnFRalzabvBPlYjQ+9eeSJMbFQvukwWm
 cgPcgoVQwv1zEdeY4XkzxJE0mJzlOUY7jZJqeuh0RFtfqWvZOjZm8ZM6cJnJUYlD8lvIIOapvLw
 GQBVSdF59061XzXnzuDOCVSGgHukzoYBI1nmt/c8OGbekFI2oQW2vZoRLrlTuOM0SqMwNmBTwAk
 a+AQXpaZh+kM9yGzQoA==
X-Proofpoint-GUID: nZByhsPFibTHgYvMmBmImwOr8PtEYjdN
X-Authority-Analysis: v=2.4 cv=cqQOAF4i c=1 sm=1 tr=0 ts=6aa83d87 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9ImTclQ0_L8IZNJOhycA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: nZByhsPFibTHgYvMmBmImwOr8PtEYjdN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI2MyBTYWx0ZWRfX7Ir4nPQdiSuH
 jSt3+oik9Ch1AV45JFMsC89Ye1vMvr8nD2gr64vl0MbqirgO02Qd8ILvNbqY/fUIqLc45UvWsRg
 I3uhG+qSK9Cm4S2bY8vzdk+OLz0VyPE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140263
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/10/2026 6:44 PM, Marco Liebel wrote:
> On Thu, Sep 10, 2026 at 10:32 AM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> Assign env->hvx to the right context when SSR:XA changes.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu_helper.h |  1 +
>>   target/hexagon/cpu.c        |  5 +++
>>   target/hexagon/cpu_helper.c | 72 +++++++++++++++++++++++++++++++++++++
>>   target/hexagon/machine.c    | 12 +++++++
>>   4 files changed, 90 insertions(+)
>>
>> +static unsigned hexagon_hvx_context_index(HexagonCPU *cpu, uint8_t xa)
>> +{
>> +    unsigned n = hexagon_hvx_context_count(cpu);
>> +
>> +    if (n == 0) {
>> +        return 0;
>> +    }
>> +    return xa % n;
>> +}
> Why is `xa` wrapped with `% n` instead of being used directly?

The behavior for an out-of-range SSR.XA value is unspecified.

Empirically I can see that the reference simulator happens to map these 
values to some in-range context number, but the behavior varies from 
arch rev to rev.  So - a modulus seems reasonable/appropriate to me.

But in v5 I'll add a GUEST_ERROR when it's out of range here so that 
users have a way to find out what went wrong.


