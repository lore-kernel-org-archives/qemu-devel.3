Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DE3CD5BAC
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 14:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQna3-0000hN-15; Sat, 23 May 2026 10:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQnZp-0000cm-7Q; Sat, 23 May 2026 10:43:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQnZm-0004TD-AC; Sat, 23 May 2026 10:43:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64N7hAwh2492593; Sat, 23 May 2026 14:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3Uoiqo
 Wd1syOzpumW1ZmSFUcBR+JLGVLhubnE8i3ZXw=; b=V75mUTKqpJiCsw9kQCLdVX
 A9qgo8Rq/Gn7bG6uQ25UGPsx2oppbJDd1KcMJvxRRC0GawC/zCKw+5/fHKGJshfU
 wxgZiXVOB0GIgKf7qGFEZwsP1stHzii4WInm454rRhLCfcEogJw8EjU8HYVfDICN
 YQQWcEfxK54WB4bW0YiqlvbnfQEhVX+kigUgCY10BrCYPZXYVU8lKdnIozwOu6Pa
 lbkzelSjPVu+RGppWVBmeW1zzy4G4YrbkCOkZSFmS4efQubWBK4cmQj2jRO8uSgh
 s5/1/EuehNjMHJDggR1KFWSi05Gl7bcRxIPQpPQKUjdNrnxMMcw3uGSXSPHd3Vtg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nps61t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 May 2026 14:43:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NEd9Ne010970;
 Sat, 23 May 2026 14:43:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eb46nhgyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 May 2026 14:43:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64NEgKIU19661528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 May 2026 14:42:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 517D55805A;
 Sat, 23 May 2026 14:42:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D13DE58054;
 Sat, 23 May 2026 14:42:16 +0000 (GMT)
Received: from [9.124.217.135] (unknown [9.124.217.135])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 23 May 2026 14:42:16 +0000 (GMT)
Message-ID: <576bad4e-7178-481b-a244-3f879f88cf2f@linux.ibm.com>
Date: Sat, 23 May 2026 20:12:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/spapr: Skip system reset for quiesced CPUs
To: Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: anushree.mathur@linux.vnet.ibm.com, mahesh@linux.ibm.com,
 sourabhjain@linux.ibm.com, vishalc@linux.ibm.com
References: <20260430085409.680930-1-shivangu@linux.ibm.com>
 <20260511095055.82495-1-shivangu@linux.ibm.com>
 <4f1ed8f4-1c6f-4717-aefe-c0dda3e77b9e@linux.ibm.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <4f1ed8f4-1c6f-4717-aefe-c0dda3e77b9e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bn80g8IN7yPXlrP-5zzj2LuQ8Zdz7p8G
X-Proofpoint-ORIG-GUID: Bn80g8IN7yPXlrP-5zzj2LuQ8Zdz7p8G
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a11bd1a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=mHyHtLYs3z0Zr9RITAoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE0OSBTYWx0ZWRfXw4R+LlalxzBv
 VZ4iWPmWrY+gsCm2IqfFgu5goUlarqQAUjcKWE/d58AeOfdQ/g/cHOhAPXTFziWpEDhCcXvuMi4
 v3Txb7b0fu7/e/DLu4LUMwM6I3PYXKz4x/ncWuXQkZkf7hzYYpuS86zW1gUIVXRe8MwhVx4rgaS
 FUeRkUXc7xAx7YRQJ1yrR/H7odeauqGYPzW7Zmq9VohGPdUwzKGnwzcjJk8Wa8a5TQaLtf5GSSw
 Y3izrrG/fzfZx2ngw+JCImkjr6k8Vy3BocZgmwdX95dIFavGw+WeL9W0JqlKfOdxEoop6lL7Zvw
 tPOy/f8WJs3WPamU2lBifSMMzm9cFaoL8AkvyboCDtJH1kmOSXBTcvIB+KuugdvqkFVBCExN6ba
 r0Qk52bUxk2qLkaxOT3msnh0E37kCBb6l/89MMtJtWS6LRRGhhT9QX3WPZnIrdxc+PEB3YDtaOx
 2kyVpt7bHBR52ZlZhdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605230149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 13/05/26 11:01 pm, Anushree Mathur wrote:
> 
> 
> On 11/05/26 3:20 PM, Shivang Upadhyay wrote:
>> During DLPAR CPU hotplug, newly added CPUs start in RTAS stopped state
>> (quiesced). If a kexec crash occurs before the guest starts these CPUs
>> via start-cpu RTAS call, H_SIGNAL_SYS_RESET_ALL_OTHERS will reset them
>> anyway, causing the kdump kernel to hang:
>>
>>    [    5.519483][    T1] Processor 0 is stuck.
>>    [   11.089481][    T1] Processor 1 is stuck.
>>
>> The hypervisor should only reset CPUs that the guest has started. The
>> cpu->env.quiesced flag tracks RTAS stopped state - CPUs in this state
>> are already inactive and should not be reset.
>>
>> Skip system reset for quiesced CPUs to prevent kdump hangs during CPU
>> hotplug operations.
>>
>> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
>> Suggested-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>> ---
>> Changelog:
>>
>> v2:
>>   * added braces to adhere to style guide.
>>   * rebase to master
>>
>> v1:
>>   * https://lore.kernel.org/all/20260430085409.680930-1- 
>> shivangu@linux.ibm.com/
>> ---
>>   hw/ppc/spapr_hcall.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 032805a8d0..613dd893bb 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1105,6 +1105,12 @@ static target_ulong 
>> h_signal_sys_reset(PowerPCCPU *cpu,
>>                       continue;
>>                   }
>>               }
>> +
>> +            /* Skip quiesced CPUs */
>> +            if (c->env.quiesced) {
>> +                continue;
>> +            }
>> +
>>               run_on_cpu(cs, spapr_do_system_reset_on_cpu, 
>> RUN_ON_CPU_NULL);
>>           }
>>           return H_SUCCESS;
> 
> 
> Hi Shivang,
> thanks for working on the reported issue. After applying the patch I am 
> seeing that this reported issue has been fixed which was guest getting 
> hung after
> triggering kdump on guest while cpu hotplug is going on, but I am seeing 
> multiple other issues with multiple attempts with the same
> scenario and one of the major issue that I have seen is a qemu crash. I 
> believe this needs to be fixed.
> 

