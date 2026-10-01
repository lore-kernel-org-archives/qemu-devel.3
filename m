Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D5BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJbQ-0002oD-0K; Thu, 01 Oct 2026 12:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJbM-0002nw-Eg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:25:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJbK-0000rP-7C
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:25:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsW3m4062383
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GEj/Oc2ezBaN1BatLMv4h5m2yewynecrGZxYV8tOi/c=; b=aqZLiVqj9Ax8Djrj
 dkUu/PSIgJhTWKcNXNifoBt+MvZL6NEnnvn/k+OtwyXr+d4pWPUqwlbSY76zPLAF
 nweqU1FiLODUKx4x5SnCkICUWbc27LT7KWkXuDUEC8Ii7qelNUXhLOh1tZRHjFGP
 NcWLo3Q3xKPKKEq5reRenrHCwosNXNRLfTJweUvyiZMxSoIn1mz/8bICPWy/Ho0z
 aNXdRCxpoRatyKvC/TCz7ez0yHsoZ/EA1wW0ZB0bkoHbXeeFZ/adAEl6TElBEbps
 edi6SrQt/dX9jv5WdzkusI4RmwEJi6kpQ6NGQD74gpd/jjyl3SqxVz2nECoNcUKH
 GlX5xg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1p2b9f5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:25:36 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso10144361c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790871936; x=1791476736; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GEj/Oc2ezBaN1BatLMv4h5m2yewynecrGZxYV8tOi/c=;
 b=MuQproN87QinOyhOnSxIXux6Q0pr71JjMitvO+5w4yyLPX+OEIjVWDir5qem3dPw48
 RTxqM6hWc7yEMJi26A8LGMkZDwqDhw6gZiGWnZNdScGquweB7PCw4slS5giQ7ANH4yEE
 0Fq7PyR+Sot9iuHQNLoiu1Rwz/GO3vZNO2muRZPa5Br3aTu/M4ET4lVUAbM0OPp7drAD
 jfXvAfsgWBvXaPMb4qFprFDC7rbszsItTrseABzGRYsCFWej5korvskzN/wTbTGNdnLa
 cpXKj2dTdVpwI+gBrQx1C0gWk91rmzPWtKYrKYfOrrdlqONbN4P2p3bCD3wsw5cd0ag4
 ciLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790871936; x=1791476736;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GEj/Oc2ezBaN1BatLMv4h5m2yewynecrGZxYV8tOi/c=;
 b=oP6ghztlalXrLtYuvFRnaxUi3U302czr5VRx9CNXtKtUt979yIWmPOUhTxLwzQHOYW
 80DfRN+DPvulPhY7QLKhv6gAibx4x5dVU+gf1rDOzO8quZFtSis2Xl9Q/81O/nKRMaQi
 Otad7ELW5V+ln2lgJf+o+3y0wftvS2wRdN49KdNQEvrh23NrwKs8//HLLq6ka6AKT+cC
 IR+fC+7B/wXy1/Y6TYT0BdHtfZWCm87FduNBFWB0ZmrrrQZYqTuuNCJ9Z/sUk3KbPaDJ
 6Shcqn4ZmOo3INoa34IJNPNGERjw5bYQX08LEdU68GQ1zXiaUaYB0HdqyJoC840OJbUP
 7E3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpzAmwLo4miF9wSroLR6SOx67yOYgG7XW4MrtZHXek8SiEXX9gb+krQtxZniIZPySdkojmY0HY5rfb@nongnu.org
X-Gm-Message-State: AFuF++neT3VSUWPR91V2LFUYduz5SsTLGq2HPkqXEkNpMlvbj6Xppx9N
 GIc+BXjJYzNxtZk0MRqB48B0kpyE1BTgsovRIT61HDZl7XbdhJENtlRcWypuvUUJZZ7DpGpY4zj
 ZBsJsFBOqjoYqOUQOfT8HHx3mrsl9WA6aJpVCGYdj2R9beU0/2mEr5PeMlw==
X-Gm-Gg: AYBFou3LQAYCJhY8WdW2Lofab+d9vS17IQH65XZkOPReL3QG27w2NSn4qRJOQRWmX1d
 MFOxuIUR/7qH7Q0df/AabpOVxsoPdPEhKyU70kSLJFydQXB9yqa/3+OkjSfWPWFSP6I74HK+cWw
 qaeMzrH4UsyvZoywNKygQ43IOMApiDXERS4yKR18+X0DDk3f+E0UvP7RHB63eDcX1tcpWpRgNoO
 yy1bcqdF5QGsaeKreRzJrEjhwfjuG1DcSlp3VvVxdDkwRP1CEQutW+bBF2QjcN6i5gtw70HxE48
 EHb8eofyAByiEoLPefbOxhP9apFZ4nc/XBtQ5GWCBWwAHD5acWFPgL2AMJ268ZMSrqXDgeArPbh
 UCncRAvSMf0bOdFucYmqxsSXAxDd2lVhanQqs4EBdKkKMwM/NaN8uT5M5+zpYaSA/s37ZWQ==
