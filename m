Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E658606A336
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gUWr4h8p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnT6-0002nG-Pg; Mon, 02 Nov 2026 03:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNnSh-0002lM-24
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:32:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNnSe-0004nL-7f
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:32:14 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24ECTb1880694; Mon, 2 Nov 2026 08:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ck6pn3
 s5h+6YnN3681jfAV/YaumdS7kJvIDzCxEdFLM=; b=gUWr4h8p8SKf/9ELACTuSN
 rxFAvJpuyNphvT2eND7W+Apst6B1r47JBcLnJ5FLff5c8veEsdw0msBdCA9ZciLf
 Yq/U0LiGBNHbuasKPnnXibuPPQvH5HdnYqN14dbnbv+jBdf4/MTlGuFDk+tP8smg
 j4AUwII3PnSUFw6dm42Hb8I+XExI9JA5d2E5CSArqnnrNxatSFSU+DY1qCPWCZYD
 XbYDatDm33XTqwt8ODTiMqmMadyX7JCWLCCly3CTQt0iGAvJaeMsfz4ctVXOrhfA
 JkLXoNMoKBREu0u/zGXSvqOYBfGqCCXYYRS/UM2XjT1v96yKZHL/LeXZysxQ4Mdw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826fg3k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 08:31:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2452ME280560; Mon, 2 Nov 2026 08:31:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjvx51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 08:31:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A28Vrgj22479470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 08:31:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A009058053;
 Mon,  2 Nov 2026 08:31:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4D0C58043;
 Mon,  2 Nov 2026 08:31:49 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 08:31:49 +0000 (GMT)
Message-ID: <1fe583e8-c4cf-4fc1-abf5-0ee9fe6486a7@linux.ibm.com>
Date: Mon, 2 Nov 2026 14:01:48 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] tests/qtest: pci and MSI-X fixes
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, philmd@linaro.org,
 farosas@suse.de, akihiko.odaki@daynix.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
 <20261028102612-mutt-send-email-mst@kernel.org>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <20261028102612-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -OkstqWannid97SfwyV3rK7hVOcaUZYq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfXx8dGZnnepuMt
 tqSjc4paYiiSi1viCQL/mmpzPh/VQidjZuLRX4ItsXkVbsEsuSbxrS1qKW5k8vWBjaVSMvDfUpb
 8qGMhnu8ZG9remDANWnr9CdrXzYnvAYdpKxrqldzoGxCLHzaXvzHn5pXR9dnuc7o96/pKTFrhBL
 pJOSQPgln7YMrFTj5F6I6tDKMUHZ46C8qTSMl2QvRJrO56taHlRWyQMVPsiJKQY3MbWrCFGiS0h
 0be/lMpAuGpz0reQJy4gKcz943Le20DmH+tvFWbr0v2jViXpfbj5rerUgaS9Q+EORkuvckTcLGV
 pysCAOIp/qv4JriUq3eOQWLYavQojc+MOaBmqdxtyJNxdkMN20wxAEAujU1fY8vTTWpYn3fL+/k
 rehy/B7aDJopYiRiBrYkyYSLWi/TOPl7kkz51bU9HbMBzrlZZ1xqMqEeYLiMFHUPLB7qayJz2EM
 JaRcrgQQ4LICEehUT6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX1JMw+XzxpyO8
 Xh4OQ9RRcDeXcIlkh5r+lHcajkLpBLlYsdCt2SQOB0APakIeH0urSxonLGMU8mKsTW1HNDLQWlN
 U8cEiGGJU6/pgJ6UJLRpFZjbShiJ/m8=
X-Proofpoint-GUID: 7lBkRZj-CISbd-TiiMBQ5BctEGv4j809
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae84a7c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=z4glEzOvAAAA:8 a=20KFwNOVAAAA:8 a=P_L9fI11Hn0w-Uy76A8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/28/26 8:02 PM, Michael S. Tsirkin wrote:
> On Tue, Aug 18, 2026 at 12:25:30AM +0530, Jishnu Warrier wrote:
>> To: qemu-devel@nongnu.org
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Fabiano Rosas <farosas@suse.de>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
>>
>> This series fixes a number of issues in the pci and MSI-X qtest
>> infrastructure, and adds new functionality.
>>
>> Nicholas Piggin is the original author of all patches in this series.
>> This submission takes his v5 posting forward, with the additional
>> changes described below.
>>
>> It was originally posted as v5 in May 2025 but was not merged.
> 
> 
> Decided to dig this out and tried applying.
> 
> Breaks nvme in CI:
>   https://gitlab.com/mstredhat/qemu/-/jobs/17536598571
> 
> If you can try rebasing, would be appreciated.
> 
Hi Michael,

