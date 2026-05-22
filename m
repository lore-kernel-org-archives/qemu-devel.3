Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C546CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXBK-0002K3-6m; Fri, 22 May 2026 17:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQXBD-0002IL-Oj; Fri, 22 May 2026 17:13:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQXBB-0003DM-0I; Fri, 22 May 2026 17:13:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MA22AT160368; Fri, 22 May 2026 21:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=97gNSv
 8JhHw9wy3pY4UJf/bu9OS4DEYTQOguPgEotKs=; b=RQjm8OY3zntThsN8uMiLXa
 Vnxkp1vbVqTQdsG0OdK5FAqYomtGlkkUlv6SPTjvr78U+9rogmQe3oAtaG3izMVs
 u7rztp+D3CPrlWuwtgXmSRuu/oo8se/Hd6Q4XMAV7zO7bnaqZRedk/cax0m79Aub
 Rf783Px4zJQ9kpExWcT5vAGw0cLd/tgQiblLJbyll/iZdeaLb9JDYvqITaLB6Whk
 iMes5pE8XaGjDMMugzOhhPUE/CfQ5QBModIFUrGBHVaUDckuN1rtu7cM0Pz5oCZ9
 or8WLKtoDr+q114P6m8LAUNI9Sk0RZXsSuthLDa1EIsD7Ct/yGVBBNID2jNyx/Jg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8v9dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 21:13:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ML9Fm8022230;
 Fri, 22 May 2026 21:13:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739wasw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 21:13:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MLD60h48693732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 21:13:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A7A02004B;
 Fri, 22 May 2026 21:13:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8585C20040;
 Fri, 22 May 2026 21:13:03 +0000 (GMT)
Received: from [9.124.217.149] (unknown [9.124.217.149])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2026 21:13:03 +0000 (GMT)
Message-ID: <40caced4-2cbe-4a85-a818-7175a4b52d52@linux.ibm.com>
Date: Sat, 23 May 2026 02:42:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ppc/pnv: Make Power11 as the default CPU
To: Misbah Anjum N <misanjum@linux.ibm.com>
Cc: harshpb@linux.ibm.com, amachhiw@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 shivangu@linux.ibm.com
References: <20260521200844.1449023-1-adityag@linux.ibm.com>
 <20260522185601.27144-1-misanjum@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260522185601.27144-1-misanjum@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxMCBTYWx0ZWRfXy40MGUQ+J+0g
 t1SGyP7mmn6R9db/iruTJOX6K3aPPn6GB1NriiaMDfzXgmUwM6dMA/l+GA6M09nnk9sbjJxVtoR
 ZhDbptNf5jSLcsygpfqkw7A5SGdsBlgCdcuET7o0jNbyV4NevRwELrUkS5m8aw3AErM++XRA3wi
 pZTyttwUJZmSA3VE9fSGDyik2/D1JXHv/ln/WlJ+1VLNkzC8xuJfgDgN4WCYt/x4nnzo4TlIN7y
 9mQlT6GO8vXv8/9sVRuNUPUUnf3EjOpoPFbBj2/WBNtlttf1EFuJwwAE5rZVaUZDeYOT1IbFEua
 r0SzOUI1gG2b2wBTKTrmQc7cw66IocugCHNhMN3AJRiKDjeAaLMTYe6WING2LU1DLk+i+NKDsXj
 Sfx0YPSFrh1Q6h7Vr7z8+86qe+4NQ4wdC+jq9ctJQZylxPrN5fNQ9rHnehNrUkA1HKEzSNDzdyX
 nx8yoqwTFCKab2QTDRQ==
X-Proofpoint-GUID: KUNSjoPCu-2ViFyc85VseH_ke6YMBj2n
X-Proofpoint-ORIG-GUID: 28ltYhyicMYxmgclMDq8B9rmvmuoG_hj
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a10c6e7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=nt1L8KCDP4n4pYK9-skA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220210
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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


On 23/05/26 00:26, Misbah Anjum N wrote:
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

Thank you for the extensive testing, Misbah !

- Aditya G


