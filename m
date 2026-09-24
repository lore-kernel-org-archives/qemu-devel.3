Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D878EC98310
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9cIR-0002CS-2e; Thu, 24 Sep 2026 01:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cIL-0002C1-Pf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:46:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cIK-0003Wh-6p
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:46:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5eJdI567717
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jPHd6aCvbo587/LzqE5wtZ+ZeNKQC74o9IWXsfj+7d8=; b=UWMtB+b1gNO7TQTS
 731MDrF+lSSvTzf3acQHi+6gIOcZW1d5b+3JVyCmeey3qRf6om6mCoy1Fd+7/5LY
 Mp/mlKxd0Mmrd3Kpyot5E2vCLHXsJRavWPs+w78yOJeMLtuxlJ6WWTHHuGxr1u4m
 gczBEqrDFUCGvDgO2gZfI60lRYKqcP8pjPirC8UBHJlSfTxlOsiHfDcMRmPc/Hu1
 pp4tWIz0OONFOZWSCn9q/hP1PfZOYXnmRGs1F4sIPlZB6dmNeTLzD1EH1X4OYCPg
 ufdSdObj76j+q7Nrk+Av5xm//DYmxXts9b8zBNEX8aT7SHbXkGuq/O7rpO6jWXyk
 bHZRZA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvgh89cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:46:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a0050a554so315765885a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 22:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790228814; x=1790833614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jPHd6aCvbo587/LzqE5wtZ+ZeNKQC74o9IWXsfj+7d8=;
 b=kLT7NkvX/wYNrji6kzc+ia2+twa2/zK8TqnYJBPCNalrtk5JtpDHpthm/duAq9olX8
 tU1ZXZr9vd2t4VzSBSkj3ztYN/QuD3hjBWXwv7Fozy/ze7DkpdW8jWkj7bU5j9Fxe+qT
 C5ditzUbAlN1zwFDSpm8VyOFQXSllFpaaG7rapu3T4eDmwVbzbIv/fKhr+00EZy6tVuq
 N/oAwalbYZFX6kQwdaMOtI4sqmP3nPw8TkoUs3gBN5g5kvk0YMnx06hHX4VRaFgncJ2z
 5pUCmBA6QJ8g24gy80a1hBDMu6FDGghyQB7or/TUxtj0gWAlh2xXjbpqYi0XI5TP/Oa3
 57HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790228814; x=1790833614;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jPHd6aCvbo587/LzqE5wtZ+ZeNKQC74o9IWXsfj+7d8=;
 b=jopR67X50kCWPYHql3Yu1/Yl2LP4x4VpE31cnhjhPD5mUfQ6FjYRFV2r8GEvj/jP3T
 GJ3hU4ryzFzmWGrXNH/chGwyM2iS5D6UTHXsXIaqzxCopM+Z6m8qiiiVf5TifAVxw0ui
 8mYJ9b+e9u5M175inAvj0r6HQI+yyMYW0HV6F6aPlEsk98Ipy6XHlERuptPYs/oyKNDU
 l2s1qD6gVA9D+FcXZi1FgrNKPAFjg5DNuGhaptQrIvzGTXlIjSz9PEWiG9Je1Kf36Zvb
 2Xb87CUvdm4Kp6S+I1MX7/O9RujZP1UtKf7lq2aUxPHUQPnW2UmHuZRV7KXpzEjhsesb
 z8Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/ISXk1Evkb51Wce+8+HmygaiBszJhRphapGsBWPKJctQ5rwRFuhEzygpgCwpfq7KGuRoMzFt1V/TC@nongnu.org
X-Gm-Message-State: AFuF++m+u2nkAapeH5NGlJl2Infwas+pPk+c1124+SD0orMMY6qJDN2o
 IX+iJnObiSch4u9VN5kdGtuacLX3Fl4E4Q1wLA4dBj5tVM+KH+eF/IM29NaeVJ6+00G26t2wSlV
 8FWLUiozwyPgbIvplp2KIIpQztSedw32OL4aDrtC16d8HKSUEXs54Xq3VsWPp6K/HfPts
