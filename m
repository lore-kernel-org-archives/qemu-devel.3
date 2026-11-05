Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B31606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ndyXtw+P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvQp-0000fd-A1; Thu, 05 Nov 2026 06:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xOvQb-0000fB-49; Thu, 05 Nov 2026 06:14:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xOvQY-0002Sj-It; Thu, 05 Nov 2026 06:14:44 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5AEAFJ3449886; Thu, 5 Nov 2026 11:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5WlR/G
 /xVry19zKv+dMSQDwoTlorWSDSUBuzy7XJanI=; b=ndyXtw+Pt2MQaDCb4+oy3k
 gQ0jB8AyRw1ctERSyEJAWTZF16oNtQoVlYFi1+Uf+h5gvYLlVXPQIk49V0nYUkPm
 56rgs8AFqMmhWvK/xqB2gocmrBtaS+9rF3Oe37JvsCb7M5sjaKluWVy41oVlObxW
 xqFxoYkTvVb1KsKlGui7jPnTOGWrIg52rsVBSiWHcTEUj+tyKo2VYjxhKEEGhoLZ
 IEEWioQifnmCTtKJCc/DmmpT8/ju1tu8EOV8Z/s32KYAVpevtwRfdHTNH8IuMm9H
 WgBngwxgdXaQ2TDdy3bK0rI+hbpTs7YTcrJRcavctCB8a58S50ksckb54WnZHLEA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3su1w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 11:14:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5A4xmD271775; Thu, 5 Nov 2026 11:14:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5g47g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 11:14:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A5BDk1Q21299814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2026 11:13:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6C5958054;
 Thu,  5 Nov 2026 11:14:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45CAD58045;
 Thu,  5 Nov 2026 11:14:32 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2026 11:14:31 +0000 (GMT)
Message-ID: <de7816aa-98c6-4c9a-8420-b937f94cd8a1@linux.ibm.com>
Date: Thu, 5 Nov 2026 16:44:30 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional/ppc64: add pseries virtio-blk
 hotplug test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>
References: <20261103141938.41147-1-anushree.mathur@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20261103141938.41147-1-anushree.mathur@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aec651e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=x_wH3vj0ZUpRxYuHfwgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tpIMDCQssRfv3W9elk2u4WSmmv6v2K39
X-Proofpoint-GUID: DL2qtvAs6af05d7HzwojkjMh5reqjPFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX/vvKffVWoqYZ
 i4qbm7gghO0u8l13xj+Dv2FW+Rjo4nNt0fnHFEa4C1GJJzOXVFGWRXjWyPw/qURUhI+2hczYzoP
 heLiuXh7Gg00WsKljmYH/WsGe4hJkF/lN8QRm5+1SvVFKJuOm/cKbNJYQLJHRLBBvwiIZ9vvj6U
 8GJupwaGNLFdWZQZkE8RvYBfe4flhBC49HxZogly0L7muyPRf9JHyJlwO7MMrX2jV+wbi0RGB/m
 yyZ3TawVp/4GlONR4LC1OITkrc21zR1DN7D88+4CyYza0zzTljJK64raTEQCCCUwLWchS3xSRs1
 VS1FsMoFtzhfqjuWGJLvESBw2Auzm7amJRwItxHQMDgbPo1cMoOxcHQ+ClcbakpZb+2YWDRd5ZH
 6nP+zTtj+tblO0oTXyaTMo3wbXtTwGjtDarKcp20mQfwNpK1PR5JUmPsWuJJBF2tWtU+FwRixGK
 U27pw5x9nCVWBVDYaSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX3beLzFOL6hRb
 CZAkSXL1iONjjx/45SlyuU2/MZjpfy/RYzxPY6p2HGm442aKDzecRz9P7lTBok8BjjJ9/JmMWSB
 jt4z2WbkITLutwhmTVLZQryaNR3dH5M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050044
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/3/26 19:49, Anushree Mathur wrote:
> Add a functional test that hot-plugs and hot-unplugs a virtio-blk-pci
> disk on the pseries machine.  It runs with TCG, and also with KVM if
> KVM is enabled.
>
> On pseries a PCI device added through QMP is only enumerated by the
> guest once rtas_errd (ppc64-diag) handles the RTAS hotplug event and
>
> runs drmgr (powerpc-utils).  Neither is in the buildroot image used by
> the other pseries tests, so the test uses rootfs-hotplug.ext2: the same
> image with those two tools added.
>
> The test boots with a second PHB (phb1) present so that the guest
> registers its slots, adds a null-co backend, hot-plugs virtio-blk-pci
> into phb1.0 and waits for /dev/vda, then unplugs it and waits for both
> the QMP DEVICE_DELETED event and /dev/vda to go away.  The root drive is
> used with snapshot=on so the cached asset is not modified by the guest.
>
> Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> ---
> Hi all,
>
> This adds a functional test for virtio-blk hotplug on the pseries
> machine, with a TCG and a KVM variant.
>
> The test boots pseries with a second PCI host bridge (phb1) present at
> boot, hot-plugs a virtio-blk-pci device into it over QMP, and waits for
> /dev/vda to show up in the guest.  It then unplugs the device and waits
> for the DEVICE_DELETED event and for /dev/vda to disappear again.
>
> On pseries the guest does not enumerate a hot-plugged PCI device by
> itself: rtas_errd (ppc64-diag) has to handle the RTAS hotplug event and
> run drmgr (powerpc-utils).  The buildroot image the other pseries tests
> use has neither, so the test needs a rootfs that includes them.
>
> I am sending this as an RFC because that rootfs is not available yet.
> It is a new file, rootfs-hotplug.ext2, which I proposed for the
> qemu-ppc-boot repository next to the existing pseries images:
>
>    https://github.com/legoater/qemu-ppc-boot/pull/5

