Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36AA107BCE3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 20:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w18l0-0002ob-2h; Fri, 13 Mar 2026 16:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1w18kx-0002oE-8V; Fri, 13 Mar 2026 16:05:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1w18kt-0002Zt-ED; Fri, 13 Mar 2026 16:05:09 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DFshmT1279244; Fri, 13 Mar 2026 20:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FVnUu7
 xSaUqVD/5THCzjX481mqu68HmgHyppCZqSUDk=; b=J9MGvL9wPjHspBW8r7D2ER
 THLmVzAjvb62yS5ouWh4IdpMixMyirOZHovr0w2j4X72Bdlq0t3a90gut4LdQTns
 D2kjxHaQOvF5K6OL8asU1W8X4bqshhi5LQJqUrLh2l5k5Ss8ZYFszada4ZUR6R2G
 R9ZJ+MqYDS50aR86v7121zDLFBgq9T8ZCcsj3yFnF29k0yRPZTNpXmorXjgkztWC
 8CHGFMzBZE3x3g7Fs0tbthLWCt1QCfiQoLT/VARP/gZ56WnqgWONYiwfy2+dBNvV
 +TUNY77soUdlLVos41LNGf1ubexf+iVzmCeioOs+fxYlBtDnk2mSsTT/cMFRaEXg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92hhqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 20:05:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DJA4ST020801;
 Fri, 13 Mar 2026 20:05:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9r4nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 20:05:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DK50qp24773340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 20:05:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7A8758064;
 Fri, 13 Mar 2026 20:05:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAF5D5803F;
 Fri, 13 Mar 2026 20:04:59 +0000 (GMT)
Received: from [9.61.175.196] (unknown [9.61.175.196])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 20:04:59 +0000 (GMT)
Message-ID: <2bfc2a4e-be82-4bc6-951c-add92ce53b8f@linux.ibm.com>
Date: Fri, 13 Mar 2026 16:04:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Add another reviewer to s390x boot
To: Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20260313113424.15583-2-thuth@redhat.com>
 <20260313194810.1844241-1-farman@linux.ibm.com>
 <20260313194810.1844241-2-farman@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260313194810.1844241-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UNvMBzmV_MnqKBRLSZTfNnRuHF-L8J8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1OSBTYWx0ZWRfX6QwiDehkGpcT
 Kv6h8fHv97Kp96Fk/D14M2EkO1eyog85n7guFbksPF/s37iROVy4J3JWSsPokc8u5IjfQVZ+uu0
 uIbBozIHsRB2eakZD/cT0H5NeinXSxhmCYrfrsYm12QxD209zqguctYM/S/yUSreImneOGJU2Gl
 8KEKAUD3BXdBoZPWRsfJaOXWua8tKWL1Q7iC8/sHfrbRl6fRYiAS/8bXdYfAxHVXr8i4CX81Wu8
 s7AX72ncrcTEkfGJxx+uXsOYYeWjHSKkNwWjgwIH/VDCZOtSqgcpxb14TXPkXFGZecfg/Ey7qov
 zM4lbyBQxnKObgeTwnXxYECOfv4yypJ4OBtZYsmjhqM+Vs3UMWIZMDCYGOF/1CxbaGHHtgWq5u/
 0jylbrpsZ/kpNpyKP1bTkdHOypuJ+CZJ0hyFnt6roj9YXOm25fPwNpbiXQVraB/JYaBXSc7Itp+
 j54tHzDcQTex+JUFfeg==
X-Proofpoint-GUID: UNvMBzmV_MnqKBRLSZTfNnRuHF-L8J8d
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b46def cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=K3oJJphijqaC0nxcXBEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/13/26 3:48 PM, Eric Farman wrote:
> Jason offered to help review this area of code;
> let's make sure he's notified of changes.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23562aaac2..e83ff3826b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1866,6 +1866,7 @@ S390-ccw boot
>   M: Jared Rossi <jrossi@linux.ibm.com>
>   R: Zhuoying Cai <zycai@linux.ibm.com>
>   R: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/ipl.*
>   F: pc-bios/s390-ccw/

Acked-by: Jason J. Herne <jjherne@linux.ibm.com>

