Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68837FCC9B2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 04:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzoTY-0000NC-L5; Tue, 10 Mar 2026 00:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzoTX-0000Mu-21; Tue, 10 Mar 2026 00:13:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzoTU-0000YL-AH; Tue, 10 Mar 2026 00:13:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629G5HFT1404716; Tue, 10 Mar 2026 04:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7fkz3X
 RXimYB9F4RRrHEIj2kEsRUu7ieuf3I74TJf8w=; b=ZVpDaPFaq4wBa7OdZWSxz8
 ijAWRsADP96Z9kLCzXiO7gOapUQ05rIkGncHpYA4YR+eEu2O+r1ZtwW/fhr8ArRu
 WqUU2rQVqZ7YqYd8fCU8htFb2q+EJwAnlU1V6iU4xjY5lAFkkHcJ1M0rteN0JIE/
 wOTuDYcEgkPoSAQL/lA9b226Nl7M0r6cYyewm54qkXMT1wXAMJLeRwmu8cLvhs/6
 WjyNYyxWfxjtZfKF36dF2NiOC92RExRw6I8lU4zSQrqZgnuyjUSkG6hZV+u6T28d
 uVksm7njcrlg+qdXGgzgEaruRn7S7PPBuiSDMK5dthVXwbVm2Zt9pS9JJOsy5pGw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw9c3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 04:13:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A28ha4015706;
 Tue, 10 Mar 2026 04:13:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121yb5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 04:13:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62A4DWOO49283340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 04:13:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3625F20043;
 Tue, 10 Mar 2026 04:13:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D8CA20040;
 Tue, 10 Mar 2026 04:13:29 +0000 (GMT)
Received: from [9.124.215.225] (unknown [9.124.215.225])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 04:13:28 +0000 (GMT)
Message-ID: <1a861e72-401c-45a2-b628-b7a8e4a911b2@linux.ibm.com>
Date: Tue, 10 Mar 2026 09:43:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Implement MPIPL for PowerNV
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
 <qowkbzfxurfejfbecky4nwhgck7hs45dsq66sdxyp23od5plcd@h67km3gfkfzz>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <qowkbzfxurfejfbecky4nwhgck7hs45dsq66sdxyp23od5plcd@h67km3gfkfzz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAyNSBTYWx0ZWRfX6yt2ZI2fGh8z
 gugqBw3RbtaBzeka0q64MXbr+lHF0LPOr5AOPmXcLsTchyKNB2U5R/kEij65Iyf5hwYk9y/JC91
 Wob6c1Jp77tSB1OyHVse13hDRKkWlq9Kx3hVSs8la6Ar/Mkf5ax/dYJTMueJ8HNOg6fwdtjzKXT
 W7/dzTDY5txjJtUdsNYvr3u+CsImdP8kB50jUQJ/EWPGJ2hbXmOC/9h+cOTAAio5wj+iM1+ZpjW
 FYMI4tQ37htQTAaDHbRmzMk/m6RffZkI31ybZ/i1I/6wHXydj2jCq7dfOmIJXlO8UFEKk7OWD33
 vK6kQHhoSnsgHoFnOXGM+tCwQQjum8Aza1Ibl77damWwmXRFFPGliOBaK4ssdECa8HComATU5hd
 lw2hX0wg8C+8o/4YAbSuOYrTJNh7WcuWvj9rUDVA7+UZUmoY+WSkpkLhVVySfD1VxmGq8iUuS1p
 J4C/0x2Tj50HdpDYGDg==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69af9a71 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=kNEGCriej9dr9HWMYikA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GtbTPTeRY6CpbpOr-BXXKYp5FnkJJ84g
