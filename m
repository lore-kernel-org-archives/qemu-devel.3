Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D891606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n3Jb9rzd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRdO-0005wp-OB; Mon, 26 Oct 2026 16:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xLRdM-0005vX-78; Mon, 26 Oct 2026 16:49:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xLRdK-000289-Et; Mon, 26 Oct 2026 16:49:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QJENd1370535; Mon, 26 Oct 2026 20:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RVQ6J1
 41ytrvuWrL7nfA0Hr29vhmnyHsW8ZMKBeIlio=; b=n3Jb9rzdw/reMBAk/nuSiX
 83/vbUxLGVZ53PfJg/B1AkFVFQY7gMu48KPtBOkIYn1cr+UoqggPWRos+lmKT6Vd
 R2MIHS0n8nzzKEKHo3mPOBpt0NH8Cw6Zm3LBC5ygUOOhLfpxOAwB0+itFtlh3Tt/
 BFz/s9zJ+dIIqikygCuCrtRw7W3rpCyhGc6c35xflR1b2AAa++KLCf15zxHJ5Ose
 8P65OxUV3jjc4KnU1N6ZoGx86PpCmAuso3NxvfNblqV8Kuw5/UT6JV8gDOMIEN3v
 DKNmcNW9p8SvcbfO3J9fAwZMAElZ13wXTec0qzVCEQ/QH2zs0brToSGeKAu624Gw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm63vcx2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 20:49:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIov5O2939298; Mon, 26 Oct 2026 20:49:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh80jfvrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 20:49:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QKnO0d4915732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 20:49:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B574A58056;
 Mon, 26 Oct 2026 20:49:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2273658052;
 Mon, 26 Oct 2026 20:49:24 +0000 (GMT)
Received: from [9.61.248.120] (unknown [9.61.248.120])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 26 Oct 2026 20:49:24 +0000 (GMT)
Message-ID: <e7c1b33e-a26c-4975-abf7-8ae4cd53f417@linux.ibm.com>
Date: Mon, 26 Oct 2026 16:49:23 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/pci: Change reset method from legacy to
 resettable exit
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 qemu-stable@nongnu.org
References: <20261026171325.876-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20261026171325.876-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4MiBTYWx0ZWRfX4dr77y4fuAj9
 YW9BBqsiv9ibG/lHDV06tt0gIo0IUe2DI5oFzJ8fPbSAO00mU7VPhqTyQ/SjhkIzgmOZMKstRp0
 tYwkNY3XCwunbeo9TiO8b+PSpRmlvOk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4MiBTYWx0ZWRfX/fyV6wbYkCLN
 qwOpoldPkA4bLv42c4xFvy27ujHaJaEOeBa4UUerahHzA5sR2wGB1pvg9oZ69Fu6UiwqYkYj5Hw
 aAtAK+SaaQ/d3XiQGMGqLNKvCEi7b5nyOybHjSncNODvKVIUN8qU34CGt9iO8rLnBMemGsmgixt
 pjV+oFbfE/hFkU+ygo64q4WaYsy/SinF198YBgoAhDWinY8VzSLq/15muFvrTJ0VgRjGCTJI5CW
 DuAiMOCcJmUN8FC6cf31U7UASyanLYxRxRRdC5+Xuot3aCr0nVPaXw0tw5tAqaOQJc125Z+SzR2
 MQ3xQiTkab4/DhqPr5CuRvt2ga/iL0vyAVHHZwpDXfLZe9HwSCWgWSYPvtpSF2A5iQdAVLh69l8
 6U16ZeycR+xEhEBv6CRZdgaxCmXj5hT/tNgkx9/jZyE/W1dUnCDok3HkiuNNaMOlTx8AF+mfQ6r
 E2ndE3yHKiRZh7at1fA==
X-Proofpoint-ORIG-GUID: VQLMffYKwkdkeCHydvcwLH6WkblFUYsm
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6adfbcd6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=dxUtY4db0SHtNY8ba_oA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: VQLMffYKwkdkeCHydvcwLH6WkblFUYsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260082
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 1:13 PM, Farhan Ali wrote:
> On subsystem reset of the s390 PCI host bridge (TYPE_S390_PCI_HOST_BRIDGE),
> child buses S390PCIBus and PCIBus are reset in order. Because S390PCIBus
> devices are reset first via the legacy reset hook, IOMMU mappings are torn
> down before the PCI device itself is reset. For a PCI passthrough device
> this opens a window where the device may issue DMA to addresses that no
> longer have valid IOMMU mappings, causing an error (PEC 0x7) on the host.
> 
> The QEMU reset documentation (docs/devel/reset.rst) specifies that IOMMUs
> should perform teardown in the resettable 'exit' phase, after all devices
> have completed their 'hold' phase. Move the S390PCIBusDevice reset logic
> from the legacy reset hook to the resettable exit phase to close this
> window.
> 
> Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
I was able to reliably reproduce the failure you described in just a
handful of iterations by running iperf3 on a guest with a passthrough
mlx5 device, with options to iperf3 for high parallelism and large
message size to saturate DMA usage, doing a sysrq hard-reset while the
test is still running, and repeating these steps in a tight loop.

After applying your patch, no PCI error events were observed across the
200 test iterations. Thank you!

Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>


