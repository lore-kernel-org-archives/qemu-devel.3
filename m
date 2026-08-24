Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAEFC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycQl-0006Dj-Tt; Mon, 24 Aug 2026 17:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wycQk-0006Cy-2M; Mon, 24 Aug 2026 17:42:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wycQi-0003Tn-NU; Mon, 24 Aug 2026 17:42:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJVlr82744510; Mon, 24 Aug 2026 21:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n7EJQ3
 /dB+uboMfq7HAkM69dHRvN2zAHZaQ1BIFR/4s=; b=rSigvvTsi9ii+1nkIoV8xZ
 IKdvJ5UiT095DBouU+eGpwWOqQX5XTPuQHH7CyhbXKkgedfFSHGiCMWWEV0RzcI5
 LCWi+ppAza4pWGrosepQsZsPfUhCdQ7hyWDi26kxjHzH8C0vQR62ZITtJdmldXfp
 XkPIu/V7+vghthDjvxqqGRldmgNhs5AWImsLwv8vaEy5YbvbTmTJMfYRUOoKeV7r
 V/PG/tx1AD2TSMCgPrOdRVbioSmgCr4V5dk+Z/nSec0ajmYZgd8rwcE5Dl6OQI5Z
 I6EdAfeZiJF6hff9YHi+xgw3A40J6ciB2ENzhirJ7M733DFAr3JswUtzTWrALhPA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hmhc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:42:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLfJ7J020210;
 Mon, 24 Aug 2026 21:42:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q0umm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:42:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OLfMwL15794790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 21:41:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 377615805A;
 Mon, 24 Aug 2026 21:42:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7153158052;
 Mon, 24 Aug 2026 21:42:01 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 21:42:01 +0000 (GMT)
Message-ID: <eb81c350-42ed-4666-abb5-5e1276cbde4e@linux.ibm.com>
Date: Mon, 24 Aug 2026 17:42:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/15] s390x/pci: Move pal from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-12-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-12-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX+6y1y5D8jrDN
 r5Jaqt2zdsGPdkEdzNcIBWqRRbUUQxcdZRcpJxIMr1Ts+QsuL6ULrjxpTGmF5EJ11+cfrwf0hHl
 5iy3Vh3AkxIkpm9iny2BpBEZ24ov5Fo=
X-Proofpoint-GUID: 36iBs6gpNIhFSAD6wQkbRSv1Jb96RO9X
X-Proofpoint-ORIG-GUID: 36iBs6gpNIhFSAD6wQkbRSv1Jb96RO9X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX9TYqfPd/0/4R
 c+/92HUPbsa/VjRsq6aoavlMWhd8LUDF9p4sljY1IrAz7wmGWhiiIVpib/YCPy2KL37YgBmk4Ii
 FYj7vnGC/Xy0xA5HaF06rWJU8DLD2jR0jGfZkKrNFXI16+zHYOqX0lhKfn0yJGBROo2z3TvbY6U
 7/SfNQUJbsLJb2xbDiB8IUamEyG58DpPTmpWT6iI6ztMmfPk/h8QFEUkIT6eOIlzVtqeJrwPSaZ
 civvAd1V1kv/TyhcDGttZeNf9T6EtEcseLZuYvTXQ5OCmiOI/+rarUJ0bleeZmCCpVr0csfmRjq
 oJRMyos0T3dXHGhELMVOR8VZaBp/Jj7+/uXbhmeMa+c01PEIrOE5+9RXarPrHAidOhtdTgP2irI
 tjltoCTzoZEYCb5haMNfe4DDKONmwmF1y32ntrAdZCFHBuBqyYC4AmJreYCff2CKbcfKbkwChQy
 IdDQDXNjMqDUwfqCSfA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8cbaac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=K5RFVuYA7s4pMnEJfqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240182
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
> 
> This also allows to save/restore this field during migration.
> 
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
With commit message fixed as described in patch 3:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

