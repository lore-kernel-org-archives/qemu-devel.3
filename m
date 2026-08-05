Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9F7C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wreOQ-000445-OU; Wed, 05 Aug 2026 12:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wreOK-00043k-5T
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:22:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wreOI-0007Qq-Iq
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:22:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FV7QP3867581
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XAY6vUGDcy1uoB/eyXABBrfFK+ZRrpSA70HzxsCgdaI=; b=MJi9jZSv6/y+mKke
 OB6UtGs6ULgg8vv0HnqjL9+NBikiZAL4Dvskla1WulHo6VhZ+Sbd3L4slgZgkp+J
 XHIXhRhZQ127mUaFB4zAniRyWUvGIarfiL6rGAJvjAE5xjO2jNeQn5MyuhpfHZCq
 VeEAo45KvPnF/9Gvez2HYIYkkVh3BdJFwjQBrDqMlfv+lQKJ4b8vb6rAWMX5o8BE
 nco7xW1C07vLsppuJG8RsLqj28I5SPkls2pcWeTE6d/5bWUhI7saWx3S0m8iLFjc
 7+Cd069uzLbxkf4FOpzlVOxqROlLxf7elssWRlEHVm7sjP7QPzde0McmmBnxDiS+
 TwbK6w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5dk141f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:22:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso15077745ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785946968; x=1786551768; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XAY6vUGDcy1uoB/eyXABBrfFK+ZRrpSA70HzxsCgdaI=;
 b=BG03QLulfwEYB3py3iy5eQ5BS7cDugQ4vmNKusj1gEDs1a48uvcRUR4ESmxkQkzFHX
 uW4PxPD3ZX83HtDexAHjW49bMhO1iCZQuEagff3jsZaArFeMrvb9icEDrKBD/u4zxYNZ
 CKRs+i9X8CZmnqtNQ5lfQSJzpWskEbRzjrQ7pq9x66RHbTHY/z9SqeXY7B2AzLdqHeLU
 VhU/LNkzsuLiIL8relo+Whouoqp9s4WTZdKbNxI9tu+4foZQR3KJ8Gtli8nEtU4QAMkd
 HFcmcC/sH/1MWmeG/UkpXLphcfFaVO/Jxfm2N7lyfsa+/ECTElw2pHggsK5dL4vyRu2p
 9LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785946968; x=1786551768;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XAY6vUGDcy1uoB/eyXABBrfFK+ZRrpSA70HzxsCgdaI=;
 b=KmoAOLAgeRhtSAYGWaCvE0gFjhDKO6+FwOnYu/YtPOmWP+asZIgs6ZHhd027ycZCTB
 pDPeku3JDE7c4erhpoO/nlnoMmmsDOLjgYTc0Nt1Y+WwZTTfM6GVwPuG84VnFHuKBYZY
 5XiLA+Ua1H0vY4Vh3ggbNaJkSkCATrR8kdDnq9JiDrvilTeriNB8YKuaTEF8zB33CD+T
 Z9Iz4cKiPHxJ0uRa9/19KQO8ycLnQq4c+xaJanxbtO6DBkMFJcCBeogqCVH/4qWuByA0
 OiQEmvAZklEQneu4vCxjzcAaxsyMJuqsdd4mG+ZWLREZeHR2ScHipMDQECwqombbZHL0
 gMfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpf4UYpdL1g2z1JBdQIDUffX2lW98/whor9c0Tns9rXYiZLdcP3z0M3VVK9DS1vNfns0HoiVjZTStof@nongnu.org
X-Gm-Message-State: AOJu0YwIvKVKRteyuXwXlr93cgFYeWqcXV2Tnw1+miedbMfcvBi2Tv0M
 Rq8RAMPLj8NK4dROM1+i0AEJczaxEoxQhthrXlF8HXYoV1rYMleQWpzqDswCQCc4inBcYC4tGeI
 58ZK7PaRLOByItlVjzBbC7ANyCp1fSnEvzquDH285VKhh7UACdXhTG/XM0A==