Hi Cedric,

I heard from Anushree that you do not plan to accept PRs in the above 
repository going forward.

If you're okay with it, I'd like to fork your repository and maintain it 
for future PPC test development and usage.
Please let me know if that works for you.

Thanks,
Chinmay

>
> Until that is merged, the Asset URL in the test returns 404.  The sha256
> in the test matches the image in that pull request.  The image is the
> existing 2023.11 ppc64le pseries rootfs with rtas_errd, drmgr and their
> libraries added, built with the legoater/buildroot qemu-ppc toolchain.
>
> Tested on a ppc64le POWER host with both TCG and KVM; checkpatch.pl and
> pylint are clean.
>
>   MAINTAINERS                                |   1 +
>   tests/functional/ppc64/meson.build         |   2 +
>   tests/functional/ppc64/test_hotplug_blk.py | 188 +++++++++++++++++++++
>   3 files changed, 191 insertions(+)
>   create mode 100644 tests/functional/ppc64/test_hotplug_blk.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b12ba90f2..806d8e6ce6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1704,6 +1704,7 @@ F: tests/qtest/libqos/rtas*
>   F: tests/functional/ppc64/test_pseries.py
>   F: tests/functional/ppc64/test_hv.py
>   F: tests/functional/ppc64/test_tuxrun.py
> +F: tests/functional/ppc64/test_hotplug_blk.py
>   
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
> diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
> index cb3c745624..e1e8211dcb 100644
> --- a/tests/functional/ppc64/meson.build
> +++ b/tests/functional/ppc64/meson.build
> @@ -2,6 +2,7 @@
>   
>   test_ppc64_timeouts = {
>     'fadump' : 480,
> +  'hotplug_blk' : 600,
>     'hv' : 1000,
>     'mac99' : 120,
>     'openbsd' : 240,
> @@ -19,6 +20,7 @@ tests_ppc64_system_quick = [
>   tests_ppc64_system_thorough = [
>     'e500',
>     'fadump',
> +  'hotplug_blk',
>     'hv',
>     'mac99',
>     'openbsd',
> diff --git a/tests/functional/ppc64/test_hotplug_blk.py b/tests/functional/ppc64/test_hotplug_blk.py
> new file mode 100644
> index 0000000000..2737e4b486
> --- /dev/null
> +++ b/tests/functional/ppc64/test_hotplug_blk.py
> @@ -0,0 +1,188 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that hot-plugs and hot-unplugs a virtio-blk-pci disk
> +# on the pseries machine type.
> +#
> +# Copyright (c) 2025 IBM Corporation
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import platform
> +
> +from qemu_test import LinuxKernelTest, Asset
> +from qemu_test import exec_command_and_wait_for_pattern
> +
> +
> +class PseriesHotplugBlk(LinuxKernelTest):
> +    """
> +    Test virtio-blk-pci hotplug/unplug on the pseries machine type.
> +
> +    A pre-built rootfs image (based on the buildroot image used by
> +    test_hotplug_cpu.py) is used as the guest OS.  The image includes
> +    rtas_errd from ppc64-diag, which is required on pseries to call the
> +    ibm,configure-connector RTAS function that makes a QMP-hotplugged
> +    PCI device visible to the kernel.
> +
> +    ppc64-diag is not packaged in Alpine Linux, so the Alpine+apk
> +    approach used by test_hv.py cannot be used here.  Instead a
> +    self-contained rootfs with rtas_errd and drmgr (from powerpc-utils)
> +    already installed is referenced as an Asset, following the same
> +    pattern as test_hotplug_cpu.py.
> +
> +    The test is run with both TCG and KVM; the KVM variant needs a
> +    ppc64 host with kvm-hv loaded and is skipped automatically otherwise.
> +
> +    A second spapr-pci-host-bridge (phb1, index=1) is present at VM
> +    launch so the guest kernel registers its PCI slots with rpaphp
> +    during boot-time PCI probe.  Runtime DLPAR hotplug of
> +    virtio-blk-pci into phb1.0 then works via the rtas_errd path.
> +    """
> +
> +    timeout = 600
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
> +         'buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104/'
> +         'vmlinux'),
> +        'fc20d5820ad83ed514ac5f88af7e2692d47ab7f36dab290cdb137d05b98502f5')
> +
> +    # Pre-built rootfs based on the buildroot pseries image above, with
> +    # rtas_errd (from ppc64-diag) and drmgr (from powerpc-utils) added.
> +    # rtas_errd is required to process RTAS hotplug events on pseries and
> +    # it execs drmgr to configure the device; without them rpaphp
> +    # registers the slots but the device is never enumerated by the kernel.
> +    ASSET_ROOTFS = Asset(
> +        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
> +         'buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104/'
> +         'rootfs-hotplug.ext2'),
> +        '01ab3421d313e7765176eb27193fdb5837281dc3c8484eed140de8a3e65908eb')
> +
> +    def _boot_pseries(self, accel):
> +        """Boot pseries with phb1 present and rtas_errd running.
> +
> +        accel must be 'tcg' or 'kvm'.
> +        """
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.ASSET_ROOTFS.fetch()
> +
> +        self.set_machine('pseries')
> +        if accel == 'tcg':
> +            self.vm.add_args('-accel', 'tcg,thread=multi')
> +        else:
> +            self.vm.add_args('-accel', 'kvm')
> +        self.vm.add_args('-smp', '2', '-m', '512M')
> +        # Second PHB present at boot so the guest kernel registers its
> +        # slots with rpaphp.  Required for runtime DLPAR hotplug of
> +        # virtio-blk-pci into phb1.0.
> +        self.vm.add_args('-device', 'spapr-pci-host-bridge,id=phb1,index=1')
> +        # snapshot=on keeps the cached rootfs asset unmodified
> +        self.vm.add_args(
> +            '-drive',
> +            f'file={rootfs_path},if=scsi,index=0,format=raw,snapshot=on')
> +        self.vm.add_args(
> +            '-kernel', kernel_path,
> +            '-append', 'root=/dev/sda console=hvc0 rootwait printk.time=0',
> +        )
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('buildroot login:')
> +        exec_command_and_wait_for_pattern(self, 'root', '#')
> +
> +        # Start rtas_errd so that RTAS hotplug events are processed.
> +        # rtas_errd daemonizes by default (no -d flag).  Run mkdir and
> +        # rtas_errd unconditionally then echo a sentinel so the pattern
> +        # match never depends on their exit codes.
> +        exec_command_and_wait_for_pattern(
> +            self,
> +            'touch /var/log/platform; mkdir -p /var/log/dump;'
> +            ' /usr/sbin/rtas_errd;'
> +            ' echo rtas_errd_started',
> +            'rtas_errd_started',
> +        )
> +
> +    def _do_blk_hotplug(self):
> +
> +        # Confirm /dev/vda does not exist before hotplug.
> +        exec_command_and_wait_for_pattern(
> +            self,
> +            'test -b /dev/vda && echo present || echo absent',
> +            'absent',
> +        )
> +
> +        # Add a null-co block backend (no image file needed).
> +        self.vm.cmd(
> +            'blockdev-add',
> +            **{
> +                'driver': 'null-co',
> +                'size': 1073741824,
> +                'node-name': 'testdisk',
> +            },
> +        )
> +
> +        # Hotplug virtio-blk-pci into phb1.0.  The RTAS hotplug event
> +        # (type 229) is delivered to the guest; rtas_errd calls
> +        # ibm,configure-connector, the kernel enumerates the device and
> +        # udev creates /dev/vda.
> +        self.vm.cmd(
> +            'device_add',
> +            driver='virtio-blk-pci',
> +            drive='testdisk',
> +            id='hotblk0',
> +            bus='phb1.0',
> +            addr='0x0',
> +        )
> +
> +        # Poll until /dev/vda appears.  Use a shell variable sentinel so
> +        # the string 'vda_present' never appears in the typed command,
> +        # avoiding a false match on the echoed command text.
> +        exec_command_and_wait_for_pattern(
> +            self,
> +            'until test -b /dev/vda; do sleep 0.2; done'
> +            '; R=present; echo vda_$R',
> +            'vda_present',
> +        )
> +
> +        # Unplug the device and wait for the QMP deletion event.
> +        self.vm.cmd('device_del', id='hotblk0')
> +        self.vm.event_wait(
> +            'DEVICE_DELETED',
> +            match={'data': {'device': 'hotblk0'}},
> +        )
> +
> +        # Poll until /dev/vda disappears.
> +        exec_command_and_wait_for_pattern(
> +            self,
> +            'while test -b /dev/vda; do sleep 0.2; done'
> +            '; R=absent; echo vda_$R',
> +            'vda_absent',
> +        )
> +
> +    def test_pseries_hotplug_blk_tcg(self):
> +        """Hotplug then unplug a virtio-blk-pci device on pseries (TCG)."""
> +        self.require_accelerator('tcg')
> +        self._boot_pseries('tcg')
> +        self._do_blk_hotplug()
> +
> +    def test_pseries_hotplug_blk_kvm(self):
> +        """Hotplug then unplug a virtio-blk-pci device on pseries (KVM).
> +
> +        Requires a ppc64 host with kvm-hv loaded; skipped automatically
> +        on other hosts.
> +        """
> +        self.require_accelerator('kvm')
> +        # On ppc64 the base kvm module can be loaded (and /dev/kvm created)
> +        # without kvm-hv, so checking /dev/kvm alone is not sufficient.
> +        if platform.machine() in ('ppc64le', 'ppc64'):
> +            try:
> +                with open('/proc/modules', encoding='utf-8') as f:
> +                    if not any(line.split()[0] == 'kvm_hv' for line in f):
> +                        self.skipTest('kvm-hv module is not loaded')
> +            except OSError:
> +                pass
> +        self._boot_pseries('kvm')
> +        self._do_blk_hotplug()
> +
> +
> +if __name__ == '__main__':
> +    PseriesHotplugBlk.main()

