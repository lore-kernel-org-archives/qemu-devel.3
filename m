Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14C8C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 18:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvKOW-00027r-Mm; Thu, 20 Mar 2025 14:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tvKOM-00026z-BS
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 14:13:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tvKOK-0003MJ-IE
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 14:13:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCRrab030239;
 Thu, 20 Mar 2025 18:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=84gOybjkP7SmKpESwg8um+82TkKV
 i38fSr9kdhTGY18=; b=I4vUOjkRoUyegKfrRQJhwMOiLq7d5psIhnww9hhEVJLL
 qcj9S4L3/xaQKbO407mJ91wx//h4373WuvHFPi009MhvxRE5jt8BJmEETqBziO00
 yWVRy+/UL9q0ExjM2C2op3c6kBYjEa8yjhFxWly27/MMjW9D/+nihsm/ZtR0uAiR
 DH76BIabVP5ykj0iw4h4e9MpcYi47qgrfHjeH2hxi+FzNzoHoh/Ug6GodJrboOR8
 kka+kh6jDtIdxxIdcqJKwNxiI+AcL57QKdn2Svs0gm2bu2RKvKzHxGvPv2Wez62i
 ko2i/DmBShxo3ypEYvLNCA51kWQaKEbBa5YSRPG8zA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gk21syc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 18:13:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KGh1OL020340;
 Thu, 20 Mar 2025 18:13:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncmhawh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 18:13:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52KID8LR49152258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 18:13:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D936558057;
 Thu, 20 Mar 2025 18:13:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FDB358059;
 Thu, 20 Mar 2025 18:13:07 +0000 (GMT)
Received: from [9.61.241.7] (unknown [9.61.241.7])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Mar 2025 18:13:07 +0000 (GMT)
Message-ID: <0fe1ff1e-2388-453e-9fd9-b550b6be0c41@linux.ibm.com>
Date: Thu, 20 Mar 2025 11:13:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 alifm@linux.ibm.com
From: Farhan Ali <alifm@linux.ibm.com>
Subject: QEMU Userspace NVMe driver and multiple iothreads
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AASTHIHD3WQ91sxgTi4anoSYgTzAWDlC
X-Proofpoint-GUID: AASTHIHD3WQ91sxgTi4anoSYgTzAWDlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=826
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

I have been experimenting with the QEMU Userspace NVMe driver on s390x 
architecture. I have noticed an issue when assigning multiple virtqueues 
and multiple iothreads to the block device. The driver works well with a 
single iothread, but when using more than one iothread we can hit a 
problem where 2 iothreads can update the completion queue head doorbell 
register with the same value within microseconds of each other. As far 
as I understand this would be an invalid doorbell write as per NVMe spec 
(for eg spec version 1.4 section 5.2.1 defines this as an invalid 
write). This causes the NVMe device not to post any further completions. 
As far i understand this doesn't seem to be specific to s390x architecture.

I would appreciate some guidance on this to see if there is some known 
limitations with the userspace NVMe driver and multi queue/multi 
iothread? This is an example xml snippet i used to define the nvme block 
device

...

<disk type='nvme' device='disk'>
       <driver name='qemu' type='raw' queues='8' packed='on'>
             <iothreads>
                   <iothread id='1'/>
             </iothreads>
       </driver>
       <source type='pci' managed='yes' namespace='1'>
             <address domain='0x0004' bus='0x00' slot='0x00' 
function='0x0'/>
       </source>
       <target dev='vde' bus='virtio'/>
       <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0002'/>

</disk>
....

Appreciate any help on this!

Thanks
Farhan