X-Gm-Gg: AR+sD11tPEDchTGpvFbWjoFjCCLIN/pg4aSs+n3ax3Sm8jxkduMdbsvx37cSkijklnK
 95ty66GoteyV+qR/S25CnEbSRq7Y//yZvhhXLt9LJrWcvd33bTEZ2LhkDU8S3CXE4p/tWuQBIoC
 GO9yl/n9TmPeiNwLgcy1DBgtrA3r4Xw2zrQT9xKBuA7bWsnBDSmzHhB4OnA5R9Sav2ve2oHS61H
 s7XxV8CxOqtAjf9RippWnJdHq0KYh4zwe/Pyp0yWbEaewWvoZr5SgbY9yXq+jzE4cS1ROZ56duN
 5P99ASieXgvz8sQOO4XcpGC1QfRxThIcXhBZEy4MlUrhWQqg1gNnP6QVUqEH18nkMcEwsCOnJJk
 nYrJoT2I9+g42DFyIgrUYgPvojEqjWmS9LP24RhYkCjRYNLeEf5cUxUG/pUNEI0DDOYW1
X-Received: by 2002:a05:6a20:728f:b0:3a2:d316:de53 with SMTP id
 adf61e73a8af0-3cb85c0732fmr8819897637.0.1785946968067; 
 Wed, 05 Aug 2026 09:22:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:728f:b0:3a2:d316:de53 with SMTP id
 adf61e73a8af0-3cb85c0732fmr8819817637.0.1785946967602; 
 Wed, 05 Aug 2026 09:22:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm24192124eec.2.2026.08.05.09.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 09:22:47 -0700 (PDT)
Message-ID: <4604ff43-773a-4f19-bc1c-e17fed4cd077@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 09:22:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 057/103] tests/tcg/loongarch64: system tests
To: Song Gao <17746591750@163.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-58-pierrick.bouvier@oss.qualcomm.com>
 <968d727e-35ea-81c1-ff99-75f7c6095677@163.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <968d727e-35ea-81c1-ff99-75f7c6095677@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pWlSTEaPy-zaY5hejU3rzQmUGzRqgTRj
X-Authority-Analysis: v=2.4 cv=Or9/DS/t c=1 sm=1 tr=0 ts=6a736358 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Byx-y9mGAAAA:8 a=wdCRf7Nk7SDVvOrTnMoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzMyBTYWx0ZWRfX9RFoKOVvvMB1
 mAJXeooSAMfA4suquTg/epXCPiYT7tA4V7gGEpBF6RoyiGVKPAGaY1QFZlWPmJoPNQ8nCcFEh5Q
 beEX9fQYu3yAa6YuQF6LLYuBndK3m1fZlBn/qE9/9+31PyqDpttve9ntyE3SoNs5NlhrQoGlXrl
 nY3K7nRSE/DtwtURPhX3EHngo/V/gUJ5lSfw4V8434v4c4fy3sslc8owB+1Pbfvlm2oM6qecqcJ
 tF0ezqr00FuAV3G73lQbBEC5MmAujpc/4ZEsnQaJGDrLEIi6AdDwfu0hM/fL/IV0pRuWMteUyEa
 hoRer8yjTk9dGrY5qE4u2BOJ9282XxxafZJD8wQNvauusxMHLssu3du8p0kc6d0m74PhPsLi+Hh
 0oRg6rjgeWpTWCwUTo38IKFBMYPrCo0VS4PNySVTH8xEmjZQm3qznfLHD+8sJgdAD7TuGnC/Sth
 6euP17vfzJqKqi0c+hA==
X-Proofpoint-GUID: pWlSTEaPy-zaY5hejU3rzQmUGzRqgTRj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzMyBTYWx0ZWRfX8MruSmB0O0On
 eWGV8fMibzgpJcgnUGxU2U6BpvxHfxiR0RiRWQxEsSNCVVXfyl9E541cWjRDu2GOV/Q/crjhgf6
 k8AEYjv7NdhZaY+F9Vc5HwppdLGA1TE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050133
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

On 8/5/2026 2:15 AM, Song Gao wrote:
> 
> 在 2026/7/28 下午12:42, Pierrick Bouvier 写道:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/tcg/loongarch64/Makefile.softmmu-target | 33 -------------
>>   tests/tcg/loongarch64/meson.build             |  2 +
>>   tests/tcg/loongarch64/system/meson.build      | 47 +++++++++++++++++++
>>   3 files changed, 49 insertions(+), 33 deletions(-)
>>   delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>>   create mode 100644 tests/tcg/loongarch64/system/meson.build
> Reviewed-by:  Song Gao <17746591750@163.com>
> 
> Thanks.
> Song Gao
Thanks for reviewing loongarch64 Song.🙏

Regards,
Pierrick

