Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F2BFD8FF5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 19:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvgt7-0006yU-BA; Thu, 26 Feb 2026 14:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvgt6-0006y6-0i
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:19:04 -0500
Received: from p-west2-cluster4-host4-snip4-5.eps.apple.com ([57.103.69.246]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvgt2-0008FV-PF
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 14:19:03 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 F21B31803C6A; Thu, 26 Feb 2026 19:18:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772133538; x=1774725538;
 bh=wvg7ZkcWshGaGmHEc4Z1dVuu1EY3+pNhauGSu/CAFXA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=c+1AdLbIyjp3zKYpihPbhmSqteifXzksx2L0jGzHmt/BkmuQoCjjAxgjks+cJ2enhK2B+lWEPs7FXA5bwHSHEo1V+agrKzbxj357BXlNR/8VgkdRM54SLp/mPifg+hxtGq/3TB++z7dsezL/VFf5r3cZhBAMDDKYm+mSgnkoZV6DBqmZmqnMf357MVWB/pM3B50IS6/RUoBp1T9+9ByjBPXDcxoOUBL9SDoblTiApY0r8BGNMGtgLWbzlE4tReVnJPVgghuyvq8R6U4Rtr7geffCtPwCF8YifLHiDGu5xb9wMGUggGL0KENkuzskapnlmCrPnwzjPIHK1JvG/42SJQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 5B95318000B8; Thu, 26 Feb 2026 19:18:54 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 7/7] tests/functional: add Arm VBSA uefi conformance
 test
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260226185303.1920021-8-alex.bennee@linaro.org>
Date: Thu, 26 Feb 2026 20:18:42 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2910C717-3002-42CC-AF54-E1ECCB71F229@unpredictable.fr>
References: <20260226185303.1920021-1-alex.bennee@linaro.org>
 <20260226185303.1920021-8-alex.bennee@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3NyBTYWx0ZWRfX4EtgP1SDPMwA
 C4RtQYLjPh/8pY/TMlTMffmg7GZ4WFWyLYvjhgaqtzbKOgIzPj1Kf9r2sorUbQfKCpBDExcGByi
 cZ7if3NeTHJNaoAfGLt4sWgRGZEEWxGK36/BL6tgL4ija5h7OibqHIeOj19y3PJsyV3LUe4pEGa
 0p6wHPhbhpfBKlpKKdslIVdOWkwKgQSkQRpNeyA8SUACkCXChQtyhrZXklcx6K/dbdiXKWsR+P6
 cB+v2xdY81v+C3JJsL0hFNY2j5IlqKX9OOluvrRMN4pPtu4AlTrYfZmJeCdvKlhwvqYs+zJcTiW
 pid5vYK1ZupejyjovJlpA2VqZRKhlE2Y5otIyj2PuhTepkKC0fFPIcucMz1SgQ=
