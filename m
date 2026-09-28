Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137CBC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8tF-0003oW-92; Mon, 28 Sep 2026 06:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xB8sz-0003m0-RA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:47:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xB8sx-0005Nb-Ba
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:47:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M6L4246041
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=R6wWn9Tx1IIbQKEEN34411xD
 nFrgkphR2cbEq2CuHro=; b=RbQXIix+Jhcm5Mba//82FEqgAeOzlvsW/bLoO72o
 bF7FkICpod+9eRS4/AgAU3LjmPdEenJpIiOqauIViannS6MBq854kxlIyQAIvzMr
 KlRalEryBpvxjEWUTa+FQMYwH54QXK8CB4y/6EPqID3vKPERUVKoC8o9Hcks+CXc
 M1mZ8ScNTAfKnQ4FnRfxxa1a6sNc/ePV7UrbOX2s+Q/xLYlNCr5NC0rZWzbLU+sl
 tZsV91QuO2WokqeCNyWtPXidnYPUv8Exx5CR2TpWkPZNfZZNper21wWycgCG48hf
 ILFsYft+fcsTTcZn/VcSwR4x4IRkVs4tRn0CpseMTrgo8w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt110eq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:46:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0c7126e7so535391585a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790592416; x=1791197216; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R6wWn9Tx1IIbQKEEN34411xDnFrgkphR2cbEq2CuHro=;
 b=CvyueCKyLGNBWelQTnIt/g4ZRF0U2CduCmttqObI4fpzL3HO+4bHGep+KFopLvGs/w
 pvKsCxPjMK5GoxCMy0VXb2+P7H++rw8uNa6abCU2xVftxf+K42wZi1heSWvn0NJ/VAkD
 MlITbKg9NNIYys8UOxo67r9n460lgvqBI6rGl8TCJ4H+AXrecu4BggMmbalXpmwOIJ+/
 Oiueof1967cszGsYm1sqxggGcvDksPt0Aqfcdc0rMyTMKFnschXSVjFFBkcS+nFPmH+e
 NVBbbIqNN+S0vSMdeeGYbPlGyVsObFRIh4TqW+ZJlOo+Xe9m8cw1cSlnF/65YojgLuVX
 OPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790592416; x=1791197216;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R6wWn9Tx1IIbQKEEN34411xDnFrgkphR2cbEq2CuHro=;
 b=U2kBs6qUJU7ae3ASn+nQDnMm9d5GJVVmvPy/1mkn+IkFUl22gl7D2xYNK4ruRf3UkQ
 8ddSa7DkJIReNhNnwyPGtIki66nCavseLgJeDjRHhj0ZJbh3mezbCW+WQxdwPWM2R8W2
 Ay3U1Aiq8baBylbgCDxuluysLuBGTkr0YYCmwLMCI7O37Cuc8QAOwSTFlmGjyUtLpQvL
 DXw6Ji962n2RYbNpCKwBi+ta28rkAUvj/26y5kjbdv0k1/zXwHVgGUrzotrwuMYfXhf2
 4CfFNrGugQ249mZ2jKYaRqCBChbuv9ttTw32Isx4wI56Enx7o1aBXUvjPZPjLh9Juzrf
 JUlQ==
X-Gm-Message-State: AFuF++nmldtOgziialk1Wzcxib9OB8YP2vSslk2h+GSnigI6OYJKHJv0
 I5zfSifRCeSIrRE4enCUWb2qP9NP1oyfbIp4V4bLaYuOAjmL66SYZTPIFO9zgq99V9IqOKrrKQZ
 7Zd+fHTknk0oLLrDT5OO+Zk0eg2WSE4r7CfY0YT+aagJpReDnQQy9gGpqJg==
X-Gm-Gg: AYBFou1Dd4oWG9Sk6BMSLUU1jEF0C03/JBAx95AH4UtMnA1oopZskgiCpmpnwfmcDjv
 yeQD/EZ494hebpI06Gs5wYz0bthjoiEpsrp83Kn1G1zRNRzoP5/e6h90gAq7ns7YdnJA1LBmntJ
 COIc6qZSqWk0BXXU7FpuT4aX11ywbufXBKwqu2FdIK8lVHfspy3qCbUeq7NR1jtJMa/2VqEcDU9
 Q3P3N12H/CqVJ5aTaZEuFQ1q1+q6LnZYBFNIEdhGtN5sX/Zel9xloJt6R3WI7Cv9KUkJrsl19yB
 P5QnCHoLT/DQ9ucEYx0+m/JXGSOUGx/H7wABJ4uDBdncuku06moB5hi9M23myfmhfVSi9i30Iad
 u3l3lk7tko8qHxCIPvBUov/DEcBKPaICOCPEFPg==
X-Received: by 2002:a05:620a:6c0d:b0:939:de6c:cb45 with SMTP id
 af79cd13be357-93c43d159a1mr2069814685a.47.1790592416014; 
 Mon, 28 Sep 2026 03:46:56 -0700 (PDT)
X-Received: by 2002:a05:620a:6c0d:b0:939:de6c:cb45 with SMTP id
 af79cd13be357-93c43d159a1mr2069810785a.47.1790592415550; 
 Mon, 28 Sep 2026 03:46:55 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6456f8sm26368609f8f.26.2026.09.28.03.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 03:46:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:46:53 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Chao Liu <chao.liu.zevorn@gmail.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v12 4/5] tests/functional/riscv64: add riscv-server-ref
 tests
