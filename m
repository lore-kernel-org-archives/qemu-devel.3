Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D95CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4h7-0006C3-Fl; Tue, 23 Jun 2026 13:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc4h6-0006Bq-5l
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:13:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc4h4-0004uj-G1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:13:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBZMli4017320
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HjoAtcgR/+JXCPHhOVC3KzyuUtXb1iPg853P+LtiVKI=; b=ASwVwbDnmZhI+UrM
 wuDwNc8nNHLGPPqP50WQqunlRWfPgnPe3hlZbm5Joy1OkMbkO8aX7FeNnwTBITTl
 CdGSQGPCITVdwEsUrD96bXuTtbzjxdfMtQQFrs1d7+T7ndS1R19cp0fzbw3B3KRY
 zqEcWKzkw3DYogBV5V8CMhTUKwYmz056aU0yvjnDMgRuguzg9YYEb4C4YwxMEowP
 aLN4TDs9DkgkDiRI8/c2t4JDAFouVJ+0PCxkNF5Vkv4CJ4DpXdnpV23jdymMPyqL
 SnDlW4zJN9vLAoMrt6JUPDE95TpVc+1dcYvU9ccXszdZaaA/PYref0OfCo83qDZB
 ayNzkA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjkgy9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:13:49 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139c6673856so145635c88.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782234828; x=1782839628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HjoAtcgR/+JXCPHhOVC3KzyuUtXb1iPg853P+LtiVKI=;
 b=gqwKw14EgfBKEAbBwnxOqXLqdMo0kusc1dTWnFFeWkkyltZvni0MuM85fjLxJEjUVd
 vsf2p6C9Y4EmVWusNkCq1fAglY9BvfHGZQeOxQ7O+vV5ZaMMStOBu1HLVZyENhDO4Bjx
 VxXAtdgdz/APkbhhKsPic2cA1KewGl3f+mGc2vkDcDkgQC31cBFM0cMKWGKZfF5R8xIJ
 TJGutMY7p0vRfy1UQ9/jZ5KQy5R6EXskFXFd3penuDqZTLaaRdaahvD70FdO5rdi3i71
 uQJOlwde8ww6RaMUQLqeWQFBuiFtoY9ACnQJd+OYaWsfmPox66rJGgTotr2vooasJZtc
 leNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782234828; x=1782839628;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HjoAtcgR/+JXCPHhOVC3KzyuUtXb1iPg853P+LtiVKI=;
 b=BoQpC99aXVH2iNl8llbnbMgyxSYymg43NOuCaGyyN2mSqkrA+Ue1R6yHmgAar0BAFc
 X2aJoEVnik/BmCVEwB+KOCWMJgBj12zWYdEGPBjEkDbvnLgHcu+LJdNQYkvtyWfFuyMR
 OFGb9jCm1v0K6YovKcyM0G+hdgFJQBXGKaIAPdoOgsH6c66RDGjQICQk+Vyzwa+kVmyC
 Wa0+Zb2UJoEmx2wf/6QZtz875th+H1hXfsOOz/qbs4ICB7ge784LFsVzikDnmviNywer
 yQsUMPIaJoov5NcDAj9EUiWm93az4G67ILKv0+C+oebS80wWdaMXGVKTJX8CedJP5aTG
 Ms8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xrxK2sYjHQKdY0S0QE1XB0yYzmeVE7AMap+zAMoGyma2Tojwu2n1EvUb6q59D9+Orfscik91RDRer@nongnu.org
X-Gm-Message-State: AOJu0Yw6KwFQ0Jua4ofvhnhB5mIgKL+cLSMA2J/gRhWN0FBLqEB772db
 iNJgoMiEhusLgAo8/9te1Z0YH5fEaNmk+Z9mik4EbrxadHETb9wYAOiqTiIWYTrvdV3lVmqFrTc
 cJuFnlEvd1uvVtKebp21Xo/7mqfha/1A8jaayQSTR+jKCTAYb7U+DKHJdVg==
