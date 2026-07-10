Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3434AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiK9U-0001TQ-8d; Fri, 10 Jul 2026 18:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiK9T-0001Ra-7B
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:56:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiK9R-0002WX-N4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:56:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Zb11752919
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JUHURz+ki6l0F9geOPWw5iteATywXGk18ve1gTwIP8g=; b=OpcWwXMHSNJYP5Ju
 fOiMmd0Fr1wr7JDA9oNHWH63IPibZriv9Codz7pns9QqGSlKWUygNigYGcWRmmbO
 jN1W58yhSYue+DjZP2xZUfdMW2WswTfrOLhV7l7KZe5UMEqgsdYcqAQjpTPuTDGN
 TezcUYAXlVSBYmxkb3FsF59tVtsgPfKo/yO+HbUfikfLILEixpI312Taih79KRct
 7LrPR0ajXtUEvH+/k3Wxjjmg9X29DZfRtZQ9YJFZ43g1zKLMicTntqJ7JCFir2Z2
 JIsF41sbqVLGIyFd4wFQUDHm6HWL9IUlsXyr7xN9TlOMU5HRBJeeCKUVrxu9T2er
 6V7lcA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9p9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:56:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c20762d21so14742011cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783724216; x=1784329016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JUHURz+ki6l0F9geOPWw5iteATywXGk18ve1gTwIP8g=;
 b=hnJfRQ18rU7gOapqcJPxNS/DTRTlLZwdMHBGsVXEMLyqsesmkgKTS6QQEqWBTuzGR9
 yA4cg7rd1lE4MNeg7HVWAj2nvHzIuhadVzd4MqUey2A5/PT6Cyvknn2dYn1LIfYYGQqc
 VDqTNHvab8dqQTmLjcUtpyTm1OJhPwri5k/HqFXyOdgN1cSmO08YWHOqPYeHgXNS0qyk
 Yzx8Wzb+9l6IsMNg5u+ObbvCVlBc7KnmhIUzolq2YjlfE1C3LZOXAsB/PJbQAaMZihBw
 f0gYHyjzrHU0HX68p/04+JUS5166CWZJvEON2gUhj/ozzlq8nXkcl/y2M4DzxJNvnxM8
 580Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724216; x=1784329016;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUHURz+ki6l0F9geOPWw5iteATywXGk18ve1gTwIP8g=;
 b=e2TLhdbnHy3sv0IGp4C77yG4CllJ8eg53MqkoCgbG0hV6AJnHcPQkUTEgG9PbY/6Oc
 NN250xafmGMXhJkfr05MfAF+1Gr5fAHGhbHm5vBjwtCiCe0b57MsPK2/poHe4xk+DnFT
 G1bjOBGCfaOUmbvHbBeMZwsYKwhoB+z/uCvNSPJ7mW9SIWHrbX/2KE8cS4fteIj/6Yju
 NtnhyONeXflG4CeEESw9W8pjsyLhzi6sdsdLELUfomqkzcfXElJIiqB/qsM5HwXNLRkg
 hac7ccrW8Uh3F/MC5vYmsro+yqPddovkIJwHZwL3VYIz2vyYFjIXbsGejGE3s27gec3y
 squw==
X-Gm-Message-State: AOJu0YxL8CiEIG7ElJVv5qQwMskLe9h0fv/kq0SlzzoLHzDpTYa6mZ6g
 2LejsZ+Hg0Dqvcw1+eGzFUJPsa4YU4FOGnS+3mi515zik4h5y3EJoej4I9fErr4IN8hhoO9ylKS
 sEJs1SRtGgaIxEc5PIC8Hj9pv1ovCLqY0Tt3ejx/qugLKnFkoz+ywMG9dIw==
X-Gm-Gg: AfdE7clNrOSWINDjOFqL9Yt5ZD+m0H5u0dqXgX1bjtQW7I1dw+4Ry+5ye8bgX+4l6KJ
 R4yKnJroSP6JpEQQaQ28olJutcQUSCjPGa93XdlbRLQQAcKjM817+i4JTTbqFJi67KA63lW5hfF
 XgJ7MounZjsnM8nTM86Ey/3ufRySXlLH6Ao1PIvhmRm1A9DBAW1TfZMhApLJVPR+DcexrlKGKAU
 RxpPnuw+eN1ABHF3Y1gbRLIaJJNNNhBk0hAgYJrCFo9r3Nat13OtfG6WScjIX0VdeSrK6LpvNRK
 ZLnjft9s4lfk/pOgjZMPat7F+S5gTsJsO9HqLTa7b1Vki5Vwh80Wckwy5ZLeAoqozZVvDimlEbm
 A5ruE0ktAOZb1Uh7flkFNIRrryDpMf9pUPH8IKv/NYmcsXXL0DPRv7R843f/sQA==