X-Proofpoint-GUID: GvdY3nJN7jRSfqxImcWwCIHmXM3PfUru
X-Authority-Info-Out: v=2.4 cv=C5jkCAP+ c=1 sm=1 tr=0 ts=69a09ca2
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=dZygtNjCWsLqK4uoJFgA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GvdY3nJN7jRSfqxImcWwCIHmXM3PfUru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1030 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260177
X-JNJ: AAAAAAABx/NEvHOTr6yVoAnPU6DIbrMPAKn+C/uBdj1D/NFwJbOJ6PLj1q9cqACyDqlzbIre2rWduCteMH3eXZSqV4bJaW3f9nDbQsdBhX7ptU+Dfn0rpzpnL9W7UF14aUmYXM/YrZl/FIYmZl3g/a9s3CNVEFY7tMHHHIolFhWgmbEe8DLJnrInKYSdcqWveZK2qQlOqLWVRHruaLmY/W27L2bBjFM8mzr6SaItlDTlCkMEd1Hjxs3YObj0yDbkxKUjo1Bc2oWl1bAYkreSUAPWZFMMTsJXaOCrUc9iF/flzNTrICqii5vbehJToep8Ir+WiQtvuE6Jr6oIMrTzQfk/F9S/OVy87D61F3V3sfb64r11rOnpMF6VbNHGfxZz0aIBXZE///iudFZ+J+6IwlnLk+GHA1lxHqAjHS7NIjyvJf7wA9JFIeKAAG7Rw7NkXDix4AFBtXYpp8OtXqBo/2WY7KDgv5UF6mVH/iXHFSQQMWe38yndo37BgVwe7eWKGFfUMukP9kno01Te74/q1Hz9MDIwt9UlhKYJeN5UVEqlqaaeVzk6yqmrJexNBxch1BRFBKzaQncWTe50kuEggUQJEcNhkVlwbEXUT+hAKf3wjszFYt9GlDV2kMy1DvY+yYOk4UACijptPAiE2lgR77bAnZvOaVgA/jX+bTaw6NDcu1RKDddaOk7haxiPreh2+zXLA9BbBYqQdorJ7BjWmw9WGPxqTWH9nhjic8JT7VdivW8=
Received-SPF: pass client-ip=57.103.69.246;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 26. Feb 2026, at 19:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> The VBSA test is a subset of the wider Arm architecture compliance
> suites (ACS) which validate machines meet particular minimum set of
> requirements. The VBSA is for virtual machines so it makes sense we
> should check the -M virt machine is compliant.
>=20
> Fortunately there are prebuilt binaries published via github so all we
> need to do is build an EFI partition and place things in the right
> place.
>=20
> There are some additional Linux based tests which are left for later.
>=20
> Message-ID: <20260213154859.1551283-7-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> v2
>  - use the VBSA prebuilt shell
>  - fail the test if we see FAILED in the console stream
> ---
> tests/functional/aarch64/meson.build       |  1 +
> tests/functional/aarch64/test_virt_vbsa.py | 99 ++++++++++++++++++++++
> 2 files changed, 100 insertions(+)
> create mode 100755 tests/functional/aarch64/test_virt_vbsa.py
>=20
> diff --git a/tests/functional/aarch64/meson.build =
b/tests/functional/aarch64/meson.build
> index 49eca120589..7ea8c22b048 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -46,6 +46,7 @@ tests_aarch64_system_thorough =3D [
>   'tuxrun',
>   'virt',
>   'virt_gpu',
> +  'virt_vbsa',
>   'xen',
>   'xlnx_versal',
> ]
> diff --git a/tests/functional/aarch64/test_virt_vbsa.py =
b/tests/functional/aarch64/test_virt_vbsa.py
> new file mode 100755
> index 00000000000..3da06904ea9
> --- /dev/null
> +++ b/tests/functional/aarch64/test_virt_vbsa.py
> @@ -0,0 +1,99 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that runs the Arm VBSA conformance tests.
> +#
> +# Copyright (c) 2026 Linaro Ltd.
> +#
> +# Author:
> +#  Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import shutil
> +from subprocess import check_call, DEVNULL
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern, get_qemu_img, =
skipIfMissingCommands
> +from qemu_test import exec_command_and_wait_for_pattern as =
ec_and_wait
> +
> +
> +@skipIfMissingCommands("mformat", "mcopy", "mmd")
> +class Aarch64VirtMachine(QemuSystemTest):
> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> +    timeout =3D 360
> +
> +    def wait_for_console_pattern(self, success_message, vm=3DNone):
> +        wait_for_console_pattern(self, success_message,
> +                                 failure_message=3D'FAILED',
> +                                 vm=3Dvm)
> +
> +    ASSET_VBSA_EFI =3D =
Asset('https://github.com/ARM-software/sysarch-acs/raw/refs/heads/main'
> +                           =
'/prebuilt_images/VBSA/v25.12_VBSA_0.7.0/Vbsa.efi',
> +                           =
'80f37d2fb86d152d95dec4d05ff099c9e47ee8a89314268e08056b0e1359e1fa')
> +
> +    ASSET_BSA_SHELL =3D =
Asset('https://github.com/ARM-software/sysarch-acs/raw/refs/heads/main'
> +                            =
'/prebuilt_images/VBSA/v25.12_VBSA_0.7.0/Shell.efi',
> +                            =
'e526604f0d329b481c6a1f62f7a0db8ea24ce8178b2c6abda8e247425f38775c')
> +
> +    def test_aarch64_vbsa_uefi_tests(self):
> +        """
> +        Launch the UEFI based VBSA test from an EFI file-system
> +        """
> +
> +        self.vm.set_console()
> +
> +        # virt machine wi
> +        self.set_machine('virt')
> +        self.vm.add_args('-M', =
'virt,gic-version=3Dmax,virtualization=3Don')
> +        self.vm.add_args('-cpu', 'max','-m', '1024')
> +
> +        # We will use the QEMU firmware blobs to boot
> +        code_path =3D self.build_file('pc-bios', =
'edk2-aarch64-code.fd')
> +        vars_source =3D self.build_file('pc-bios', =
'edk2-arm-vars.fd')
> +        vars_path =3D self.scratch_file('vars.fd')
> +        shutil.copy(vars_source, vars_path)
> +
> +        self.vm.add_args('-drive', =
f'if=3Dpflash,format=3Draw,readonly=3Don,file=3D{code_path}')
> +        self.vm.add_args('-drive', =
f'if=3Dpflash,format=3Draw,file=3D{vars_path}')
> +
> +        # Build an EFI FAT32 file-system for the UEFI tests
> +        vbsa_efi =3D self.ASSET_VBSA_EFI.fetch()
> +        bsa_shell =3D self.ASSET_BSA_SHELL.fetch()
> +
> +        img_path =3D self.scratch_file('vbsa.img')
> +        qemu_img =3D get_qemu_img(self)
> +        check_call([qemu_img, 'create', '-f', 'raw', img_path, =
'64M'],
> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
> +
> +        check_call(['mformat', '-i', img_path, '-v', 'VBSA', '::'],
> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
> +
> +        check_call(['mmd', '-i', img_path, '::/EFI'],
> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
> +
> +        check_call(['mmd', '-i', img_path, '::/EFI/BOOT'],
> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
> +
> +        check_call(['mcopy', '-i', img_path, bsa_shell, =
'::/EFI/BOOT/BOOTAA64.EFI'],
> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
> +
> +        check_call(['mcopy', '-i', img_path, vbsa_efi, =
'::/Vbsa.efi'],
> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
> +
> +        self.vm.add_args('-drive', =
f'file=3D{img_path},format=3Draw,if=3Dnone,id=3Ddrive0')
> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=3Ddrive0')
> +
> +        self.vm.launch()
> +
> +        # wait for EFI prompt
> +        self.wait_for_console_pattern('Shell>')
> +
> +        # Start the VBSA tests
> +        ec_and_wait(self, "FS0:Vbsa.efi", 'VBSA Architecture =
Compliance Suite')
> +
> +        # could we parse the summary somehow?
> +
> +        self.wait_for_console_pattern('VBSA tests complete. Reset the =
system.')
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()
> --=20
> 2.47.3
>=20
>=20


