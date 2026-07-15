Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD79C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 01:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjoSu-00014y-Ul; Tue, 14 Jul 2026 21:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoSk-000103-9o
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:31:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoSi-0002rl-8Z
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:31:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F0IPvc2171733
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KVYTJ71gUTvAE/YLOOvruhI9yLOA2DZEWvFvnjZK+UA=; b=S1U/1aGSNbIc+G5g
 zJu0az8z0C/+uL7WFFHv0G0UXtbIwnv3y5g7STVxgW+wWE0nghSvoW7XHuhvNPGv
 yijjYMs3f7iqCZKnqCI/sTYRsvdOBa9DBpFt5MIh1f3Qq4qyL3OKXrSPSWrhSamF
 2DHMrh3hIlb5OyADDvoH70NCPbRbdYkGWhqJQZyYeZ1NdWW12AYM0tocvyNKYHwp
 RIsXE+v5AbtXtLztZua9H+5ag2od9uYDXTyveTX9Of/MxzxUzbQ+IjYrvDOVyK5d
 kOV5RL0Mb9Pg+abJIZHDD+GoDVXm2ge9j18IMHU50rzR7jivVzZhAWOyzgrlLB/Y
 /dN6jw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqtgdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:30:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38d7fcd1f66so7274212a91.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784079058; x=1784683858; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KVYTJ71gUTvAE/YLOOvruhI9yLOA2DZEWvFvnjZK+UA=;
 b=fQhq6hWG97cLkeLXWWLCTQVEEOd1QyKlZ3gXSig7UUwsz7drsKjNXwP4X6YA8wlcBm
 mb4uH81UEj1PuYhGAQMn8I6/fHs9G1DdMgj/xWK7PyndYGngTPASy9P4dz+n2kM5Z3dT
 eXGpvZ1xdhW+BAYb9leoOl0gACAG7a/immqrKozMOx5OVRSELDEFlouAq1A0MHaNP3q3
 jtMo0KUv6BZKuNJXNoEo99C/Jsh/Slt5k+VuldGwlzqG1vQvA1mHX8k7QJtGLFmahkze
 sloCsLmt0tJdAU+6YgXkb9ekJich0UQ6h3YOXDZ9DPMUZ4ItrThnLkIASwJnB1jrNdMB
 6W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784079058; x=1784683858;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KVYTJ71gUTvAE/YLOOvruhI9yLOA2DZEWvFvnjZK+UA=;
 b=B3T7jRD1mRvdC5mCohOtFAvkabVexzcv8ayGniDLNH4ng06mVgjHSrjtFYX3UN20EN
 8wUcTO5S914ydAB+lLnYz19+OK4zTAhQzaDAKAC5v/V8Ib9P8vYS60liyMwp+Rk6VOhE
 YUnlmmoXIIrPVbWiJIb1MCss5seJcriEdnhESGxgEwNKL5O22tVsas4XSU+7tMArycxJ
 WtbyUV2SDeAtNEgp/1OK1Bm29kJPxvXna65GH6vIyLYRjvWkIY7dltMI1IZNr2k4hwg7
 82Gw2YHCj4HubwOQvlhI5a2paRHmR94SGjpvljetauTcke9P57hOqSv9Brv07y2g3MbW
 1PRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrndcfUWAx9VLPVPqBZUkxuj4Sn9ENRUBUutZ4Kd0Rdt1eqtkRxCpvVgaOWRBQN8+e86REec9UAydc/@nongnu.org
X-Gm-Message-State: AOJu0Yz7hr14e7fUYeOhSSmNecAcP+2arT6tH8AkB8uGnj5Pt3vr2cpM
 7raycpqfFOCZTZQTfTXpFxXqwQhRvmq7ubc2VCCTTv42fpi74h7KCuUKOW+8T82oFq1uwdm5rhO
 I/0rTOGXbEfwDiyp6M7xWp3FTUNpt3CaM4SiwDnugnBVQ4sg7dxkpV+xK1w==
X-Gm-Gg: AfdE7cmiG4mrbkXQ68YAMcPGbylheKU0fG85aH3qYpC3MRBVDEaLQd5DD9A9XrRw9+F
 w/soYdxd6QNtLzw+/GLiFfCPFmKWWCt6q8lQ0mcYvorDJG1GERmCs9udkGciPG0jtOI+1b3aou6
 ub1NcPdJ+lo4IZD9873C5nbbRu3TehHV0qnUTHFDUw9VvW1UNFM6wVD8AxSEt+uE6nY15Ebf0cW
 DKRss+G729HNDNwOJrpBzsqmTwygTGGsCyL7ZC57vxZinrW2cCqQoqfWAYpEsiQqwOu8gQDVB60
 i6r+V6tLfliK58hfdDKgZ3DgmzDLTIsgLxDEATVI5MVlh8QiVOzlr1rfPEQW4I/5tlc2KTusQP4
 QCY9YGuv5EwJmAJ1iH4o3RTXu8oAiNXLt4ZZuESBGHKRDnghcUC6CQe5TV8mBF69F41/G2Vf+od
 HdheY=
X-Received: by 2002:a17:90a:f950:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-38e1add8ac8mr4259411a91.4.1784079057554; 
 Tue, 14 Jul 2026 18:30:57 -0700 (PDT)
X-Received: by 2002:a17:90a:f950:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-38e1add8ac8mr4259386a91.4.1784079057024; 
 Tue, 14 Jul 2026 18:30:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b0240570sm53148437eec.28.2026.07.14.18.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 18:30:56 -0700 (PDT)
