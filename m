Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A7F588F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErqE-0000sl-3M; Mon, 20 Apr 2026 12:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErqB-0000rj-B3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:51:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErq9-0002Ph-PC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:51:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KG1mb73925591
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rPrDFoMx2ra8gJGudkXokPcb2FIACJtYdzUmiIP43FY=; b=FLUlcXPY57ZmMInb
 IZiVDXq8vR/KnkQuYA8Yd1roUEQWdZ3K0lcpqqOCNuCXDGbM47FaHch+w2nLmo7t
 KW47YLK4bZaskCgA9OMVI5ab5ucYI1eLA5SBDJ8EBCq0GEppLMwAytOwJ1Si3488
 4iwbgD74E/pcR7o4TBsrbv6cmkssryuS/ROfaQ9GXV0og/7FUzYcjh5nLPkQykhW
 dhWnx/65kF26notSIzNeVLOYxU5uzvbX20vh07U2rZnVPvXg7K+424BVfy5PpULN
 ak7xgFbnQjc+rAReuQob3toP/rfBXkDdda81sA3aRzMLaw1+d0mTQjKsDGmV4fv9
 YMrZRA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhu9sgpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:51:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so4073946eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776703876; x=1777308676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPrDFoMx2ra8gJGudkXokPcb2FIACJtYdzUmiIP43FY=;
 b=CQqcHJGHOFgOMBNSmjavalbTJmwKmZnv50QwJiWKoD6SbBgIEIOilRpGTNbG4E0C7l
 vIoMMM3QYjuUBED3OOep8Jk+ja169jIirjJAmbVGx2/tvXFuIfSIv/wZGKiQc1uWsTEX
 agVQanZM5P5HZNtfCB3ECiacSa6SJ0XBcqsn0hIbmFyL+KwjajRIxFEsunhvkvnpuw6V
 /PemH/wX6nFaP9zoya4GC/VYcDCua6GEIQVqwos27p9NHN/c1mDvp7xRy4xXR8m4sUYm
 3LRb1BzA86AW1CEqduPkrgUYgVOj2z8lkgXeyQM2hrbjA7O44bMCsuLyflwdq1XqmcJD
 O0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776703876; x=1777308676;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rPrDFoMx2ra8gJGudkXokPcb2FIACJtYdzUmiIP43FY=;
 b=OdG1dm1Sw6N1Lp+KGOFyLRi+O+YirxbsqKPzRnu2sLh0t2X9NuycFNXWR1KlE6aELG
 sLnOpl5Yc7LV11w5+hFJdkUjKFD8Kxt5qy7zaZfHoK4Q8uI/ik5KJ7FGdTU0afAE0Gkd
 2jwphZgwLvkBLBfgbr30Tp+sMKWqLnpYehONZfvU+aO8/7yTmyPHdj/Q4b687MYePJVm
 yZ2esaQodlzZh0/Qb6Jv1rHXXQlmPBhiInV1ZrDG5VgvJD1YIkAD01iYFeibbsVrjN8G
 VFGxrMogznk2lOixgoRAgOWC5eSxoSnvF9XLPM8U+3VB+pDauRLRNntCFY/nhezMyN+X
 OghA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8W+oEKsET2XLmQqPYaHEMNB2KsWXYqLJh8Y62zVD2+CiCsf972vDHAaNwsNgK7Vs1YrOviF6mZeTAL@nongnu.org
X-Gm-Message-State: AOJu0Yz25/xuqJZXMdprA4qtiioFf3wJFjUgH3vjfluTI7Z8Yi4pkyOK
 5lxL+aCMw2tGf3Zf9APuTEfSo9Hc1Z4jBqE4XcDYvFqRGTV7OfxaPpNhwRUwJJG05NswSV0Umvm
 aFEwhF3xM483YcKljNrCeXIn2xJN8p6xDlUzjxs3tyqjJJvGxPLJ/YiOcyA==
