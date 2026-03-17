Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030DAFD8776
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Uhu-0006Iq-OI; Tue, 17 Mar 2026 09:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1w2Uhs-0006H7-Nr; Tue, 17 Mar 2026 09:43:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1w2Uhr-0005iS-0O; Tue, 17 Mar 2026 09:43:36 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H696ol442363; Tue, 17 Mar 2026 13:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=O+pbnDwDIhI9m+VOyD59vcXya5J3p2DxQK0PrmGU1VU=; b=kv9DbexHpRXu
 VryzIiG848GFzACCtEUvttoswH2yQDnPJT8pqL0drSYo1KVDMxtjt8dMAMWluKuX
 n1lIJT4Zc0q7zBnz7bmldbH5kiqMGqHthenb2g33IPlY2fc6agNQncYiDJ9NLstF
 IdTc0cP225k2aZxSoM9UfRFHU15Tz7qLdn/6U84hJIycl+1Vpm6uSyUMHoDBHim4
 LaqklbhJUuO3KEFU1hTdYIkJzzLuO/P2I3NSA+/v0fJbLg3JpDCbcZHzIZIR0zu3
 V9OFRKZMKyMa9dx70mbFAarPJvwLjnsQNMKJhHBF4GgCFRTJ/hXJujkf8tcQy4WG
 khH6jjG6Gg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs4ykd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:43:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HAw1DO004559;
 Tue, 17 Mar 2026 13:43:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s9gak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:43:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HDhRIH11010814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 13:43:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A145658052;
 Tue, 17 Mar 2026 13:43:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15B715806A;
 Tue, 17 Mar 2026 13:43:26 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 13:43:25 +0000 (GMT)
Message-ID: <843a92d17038ca06d7aab8e40227bed8f6957b0c.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] target/ppc: Explicitly declare 'cpu_reserve_val2'
 register as 64-bit
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>, Nicholas
 Piggin <npiggin@gmail.com>
Date: Tue, 17 Mar 2026 08:43:25 -0500
In-Reply-To: <20260315170832.40331-3-philmd@linaro.org>
References: <20260315170832.40331-1-philmd@linaro.org>
 <20260315170832.40331-3-philmd@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b95a81 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=ja36r-UFxlY8USd8m5QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: UMH3j_jgrwwY-V_tRTQDi6KbWn3dhHUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyMSBTYWx0ZWRfX3s/WkRgpqFWq
 mD7QFi+JDyIjy2U2esishhlpCiLuWcmwywadW0AvceQVaYGxoNAj66kmxsE0sK80pBCBuoO8KQb
 mBxtBOCit1O7aar1nP9AfMOIxzBqHiTjeShU9UoXTRM066VWbs+RQLP2ejnCt2/qsN1C/3twwBh
 fYod4ZxEhX0jgcUhPxzqvuxHoU4kH/E1eEtL0hGt8nVE2NpEtgb38VguveKdftboTz+RJBSkmAs
 /xTCoK68TrVF9ln5OoBkqC3ujQlmFKpG2Xy5GTg1GyxMKlExewzrEWWGrL9S4EGf/bSGeA9P9jT
 uDXeOISExtylxhUwz5gl1/q6mY1JwSVQ/rg1kqLOquQYblwBbUXXMMF4jT4vWSVUZS01IiOcoXZ
 uLih6LxiHH548pfqwb6Bx0r8hVvQhh0AMdcWsx9/iI+6PRP2rLvqvMp/KPb1bvBle8FE/in1y1C
 Ub9sUdpkeJbCDWyZegg==
X-Proofpoint-GUID: lXHhmhMJtjvhXx3YrnRBO68qxcHciGsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Sun, 2026-03-15 at 18:08 +0100, Philippe Mathieu-Daudé wrote:
> When TARGET_PPC64 is set, the 'target_ulong' type expand to
> the 'uint64_t' one. Use the latter which is more explicity,
> similarly with the TCG and migration APIs. No logical change
> intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/ppc/cpu.h       | 2 +-
>  target/ppc/machine.c   | 2 +-
>  target/ppc/translate.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 63c8fa25acc..f4438982928 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1298,7 +1298,7 @@ struct CPUArchState {
>      target_ulong reserve_length; /* Reservation larx op size (bytes) */
>      target_ulong reserve_val;    /* Reservation value */
>  #if defined(TARGET_PPC64)
> -    target_ulong reserve_val2;
> +    uint64_t reserve_val2;
>  #endif
>  
>      /* These are used in supervisor mode only */
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 49cfdc6d674..b44c3ccf0ae 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -682,7 +682,7 @@ static const VMStateDescription vmstate_reservation = {
>          VMSTATE_UINTTL(env.reserve_length, PowerPCCPU),
>          VMSTATE_UINTTL(env.reserve_val, PowerPCCPU),
>  #if defined(TARGET_PPC64)
> -        VMSTATE_UINTTL(env.reserve_val2, PowerPCCPU),
> +        VMSTATE_UINT64(env.reserve_val2, PowerPCCPU),
>  #endif
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0fc81570a8b..ecf75c1376e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -76,7 +76,7 @@ static TCGv cpu_reserve;
>  static TCGv cpu_reserve_length;
>  static TCGv cpu_reserve_val;
>  #if defined(TARGET_PPC64)
> -static TCGv cpu_reserve_val2;
> +static TCGv_i64 cpu_reserve_val2;
>  #endif
>  static TCGv cpu_fpscr;
>  static TCGv_i32 cpu_access_type;
> @@ -152,7 +152,7 @@ void ppc_translate_init(void)
>                                           offsetof(CPUPPCState, reserve_val),
>                                           "reserve_val");
>  #if defined(TARGET_PPC64)
> -    cpu_reserve_val2 = tcg_global_mem_new(tcg_env,
> +    cpu_reserve_val2 = tcg_global_mem_new_i64(tcg_env,
>                                            offsetof(CPUPPCState, reserve_val2),
>                                            "reserve_val2");
>  #endif


