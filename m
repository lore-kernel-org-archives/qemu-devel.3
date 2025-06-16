Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2963BC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRC7H-0001BB-Ny; Mon, 16 Jun 2025 11:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uRC7F-0001Ax-Ua
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:51:22 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uRC77-0003js-L0
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:51:21 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 48B4B737B
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1750089039;
 cv=none;
 b=v80Gs3U/4YCsy/h5DMXcd+UQ3RuBFEe66HJejp3CdJ9d1p15beWNJez+yMxwaizH0OAzkaXnntby3NzWjPU4QnfJZCndlUSv3WcXMCVZe3DEyI8BsmA1mz0JiBoghsNi9O0qOvhoYpRo5f+2bhkSgDpya0E1MGT5Rr5lJXRvxWyP5yQOE1oGa0Th9Jp7+cdT7gNiT05jClyGf6A8zsczZK9vUKEbJh/pteeLDTljCKlZxp84b9AgQIbStkVss98aAWECcmgPBlFd83LizTNiIKyoyq0LEM411IC8BMKL1CtVOIIxMM+1h80mpE9fFXTqzgWsxmXtPsZUF4AfrkExgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1750089039; c=relaxed/simple;
 bh=wOUJ/zaiQlCj3siK0vTD1Gt0EpD0c1WOUtaCYr30hIo=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=pOuL/etpx68cFYWh2XGMKQrDqGJT4CNfL634c3Lol6SeVjdqeyIYFVzHZWXGEVWdLXwEMQdrE7W6eX/TneOGsb/t+4D3aKUG822um0lWFWIV1sAsSHCzwg0oH1EE2g+SQwSo4E3B2rBeFw9zBWuTxBD29Ld9Oui2vOH8r2alCYIdKhLDTZfEdB9dJCL7Hdgxi23iV4/uLPNEbwkFqh7ZefFYC9qoXUUjOFvRmCBrrYuAQnry5VQ+pRlDO+rGVIvj8Eqbjn+1utmZWvKi3NzcWCP7s7VUwXArMUgnsqWzimfC7zPZVPH5KI8woupH35dLwirlYZwJHqxRwgwZK0bUAQ==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1750089039;
 bh=wOUJ/zaiQlCj3siK0vTD1Gt0EpD0c1WOUtaCYr30hIo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f28paViscSp+3dC0awPhX08mOIH05nFfznCrfT0DjcP00fIffSWU2isg88yfcLhPT
 ZTN0woOdvAL/1x7hWH608TiFAfbludthb6yiAZSOmwTamr3E0Af5coffT90PL+s8vi
 nHXivSbqOQpaSp6LbGe8atqf0yb/8QCDJ+uTFuKlWFxCpMgPNRmuNSMgiTLio9nRD9
 AHMlFY30n24pnnSOSqsX9+7LQFWtVkyMWcYyBr23iquAvFdFKbX6EdXT3TbENwuRLm
 TCxSzyJjd2/6Mm0EmAZfH6W1X+zdzqJeZqUui0z648jabfQnkQbEijSCmrKkYNbN/b
 3nhTawItZwjyg==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 48B4B737B;
 Mon, 16 Jun 2025 23:50:36 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH 4/6] MAINTAINERS: fix VMware filename typo (vwm -> vmw)
Date: Mon, 16 Jun 2025 11:50:10 -0400
Message-ID: <20250616.qemu.relocated.04@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616.qemu.relocated@sean.taipei>
References: <20250616.qemu.relocated@sean.taipei>
MIME-Version: 1.0
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The entry for the VMware PVSCSI spec uses "vwm" instead of "vmw",
which does not match any file in the tree.

Correct the path so scripts/get_maintainer.pl can match the file.

Signed-off-by: Sean Wei <me@sean.taipei>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7428217361..ad82fa4d9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2539,7 +2539,7 @@ F: pc-bios/efi-vmxnet3.rom
 F: pc-bios/vgabios-vmware.bin
 F: roms/config.vga-vmware
 F: tests/qtest/vmxnet3-test.c
-F: docs/specs/vwm_pvscsi-spec.rst
+F: docs/specs/vmw_pvscsi-spec.rst
 
 Rocker
 M: Jiri Pirko <jiri@resnulli.us>
-- 
2.49.0


