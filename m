Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4E7C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwaDg-0007Lw-Gw; Wed, 19 Aug 2026 02:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wwaDf-0007IE-1R; Wed, 19 Aug 2026 02:56:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wwaDc-0002jv-KB; Wed, 19 Aug 2026 02:56:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J6WIDV1545005; Wed, 19 Aug 2026 06:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SygJin
 cI7Te2NspxEM1MJ/ee0HphpGOoJwBTgoUBaoY=; b=GjCPUHP8BTPAVuNkbmnmmD
 1bTBnhDIX04L2bzJe+8snt2mrrjMEi5odZvg+FttW9P0lttIfP9Y2x8GvAoaNV71
 dub5TEym9WepNGJjQ7qifpZvwD5mVRJbkxXTxKihzgDTpqJknnYnzBbjRWEXIw91
 NEf1tQ1GyfX1gLWEhYYfvSlATqSVMLgf15ygxDirb383xB0Khwqwr0AIi/s8suxG
 9dzAoi/AZPNjdx6ct5vKouiTPgaYCCBP6j2KQXtcbY5goV4DW22AgEuEjT1wdGAl
 ChAkUO3yEF0/3D8yjsImdqyw6DS2BQd9d37dGwH7opDONnUhFfpHc0FI1Hq/XG5g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu221sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:55:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J6ffLp029643;
 Wed, 19 Aug 2026 06:55:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek7jtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:55:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67J6ttlV29360874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 06:55:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDB8A58067;
 Wed, 19 Aug 2026 06:55:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7349E58055;
 Wed, 19 Aug 2026 06:55:43 +0000 (GMT)
Received: from [9.43.127.81] (unknown [9.43.127.81])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 06:55:42 +0000 (GMT)
Message-ID: <e23ae0e2-935d-49fb-99e8-dbcaca5fb997@linux.ibm.com>
Date: Wed, 19 Aug 2026 12:25:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] ppc/spapr: VOF disk image (qcow2) boot support
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, aik@amd.com
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net
References: <20260817102733.605346-1-uverma@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a85537d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=EGYj-OwPAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=KGBFmflJReHv3GOqU-AA:9
 a=QEXdDO2ut3YA:10 a=xQyHFheebwQZ3wMG2Lhb:22
X-Proofpoint-GUID: nFqOa1wv8mpMnTDhJ3w1F7WczlzUx_Qd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA0NyBTYWx0ZWRfX/xuzcTqEROFL
 Gt7TGSsJx55yvJNaPJDxTUrEBLm9u88Z8AiA2yaQoyugpac1cOM8RrQMsrFx5BwdeTnP3KXN4IB
 s+WG17uU64+YmYWiROqnLHiA4dSM9AgSghzECdA1nWBZPuTdB9GKeqWP5yM8SugNmlJvh9JYKzz
 nGEeOU0UUKrRmDpH+H6NC2JH9h7w7YLmNUzoNau03786RM1wr8LX5rW9QSEtPEWwebppTEheVLf
 +4hmP85p4lkdR3xwQqcytUrg/AGpNtZ0k4uCF1yzpqBUdrLy5N9H8RLdWiSxW7Qyb4btj7wMKIx
 XVgc/YsA1EoUOv6Yqp2QC9LvMmG2NrAHHTYeKyppymDOHBJdbw4v8yMLPuvvCLNcEVPlLKOGb/v
 MAhkJV40+DYEIIbERnZ5EpHBv8QxJh1TYFXET8689nn0jmN2Eo9ou/WQ3LMxGOOMLBk9ffpo9T6
 nNaUTto/GX5LX6Os57A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA0NyBTYWx0ZWRfX1M9+KBGJnbYD
 NA2kjpmQubum+luKrruMwTf9ogYsmMcOx2GH5yNtcKaH34AqTgXByOKiA8xSmNWaAQbkze3MhMv
 rp3miogsBjKGhryylUNaka+CiMUBT4Q=
X-Proofpoint-ORIG-GUID: aQxZvtPTZMaWlL5WGzp3MjBh_-4Tw4RF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190047
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
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

+ Alexey (AMD)

Hi Alexey,
Will you continue to maintain VOF in QEMU?
Could you please share your feedback on this patch series?

Regards,
Utkarsh