X-Gm-Gg: AfdE7ckiYpvwyqWLFmvtiWhYvXfXjA/fv3w1RQ2A88oCK1MeyzskDgEgg29qowvVPl6
 bEohJatnAlhiN69YXq4F+q6Obx2rZG+oJtpx5E0g/sN5UE6A5w2JYH4NJMUwadZsMuNiGtZr1h7
 xpz+3viWxBk+XwYoWmReEdbUGLpunCGQuz3tsq60AegHHSG92y89GvsAm+18dkEQowXP0W8Qs+U
 hAn+Gf+212J6UjQO2EkIHRjJlK2UMOaB4ePPEiEnAPwxzjWF/+Fvd1NyCgiaUh+4bpEKIAub4e+
 p606GmBAg7zVt/4im72w4N3jwOuMFobEgK/TR8zlRro169aLAtAVHWqA/cKR1sv6YTGf0ncR1Ur
 4fF3Pfooh0LOBTA/f68W0itv2ieDztIZko85HoEvAX/ZVCfi6/S6+eCSRxA7z7pEf8hbJLnUi1l
 LkUZ0=
X-Received: by 2002:a05:7022:f68e:b0:138:148:6a28 with SMTP id
 a92af1059eb24-139c6f43251mr2401111c88.18.1782234827756; 
 Tue, 23 Jun 2026 10:13:47 -0700 (PDT)
X-Received: by 2002:a05:7022:f68e:b0:138:148:6a28 with SMTP id
 a92af1059eb24-139c6f43251mr2401076c88.18.1782234827100; 
 Tue, 23 Jun 2026 10:13:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add5824csm13591625c88.10.2026.06.23.10.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:13:46 -0700 (PDT)
Message-ID: <59603458-a668-429f-8864-1bb351f68e01@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:13:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: disable macOS jobs in forks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260610091700.2772973-1-berrange@redhat.com>
 <ajqGm13E8eaRY81j@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ajqGm13E8eaRY81j@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0MiBTYWx0ZWRfX66zFVQbwbi3x
 fVYEWxCLY9HGxRmsW/jLT3+0PaApb+zbYnUwC1MMrU6qpG8UhSQJCMM4bMeN76DhjjxSJcqx+Nw
 R1oJCsttChl7uTxONeaQb5l8Ha/zBE2zi/9dDiwwBJpnDaRSLme3za4omgDczE7VGeMrisCdMH4
 vI5J+8aOXSFd3PewD+knkKBt8jpLTvTy0Nmp6bwUUluyuNfMQGz9w53C8HEiLhczm+wtRIGsrjz
 +POjNEvqfHSVU6eeSAnVlsoeTY5PwZ17VvV15rIWJs4Tc5uadfGY1o0+XnwTUQ1eVFTMJxGOiCD
 YtX3xpGSc/WKpN9+EU8vQZXuzIzCG5EuoHpiMtuZBuKycMqlFHTkHm3G3vqBFQApAhvvPQ/lkjz
 BAHB+XPAjcKH8Caso+qIyVMR30tPDE6sj0Plx+5Xdnvv5MYXVwmIm7CNboGfbXCVq4zx3gO7Y+M
 zdLkt2tEWIvZ74vkENw==
X-Proofpoint-GUID: Px1WUYTwB1-XIH_jrFNZlJKgsrsH4gNg
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3abecd cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=H7NG89G6tyxdvnlhGt0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0MiBTYWx0ZWRfX+GY3u51fhkLd
 0jQHklcFM2N7eERP7CWEAoNCiuGLo8jgBnaqA2LDCjwbVVVvXbNHykFTbY30r4CHCQ8w/pbrqih
 7vKuI1PeTQQeXu/Ossr2WDOyrNyiBEs=
X-Proofpoint-ORIG-GUID: Px1WUYTwB1-XIH_jrFNZlJKgsrsH4gNg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230142
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

Hi Daniel,

On 6/23/2026 6:14 AM, Daniel P. Berrangé wrote:
> Hi Alex,
> 
> Could you pick this one up for your CI queue ?
> 
> On Wed, Jun 10, 2026 at 10:17:00AM +0100, Daniel P. Berrangé wrote:
>> The GitLab macOS runners are only available in Premium and Ultimate
>> tier projects. This permits their use in QEMU upstream via the OSS
>> Program membership perk, but this does not extend to forks of QEMU.
>> The macOS jobs thus need to be disabled in forks, otherwise all
>> pipelines will immediately report a failure due to inability to
>> access a runner.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>  .gitlab-ci.d/base.yml              | 5 +++++
>>  .gitlab-ci.d/macos.yml             | 2 ++
>>  docs/devel/testing/ci-jobs.rst.inc | 7 +++++++
>>  3 files changed, 14 insertions(+)
>>

just sent a PR for it.
https://lore.kernel.org/qemu-devel/20260623171137.1847038-1-pierrick.bouvier@oss.qualcomm.com/T/#

Sorry for the delay, I'll be more proactive on this subsystem in the future.

Regards,
Pierrick

