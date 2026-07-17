Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1E2C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiZz-0008JM-TL; Fri, 17 Jul 2026 09:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkiZp-0008ID-EA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:26:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkiZn-0007Ac-G2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:26:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCT1tP1884520
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 13:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dEZXfGKPhpN/GbNaJUJdMJOu6x/OSxFKQsc7D4qJtXM=; b=fZsfsBgTwUCgwtH5
 wFdPT17coma4QvMofyPZrydgZxpTKf3sg55IQMco10vUBf+BM9bTYMbTa4fgTJ7B
 xeYCbt8ZtQ1iFox4S4pMRH6zO3Hy9zfaO2vStVhlpiFXHTWmuzrhCg81GuhhiKtr
 IdAiKebSaVHl0Jk5QJU6YL9QsYLm7h+F6IJxiprxYLA7tbMM3lEUWqmp71NOtAb2
 n0gIEMXn6Q/97St60x0406Qv6PRvFZi4UDdJEAr5eyG2aVWZCCveHri94o65kd5S
 GHSglJCKBqPjt1BpcKX/vIqra10YPk7FOpcTdT+UxxoFJF2KuDYih9zb9S6NtlRw
 TyXL8A==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfgvbs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 13:26:01 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81eddfe28b4so64288227b3.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784294761; x=1784899561; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dEZXfGKPhpN/GbNaJUJdMJOu6x/OSxFKQsc7D4qJtXM=;
 b=R3YhrdIJft+vQHhwgJtSzde1kynGdkMHEK9hSK2PZaMbzhU2uS9a5qWGZx8cSQqx03
 +JVmieOdfn4PTe9PgqxkJuO/yfcY1VJ2ob68BLi4/Ubt+IVxjnOAObjzJyH/Qq/JVzPL
 vljC+jAv79eaMUqq9YPvPLArUrq57jqN+kL/doMzqE0JDMb4G+xMfQK2KE4uyMs9EXna
 e03QFW0MY8YCusSBlFmTZVPnklF+lJkiUe7vcRy6dmdzvCxQux61BZgjqGnAq5y10XOI
 qZjFmfMRr6BcIRgI3YAMl0tIckb+fX2odKzQ5SsX4r7xtOQNtV8XkAGcG1ijff484va+
 uwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784294761; x=1784899561;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dEZXfGKPhpN/GbNaJUJdMJOu6x/OSxFKQsc7D4qJtXM=;
 b=c83RfTFYuzEKBVu+3FTtC8pfmckGIwnG0Vrrt1eC3LhS3kUbLgJ1iZvsIYKe7uIKLQ
 8XE0tIfAmEGH+pz7VFsKv5rm8IpRwofrulx+aAX5mWLt9LY4+6jevSngNAShRvFjy/xj
 W4sTq7QyK/APoOIoGHaEY2BM6gCdmyrNi4vh7IYhILtR14Asd44+P3pjtiDQ6am8KpFA
 mIymWmy6hES2kCDVH2g1qbZfb/pVykCNssty43XIg6i89v+4PgOWHE3/HapQGpLEpePz
 pW2e5h/IXfTMGA+geZ044jvrz4fOqX+hb57QpZH90ZigeumuYfhhEfE4LTxwIP0uxdtQ
 AOtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/64Puy4ueJgHlD0KnFVObVC1Oq9Czmr8Ve0msHCBJrwj7cgaXSQJXOe/SjaByJn1+NUYkOSFvxkhi@nongnu.org
X-Gm-Message-State: AOJu0YwpBPOxmxg46bDjD5wiS2/ukibqSKJEmUXDBQN9kBCXiEcOoYKb
 5m2mYy63sjDqeHPHlBtZ9nWgm95KZgTAhdJ8dbIHq8IoywCKQ+drAUYFEha1/7LfKPAsqf01I8G
 ZU+q8cZc8gubnjEzGHIH4tPPB3y/EVjRjGoC7h2nK9AYPo5fadTP2Vi2AIA==