X-Proofpoint-ORIG-GUID: Gq2z5wx5T1blauDkNj6ZqE3BglGJN68f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 09/03/26 14:26, Shivang Upadhyay wrote:
> On Mon, Mar 09, 2026 at 12:49:49PM +0530, Aditya Gupta wrote:
>> Overview
>> =========
>>
>> Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
>> in QEMU.
>>
>> Fadump is an alternative dump mechanism to kdump, in which we the firmware
>> does a memory preserving boot, and the second/crashkernel is booted fresh
>> like a normal system reset, instead of the crashed kernel loading the
>> second/crashkernel in case of kdump.
>>
>> MPIPL in PowerNV, is similar to fadump in Pseries. The idea is same, memory
>> preserving, where in PowerNV we are assisted by SBE (Self Boot Engine) &
>> Hostboot, while in Pseries we are assisted by PHyp (Power Hypervisor)
>>
>> For implementing in baremetal/powernv QEMU, we need to export a
>> "ibm,opal/dump" node in the device tree, to tell the kernel we support
>> MPIPL
>>
>> Once kernel sees the support, and "fadump=on" is passed on commandline,
>> kernel will register memory regions to preserve with Skiboot.
>>
>> Kernel sends these data using OPAL calls, after which skiboot/opal saves
>> the memory region details to MDST and MDDT tables (S-source, D-destination)
>>
>> Then in the event of a kernel crash, the kernel initiates MPIPL with another
>> OPAL code (opal_cec_reboot2), this request goes to Skiboot.
>> Skiboot then triggers the "S0 Interrupt" to the SBE (Self Boot Engine),
>> along with OPAL's relocated base address.
>>
>> SBE then stops all core clocks, and only does particular ISteps for a
>> memory preserving boot.
>>
>> Then, hostboot comes up, and with help of the relocated base address, it
>> accesses MDST & MDDT tables (S-source and D-destination), and preserves the
>> memory regions according to the data in these tables.
>> And after preserving, it writes the preserved memory region details to MDRT
>> tables (R-Result), for the kernel to know where/whether a memory region is
>> preserved.
>>
>> Both SBE's and hostboot responsiblities are implemented in the SBE code
>> in QEMU.
>>
>> Then in the second kernel/crashkernel boot, OPAL passes the "mpipl-boot"
>> property for the kernel to know that a dump is active, which kernel then
>> exports in /proc/vmcore
>>
>> Testing
>> ====================
>>
>> 1. Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/fadump-powernv-v4
>>
>> 2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2372098708
>>
>> 3. Analysing generated vmcore:
>>
>> 	# ls -lh /proc/vmcore
>> 	-r--------    1 root     root        4.5G Feb 25 07:33 /proc/vmcore
>> 	# file /proc/vmcore
>> 	/proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
>>
>> 	# crash vmlinux vmcore
>> 	...
>> 	      KERNEL: vmlinux-38fec10eb60d-network
>> 	    DUMPFILE: vmcore-powernv-25feb26
>> 	        CPUS: 4
>> 	        DATE: Thu Jan  1 05:30:00 IST 1970
>> 	      UPTIME: 00:05:23
>> 	LOAD AVERAGE: 0.12, 0.08, 0.03
>> 	       TASKS: 101
>> 	    NODENAME: buildroot
>> 	     RELEASE: 6.14.0
>> 	     VERSION: #1 SMP Thu Apr  3 08:06:13 CDT 2025
>> 	     MACHINE: ppc64le  (1000 Mhz)
>> 	      MEMORY: 6 GB
>> 	       PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>> 	         PID: 257
>> 	     COMMAND: "sh"
>> 	        TASK: c000000008066600  [THREAD_INFO: c000000008066600]
>> 	         CPU: 2
>> 	       STATE: TASK_RUNNING (PANIC)
>>
>> 	crash> # ps and kmem -i works
>>
> Hi Aditya,
>
> I was able to get the fadump working on buildroot images, with this.
> Thanks for this feature.
>
> 	Welcome to Buildroot
> 	buildroot login: root
> 	# dmesg | grep fadump
> 	[    0.000000][    T0] opal fadump: Kernel metadata addr: 653902a8
> 	[    0.000000][    T0] fadump: Reserved 768MB of memory at 0x00000035390000 (System RAM: 8192MB)
> 	[    0.000000][    T0] fadump: Initialized [0x36000000, 752MB] cma area from [0x35390000, 768MB] bytes of memory reserved for firmware-assisted dump
> 	[    0.000000][    T0] Kernel command line: console=hvc0 rootwait root=/dev/nvme0n1 fadump=on
> 	[    0.377005][    T1] opal fadump: Registration is successful!
> 	# uname -r
> 	6.19.6
>
> 	 <snip/>
>
> 	Welcome to Buildroot
> 	buildroot login: root
> 	# ls /proc/vmcore
> 	/proc/vmcore
> 	# ls -alh /proc/vmcore
> 	-r--------    1 root     root        4.3G Mar  8 17:08 /proc/vmcore
>
>
> Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Thank you for testing the series, Shivang !


- Aditya G



