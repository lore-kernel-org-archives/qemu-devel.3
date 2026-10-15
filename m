Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE83CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPUm-0006f6-On; Thu, 15 Oct 2026 13:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPUj-0006ea-Dd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:43:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPUh-0007KF-6m
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:43:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FGNMxp4100190
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mLgTl3cAG6swjWl1Sp5bqrY9uGk+ZVPzz8emKEaOgSQ=; b=gEZy85706F0NZf0D
 V7wd0acR0zylC5m9ZrcyC9lgbQ7Ux/BroJhsjRVrCUlt4vjYOEGT8Eg1gQRM6dN6
 +7gpFj5ZeHh0M/HsuIKFWw3Nrb/O5LwIJFxl1sTL/75qbvOiAYloi0pjh+S1BnH8
 dR2nwx9Ckew2/0E1SbrSPrtICVhx53gbxaIbU7t+EFdkU31bHXJBjx50yTqmBXg+
 Szz52KebS2FGIQJUxwwXhi3VDVvrEK2GAfnzFXP54eYs2ddQXLNQgPX+RhkT+TUZ
 99V7GPiC5ro3EDfHWM9hYg3wX5FEgHXv3jbe5FgESoxN5RfldUTHVqvU8iLHvjh4
 D5Z/5w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2r9rpw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:43:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso361734485a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792086232; x=1792691032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLgTl3cAG6swjWl1Sp5bqrY9uGk+ZVPzz8emKEaOgSQ=;
 b=ZLW3HKOSUWQYcdZTKstScjcktYEY0TWt3OapuH6LVwJCp4qSQH/Mk2ZyWIsw6n3ynQ
 U9ambuw9RkRAieZ5HggltVzCN4vnEoVfp4k8gmdgDAbu6FkoMKMFtLLclpjmwZ+bkD0F
 5eYTo8aT/pzDxNwBKR3pvM6ZwOVfw4PlQOf+c057hNgXDa4NRx/l6m2bf5iAP/Pj0Og5
 lG4dRt8QF+MwdyIqXBXvHoA/7el+xwFEFhI2rzffev/UtpSX9qF8Uz3nJFAHFvUrOPTU
 vS6E7tErI51YCsvQElYeXjQY8V9Z7ooeQIvTg4iFAar00u6tSmFDu3IX1Wb+FmljQ4tO
 n4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086232; x=1792691032;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLgTl3cAG6swjWl1Sp5bqrY9uGk+ZVPzz8emKEaOgSQ=;
 b=tZSTIXDPEJ78BqZSSXTCP0oDF4ZrVhi5/bwr/8SEYB2PzAlbRWifjSM5bzLS528Gvw
 2IK8UXjvIBUOHZh3nsqgh0W84VSHnu7XfHPG7yrL8vTU3aW2DJNqsGereSwkaO68+4Wj
 4vwSj3ZcGPWv4/F1wChGluMPVmdeLh50rjsADOrvOKmR8PuGYMJY7YBN76O3P0OPioG3
 w2cVTRdBNsZHbQnZaVn7oVPm4gZKXr9w+TNklKycp3XUKbhoRX1l5TNIknHk7it8H2wp
 yVmBpikyXznyGg/R0mxNZeci+qkRsdY1gApgNU3xVLnyx9acKvSnNcKN/s99xmOTzEQ+
 0BTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaisYaP5/jsmoZ5q8gOCgV2MTBTyY/lp0xJFeG2OZQtpUflnu0rQgIhfxGXVUKjbceBHOUMVEc7v5q@nongnu.org
X-Gm-Message-State: AFq9FYK+vTmjueLaPN7dM1FQvCJ5SpZmt/Ra5Rg3VBpvfzpbVEDKp4zH
 FBFO0tW44GVScFlq34IyW67mHdEahvge8te25YcYXsv+8ciAhjjotsPXZXH4xK4+9N4vIyNxgSO
 xO+acwCz88u8BIiwYmSpsF6gO7RxP/VXYiQYpQjdhEOYrK4rBdBtTlZnzAg==