X-Gm-Gg: AeBDiesLDRgxpUm8AlmaCsZzlA90QdFdlWNVO9/7iN2wanIyGzy+DdnoAD7h82tG0jF
 vCbeiz8SgZ43nVNH6uzoQuROSue96+Nb64rX/i/n6WXZPZq+TbgksYyuO1JlmdAJAO0wHTOht/O
 s2arulLovKrv31kN0hgYNDz2rkphL+ze8u6uqw47z8SPx3MH1IugSKmNqzngxeBV9CnQS9bkKi7
 zo0VfJeE9L5dqwGSPMJv4BzjoeDftVe3sYS7Re278T+i8XUk7ox6Kw3ddd51GC07R5fooj37VFs
 QUmPB+zBsfMaLCAgFbsK65nYSQ2xxkTtOGm9tO4ghAowV14P3593Pkc/DDkeVy4myBF+JaXV4aq
 RzzwJjHfLMBkr+1GHychDG5EQZtVz4FRmhMaPuuyQU0opmZfTaVV52PidgZaMNfds/he4khVCeD
 MDSq/5swwlItJXitWr2WXlaPxX
X-Received: by 2002:a05:7300:6d23:b0:2ca:9b08:e7d2 with SMTP id
 5a478bee46e88-2e478a34148mr8107074eec.22.1776703875613; 
 Mon, 20 Apr 2026 09:51:15 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:2ca:9b08:e7d2 with SMTP id
 5a478bee46e88-2e478a34148mr8107045eec.22.1776703875070; 
 Mon, 20 Apr 2026 09:51:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d8b944bsm15315762eec.28.2026.04.20.09.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 09:51:14 -0700 (PDT)
Message-ID: <a1f89def-1cec-4a41-a1c6-952447398d23@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 09:51:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] target/hexagon: add build config for softmmu
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2MyBTYWx0ZWRfX/4wTwbHWV4bm
 ZB2jCFJRXymgkUxWmXHnzuVoN2NJ+Fw+mGyHRLgXOnXC53XQm1DFtGSvNRGEW7YV0JF3WeYH4I8
 tH3c7Mn7GT30vvh8cv5jHHrA90VTyYj/I+vAPWcUIaYgNo8yuk7a61D6b+p3oxcdhM5HCS3x+90
 fxQutXpmC4PbY1keap7ItnnhBzeoJrvAC/U6UK26+v+3hEooCyrc7C9lH35B4lKFPDejAUfKPHc
 hlie41Ua1+YBcYaZDw29rWgbWuIA7C+VJX/7ZcPE0vYKzP151xaIAHeDj6FbQ/vfRfRQatDgY9c
 /5H6GRq2ZfdzjUZjLNSzFYKWoBSTBjp8LwP0HnkXxtUk4eNZ0zNLN1fMCnIap1K84ed2Fa9xKAR
 R5uHZIYyzFoBt+S0KRgxSIH+SYGmzgLFPejZmd6L2VIBLPHNp51b51aPyEql70vnfkzuv4B1R+/
 dICY5b2/BezQ9W86IQg==
X-Authority-Analysis: v=2.4 cv=IIoyzAvG c=1 sm=1 tr=0 ts=69e65984 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=z3rugqDRiJh3h8wCk48A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: w05lO6j08LE_k5NPfMEk_7FrowhYCEbE
X-Proofpoint-ORIG-GUID: w05lO6j08LE_k5NPfMEk_7FrowhYCEbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200163
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

On 4/16/2026 2:03 PM, Brian Cain wrote:
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                                 |  1 +
>   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>   configs/targets/hexagon-softmmu.mak         |  7 +++++++
>   target/hexagon/cpu.h                        |  7 +------
>   target/hexagon/cpu.c                        |  3 +--
>   target/Kconfig                              |  1 +
>   target/hexagon/Kconfig                      |  2 ++
>   target/hexagon/meson.build                  | 13 ++++++++++++-
>   8 files changed, 32 insertions(+), 9 deletions(-)
>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>   create mode 100644 configs/targets/hexagon-softmmu.mak
>   create mode 100644 target/hexagon/Kconfig
> 

Minus the mttcg enable, for the rest:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

