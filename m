Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BC2E7DF0F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmy0a-0003Rn-KP; Mon, 02 Feb 2026 12:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vmy0Y-0003R9-Kx; Mon, 02 Feb 2026 12:46:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vmy0W-0007B8-Ur; Mon, 02 Feb 2026 12:46:42 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612Gvm5D018916;
 Mon, 2 Feb 2026 17:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TAZJDb
 GB7DPcXMCPT1lOKdZlutg1LU0U8KyLZ2r8W+g=; b=fj8mjCKybPzppNPZT99Atm
 jRTWwm1GqvI5GFurXXcJhvjM8RWqUcDpcKx0uy+u50KAeTIpbzb/UXGsQQCYXfyG
 NLiXsCYENZMkz87LuWUo6RC6vmNU+2gLWgcscaRFSKoAbHpfuX1Up8lwfsfiItEj
 U4jazj6sdOrinwqOLDpwWUx5A7fCXSBWcOHW2KZFT9do6RfNgtZYzPBJEbYhYsIy
 LgKNQhldRiPuTzURWHbJw6bnOu+guFufR4hpoc4BP6Z92ACB3ftXAkzu3VFqjEsG
 +ps7uCBGNlfypDHL/kzP2YOHuDu706H5gDXXDz0oNXjSGhVIeQnIrw3MB/1XXTRA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19869n50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 17:46:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 612EN5ep004411;
 Mon, 2 Feb 2026 17:46:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1wjjnxb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 17:46:36 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 612HkY8D25362984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Feb 2026 17:46:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A195E58055;
 Mon,  2 Feb 2026 17:46:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D27B65804B;
 Mon,  2 Feb 2026 17:46:33 +0000 (GMT)
Received: from [9.61.254.56] (unknown [9.61.254.56])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Feb 2026 17:46:33 +0000 (GMT)
Message-ID: <782cc686-01ff-438b-b470-d4fb74971879@linux.ibm.com>
Date: Mon, 2 Feb 2026 09:46:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace backup for s390 PCI
To: Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260202144702.1783102-1-farman@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260202144702.1783102-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEzNyBTYWx0ZWRfX28nsqeaCvl8q
 KWa99S7pnXqWQqZyLNvDT8YuYhAeiURf+fk9eLnT9Wkf8kLlAgPcaExAfaYxveuxNecbjrsRaGS
 lhnu2q9aLURV2QXxnrjnH6IUhJXETW35E6ILytLMeOVXeXeCQU0bdi94PbMQGpMUE0C9ePmqWFF
 ZoARE77tk7loOQwjEjTXg/nMoqmJpRh6YEw2UdY5h/LgxjCiAfRiZOM6Plg88wcPRLQpH4Wh98M
 ooH/cUS6DRsjeovpsuMg6tZfRKK/bwSIf30AQEaM44vrPx3aI65MR6HhRZfb+A4f4+MiUQG7xHQ
 IL5aXZuOZmMUtZlP6mpDtAZnhJAY9r416t4cxxHaWHvgoIQjiS52IDLRmvH6S5Sa6c/mdWj7ZbS
 uF4Zz/02KDyuu4Zq0RoA/3G0BudOwe3mz47kBT2X+qnoRfLdBqb0pQoKnEvkms6N/Wv/gYX/gub
 z01WGCmqcaCnzvg9JFA==
X-Proofpoint-GUID: CUNoKOKZe7o91JlqeQoJExIL3AVMUzqg
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=6980e2fd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=STK_0p3wlTkmVyiQI7oA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: CUNoKOKZe7o91JlqeQoJExIL3AVMUzqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020137
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2/2/2026 6:47 AM, Eric Farman wrote:
> Farhan has been doing a masterful job coming on in the
> s390 PCI space, and my own attention has been lacking.
> Let's make MAINTAINERS reflect reality.
>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b7ed4fccb..32d60dd673 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1862,7 +1862,8 @@ L: qemu-s390x@nongnu.org
>   
>   S390 PCI
>   M: Matthew Rosato <mjrosato@linux.ibm.com>
> -M: Eric Farman <farman@linux.ibm.com>
> +M: Farhan Ali <alifm@linux.ibm.com>
> +R: Eric Farman <farman@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/s390-pci*
>   F: include/hw/s390x/s390-pci*

Thanks a lot Eric!

Acked-by: Farhan Ali <alifm@linux.ibm.com>



