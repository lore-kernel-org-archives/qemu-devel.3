Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CABBC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cii-0004Ax-MH; Wed, 02 Sep 2026 00:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cih-0004Ak-3X
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:37:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cif-00088l-LM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:37:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTFfB2468830
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5MJKcdW49ifRGoy5TYeTZZ5D5lrgioLi9sEAi2UH0sA=; b=XuLkXE48WIjcONt1
 ZxOSlNSlbnThn+fEp5aMldjmcLY2AJ9BKvV7QfEGRppEU3WRLsJoVlQKvj9mNzQz
 ZZdLDYYh3HwGz9YCRnLfoL+jNfYi/8uYxceM6BPS1ExkW5uFoYTmo30yfc7DaEOK
 DyfUJ6iOCC64j4/r2Pz1B/SOwtwQpGdBBLfTsQIffofy4b2rILbGN1NethtjjNfF
 Wfswp3wAphWt6Nhi53YAgCAsNIv783LliM9gDCIrzNO2tAEvPiDUD9lYYZiSA6rf
 JPTYmZQEhQBlmuld2XCZZrbW+mJXyZzlQ/wRiDh6fKKRTE6VMZf4CEACoqRBdDAr
 x1JWOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cj2ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:37:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ef13b61bcso165856885a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323821; x=1788928621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5MJKcdW49ifRGoy5TYeTZZ5D5lrgioLi9sEAi2UH0sA=;
 b=XdzBZfvRMFWevdqUgYdjrOCCcF+OoC1EIFsNCEUCcMl5tei6Lc4s9QIH4W48SXeYky
 ej5bbSjrhbdd9O32y1oRy54QhoD827S/MPrO6GUgcynzmV2WJPWVmZUhkb1m79vuGQ8i
 shTpvRATAwRnFR8twx1VOzFioSNCDYIceETUarosN93v8l2RAuImAzayxbklarFlPq1a
 LoyM++MZDOyaKiUlmNeMN/7XpKf+ndOqRxL/pzpOZP+tu2Ye7rl2yXSXiWaoqS3yyR7G
 rkenhDuP2m3l1p+/TIpEeBsz53rjpGlnGaMz5pu7lVs8HFV2/cncoK8zBZYxo3iM5Rvu
 WMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323821; x=1788928621;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5MJKcdW49ifRGoy5TYeTZZ5D5lrgioLi9sEAi2UH0sA=;
 b=TwohIj2cuqZjwpHF9OPIMMaS4Je6IAqKUBPZ9WdHtRpKMOTt+In6gptT9O6vR7iREq
 xDVAI2TNPNrskYLzZQmuaqkZ0J74fGxhuhszKDOTAkPuySvSNnrDjBIp3ns6PYWRT74S
 pS05AdOZrIy6pGeQKabrs04lTjFZv8yc6iFmMqV64bnEN3Gw3gI4/ntuBLicbvWsRiOo
 rmQLIQvhJg3yaYpNQKbQIOe3ZX7Hu3RtbRIXQQTirnnoPFdnAzVe13iSuoJAEN8yUyYQ
 Oi0X8CM4ItRMcK1Gzyx4gfJY2/SVmJdzt8TW6oI8FsstbOEKoylmvDMOOJCjvrkZbmCH
 HMKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoG+eBqOQ8BnssEzAwa/CVITDK8sCHoNknwIJnMDs9gJ0YSdtRgVmTzBGMRcHC8ByJik/YRbJaV8TuV@nongnu.org
X-Gm-Message-State: AFuF++ksMn87YXAIr7En9aPTjclXbL4B+wTLlIITT19dUHJhjFwYHCYG
 EXVS3MHuo8Rqhph5+iCkJDnHrkTyPsx2gntF5bcO+iK++IDHhTem0ZGDgJIcrm1hpbIK8Cfpntz
 6eTBQOf3+9N9VlmccJX4j6bRHPxVfzJFngCUVMhggrUXCy3oaEwRLV0oDAg==
