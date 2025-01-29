Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D10DC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdBxY-0007Wx-UG; Wed, 29 Jan 2025 12:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdBxU-0007UA-Tl; Wed, 29 Jan 2025 12:34:36 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdBxS-00027H-7V; Wed, 29 Jan 2025 12:34:36 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE4BD4E6019;
 Wed, 29 Jan 2025 18:34:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id b0z7Vw4jPtDw; Wed, 29 Jan 2025 18:34:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9CDEC4E6014; Wed, 29 Jan 2025 18:34:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9AD0374577C;
 Wed, 29 Jan 2025 18:34:28 +0100 (CET)
Date: Wed, 29 Jan 2025 18:34:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] tests/functional: Extend PPC 40p test with Linux boot
In-Reply-To: <20250129104844.1322100-1-clg@redhat.com>
Message-ID: <ed16ce9d-f750-83c5-d2c0-f2fcb4c860b3@eik.bme.hu>
References: <20250129104844.1322100-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1207541628-1738172068=:21657"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1207541628-1738172068=:21657
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 29 Jan 2025, Cédric Le Goater wrote:
> Fetch the cdrom image for the IBM 6015 PReP PowerPC machine hosted on
> the Juneau Linux Users Group site, boot and check Linux version.

Not related to this patch just by the way, I've noticed that the rom image 
is loaded from within hw/pci-host/raven.c instead of hw/ppc/prep.c which 
is odd and unlike other machines. Is there a reason for that?

Regards,
BALATON Zoltan

> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
> Changes in v2:
>
> - Kept the 2 empty lines lines between the imports and the class
>   statements
>
> tests/functional/test_ppc_40p.py | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
> diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
> index 7a74e0cca70b..614972a7eb38 100755
> --- a/tests/functional/test_ppc_40p.py
> +++ b/tests/functional/test_ppc_40p.py
> @@ -9,6 +9,7 @@
>
> from qemu_test import QemuSystemTest, Asset
> from qemu_test import wait_for_console_pattern, skipUntrustedTest
> +from qemu_test import exec_command_and_wait_for_pattern
>
>
> class IbmPrep40pMachine(QemuSystemTest):
> @@ -72,5 +73,22 @@ def test_openbios_and_netbsd(self):
>         self.vm.launch()
>         wait_for_console_pattern(self, 'NetBSD/prep BOOT, Revision 1.9')
>
> +    ASSET_40P_SANDALFOOT = Asset(
> +        'http://www.juneau-lug.org/zImage.initrd.sandalfoot',
> +        '749ab02f576c6dc8f33b9fb022ecb44bf6a35a0472f2ea6a5e9956bc15933901')
> +
> +    def test_openbios_and_linux(self):
> +        self.set_machine('40p')
> +        self.require_accelerator("tcg")
> +        drive_path = self.ASSET_40P_SANDALFOOT.fetch()
> +        self.vm.set_console()
> +        self.vm.add_args('-cdrom', drive_path,
> +                         '-boot', 'd')
> +
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Please press Enter to activate this console.')
> +        exec_command_and_wait_for_pattern(self, '\012', '#')
> +        exec_command_and_wait_for_pattern(self, 'uname -a', 'Linux ppc 2.4.18')
> +
> if __name__ == '__main__':
>     QemuSystemTest.main()
>
--3866299591-1207541628-1738172068=:21657--

