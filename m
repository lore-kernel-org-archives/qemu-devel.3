Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F12C9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 17:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAW71-0006XU-CT; Sat, 26 Sep 2026 13:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAW6y-0006X0-Py
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 13:22:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAW6x-0003FC-0q
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 13:22:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQ0E3793105
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 17:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OrYs5WwG0Dnm2L245fD1cFVeflHKO5PsRt4f3CUHL1s=; b=E0kYiaPMh5pxGT/2
 OdCya2xTAg9IAxgD6QZF/9UnvhYgH2m1bJ7n+K7K8PrWmLgJ1+qFsOS70vqLS8TJ
 oprYy2Q2n2EgP0EKP7nrrZ/+jAGCB6ZLP2fkKmeFMxclhAvltVrTW/SsS7s3lru8
 cu2zni/rFrj6vcI0c9xPYC6akYi+MIkw0UQz8YRp47JYpltV8stSoZ9Xn7J6au74
 Z6jZ6uJfPvsb03N6Ig9q+Zw9ChqVxffOWVEpOA9K49H0DWCMXn66vqR4ryg9/FdK
 qp4wLmbtfwYrZrCr51PmwPpbC+0OMDzzKBtLVzrO8lWiu4fFhR2e4sm1tjcJmqoz
 jhD/mw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx7b9s753-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 17:22:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-882776aae15so136992b3a.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790443372; x=1791048172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OrYs5WwG0Dnm2L245fD1cFVeflHKO5PsRt4f3CUHL1s=;
 b=D0bh9ha7WphSNhp/VePOoTEi1sXD7laVfUthNHTQprTWmKVntVBgiqN9XsluUejgRV
 EFvt+OHdiuABzixZ/iuS3c7u1fxj+PX0FseusS3Q+Fd2WZimfQ4Ugci8Nb1gvIZ7uHIt
 vHYDZ97mr9IG8y+wreN6f2td6YEUon+tnvUR7IN3ObksvAxcds9TfRoAQ2oll4nyVTl9
 Jjh6nnN+Jz8iYfwAR8hxdRw0/H5i5m3xoW4k9zje4bpohj78FCxM7SGxhDkiQJVLZw9W
 4Bcy0WKAUBzRdVsgLv+Y95ETcmXw/OtUi1Fz1t/pnEoDYZKweg95C5eAX+YW2Po5yfRd
 E3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790443372; x=1791048172;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OrYs5WwG0Dnm2L245fD1cFVeflHKO5PsRt4f3CUHL1s=;
 b=BttxJcwNYV1es+3OQ2LVH1EWc1oZBWsxnEujghAvvdzeI+fFWktHK0b/ZtF21w6IBx
 Iqz7Hg8TZEU7aklo3o3yRh/Rg16ROSlm49d80oFbF+Zj+/hYYi7oD7BElwrIUjfEHo26
 XbOdrhluaHBwzk3K3HwRbvvBSCREx9NQkl8tTS8DeWxFa2HwxwL/vvFOFmsd6JQeRuyh
 KvtyC28ubFccbgbuT8x1Dcmi6+K0pcGLH5Nrmi7UQtudMr6rdDwZHXkN1eESa6uXDPoX
 PzzJNZLBAIiq/+AKGkkFPFr2P3Xtfu5qIkHFSJkjh97r1VSZ8mM/Xr41yJHsLA5kh5Sf
 hU6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwL0tVhjywBaqhvFZAMv/Trp3sCvO7pnmicWT+Q487rwli13YsD/WiDrmWw9PSznkMbHD12JsPSTUbG@nongnu.org
X-Gm-Message-State: AFuF++mfzgzIpljpRG1VK4yFSNTFodAekJFf4o03wmilH0iH8aC2xn2u
 MTkvbgqRKmHEBmNhGW9whAfigK4BFfbnMECQUL316dN/eCd+Ef4FMc/An7EN/zzhP7ySQPDP8hT
 YVaN9YsxLoFP6RrJrDtcLYU4v1yyf+f4JWatqSVdKI8+DZIL49WwvjMMIHA==
X-Gm-Gg: AYBFou1xkH3L8fEy+p0zfJNXoqqKpVSvUDoZ7/e7mVb+zE8xX+fTIyZ4XrlmoOa8m8k
 TVdZ2A9r0BF/GLKXdLo6Yg7K4PF5P9AiNdUJMIrzaK0+NgqINTz/IhKxumt0Vvg1dYA9BI1C/R9
 ObZzumJjExbIak8SGmheOJ5evjZvZM0+D7F3DSocuiGVXLMr+HS8mHBeOQkB1yc+O/Ik7rCJEKp
 cqzyFuq5DM3OPyu7F43weO/dn2EJYsaA49hA8sRjDUzjjYrqbfYrnWFxi1CVwB+XxfuJhxitiaX
 R45SYU9ezn8xJkddNgQ1xTOAquprtRWrPWgGuxeuf13BiigyFeNw1ncUB7miT81hEDkfkHgm5db
 i82XUCVzSd8scelKdnspHZS28OKew8/PPpzkEdDDamIDWASXXXJTCug==
