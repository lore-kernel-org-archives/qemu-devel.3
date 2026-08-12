Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A225C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBKa-0007aI-Bg; Wed, 12 Aug 2026 11:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBKZ-0007a2-GE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:57:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBKX-0005Z7-6s
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:57:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDcgLg104699
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BOcolcaa72g7qHVFbjnaZ4KobcI26QSgxtU7lmEkjk8=; b=oHioZKmkig4qFdmZ
 JGXoSrCTnqYlWnFbY6OxUclF+lOgv23OO7GZUIFmXzlYOLb0fW0aI7lXfwK8CFxu
 oDCxRNkHimpOUqB5v8VMRiTK4MXrsNxH+NAgQeIc2aLrRn8BBLx2cSxP4NNOhKmi
 XVbT9rozBEn4wSf8ORTfYlI/JbJBgCYNognQ+2iHW4FxHI1u7BJR5PCAU5MCLnjF
 L1k6wo5iy2iDuEBiJKFjtz2qoiuW48up8ZFRMcvZC5hfJlj5xco7AhlTdqSPCrCP
 aCQ/kXtHRlUnxh9DfQzXpTy7QxzEvrs46UcDjsoUscvk1cZlXDxsT+v4EpnyRvoq
 VQ8ulg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nuchtaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:57:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so1749204a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786550243; x=1787155043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BOcolcaa72g7qHVFbjnaZ4KobcI26QSgxtU7lmEkjk8=;
 b=c188bD44P+z+vEPSoTQIYPZEskD55jwdeXEyKBxBwJ6Z2saEOCd5TPbgx9Wqq/lBn+
 KMh9EXriGEQxaNDe6hyM5aFm6OJlA5PIIp3e08FwDcF6lorI+gmla+t7WHGzdFY8qhWX
 aHByCAbeHe70eytQuOAkRXhCfxxy69ZClC1PjAeWLFHa5+4Z1uF97U1nVyRVEHCohGiv
 DpUgfalVWpi9kpuv3jJt629PXjmsbJE2SAl9gUgCQvhLSCCKuWaQ6+m9yqXaJJ/yKhcB
 Ntzz+7tz/FEHVNXYqtjAE6cr+0MrzftLIepBMadCfooiRWoYrQ9YyvbYDMPsw/Apk/kY
 cJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550243; x=1787155043;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BOcolcaa72g7qHVFbjnaZ4KobcI26QSgxtU7lmEkjk8=;
 b=ikRIXMdBeO61d7xIX4zVDvbkv7GNj9UorI6lMYpjqBLEIWP9ekpoDnZg2lujwyL200
 ERXBmLr0qOCs5sVQ3yZkaZlRdojHPKQ5h4vWp4Ihg9RLzT+wbDhuw9ly0iSXSUzqiUYj
 pQyjT/Cj3mFP7LKz80hj4EULb81Zf1R6AGyTAA0oqO1/SsdFS8u2S/EhKNvwPGjbOEWB
 BJlrgZyikH9mI79QCVAGKUpTpZSt+BPwkLdjcfpypw1f44NW7bmSn5NJOK7qhtj1++gu
 oUxZA+u9Fh3/6wm817+ELWCavPxzuVd/Eyzc/kgMsTG+U3TKW76arba4n5RpAaFBLvAP
 Jyow==
X-Gm-Message-State: AOJu0YzHAiIwuBVky90yQoFjFv9yx1Yjr6ZNKdXO96nYKt3CzDXatsy8
 GJvpgStGW6/t9PtH9ZOy61VUeXMNmRGriAdVr/fUpjidaikimVgJ1QwPln6JRQQOSHi+74PtXUA
 +MgsnS8fza3V+Ut6nv6QbgdfMca1fsV5pa4tQWsyhvR1w9iY2TERhEyVz7A==
