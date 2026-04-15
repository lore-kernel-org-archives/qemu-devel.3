Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2110DF4213F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD551-0003VW-3M; Wed, 15 Apr 2026 14:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD54n-0003Mk-VP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:35:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD54l-0005Wj-Ec
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:35:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FCgo9T2772654
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LRpSIe9kabTlcoSlutMpDT8sQNqdMc5VVou5iKFdtMs=; b=ZcopRCZNqVDaIEn2
 h+BXr49BxxEMytc78bZX3EMGGChlncJQN3HLiduo5JorW1nzWUymdf6kzGzh1vuY
 kDkJ8e/fbu2EknbXe1PBTkPR5W7Y+NMTZXrGpoalSU8umL/RtC1XrHXFmhQaN6CM
 92TA2whKWesEsOKLkO/kml3xoRRw7YCzxJrpEpS/PYrmNWhczM7rpHsrw0gnnCp3
 A8oy00CjQkIooh/e9jwB1OYS4FNNpgRLeFNuvWfmW0J0vMx+wOpxErxfVZ9HEmHa
 51gDVEvZBSr0mRoo02d7SxmbkjJtUi9wQWbjEtlCVz/QMtCWGPWDbTPXircSS5Nr
 VOP+tA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj50v2qy3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:34:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d3a617ad90so24215626eec.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776278097; x=1776882897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LRpSIe9kabTlcoSlutMpDT8sQNqdMc5VVou5iKFdtMs=;
 b=aDUbSX//RJ7hc+6/akrbraStI9QPNYdD9jXIpqwlVskpOo9+MH39UivQHPj20Oeqxb
 0KV0KON9w34qjuBlzKkjygnVYlCc/l4u2szDUrN8TfMwGirOGrl20Eoj5BiLWXvTmiqQ
 pW/OknkJNVX0W5gcaWQTA8wjNWGFap2bEaFpOxkoiGn/QpMeSSM6S3vRAN8iBFp85Q3f
 kHY3ZedPk4VpKgdDCXvP5/2e4rN8XW2FRjxMiHTYeVMt97M06VALNb8kB8iXqaKHmQL1
 KeCBa6Gb1ZKSHn8Cj2G6nuAjlfbrAD6KnFC2iu350MAzCQ/2gEcVZt6l6n0Q+DN+0ec2
 Y1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776278097; x=1776882897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRpSIe9kabTlcoSlutMpDT8sQNqdMc5VVou5iKFdtMs=;
 b=of5Gqb/HINxPPuE1wK6rH8J6OF4oSXDFid3MDBL67La3a+y1Xfb5JHzAgYwIpiQ3Jb
 wJbtFYixTFN8UeQ1ze09RUMFNX3tqr4g+Yvj0zG30XT2hjIrd1AB34mc52nl4cwBQJC0
 7GGiKc7RodbEshqIgzD2Tcs0yfXvQTbF43Ix5puGQwbsdNUq4hH0YQnIiUV4HTVzOG0s
 CAXik6Z7bA+OJ3OVpitlPWDalBX1gi3DAUoaduCjW6NM3+7CCr+yRBcAjZUVR4kkxAMn
 qEVHWjiRugYyAddQlTXcQyveaPQnkb2jjhbTWtW19UcONNLCbtB/a1eso6lyOvi+CPd5
 fwSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xfF5jnjHLBiae5uOw+o0LqcuoBjyF+Oyzo41zjlPxOmdk+FE2s6atpoL1zwUn7A72B7XscR5+GuQH@nongnu.org
X-Gm-Message-State: AOJu0Yy1/x2bdGjKWR3MfoGzKVFcdNHqBCu/ADQyjgs8kK7pqzxjiKHF
 oRCTnAuBio2C0n8j6+5zkn36bll62gVCIRUgvTOun3szoieBn6vpKYkJ0haWv95eShNJViqN13L
 8Gw3IOhXVYPm/TPiw0yUEmjPP8NRyx9BgsaI8U3WUK54RGl/6rmfYdmbv8g==
