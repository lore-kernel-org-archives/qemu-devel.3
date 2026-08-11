Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9915BC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqGN-0002Xj-Ox; Tue, 11 Aug 2026 13:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqGL-0002X1-CQ; Tue, 11 Aug 2026 13:27:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqGJ-0006oG-Es; Tue, 11 Aug 2026 13:27:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGVg4Q4029941; Tue, 11 Aug 2026 17:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=M7avRh
 UNtONHQ8J7gPPyouJx1bBtOCJSjRPJva2/YX4=; b=BRMiXx9vZIDKdQP7xEo3v7
 jm0pZMw0Mk59nkmw8lmX2IYfhoYIRAQD/c0GfbPn4pUm9Va9SQ9yZCmSrALz6p8A
 6Vf3iT8dge0p+Wo3sLrq4vkPbjUa1I9SxlDuQrxOGU7w5CyacJ9ZuGqjePvvYh1t
 1ARp4oPxH1oSQ2PSfXdLzevHLot9n/gpJJLTpyXhx2twi/JNWS4nRRP6ZdqxCkqn
 dp4jBH8xpRO/awb67yrCmFsgI0A8YnRxa8XTaeEPtuOgsXdZc3aW3VbCnHXIXgCj
 ol5jNph3UkTRSfN6BFUAR8PlKx4d7hPQg7cn7GGC+LXonm8kHCMEWvKZrAS/Q8kw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pvrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:27:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHQJKf015074;
 Tue, 11 Aug 2026 17:27:35 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq24m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:27:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BHRYPj21955144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 17:27:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68B9158063;
 Tue, 11 Aug 2026 17:27:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A27175805A;
 Tue, 11 Aug 2026 17:27:33 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 17:27:33 +0000 (GMT)
Message-ID: <5dfc9fbc-5ed9-4654-942f-326034056929@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:27:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/15] s390x/pci: Move pba from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-11-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-11-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b5b88 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=NT-D918DeMxGRRny-ogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfXxRyDTORr9YlH
 kt7cLhwWxA13Q7uoRxqrILzWtVBxxxR6jfppTWvh+XaqlR2+OjKVZ3uOgetL+ImsWLco3xtmXWi
 Snr1SGYeei/MuGocGsmNipuJy+yLGEYnhdnL3K1OKPNL6lrz/FpJiwr13jDRzREA1e32hX/Ex8p
 9d8DzUb+5XuLenDIeorF0b7PKmDkTaqfOr+jhq9w0gq4bJWU6DcO5XJJVcalDds1iInGlqvNhS9
 +FaUg/I5zKVuJYlQtC87nOzTFuTp6FAPC/SjYcENlaDRlA4CuB0vUwJJgtuYvVn6flVPnKIXdDa
 H2HOSdcjsvmhtyxhVXqKC8qsS5hSikW0Wpu+pwjF7+KI5NNNCTd7ylRqF/FQcWzVyO/8Yk+fH0n
 QBNqE6/QPuXiu506Il5QRR/8OV9IPPIZUftJzwFyy+HGdPciAN9syNvOll1RfXbGVIvDDiYf3Ur
 UDjoyA9zl5kQN+QURdw==
X-Proofpoint-ORIG-GUID: E9pDAZnweKC1xZpUIST9Q53pLGpLoxNq
X-Proofpoint-GUID: E9pDAZnweKC1xZpUIST9Q53pLGpLoxNq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX2gGgsSsrii6v
 tcorW7/MnUwp1YPhU49ocCJypJ8xposEhpEQ++X9Y8iXQnco+yM5jZiwUrn/71kzLlIxG/ipSzm
 HNhED76TJdWpDNVJ0VsBHScNM3huCwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110142
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 8/7/2026 10:08 AM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
>
> This also allows to save/restore this field during migration.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         |  4 ++--
>   hw/s390x/s390-pci-inst.c        | 10 +++++-----
>   include/hw/s390x/s390-pci-bus.h |  2 +-
>   3 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