I submitted a v7 for this series.
https://lore.kernel.org/qemu-devel/20261102035306.2291147-1-uverma@linux.ibm.com/

Regards,
Utkarsh

>> Changes since v5
>> (https://lore.kernel.org/qemu-devel/20250502030446.88310-1-npiggin@gmail.com/):
>>
>> - Use sizeof(data) instead of literal 4 in qtest_memread/qtest_memset
>>    calls inside qpci_msix_test_interrupt() [Akihiko Odaki]
>>
>> - Fix MSI-X capitalisation in the qpci_msix_test_interrupt() doc
>>    comment (was "msix", now "MSI-X" throughout) [Akihiko Odaki]
>>
>> - Replace the per-device boolean flags (pci_enabled in AHCIQState,
>>    enabled in QVirtioPCIDevice) with a bool mapped field on QPCIBar
>>    itself. qpci_iounmap() is now a graceful no-op when called on a
>>    bar that was never mapped, removing the need for guards in callers.
>>    [Akihiko Odaki]
>>
>> - Remove missed qpci_check_buggy_msi() guard in nvme-test.c
>>
>> - Fix off-by-one bound check: use barno < QPCI_NUM_REGIONS instead of
>>    barno <= QPCI_NUM_REGIONS in qpci_bar_reg() and qpci_iomap(); the
>>    previous condition allowed barno == 6 which is one past the end of
>>    the 6-element array [Amit Machhiwal]
>>
>> - Remove redundant memset(&dev->bars_mapped[i], ...) in qpci_iounmap()
>>    that immediately followed dev->bars_mapped[i] = false [Amit Machhiwal]
>>
>> - Add explanatory comment before the msix_addr/msix_data != 0
>>    assertions in qpci_msix_test_interrupt() clarifying that 0 is a
>>    libqos-internal sentinel value [Amit Machhiwal]
>>
>> - Remove always-true g_assert_cmpint(entry, >=, 0) assertions on
>>    uint16_t parameters in qpci_msix_set_entry(), qpci_msix_pending(),
>>    qpci_msix_masked(), and qpci_msix_set_masked() [Amit Machhiwal]
>>
>> Nicholas Piggin (10):
>>    tests/qtest: Enforce zero for the "un-fired" MSI-X message value
>>    tests/qtest: Fix virtio MSI-X message endianness
>>    tests/qtest: Add libqos function for testing MSI-X interrupt status
>>    tests/qtest: Enable spapr dma with linear iommu map
>>    tests/qtest/ahci: unmap pci bar before reusing device
>>    tests/qtest/ahci: don't unmap pci bar if it wasn't mapped
>>    tests/qtest/libquos/pci: Add migration fixup helper for pci devices
>>    qtest/libqos/pci: Enforce balanced iomap/unmap
>>    qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
>>    qtest/libqos/pci: Factor MSI-X entry helpers into pci common code
>>
>>   hw/ppc/spapr_iommu.c                   |  10 +-
>>   tests/qtest/ahci-test.c                |   8 +
>>   tests/qtest/e1000e-test.c              |  21 ---
>>   tests/qtest/igb-test.c                 |  21 ---
>>   tests/qtest/libqos/ahci.c              |  12 ++
>>   tests/qtest/libqos/ahci.h              |   2 +
>>   tests/qtest/libqos/generic-pcihost.c   |   1 -
>>   tests/qtest/libqos/pci-pc.c            |   3 -
>>   tests/qtest/libqos/pci-spapr.c         |   7 +-
>>   tests/qtest/libqos/pci.c               | 215 ++++++++++++++++++++++---
>>   tests/qtest/libqos/pci.h               |  21 ++-
>>   tests/qtest/libqos/virtio-pci-modern.c |  30 +---
>>   tests/qtest/libqos/virtio-pci.c        |  86 ++--------
>>   tests/qtest/nvme-test.c                |   4 -
>>   tests/qtest/vhost-user-blk-test.c      |   6 -
>>   tests/qtest/virtio-blk-test.c          |  12 --
>>   16 files changed, 262 insertions(+), 197 deletions(-)
>>
>> -- 
>> 2.55.0
> 
> 