On 8/17/26 3:57 PM, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
> 
> This series adds support for booting from a disk image under the Virtual Open
> Firmware (VOF) path for sPAPR/pseries machines in QEMU.
> 
> The most common use case for pseries VMs is booting from a distro qcow2 disk
> image. These images carry a PReP boot partition containing GRUB2, which in turn
> loads the kernel and initrd via IEEE 1275 client interface calls.
> VOF currently only supports direct -kernel/-initrd boot; there is no
> firmware-mediated path to hand off to a bootloader on disk. This series
> implements that missing path, making VOF capable of handling the standard
> distro qcow2 boot flow without requiring SLOF.
> 
> This series takes reference from an earlier implementation by Alexey
> Kardashevskiy [1] which explored the same concept but was not carried forward at
> the time.
> 
> The existing load_elf function works on a file, whereas in the VOF the PReP
> partition (GRUB) is read from the disk image and loaded in the memory, also
> on loading the PReP partition in the guest memory the /memory@0/available FDT
> needs to be properly updated for each PT_LOAD segment of the core.elf file
> of the GRUB (PReP partition).
> 
> Implemented a new public elf loader API load_elf_ram_sym_buf() to resolve both
> these issues. load_elf_ram_sym_buf() accepts a caller-supplied memory buffer
> instead of a filename. Internally it writes the buffer to an anonymous memfd
> and delegates to the existing load_elf32/load_elf64 paths, so all existing
> behaviour is preserved. Also, added optional segment_fn_t callback in
> load_elf_ram_sym_buf() through the internal elf_ops.h.inc template; it is
> invoked once per PT_LOAD segment after the load address is resolved, allowing
> callers to perform per-segment work such as VOF memory claims.
> 
> When no -kernel is given, spapr_vof_reset() calls a newly implemented function
> spapr_vof_try_prep_boot() which iterates attached block backends, scans
> partitions for a PReP boot partition, reads the partition contents into a
> host buffer, calls load_elf_ram_sym_buf() to load the GRUB in the guest memory,
> and on success stores the ELF entry point in spapr->kernel_addr.
> spapr_vof_client_dt_finalize() then writes the entry point into
> /chosen/qemu,boot-kernel so VOF then transfers control to GRUB.
> 
> - Partition scanner (spapr_vof_partition.c): scans MBR and GPT partition tables
>    on a BlockBackend to locate the PReP boot partition.
> 
> - Core loader extension (hw/core/loader.c): new load_elf_ram_sym_buf() API loads
>    a 32/64-bit ELF binary from a caller-supplied memory buffer, reusing the
>    existing load_elf32/load_elf64 paths via a memfd. A new segment_fn_t callback
>    in elf_ops.h.inc lets callers act on each PT_LOAD segment as it is resolved.
> 
> - read, seek OF services: two previously unimplemented IEEE 1275 client
>    services, covering block device I/O needed by GRUB.
> 
> - vscsi-report-luns method: walks the SCSIBus and builds the LUN report table
>    in guest memory in the format expected by GRUB's ofdisk driver, matching
>    SLOF's dev-generate-srplun encoding.
> 
> - VTY write/read routing: routes console I/O through the VTY chardev backend;
>    promotes vty_getchars to external linkage.
> 
> - FDT disk@<lun> child nodes (spapr_vscsi.c): emits a child FDT node per
>    attached SCSI disk in VOF mode, giving GRUB a fully-qualified OF path to open.
>    Gated on spapr->vof so SLOF boots are unaffected.
> 
> We used AI to build prototype with manual changes incorporated as identified
> during debugging multiple issues faced while making it work, hence using below
> tag as suggested in [2].
> AI-used-for: Code
> 
> Testing:
> 
> The series has been tested end-to-end by booting a RHEL9.7 qcow2 image on a
> pseries machine with VOF enabled (no SLOF).
> 
> build$ ./qemu-system-ppc64 -M pseries,x-vof=on -cpu power9 -m 2G \
> -hda ../../rhel-guest-image-9.7-20251021.0.ppc64le.qcow2 -nographic
> qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-cfpc=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ccf-assist=on
> Welcome to GRUB!
> <snip>
>                                 GRUB version 2.06
> 
>   +----------------------------------------------------------------------------+
>   |*Red Hat Enterprise Linux (5.14.0-611.5.1.el9_7.ppc64le) 9.7 (Plow)         |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   |                                                                            |
>   +----------------------------------------------------------------------------+
> 
>        Use the ^ and v keys to select which entry is highlighted.
>        Press enter to boot the selected OS, `e' to edit the commands
>        before booting or `c' for a command-line.
> 
> <snip>
> 
> Red Hat Enterprise Linux 9.7 (Plow)
> Kernel 5.14.0-611.5.1.el9_7.ppc64le on an ppc64le
> 
> Activate the web console with: systemctl enable --now cockpit.socket
> 
> localhost login: root
> Password:
> Last login: Fri Jul 10 01:45:44 on hvc0
> [root@localhost ~]#
> [root@localhost ~]# ls /
> afs  boot  etc	 lib	media  opt   root  sbin  sys  usr
> bin  dev   home  lib64	mnt    proc  run   srv	 tmp  var
> [root@localhost ~]#
> [root@localhost ~]# echo "Hello, World!" > hello.txt
> [root@localhost ~]# cat hello.txt
> Hello, World!
> [root@localhost ~]#
> 
> [1] https://lore.kernel.org/qemu-devel/20200203032943.121178-1-aik@ozlabs.ru/#t
> [2] https://lore.kernel.org/qemu-devel/20260529094619.1034458-1-pbonzini@redhat.com/
> 
> Utkarsh Verma (8):
>    ppc/spapr: add PReP boot partition detection
>    hw/loader: add load_elf_ram_sym_buf() for in-memory ELF loading
>    ppc/spapr: add baseline VOF disk boot support
>    ppc/spapr: add VTY backend support to OF read/write/open services
>    ppc/spapr: add block device backend to VOF open/read/write/seek
>      services
>    spapr_vscsi: add VOF disk nodes to the device tree
>    ppc/spapr: strip OF path argument suffix in path_offset
>    ppc/spapr: implement vscsi-report-luns call-method for PAPR vSCSI
> 
>   hw/char/spapr_vty.c          |   2 +-
>   hw/core/loader.c             |  77 ++++++-
>   hw/ppc/meson.build           |   5 +-
>   hw/ppc/spapr_vof.c           | 144 +++++++++++-
>   hw/ppc/spapr_vof_partition.c | 176 ++++++++++++++
>   hw/ppc/trace-events          |   4 +
>   hw/ppc/vof.c                 | 429 +++++++++++++++++++++++++++++++++++
>   hw/scsi/spapr_vscsi.c        |  40 ++++
>   include/hw/core/loader.h     |  30 +++
>   include/hw/elf_ops.h.inc     |  12 +-
>   include/hw/ppc/spapr_vio.h   |   1 +
>   include/hw/ppc/spapr_vof.h   |  14 ++
>   include/hw/ppc/vof.h         |   2 +
>   13 files changed, 923 insertions(+), 13 deletions(-)
>   create mode 100644 hw/ppc/spapr_vof_partition.c
>   create mode 100644 include/hw/ppc/spapr_vof.h
> 


