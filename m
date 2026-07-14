Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC77AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjc54-0006vU-6P; Tue, 14 Jul 2026 08:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc52-0006t8-Tv; Tue, 14 Jul 2026 08:17:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc51-00032A-6l; Tue, 14 Jul 2026 08:17:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBfgGi1222315; Tue, 14 Jul 2026 12:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=I4v65e
 mijr7vvK5PCZzx/BQl6e2KrK0ztu/OrMm5Y/c=; b=U9D8ZFmfMh9StW+S+qRoOB
 G3zh6DqeAy/Y8YWjhTaYiMWIjrNV8uMdAhwNq/ersbCwvJSZABRToYTZnHOmRA7c
 lQrR7/JzmYWr6eOVu9DSYLYcZk49w3hCNQbGajL1jKYDddNWkOUXwMFxURqRHUEF
 7LTjrficESqGMzffOgtgBU7KqaDLeG2xDbduN8YHczY2U8kGaUOoYpzk2qT3eYa4
 uyqAV9itPW/ThBxGXGgFJV0kkwnLIerTl0MxuORqg/uaRhy9vTK+FeFFIz3vIH6T
 T5APnRqHICL6ANrAJz2fYUixlX67q1nEb7ZqS/YoUaU9QkTc4TxrY3cBdLEy6gSQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt62rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:17:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EC4cCX013831;
 Tue, 14 Jul 2026 12:17:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhakat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:17:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECHaNM49349028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:17:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F5FC20043;
 Tue, 14 Jul 2026 12:17:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBB2F20040;
 Tue, 14 Jul 2026 12:17:35 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:17:35 +0000 (GMT)
Message-ID: <2caf2627-f1e3-48b5-b29a-0cd5ac3b74b6@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/51] exec/breakpoint: Move BP declarations from
 hw/core/cpu.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: XWo6DM3pgynHg_k5bcEfFEpwD9zDYlBH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX54/IEJznKXgx
 0bQxbM57K/dN2GNEEbg47aAesM9hzGcJYWI+bb8GNwi9ILa+3lVlgjdNV0vvAuP8dUm038akiMb
 3rWULwFt3HS4yK3ON9fPwIANLQ/fp9s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX5Kuif2cKQCZl
 N82+z2VuLFPzHETvLsm0NyunfnUciHzHmqFL/dRRIS//km4Vx8HlLeAaMwtlr3JL6gPTSJCzt0T
 xTuhcg5dJ6gDeW+DPLC+so2qhESLfdlKECPlySWBoSHeeD3MIGa8pS2DOktQ/cvFemttr7gltu9
 uEjYPefrV4K206seoZ2n68lJLklpMvgNPCgE8cud57Liut04cs9NwRtioqMry5iQ0xg6xVacNJX
 xxdjmDWYSyxWYcCfo73g7f/HZLSEsJDMtuw6ZpieF/SNMC7YIZEfoPv/9XKpfnNDMV2zwlL3YPS
 PIho/Bp7LZIVyIYSbSxvIvyJwHSeKdlP/SEjgeajWcDNWwNuGrsbr7ePb0X90RmhNV1Zb8/qrUB
 jsvZJIuPktKf7RoQLBLZ13WxHig3Jx5xI5VONlLysddH9fNqYtyD92WbeDDByt0qV3huQc4MiNM
 8hCnaXBbNkjpW0ROMhA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a5628e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=0P3Jjsb5eW0RbDK5GlwA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: i-eXzegv58ew60bzr9_WT-vQGU6sdY6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/10/26 22:53, Richard Henderson wrote:
> Move cpu_breakpoint_* declarations to exec/breakpoint.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h | 7 +++++++
>   include/hw/core/cpu.h     | 7 -------
>   2 files changed, 7 insertions(+), 7 deletions(-)
Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

