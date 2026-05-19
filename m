Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8E8CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 05:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPDNg-0008Ug-St; Tue, 19 May 2026 01:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1wPDNa-0008UE-HP; Tue, 19 May 2026 01:52:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1wPDNY-0001Hf-MT; Tue, 19 May 2026 01:52:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J4bW001839474; Tue, 19 May 2026 05:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=N8ixZu
 Z4lH4T096rH0HCzno7DIPDPk4Ldi43ztHL+oQ=; b=L39w5N6mzo13rYUK4wwNEL
 CPOqoWD0nRersgBYnLOvO46Q/XuEEEoCxItWF0QAp1idne18E+Z4g6fo3FPKVFgf
 PNJtU+0Lj5Vj9+JA+ry+PTl4eexVKJEwqlc2Czu2cqaIA4NamSUSzEg7wnQCyej9
 KF+fRTj8ZHbf8zeEBbRpGbgFIo5PfFibwbjC2sDvIr6OT8FKdF37bs+oWtsQu9Mw
 w2YoHKt9TjjwFsQSAN/xqQ2fdsRruR4Yq3rQgY0tOBoEJqVnedqvUAu+SI5SPmvv
 XKKkWSF415Dh7Tcx40u6LHGUogoHOeNFSinUUndnbnWqO8kv2npGXwoPSjfCLtEA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mkcva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 05:52:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64J5dg46009559;
 Tue, 19 May 2026 05:52:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhh4b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 05:52:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64J5qM5r31261366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 May 2026 05:52:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F0B35805B;
 Tue, 19 May 2026 05:52:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04C3958059;
 Tue, 19 May 2026 05:52:15 +0000 (GMT)
Received: from [9.123.126.102] (unknown [9.123.126.102])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 May 2026 05:52:13 +0000 (GMT)
Message-ID: <d8769530-6554-403c-be85-430f46d47ed3@linux.vnet.ibm.com>
Date: Tue, 19 May 2026 11:22:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] pnv/phb4: Update PHB4 to the latest PHB5 spec
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, mahesh@linux.ibm.com,
 Jishnu Warrier <jishnuvw@linux.ibm.com>, milesg@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yWqLWyhB2Dy3jBOfnoXajdP3KgPCA-Cc
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0bfa99 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=pzxsVZ2ziKnreO0vgw0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mXQszkfxSZwrSre19h4hh5JTnTryIrTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA1MiBTYWx0ZWRfXxbfM8vgHeWEB
 bOVdq0Yd6d1BG2vboc2xfVtqDCh8zAOST5yYhmtpHUM5HSJLpSRZxMvbWJNRfNaG8i3f0IBQWRG
 DyNj24/GfpXX8OUXhodAbLjG3FZNuOZ/IEfC3wziX6OJggLal5RXWbUCSGh7dhhi42sHdb0XlJF
 9qAp91G2FEwzibRJqVXIPrUvyLnhDcTYVMZarV9MPyg4kU6h4QTqAZT0jQYRFEBMnndHrAyRoF3
 oLO2gB17ANQlft8m3xcDhet9HBWoJJlo8JJ6FGU5SKc/yP2WGrJmSldvNLab0HZ4/EuS/itPuv9
 KEyRgqxm2K4Tsd3oupalCpi5NGIFJBl/i2hldRb17kcRGJk7TvNcg+dTLCNH1qRBP+OhZKBqB9R
 N9U59TyqPzCz+ogAnH+tKKkli88yfscNWNOMkBwx2WHlfMVGYes9DcCzKNYxzA/711wn8vnToq7
 Ac+9I4KS13fnKvsboLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190052
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Dear all,
Thanks for your review comments.
I am currently occupied with another high priority task at the moment.
Shall get back to addressing the review comments by mid June.
Hence, please expect delay in response.

Regards.
Saif

On 05-03-2026 11:39, Saif Abrar wrote:
> Hello,
>
> This patchset v4 resolves the tsan build failure seen in
> https://gitlab.com/mstredhat/qemu/-/jobs/13201554945
>
> Few variables were declared directly after a case label inside a switch,
> causing the compilation failure.
> These are now moved to the top of the block.
>
> This series updates the existing PHB4 model to the latest spec:
> "Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".
>
> Updates include the following:
> - implemented sticky reset logic
> - implemented read-only, write-only, W1C and WxC logic
> - return all 1's on read to unimplemented registers
> - update PCIE registers for link status, speed and width
> - implement IODA PCT debug table without any functionality
> - update LSI Source-ID register based on small/big PHB number of interrupts
>
> Also, a new testbench for PHB4 model is added that does XSCOM read/writes
> to various registers of interest and verifies the values.
>
> Regards.
>
>
> Saif Abrar (9):
>    qtest/phb4: Add testbench for PHB4
>    pnv/phb4: Add reset logic to PHB4
>    pnv/phb4: Implement sticky reset logic in PHB4
>    pnv/phb4: Implement read-only and write-only bits of registers
>    pnv/phb4: Implement write-clear and return 1's on unimplemented reg
>      read
>    pnv/phb4: Set link-active status in HPSTAT and LMR registers
>    pnv/phb4: Set link speed and width in the DLP training control
>      register
>    pnv/phb4: Implement IODA PCT table
>    pnv/phb4: Mask off LSI Source-ID based on number of interrupts
>
>   hw/pci-host/pnv_phb.c               |   1 +
>   hw/pci-host/pnv_phb4.c              | 581 +++++++++++++++++++++++++---
>   include/hw/pci-host/pnv_phb4.h      |  16 +-
>   include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
>   tests/qtest/meson.build             |   1 +
>   tests/qtest/pnv-phb4-test.c         | 228 +++++++++++
>   6 files changed, 835 insertions(+), 58 deletions(-)
>   create mode 100644 tests/qtest/pnv-phb4-test.c
>

