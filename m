Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D69BC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRC4R-0006uN-E9; Mon, 16 Jun 2025 11:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uRC4M-0006tM-RU
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:48:22 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uRC4G-00033E-U6
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:48:22 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei B78B61551
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1750088893;
 cv=none;
 b=gCeGLaNe0MrtsTT9WzTdNd9XP5SOwe22yh9WnwiE/v3B3s+6hXXeH//qixZPvFB939ru+WiJeJJW5w+sOn1DWZzO1AYNQfPYDr4oR5ldKI1F3lGgLkBMOocchLO8KtI6QM2I9wOE5d5FP9Iyg4lsDLpt4bafyflEuYKZs/qzkCbCzipX4BJTnwUDwRKLlg8ujJKH2W3RrBGOzzmbmUSyR9cfad49Qs5Yi30Tv7cDtsE/uE+pXEHjK71UsGEJup2TrtXMGp/NMA9CTJrCL7c2XTiSVOCSCkvIWLQI6KVodgpm2dThTLEvAvTlmIOrRzVYoaaxxzTfBvY2geLdjZEB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1750088893; c=relaxed/simple;
 bh=2BtpyxabmH3MFcGYk3UBw2NnSfN2FJCjp+X004S+Hs4=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=LDILEgEo5afTn5WTFvPuhVhQdPsTUOkxtoi7wxVIBoB7cap8wWUL8yj9HFsdSQXUew+1zFijq6PpimEg8KTvd5gP6gFrTIeP5y47DEc8f9uvPYeiG6z9XhWYmYP5r+f91IaL3LvhVDuV2A6g5AHlMr0I+XoVj9/yLuq6K5vs+M3hEJlVeZh3uIIXgKI7qjXBbQJgSD2ek9X0xtISYM37zA0cVihKNTlPNks13JNHaBM4QMX9Mvuqy/yEIYQSMp/wWk/gXHh+jmxdV9axg26q+OLryVAnRAGANAJGI0q8cfcJDIvBbjihVAMDueIGL380kZvhVuroExQFEgPmR2/B0w==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1750088892;
 bh=2BtpyxabmH3MFcGYk3UBw2NnSfN2FJCjp+X004S+Hs4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=3kkx2EORtS0CPfr4MwI52qPVjy9YfG3wmZC5/02NtUU7FPsUhB0Vq019MBEHRIwD0
 gSVNyjh80Qw63f2gZL3qNqllOe4NV+/lTJrMncRn64WwMffsU84BJv8wTTUOWmZ2En
 MYjqA6I2c7bwbbxeooaMfs7eb2ZtHxL6Npi/CO+ImoTQV+OzN5V+nf5u6tiZD0hZD9
 Bww6D6SZvMpVqUtwodjhF6XCl4d9VAsVLzzKigp4iUYljcwcA1F66VgnnKlgVE4wfE
 8OGApx88w5kRC4ArfeiOcDhnKIUVyrmtdpyBjv11+p8zeD/aSvzghZn6Mwut4FeqM3
 PISx70wOsUeww==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id B78B61551;
 Mon, 16 Jun 2025 23:48:10 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/6] MAINTAINERS: update docs file extensions (.txt -> .rst)
Date: Mon, 16 Jun 2025 11:47:30 -0400
Message-ID: <20250616.qemu.relocated.01@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616.qemu.relocated@sean.taipei>
References: <20250616.qemu.relocated@sean.taipei>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The documentation tree has been converted to reStructuredText, but
two entries in MAINTAINERS still point to the removed *.txt files.

This prevents scripts/get_maintainer.pl from matching the documents.

Update those entries to *.rst so the maintainer script works again.

Related commits:
  8472cc5dbe6 (Sep 2023): docs/specs/vmw_pvscsi-spec: Convert to rST
  8e72ceee5cd (Jun 2022): Rename docs/specs/fw_cfg.txt to .rst

Signed-off-by: Sean Wei <me@sean.taipei>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28b3dd2684..fed8619874 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2531,7 +2531,7 @@ F: hw/net/net_tx_pkt*
 Vmware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
-F: docs/specs/vmw_pvscsi-spec.txt
+F: docs/specs/vmw_pvscsi-spec.rst
 F: hw/display/vmware_vga.c
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
@@ -2736,7 +2736,7 @@ Firmware configuration (fw_cfg)
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
-F: docs/specs/fw_cfg.txt
+F: docs/specs/fw_cfg.rst
 F: hw/nvram/fw_cfg*.c
 F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
-- 
2.49.0


