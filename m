Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcwD-00039o-PY; Mon, 29 Jul 2024 22:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sYcwB-00038s-Fb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:50:07 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sYcw9-0004aZ-Jr
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:50:07 -0400
Received: from LT2ubnt.. (ip-109-42-177-119.web.vodafone.de [109.42.177.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 80C2041132; 
 Mon, 29 Jul 2024 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722286297;
 bh=rj9tWCkKgk6gOOGz4iv3h6rinT5FKWXZ0YJMrnsEJ5M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=sO3fO3hjhQyNuRcgO5CpEU3XMWaUPDnuVPyEMSwCt/mTH/abY+JXWx4U7b5R91XYY
 Ijs0J3YJ6CdulAaSZYAHN8stFPzzaLWYvq+UYSiNMu0mlJMwhzQhdewTOHqj1rtw9k
 uiGV3fo/DDHNjR6Y1eRKEkgDiOVxBXicYNpIFQN3oQGDuZA7xhYnuK1z2TMSN4Rpts
 C7mZpMKj5IGPk5huKSWG2KLoUfBGUixWBcBm42lz/ol5OdezBDqgpcqCH5FGmoye5l
 zdOG/SPeM5AwPHXNOAJWmcaIG02fdE/8Pthg/Y8AegDoMwUtVwDowsQcGpwuQvUWA8
 TZpBycRvPFQOA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] qemu-options.hx: correct formatting -smbios type=4
Date: Mon, 29 Jul 2024 22:48:15 +0200
Message-ID: <20240729204816.11905-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.121;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-canonical-1.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

processor-family and processor-id can be assigned independently.

Add missing brackets.

Fixes: b5831d79671c ("smbios: add processor-family option")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 369ae81d7c..b0eb41fbcd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2704,7 +2704,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 3 fields\n"
     "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
-    "              [,processor-family=%d,processor-id=%d]\n"
+    "              [,processor-family=%d][,processor-id=%d]\n"
     "                specify SMBIOS type 4 fields\n"
     "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
     "                specify SMBIOS type 8 fields\n"
-- 
2.45.2