X-Gm-Gg: AfdE7ckzFmpx2LFiqF5RMNy+vo6FbghmSfiv+xe2y1phKifKsPW5jdcQMS/oU8hcfa7
 v34IvvGwyjhStJeuZly6bEY9fcP18OQENF7wWNUxtXKW+/h1JX5Sgw8rdv3CeDQPQMxG15AAUb2
 H0AlQbQegfZfNs1RboLwJJhIl9LiDRltqG7s74k9/JBdVsqht7zWVB64+c6H+L84SgcC7JWwCIO
 Ili7xh5fdnNhng9f+O8cb1/bmqf+1/hfssqTtr+D1gwAIhY17ZrPa/5Ig0A0Xx5yMAAw45+NKNv
 kP/mLM4l7/uiq94smN9PpQRBHrdmhapC34VUVlzUpmpp+JCT4nT1qkgo0i89nccqQlenB4iJvi8
 uvJY6bkYSvPCtYgnQMN7wfu0B9VM/L6uznK78Og==
X-Received: by 2002:a05:690c:6:b0:80c:85e5:8732 with SMTP id
 00721157ae682-81ef26c1340mr7064477b3.64.1784294761415; 
 Fri, 17 Jul 2026 06:26:01 -0700 (PDT)
X-Received: by 2002:a05:690c:6:b0:80c:85e5:8732 with SMTP id
 00721157ae682-81ef26c1340mr7064227b3.64.1784294760764; 
 Fri, 17 Jul 2026 06:26:00 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81ef42ae43esm9010967b3.34.2026.07.17.06.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:26:00 -0700 (PDT)
Message-ID: <e4c52a4d-9464-4a8b-92ea-7ab1197e9bea@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:25:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] tests/functional: add initial RPMI virt guest
 smoke
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-11-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714075659.2258023-11-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNiBTYWx0ZWRfX3qClSHL0YSX7
 0WW/UgflAoiacCpFPU5B09LmNQlGnjSiltFSco3a6cjP6OlPbomhMYJX41nUvecsLa73dB3vqqq
 h3EX9DwRYIHPqJ0PpzvaLQj8GVLesxvtU/Hv5r4bVQAe9uraw5zaHVkWclgd4MC5lzEvrBu4Vn8
 4ppDZN1RUIdKvu5ej+qNNdpVD70WjR0g6s1TVyJAFLsG2O9h8i3PYsN1CP9gK9vx/iNsLYyrQWe
 MCfzlhcqXzgdJXs1CIJm3PFp+BgVezuOg1GOVdhOE4zJXr8qgFqb9+i5/LTK/dNETeyqOAyNRoO
 ZrenMujKQ+9FoypgtDFG5b/M7bRhkbHEBDuzA3EVyuEbYBw73Hswq8AIpxgZ5G4oo0AxcCjw88y
 atYPUh23Lz+o7GJQ0c+1ZZHF3s13zBB19sovGW/3H3cR0rEoEDvcJ0hgeUbMvScOZMBqRsLEdb0
 fKRTjZaxfcW+51JncHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNiBTYWx0ZWRfXyzYHq7qohDO7
 7kpjVkKwz9iz+gf0mP4dYb8KEEfnjMN2pBevg0U6Dlukrics/eUUlP2ZhT6tDRjO+jYelashz36
 ff2SllkTybxBL1XhbDGSUx6/J7OCU2Q=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a2d69 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=id1fG4O3IpAWAUPRaTwA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: SiUn4Tg2FIft38FCL70Ga85uidGdWn8v