X-Gm-Gg: AYBFou0ZB0TQlTKsaL3E4FAG4oj2McXvoTBDH8y3MtWdUVhvUBcL7bo+CFl3qLsyrOh
 PGlHU7HsNLOpjfCWxsPRa1aS8VaGx4Extcg/VZv06U672oR3zd+CM4aAl3zLJtmF+3yEufX0ZY+
 elFp82Z1zKTsLV0Q0h6WKx/X3IXQFgQirjfIHFZGqzIPr+X1g89Ra+406mq20rnAxmXuhIXySmg
 aWr5ToRE8U8S/SoKWPSBPZti6bMPBDbhJLxhlTiKAQgBIzfpOCnva096YWqR/bM0AD+pmHRnsYI
 YiZ+ORAr9wyXMthdz07jJCqV0/X5DxjXVMwTmhQo4EEsMNE3u/l7Ejs05AQzk53VYhtueKX/Mbq
 OCR4dl7iQoX73NW+TTxTcndSA/zGIz/D0WA==
X-Received: by 2002:a05:620a:17a6:b0:93e:c12c:9b6b with SMTP id
 af79cd13be357-93ec12c9ecemr2932235385a.70.1792086232431; 
 Thu, 15 Oct 2026 10:43:52 -0700 (PDT)
X-Received: by 2002:a05:620a:17a6:b0:93e:c12c:9b6b with SMTP id
 af79cd13be357-93ec12c9ecemr2932230285a.70.1792086231805; 
 Thu, 15 Oct 2026 10:43:51 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48deeadc0b5sm10768130f8f.6.2026.10.15.10.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:43:51 -0700 (PDT)
Message-ID: <5f87b6ba-5352-4043-90d9-d6a98393f101@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 19:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] target/riscv: declare semihosting ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-8-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014210526.104215-8-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX4DD83Ia6EIv4
 FTY2kAVxAwWSywfY0FX/+5c/vBOFgScbAFksaceKTuyG8UiM2nBhFiX23ncFECBH4MTTDtNawdI
 8uaQkcuUWT6RiL3+Jw5WlvDpEclqcIQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX/lDluFBtkfRD
 3nq6fqe6BwP2gbLwHdKQ+ZyE9E7L6ZVYPlfwAa/tf2pgQ9col1BHJ3H411VCld0615u9m/lPgFl
 ENvTrVp+y87iMam2cW7FPErGXJhEBitR2cASaRtv/hrqvZaQKhRQcHMWEcg31VjF4eIKN+cTGuX
 0kVBc44fSwk/wyBOH7IJIHauP6AmodXsDq67xdn0YKOt1/CyKCJi5Bxe3+qULuuVX8u2m8YMMy9
 mZsupWkv5FdqIeEKdyCwDZMwoeivLpTVxPPz4A+iLboA+4x+jjDhabGTJKmG82JZbhEYAj+JuCJ
 kv+cjgoKPqWXrODTnaBtE13sFONr9ovEVC/4I+utHQZR/HU2+z/AlUcxPsD89DT7CJtUoEXHTW3
 9dxVtsFwRM5p3u01ywLJbjwBmb29Je0hViMauqkwcImMqm81zYwlmX1sNvenFr8dxl2k1aKN6PO
 3GwM3tH+FNqm1PQP6Xw==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad110d9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=X6Q8Br3edyyEBAiNBCQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: v-UjM_VjFy0Wo5aVui-Zd3gNlO_c53du
X-Proofpoint-ORIG-GUID: v-UjM_VjFy0Wo5aVui-Zd3gNlO_c53du
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150070
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

On 14/10/26 23:05, Pierrick Bouvier wrote:
> For now, we keep the global common_* symbols defined.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/riscv/common-semi-target.c | 66 ++++++++++++++++++++++++++-----
>   target/riscv/cpu.c                |  4 ++
>   target/riscv/internals.h          |  2 +
>   3 files changed, 62 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

