Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD96DCD5BB8
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 15:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQnyt-00062U-6m; Sat, 23 May 2026 11:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQnyr-00062F-PC; Sat, 23 May 2026 11:09:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQnyq-0002gA-2a; Sat, 23 May 2026 11:09:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64N9WMYM1597590; Sat, 23 May 2026 15:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7VSr35
 VeL6xkNoXGZxdFbNg3rm7dKR9b93ZZJ+Q92is=; b=X1EGs+JBcPpGrwm33US8R4
 KePnYo4kzlNvHBfKUqDyE88yCSApC6DeTM7WgBhrx8nqjK3K+Xhxv+grpaaum2uK
 jmXp7GEU2sLWpJ2Qrbt7yQaYIJJQfDEgcZHp7poeTLodu0g+MoJL+0GcLU68Iw3D
 7+FsV/qiON45k0/Z8It6TeV4geo6LY/+I094Qgic+rno47Anc0f2Tk2fhZRsCUUw
 VFsl3K8w0SnB6Z6nCcZS6f9gb+x3hUbeBqSXSfKuDxzWSbstYb5yXRGHqlUq0P98
 +6GW6zOFekPfhgU76eiOQcGHBAdvukZQWs9YChkTdpAYxFnU/xwiIAxrQcunUnkw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s21c06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 May 2026 15:09:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NF94lj030651;
 Sat, 23 May 2026 15:09:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eb4781kbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 May 2026 15:09:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64NF9UAh60293624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 May 2026 15:09:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A89925805A;
 Sat, 23 May 2026 15:09:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0786458054;
 Sat, 23 May 2026 15:09:27 +0000 (GMT)
Received: from [9.124.217.135] (unknown [9.124.217.135])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 23 May 2026 15:09:26 +0000 (GMT)
Message-ID: <d4eba4da-4f17-45aa-9bbd-7ddbbde00dab@linux.ibm.com>
Date: Sat, 23 May 2026 20:39:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ppc/pnv: Make Power11 as the default CPU
Content-Language: en-GB
To: Misbah Anjum N <misanjum@linux.ibm.com>, adityag@linux.ibm.com
Cc: amachhiw@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, shivangu@linux.ibm.com
References: <20260521200844.1449023-1-adityag@linux.ibm.com>
 <20260522185601.27144-1-misanjum@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260522185601.27144-1-misanjum@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZnAcYCAmSQutuqsnfqgIgnIFEcED8SO0
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a11c32d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=nt1L8KCDP4n4pYK9-skA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE1NCBTYWx0ZWRfX9qrgGbmcoEw0
 eTkHEacOZWilbJ/MDRq3z692hJpn44QQ7wTQLjtkBMnAtVl6Zqu09yKlm7UJ7oUYKmaOb6EjAAc
 o330spyq5PMZ+X/HJ4koZEL1pNK2xd03oJUnJYwLID+WSsIuHxBULcrnqqMheQO2gdPtO+R+qeU
 79kmvdSnr0+2fOXUnSQ+jvRm3TfrZEnVVzweE5SiCCtfLZWKez3H/0P93bW0hBpkkDWk6JVQyQd
 pL31ybOEXLbeVXbR6RX5dK6orsaTz+l2xod1Wdx0epZcxcUtlSlaJG64uxd11mxfMTCeWj6rdj/
 luw8iDF+edWM9Waww/Ki0+kyv846tzYb+oSIIddgb9WLxn6XRPsvjK8GbvKddIFJbu6mVXR3Klm
 JVTr0xP948EtZ8wnCKEmHo1Bs4DAKbZTIE5WJpENKcC6jzgnpTZ15Tc1cv8zj9wUy6X5BOMwMT+
 CW+pC5TXvtImsNT8wpQ==
X-Proofpoint-ORIG-GUID: _X5C4DgeTgvjdC1IO8dQ7aYfgzTUMdj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230154
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

Thanks Aditya, Amit and Misbah for the quick turnaround and bringing 
Power11 to default. I think it's time.

I am queuing this patch with minor updates:
- patch 1 title prefix changed from ppc/pseries to ppc/spapr to follow 
the convention
- Correcting Amit's email in Tested-by tag.

Thanks all once again!
Harsh

On 23/05/26 12:26 am, Misbah Anjum N wrote:
> Hi Aditya,
> 
> I've tested the Power11 default patches on both PSeries and PowerNV guests with various SMP topologies.
> 
> Testing Environment:
> - Host: SLES 16.1
> - Arch: ppc64le
> - QEMU: emulator version 11.0.50
> 
> PSeries Guest Bringup
> Status: Success
> qemu-system-ppc64 -name test-vm -machine pseries,accel=kvm -m 4096 -smp 8,sockets=1,cores=8,threads=1 -nographic -serial mon:stdio -drive file=/var/lib/libvirt/images/sles161.qcow2,if=virtio,format=qcow2 -netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
> 
> PowerNV Guest Bringup
> Status: Success
> qemu-system-ppc64 -name test-vm -machine powernv -m 4096 -smp 8,sockets=1,cores=8,threads=1 -nographic -serial mon:stdio -kernel /boot/vmlinux-6.12.0-160099.36-default -initrd /boot/initrd-6.12.0-160099.36-default -append "root=/dev/sda2 rootwait console=hvc0" -device virtio-scsi-pci,id=scsi0 -drive file=/var/lib/libvirt/images/sles161.qcow2,if=none,id=drive0,format=qcow2 -device scsi-hd,bus=scsi0.0,drive=drive0 -netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
> 
> Different topologies tested for both pseries and powernv
> Status: Success
> -smp 8,sockets=1,cores=8,threads=1
> -smp 8,sockets=1,cores=1,threads=8
> -smp 8,sockets=8,cores=1,threads=1
> -smp 4,sockets=1,cores=2,threads=2
> -smp 4,sockets=2,cores=1,threads=2
> -smp 4,sockets=2,cores=2,threads=1
> 
> Qemu Unit Test Results
> Status: Success
> Ok:                337
> Fail:              0
> Skipped:           9
> 
> Result: All tests passed successfully.
> 
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
> 
> Thanks,
> Misbah Anjum N
> 