X-Gm-Gg: AR+sD11ESVoVhvddnEnRCTIM+3Ps5CdwWBDbR2wSCsKeLpt477A/LUDXmFjAs5+btBL
 3mFfg+stwUC0IpXs4tBMEZUGFYQ5Kmm6PvwUhOecVkVldVcR5rxyIH7O7uqV8+Q8MZseGRJrryd
 eOhpEy0JzvopKawlBH46dEXbeYz+Te/Mj/Khnnc77MWhANGWBbPKUft2V+/Icz0mRvY4m+r+gTj
 ug74/tYoErjeUMgiw0kqYYo5n5Xjy4T04X8pUDpQoRXXr5GfdRwF0caYnjhpkFhJvQc/AvaAP4V
 7IQ3edo96WLHyTCg2667MVVdnq1cPkAmFgPQlCTCTE1vIAfqPxkJ7rS9tGq/ztfEZU3kZLEh66E
 1Nts7n0vbmhI1m/bLMxo+raz3ltR5wLd93xLvHXcg9OaeeUoU5qmeVNhm1ltcqLMFyGW0
X-Received: by 2002:a17:90b:4c84:b0:38e:2e16:859b with SMTP id
 98e67ed59e1d1-393017e569dmr6705560a91.20.1786550243094; 
 Wed, 12 Aug 2026 08:57:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4c84:b0:38e:2e16:859b with SMTP id
 98e67ed59e1d1-393017e569dmr6705485a91.20.1786550242635; 
 Wed, 12 Aug 2026 08:57:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392fe4fb406sm1460657a91.4.2026.08.12.08.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 08:57:22 -0700 (PDT)
Message-ID: <9a1d9f99-ef41-451b-a8fb-fd1fae500e22@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 08:57:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 097/103] tests/tcg: remove remaining Makefiles
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-98-pierrick.bouvier@oss.qualcomm.com>
 <87ecg3za53.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ecg3za53.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mcZxF_jv1KkUVqrqfIZewxmm4I9XPiNG
X-Proofpoint-ORIG-GUID: mcZxF_jv1KkUVqrqfIZewxmm4I9XPiNG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfXyrrXr0ey+Pcr
 euJu9gLoiebQuvvMb0ckJoqP/M+OoxMotUUrETUSrCQNN1gUZUyCO5Uv01fHM4krn2Oiw91Ca2e
 eq/cWezqNLxA3IyXBtdxDN0ZJ2DpDdhrg+6Zw7qL2RcH9hVijrSgjDCwLzdvpYgkS3d9XL7TrBo
 mATlEdeZslht15A+Sis6xNLPcEyhTghkkXGP9IhgpaUs/oTHXm6JaeKzZYc8ZBJJvGWrPvgUcFR
 EJDKeWo0AuIza7Xmp5Bhg0DrxO+RHIfK/teghEl+kXgEJDWHoq2yVHF4ntPepaezA7J10yVb/C8
 7usHuu143UdaFN4+GIqT8FrKqXhuAtct3HSxVhHnnKQ4RpWV8xSJHmxeyXzhg9Ku5gIZqmLO2xL
 KWpDdd6Jg8Kzq2DcTX+tUyweRHAm3n9GvBZFg23LAM9vjTo54Onj0Hivs5ze2EDeaLeY/BJ54JX
 ey2QrutqkbIoMe+hwhw==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c97e4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=DlS8JDemCB7tWP6Nx8IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX4py8OLHECQgP
 7qQ+Ayptv7hdRyOOkEI0onFE6K0rmYnYpU9EFAp27uinmIfm2KAdV/VQXSCqEwfkpXj4fn+A0Kw
 euWmjhmbK73sQgRTud4Ze0Jh3dcQlSU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120130
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

On 8/12/2026 7:27 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> tests/tcg/mips/user/ has extra tests that are not currently run at the
>> moment. Keep their Makefiles until they are implemented.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> <snip>
>> -else
>> -# For system targets we include a different Makefile fragment as the
>> -# build options for bare programs are usually pretty different. They
>> -# are expected to provide their own build recipes.
>> -EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
>> -
> 
> Ahh here is where -ffreestanding came in. We should also check why
> -fno-stack-protector was added.
> 

I removed flags that didn't expose any difference in test
compilation/results, thus skipped -ffreestanding and -fno-stack-protector.

For -fno-stack-protector, I don't see any good reason to have it. In
worst case, there is a compiler that adds SSP by default and it breaks a
specific test, and it would be a good idea to document that on concerned
test, instead of globally applying the flag.

Regards,
Pierrick

