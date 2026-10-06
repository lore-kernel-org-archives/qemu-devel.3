Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4721FCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAB-0002js-OJ; Wed, 07 Oct 2026 04:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEII6-0002sG-5N
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:26:13 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIHz-0005Ua-Th
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:26:01 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so2111617a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791343537; x=1791948337; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uBan2vPnuxZmPsBXKSBaOr/VE/70/QAtNwrFSmFxYy0=;
 b=LSvi0qHZmrdRBYi34E08J7mBjbRsJR6CVgWqxaJHeMXnMOdlG7/2MgepkPC4LUtD8r
 N4VRQSQ+6nXploSgunF4nsjvkkFP1WbDLKkhzZXILTeUiSqbXUp+IXdSBxeutTVAgfIT
 qI7CjA5X7CKbdX08iUE50DOiSYhAt5tYvlFXcS1PtS0LX0wfI89Lnl/VoQjVzrtChO6V
 tiWhNDXkJaPeB70vtd4/7DElraD5k2z1Z8GqmfBfMbA70oXLlPoxdiLMQbrJ7gnQ2Pvg
 /XfgnMEnNwM75b/AbOTk0TZSklJez5B+XG6PJeERSKoXZaEaeysZlHmd+YPXQYlI0IBt
 /tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791343537; x=1791948337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uBan2vPnuxZmPsBXKSBaOr/VE/70/QAtNwrFSmFxYy0=;
 b=wdHE/NQ6/mLjIrnE/duJNA7xwihFXbfyLKYBZMqr4H95bh5lTE027UB7SPCsQ6ye8R
 G7j6G75mFc3pRZiyuIouQtLIIRr9GN5BR+rfIoNpJyIGcfYVepaUUAkoVDl4y1nl2VqA
 pxog4TBUBoCSTEJL/aG0eJ3an4dqSDPYaSJptd0lIiDxI4S7Id1yCf2IuImE6vzXj7bb
 0vZeU1FVlFqkfMqkV1j1bSDnPKUqY650MdHHzkzLHZk+M1ZStuRYTrDxqJa3q06+HEtP
 8z9Y8g9WlF49LgzMKxk/Rt596irMYGtP5tYUWXWjkDpLMMzyZnWbtgAPsCHXbzzF4ocn
 j20g==
X-Gm-Message-State: AFuF++kxk8liqi+kX1bFODEP1uYuf6k7EXA/LFS7HL0m28J0En9WIobl
 ekvZkKo95X21GfaBa+qiP1XChAfll1nVOUGG0xHyFgcpXCA9LaZBr9me2C7zBg==
X-Gm-Gg: AYBFou2P0KJdzh0uDo9qK8cakTW4yO6pnY892q8118V0yrhGD67XYTrzzdkmx+orzNH
 lFpzYk9X87yXaAeDm0/1wGU9wdrpxFSELnMRbd5+hMZeP68TeCrySj7vYi8f02zeVNH6cNKvA1N
 Dr3GxFWoQctsT5XO4wtEwtrlQsQmmEgqh///103J3Gd/sa2Phk/apSOSUt6vEEmofu/oSh8W9bS
 8Sz3JDK0P2Tg30THyNesP+sMoN/l9ljMj0QIIJM+0Jyq9YI8Qty1ZTpp1QFaH1fn3o5OpiHV9Qo
 uwr+lgk0GFovKyEo9FDLj9eGePItWIJW6ioFY8DFf+rJJnuEyCUxemn0lUYdlvqVchGL3EBjgHA
 tCM/FovYRmX/QNdzQhManE3vEyWCpJAz2og+m5GKGiJZpe4HOru3S7eYg71ZUqsTfYPfOTmdxmJ
 O1B/+R47v6lRMPdhjn1qkBEYPIi4GVhdfvwCqdYtlnWkVemGA+7DBaTiSoN/fr00YSnUAHH47VH
 CmaFEEVzm7oSThzWdkJ2d0zknyOwluVeeqNHg==
X-Received: by 2002:a05:6000:1448:b0:48b:1ed:db34 with SMTP id
 ffacd0b85a97d-48c6d1a5623mr1205063f8f.45.1791275726892; 
 Tue, 06 Oct 2026 01:35:26 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:26 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 06/31] docs,
 tests/functional: Drop redundant CLI arguments in imx8m*-evk
 invocations
Date: Tue,  6 Oct 2026 10:34:18 +0200
Message-ID: <20261006083445.30362-7-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Both boards provide defaults matching real hardware. No need to ask
users to repeat these. Also, remove these redundant arguments from the
functional tests such that the defaults get tested.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8m.rst                   | 2 +-
 tests/functional/aarch64/test_imx8mm_evk.py | 4 +---
 tests/functional/aarch64/test_imx8mp_evk.py | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index 1bcb8255be..5348757089 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -79,7 +79,7 @@ For i.MX 8M Mini EVK:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 2G \
+  $ qemu-system-aarch64 -M imx8mm-evk \
       -display none -serial null -serial stdio \
       -kernel Image \
       -dtb imx8mm-evk.dtb \
diff --git a/tests/functional/aarch64/test_imx8mm_evk.py b/tests/functional/aarch64/test_imx8mm_evk.py
index 86725991f1..73d286167c 100755
--- a/tests/functional/aarch64/test_imx8mm_evk.py
+++ b/tests/functional/aarch64/test_imx8mm_evk.py
@@ -52,9 +52,7 @@ def test_aarch64_imx8mm_evk_usdhc(self):
         self.require_accelerator("tcg")
         self.set_machine('imx8mm-evk')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-m', '2G',
-                         '-smp', '4',
-                         '-kernel', self.kernel_path,
+        self.vm.add_args('-kernel', self.kernel_path,
                          '-initrd', self.initrd_path,
                          '-dtb', self.dtb_path,
                          '-append', 'root=/dev/mmcblk2p1',
diff --git a/tests/functional/aarch64/test_imx8mp_evk.py b/tests/functional/aarch64/test_imx8mp_evk.py
index 99ddcdef83..2ec421c326 100755
--- a/tests/functional/aarch64/test_imx8mp_evk.py
+++ b/tests/functional/aarch64/test_imx8mp_evk.py
@@ -52,9 +52,7 @@ def test_aarch64_imx8mp_evk_usdhc(self):
         self.require_accelerator("tcg")
         self.set_machine('imx8mp-evk')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-m', '2G',
-                         '-smp', '4',
-                         '-kernel', self.kernel_path,
+        self.vm.add_args('-kernel', self.kernel_path,
                          '-initrd', self.initrd_path,
                          '-dtb', self.dtb_path,
                          '-append', 'root=/dev/mmcblk2p1',
-- 
2.56.0


