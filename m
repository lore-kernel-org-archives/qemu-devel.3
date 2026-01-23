Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EB7D778B0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjMco-0007tO-D9; Fri, 23 Jan 2026 14:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vjMcl-0007qO-Q9; Fri, 23 Jan 2026 14:15:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vjMcj-0003B8-UP; Fri, 23 Jan 2026 14:15:15 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NEAEjw011177;
 Fri, 23 Jan 2026 19:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6mo9T1
 ReuOqC1J19JEwi0SNYlQpXsRMUwu38+mLb2mI=; b=NC7Xj09v8IkbZT/5vP3TEW
 Q3d7w+yvuRIZny3bQ/z+sa6TArES/Q/bdDxX2aUybyct5dI3hh+rxqNmrr2xldie
 U582WjdaWCPF+wOLBf7xGQLqIZVOyuP8owxwomR/ZgLP2ggJl8afRrLjSPTa9fdi
 /XcOLYW2DwK05SThslATa2aaMXAqk4dBqDPb277f8akH9U64jYsfYJ9a0ERz7ecN
 +Wsdb3bONzUlC7DOi/OnlXFDcEWUx6k9yAqgY19CWyybQe/fCuD09eCCNszGHC6R
 3oVvx0pbDFwh1dFADh1NgwmUZtakAzm5zvf0y5jvDNJwQegXIOCn+k2kwa6JP5sA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256hw1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 19:15:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NI8sdc006393;
 Fri, 23 Jan 2026 19:15:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf22kaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 19:15:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NJF6vB3998268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 19:15:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D92E658056;
 Fri, 23 Jan 2026 19:15:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 462EF5803F;
 Fri, 23 Jan 2026 19:15:06 +0000 (GMT)
Received: from [9.61.247.201] (unknown [9.61.247.201])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 19:15:06 +0000 (GMT)
Message-ID: <eb9693ae-6aae-4599-8c8c-22268357d2c0@linux.ibm.com>
Date: Fri, 23 Jan 2026 13:15:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260119181630.GA834718@fedora>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260119181630.GA834718@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0MyBTYWx0ZWRfX2JOQa9lzWLGh
 8/HugdzjhIEFIIEubWqzbUYx2xkD3KR40ntCqWk1LBvkuFskG+XvXd9p9VcJThjJ04ZmWxPX8RA
 wwlMfg5bof1aZwxomVmD656jmg/rwlWDESmc2ZeU1CZu62RWqTxdpS7Mqp1mJk5bMvt2HZs1B55
 pYlWfy6R+x7lU8ndxh04/ZmD1Q4vXrVaWEeivf+EqvKm3A79Vrt6dEjGt1iqS9TYoU6ZYXAXgd2
 o4SwTlPBjUXp0NNnOCv6hDYaK4N0KOY6UVhQQCjZ1gd1qg+Id10MQ+MH5Koh46K/430gQ8OnM1L
 xIbdI5IoYGJh9zR5psaOl6Th8eQVlXSaI7DyEvmAiGAR+MrO0Y5ZB3/MilN4GtrNxDwsa7rDJ+L
 bfbiUkCWBMl550F5op6kl+soPUfoONei0DlddtkFJUL60Ur/F2diswJQ7QVijKQezBnQO2G1nuj
 wfMw6Da+3YSWIMmfIPw==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=6973c8bc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=K6ttad8bJOakppDEtFYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HKPcbJnzWp-gWQ_okKQwfACn_uIjeMcU
X-Proofpoint-ORIG-GUID: HKPcbJnzWp-gWQ_okKQwfACn_uIjeMcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230143
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 1/19/2026 12:16 PM, Stefan Hajnoczi wrote:
> On Tue, Jan 13, 2026 at 11:48:21AM -0600, Jaehoon Kim wrote:
>> We evaluated the patches on an s390x host with a single guest using 16
>> virtio block devices backed by FCP multipath devices in a separate-disk
>> setup, with the I/O scheduler set to 'none' in both host and guest.
>>
>> The fio workload included sequential and random read/write with varying
>> numbers of jobs (1,4,8,16) and io_depth of 8. The tests were conducted
>> with single and dual iothreads, using the newly introduced poll-weight
>> parameter to measure their impact on CPU cost and throughput.
>>
>> Compared to the baseline, across four FIO workload patterns (sequential
>> R/W, random R/W), and averaged over FIO job counts of 1, 4, 8, and 16,
>> throughput decreased slightly (-3% to -8% for one iothread, -2% to -5%
>> for two iothreads), while CPU usage on the s390x host dropped
>> significantly (-10% to -25% and -7% to -12%, respectively).
> Hi Jaehoon,
> I would like to run the same fio benchmarks on a local NVMe drive (<10us
> request latency) to see how that type of hardware configuration is
> affected. Are the scripts and fio job files available somewhere?
>
> Thanks,
> Stefan

Thank you for your reply.
The fio scripts are not available in a location you can access, but there is nothing particularly special in the settings.
I’m sharing below the methodology and test setup used by our performance team.

Guest Setup
----------------------
- 12 vCPUs, 4 GiB memory
- 16 virtio disks based on the FCP multipath devices in the host

FIO test parameters
-----------------------
- FIO Version: fio-3.33
- Filesize: 2G
- Blocksize: 8K / 128K
- Direct I/O: 1
- FIO I/O Engine: libaio
- NUMJOB List: 1, 4, 8, 16
- IODEPTH: 8
- Runtime (s): 150

Two FIO samples for random read
--------------------------------
fio --direct=1 --name=test --numjobs=16 --filename=base.0.0:base.1.0:base.2.0:base.3.0:base.4.0:base.5.0:base.6.0:base.7.0:base.8.0:base.9.0:base.10.0:base.11.0:base.12.0:base.13.0:base.14.0:base.15.0 --size=32G  --time_based --runtime=4m --readwrite=randread --ioengine=libaio --iodepth=8 --bs=8k
fio --direct=1 --name=test --numjobs=4  --filename=subw1/base.0.0:subw4/base.3.0:subw8/base.7.0:subw12/base.11.0:subw16/base.15.0                                                                        --size=8G   --time_based --runtime=4m --readwrite=randread --ioengine=libaio --iodepth=8 --bs=8k


additional notes
----------------
- Each file is placed on a separate disk device mounted under subw<n> as specified in --filename=....
- We execute one warmup run, then two measurement runs and calculate the average

Please let me know if you need any additional information.

Regards,
Jaehoon Kim