I see the crash mentioned below happened after 10 attempts of kdump,
which could be an unrelated problem that can be addressed separately.
This fix seems appropriate for the original kdump hang issue, just that
a more elobare comment would have been more helpful.

I would expand the comment being added as:

/* Skip quiesced CPUs - they are in RTAS stopped state and
  * should not be reset. This prevents kdump hangs when CPUs
  * are hotplugged but not yet started by the guest.
  */

No need to send another version, I shall update and queue.

Thanks
Harsh


> 
> Here is my analysis of this issue with and without the patch:
> 
> 1) Without applying the patch:
> 
> i) Start the guest with maxvcpus as 64 and current vcpus as 8
> ii) Start cpu hotplug [virsh setvcpus guest_name 64] same time trigger 
> kdump on guest [echo c > /proc/sysrq-trigger]
> Guest is getting hung.
> 
> 
> [   32.930453][ T1208] NIP [00007fffbe35b3c4] 0x7fffbe35b3c4
> [   32.930528][ T1208] LR [00007fffbe35b3c4] 0x7fffbe35b3c4
> [   32.930638][ T1208] ---- interrupt: 3000
> [    9.857410][    T1] Processor 0 is stuck.
> 
> 
> 
> 2) After applying the patch
> 
> 
> Multiple issues that were seen in multiple attempts of this scenario:
> 
> 
> i) In 4th attempt I saw dlpar related traces along with OOPS after 
> triggering kdump:
> 
> [    6.071156][  T121] pseries-hotplug-cpu: Cannot add cpu /cpus/ 
> PowerPC,POWER11@20; this system configuration supports 32 logical cpus.
> [    6.071313][  T121] OF: changeset notifier error @/cpus/ 
> PowerPC,POWER11@20
> [    6.074099][  T121] BUG: Unable to handle kernel data access at 
> 0x151591241bba0bb6
> [    6.074232][  T121] Faulting instruction address: 0xc0000000211e5b98
> [    6.074311][  T121] Oops: Kernel access of bad area, sig: 11 [#1]
> 
> [    6.076695][  T121] Call Trace:
> [    6.076741][  T121] [c000000026a6baf0] [c000000026a6bb30] 
> 0xc000000026a6bb30 (unreliable)
> [    6.076834][  T121] [c000000026a6bb60] [0000000010000021] 0x10000021
> [    6.076930][  T121] [c000000026a6bb90] [c000000020e55b14] 
> of_get_next_child+0x64/0xd0
> [    6.077034][  T121] [c000000026a6bbd0] [c0000000201cd1dc] 
> dlpar_cpu_add+0xbc/0x5e0
> [    6.077148][  T121] [c000000026a6bcb0] [c0000000201ce9d0] 
> dlpar_cpu+0x60/0x1f0
> [    6.077241][  T121] [c000000026a6bd40] [c0000000201c5914] 
> handle_dlpar_errorlog+0x1f4/0x6e0
> [    6.077333][  T121] [c000000026a6be20] [c0000000201c5e28] 
> pseries_hp_work_fn+0x28/0x60
> [    6.077425][  T121] [c000000026a6be50] [c000000020259e6c] 
> process_one_work+0x1dc/0x540
> [    6.077516][  T121] [c000000026a6bf00] [c00000002025ae0c] 
> worker_thread+0x36c/0x4d0
> [    6.077608][  T121] [c000000026a6bf90] [c000000020269978] 
> kthread+0x168/0x190
> [    6.077700][  T121] [c000000026a6bfe0] [c00000002000de58] 
> start_kernel_thread+0x14/0x18
> 
> ii) In 7th attempt I saw xive interrupts
> 
> 
> [   61.692603][ T1909] ---- interrupt: 3000
> [    0.010215][    T1] xive: H_INT_GET_QUEUE_INFO cpu=62 prio=6 failed -55
> [    0.013834][    T1] xive: Error -55 getting queue info CPU 62 prio 6
> 
> 
> 
> iii) qemu crashed after 10 attempts with the following error message in 
> the libvirt/qemu logs
> 
> qemu-system-ppc64: ../hw/ppc/spapr.c:4396: spapr_cpu_index_to_props: 
> Assertion `core_slot' failed.
> 2026-05-13 09:46:29.656+0000: shutting down, reason=crashed
> 
> 
> Thank you!
> Anushree Mathur


