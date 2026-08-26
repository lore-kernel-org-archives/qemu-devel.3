Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD0CC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzICO-00064o-CE; Wed, 26 Aug 2026 14:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzICI-0005y7-Ig; Wed, 26 Aug 2026 14:18:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzICF-0005eu-2I; Wed, 26 Aug 2026 14:18:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1hqF314101; Wed, 26 Aug 2026 18:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UokiyT
 vohVu5UHigruFeJHFnYdIuXRUm0TGq3Li/bys=; b=RCUGtZ4Py8dbpLACdFg7oh
 bhKocxDiIeAKZ8NsFdT0i+7To3kxRzOGzyCXFXGTuVjoENUJSPMqWuwR2f287ldn
 ansY5dC482EeVHkf5oTte5P3W0agvaiWoSSajhl2GZ5m7j7w076ASdJ9Kk2L0UCs
 lFTxEsm36J9Nx1yJrGAndibzGOXfEs9Wg59D7BOXBDWJ+L3DABeXRvv1OAQyVzbu
 i4KDTkB49+3JGRPE8LW6/23gIc9CdICal2Vys87+82vAjqqIENqGtVSDzdQWtKHR
 f7gXmmtIuMCoc0gTJNH85uI+zeMnGz22sRXcH/hVX8bOEzX0IQQedm8xsfx6JFlA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j0g7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 18:17:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QHuORn022071;
 Wed, 26 Aug 2026 18:17:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qbn0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 18:17:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QIHtuE17498840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 18:17:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26B9858059;
 Wed, 26 Aug 2026 18:17:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E312358058;
 Wed, 26 Aug 2026 18:17:53 +0000 (GMT)
Received: from [9.57.45.223] (unknown [9.57.45.223])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 18:17:53 +0000 (GMT)
Message-ID: <7c7f089c-b01b-48da-b1ef-2f6aca096c44@linux.ibm.com>
Date: Wed, 26 Aug 2026 14:17:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] tests/functional/s390x: Add tests for virtio net
 PCI in test_pxelinux.py
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260818205324.580199-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MSBTYWx0ZWRfX5+ipg9VwOspm
 /oy/2/jvOBzHttTM/0LDdnD35if+XjJlDHyHAopduA8QFxcZLpilYOs8QA5u1vGZIOz3InYKDWs
 Ez/gaXbNc7uoZuzGZnuacZVrOnZq5E0=
X-Proofpoint-GUID: gu5eljNmFBjCPjQ-mlBa0DGQcNobiIe1
X-Proofpoint-ORIG-GUID: gu5eljNmFBjCPjQ-mlBa0DGQcNobiIe1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MSBTYWx0ZWRfX0JNnBVvhO7gP
 YgSVW/n1PxdZh6Cpy5lcGOVYJfrBYvO65QPJqcM62fCs0E17izxkksrW+Cs2kfu5qlOT+EofIjU
 zMjQkiDcI4AIDKCyhWFiUiuDvZ4K+8hUvEa24W5BZW+UW+r8SZ0XsGYXSdL1Jihb+a1wG6dz8Tx
 NrJ0EoeNuj74h6zTRIMRw4TG9q9RWbcZh6Uw4a1ICHHGFQ22garG0plwNEMkfPgu80dJbWE978c
 w+lqLaL1tHcuLhNK7RrirtzCDhiEpKNlLnlWyFC8hlrNzcdvyQeaSiQo4aQT25fy84L2zWVqujI
 k2QYnt88Q+eGhv9cqUIMjUldi/pysndxo2+u7AEwXQ+ICtVcVDGK+H6mW7doSRwQDMZqv5+XiIx
 rjbd2ZHwtzN0MbdDJlyUEOKIC2DddQeIWGfG4+q2OgFJxi4XfONM3VNK6XxP3r8KIrKa972hBGP
 tRwLuCk1xNbuaA2iTPQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f2dd5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=TjeHpCvXNFeaI94agQoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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

On 8/18/2026 4:53 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> extending the pxelinux functional tests.
> 
> This patch adds PCI variants of all existing pxelinux tests to verify
> that virtio-net-pci devices work correctly for network booting.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   tests/functional/s390x/test_pxelinux.py | 71 ++++++++++++++++++++-----
>   1 file changed, 59 insertions(+), 12 deletions(-)
> Tested-by: Joshua Daley <jdaley@linux.ibm.com>


make check-functional-s390x MTESTARGS="func-s390x-pxelinux"

...
ok 1 test_pxelinux.S390PxeLinux.test_default
ok 2 test_pxelinux.S390PxeLinux.test_default_pci
ok 3 test_pxelinux.S390PxeLinux.test_ip
ok 4 test_pxelinux.S390PxeLinux.test_ip_pci
ok 5 test_pxelinux.S390PxeLinux.test_mac
ok 6 test_pxelinux.S390PxeLinux.test_mac_pci
ok 7 test_pxelinux.S390PxeLinux.test_menu
ok 8 test_pxelinux.S390PxeLinux.test_menu_pci
ok 9 test_pxelinux.S390PxeLinux.test_uuid
ok 10 test_pxelinux.S390PxeLinux.test_uuid_pci

