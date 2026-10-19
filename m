Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36646606A326
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m+kZ13ip;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RTKPnWoV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuO2-0005Yk-Fa; Mon, 19 Oct 2026 16:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuNz-0005YV-Tm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:55:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuNx-0003Ce-Ot
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:55:11 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJPpqj2794564
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 20:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dvQg0mXXDG757zQH6BDIAkzeQ8fB5GSf69xQmaai3s0=; b=m+kZ13ipKsCdcddQ
 uLKAHDGI0yX6NNYuZvZ45sWsm65f8PjqIKUs49GUeUnizXvZVEVaaoU7VDxsRt7I
 +PZ5az5OhvWExhS1DicKK2PuwHylQSJlBoYWb4sORnXtroVqCP0rsx+PXAfWlc0q
 RhHU1Hk9rzXgkPug8B5NjoHPy+jjq6jC1OUwnr6IK0pZqXHh3o4N1rBYXovedyMm
 sX2sL7SDFdBXsWUMxiKVw81o4vXr8rbGlU0wfwtrE8CLt0Hg6nFQH9nv+afrPiAn
 SSmziWeWm/Xyh59X9chAFA89hQAcEz0MV81DooZaTO5vi4VPt86QEFZ2RfMW8Ym8
 x4W85w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr3p0mwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 20:55:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so4472236eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792443306; x=1793048106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dvQg0mXXDG757zQH6BDIAkzeQ8fB5GSf69xQmaai3s0=;
 b=RTKPnWoVodeBLrIQfE/qqv17rP0xG8LccAU3RUoye5dd/D8HMjMOlCj0EQjaqpj1ZO
 LAwwjcwXnfCyBbCID6nkaKSXrWybzYUKvuYpWvqCjVJzkHD3t0z00GRPM/CQJGSqHkup
 D4++N3TbIb/teI21jGRQ6bYHSgfGw/78LLP8Qrq72RVyT/nxiFVaTR3nStr0dTacMHZY
 EuiL9CHPRSKpU2P1k0vKojddNzWtYlFecTE9sZVEYj322YNs0bRB9hRsshvBBgTGlaG6
 VN85oS1jucgH3P5EENxEHQnfVZTygjbjTCdqajqL4muJLjKr+JWBwmcSS4pxJbctkq7E
 KFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792443306; x=1793048106;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dvQg0mXXDG757zQH6BDIAkzeQ8fB5GSf69xQmaai3s0=;
 b=qtYwlS1YPra5mMo03WPJTdH+ja0L17MXLeqKXqrHQy7xn8JzuNNwuhJCGTq8bRoOJh
 p7gEP/Yjr4gKEfhShjToJNHgz/b6i+87Vbo1PRP0g9N6/WTEhMUDqQkc4J0ht8Mui07l
 sWdK8d5x/eL17j2wSduDZ5HQIjEX9RFoOdzwfw7zMenNjIbdzhb2pCgO8hqS1n2WdajZ
 xpOHeTDds7SsVYSN/t+eS1qYn6O03vs4lHN4CYbNwJg0A4Jn2yEDSmcfWPejRBzlxekM
 D+WnQylfatq5RQmUgHQgaAsM+iwILi2QIQ84G8kvqENhrvHg/y8i5cGfrnYsOENrrfoz
 m7PQ==
X-Gm-Message-State: AFq9FYIF+sSV1INOVOeXt2toZwPLp2fopXIZAGDZmDPtsx8Xhz0+TuhB
 ScnytqqLwr+QVmiQOSvhIejypDxQWV3LTWKkDZKHi34J4sdkJU4FXNJ3XxFtuh8l1hK/VMsdnC7
 ZDGPhy1eGY/XdLDNJj2px/ANNt9SYgVfw9q0yuvXA1/goCLnRAvSnljPViw==
X-Gm-Gg: AYBFou3CNfDViaX0tZXIsoL+c2VEf8w6bb2BawRDiFTdRrQpo8xX8P63VXHONdCU81a
 2qqwCLjVSKoQHFrjrV+cQsGLPgAViBHMEl3qEUWnH+vcgSnyHFXv+jZ9T7gXB77Vzh0dMVyPSrO
 r6eiH4LQjlsY7+/AacVRr6762WGMhgyJfoa2FTk87rPxvOQtgSv0gKDHE7faHxPyv343yYGH7do
 U+8I0WRRJuNhYyHy4B9AC3tgIE3cRFdRGS/HAJukwiPFhDQGKHTT8kyk8s+kZizPAUpYP4va28X
 yo2Kwk70lly5of6Sth7FZPXBZ94vCWtoC+LLXDYjqXSqElsstmA2B9VKDcdMQpa+CM8p95bmLtL
 v342O/E2lGVAZgYDXNete16KYF3hB4RmG0JhfRiKpYMLX/Xo7/yN4qcNQ3Zgu0kSdOCWBKA==
X-Received: by 2002:a05:693c:69d1:b0:33e:c164:b5d7 with SMTP id
 5a478bee46e88-3619ed114f5mr12143604eec.3.1792443305951; 
 Mon, 19 Oct 2026 13:55:05 -0700 (PDT)
X-Received: by 2002:a05:693c:69d1:b0:33e:c164:b5d7 with SMTP id
 5a478bee46e88-3619ed114f5mr12143550eec.3.1792443304687; 
 Mon, 19 Oct 2026 13:55:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360819be413sm34586009eec.13.2026.10.19.13.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 13:55:04 -0700 (PDT)
