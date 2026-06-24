Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FDBCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 04:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFWV-0001WG-EE; Wed, 24 Jun 2026 00:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wcFWP-0001Uq-UO; Wed, 24 Jun 2026 00:47:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wcFWN-0002f2-V3; Wed, 24 Jun 2026 00:47:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O1mWKG3795825; Wed, 24 Jun 2026 04:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4XbrTd
 ARxWknB8AKoQI3KFySKj+qQyHgQ8FWdLl+eMc=; b=bfWdQ5GfxR8LxxH2hPeS4O
 EnYBHIIpDZjM9TgF3Pubu0H/DQmMwt4Gg0Z8gZ79K3MC4vyiYhRWOujTBL7/qsFW
 WTt9fQHl1u11neDT6+y+kISYRpGryCBZxLzF/DpXOZwgpvx1E64OvdLFLtFQocM0
 MJzyPeIB9+nJLn8lCjDkUfuO12dUfv5yLlpJfZcn0CKTiHSvV6DPZOkxT4i1slXC
 Q03eLKq6C4QnIJEmE9ospTsoCfz8H5Q4ISkXmmv4lGFsXn4esvnlPwPf2hIGFfhs
 0Ul2s0M/9heAQqq8qTsKlHtErciFjC0brRHBUSJs2o1bNYMTSt/BqNBfDMjukawQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3jcb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 04:47:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O4Z2cP023232;
 Wed, 24 Jun 2026 04:47:18 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phet0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 04:47:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65O4lHqS46661940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 04:47:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A772A58065;
 Wed, 24 Jun 2026 04:47:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBBA35804B;
 Wed, 24 Jun 2026 04:47:10 +0000 (GMT)
Received: from [9.36.7.185] (unknown [9.36.7.185])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2026 04:47:10 +0000 (GMT)
Message-ID: <e26ac28d-07fa-4564-a1cf-49bc81957424@linux.ibm.com>
Date: Wed, 24 Jun 2026 10:17:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
Content-Language: en-GB
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, adityag@linux.ibm.com,
 amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3b6158 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=2Fe7J2Dmp-ywF56d-9gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDAzMiBTYWx0ZWRfXyFy1awP3hbkm
 SiIEug87uCsobpsSr/yMtW8jeewFhCbhU6a7gcCkmpTnj3HYamvHL2RzNogxXvQGnZKsARP8S3b
 FgPxrG41OOcHxQJ8WMCbZLJ1vun14Jw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDAzMiBTYWx0ZWRfX/lH6LNEo12q0
 2jW1FftT4x/vf/j7yV/cD5LZLzozukxduUnj76EGMUJEOczQVo0nDpnfa8Vbhht+QocOl99nNVY
 0SYNYIGhtd5rVssRogEgDVe6QGoFUFlB1XuW6rIjmlhAuei5puiuolQMbqaZ9K90bVWW8XocxHJ
 UlCrQ4joKsBMGkZ1u1+DEnzdTSGGn49jBup5HnmtQ7p9E45SusBCUtb+pteuM5xuefspnMZA49g
 A/Y4zs+OVEtUEeBHG2KmS9Nny5KWVjsegPk3U8IYKSUecdM5AQ2KteMCzES2SY6jLlQyE7Jqol7
 BS2MKxhWcXWhXIKiCX4vAkog3UxpqMjUscFAybuDjF2Mj16MggZMa189VCGE8008XenITE8sLlf
 9XzaHDsMdiR15N2b9KAaVcKS9N/2D3KxTVRNZsyVDEvAPavRhxwZwuMMGNNXK8eELF51o5NRfds
 xN4mhzpPpLxBN64gtZQ==
X-Proofpoint-ORIG-GUID: 2r7W91vWb265JUPEPz4WS20ObvnTJKJb
X-Proofpoint-GUID: L_TnFsmPtmH8bwgSFijDa5AXN7k3Ynl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 17/06/26 3:20 pm, Saif Abrar wrote:
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

Thanks Saif for addressing the review comments from reviews on v4.
I see you have also included Rb (Reviewed-by) tags from folks who gave
review comments on v4, but (at least me) didn't give Rb explicitly after
seeing the review comments addressed. We should add Rb only once the
reviewer explicitly provides it.
Also, could you please rebase this patchset on top of below PHB 4/5
refactoring patch from Jishnu:
https://lore.kernel.org/qemu-devel/20260608093430.2729688-1-jishnuvw@linux.ibm.com/

While I do not have any additional major review comments, I will let
other reviewers provide any additional feedback or Rb as appropriate.

regards,
Harsh
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