X-Gm-Gg: AR+sD12yBenT73tWKuFsZFuW7PybopkBzTrrDUYZzdD4pHOKnuqIRteJkMupoiGOjEf
 kagtTFXJ9jM2VRKsjofifP1woXapVOx6APYhRLVOSTPiNnTRjJ7Hf33VCS9Jo7yqJpEHoNoqUe0
 0S9SHXKKquyvObJczUQ4AG6pUgWfL98FrrEZz3STbp2t0lpCInjNbpc1pzzYpuKA2aZ5myee5A4
 YQjKMLrNCboudNkE8uic+FM9M8YgM7hutvxn6pMkzd4ceklkyJfE+4Jq0+UeByvpa0+ytRyPav9
 P4ll+aM5550kbXrLuKbMHwFptZzFGRv1uMtr3VGqwKdnpeSTvwlYQKrkA630hugtgL36IfZ7/o6
 FmigaE16L6jMDMEXB2ixJqNLw/A72wlohYA==
X-Received: by 2002:a05:620a:468a:b0:939:57ad:4586 with SMTP id
 af79cd13be357-93960df4859mr250505485a.16.1788323821617; 
 Tue, 01 Sep 2026 21:37:01 -0700 (PDT)
X-Received: by 2002:a05:620a:468a:b0:939:57ad:4586 with SMTP id
 af79cd13be357-93960df4859mr250502885a.16.1788323821185; 
 Tue, 01 Sep 2026 21:37:01 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4647472sm36316915e9.4.2026.09.01.21.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:37:00 -0700 (PDT)
Message-ID: <d5dfc481-5ce4-438e-96a5-19661beba341@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] target-info: remove machine_typename
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-5-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a97a7ee cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=adVaQAAPJtczaq4qYdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: oN0Td3wDYfd2XrN6jhXS1g6nZ1bOWXtl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX42RWsDM3nQHP
 qc0I9oUo/wOw+EXR0IqabJOO5nEaZx5uSNlPeX6hqT8rfObpmblxtAvpxZHMg4tfV/PWPtWodZj
 0fQWEM1nfCgUteCC2ULlovZJBJC1wyk=
X-Proofpoint-GUID: oN0Td3wDYfd2XrN6jhXS1g6nZ1bOWXtl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX89jYrNxmix3G
 JE08myIyU+pD5SE1P/z3mpQg5dcbLb0rsOOMTjeM5UZ3rYe8X1aC095kIxjYfucP7ju+Xczv68z
 M0PXeZAec3ZTc988sCR4CJNY4+FpYtOJyFQXUJzLIsRtEeGbTNx03KVu36DSEqrH/emAXmVRvhQ
 d1hCjBaL8/omMKS8a1tk+a5pzANmkPRNqj0d6D1JWFOOCoEr/gTLdwirRqS2AMGswJM0WzhF/eh
 KtRpslz7Tnr8oHYIDd8aPqd0PdaCOw0+JkiD/G1VghagqqRs58o6e6PY5optCGQ3u45Zz2c9YIT
 qw4NB6SzJkSiiSupmHGQfvYP/f/4XKxAHNxOhioE8NfENtS45TN/om/G5grjmrIfUXThPPFXUUI
 kOwlrNEh7tAKdpzAx0VhbsZ194AAUKMT8YDkQsL9LbQYwiB+mz4G+gnzyX1/tRKBPQJ+LQfpmyh
 D6iwQYr2c3WT1Eq57bQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020039
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> This field is now unused, so we can remove it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   configs/targets/aarch64-softmmu.c | 1 -
>   configs/targets/arm-softmmu.c     | 1 -
>   configs/targets/riscv32-softmmu.c | 1 -
>   configs/targets/riscv64-softmmu.c | 1 -
>   include/qemu/target-info-impl.h   | 2 --
>   include/qemu/target-info.h        | 8 --------
>   target-info-stub.c                | 1 -
>   target-info.c                     | 5 -----
>   8 files changed, 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