X-Received: by 2002:a05:622a:4c7:b0:51c:f3e:7819 with SMTP id
 d75a77b69052e-51cbf142ca1mr9535931cf.39.1783724215788; 
 Fri, 10 Jul 2026 15:56:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4c7:b0:51c:f3e:7819 with SMTP id
 d75a77b69052e-51cbf142ca1mr9535751cf.39.1783724215310; 
 Fri, 10 Jul 2026 15:56:55 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm62728844f8f.14.2026.07.10.15.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:56:54 -0700 (PDT)
Message-ID: <91ad4c80-adc6-4f37-8346-20230638e5f0@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/hvf: panic the guest if an unhandled exception
 occurs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Leesoo Ahn <lsahn@ooseel.net>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Markus Armbruster <armbru@redhat.com>
References: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
 <CAFEAcA9LCRKmU+r77zGp+4Rgd-uaZLPnoPPQDSfG8X5eeiynJA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9LCRKmU+r77zGp+4Rgd-uaZLPnoPPQDSfG8X5eeiynJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIzMCBTYWx0ZWRfX7p9APc/yYiHk
 z2nyYvPz6V8Mz2Z98TNbYEMQvuBpxl8AVqWTYcKniF7y92Wa6NIQ+unVCWkPZyUVDoJdRUPuhnl
 dy36ShjXxFEkkRimnv76NSUD6oHJ077TwUsz/1WAo0MAlz/eEiWx84u4N3wz0qWOIqMj/nPTPER
 QrCXxnq9zQ2TneFcPZPb0rKDcrWaOqfF4gyvKbCzCxdzEx1cO2pexWH5fxNTWByLfYWdrG6UnQl
 8oQuaJZ8tDpjIM9QQOX69TJb6YJSrwohwv3qsf9y74bHEy/QwISO8FqzBjtrtjnP1fU0kExknf1
 2gV18Ib59JyOAHB8P1KIGi8G2sJRULcTH0u0YOkbjZKdaejDpAvu/5E8t/EoAAWYLR0hWSCW3Va
 Bz6O6O1BRRuEqCQc+rvFXs/Stlw+csQc32drJr4T+D4Ha4pky8yGp/5vfUf90C+CpAqNM+tBlh+
 WOJo1VK/qDiyXx4OlLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIzMCBTYWx0ZWRfX5wO/Z1H34r4Q
 tGNDfEzONq+fXJyxzUqe3RAXm9C8U3/PBVL/nKcJLIj1PQkzwGbLEKde0FeiEBIgYTmRHNfhaqd
 qxeXekIT4AGOH3HmcnyVrgJftM2klPM=
X-Proofpoint-ORIG-GUID: SNDveAXfVVl0cHOCQBrojdI8Imhd0ei1
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5178b8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=JdaLKi-2AAAA:8 a=4iX3uDW9G_cJQgqnWakA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=eajN7WahzW3wU8zyartL:22
X-Proofpoint-GUID: SNDveAXfVVl0cHOCQBrojdI8Imhd0ei1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100230
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/7/26 17:37, Peter Maydell wrote:
> On Tue, 23 Jun 2026 at 13:56, Leesoo Ahn <lsahn@ooseel.net> wrote:
>>
>> It's worth cleaning up all resources that the guest taking and to quit
>> if an exception in el1 could not be resolved.
>>
>> Otherwise, the guest will get in the infinite black-hole by
>> unmodified pc.
>>
>> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
>> ---
>>   target/arm/hvf/hvf.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 8b902c6882..4358cf90e8 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -2533,6 +2533,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>>           cpu_synchronize_state(cpu);
>>           trace_hvf_exit(syndrome, ec, env->pc);
>>           error_report("0x%llx: unhandled exception ec=0x%x", env->pc, ec);
>> +        qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>>       }
> 
> We should do something here, but my question is whether
> qemu_system_guest_panicked() is the right thing. We mostly
> use that for "the guest OS wants to tell QEMU that it has
> panicked, so QEMU can reflect that to the user and perhaps
> reboot or exit", though we do in a few places use it for
> things that are more like "we don't handle this case". I'm
> not sure exactly what the right thing to do here is, though.

We usually abort() for programming errors (here unimplemented
case) and don't let the guest mis-behave.

Maybe call the mis-named hw_error() method to dump something
before dying?

