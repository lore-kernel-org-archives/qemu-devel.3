Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8EACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6U5j-0006f8-6b; Wed, 08 Oct 2025 09:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v6U5Z-0006cQ-RN; Wed, 08 Oct 2025 09:20:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v6U5R-00041L-Fs; Wed, 08 Oct 2025 09:20:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5985mRcM005704;
 Wed, 8 Oct 2025 13:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=s6DuQk
 HT8X1dcvUWbJ4n6qV5fCbofV9S7C7ywfZP2NE=; b=QUt0H4oCvDLogAQvxsHZm5
 wKP++78tyVxHp9lBk88c8lQGujVgLEZITsn7OEmxDkkgCojScw/Y4ZUQZtsHjrTA
 2ZiwUlKNMTUjj6Mzcx+mwx4SF3Vpeeczb1wDCJK69q5ACLkH+Oa6/3qVdZqq3BOa
 gI4+EiGjacMP8AoRQGHNGDLgU4c1ILhiaZ8VbhaeJKxl8P8xT02WNQiqX2s+mDWJ
 SIZ61FHMbX781vLRNmJP67ny/PHWVn+ft0cRNUL8t8YaTxPCtE/wSsD8YaP0iYZw
 43odQoNtDKInHxVtTEk2EGFWbQOl4yEuUnuwhqAwr8xWw7gNbewJNH3g3sUZQ8ZA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h5bb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 13:20:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598AhnJ8013189;
 Wed, 8 Oct 2025 13:20:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kg4jret0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 13:20:00 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 598DJxWi60031346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Oct 2025 13:19:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E83D58050;
 Wed,  8 Oct 2025 13:19:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3135458052;
 Wed,  8 Oct 2025 13:19:58 +0000 (GMT)
Received: from [9.61.90.117] (unknown [9.61.90.117])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Oct 2025 13:19:58 +0000 (GMT)
Message-ID: <1e61ac7a-3ab1-44e6-af91-fee9a261cb7e@linux.ibm.com>
Date: Wed, 8 Oct 2025 09:19:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x/pci: set kvm_msi_via_irqfd_allowed
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20251007205614.188365-1-mjrosato@linux.ibm.com>
 <9e04c38e-507a-4b68-a522-7e9c4a130d9a@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <9e04c38e-507a-4b68-a522-7e9c4a130d9a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX+h9rlA0Ym++A
 2GrO6P1s/oHGoJ4/CAhxAPPLaG1uwmyvOY3jTfcwKdCgIHu32z12JbuRuBO24rYmE+VILdw1SRZ
 zOR3VJlKzxsCkClNd/O/JN0vjGdiM62bCQLbKAFKp99B79nXwVULYoyRE/5Yh0YMAWS7JUZSdOB
 GuClYMB+nutx9qSwRFTRFJhqfhoAVVJFbtSeDZFpfwufuMR3besa+4/HR59hyzRc43xcrPmGGTL
 RHViPaD0jTRav6r1YRMUWu4s1Oljd2KlXX/ly7OHm3LVj99cwXVJOje5Zq8nAW2IfbG3wRiikKb
 7Tm68M1ov0Ccw3MwWyGBWEBMS1bgevP+w575QRB++31qqWBEP8o/M+QC2e5itdBki+OeDld21hT
 vYuLTHBUlr1zbrCNSZffKJsh705Xpg==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e66501 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=VzAEzlHLRh73CqL-NnQA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: cbYUuTNSWTcPUWaDSrpmImLwiNAicqvL
X-Proofpoint-ORIG-GUID: cbYUuTNSWTcPUWaDSrpmImLwiNAicqvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/8/25 8:51 AM, Thomas Huth wrote:
> On 07/10/2025 22.56, Matthew Rosato wrote:
>> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
>> it.  This improves s390x virtio-pci performance when using kvm
>> acceleration by allowing kvm to deliver interrupts instead of QEMU.
>>
>> Reviewed-by: Eric Farman <farman@linux.ibm.com>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>> v2:
>>   - add review tag
>>   - tweak commit message (David)
>> ---
>>   hw/s390x/s390-pci-bus.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index e8e41c8a9a..88852acf45 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>>       s390_pci_init_default_group();
>>       css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>>                                S390_ADAPTER_SUPPRESSIBLE, errp);
>> +    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
>>   }
> 
>  Hi Matthew,
> 
> this unfortunately fails to compile without KVM (e.g. on x86 hosts):
> 
> ../../devel/qemu/hw/s390x/s390-pci-bus.c: In function ‘s390_pcihost_realize’:
> ../../devel/qemu/hw/s390x/s390-pci-bus.c:903:5: error: ‘kvm_msi_via_irqfd_allowed’ undeclared (first use in this function); did you mean ‘kvm_msi_via_irqfd_enabled’?
>   903 |     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |     kvm_msi_via_irqfd_enabled
> ../../devel/qemu/hw/s390x/s390-pci-bus.c:903:5: note: each undeclared identifier is reported only once for each function it appears in
>

Argh, thanks for pointing this out.  Of course this value only exists when CONFIG_KVM...

What do you think about using a routine in hw/s390x/s390-pci-kvm.c to set the value (and is a NOP stub when !CONFIG_KVM)?

Thanks,
Matt