X-Received: by 2002:a05:6a00:8c8:b0:86b:922d:6aa with SMTP id
 d2e1a72fcca58-87e9c543ef9mr7279945b3a.1.1790443371764; 
 Sat, 26 Sep 2026 10:22:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c8:b0:86b:922d:6aa with SMTP id
 d2e1a72fcca58-87e9c543ef9mr7279934b3a.1.1790443371228; 
 Sat, 26 Sep 2026 10:22:51 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea18ebb7sm2403519b3a.18.2026.09.26.10.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 10:22:50 -0700 (PDT)
Message-ID: <ba38f0cb-e9a7-4aee-9d10-f6d5fa22c333@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 10:22:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/tcg/mipsel: add float reference files
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
 <20260926010053.2840-5-pierrick.bouvier@oss.qualcomm.com>
 <17d2b653-e32a-4c0a-b035-ada9e9762360@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <17d2b653-e32a-4c0a-b035-ada9e9762360@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA2OSBTYWx0ZWRfX5MNBhIzbFgix
 3bJQOgYym/9+1u5yEstyo8eBj1OZbJdtRi9nRe4FSGDINAKauM9J8eTvHLLoJB8ajJPRp0JFMct
 e4PyBXeWmq+DQ0M0YHE9/dR3un4/1DM=
X-Authority-Analysis: v=2.4 cv=d8FgWhjE c=1 sm=1 tr=0 ts=6ab7ff6c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=jlb3HRkaPq3sopqIlKAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: nE5-B2aS9siMoIp8qYQ_Qb0EK4YK7w1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA2OSBTYWx0ZWRfX37LFnDb4sQ2k
 Fbn7tuO7hceKy0UNWKa4Fu+O0Vk/ljd4d0UL0xJWjENineZFC083kQf2Tl2sSwhUd9ao1fK1zGV
 6mAlZR/iuiSdF1TBKDEPJGjgYT2vzvMJwAfVsEfFEnYRqjfPBgMceNOsNrHLvP8CRqb1quCE9BH
 QHcmBFT0XBF09XP3xQcGF/BplZb5zyMHxfquwQFRqVSnak+YqDiCA66IZyAPiT7IyqHmdFTApMO
 M+uIRBWYt6sVDGbq2EFVL9jP/U0lQiZeIkYb4cBDvIfDBmGizbcHCuoWwOZBLwe/ZrO0q2rAePB
 q+Xm2KoaN917aajb/OZKWlgubXCsZDvxXfdogoIX56Kx+bkQa6CHED4u4yi067bFi8LNIhfdUgh
 zSjZEqq3WJThoieI949+AA8NGmW0YAVmCc7+TWLqf3QhwMfmGBnL1DsqKU/dbvku5nK/tkP7RCw
 i4o5BR2HoNF58hPhnWQ==
X-Proofpoint-ORIG-GUID: nE5-B2aS9siMoIp8qYQ_Qb0EK4YK7w1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260069
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

On 9/25/26 7:35 PM, Richard Henderson wrote:
> On 9/25/26 18:00, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
>> ---
>>    tests/tcg/mipsel/float_convd.ref | 988 +++++++++++++++++++++++++++++++
>>    tests/tcg/mipsel/float_convs.ref | 748 +++++++++++++++++++++++
>>    tests/tcg/mipsel/float_madds.ref | 768 ++++++++++++++++++++++++
>>    3 files changed, 2504 insertions(+)
>>    create mode 100644 tests/tcg/mipsel/float_convd.ref
>>    create mode 100644 tests/tcg/mipsel/float_convs.ref
>>    create mode 100644 tests/tcg/mipsel/float_madds.ref
> 
> What are you using to generate these?
> I noticed that you did the same for other targets.
> 
> If the answer is qemu... that's bad.
> This really really should be from proper hardware.
>

Yes it's qemu. I understand the consequences of generating this with the 
tool we are supposed to test, instead of real hardware.

My point of view is that if we can't get access to this hardware, having 
a self-reference is better than nothing. It trades correctness for 
stability, and allows to catch any change to review them.

In case this approach is proven to be wrong, and changes are too 
distracting, I would be happy to remove them. It's easy to isolate 
concerned tests in a specific list, and include them only if target has 
the reference file. Just saying this to explain that it's not a decision 
based on "it's hard to express in meson".

> 
> r~


