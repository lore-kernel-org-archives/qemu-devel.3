Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C00CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpKN-0007NP-Vy; Tue, 12 May 2026 11:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpKB-0007HU-Ig
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:47:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpK9-0001hm-Kw
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:47:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB5MOr591895
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8CuchrkskhDRphl78RKFp9vUfWlztKEoqN7XftUFcao=; b=Z7dR7Sg8EE2vi66c
 mAkHrCKnFWXzzxnwBipvCuNm95cgy2kdqr25nePBIAXwwNu/i1F6NWGRZSvQcmHb
 Xhyo7R6zYdyT5v7GwKjhRhAFNRQYZFRpeJJ0HXlx9aC/D3E9eatfJ77rbw6O49mc
 j3Tdhe2yi8OAwqxkOrs5ePbN6pnWaTkNbLrsSfOdd0stV7Qg9j73rqjZS7JIlqAe
 CoAfxU9VaavTF+FbmBV7enxHtZ1y5v24H/Mff4DSWJN2tBv0l4TsC3YKUHMtsybj
 nRutWIzC7UjGH97IhIAnKzq1quWRoi/DYIfxUsTYcHpJz8cIlYtpDxQsIoQZ5XSw
 j59Nxg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319s4u1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:47:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2eebb099efbso6731129eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600826; x=1779205626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8CuchrkskhDRphl78RKFp9vUfWlztKEoqN7XftUFcao=;
 b=THKnDVFyGnnpvhB59ldv8nqgZbVnju3DcR6W07ocSTEAtscHifBEuxBnARrHQCvWca
 oByDJQ3Kh7UwHBf6mfLSmoNVO7GvzJrEDlUQ8RWPOKx+s1Sq+IxzSd4QCYnSBQ60IU8H
 2N4eGbQLRIcFsyy/nmz3xi3uCLvvFzQlSDcbDd7Xl5wRfzxs6el18efw+0EgImHbykz9
 kL05vf2mSl1dnmhQWPNHYVxascROXxgPlwvqMMTo+Zsh/k3kEphc6Mowkpah7FVGIqpU
 32OD24Apz4ki36Vh7/tmAst+pg5X33GWSIb4fDyurlbFSe7+BhCWRwGqcCktXoGK5N93
 N5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600826; x=1779205626;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8CuchrkskhDRphl78RKFp9vUfWlztKEoqN7XftUFcao=;
 b=atTNqTqLcszob1Rw5DX7UhI8Dcp0xnmGJQOqtuliBlwh82q/6gi/s6cjTGApYR7T/P
 05frarty+YI4wPSNOEhJkJclmkC/QDrfSheZEhXYtKnSAKyYkzVGipLDAM9wv6ym5BYz
 Q/lGxyL5HKLI0ZuXisSvAzE3t6u1OzHAy6lXP9J74horgHxb/13OPTCaBG4vx48iGgrQ
 IsNl1+ll7UXtf48VFF98ms8ufULsRS1lZ8KIKb0s61VG/1Na/O2FTpIDmCcMW1WzB+QG
 82Qbp3RDO+82RH/rRMgZWUTfV62zO5DwhN7/w9ZMDiXs3VoHHFTPz6i3yDwTXaaKpP0/
 aUwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WXz2Vs/fwc3heO+TpUzQ1FZd3dMu1g6SoRP2UlynSO2RbSJGiS9ii0HHT9cjQeg0UXmfEIC60/7Ix@nongnu.org
X-Gm-Message-State: AOJu0Yzsg0Cqg9TFAUejy83yI8I8dMPxu+rHtI7WAvUQ7cMHBKatA6mV
 u2T8TYv35y4dm7SbR2Jn2aK2rYIZSZHoPyGwIaT1sR7B+RK/qRgFgmApWST2UOgBIH8xYwDuFsX
 WQciladovizeyVYgPwJadqIsN8fg5VQNI0HWGTl9jDez/F9nqgO7h3CETxg==
X-Gm-Gg: Acq92OEd0iBZn6Yd5vXNIg5zvmb5V3OZLsFFDSWh/ATHnAuTT0WHELcfypLe513Cv8d
 mWitk6rLrkVPuYSR/13NbBSUU6/PqLzzFLrH4jGAX0fhM/XvI1aUNdbr8HsI+46LDwxNkYZpxyR
 obE3K6HPWIElj8jdCoqdOwBKm0HY7o15f9iVA1QDnXObIuLL07XQ79Jgbfcv5PQbjUtBH8DwAz2
 D+6LpZZW1qnqunMfp39zuEu0/lVSQRe2LmVTa3KwA4RSEqT5LOnRlnbLno61Q/xfROkIK4BgZlZ
 /VRJp5AYXGns3Ks7nr4Vyy2but4crrMRkC/pKSiYBGaL39kNPSLR55RPmFGvXvQB97ZU1jDx/4a
 Zs1/iPoqMnVrkWU5vKPmpMCegmbZwpc9nCyZCLx2a2HO77j8ngpXgz+JOyv2DX+3N+ybDidoKFA
 yfWX+LvtF3iARGbA==
X-Received: by 2002:a05:7022:388e:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-131853f4473mr15664314c88.0.1778600826358; 
 Tue, 12 May 2026 08:47:06 -0700 (PDT)
X-Received: by 2002:a05:7022:388e:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-131853f4473mr15664273c88.0.1778600825740; 
 Tue, 12 May 2026 08:47:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327875a269sm19450769c88.13.2026.05.12.08.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:47:05 -0700 (PDT)
Message-ID: <55ef04eb-b5c6-42e4-b3a0-679e29471eab@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:47:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] docs/devel/testing: expand documentation for 'make
 check-block'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-10-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NCBTYWx0ZWRfX/yB7bKM5dd1H
 DKDex9xx7MJt6i7SwspGnHtudXLJnKcGRc8sEnyN0JggBbF97SOLE6GLhAAgmUACC2Q5fZetoh8
 69ekRz4AN7ajRZKo1YsQa76zoBJZvBGshtH7Rl78doh3+s25N8CFbqh2FGyBgHmP8JaD2YDRDQ1
 C0oOZ/FaxOiBlMmAJX5vfWU7lmzLDn2NEPVtHPLktQZqaKHK9Ixrq5S2AiT3Dkm34JjFnMn9gsg
 HUt8wv8Vp7jCy+TIMcgqnUZr+pg0u8LatfTYI1t+2rRLFUni6T34QMuT68wNTO8X9349GSiYeEk
 JZJ3Wc/SQz/o05Eq7LG/UPx21MDV56DK96ltW9aiQ/yqDTN+0F8rQuvnVu5VKD01B/lguCk4Oum
 ikS/U/zf43tYMEiD0nQA2omo0Kyd8rGstE7YfIodXN/z+VEL5/FVI1aYI4KD870z8q2vfpWrns0
 S+EkcOSzexHDsIy6UFQ==
X-Proofpoint-GUID: lZzeSkyxJ2vRwsXzjw30FxldvcHPMGe5
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a034b7b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=N7U3_DaEffYtyMzDJu8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: lZzeSkyxJ2vRwsXzjw30FxldvcHPMGe5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> Explain in greater detail what 'check-block' will run for each format,
> and also document the new format specific targets.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/devel/testing/main.rst    | 25 ++++++++++++++++++++++---
>  tests/qemu-iotests/meson.build |  2 ++
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

