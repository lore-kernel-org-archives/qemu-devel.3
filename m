Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1B7CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXHH-0005qv-JN; Tue, 29 Sep 2026 08:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXHG-0005qb-BE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:49:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXHE-0007RE-9j
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:49:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCEm4q4066652
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8yqQOeyJ0XXnOB4fc3PXWwr3kPG6kdduEgvwRnWN6dE=; b=WBMmgmSCKmUU9u4J
 S9RLNZQCn+9V4iFyZY3ofVyRCL+zjqMEvLEEiALotHlacVP6xE5BdCzmOXBJIUfm
 oOud034SSRGOuHla82NBYoZ3ALha/cUx9SW1Y5k6poLfFdKR3Wtali2MivgdOI93
 yDTmVbCoRX//YMhkxsLCQJ7y5QNfegUc10aSWPWzgNHL47klUtrFo/5bWOLq4Io6
 HYWbRB3XTk+fcv1ju3Z79+g8ehe9FFZsrewbVcuiUFoXxJH83f5OlHx/UG6vj1fH
 sgPn+WqaoqHe0sd9ZhxN1HOAWLOCIz7iajRZfipsASmpRtfuJzs8Sganaw1kYVSU
 lnCgIA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwnc2uf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:49:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939f3426a7cso950700885a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790686181; x=1791290981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8yqQOeyJ0XXnOB4fc3PXWwr3kPG6kdduEgvwRnWN6dE=;
 b=amvnOq3VjzYmNXs7YvWsWI05awNfcngnOUhi7ClAE24TEzgQQBDw6Zu6RRPhQaDp2+
 X0r5f54aNFzzuhw1o1rSGpBFT1gTx97otClZUudlgPV4eb0+8tuZHbTea5O3pLzc1tvw
 UXkIwI2sUbU2GafJRn0ne7zoRqSLmynHTVyuU0jHqfySyTVr330OgZn2vQFacqEpyAcA
 cgASsBl0nnhhU3WsaQpCcdhFZ8jubKiFyXLCRS+lQPbn9MCAsE9wLUNFJRD0vEzJ3LrN
 5Njuvl5MMcHVvQciUJPD7/9p0jdLPFOMHo4kTUjeFWVvkFctf/gQhlVmqNo5bXF51OvV
 eDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686181; x=1791290981;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8yqQOeyJ0XXnOB4fc3PXWwr3kPG6kdduEgvwRnWN6dE=;
 b=J4xBDj3TRL1x2gLbTulddJfw3/MmD++G+C7vxPlwJXguJcPfXAnklTFbYM4urUaJKy
 519D+xU7daKerflYVoDjZJYATHvTrOTqE+oqyGRMZtBQn6q0a5YzMFZ6Dqekx5sVzI3R
 JTJR5DC1F1+RX+vCA8ceVzBdwcvAG2rSZeWhvyXou4yL4H0Ooxn2l7SEcwSdn9OmAnkS
 z3lurYe3rHzSy4FeaVm2wASRQNP3GAZRjjXQR2kNeEvMUxESXd3J89fqZ8376UQFt3ph
 JhDsZJTllvx8wFHaff7RLVKQDhvU7gEoJE+jQ6CgbUt0VZ4z8XnHVuvCD0Kjbtn/n0dJ
 4NUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy48rA2bm1QyS0jp4uYxf0NqzFyIzUVD+0dtueUidVJJyGmt12cSPtIUNeHyeODAxnNUSSzg1jtwR6Z@nongnu.org
X-Gm-Message-State: AFuF++n4GILjncrxCv6KfqnrC5fweEgchHYQqy7fLWI364HmOAMvE2mk
 CqiMzPZo/kuhribeFa4/FEK+buOnTbWAZulc6lHUTjlbXNmFBQwv3vl0a5e2wZpATNSy+JiTOi9
 DBLOO5mPyCWtQU3wC6hzVYoDhHF9dnsQtDgZnFu+soPX+QxVvj5PgAZ0Vpg==
X-Gm-Gg: AYBFou0LKjeONWu6YpDaGle53EJX8q/k/Xnk7TbI0rGARxdI39/LZzDhaUt+X/30Ob3
 sgmLaIWDU/U39eXeK/nw8EI0U/Ui/W5pRTQguOVt1XXld6oCUkXG/n2SduPAS6K59GGSXL4clSz
 3i5ImR31I/LefQOfMavRwRtRv8Vqq7Cc4zcfHGpe55/6J+4hWw0pG7O+qVT7mkp9ArvcdfhQRjQ
 CrdevdfpE5X+RVEIhWRerlAgRNhYZvi3JyorEeheyJpAAg4LqwTIQ3pmqezvGVC4+BqIyKeT9yr
 jWQx65nHx8+g5GfaYkYZMa/UKEgqpvyDdnoIyxFdVjQybRuzrAMZzeuuGEfEgSvkN7HG/ITO1rF
 Mwrrfr+9Y7TkOABUPcuN49Ws23QogxCUVEA==
X-Received: by 2002:a05:620a:a195:10b0:93c:612e:9b51 with SMTP id
 af79cd13be357-93c612ec123mr1370066185a.55.1790686181463; 
 Tue, 29 Sep 2026 05:49:41 -0700 (PDT)
X-Received: by 2002:a05:620a:a195:10b0:93c:612e:9b51 with SMTP id
 af79cd13be357-93c612ec123mr1370062985a.55.1790686180891; 
 Tue, 29 Sep 2026 05:49:40 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfec703sm70848865e9.6.2026.09.29.05.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:49:40 -0700 (PDT)
Message-ID: <d8621b2a-c748-41d6-8aab-a1af066f7deb@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 051/101] tcg: Generic expansion of tcg_gen_clz_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-52-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-52-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p76xefMUf3jWB-4zisTz9WrVs9NcLW7j
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abbb3e6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfXzxR1Up/14/JD
 Cls4yyrcbD6MBDYozq4faj6XKcuAUJfzimONaklcVVJwTxny/crbMUVx+XamjxWIXi+PBa+Zl2F
 o5ipQLtczlh/9B/4mA0yEetsQZMvd256MzdDQMN39sDKvWMinuQZrtqPJdU5EkM/dm4NZ+ytYK7
 0m2ShV4q74YvN9/hO9YSprM9ejuNd3ncWYdMawMiFFa6dubtapPZtbJXb0gdMDpFtrs3BolAMyr
 dvrWXzF+VUZEpV0kNzGifGcomr3WuI50Fy3/pnmIDAvD7oyPxa/1xSJe98rB5P1L6Mvwj9laVUE
 YbFbvqcX+f5pbtWY7nxOB8gduAabY/o/C+Yx43t60OhzN9RmVQL5GpBKtzdpWki1vx93wEG6mlR
 b1QlBnlnCUOfbH6eoH7/mPj3zeChwDjzuj9BP+O++WqqaallfmDO39IEFPRlVVTrhnbBRp1cJZJ
 q+V0msTP7jyWJTEDQQQ==
X-Proofpoint-GUID: p76xefMUf3jWB-4zisTz9WrVs9NcLW7j
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX/CArx9QyE9je
 iFoHKRggm/2zIJ+iuweK9oteZpPBfRJIa1bu5F+mIKHrGHYnHwDnPhDGEWDJvFopX+Uamp9w9fj
 YMq7FPkGyL5PKn0eaK1Nt5Hn/pORJtk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290051
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 52 ++++++++++++++++--------------------
>   3 files changed, 24 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

