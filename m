Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79ACEB1054
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyPo-0006bh-LM; Tue, 10 Mar 2026 10:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vzyPY-0006LJ-KM; Tue, 10 Mar 2026 10:50:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vzyPW-0007Qd-D9; Tue, 10 Mar 2026 10:50:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A85HNd1478497; Tue, 10 Mar 2026 14:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=m2YbJb
 wb3hlmNW0SdejtB+PpMBS5rPz3iVUaQnOekZE=; b=mmT9ioIikKuFrHhjFQ3xg/
 BMhiFSoT3bAFGUOJNa/w7VxN5yvX9y4ZVnlQv4u6QhBGud/cE0p3Xq16ahmXanw+
 y1Ex/cJWztDciEY6FHH0MB9Y1Z78HkQI8g+GW2N/FpOZdfufpo8jF5q9em2xJG8g
 9XunpnAKxP2FmEczHLh+YxAtvJdRsCpn9x1TczURPmwq6Ctq5EKFdDSqIsXMm+uV
 p+VkyRvFaclgzGUQWJRPnW2rwh325fqssW0fxjjCswbd1ji3k3VT4T3bFnpzkxNs
 NshassS0cZ733VwxNIiubH2dF9Qy/ioZNxhF/5azR93NYLIhIG+seGzR5LxGvyDg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrb2hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:50:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AAF7gc021168;
 Tue, 10 Mar 2026 14:50:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbssnse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:50:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AEo7ge30540182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 14:50:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B011F2004E;
 Tue, 10 Mar 2026 14:50:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 397052004D;
 Tue, 10 Mar 2026 14:50:05 +0000 (GMT)
