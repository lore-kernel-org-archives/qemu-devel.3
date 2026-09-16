Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC36C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yrT-0008VZ-G2; Wed, 16 Sep 2026 19:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yrR-0008V1-SM; Wed, 16 Sep 2026 19:16:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yrQ-0002jZ-2U; Wed, 16 Sep 2026 19:16:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1ShA006600; Wed, 16 Sep 2026 23:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gZVOVG
 rDT4DX+RR3O2OAC5uA4aJJmFz0c79qswu003I=; b=lrApeD4tF6yfKrZp0aNnrh
 Bsdcoq18KEJG7UvB6PWgsUdoTK1juSJ69Sd33KBaMtxhQBkH0jx1RICTiVqzLq6i
 2aP4lalp0q2LLqPGAe4edqLGIG+zRdqaHm9Pztee4o4AStlvLJW3bQdDSP44R0i0
 VA+hSExce6kKj07kekZykHTD7o2O4W+Ngh29hmJdhIpcZPJikBjgeBvJKEBCN5m0
 ydDBMArdhtappEXkfxoXJjw3B7OVkC7T4Y6sj+wMlhDgdwveRl0oU69ZBkO4AVlU
 ApFW5+/C2sE2s8P/DoiQcuVmYzwH0lQuUMyhfNy5P5wtl7fXwZkPQQwbUpcsuXwg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83yeg7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:16:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GMqohv1663497; Wed, 16 Sep 2026 23:16:13 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089ru8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:16:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNGCtc852756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:16:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0410058052;
 Wed, 16 Sep 2026 23:16:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69FE058060;
 Wed, 16 Sep 2026 23:16:11 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:16:11 +0000 (GMT)
Message-ID: <5ebb0fac-7941-4703-ace2-86855354346f@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:16:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] s390x/css: Expand check against no-data-count CCWs
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-9-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXyl4klyLOJDKV
 aS4U1JoYpCWynq/4pQ1eF1svlHYktQICAbxGlH4/c5hcwSpfLzfGYqNIoRCf7BEsYD+Ugm69Bzy
 k4tJh6y3xNzIc0UnsjOZl3pZNs+NZV4+mUIfkYFJj9+m5i/X4lXuBhIXxkE1EkXDdEXege0m8sf
 YXoVeyTrsJLmqQVCFu+cJiXiDu2Dfg37jDOCICMjr5sXRDlPegsUxI8koHrGzzPbZT03f1nCFdP
 +Wav/l9ouFwqK5cJwngajIcn8yMG/Ui8Dyvt8PSdgzWuwS7Av05gNessoHV3HTOo1Mrye1H7yLD
 NXUYmhRLdsIZsDWtTeBIajm8kz8rymeKnhbW44kxollepjC+fwZqpOEf2N21pXMD+KMbd0Styni
 tSqSNKiPciq0GiRsjb58EbYB7T41s44v+Su9/rtwrKPJUcosJdR1GOX8SlhIFEyspx6GEmS6SUP
 phB6cxLhvFcIBTD9CCA==
X-Proofpoint-ORIG-GUID: Rq8JlTcgFTocQ3Wlo3DLVpTgJScS73li
X-Proofpoint-GUID: Rq8JlTcgFTocQ3Wlo3DLVpTgJScS73li
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX1aPfXsf95M5p
 rUJyg2XqSdauR6tFfbx+XHJ0AGjH3FUUa083aPKC6DqEaMp+jpHz8q79Zx/5tAbEg05EaXJuDLL
 jSjacNmITEwHUzoNY4J1FTX4X5w5vkw=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aab233e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=FdgE7B24lvi5G1TxQcMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/16/26 4:32 PM, Eric Farman wrote:
> The channel subsystem will reject channel programs that incorporate
> 256 CCWs without a data transfer, but the existing check for this
> does so against a data address of zero. Expand the check to include
> other CCWs that are valid but would transfer no data.
> 
> Fixes: e8601dd5d0 ("s390x/css: catch ccw sequence errors")

guest-triggerable, cc stable

> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/s390x/css.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 9da9128d88..c38549c7be 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1016,7 +1016,9 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>  
>      check_len = !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG_DC));
>  
> -    if (!ccw.cda) {
> +    if (!ccw.cda ||
> +        (ccw.flags & CCW_FLAG_SKIP) ||
> +        (ccw.cmd_code == CCW_CMD_NOOP)) {

I'm not sure if this list is complete...

I wonder if we could we key off of the number of bytes transferred e.g.
sch->cds.at_byte == 0 instead?  Would have to happen at the end of this
function e.g. in the ret == 0 check maybe?

>          if (sch->ccw_no_data_cnt == 255) {
>              return -EINVAL;
>          }


