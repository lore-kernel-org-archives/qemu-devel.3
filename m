Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9D8D58E5F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwWD-0004sq-3l; Mon, 02 Mar 2026 01:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwwWB-0004sd-TK; Mon, 02 Mar 2026 01:12:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwwWA-0004e7-AJ; Mon, 02 Mar 2026 01:12:35 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621L0V3W1903139; Mon, 2 Mar 2026 06:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2RwJJy
 jXVim+0ucGsj1vlTmj/rWxVUANho849tHk6n0=; b=QCBXQLekil8svKCBGboTps
 UGIvAI1NqtYQGAq5ck6ZC4egjGj1jbh5lh4xFLvUqmFjabA4jU6vmErOWc/S9Vjp
 iaCP65Sxy5dOCGOOf2Qna/kXILwMJclTzvUvwZONLXbN2Bfkrr6aCjDCKHyYN8zy
 lS4C2sqIf6rSm9hx/sup/qy4Qyu7ZZQz4rOHcgVHeulxV+xgIvpekemLGnjRd7e4
 eCrpYlkSwsB8zkkjavxjHDeXuNdarmNjFPrvsE2R5DIkcedATl8G4txeVXezffwO
 XZPl7Qf/OnIKpCVzc+/GJMflrPnK6vIA/dJ6+sm5q2Uc5K/KPg1BwKP759PGL2PQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjd560w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 06:12:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62243BUY028908;
 Mon, 2 Mar 2026 06:12:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaprvq99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 06:12:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6226CTZN21430914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Mar 2026 06:12:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D5C458055;
 Mon,  2 Mar 2026 06:12:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC16E58063;
 Mon,  2 Mar 2026 06:12:26 +0000 (GMT)
Received: from [9.124.211.120] (unknown [9.124.211.120])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Mar 2026 06:12:26 +0000 (GMT)
Message-ID: <2b10ad99-5591-41fc-a957-0c601ea380cf@linux.ibm.com>
Date: Mon, 2 Mar 2026 11:42:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ppc/pnv: Add OCC FLAG registers
Content-Language: en-GB
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20260210134647.2050821-1-calebs@linux.ibm.com>
 <20260210134647.2050821-4-calebs@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260210134647.2050821-4-calebs@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a52a4f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=1uUI7C-GC6mqRRDD0YoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hb_3-BXOXEelymN2xpylZt4I2QSQeRyZ
X-Proofpoint-GUID: W1AurXSuzUKXmbE44iZqRp9Nh8yX-aoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA1MiBTYWx0ZWRfX9CIQgoVhbFUn
 W/u94GxtnDBHYvYnSaeOg3jA7NeYlTKUFDBUGb4WTktLpb8ueNE47offwjHzgSZquma8MDJDsCK
 iz+UZx7V2jqgu0/RpR+o78ohpMrUDLtzzqr1MTEj9WnRcNndDzN9sYdexj+h/g8le9gxYDbU8Kc
 3VZS/H+PIlZd1JUdEk4l8C2GYmqvWl13XPLnbqn46hKRnRmHn9Jca659hYoMbRaZX5wSYr6+nKh
 j2p4ShPTercOMgc8IxoRWn3Pct1ByTtkiJ7LkfwJJ4Yjc27eVbay+TzDceMGDyHFB7Prm5YlRQL
 h90QuWeJj1Xor9jKLSSh0ODhLrc51QSye+OdJsspLIvd3TUi61hE10oMuHshLabru3FGJR5vtOq
 SzMC0V1Aq4oXYkidI8TbqzopdesZmE80wDRlNqFEdWUQ6fmjY7It+vmowkezlY4lI5SJuM4/O7M
 UZ3kxCtVVYfoA0ShUlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020052
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/02/26 7:16 pm, Caleb Schlossin wrote:
> OCCFLG are scratch registers that can be shared with OCC firmware.
> Log reads and writes to the registers as a reminder when we run
> into more OCC code.
> 
> Add RW, WO_CLEAR and WO_OR SCOM Type enums in pnv_occ.c
> 
> Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com
> Reviewed-by: Glenn Miles<milesg@linux.ibm.com>
> Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++++++++++++---
>   include/hw/ppc/pnv_occ.h |  4 +++
>   2 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index 64cab3e9dc..b9f69daffc 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -195,6 +195,49 @@ static const TypeInfo pnv_occ_power8_type_info = {
>   #define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
>   #define P9_OCB_OCI_OCCMISC_OR           0x6082
>   
> +/* OCC scratch registers for flag setting */
> +#define P9_OCCFLG0                      0x60ac
> +#define P9_OCCFLG7_OR                   0x60c3
> +
> +enum ScomType {
> +    SCOM_TYPE_RW          = 0,
> +    SCOM_TYPE_WO_CLEAR    = 1,
> +    SCOM_TYPE_WO_OR       = 2,
> +};
> +

Would be more suitable to place above macros, enum in pnv_occ.h,
but that's trivial and can be taken care as a separate patch later.

Queued patch 1,3.

