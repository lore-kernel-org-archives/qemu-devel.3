Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F30BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ree1u-0006wa-Bf; Mon, 26 Feb 2024 11:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ree1s-0006qo-D7
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:40:36 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ree1m-0004iT-SO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:40:35 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56454c695e6so5792714a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708965629; x=1709570429; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OeA7zoj/+JYyg7kFDPC8LPBeMuXP/XzZt1UdIvovbl8=;
 b=OTvxIOTg5prjaUpNTlaMYOzuaco+4D+kyQ+O6TVMcJzsD8rvm1Xs/63tVDKDaAMqxU
 o5gsLyXJXc7RfUnZmjYHO34DnZAbYZ6VFv4iVWAEVq1LN+54ppWyoGehG1YeAMiAjq3N
 2EPKUKrQHZW04BhQN8Lg5AtCjQvCEFebti7vP218DfYNJtBRO4Ix4bld0GkRFH/39bH2
 8TSzUSOXnb6HIKH5M/fWKHCSomUv68pssJqk7aIWBEZLu0elEvvohPR63vjdQCDGOo2b
 gx8dcl7uy6xU1NvC06zXPS/sXS7nOEc2Cda6ZBf6scmk5EO0iniTrX3WIpqTH83ghOqk
 iC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708965629; x=1709570429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OeA7zoj/+JYyg7kFDPC8LPBeMuXP/XzZt1UdIvovbl8=;
 b=jTT8KNUCFLqicQR3sR/oiev9jR7RSnWS1oW2Qg7qzn+X7oU1vjzu7CKJUgaQB66aUz
 OZSaMy17RyrQnkeGz770SLXQtZS8Ywj+VCyUqg3eOV9C3VNbrOdl5FWtvrq4xxq0cyLu
 qneuHp2EuNjwouIQpnVokv1XnRwnWqFmyfn5ygKTR5YlGJ6Qw6a06oRNkDhx/G+A7BPh
 Q3f9Zj24naClJNP6VRaRRLS47rqcJ5iDISo0lftsZdjBJ0MfA0bqAe+ENvdhLl6zROrR
 S4lg1eUqhEKrB9j47ycBiJtBjgfobo6jGX8O9UmKRRpFqwsi20R2pyzG4pe9ft6S0Rcn
 SuOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaFoNx7hztjQA97ZqzsRghOhp4fZUZuJKBYocrdi1y+nfIszoubFipLbV93GDkmTpWqEXe4Qv/l50chKxJEqyNcHEtzqQ=
X-Gm-Message-State: AOJu0Yx6QcD+sG/NRjd0truoIH6YTQaDEjENL0A3cnvAJBhRJhehrlW4
 EJa/YI62TYuUgf90cTEXMxbp7HCP7j+ZbfzIkmvK0TdYzX4MCsDrlxMVtiu+VKM9U1AGw9FbNED
 3CP8Kn3xCmIAhEvZ9e4yASJ/UIflI/dcx555awfdjNC5zaC4L
X-Google-Smtp-Source: AGHT+IFZXs9nB2a08Wo5q5HVHwd9vgRF2ND6uwi3OFz6a0qE/KOEmjbAJazkppRhtNOikWCUcnCqbQqLzabyJefIeF8=
X-Received: by 2002:a05:6402:5004:b0:564:4211:faa3 with SMTP id
 p4-20020a056402500400b005644211faa3mr7358928eda.1.1708965628995; Mon, 26 Feb
 2024 08:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-31-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-31-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:40:17 +0000
Message-ID: <CAFEAcA-hXz80bMA3anadAO3fQAM=MA29CefM4yjXp4_b9R7w2Q@mail.gmail.com>
Subject: Re: [PATCH v6 30/41] Add Rpi4b boot tests
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 00:05, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/avocado/boot_linux_console.py | 92 +++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)

I think it would be good to get the base rpi4b support upstream
now (all those parts are reviewed), and then land the ethernet
and PCI support afterwards, rather than holding up most of the
patchset while we work on the PCI/ethernet patches. That will
mean we can definitely get something at least into QEMU 9.0
(softfreeze is 12 March), will reduce the size of the patchset
a lot, and get the refactoring changes in the early patches
upstream, reducing the potential for conflicts on rebase for you.

To that end, my proposal is to take from this series
patches 1-12, 18, and 30-41, with the following minor
changes to this patch which are necessary to get it to
boot on the "no PCI" version of the machine:

--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -530,13 +530,17 @@ def test_arm_raspi4(self):
                                'dwc_otg.fiq_fsm_enable=0')
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
-                         '-append', kernel_command_line,
-                         '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
-                         '-device', 'usb-kbd,bus=xhci.0')
+                         '-append', kernel_command_line)
+        # When PCI is supported we can add a USB controller:
+        #                '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
+        #                '-device', 'usb-kbd,bus=xhci.0',
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
-        console_pattern = 'Product: QEMU USB Keyboard'
+        # When USB is enabled we can look for this
+        # console_pattern = 'Product: QEMU USB Keyboard'
+        # self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'Waiting for root device'
         self.wait_for_console_pattern(console_pattern)


@@ -578,9 +582,10 @@ def test_arm_raspi4_initrd(self):
                          '-dtb', dtb_path,
                          '-initrd', initrd_path,
                          '-append', kernel_command_line,
-                         '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
-                         '-device', 'usb-kbd,bus=xhci.0',
                          '-no-reboot')
+        # When PCI is supported we can add a USB controller:
+        #                '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
+        #                '-device', 'usb-kbd,bus=xhci.0',
         self.vm.launch()
         self.wait_for_console_pattern('Boot successful.')

I'll also tweak patch 41 to not list PCI and ethernet
as supported yet. We can then undo these changes when we land
PCI and ethernet.

thanks
-- PMM