Message-ID: <7b8be124-b5e8-4d29-a6c9-8aa3e5716a52@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 18:30:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tests/functional/hexagon: add arch_tests functional
 test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714155126.3509544-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAxMSBTYWx0ZWRfX2YpMIAjJK4Gw
 CPUzN2endgM/lqTyLc4hREyivhyT4iQIb/wLoFb8kmOiVZnmns4X0c9w+0TByzzT2riSMmmftr9
 SfI//mpP+SOeypFfXkv++sRh8enAwImU2DgPUN5fJwygqD2nIJP6WXEhEo71TZOV1ROgjNS3tc+
 oUUEEFrNMiFCLgNePbvckyu+iA6frIm7PiYox1v1/3wDkYAQkFkXaPDAJpwQZg+rJLSh3wawF+y
 wzHOkQNQB01pSWeR762j+9ys8Ddr4g9qQbAN0+1nv9yIB5UfO3dUXtYBobIUA06Eky9rieI32GU
 /g2HRSH5MnPS/+KMsZr/mBtamRa7XlhvxhzNNehmm+BTclMoKMQkbB6jA7gqq3HJjuRNN4U9IZ+
 KxLRmHzzTWN14R81DmK0jnZ6zzWT7DmvTcBQJDxepxkC/H7R9EMCnIh0ilU1xavwpQhjSstMqU+
 s29e2Kj3/xSnWzAUc7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAxMSBTYWx0ZWRfX87czX/Odf7lg
 KiQM8t0eBW1p2FdR7dEPxEVlnF5KSpU/1VU9teT2iTqUhLhpH6ZmgYErbBXYGRmq8c9tAsj9UJf
 w3QOk1ZEohnZWm2ih3J/5PswJx54CTc=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a56e2d2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=7Cha0_PJxengYU1oxksA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 7Og8heF120AMO3eHQMEc1cntBZuXF17m
X-Proofpoint-ORIG-GUID: 7Og8heF120AMO3eHQMEc1cntBZuXF17m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150011
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/14/2026 8:51 AM, Brian Cain wrote:
> Add new test cases from hexagon-arch-tests to exercise exceptions,
> guest mode, interrupt steering, etc.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                                 |  1 +
>  tests/functional/hexagon/meson.build        |  5 ++
>  tests/functional/hexagon/test_arch_tests.py | 65 +++++++++++++++++++++
>  tests/functional/meson.build                |  1 +
>  4 files changed, 72 insertions(+)
>  create mode 100644 tests/functional/hexagon/meson.build
>  create mode 100755 tests/functional/hexagon/test_arch_tests.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8201e487000..a9b134b323e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1361,6 +1361,7 @@ F: hw/hexagon/
>  F: include/hw/hexagon/
>  F: configs/devices/hexagon-softmmu/default.mak
>  F: docs/system/hexagon/
> +F: tests/functional/hexagon/
>  F: docs/devel/hexagon-sys.rst
>  
>  LoongArch Machines
> diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
> new file mode 100644
> index 00000000000..2b5a1a8f264
> --- /dev/null
> +++ b/tests/functional/hexagon/meson.build
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +tests_hexagon_system_thorough = [
> +  'arch_tests',
> +]
> diff --git a/tests/functional/hexagon/test_arch_tests.py b/tests/functional/hexagon/test_arch_tests.py
> new file mode 100755
> index 00000000000..008822d5e5b
> --- /dev/null
> +++ b/tests/functional/hexagon/test_arch_tests.py
> @@ -0,0 +1,65 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test.cmd import wait_for_console_pattern
> +
> +
> +class ArchTestsUart(QemuSystemTest):
> +    """
> +    Hexagon architecture verification tests
> +
> +    These are bare-metal tests from hexagon-arch-tests that exercise
> +    system functionality.
> +
> +    Tests output results via UART.
> +    """
> +    timeout = 60
> +
> +    ASSET_TARBALL = Asset(
> +        "https://github.com/qualcomm/qemu-hexagon-testing/releases/"
> +        "download/v0.2.5/arch_tests_uart.tar.gz",
> +        "edb4f37b877a3a72a0e10920477458a43b40045d34398fee8cb763fefd342f4f",
> +    )
> +
> +    def run_uart_test(self, test_name: str,
> +                      machine: str = "virt") -> None:
> +        """
> +        Run an arch test binary and verify PASS via UART console output.
> +        """
> +        self.set_machine(machine)
> +        self.archive_extract(self.ASSET_TARBALL)
> +        target_bin = os.path.join(self.workdir,
> +                                  'arch_tests_uart_package',
> +                                  'bin', test_name)
> +        self.vm.set_console()
> +        self.set_vm_arg("-display", "none")
> +        self.set_vm_arg("-kernel", target_bin)
> +        self.vm.launch()
> +        wait_for_console_pattern(self, "PASS")
> +
> +    def test_exceptions(self) -> None:
> +        """Tests exception delivery for trap instructions, privilege
> +        violations, and verifies SSR cause codes and ELR values.
> +        """
> +        self.run_uart_test("test_exceptions")
> +
> +    def test_guest_mode(self) -> None:
> +        """Tests guest mode entry/exit via CCR configuration, verifying
> +        GSR fields, GELR, and guest event vector table dispatch.
> +        """
> +        self.run_uart_test("test_guest_mode")
> +
> +    def test_int_steering(self) -> None:
> +        """Tests interrupt steering via priority-based routing to
> +        specific threads using STID priority and iassignw.
> +        """
> +        self.run_uart_test("test_int_steering")
> +
> +
> +if __name__ == "__main__":
> +    QemuSystemTest.main()
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index c158197c4b7..c7362dd00ef 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -14,6 +14,7 @@ subdir('aarch64')
>  subdir('alpha')
>  subdir('arm')
>  subdir('avr')
> +subdir('hexagon')
>  subdir('hppa')
>  subdir('i386')
>  subdir('loongarch64')

With the same comment that Daniel did on semihosting series:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