Received: from [9.39.23.9] (unknown [9.39.23.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 14:50:04 +0000 (GMT)
Message-ID: <d828f5f5-f79f-436a-bd84-ab8c270725a8@linux.ibm.com>
Date: Tue, 10 Mar 2026 20:20:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Implement MPIPL for PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Hari Bathini <hbathini@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260310124619.3909045-1-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260310124619.3909045-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyNiBTYWx0ZWRfX9B52+G0IOy1w
 KDlR7iWmdl0HoJAhIhyVrD6feAr7iRPqV3YO2WnrSsZp7SRORuc4aPmSTUKXCfqK68+BY9+0z3g
 F5lxEjwH6cRnb/n6D0FXwNbU93jeT7ugj0qR3D4tPDjiCh9r8JySldzX3bJ5Uraz/oIZNUaOng9
 hUPkV4uWrxNKYzYbY9143TCHi0KhabNdaEblE35S3KN4DzjNNSIFwFlqANFr6h5+XV7x6C/ZKGM
 MxPpeeHWLAPkFRrVypaqcoLlg7rguHr/rT9zJod8r9/mS1fYXin6ze2HME4bblTzm4XIBIkwQsI
 C4lpKTWzT3B5pez2lYcThU52QrQWemeNqbA/ks1r6lHiTCkRjN+U5q5U9Z5rV2APuEtfESRy3eK
 cZ0pAkGVaqD3of9QC4EBSUK090FnF/UnYyY6vqB81lsqfAS1Lf4Eyz4pY+G2SObx24WqPOJRJXT
 /DdrHH55gBCwKMDT/eg==
X-Proofpoint-GUID: JfWKFPmZHPStu3d5XsSoaMfJBr2glXGN
X-Proofpoint-ORIG-GUID: yiOblZUC_AifsHkiDHeVNRZFmSSNcPag
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b02fa4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=-BV1kvdu0bO3fe65mvoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100126
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Thanks for adding fadump support on PowerNV platform.

The whole patch series looks good to me.
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>


On 10/03/26 18:16, Aditya Gupta wrote:
> Overview
> =========
>
> Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
> in QEMU.
>
> Fadump is an alternative dump mechanism to kdump, in which we the firmware
> does a memory preserving boot, and the second/crashkernel is booted fresh
> like a normal system reset, instead of the crashed kernel loading the
> second/crashkernel in case of kdump.
>
> MPIPL in PowerNV, is similar to fadump in Pseries. The idea is same, memory
> preserving, where in PowerNV we are assisted by SBE (Self Boot Engine) &
> Hostboot, while in Pseries we are assisted by PHyp (Power Hypervisor)
>
> For implementing in baremetal/powernv QEMU, we need to export a
> "ibm,opal/dump" node in the device tree, to tell the kernel we support
> MPIPL
>
> Once kernel sees the support, and "fadump=on" is passed on commandline,
> kernel will register memory regions to preserve with Skiboot.
>
> Kernel sends these data using OPAL calls, after which skiboot/opal saves
> the memory region details to MDST and MDDT tables (S-source, D-destination)
>
> Then in the event of a kernel crash, the kernel initiates MPIPL with another
> OPAL code (opal_cec_reboot2), this request goes to Skiboot.
> Skiboot then triggers the "S0 Interrupt" to the SBE (Self Boot Engine),
> along with OPAL's relocated base address.
>
> SBE then stops all core clocks, and only does particular ISteps for a
> memory preserving boot.
>
> Then, hostboot comes up, and with help of the relocated base address, it
> accesses MDST & MDDT tables (S-source and D-destination), and preserves the
> memory regions according to the data in these tables.
> And after preserving, it writes the preserved memory region details to MDRT
> tables (R-Result), for the kernel to know where/whether a memory region is
> preserved.
>
> Both SBE's and hostboot responsiblities are implemented in the SBE code
> in QEMU.
>
> Then in the second kernel/crashkernel boot, OPAL passes the "mpipl-boot"
> property for the kernel to know that a dump is active, which kernel then
> exports in /proc/vmcore
>
> Testing
> ====================
>
> 1. Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/fadump-powernv-v5
>
> 2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2375470651
>
> 3. Analysing generated vmcore:
>
> 	# ls -lh /proc/vmcore
> 	-r--------    1 root     root        4.5G Mar 10 12:30 /proc/vmcore
>
> 	# file /proc/vmcore
> 	/proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
>
> 	# crash vmlinux-38fec10eb60d-network vmcore-powernv-10mar26
> 	...
> 	      KERNEL: vmlinux-38fec10eb60d-network
> 	    DUMPFILE: vmcore-powernv-10mar26
> 	        CPUS: 2
> 	        DATE: Thu Jan  1 05:30:00 IST 1970
> 	      UPTIME: 00:00:50
> 	LOAD AVERAGE: 0.57, 0.19, 0.07
> 	       TASKS: 83
> 	    NODENAME: buildroot
> 	     RELEASE: 6.14.0
> 	     VERSION: #1 SMP Thu Apr  3 08:06:13 CDT 2025
> 	     MACHINE: ppc64le  (1000 Mhz)
> 	      MEMORY: 6 GB
> 	       PANIC: "Kernel panic - not syncing: sysrq triggered crash"
> 	         PID: 238
> 	     COMMAND: "sh"
> 	        TASK: c00000000a0f3200  [THREAD_INFO: c00000000a0f3200]
> 	         CPU: 0
> 	       STATE: TASK_RUNNING (PANIC)
>
> 	crash> # ps and kmem -i works
>
> Changelog
> ====================
>
> v4 -> v5:
> * #4/10: set chunk_id=0 before copying
> * #7/10: remove unnecessary bool check, ie. 'if (b1) b2=b1 else b2=!b1' => 'b2=b1'
>
> v3 -> v4:
> * #2/10: s/recieves/receives
> * #7/10: remove empty line at EOF
>
> v2 -> v3:
> * rebase to upstream, changes in patches below
> * #2/10: no code change. add comment that skiboot triggers S0
> * #3/10: stash command: handle invalid skiboot_base sent by guest
> * #4/10: s/src_len/data_len/
> * #4/10: use TARGET_FMT_lx/PRIx64 instead of %lx to prevent build errors
> * #4/10: stop copying chunks once copying a chunk fails
> * #5/10: use address_space_{read,write} instead of cpu_physical_memory_{read,write}
> * #5/10: add more SPRs to be saved, same set of SPRs as spapr FADump, except CR and FPSCR
> * #7/10: only export "mpipl-boot" property if preserving cpu states and writing MDRT was successful, otherwise continue with normal reboot
> * #7/10: use address_space_{read,write} instead of cpu_physical_memory_{read,write}
> * #8/10: reword commit description to mention fw-load-area, no code change
> * #10/10: add entry in MAINTAINERS file
>
> Aditya Gupta (10):
>    ppc/pnv: Move SBE host doorbell function to top of file
>    ppc/mpipl: Implement S0 SBE interrupt
>    ppc/pnv: Handle stash command in PowerNV SBE
>    pnv/mpipl: Preserve memory regions as per MDST/MDDT tables
>    pnv/mpipl: Preserve CPU registers after crash
>    pnv/mpipl: Set thread entry size to be allocated by firmware
>    pnv/mpipl: Write the preserved CPU and MDRT state
>    pnv/mpipl: Enable MPIPL support
>    tests/functional: Add test for MPIPL in PowerNV
>    MAINTAINERS: Add entry for MPIPL (PowerNV)
>
>   MAINTAINERS                           |   8 +
>   hw/ppc/meson.build                    |   1 +
>   hw/ppc/pnv.c                          |  98 ++++++
>   hw/ppc/pnv_mpipl.c                    | 482 ++++++++++++++++++++++++++
>   hw/ppc/pnv_sbe.c                      |  84 ++++-
>   include/hw/ppc/pnv.h                  |   7 +
>   include/hw/ppc/pnv_mpipl.h            | 168 +++++++++
>   tests/functional/ppc64/test_fadump.py |  35 +-
>   8 files changed, 852 insertions(+), 31 deletions(-)
>   create mode 100644 hw/ppc/pnv_mpipl.c
>   create mode 100644 include/hw/ppc/pnv_mpipl.h
>
> --
> 2.53.0
>