X-Gm-Gg: AeBDieuNgjZu9kLEKy/HLfTRlks0ws1TMUUQRAneJ1DEXf79N26QW+6pYmSqZCnemfz
 YT0tG8B7VhQdhLkcXMhweV6nFegxmTlfzWLZ1QiNusoUzIx6Fp/QmLd98nDHmGEm8extXQ4ZFPT
 5UELfC8masPI1m3XsImfX8vmsHxEcdQBdJMrLqc//qP/QBNM9cOnFy6Z4siHpCTlbs2O1OD6vO1
 RmXF9ikEncYaNH2M72zUzyJFG/28XK5tG0iItEPJgiOu0CuoGYNaKKP0deeWDltF1KAQ1/H102X
 UUDUr5GddFsjX/PwPrP5686HRINqVr4l5Wxh2FIn8WRZYkkZuvJ51iXBzYAu16RZnvgevDuDGb4
 L2jeDHJ57GZKjMou60tY+CP/b+V0DC5yrIM3htaldsYG1UeshSd5zLN5FkHnf6knhyjeuEFlhsp
 8ClhD4rEUK/w==
X-Received: by 2002:a05:7301:4705:b0:2d8:7302:d3b with SMTP id
 5a478bee46e88-2d873021818mr5550229eec.18.1776278097042; 
 Wed, 15 Apr 2026 11:34:57 -0700 (PDT)
X-Received: by 2002:a05:7301:4705:b0:2d8:7302:d3b with SMTP id
 5a478bee46e88-2d873021818mr5550217eec.18.1776278096502; 
 Wed, 15 Apr 2026 11:34:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm4764341eec.8.2026.04.15.11.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 11:34:56 -0700 (PDT)
Message-ID: <3b561653-5cd3-4195-925a-f726e21df113@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:34:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/arm/smmuv3: Have smmuv3_accel_init() take an
 Error* parameter
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20260410200031.18572-1-philmd@linaro.org>
 <20260410200031.18572-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260410200031.18572-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xyxujSfMo0l6-5ZqWIwjlME9AMSga4SQ
X-Authority-Analysis: v=2.4 cv=eLMjSnp1 c=1 sm=1 tr=0 ts=69dfda51 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ikd4Dj_1AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=urBhWk9uDEoXAR6DJqoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MyBTYWx0ZWRfX/LVXNPbvya8L
 3+mfPU3vU3afL9Fn1WFQpLaDoRIYD0wXyUQ3gaJNBciB6CkqzdnpIZR4g7zHHnvsh8rwotuYnKB
 b85f/N+W1zUg5wgVdj/Fo2vR4VnTz7q357xSiPlUVafESHQYYcih18j0kUoJtTCRQ3CFtKnD/yl
 ggOJEm8aWnF2dT3r399YK2b8NSYElBluKMzsgKJ3QoUHN6ZONjXHfFIKIcdSwNeDR3EGuOkxwHE
 ST+Zo3Mj1D58aiJuqHrUtPpJKbcol1flk44VQVNcTPQM2zsgiM+8JkRb/8wk1am1i/Iz/nHIwiY
 CXcvdQMecMPHJOqDRLFYHVQY1wUeDDo6vleix1bmhx0ZlbOmnPfg/STPiyZNEQqSvvVEPFxw32l
 dNjixiptrRj1ixdDZVBtbKUgZrp3/sddKGRvwc8uc5wLs/8LoC7gSpErc9+eNm4iaPdNPxyW6XM
 ULGMg6e7KiGQz2CRW+w==
X-Proofpoint-ORIG-GUID: xyxujSfMo0l6-5ZqWIwjlME9AMSga4SQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150173
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/10/2026 1:00 PM, Philippe Mathieu-Daudé wrote:
> By giving smmuv3_accel_init() the ability to populate an error,
> we can fail early in smmu_realize() when CONFIG_ARM_SMMUV3_ACCEL
> is not available, simplifying smmu_validate_property().
> 
> Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Co-developed-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/smmuv3-accel.h |  7 +++++--
>   hw/arm/smmuv3-accel.c |  3 ++-
>   hw/arm/smmuv3.c       | 11 +++--------
>   3 files changed, 10 insertions(+), 11 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

