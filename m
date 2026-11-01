Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CB606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=mj/kChj2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWT9-0004TI-SV; Sun, 01 Nov 2026 09:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNWSz-0004Rz-QM
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:23:26 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNWSw-0007aU-AG
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=IcGSRwcoccQDdisKc79r7UVkewokgafoSbc99lF6Xq8=; b=mj/kChj2Sp5/udbQwmdwnzqCeH
 kSahhZnFEPyRZZNVaiZLkCo9rSPadTATZisHXlpCI3mCfyZsrWRXIp8TPKZgeV9pDj9dbB79bmvzU
 PxJ+25EIKfemBvxrkZxA0E5PBn2xcJ8vgESu08y4ZYLDJyU8/X2coyrBaXkiKXPifIPlC5tWZ3nwj
 OPOO98Q1cpuSlGH80zROlhXJhtBKI//1m5ahTbg8HWMBbqiDE5emN1fk2aJa6uKOEzhICHGhGj01V
 SuMrXrO+eNZSbdyOauZ9awxRfhtHdsykRuSc1uTGhzKRziJrkxTZgT3vw5ZtADG8sQlBeXANJ8YHE
 K8aGMDjP/iyQBwq4XwksYYsmKZaO+8PmHtuqlwxSrVwlyoyV7bV+nNhqnAGi4PQLv4OYYxpoZ1uNI
 K5h+QZaEu3OqNStkvkj5cyeXf/GjIRfT9xr0psGHYcN5/E7h2/hmKxT2PZCZi+x+qNw7uZxHWvR5g
 guX/Bu6MFJqXdRywB4flehUSf5K0UYng6nbfRAqMXX9X8+2B5ha6xwHqWLQekqRPDbIBPYjyo7FWd
 cFIq8T5sHrt0hNMd1FnrW7ZQdDNqnVSKyY2A7oB32kRpaz4yidt8oJnfa1uoK1+aMUdDwyFJLQFSo
 CaX3QYQH8vC33Ribm9uKtKa600ZBneRS4z+v69+Ac=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xNWS7-0055Ed-RZ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 14:22:32 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Sun,  1 Nov 2026 14:22:52 +0000
Message-ID: <20261101142312.983515-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
References: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 2/3] linux-user/sparc: Report HWCAP_SPARC_CRYPTO for crypto CPU
 feature
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stian Halseth <stian@itx.no>

Set HWCAP_SPARC_CRYPTO in AT_HWCAP like Linux does on real hardware
that supports it. qemu-sparc64 defaults to "TI UltraSparc II",
which has no crypto feature, so it must be enabled explicitly,
e.g. -cpu TI-UltraSparc-II,+crypto

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Stian Halseth <stian@itx.no>
Message-ID: <20261028113816.1651212-3-stian@itx.no>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 linux-user/sparc/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 181f1e00b59..04127412857 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -90,6 +90,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
     r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
     r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
+    r |= features & CPU_FEATURE_CRYPTO ? HWCAP_SPARC_CRYPTO : 0;
 #endif
 
     return r;
-- 
2.47.3


