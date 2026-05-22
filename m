Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB53CD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUXl-0003Hy-OC; Fri, 22 May 2026 14:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wQUXk-0003Hj-LX; Fri, 22 May 2026 14:24:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wQUXj-0003Ui-28; Fri, 22 May 2026 14:24:20 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MAKath414604; Fri, 22 May 2026 18:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FOhGXq
 MEeSLnOq1ABDGf6MB1gcMMCpI1RKoxviBIC1k=; b=l4sRdP2ULjLvvL8FBRro9J
 IDgjI2iGbG6tQuJ/dhYK4x4013u1DUTpeQU4kYkFM19Jn56dtawKStoi2ds+jPUl
 eP6Jt+7XYkoZ4HmvaVA0Epvu1nAxQcpjhbrIvrIu5ADcxGPFqKt4xzY1mASO/RmI
 mHRF5NTkzk1tsfzK4vTB3nRgLMZ7sCcvQz/JXMVPdwYUUJMw0egL2H/xcQDwbQhi
 KtGCAglOLw+aVRAYbxbYGmO6psA2eb0gkvMSO5ZRt6jOqf9ZpklZGWRjrXTwYv3T
 OewgXwvAZ6+zgDQV298P6wDyTpdzH/4+2NhYK6YJGknqo+0b9AlYMvKYSReHxG5A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88usem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 18:24:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MI998b032035;
 Fri, 22 May 2026 18:24:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj229f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 18:24:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MIOBBZ63177014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 18:24:11 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0572C5805D;
 Fri, 22 May 2026 18:24:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF52158053;
 Fri, 22 May 2026 18:24:09 +0000 (GMT)
Received: from [9.61.48.218] (unknown [9.61.48.218])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2026 18:24:09 +0000 (GMT)
Message-ID: <de6b67a4-93bb-442a-a2c1-92b9abd5d3bf@linux.ibm.com>
Date: Fri, 22 May 2026 14:24:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/s390x/ccw: Mark virtio-pci disable-legacy property
 as optional
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com
References: <20260520183403.223983-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260520183403.223983-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T5fy6y-Yq4lCJcB5PPQT9pJec6AKXG56
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfXyeKDdWgD3G0u
 g7SsKoh0qvj7n5aHIuPU8rylO+G71mVKKZ49WtFLgczqo6SnaWB64R+fJHlUQHQes3tWnI8MRoS
 4AIsJT0S/6jGUdE3RDmiESEhb955UTu52MneW8Kpo+I2RL32uR28frWuaC00vBLNOemLzHvDN2S
 Lko8sscwN6vXsxuXEy4L40z0zsf6zdtnbNEAVQyx4D4xO1f5ddNPSufBUJ3hLrIQ7MaEJc/HNAF
 SDp3Nj6ArEQgsmPcUiVyxdIEFOfNZw51FxMs9GJ7KBfGcGBFcIfn8Q1LTBKF13gLwderChpsgUi
 7ZEMe1JfCM4F6MljzKE3bTYuI8ImBkPtYwKfLtq/+tZc7A2/TCpPrNSrfviy9YlLvjDYMlEka/d
 fbxxJVzl35v5nLjqzT9K+pAEPd7I02Ncnyq8oA3/uBpBIPOepRFIp+UQWpp1gBUQxgGg69lo3qq
 SF7P/puf+meEWcSAJqg==
X-Proofpoint-GUID: T5fy6y-Yq4lCJcB5PPQT9pJec6AKXG56
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a109f4c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pZEqJEV-R4EwDfoGAnQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220180
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 5/20/26 2:33 PM, Jaehoon Kim wrote:
> The s390-ccw-virtio-11.0 compatibility property for TYPE_VIRTIO_PCI
> "disable-legacy" causes QEMU to abort when instantiating
> vhost-user-fs-pci devices:
> 
>   Unexpected error in object_property_find_err() at
>   ../qom/object.c:1284:
>   qemu-system-s390x: -device vhost-user-fs-pci: can't apply
>   global virtio-pci.disable-legacy=off: Property
>   'vhost-user-fs-pci.disable-legacy' not found
> 
> The issue occurs because some vhost-user devices like
> vhost-user-fs-pci only implement the non-transitional variant
> and do not define a generic device type. Non-transitional
> devices have disable-legacy hardcoded to "on" and do not
> expose it as a property, while only generic device types have
> the "disable-legacy" property. This affects users running
> older machine versions (11.0 and earlier) even when using the
> latest QEMU version.
> 
> Mark the global property as optional so it only applies to
> devices that actually have the property, allowing vhost-user
> devices without a generic variant to be instantiated
> successfully on older machine versions.
> 
> Fixes: 26103c13cff0 ("hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)")
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

Thanks Jaehoon.  I was able to reproduce as well and confirmed that
this patch resolves the issue.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



