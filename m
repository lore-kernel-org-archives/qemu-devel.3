Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494DCC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wych7-0001UX-00; Mon, 24 Aug 2026 17:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wych6-0001UL-DE; Mon, 24 Aug 2026 17:59:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wych4-0006Dy-V7; Mon, 24 Aug 2026 17:59:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJVhCW1725617; Mon, 24 Aug 2026 21:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/Z2zEi
 x5O/JPZMuv5pHvUicfjJaVFNt6Acbo7Bs5lMQ=; b=RBy4kZXjO4k2f5OKmx6/Bl
 y525/p0ZVj1YZVKDVbbXjyXDp1iIGWXg62gO3JUZaH9q3AJKHZpWrCxEitMC7LFw
 vaIJ3/eQ1LHDHJf+xn4+p/ptZbj4yip3L9SRYY9sw6uBzLw7+j8mAr+8YXW5fGKx
 9DvL7IGn7r7suPA7wivF9Xl+8sMUfTbpZzOSJAJKDkPE2H9xRK8wMevGOPn04zxD
 95aF5OpiKeTr5KW+DuXNC8lUQKH8cg8AFM5xVE37UW4MCrdxzM968YBQZcab/pfp
 Z5sAagxktzaeCNpMxniT9826w7mOv3p0Owzjny5gOXX/e2zsgH93uSWJV5VvUooA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ecdgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:58:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLuTev008239;
 Mon, 24 Aug 2026 21:58:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh0mqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:58:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OLwvAW29885108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 21:58:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E51658056;
 Mon, 24 Aug 2026 21:58:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CEA258052;
 Mon, 24 Aug 2026 21:58:56 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 21:58:56 +0000 (GMT)
Message-ID: <590dd310-12f8-47c7-b047-42778f9227fa@linux.ibm.com>
Date: Mon, 24 Aug 2026 17:58:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/15] s390x/pci: Move max_dma_limit from S390PCIIOMMU
 to S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-13-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-13-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8cbea3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=K5RFVuYA7s4pMnEJfqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfXwohXddNM0vz4
 B8e1cdApOJzAGy2Qctdt4RgxHbGUW9GKc270RlBH6VLHGzg/HRJxsJ+eQEmu+nosGJgO2vLD1NB
 sYoK1vACP+bADjqSXj7q2W4qBGuoULs=
X-Proofpoint-GUID: x9zTDQPH09tArvMXIVjdzTRI8_Oy1umm
X-Proofpoint-ORIG-GUID: x9zTDQPH09tArvMXIVjdzTRI8_Oy1umm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX43k5gr3nKwP/
 AQvB9OJYxk7XR82D2lJryHsruT+wN1GDdMYZrN89lW1j75MFQMOvpN6PD4oWDRcEehBBvJ/wfH3
 GNK/NtVDPTzQgiwRCSH2CZgsOLQ2OHGFQOhKWtk8LLCVAeAXkK/VNFAzGlfXHRpW7wx/d+j2d/R
 Dh902vTzf1+p6OkUDm6qxg8s0eGjNXvofxc/E2Yo6SIZ1MkjHb8OP12zGUHtAYQHRhlwMCUX/qS
 evolK6nRU8OmXAIFMCDQNd7ZISss9LcB3gLNlbkvPTHQKg17WyIrUMkYraQ0iywpgWIH3tzvBUC
 2nkvrH6Qogwgk4jdLKTZllfrHQYjXaXZTns7ITXjgshL7W1xYpcD2FR0B84/j+nXnyok9W4VlsS
 Ay5sD0b8ReSLcaaEc62awDN7E4EfaOqBPLnRU2wCxoVHWa2WyjUoGUbNgMg1PURDJgBvtM65lFJ
 dm2s6GWkSJQ8grDumtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
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

Maybe just remove this last line from the patch?

This field will always be 0s today unless it's a vfio-pci device, which
we are still fencing for migration with this series.

And considering a possible future scenario where we did migrate a
vfio-pci device, we'd need to get the max_dma_limit from the destination
host, not migrate the value we previously derived from this host.

So with that + the commit message fixed as described in patch 3:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



