Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4576CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNay-0002Y1-JN; Fri, 08 May 2026 11:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wLNax-0002XD-1y; Fri, 08 May 2026 11:58:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wLNav-0000up-Ho; Fri, 08 May 2026 11:58:30 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648EmYnV3486157; Fri, 8 May 2026 15:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2NapTo
 LGBo1AxtfsOxfGrqGsLrSCo8Dsp/RoB0TLhjE=; b=cONhYmIe/xIBC1XknWN9NV
 z3phMuu8L4oIMaU1XObUXrzla0BT8ykHt9YQBw+O7P9tqBhqKCgLI0vWxlytRBaJ
 o9gKYvOMvwQMJbhpe5OvMVI8ENZh+XjDZiYzuTHbPYvujHY1E/YBgWnDN9HSZWXJ
 73tpGvYzWJW+iyehAPewvop1vT9pEDmH5oE0ps+t77Sjm7Zj7jY19BV4ZEHiAZF5
 B8F+BEDuqo2KH4I/6Z0VuLsuvuDNL8LqCirVKYbIaAr4egHciDS5Kfan0Fs+tCS8
 Pz1IFV6gB2Jfo+rLekMg16+rGMebe4213+4JviuBaOX4u0n+19174SXSTdbW43qQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy33xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 15:58:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648Fsnvn000663;
 Fri, 8 May 2026 15:58:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywgy6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 15:58:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648FwGuR30736930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 15:58:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8457258055;
 Fri,  8 May 2026 15:58:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBE0D5804B;
 Fri,  8 May 2026 15:58:13 +0000 (GMT)
Received: from [9.124.210.81] (unknown [9.124.210.81])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 15:58:13 +0000 (GMT)
Message-ID: <a5b1076d-77ec-40b1-b4f8-f493341c7cc0@linux.ibm.com>
Date: Fri, 8 May 2026 21:28:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add self as maintainer for XIVE
Content-Language: en-GB
To: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Markus Armbruster <armbru@redhat.com>,
 Caleb Schlossin <calebs@linux.ibm.com>
References: <20260507154530.364296-1-milesg@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260507154530.364296-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1NiBTYWx0ZWRfX7FsYvq8mj3UG
 +1HENuVcB2xKbIrLknFYYVgVglJmGWSZNiws4pm6XYWusGOPrJRwheJ3IIoNcDr1uaXjVOm5mxT
 c9dImo3DZejr0CIEi0bwcEgEvBAqA4P5wR8uw+dhUhhxF6+fHvMxRAjwpU7gyL0T4uVVCXBiNxe
 S/VAlU/ak1SS313vmqzHrXIZSxg/txzZS4S4S9+V5BOAFvb5zeDjwnHeb3MA2M32oGa9bsgjUDQ
 FHVypGG4Y4Jp+nR+jAjsaa1DzHCakUDNp/xgbmC1HRbZV0uAQ8XRgJAdkDBgora4EgijmtKrubn
 cGKqrg6HKvoyDlNdFpl5EumqB3yEnw5V4O7g/Kf9LSTAI0xFGjPcU6AeVkvPfWSduVdr3w5b/iw
 mKo4dW8GCETkUqhIbnVfksCMWFGndi5sfWdoZ9PBXnLoRcQzUXPAACkG7TbvBGeXvvdZZMTsVuG
 L8BFbsPkJGk6eIXDbVA==
X-Proofpoint-ORIG-GUID: syjdsUC3YgqqknHNgy3iwm9ixmsEPrnR
X-Proofpoint-GUID: syjdsUC3YgqqknHNgy3iwm9ixmsEPrnR
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fe081a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=cAj_wJHvSNCvMi5F0UsA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 07/05/26 9:15 pm, Glenn Miles wrote:
> Adding self as maintainer for XIVE
> 
> Signed-off-by: Glenn Miles (milesg@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d3d645953..37fb460a2b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2877,8 +2877,8 @@ F: tests/qtest/libqos/fw_cfg.c
>   F: tests/qtest/fw_cfg-test.c
>   
>   XIVE
> +M: Glenn Miles <milesg@linux.ibm.com>
>   R: Gautam Menghani <gautam@linux.ibm.com>
> -R: Glenn Miles <milesg@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/*xive*

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