X-Proofpoint-ORIG-GUID: SiUn4Tg2FIft38FCL70Ga85uidGdWn8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170136
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> Boot an RPMI-enabled RISC-V virt guest and exercise the initial HSM,
> system suspend, and system reset paths.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---
>   tests/functional/riscv64/meson.build       |   2 +
>   tests/functional/riscv64/test_rpmi_virt.py | 172 +++++++++++++++++++++
>   2 files changed, 174 insertions(+)
>   create mode 100644 tests/functional/riscv64/test_rpmi_virt.py
> 
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
> index 5871211e89..619a0735fa 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -3,6 +3,7 @@
>   test_riscv64_timeouts = {
>     'boston' : 120,
>     'tuxrun' : 120,
> +  'rpmi_virt' : 300,
>   }
>   
>   tests_riscv64_system_quick = [
> @@ -15,4 +16,5 @@ tests_riscv64_system_thorough = [
>     'boston',
>     'sifive_u',
>     'tuxrun',
> +  'rpmi_virt',
>   ]
> diff --git a/tests/functional/riscv64/test_rpmi_virt.py b/tests/functional/riscv64/test_rpmi_virt.py
> new file mode 100644
> index 0000000000..c0f96f7d8d
> --- /dev/null
> +++ b/tests/functional/riscv64/test_rpmi_virt.py
> @@ -0,0 +1,172 @@
> +#!/usr/bin/env python3
> +#
> +# RISC-V virt RPMI Linux guest integration tests
> +#
> +# Copyright (c) 2026 Ventana Micro Systems Inc.

We can't add a Ventana copyright dated 2026.  Ventana as an entity ceased to
exist December 2025.


Everything else LGTM.  Thanks,
Daniel


> +# Copyright (c) 2026 Qualcomm Technologies, Inc.
> +#
> +# Author:
> +#  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +from pathlib import Path
> +import subprocess
> +import time
> +
> +from qemu_test import QemuSystemTest
> +from qemu_test import exec_command
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import get_qemu_img
> +from qemu_test import wait_for_console_pattern
> +
> +
> +class RiscvVirtRpmiGuestTest(QemuSystemTest):
> +    """Boot Linux and exercise RPMI-backed services through guest APIs.
> +
> +    This test intentionally keeps guest artifacts external. Set:
> +
> +      QEMU_TEST_RPMI_OPENSBI=/path/to/fw_jump.bin
> +      QEMU_TEST_RPMI_KERNEL=/path/to/Image
> +      QEMU_TEST_RPMI_ROOTFS=/path/to/rootfs.ext4
> +
> +    Exact RPMI packet command-ID coverage remains in riscv-rpmi qtests. This
> +    functional test verifies Linux/OpenSBI integration paths visible from a
> +    real guest without adding probe hooks to production RPMI sources.
> +    """
> +
> +    timeout = 360
> +    PROMPT = 'root@tuxtest:~#'
> +
> +    def _require_path(self, env_name):
> +        value = os.getenv(env_name)
> +        if not value:
> +            self.skipTest(f'{env_name} is required')
> +        path = Path(value)
> +        if not path.exists():
> +            self.skipTest(f'{env_name} does not exist: {path}')
> +        return path
> +
> +    def setUp(self):
> +        super().setUp()
> +        self.opensbi = self._require_path('QEMU_TEST_RPMI_OPENSBI')
> +        self.kernel = self._require_path('QEMU_TEST_RPMI_KERNEL')
> +        self.rootfs = self._require_path('QEMU_TEST_RPMI_ROOTFS')
> +        self.qemu_img = get_qemu_img(self)
> +
> +    def _create_rootfs_overlay(self):
> +        overlay = Path(self.scratch_file('rootfs.qcow2'))
> +        subprocess.run([
> +            self.qemu_img, 'create', '-q', '-f', 'qcow2', '-F', 'raw',
> +            '-b', str(self.rootfs), str(overlay),
> +        ], check=True)
> +        return overlay
> +
> +    def _boot_guest(self, smp=4):
> +        self.set_machine('virt')
> +        self.machine = 'virt,rpmi=on,aia=aplic-imsic'
> +        rootfs_overlay = self._create_rootfs_overlay()
> +
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            '-cpu', 'rv64',
> +            '-smp', str(smp),
> +            '-m', '1G',
> +            '-bios', str(self.opensbi),
> +            '-kernel', str(self.kernel),
> +            '-append', 'printk.time=0 root=/dev/vda rw console=ttyS0 '
> +                       'earlycon=sbi loglevel=8 no_console_suspend',
> +            '-blockdev', 'driver=qcow2,file.driver=file,'
> +                         f'file.filename={rootfs_overlay},node-name=hd0',
> +            '-device', 'virtio-blk-device,drive=hd0',
> +        )
> +        self.vm.launch()
> +
> +    def _expect_rpmi_firmware_and_linux(self):
> +        patterns = [
> +            'Platform HSM Device         : rpmi-hsm',
> +            'Platform Suspend Device     : rpmi-system-suspend',
> +            'Standard SBI Extensions',
> +            'susp',
> +            'tuxtest login:',
> +        ]
> +        for pattern in patterns:
> +            wait_for_console_pattern(self, pattern)
> +        exec_command_and_wait_for_pattern(self, 'root', self.PROMPT)
> +
> +    def _run_marker_command(self, command, marker, failure_marker=None):
> +        out = exec_command_and_wait_for_pattern(self, command, marker,
> +                                                failure_message=failure_marker)
> +        self.assertIn(marker.encode(), out)
> +        return out
> +
> +    def _validate_hsm_boot_start(self, online_cpus):
> +        self._run_marker_command(
> +            'echo RPMI_LINUX_HSM_START_BEGIN; '
> +            'cat /sys/devices/system/cpu/present; '
> +            'online=$(cat /sys/devices/system/cpu/online); '
> +            'echo "$online"; '
> +            f'if [ "$online" = "{online_cpus}" ]; '
> +            'then echo RPMI_LINUX_HSM_START_PASS; '
> +            'else echo RPMI_LINUX_HSM_START_FAIL; fi',
> +            'RPMI_LINUX_HSM_START_PASS', 'RPMI_LINUX_HSM_START_FAIL')
> +
> +    def _validate_hsm_stop(self):
> +        self._run_marker_command(
> +            'echo RPMI_LINUX_HSM_STOP_BEGIN; '
> +            'if [ -w /sys/devices/system/cpu/cpu1/online ]; then '
> +            'echo 0 > /sys/devices/system/cpu/cpu1/online && '
> +            '[ "$(cat /sys/devices/system/cpu/online)" = 0 ] && '
> +            'echo RPMI_LINUX_HSM_STOP_PASS || echo RPMI_LINUX_HSM_STOP_FAIL; '
> +            'else echo RPMI_LINUX_HSM_STOP_FAIL; fi',
> +            'RPMI_LINUX_HSM_STOP_PASS', 'RPMI_LINUX_HSM_STOP_FAIL')
> +
> +    def _validate_system_suspend(self):
> +        exec_command(
> +            self,
> +            'echo RPMI_LINUX_SUSPEND_BEGIN; '
> +            'if grep -qw mem /sys/power/state; then '
> +            'echo mem > /sys/power/state; '
> +            'else echo RPMI_LINUX_SUSPEND_FAIL; fi')
> +        wait_for_console_pattern(self, 'RPMI_LINUX_SUSPEND_BEGIN')
> +        wait_for_console_pattern(self, 'PM: suspend entry')
> +        self.vm.event_wait('SUSPEND', 10)
> +        self.vm.qmp('system_wakeup')
> +        self.vm.event_wait('WAKEUP', 10)
> +        wait_for_console_pattern(self, 'PM: suspend exit')
> +        wait_for_console_pattern(self, self.PROMPT)
> +        self._run_marker_command(
> +            'marker=RPMI_LINUX_WAKEUP; echo ${marker}_PASS',
> +            'RPMI_LINUX_WAKEUP_PASS')
> +
> +    def _validate_reset_poweroff(self):
> +        exec_command(self, 'echo RPMI_LINUX_RESET_POWEROFF_BEGIN; poweroff -f')
> +        wait_for_console_pattern(self, 'RPMI_LINUX_RESET_POWEROFF_BEGIN')
> +        wait_for_console_pattern(self, 'reboot: Power down')
> +        self.vm.wait()
> +
> +    def test_linux_guest_service_enumeration(self):
> +        self._boot_guest(smp=4)
> +        self._expect_rpmi_firmware_and_linux()
> +        self._validate_hsm_boot_start('0-3')
> +
> +    def test_linux_guest_hsm_stop(self):
> +        self._boot_guest(smp=2)
> +        self._expect_rpmi_firmware_and_linux()
> +        self._validate_hsm_boot_start('0-1')
> +        self._validate_hsm_stop()
> +
> +    def test_linux_guest_suspend(self):
> +        self._boot_guest(smp=1)
> +        self._expect_rpmi_firmware_and_linux()
> +        self._validate_system_suspend()
> +
> +    def test_linux_guest_reset_poweroff(self):
> +        self._boot_guest(smp=1)
> +        self._expect_rpmi_firmware_and_linux()
> +        self._validate_reset_poweroff()
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()


