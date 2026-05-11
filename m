Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C735CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVT3-0003ch-Ii; Mon, 11 May 2026 14:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMVSn-0003V1-4z
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:34:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMVSj-0005tt-PB
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:34:43 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BHUuwU3051401
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 18:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sR40ptHVtZftjleY3SdjKSPIBerXMuKjSDpQ2xc9Q/Q=; b=FMg05uKg9Te52sNV
 lsbDUtp4x/dqBrjmEzZUq80yeMSsW2Clr4u92zqyFVK1duj8+2XTQ2wUDMXM0tLd
 pyHWklmkWYlyu0QJ1l1N7uJ3izhRH6hg8sSK0mxYtfY8lq1VWhhTLocqRHL7x5i/
 oTgkk+fZ2jmqITkvi/oJicDpfwoZ67FFMPaT32N/DF+pRvT7nmOxjPZ7LmCfDiGj
 KAVAeWKi7I3CTwu8R0FC28pwxyTnK8GucN5uOdRjC8dLzNkCh21D3gTDRv/iCXsS
 9B2YEXEjlPfLXuTvvryM45m9YXkDkrAKzawtKtPFiL/N7+H08VTF+ox6d3xF/0nU
 TvYW9Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3kjwg993-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 18:34:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f3eb8f3419so1173167eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778524478; x=1779129278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sR40ptHVtZftjleY3SdjKSPIBerXMuKjSDpQ2xc9Q/Q=;
 b=H/fq3QLFdNvCdf2ZGi0+YpRuZAChxx31ny47q9w3jE/w1CFrXMUrudZUEyO2yFqKwj
 TaGvKXqa7d/Cbgk2zKdiDvjaAkoLgHYQBIm0y14EHXvQdkW3WP8thUjAd7ToRS0WlAkc
 YGv08ZmjIih5ymfLAJaOnF4atg7kjfonuOKXqzp2WnqCqkH3NS50VWsnfqB9FUgJ2IjO
 DA0vKfAiu8CR4igFoG/AnBj7W8B/p00WVV8Box2ssEs3w9cYuS+5WW6QCOMMp2claOo+
 cBoRyi39NsYiAxclURaiO9V6/v/nMbPZjkrbuN58gsCEN+RetaUl8OLoIxS4VXXU9rti
 zZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524478; x=1779129278;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sR40ptHVtZftjleY3SdjKSPIBerXMuKjSDpQ2xc9Q/Q=;
 b=Fygpg4HefzPc5vp0+E3wa1Abbt9BHJWM3AST2Hl/ussNJdwi/vDWmidKsUmhGdmBK0
 SyznsMBJiz2E3Xn/+S0zZGgSVqjG3QglUKkLyHpo67hIrsR96PqkHxPxq/v7dsQ00xCR
 D5SEApO7iCmbf8rqJxohZdO6Rglnrc5B5flt9XwULE01H4Ms0SSEZ38skaJqpJrUL6jY
 WOKWOSnc+4wP8BMR8pnVM6Z7OuICeEtfpvWJ0BZvovjuiu0HYrmVW4Q7ZEhoL42xHS7W
 mmMtmBR6qop6YcJGDZFJbIfek28okTtGOlFrz2dL6UFBg+v3C2KW9KbgNmLlfeUfwlAp
 gF0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UWgxwH1uuDYtZL3auVpzAdZ7qz4u0QxDVjvEgfq4GFUxucS2hysP3uY25IlZw/FE1urYf61s7TRRJ@nongnu.org
X-Gm-Message-State: AOJu0YxJqB6nw+0Sfh4hhCE0jdXqCWa3A+qiEpZvAxQouFrcDHs/atCM
 ExA039DR+gvkHbdBsuZ6KNJNjX/y1A8HFFOjkIJZEIvXp7MuDs/DuaH/YWdYb5J5cnQtcCKPtmX
 bbLUpsADnGWBj6fjPquBVUgbsboe3y5Vqxt9/anrxyjEeRDHdqv8xMPo8KQ==
X-Gm-Gg: Acq92OG17J2iNlksYqOvHwDiG/10Ytqi6KM03AKM0aRCusxFRC2llH2TQLYl7DgQQCi
 fHxCEPEWsmhgLW3AeGqNl/FPJVaH/svz+F1IaLSEQeik+WZedH4l8FpiB8B5yWSOTOGONCdC/Ir
 sDBWURFHqRo1x+yx3ddeXI3P7CCdmaO3IlcS0jLWI34UdfModBwhDMRPFdO0TwySd/g4x9877Ol
 NV7mGEOM7kDP7LZXH/TlAQTUaffca6p+QP43SjiVtBRUjm9uANKrUZEHOqRQbMT1Qb5OKwfyM0v
 YEsLz5+HiQTtnq9kcJ61bTy8uSTE4+Odo11+xV8EsSooajVk2kCIRhLwXMV/0jwHrpw8KznPSfe
 wGSMdfYHwbuMnKNImQTfhmBUTs9yIj8YeYzz3FZ9q2G1Whrp+kqs08Kc9nlMFeABktEw/iil8Wv
 4xVHGSalAP5IMi/y7iK8IXAg8Y