X-Gm-Gg: AYBFou0M7t9JKImFJRJIuqvKInTL1S7lu2TGqxwo1O+rKkTrstSJJy59Ize5Q4xhRwB
 pA9J+5yu2OHVMtGoakc54h6YudQhH7OCpQEhB0IGjH95urORUiFdCumqV0T+SdNwmdIfOG2WtkA
 mrVhP9HkIrqcoqzphEo7jKh5vp4wR6pMfmbt/4y6Ym6ayRP8gui0Smdz31JQsnAMM4cg7IzGcya
 p1MnHGtpkQf4DZltxqQKIg0sFK38rrPIgTt29JZtntzGg6f42Y59220W5qd5+aUisvYk6+lTmy4
 MJ1dXpuVuCnCOAgvRw4bHOg16J02xuRwFljb6unlQrF1ha+17Gawoo5FbNsaPkmG+WegRVELQXj
 Rff7wg8/AM1cV1R6uu8a3iXHfGGTLh5NO2w==
X-Received: by 2002:a05:620a:3722:b0:93c:8ad:4eee with SMTP id
 af79cd13be357-93c3642fdedmr150197285a.59.1790228813810; 
 Wed, 23 Sep 2026 22:46:53 -0700 (PDT)
X-Received: by 2002:a05:620a:3722:b0:93c:8ad:4eee with SMTP id
 af79cd13be357-93c3642fdedmr150194485a.59.1790228813180; 
 Wed, 23 Sep 2026 22:46:53 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4d12sm37115385e9.4.2026.09.23.22.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:46:52 -0700 (PDT)
Message-ID: <5be960e5-a887-483f-ba3c-6c66b696c83a@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32CPS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
 <20260914230901.1781309-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914230901.1781309-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab4b94e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sPgrkhP2hPvesMlqVDYY2XkRdevTGYma
X-Proofpoint-ORIG-GUID: sPgrkhP2hPvesMlqVDYY2XkRdevTGYma
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX0kt4IXDQKrLD
 +ZhZq7h2g3uXLv5yQhA43EHmFo0KawObXFmbxW19gJI9w8Eph/WGniyB34a8T+ksJUdXY8kR9r+
 nD9SbL6vfOVW8OL98m1XuMA1pvGDObs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX58aYadg/ShR9
 6YOcAJTjV029T8QKm715MMB3KqQ9aPCh50MPDdDQk+QA8ltODSVMovelj9XNORS1Q3wmi0DeZ0g
 HX/vjRSK6Q19b5GFiGGyJ4nZFJCvT+vjIll85ojVCP5sve6Ui7CzdJf5i2pkN7q2Q2jFQPpZOfJ
 wnvH6oYXi/zZVtW4VgzaHzFga1DuSvABgMy06usqumnzkmRKOn1TgbJ95bmBWXeJ31/t2p9rq2H
 JU0mFXwhuRjviD9m5Tg3XgpR+yHFNesqkHMTdB0G2jVd3wTb97Q+S7OXNn7m9aGoBXFezccBADm
 oi4t5GmY/bV6/9iVWcNdNP7y+/pYSRGOYEGaLVjxxofaJxS5CBYf4n7v9bmWoThpVk/RS/kHqic
 U8JlitMfhOCPP3AzjXCb2dqlCbxN8oFMhGdvyP4UtHeY1a6nEE52H+z5JJXRmCeTJ6LaMHgr5mp
 0pSJLihjoTpgVPvy5CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 15/9/26 01:08, Richard Henderson wrote:
> Use movcond instead of a pair of branches to perform
> the computation, packed in a new gen_cps_i32.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 42 +++++++++------------------------
>   1 file changed, 11 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

