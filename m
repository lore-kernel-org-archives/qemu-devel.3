Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC62606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ouuSVc0U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOyWc-00018U-U3; Thu, 05 Nov 2026 09:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOyWa-00017u-Sh
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 09:33:09 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOyWX-0002Jf-Sb
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 09:33:08 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so802099f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793889184; x=1794493984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=euWfoKO50Zdr1RWlmKiu3TDpJqYKcQS76pZ00DTQmn8=;
 b=ouuSVc0U2BT/tfoFg5sN60nmUMg6LvqzFRHlCjvfLqrGV2Ed2rV7kspQt1mVUlcIzP
 AIW68UOxDMTj5vwB56ADHtYfcblk2IpsFwrJ4mUJ3a/XSl9OcGv73bEBXTOxBH/42aTd
 hpulUgHjhc/Eos6jdR90zefjj0LwgueKW+ImBWpoWbisOfBgHPITRKjEo7E996DK7SPL
 VgPkNrPnJuTKSFlSZs2rTLv/GIGh4/0anH5h1jaf9B1yjylogaQlOUev/+pe4AOgJ5i/
 Bk1JArPwvaUf2fUYH4aaiTge/GrGrgpWLz0YM3KwYEXSO9tPOprwfDjaBk+BV8FgXoDU
 BVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889184; x=1794493984;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=euWfoKO50Zdr1RWlmKiu3TDpJqYKcQS76pZ00DTQmn8=;
 b=JvaCjDrpFQGmt2US43uw0lNio6mEMPCEqWrIxHPasSLG2YsZh0sDP66oEcZvoudAs+
 4GM1Y0PChv9lu4H6t2c109kfzFPsmLWOYlXjo8ionMIucdObiHcARTd5Rb8Enfkt3TMO
 aeXsjLgfqI6i3UhddoeVdBz3VIuGN/Y1+rPECiU+9mcKdHli9vtN0DyHQkAfG1onrNRO
 cMh7XOVDv+v0MmxSZcmugMxjSiIBh3icYOXsS/rt4CtkwkfNxU85mdvGPgYV2uCggAOY
 x/GGI4NfnvHZwO3hUUIVXiLvzkhYxkizP/for+7hWakVHRvh6lGD7q/PCYsQmRpv2trY
 Up+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuXeYSu/0arOFIblF1+iOVz2tX1psjQQsmyGpZFI2faXQv7BFeXm2+AhN4W9wM5EK2iiKNupdv3RqJ@nongnu.org
X-Gm-Message-State: APuU4Z+3yEXCXGtWTYgVUF1Yf0VS+dTp6uPRHT6rE06Hds7U5zQYPfW/
 Hvb9MH0KUXOw1Kyyt02cI0+ryh4/tsVuFyy0ffuAfQETVXbZTneOHDFFno6Q+gNuXPs=
X-Gm-Gg: AYBFou1kchvTbNRnSj/gM6C4YPW9vroqFrm551TyGEz545nSktpJoLSkfnPX5EK7va4
 1E/S36BOELOqEzs2c9ZUBH+V1QTpay/tINLXdGb2QU30le7j2jQEOM8pSYtRIjnk5FjF76R03c9
 qDmliVnWRjzbmC2Fv8kQJqieaKrEZWlu5Diw0cRuMS87Tjro2JDIDYMV85RaTNY2GEXsPi8f0qw
 BkdBRDarww4Q/PMBLVxpFznB12uNiP72u2L/kgtgH32IvmOdqTmDG6KdvfxmoRhHTmujHYcSpCX
 E8XAzVYqvCmWSP4BDPqJeRQUAp0qesMaBrK70KfRwkaAX5XGKSWFBu5pUAvCj8X4k3ENuEorHS2
 u7+X1xFumwM0G7HXzBdupaAnPBhoFWjcWnBqWFsx9C/AMtoGqWCHC6YUryimVgs5QaqNlF4t7oZ
 8SBe4AtuakkokLBq/gj0CQGYqqKNlPoXKdrxEpXZOtZvicGybLKLFf9VFCa2Se/CdDkfTvz/Zj+
 cwUZ1dQ5tQE4rzlcW0KeqIinRcMtw3/mkkvlAT236MPlDq5OFx44VudOBGZ0Cldoj5PX8mMVRe9
 BBO2oAMU2kEiy5fodxpzujsZdHd2
X-Received: by 2002:a05:6000:4a10:b0:491:4ab7:fe9f with SMTP id
 ffacd0b85a97d-4914ab7ffb4mr3926685f8f.57.1793889183672; 
 Thu, 05 Nov 2026 06:33:03 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecf8ef85sm11321214f8f.27.2026.11.05.06.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:33:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D5EBA5F8AF;
 Thu, 05 Nov 2026 14:33:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,  Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,  Thomas Huth
 <thuth@redhat.com>,  Nicholas Piggin <npiggin@gmail.com>,  Amit Machhiwal
 <amachhiw@linux.ibm.com>,  Miles Glenn <milesg@linux.ibm.com>,  Aditya
 Gupta <adityag@linux.ibm.com>
