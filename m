Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F5AC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 23:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfSpm-0005We-Vj; Wed, 28 Feb 2024 17:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfSpb-0005TS-Q8; Wed, 28 Feb 2024 17:55:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfSpY-0000Yj-Le; Wed, 28 Feb 2024 17:55:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D2F735180D;
 Thu, 29 Feb 2024 01:55:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 444228BB40;
 Thu, 29 Feb 2024 01:54:56 +0300 (MSK)
Received: (nullmailer pid 274137 invoked by uid 1000);
 Wed, 28 Feb 2024 22:54:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 68/78] update edk2 binaries to edk2-stable202402
Date: Thu, 29 Feb 2024 01:54:44 +0300
Message-Id: <20240228225455.274062-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240229000326@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240229000326@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 658178c3d4e95b3f4106e25ec5a209356e339032)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/edk2-aarch64-code.fd.bz2 b/pc-bios/edk2-aarch64-code.fd.bz2
index fdcf89022a..5d0a57173d 100644
Binary files a/pc-bios/edk2-aarch64-code.fd.bz2 and b/pc-bios/edk2-aarch64-code.fd.bz2 differ
diff --git a/pc-bios/edk2-arm-code.fd.bz2 b/pc-bios/edk2-arm-code.fd.bz2
index 9d829f4f08..af49559f34 100644
Binary files a/pc-bios/edk2-arm-code.fd.bz2 and b/pc-bios/edk2-arm-code.fd.bz2 differ
diff --git a/pc-bios/edk2-i386-code.fd.bz2 b/pc-bios/edk2-i386-code.fd.bz2
index 1a9d392574..ecd0c6b1ae 100644
Binary files a/pc-bios/edk2-i386-code.fd.bz2 and b/pc-bios/edk2-i386-code.fd.bz2 differ
diff --git a/pc-bios/edk2-i386-secure-code.fd.bz2 b/pc-bios/edk2-i386-secure-code.fd.bz2
index fab0a77b30..983e1778c4 100644
Binary files a/pc-bios/edk2-i386-secure-code.fd.bz2 and b/pc-bios/edk2-i386-secure-code.fd.bz2 differ
diff --git a/pc-bios/edk2-riscv-code.fd.bz2 b/pc-bios/edk2-riscv-code.fd.bz2
index 6394fbfff3..b6cd3c6f74 100644
Binary files a/pc-bios/edk2-riscv-code.fd.bz2 and b/pc-bios/edk2-riscv-code.fd.bz2 differ
diff --git a/pc-bios/edk2-riscv-vars.fd.bz2 b/pc-bios/edk2-riscv-vars.fd.bz2
index 40da6591ad..36435a1046 100644
Binary files a/pc-bios/edk2-riscv-vars.fd.bz2 and b/pc-bios/edk2-riscv-vars.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-code.fd.bz2 b/pc-bios/edk2-x86_64-code.fd.bz2
index 0d325bd483..8707f695ef 100644
Binary files a/pc-bios/edk2-x86_64-code.fd.bz2 and b/pc-bios/edk2-x86_64-code.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-microvm.fd.bz2 b/pc-bios/edk2-x86_64-microvm.fd.bz2
index 829429082b..334da49917 100644
Binary files a/pc-bios/edk2-x86_64-microvm.fd.bz2 and b/pc-bios/edk2-x86_64-microvm.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-secure-code.fd.bz2 b/pc-bios/edk2-x86_64-secure-code.fd.bz2
index c6b039819c..abeb60bcf3 100644
Binary files a/pc-bios/edk2-x86_64-secure-code.fd.bz2 and b/pc-bios/edk2-x86_64-secure-code.fd.bz2 differ
-- 
2.39.2