X-Received: by 2002:a05:7022:61b:b0:14c:efa5:ee7 with SMTP id
 a92af1059eb24-14d3204e4a4mr7120490c88.14.1790871935830; 
 Thu, 01 Oct 2026 09:25:35 -0700 (PDT)
X-Received: by 2002:a05:7022:61b:b0:14c:efa5:ee7 with SMTP id
 a92af1059eb24-14d3204e4a4mr7120455c88.14.1790871935075; 
 Thu, 01 Oct 2026 09:25:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f27088473sm398751c88.10.2026.10.01.09.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 09:25:34 -0700 (PDT)
Message-ID: <f5b60b8f-f65f-49e3-b4bb-b1ebc92649f0@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 09:25:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/i386: Build test-i386-opt-shr
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Dominic P <gcc@gcc.dp11.uk>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
 <20260930185124.3036980-4-gcc@gcc.dp11.uk>
 <1bac23ee-6370-490c-bab6-fbd17d437fac@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1bac23ee-6370-490c-bab6-fbd17d437fac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2O0tHVIWGinbesL2hlfaUUgVUaxNI_oH
X-Proofpoint-ORIG-GUID: 2O0tHVIWGinbesL2hlfaUUgVUaxNI_oH
X-Authority-Analysis: v=2.4 cv=O8SsLx9W c=1 sm=1 tr=0 ts=6abe8980 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Ohd7FOC1tvnkoCpmqzwA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NSBTYWx0ZWRfX6UhNqrlONPB+
 d61BfTR8TfHIg4WU41mwpg/bVKlLaXfsmaMlRUx09l2ZJvn36dIOYBqbEwzMMcDEfrRQcB+LBvF
 2HtiUoy0wi6FDyIeGXWhTX+LeO3QNqM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NSBTYWx0ZWRfX26USWvbOYbFT
 O++3XAmRHIwbARgZN1tekp46pIGt7CUKdfc3486ohRkcpT34+31UuZ7oQbkpjsc1E5ZFQJiGanI
 ugjKBLP1wAx6Ovno/0cg75A9/PiOf8i55J0hkksjuRTXeu8b60bDtikzbB4VGj6jmA6XvMRFX6U
 ldCnv86QnZCKJu+N91tjbP525QOrPjXwin9/z9XYEqXEKqH3vamN5YT3vCvMw8DHQyOfo1A2Yct
 eBVzlcU8nU8nCoNCiPN1ofCTYpQhxowwEbi0Z2986w/2XOzXaF2H9OTOUrg/K6fDIf37n+0C9Zz
 3UHATw8blvds2U+Rpn5rsxNrXa7yqIKLiWeBV5+Smky8y1yY6AC4ENPMgT00olR06kUe+uSyN/q
 MuYKGUpoMJaGkAV7BNVLeeewOuYs4sf0jfT38h9/KGPD0jSV7BBFNWI6ktqqJunZeercNaWBchq
 MrSAboNLVITXeGzuXcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/1/2026 9:07 AM, Pierrick Bouvier wrote:
> On 9/30/2026 11:51 AM, Dominic P wrote:
>> The old Makefile.target built every tests/tcg/i386/*.c.  The meson
>> conversion lists the tests explicitly and missed test-i386-opt-shr.c,
>> which 5fe51606146 had added in the meantime, so it is no longer built.
>>
>> Fixes: b4e3e90d61 ("tests/tcg/i386: user tests")
>> Assisted-by: Claude Opus 5 (Anthropic)
>> Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
>> ---
>>  tests/tcg/i386/meson.build | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
>> index 4152371a3f..26bd85c05e 100644
>> --- a/tests/tcg/i386/meson.build
>> +++ b/tests/tcg/i386/meson.build
>> @@ -28,6 +28,7 @@ tests += {
>>    'test-i386-fxtract.c': {},
>>    'test-i386-fyl2x.c': {},
>>    'test-i386-fyl2xp1.c': {},
>> +  'test-i386-opt-shr.c': {},
>>    'test-i386-opt-rol.c': {},
>>    'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
>>    'test-i386-pseudo-denormal.c': {},
> 
> Thanks Dominic, this indeed has slipped through the cracks.
> I double checked all the rest, and found one missing test for hexagon too.
>

For information, this will unfortunately conflict with current series,
since opt-shr is added after opt-rol.

> I'll pull this patch in upcoming tcg tests PR today.
> 
> Regards,
> Pierrick