Subject: Re: [RFC PATCH] tests/functional/ppc64: add pseries virtio-blk
 hotplug test
In-Reply-To: <de7816aa-98c6-4c9a-8420-b937f94cd8a1@linux.ibm.com> (Chinmay
 Rath's message of "Thu, 5 Nov 2026 16:44:30 +0530")
References: <20261103141938.41147-1-anushree.mathur@linux.ibm.com>
 <de7816aa-98c6-4c9a-8420-b937f94cd8a1@linux.ibm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Thu, 05 Nov 2026 14:33:01 +0000
Message-ID: <87pkwj73he.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Chinmay Rath <rathc@linux.ibm.com> writes:

> On 11/3/26 19:49, Anushree Mathur wrote:
>> Add a functional test that hot-plugs and hot-unplugs a virtio-blk-pci
>> disk on the pseries machine.  It runs with TCG, and also with KVM if
>> KVM is enabled.
>>
>> On pseries a PCI device added through QMP is only enumerated by the
>> guest once rtas_errd (ppc64-diag) handles the RTAS hotplug event and
>>
>> runs drmgr (powerpc-utils).  Neither is in the buildroot image used by
>> the other pseries tests, so the test uses rootfs-hotplug.ext2: the same
>> image with those two tools added.
>>
>> The test boots with a second PHB (phb1) present so that the guest
>> registers its slots, adds a null-co backend, hot-plugs virtio-blk-pci
>> into phb1.0 and waits for /dev/vda, then unplugs it and waits for both
>> the QMP DEVICE_DELETED event and /dev/vda to go away.  The root drive is
>> used with snapshot=3Don so the cached asset is not modified by the guest.
>>
>> Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>> ---
>> Hi all,
>>
>> This adds a functional test for virtio-blk hotplug on the pseries
>> machine, with a TCG and a KVM variant.
>>
>> The test boots pseries with a second PCI host bridge (phb1) present at
>> boot, hot-plugs a virtio-blk-pci device into it over QMP, and waits for
>> /dev/vda to show up in the guest.  It then unplugs the device and waits
>> for the DEVICE_DELETED event and for /dev/vda to disappear again.
>>
>> On pseries the guest does not enumerate a hot-plugged PCI device by
>> itself: rtas_errd (ppc64-diag) has to handle the RTAS hotplug event and
>> run drmgr (powerpc-utils).  The buildroot image the other pseries tests
>> use has neither, so the test needs a rootfs that includes them.
>>
>> I am sending this as an RFC because that rootfs is not available yet.
>> It is a new file, rootfs-hotplug.ext2, which I proposed for the
>> qemu-ppc-boot repository next to the existing pseries images:
>>
>>    https://github.com/legoater/qemu-ppc-boot/pull/5

I can't see the contents of this PR but I was wondering to the tuxrun
kernels have what you need?

>
> Hi Cedric,
>
> I heard from Anushree that you do not plan to accept PRs in the above
> repository going forward.
>
> If you're okay with it, I'd like to fork your repository and maintain
> it for future PPC test development and usage.
> Please let me know if that works for you.
>
> Thanks,
> Chinmay
>
>>
>> Until that is merged, the Asset URL in the test returns 404.  The sha256
>> in the test matches the image in that pull request.  The image is the
>> existing 2023.11 ppc64le pseries rootfs with rtas_errd, drmgr and their
>> libraries added, built with the legoater/buildroot qemu-ppc toolchain.
>>
>> Tested on a ppc64le POWER host with both TCG and KVM; checkpatch.pl and
>> pylint are clean.
>>
>>   MAINTAINERS                                |   1 +
>>   tests/functional/ppc64/meson.build         |   2 +
>>   tests/functional/ppc64/test_hotplug_blk.py | 188 +++++++++++++++++++++
>>   3 files changed, 191 insertions(+)
>>   create mode 100644 tests/functional/ppc64/test_hotplug_blk.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3b12ba90f2..806d8e6ce6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1704,6 +1704,7 @@ F: tests/qtest/libqos/rtas*
>>   F: tests/functional/ppc64/test_pseries.py
>>   F: tests/functional/ppc64/test_hv.py
>>   F: tests/functional/ppc64/test_tuxrun.py
>> +F: tests/functional/ppc64/test_hotplug_blk.py
>>     PowerNV (Non-Virtualized)
>>   M: Nicholas Piggin <npiggin@gmail.com>
>> diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64=
/meson.build
>> index cb3c745624..e1e8211dcb 100644
>> --- a/tests/functional/ppc64/meson.build
>> +++ b/tests/functional/ppc64/meson.build
>> @@ -2,6 +2,7 @@
>>     test_ppc64_timeouts =3D {
>>     'fadump' : 480,
>> +  'hotplug_blk' : 600,
>>     'hv' : 1000,
>>     'mac99' : 120,
>>     'openbsd' : 240,
>> @@ -19,6 +20,7 @@ tests_ppc64_system_quick =3D [
>>   tests_ppc64_system_thorough =3D [
>>     'e500',
>>     'fadump',
>> +  'hotplug_blk',
>>     'hv',
>>     'mac99',
>>     'openbsd',
>> diff --git a/tests/functional/ppc64/test_hotplug_blk.py b/tests/function=
al/ppc64/test_hotplug_blk.py
>> new file mode 100644
>> index 0000000000..2737e4b486
>> --- /dev/null
>> +++ b/tests/functional/ppc64/test_hotplug_blk.py
>> @@ -0,0 +1,188 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that hot-plugs and hot-unplugs a virtio-blk-pci disk
>> +# on the pseries machine type.
>> +#
>> +# Copyright (c) 2025 IBM Corporation
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import platform
>> +
>> +from qemu_test import LinuxKernelTest, Asset
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +
>> +
>> +class PseriesHotplugBlk(LinuxKernelTest):
>> +    """
>> +    Test virtio-blk-pci hotplug/unplug on the pseries machine type.
>> +
>> +    A pre-built rootfs image (based on the buildroot image used by
>> +    test_hotplug_cpu.py) is used as the guest OS.  The image includes
>> +    rtas_errd from ppc64-diag, which is required on pseries to call the
>> +    ibm,configure-connector RTAS function that makes a QMP-hotplugged
>> +    PCI device visible to the kernel.
>> +
>> +    ppc64-diag is not packaged in Alpine Linux, so the Alpine+apk
>> +    approach used by test_hv.py cannot be used here.  Instead a
>> +    self-contained rootfs with rtas_errd and drmgr (from powerpc-utils)
>> +    already installed is referenced as an Asset, following the same
>> +    pattern as test_hotplug_cpu.py.
>> +
>> +    The test is run with both TCG and KVM; the KVM variant needs a
>> +    ppc64 host with kvm-hv loaded and is skipped automatically otherwis=
e.
>> +
>> +    A second spapr-pci-host-bridge (phb1, index=3D1) is present at VM
>> +    launch so the guest kernel registers its PCI slots with rpaphp
>> +    during boot-time PCI probe.  Runtime DLPAR hotplug of
>> +    virtio-blk-pci into phb1.0 then works via the rtas_errd path.
>> +    """
>> +
>> +    timeout =3D 600
>> +
>> +    ASSET_KERNEL =3D Asset(
>> +        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main=
/'
>> +         'buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104=
/'
>> +         'vmlinux'),
>> +        'fc20d5820ad83ed514ac5f88af7e2692d47ab7f36dab290cdb137d05b98502=
f5')
>> +
>> +    # Pre-built rootfs based on the buildroot pseries image above, with
>> +    # rtas_errd (from ppc64-diag) and drmgr (from powerpc-utils) added.
>> +    # rtas_errd is required to process RTAS hotplug events on pseries a=
nd
>> +    # it execs drmgr to configure the device; without them rpaphp
>> +    # registers the slots but the device is never enumerated by the ker=
nel.
>> +    ASSET_ROOTFS =3D Asset(
>> +        ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main=
/'
>> +         'buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104=
/'
>> +         'rootfs-hotplug.ext2'),
>> +        '01ab3421d313e7765176eb27193fdb5837281dc3c8484eed140de8a3e65908=
eb')
>> +
>> +    def _boot_pseries(self, accel):
>> +        """Boot pseries with phb1 present and rtas_errd running.
>> +
>> +        accel must be 'tcg' or 'kvm'.
>> +        """
>> +        kernel_path =3D self.ASSET_KERNEL.fetch()
>> +        rootfs_path =3D self.ASSET_ROOTFS.fetch()
>> +
>> +        self.set_machine('pseries')
>> +        if accel =3D=3D 'tcg':
>> +            self.vm.add_args('-accel', 'tcg,thread=3Dmulti')
>> +        else:
>> +            self.vm.add_args('-accel', 'kvm')
>> +        self.vm.add_args('-smp', '2', '-m', '512M')
>> +        # Second PHB present at boot so the guest kernel registers its
>> +        # slots with rpaphp.  Required for runtime DLPAR hotplug of
>> +        # virtio-blk-pci into phb1.0.
>> +        self.vm.add_args('-device', 'spapr-pci-host-bridge,id=3Dphb1,in=
dex=3D1')
>> +        # snapshot=3Don keeps the cached rootfs asset unmodified
>> +        self.vm.add_args(
>> +            '-drive',
>> +            f'file=3D{rootfs_path},if=3Dscsi,index=3D0,format=3Draw,sna=
pshot=3Don')
>> +        self.vm.add_args(
>> +            '-kernel', kernel_path,
>> +            '-append', 'root=3D/dev/sda console=3Dhvc0 rootwait printk.=
time=3D0',
>> +        )
>> +        self.vm.set_console()
>> +        self.vm.launch()
>> +
>> +        self.wait_for_console_pattern('buildroot login:')
>> +        exec_command_and_wait_for_pattern(self, 'root', '#')
>> +
>> +        # Start rtas_errd so that RTAS hotplug events are processed.
>> +        # rtas_errd daemonizes by default (no -d flag).  Run mkdir and
>> +        # rtas_errd unconditionally then echo a sentinel so the pattern
>> +        # match never depends on their exit codes.
>> +        exec_command_and_wait_for_pattern(
>> +            self,
>> +            'touch /var/log/platform; mkdir -p /var/log/dump;'
>> +            ' /usr/sbin/rtas_errd;'
>> +            ' echo rtas_errd_started',
>> +            'rtas_errd_started',
>> +        )
>> +
>> +    def _do_blk_hotplug(self):
>> +
>> +        # Confirm /dev/vda does not exist before hotplug.
>> +        exec_command_and_wait_for_pattern(
>> +            self,
>> +            'test -b /dev/vda && echo present || echo absent',
>> +            'absent',
>> +        )
>> +
>> +        # Add a null-co block backend (no image file needed).
>> +        self.vm.cmd(
>> +            'blockdev-add',
>> +            **{
>> +                'driver': 'null-co',
>> +                'size': 1073741824,
>> +                'node-name': 'testdisk',
>> +            },
>> +        )
>> +
>> +        # Hotplug virtio-blk-pci into phb1.0.  The RTAS hotplug event
>> +        # (type 229) is delivered to the guest; rtas_errd calls
>> +        # ibm,configure-connector, the kernel enumerates the device and
>> +        # udev creates /dev/vda.
>> +        self.vm.cmd(
>> +            'device_add',
>> +            driver=3D'virtio-blk-pci',
>> +            drive=3D'testdisk',
>> +            id=3D'hotblk0',
>> +            bus=3D'phb1.0',
>> +            addr=3D'0x0',
>> +        )
>> +
>> +        # Poll until /dev/vda appears.  Use a shell variable sentinel so
>> +        # the string 'vda_present' never appears in the typed command,
>> +        # avoiding a false match on the echoed command text.
>> +        exec_command_and_wait_for_pattern(
>> +            self,
>> +            'until test -b /dev/vda; do sleep 0.2; done'
>> +            '; R=3Dpresent; echo vda_$R',
>> +            'vda_present',
>> +        )
>> +
>> +        # Unplug the device and wait for the QMP deletion event.
>> +        self.vm.cmd('device_del', id=3D'hotblk0')
>> +        self.vm.event_wait(
>> +            'DEVICE_DELETED',
>> +            match=3D{'data': {'device': 'hotblk0'}},
>> +        )
>> +
>> +        # Poll until /dev/vda disappears.
>> +        exec_command_and_wait_for_pattern(
>> +            self,
>> +            'while test -b /dev/vda; do sleep 0.2; done'
>> +            '; R=3Dabsent; echo vda_$R',
>> +            'vda_absent',
>> +        )
>> +
>> +    def test_pseries_hotplug_blk_tcg(self):
>> +        """Hotplug then unplug a virtio-blk-pci device on pseries (TCG)=
."""
>> +        self.require_accelerator('tcg')
>> +        self._boot_pseries('tcg')
>> +        self._do_blk_hotplug()
>> +
>> +    def test_pseries_hotplug_blk_kvm(self):
>> +        """Hotplug then unplug a virtio-blk-pci device on pseries (KVM).
>> +
>> +        Requires a ppc64 host with kvm-hv loaded; skipped automatically
>> +        on other hosts.
>> +        """
>> +        self.require_accelerator('kvm')
>> +        # On ppc64 the base kvm module can be loaded (and /dev/kvm crea=
ted)
>> +        # without kvm-hv, so checking /dev/kvm alone is not sufficient.
>> +        if platform.machine() in ('ppc64le', 'ppc64'):
>> +            try:
>> +                with open('/proc/modules', encoding=3D'utf-8') as f:
>> +                    if not any(line.split()[0] =3D=3D 'kvm_hv' for line=
 in f):
>> +                        self.skipTest('kvm-hv module is not loaded')
>> +            except OSError:
>> +                pass
>> +        self._boot_pseries('kvm')
>> +        self._do_blk_hotplug()
>> +
>> +
>> +if __name__ =3D=3D '__main__':
>> +    PseriesHotplugBlk.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