Message-ID: <geavtirs7hw5givjazrneegb7gwqsvmwq3koglyxxcxz2fauy3@j4vobi7nbsh6>
References: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
 <20260917174405.3471736-5-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917174405.3471736-5-daniel.barboza@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfXyKA7vFaIZRz8
 1ZozqBPwWaUmo16l+32lbXd3vw9XE5umtsng2qD8ZHvFlH1PO8Qc+9BFTn/BBY0Zd1PclKkOSvx
 NfFoRKfzG+kTt7qYLQWB9KN3MHs8CwAwrMewVlJOsCqvPlgDjkzvI1YF9PR+14xqkKq6F1pT+wJ
 FGC5laZZMQpRrPFHBCZmr//2+f8i3Rhgt8IgKPgolFYScbjb/OERzUcPsoST9olIHCsxs75ovKU
 iOxH7uNnbYMi1RH13Nu102trWdBxbvw/i9w8yyhPbwdw7TS1rEqZrgbxYFbu8Y6juWhi7h8k76y
 hHEjBEHi0GXbeI06mNgMLtY5fi29b+awvjnx4Cb1xijh/figJnxeGKQHnVsFQUc9p4hhhzHfkq6
 MaDmOF+VZ69NmFC7/Uyqe+DPkw17AN5l0gbo/L/UMEZawCh+11BXtpbbI9r1oWUS3AiE64J4Gt2
 IZTEochkB6M7uHc5Nzg==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba45a0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=69EAbJreAAAA:8
 a=JF9118EUAAAA:8 a=2REcCJ5HaDLgvgcGo00A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: GBxmBQSd6r2_sGE-45TouLO_r9Qfh-fg
X-Proofpoint-GUID: GBxmBQSd6r2_sGE-45TouLO_r9Qfh-fg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX5nA/EEJ5agIR
 mDSVIA2RASGkSsOWKgdgaonyvhzc8ebXfUrVqKwhmMtE8buLCoGfYbKqxP5xyopns3w9HMqmznn
 F3qA+NLFJPd7myJFN/IZQhLZx/mmpE0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280042
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, Sep 17, 2026 at 02:44:03PM -0300, Daniel Henrique Barboza wrote:
> Add tests for the recently added riscv-server-ref machine:
> 
> - a new test_opensbi.py test.  The idea is to have a quick test that can
> catch trivial regressions that would prevent OpenSBI to finish;
> - a new Linux boot "thorough" test that will boot the machine up to the
> buildroot prompt.
> - a TPM specific selftest for the riscv-server-ref board.  The test
> will be skipped if there's no 'swtpm' in the host.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> ---
>  tests/functional/riscv64/meson.build        |  2 +
>  tests/functional/riscv64/test_opensbi.py    |  4 +
>  tests/functional/riscv64/test_server_ref.py | 90 +++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100755 tests/functional/riscv64/test_server_ref.py
> 
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
> index d1a3e6c2bf..2d22e49efd 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -3,6 +3,7 @@
>  test_riscv64_timeouts = {
>    'boston' : 120,
>    'k230' : 120,
> +  'server_ref' : 120,
>    'tuxrun' : 120,
>  }
>  
> @@ -15,6 +16,7 @@ tests_riscv64_system_thorough = [
>    'endianness',
>    'boston',
>    'k230',
> +  'server_ref',
>    'sifive_u',
>    'tt_atlantis',
>    'tuxrun',
> diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
> index 0f8beb7e7a..367e131164 100755
> --- a/tests/functional/riscv64/test_opensbi.py
> +++ b/tests/functional/riscv64/test_opensbi.py
> @@ -36,5 +36,9 @@ def test_riscv_virt(self):
>          self.set_machine('virt')
>          self.boot_opensbi()
>  
> +    def test_riscv_server_ref(self):
> +        self.set_machine('riscv-server-ref')
> +        self.boot_opensbi()
> +
>  if __name__ == '__main__':
>      QemuSystemTest.main()
> diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
> new file mode 100755
> index 0000000000..ad29094dbe
> --- /dev/null
> +++ b/tests/functional/riscv64/test_server_ref.py
> @@ -0,0 +1,90 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +"""
> +riscv-server-ref board test
> +"""
> +
> +import os
> +import tempfile
> +import subprocess
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import skipIfMissingCommands
> +
> +class RiscvServerRefTest(QemuSystemTest):
> +    """
> +    Test the riscv-server-ref board
> +    """
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
> +         'master/riscv/images/virt64/buildroot/Image'),
> +        '6bacc876c769c1bb6057d2bf549eba67fbe83916e8223f9fe21c8e8fff665a36')
> +
> +    ASSET_ROOTFS = Asset(
> +        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
> +         'master/riscv/images/virt64/buildroot/rootfs.ext2'),
> +        'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
> +
> +    def do_test_boot_linux_test(self, tpmstate_dir=None):
> +        self.set_machine('riscv-server-ref')
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.ASSET_ROOTFS.fetch()
> +
> +        self.vm.add_args('-kernel', kernel_path)
> +        self.vm.add_args('-append', 'rw rootwait root=/dev/sda')
> +        self.vm.add_args('-drive',
> +            f'file={rootfs_path},format=raw,id=hd0,snapshot=on,if=none')
> +        self.vm.add_args('-device', 'ich9-ahci,id=ahci0')
> +        self.vm.add_args('-device', 'ide-hd,drive=hd0,bus=ahci0.0')

Any reason not to use nvme here like the documented command line does? We
could drop AHCI in that case.

Thanks,
drew

