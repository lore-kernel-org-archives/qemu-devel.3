Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8859C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVbp-0007JW-EQ; Tue, 30 Jun 2026 06:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1weVbn-0007Iz-Dt; Tue, 30 Jun 2026 06:22:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1weVbl-0004Y6-Nw; Tue, 30 Jun 2026 06:22:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9n9qi1578226; Tue, 30 Jun 2026 10:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AGjhYe
 MyleodoNOzT/Q8+eG7yAoXg7SVuR2tcUHMosI=; b=gytYtNE3NSV7KK+k8DGrQg
 /WIZC8gUfcvNMHertpgymZlRBLOb/FmoVSL/IEXiWw9nlxzYhHS4jWvk26CpY0sJ
 eq8P/tCtuNAFwOVJUozBEBcXWjhvRSu1AfKD+y1BrQPXihXvTiDvFCvhhiyyrD54
 Ml3n5UKdZV2jaoTzSBv+PDDocsJjvn5vLePDxNXJqEwrKnPxd7GX8dPr1JH3TXrN
 pxGz/RhX7KqHO/ARF5jQgoAHbyeGg566ezV0rEZBqtUU2aIbzD6t5ChIOKBQvvAQ
 BRryTb7l/BIHZKXIwLRTld7oEyFN/2VQMSTMgpat5vigjquOncpC5aGdBD621eNQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rewsjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:22:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UA4fPL006108;
 Tue, 30 Jun 2026 10:22:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy9d08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:22:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UAMD5F21168690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 10:22:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 928AC58054;
 Tue, 30 Jun 2026 10:22:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96FF258055;
 Tue, 30 Jun 2026 10:22:06 +0000 (GMT)
Received: from [9.43.123.94] (unknown [9.43.123.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 10:22:06 +0000 (GMT)
Message-ID: <d58ee809-02b3-49be-b927-eacf2da8bfb5@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2026 15:52:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, mst@redhat.com
Cc: harshpb@linux.ibm.com, npiggin@gmail.com, fbarrat@linux.ibm.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, adityag@linux.ibm.com,
 amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4398d8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=N1-tE7rikoB3GCo6Uq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: doAWwkymRZHl_SkDgEw2kGeNdUjv3Ssu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX4VaekMmb9GvD
 1zT7YNmmDTz86/KY/LpTlmdqVdOEWTjUxPehVjkX+tFWZmwblce4n2HRRtM5zxffLWRxiH1mF6x
 VfFgbS77wywX15l4NfFRX5AlLLjs0poDtpYw1XUsxh0nd0yHAtF32o20x+NQjVCV9LMI1Q5fwjK
 Ond+2Gu+4Ljs89KwA2AjI2Vi8cCbzkguP2t0+kM/BRpadF8ESiFBxGSDzW+LJbeUcy4X1hFl4e6
 W0DNZvB1MsXbJKhtjz73hIw6mcO14QSZhZm8fIN59JnjsBXyYICAp4Z9y85Vz24KhVOhaHOcS0i
 31EBwErN6jUmVX237KWrqa9a5Pt1k/gh0jFALI4I5tFsMBNgHkdGIB01RbyrVRiEHrzMPdtkZYL
 FJmXMJGU8z0vrJ40uuxJfisX1aiNM+q3iEzJR27TfbplCxOhNo84uEHw7bC55Nkj9JL0mHQmf+n
 VCCLXa30P4ROfMiFQMA==
X-Proofpoint-GUID: xQgYoFSdDW-3I41MIoWLGolqICkYrO2t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX9BUyPG1uLrl+
 fEl8FPg3jA/U8+1hd0PfBLtAtxSU2R5QuAJi3WyiHZz6TEdwrCn5iFRG0VqMF6kWlZsy/Vwjt1T
 /aVlQC3VcFtUGkUWgS7n+58TnKzWO4M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Cedric, Michael,

Is it OK to retain you Rbs in the next v6?

or would you like to review this v5? (as the patches have evolved since 
you last reviewed.)

Regards,

Saif


On 17-06-2026 15:20, Saif Abrar wrote:
> Hello,
> This patchset resolves the review comments for v4:
> https://lore.kernel.org/qemu-devel/20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com/
>
> Thanks to all the reviewers for their efforts.
>
> Major updates include the following:
> - Rename to phb5.
> - New file for common definitions used in tests/qtest/pnv-* files.
> - Initializing PnvPHB4Class members within class_init method.
> - Updated IODA3 PCT table max size to 128, each with 2 entries.
> - Multiple general cleanups.
>
> Tested with 'make check-qtest' , 'make check-functional-ppc64' and 'make check'.
>
> Regards.
>
> Saif Abrar (9):
>    qtest/phb5: Add testbench for PHB
>    pnv/phb5: Add reset logic to PHB5
>    pnv/phb5: Implement sticky reset logic in PHB5
>    pnv/phb5: Implement read-only and write-only bits of registers
>    pnv/phb5: Implement write-clear and return 1's on unimplemented reg
>      read
>    pnv/phb5: Set link-active status in HPSTAT and LMR registers
>    pnv/phb5: Set link speed and width in the DLP training control
>      register
>    pnv/phb5: Implement IODA PCT table
>    pnv/phb5: Mask off LSI Source-ID based on number of interrupts
>
>   hw/pci-host/pnv_phb.c               |   1 +
>   hw/pci-host/pnv_phb4.c              | 581 +++++++++++++++++++++++++---
>   include/hw/pci-host/pnv_phb4.h      |  16 +-
>   include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
>   tests/qtest/meson.build             |   1 +
>   tests/qtest/pnv-host-i2c-test.c     |  13 +-
>   tests/qtest/pnv-phb-test.c          | 235 +++++++++++
>   tests/qtest/pnv-qtest-common.h      |  24 ++
>   tests/qtest/pnv-xive2-common.h      |   7 +-
>   9 files changed, 868 insertions(+), 76 deletions(-)
>   create mode 100644 tests/qtest/pnv-phb-test.c
>   create mode 100644 tests/qtest/pnv-qtest-common.h
>

