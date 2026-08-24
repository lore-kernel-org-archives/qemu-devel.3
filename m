Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE1C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wybhg-0001x4-9H; Mon, 24 Aug 2026 16:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wybhe-0001wT-SR; Mon, 24 Aug 2026 16:55:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wybhd-0005uu-7F; Mon, 24 Aug 2026 16:55:34 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJW9St2859000; Mon, 24 Aug 2026 20:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TJBOKA
 YMDQdRuXDir7LOg8qWVMXWeTsww3CfUiPnP7o=; b=Yb8hyueTc/UdqwB2yvaDs7
 peXjqS2xT87+MEqkxpAk80mZVT1hm1zgWFN4InHMKNeMttY1nG7OkFh0y5BUKcg/
 VaaCLJ1qu3JNmIGjT4D7F5A6sR49sAI2pAP+Gh0fpIIGAV3orpA3Kdh6L4HyT8Zt
 cFb+IvBNRD9UV+AWKWJulLo0SMD2sDAqK579erU2VeYUBNKNgAUHWiMVZhG5QnRq
 OzWrrhUHcUFQz/uI1U7nrW2Qicxo6Hgl7l3Qa1fGm8wPpxeEXI8Y61HnIL9ev9qh
 oWBsWKCoQIUCQrytp3TUKCXEMW5DE7XXdhDM8tQc/2m3W/wRazmzL/Lf9WpoMa0w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4m61q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 20:55:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OKfIk0016276;
 Mon, 24 Aug 2026 20:55:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw0kck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 20:55:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OKtPtZ60948862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 20:55:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9679C58052;
 Mon, 24 Aug 2026 20:55:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6EA758056;
 Mon, 24 Aug 2026 20:55:24 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 20:55:24 +0000 (GMT)
Message-ID: <011deec8-70cd-4a4e-86ee-7d4ce40e64dc@linux.ibm.com>
Date: Mon, 24 Aug 2026 16:55:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/15] s390x/pci: Move dm_mr from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-5-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-5-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HvbFuQCm1zNZeqdwKxiSecR4uaCOVgU6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3MyBTYWx0ZWRfX7RDreU4cHaQm
 nZqWmZlmI0MvTlLh9ngjHU/taVI4fy0Mif3d2SlWDssXBL5GSY1FTUHEbrw5P8OUxJkQ/rc7G0q
 UTt9XwkoGYLGd0n9dtfBEVxUawwI1YQ=
X-Proofpoint-GUID: HvbFuQCm1zNZeqdwKxiSecR4uaCOVgU6
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8cafc0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=cyitXeQsElXgarLFEw8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3MyBTYWx0ZWRfX34TIXEZN65x6
 qy45BGb9EDfjw2lKcZc0A+CT+/WGiDIytZY2tESPHSPtcdbK9Y/HuGE45yhMIjG6tiwzcvbv0kf
 PW7jFwpWxsRZpF13IEa+Yxnk2h6lTbIRpGU/rgxOPOrSua/WswQ/YVev/c2dqlkiYB0nmhPB6Sf
 WfGRcuO3YCK9mi2KISBiXsek5UUvmro2dsI81bGXecxMyy+rpDUeRLRZ0soeMRsz9SgCWjKJOvk
 WrXaLZMfSg575CtsqxV3upnLbSE6VdQ6Jw/W+BLV0xpdtHb1skUMS4mk243IR+Hd3MW3/eumlZw
 batJ4W3utVtHlCVLfLRxE/fyAEEHDw+oN1sBpFQh2ZpYVQjD4fiQwq5NPE7lVpQkhRvHIeUZOQS
 PtVaYg+LJjJp27CPyetSoziQXvEIf8XZiXRjb0zLoZrHNa+PoPzRWH3zbzkuucoJY6hSZ2t/Ml1
 YUSG6Wwp1beAn1N6PrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240173
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
> 
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

With commit message fixed as described in patch 3:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




