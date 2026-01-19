Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDF9D29C2A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq1K-0001tW-Pm; Mon, 19 Jan 2026 09:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhjqo-00089X-QQ; Mon, 19 Jan 2026 02:39:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhjqk-0000zp-4S; Mon, 19 Jan 2026 02:39:00 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60INfWS7002734;
 Mon, 19 Jan 2026 07:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=X8WOKT
 3lNXu+9QrGrMvxE/ZfONCI6g6WEFj1cabPSsg=; b=dTzRlcIiDdINksYCijamwK
 dMEHcAwTCKXnCB4qfl6Fk/GiyXMhNOIBV5/oqY5Szd/oOY0t9nzSqHATiHBZw2po
 A06PfpS1ZGhPpeFbUAjZoVqPB2EcOP5P9h5nu283lylrWwp2w+mCKCW6Gkf43Frl
 06Zr+9m4S5A3uhZVFGbjhjv2f1esKT5MLaffYv1sHY3Oy7EVSBkMxw0AcGUhr3xf
 9kH7Bnc8PTB+XTtJe+gct6bmDw3Q+KiIpLEs9bRvYbpaEL8Rt9D66v0EdmYrR9s/
 9In2jOB+itIoKuyG1T1Zs5+vbyWmLYgVkESEUEpSfgoAAsK9sLd3MJt2AZ3srt5w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4xye3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:38:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J6s2ms016679;
 Mon, 19 Jan 2026 07:38:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xnhvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:38:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60J7cnjt54985146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 07:38:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42F8F20049;
 Mon, 19 Jan 2026 07:38:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11C7020040;
 Mon, 19 Jan 2026 07:38:48 +0000 (GMT)
Received: from [9.43.98.125] (unknown [9.43.98.125])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jan 2026 07:38:47 +0000 (GMT)
Message-ID: <d1d537b7-5fbb-4cfc-be4a-5e65324a63a3@linux.ibm.com>
Date: Mon, 19 Jan 2026 13:08:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Implement MPIPL for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20251206055648.1908734-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=R8AO2NRX c=1 sm=1 tr=0 ts=696ddf8e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0rgLX0TTvtzbSEFFmHoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R9b6S5oK6zVitmzXQT-se6hWlxmAMTii
X-Proofpoint-GUID: R9b6S5oK6zVitmzXQT-se6hWlxmAMTii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1OSBTYWx0ZWRfX2m17iGgK2J8w
 WGog4Qwiql7rgsWj+74kgHJqkKjKKyg7hjMyxJVrYLzxOVUE08OePOVhZ+vreI/x4pdjw6naZU4
 IC41/khMs1xQ7ZHxLKbeF1AHNrPLffzYhLY9blHEjutsmKMJIsRIG/r1akT1x+rP6HRVU1G2kmO
 +dtFJgljRdTjNdaYTIV5+jh7IEr2NHCuMrzztASGqfM5Z/suXkUEOgJqY5PgRbhCB139iXbCTeH
 YNOCCeS/laEWvW9hERYOv0VjLY0oiaAkRcNwXv0sZrvU0Y6gnDAoFOBaa3YZedGd+h8mhTylxsv
 PPSRyKcMRTA0zmyahou6Pr1esiHOHwmsKGNuvet/AXxh11pIa72k2IMqIa42XHHXb8uvc1oWvcL
 IJgDB6XE/EtxKDRUt/7hGJnlwOHAvt3DypvchZ+7agoCyzPM/uph7hdUbzqKrduNryGxEjiqQGK
 GVgI48g5M78NPwc3Nxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190059
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=hbathini@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Jan 2026 09:14:03 -0500
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



On 06/12/25 11:26 am, Aditya Gupta wrote:
> Overview
> =========
> 
> Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
> in QEMU.
> 
> Note: It's okay if this isn't merged as there might be less users. Sending
> for archieval purpose, as the patches can be referred for how fadump/mpipl
> can be implemented in baremetal/PowerNV/any other arch QEMU.
> 
> Fadump is an alternative dump mechanism to kdump, in which we the firmware
> does a memory preserving boot, and the second/crashkernel is booted fresh
> like a normal system reset, instead of the crashed kernel loading the
> second/crashkernel in case of kdump.
> 
> MPIPL in PowerNV, is similar to fadump in Pseries. The idea is same, memory
> preserving, where in PowerNV we are assisted by SBE (Self Boot Engine) &
> Hostboot, while in Pseries we are assisted by PHyp (Power Hypervisor)
> 
> For implementing in baremetal/powernv QEMU, we need to export a
> "ibm,opal/dump" node in the device tree, to tell the kernel we support
> MPIPL
> 


> Once kernel sees the support, and "fadump=on" is passed on commandline,
> kernel will register memory regions to preserve with Skiboot.
> 
> Kernel sends these data using OPAL calls, after which skiboot/opal saves
> the memory region details to MDST and MDDT tables (S-source, D-destination)
> 
> Skiboot then triggers the "S0 Interrupt" to the SBE (Self Boot Engine),
> along with OPAL's relocated base address.

This sounds as though skiboot triggers S0 Interrupt right after kernel
registers through OPAL calls, which is not the case. Please make it
explicit that kernel initiates fadump with another OPAL call after
registering..

- Hari