Message-ID: <9091e2cf-9d44-498b-b40e-24e77dc1962f@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:55:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/tcg/ppc64: Run float_conv* against power8
To: Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019185600.2031729-1-farman@linux.ibm.com>
 <20261019185600.2031729-3-farman@linux.ibm.com>
 <cee46a83-aec3-4725-acaf-e52d16e327a5@oss.qualcomm.com>
 <82425214-d5df-49d5-aee0-ff0f9fe7ef45@oss.qualcomm.com>
 <f380714e-42fc-4dc8-a9dc-224e582c1e3c@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f380714e-42fc-4dc8-a9dc-224e582c1e3c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Noo9qp43_3hHutM1XnAZpx9C7LeMMdPi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4MyBTYWx0ZWRfXwT1gWMh5/xfD
 ZNyHC+c4bd0jgEQzRBNB3NCGYOoxjVxvmZifNPvlKpCuM+1TUiStEr/mzUh/56PhNx/v8PydhDr
 XuxYKY5xZZM7qui4rylgpmj5N3UNBC/Hs7JDOqdqt6EkTrJLT555QGaQg8DE05mhbTnbidZtfax
 44ML9G2rhUkbMa5Kb0/qkH4/QVBtPjJAYnfEn/cmPILpzlRuwRReFL5Ozv4Fzy4NFtrrpMTuP56
 c0a6me1xtu1w4L7VPaX00gVVNz9l+3z6H87FFN28QBVCD/W+T3jzZm6TSIUra1x8QWzAn+Txyn0
 HeW5oXMgP6ic/dHw01iynUsKENK46zeWiqWK1O4WzJsXLzA/fH3R06XijTID/THYQT02RN1drTc
 9a9Ab5FDhogiCOUuVFosJBpxdsnS6gTe26OVt7fMPYAp7VWpCDrpLHulPT1PelmXktDniKdq5AY
 NGC4azI4CjPHe9OgaNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4MyBTYWx0ZWRfX0tRXda9Qy5Ia
 IP1BY04FlnhPlJgdmNUSe27jGs+6SztUyvoclkTk05mtOhH+sKqnX+kucuJcrjP0ymmWTBofFF0
 cis9ZAL7BNs+ThfbhG8R8FalKJeaSUY=
X-Authority-Analysis: v=2.4 cv=HLxWhYtv c=1 sm=1 tr=0 ts=6ad683aa cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=wuUvhH9SJMtX9C6tiCMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: Noo9qp43_3hHutM1XnAZpx9C7LeMMdPi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190083
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 1:51 PM, Eric Farman wrote:
> 
> 
> On 10/19/26 4:32 PM, Pierrick Bouvier wrote:
>> On 10/19/2026 1:29 PM, Pierrick Bouvier wrote:
>>> On 10/19/2026 11:56 AM, Eric Farman wrote:
>>>> There is an oddity that turns up with the float_convd and float_convs
>>>> tests, when running from different toolchains. As one example, the
>>>> expectation at the start of tests/tcg/ppc64/float_conv*.ref is:
>>>>
>>>>    ### Rounding to nearest
>>>>    from double: f64(nan:0x007ff4000000000000)
>>>>      to single: f32(nan:0x7fe00000) (INVALID)
>>>>       to int32: -2147483648 (INVALID)
>>>>       to int64: -9223372036854775808 (INVALID)
>>>>      to uint32: 0 (INVALID)
>>>>      to uint64: -9223372036854775808 (INVALID)
>>>>
>>>> But, other hosts offer a different response, e.g., this debian guest
>>>> on my laptop:
>>>>
>>>>    ### Rounding to nearest
>>>>    from double: f64(nan:0x007ff4000000000000)
>>>>      to single: f32(nan:0x7fe00000) (INVALID)
>>>>       to int32: -2147483648 (INVALID)
>>>>       to int64: -9223372036854775808 (INVALID)
>>>>      to uint32: 0 (INVALID)
>>>>      to uint64: 0 (INVALID)
>>>>
>>>> The explanation seems to be a behavior change when compiling to
>>>> different
>>>> versions of power hardware. When building the arguments from the
>>>> multiarch
>>>> directory, let's ensure these float tests offer a deterministic
>>>> response
>>>> to these NaN tests by explicitly binding them to a CPU architecture.
>>>>
>>>> Chose power8 for no real reason. This behavior change appears between
>>>> power6 and power7, but other tests that rely on a specific architecture
>>>> today pick either power8 or power10.
>>>>
>>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>>> ---
>>>>   tests/tcg/ppc64/float_convd.ref | 144 +++++++++++++++
>>>> +----------------
>>>>   tests/tcg/ppc64/float_convs.ref |  80 +++++++++---------
>>>>   tests/tcg/ppc64/meson.build     |   6 ++
>>>>   3 files changed, 118 insertions(+), 112 deletions(-)
>>>>
>>>
>>> Thanks for the update Eric,
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>
>>> I'll let you pull this as part of ppc64 subsystem.
>>
>> Checking MAINTAINERS, I noticed you are working more on s390x side, and
>> not ppc (I've been misled by @ibm.com). If I can help by pulling the
>> series as part of tcg tests, let me know, and I'll send it on Thursday.
> 
> Yeah, I'm only noticing these running on an s390 host; would be good if
> someone in PPC could chime in and confirm my suspicion, otherwise maybe
> you could take this one via tcg tests since it's showing up now. I don't
> think we ran this combination of tests prior to your meson rework? (I
> couldn't reproduce these ppc errors, anyway.)
>

Not that I'm aware of. Personally I only ran tcg tests on aarch64 and
x64 linux hosts. That said, I'm happy to see we are covering more
things, and discovering issues.

I'll pull this on Thursday through tcg tests if there are no further
comments on the series.

> Thanks,
> Eric
>

Regards,
Pierrick