X-Received: by 2002:a05:7300:d704:b0:2c1:7b61:8731 with SMTP id
 5a478bee46e88-2f5490931d5mr13233272eec.10.1778524478264; 
 Mon, 11 May 2026 11:34:38 -0700 (PDT)
X-Received: by 2002:a05:7300:d704:b0:2c1:7b61:8731 with SMTP id
 5a478bee46e88-2f5490931d5mr13233248eec.10.1778524477693; 
 Mon, 11 May 2026 11:34:37 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d43b4sm14235574eec.11.2026.05.11.11.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 11:34:37 -0700 (PDT)
Message-ID: <d0be855a-2fab-4dc8-a70b-bdbdcded47f2@oss.qualcomm.com>
Date: Mon, 11 May 2026 11:34:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <90ea3dacb27252a623c0f95bad334e4702222d83.camel@linux.ibm.com>
 <40f3f863-04fe-4eb5-9672-a21ae4fca950@redhat.com>
 <3b5ff524-75d6-41d0-949d-39bbff0558bb@linaro.org>
 <2a4981de-da3f-44a9-b422-3ba9c24b7dab@oss.qualcomm.com>
 <4d0a80a8-396d-4ce5-ae8c-ec5581f5e90f@oss.qualcomm.com>
 <9ec245d8-4a3f-4896-b633-c17c45b328f8@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9ec245d8-4a3f-4896-b633-c17c45b328f8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RNLttPoTi_tEkyeoBdLLOxVUkkqvVhb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5NiBTYWx0ZWRfX6xB8Vpb3fJU8
 9/aza5b/YaGxXxGOTHipUfL/NzF4NOBTlQCi95RL3CSZd+WAGnsf4Aabjrp8qnAzbidd2iiqyUC
 HzbgjMNVv02MFIxCbsy+nPQAkEaE14NfGfaR16sFnZpTBQ4xn1oCaSnyzjdu7IGR13FrM2UplU9
 y32w+wZ8f8mX3yb9E6mDVPeXxpQLpWbBJmJZHTZ49PC5MS+dVzuSF52ta0VcoL3lCMLqoFNT1KX
 p4uqewakKei2jbuTcIcC6ItBviQ9qwGtzL9XiOOhMhYObhEhy6R++4lBZHMuAjPoqrwgCv1ys53
 zKby4omw7m/EDlEu6S5UU56yK5GiS24kVyA3/z48vm1g+rXMvJqBpEEGrD2pZiZx7sO3JC3BJzH
 xt3HzsXsHgi4slSY3wvw7MaZzn8+Bxt2xJNyx5+cUCJQN24NUpB0UBMA6uhTnsUIxkGt5bGHX9j
 3gneTBkQT/UMtMNOgmA==
X-Proofpoint-GUID: RNLttPoTi_tEkyeoBdLLOxVUkkqvVhb6
X-Authority-Analysis: v=2.4 cv=MKRQXsZl c=1 sm=1 tr=0 ts=6a02213e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=VNAxQWZTLBBph186XC4A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110196
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

On 5/11/2026 11:29 AM, Matthew Rosato wrote:
> On 5/11/26 2:16 PM, Pierrick Bouvier wrote:
>> On 5/11/2026 11:01 AM, Pierrick Bouvier wrote:
> 
> [...]
> 
>>>
>>> The only possible thing is that code becoming common skipped some ifdef
>>> that were here before per target.
>>> So, something that should have been poisoned has not been, and we
>>> definitely need to identify what it is to prevent other regressions like
>>> this.
>>>
>>> Regards,
>>> Pierrick
>>
>> Fortunately, it was a much simpler bug, where we incorrectly removed
>> cpu_models_system.c completely, and used user stubs for all versions.
>>
>> Attached patch should fix it. Can you please test and confirm?
>>
>> Regards,
>> Pierrick
> 
> FYI Eric already posted a very similar patch:
>

Thanks, I didn't see it, as I was not in copy.

> https://lore.kernel.org/qemu-devel/20260511163541.192533-1-farman@linux.ibm.com/
> 
> 

Regards,
Pierrick

