Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC67AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifp3-0004PW-Hk; Sat, 11 Jul 2026 18:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifov-0004GV-1F; Sat, 11 Jul 2026 18:05:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifot-0000Ob-3A; Sat, 11 Jul 2026 18:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=lzzsv4m1zYxGpON0TV3+c+SD41VQNEXYLR39VzUql+c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hRx3mORz0aqPXwIR9IF9V3sEnfMywZekgryHf5UHx5U1Sd11O/ag4YScJI/VMQq74
 cIfeKCv4zQ1Up7z1lRI+pSnKlCKRPN535Mwnsg7bV73/+drppUUobguuiu+iN9E1KZ
 nqt7W+MzKfbTA+JvXg+cXSnhbicXnXyBT4SfDHoKgi4HcKpQabGBZfxyU8dval3zUM
 n7JqN+0W6CWsjZMIf83+LrYgPD3lyxF2EqVIKnufAd8mBsnJW+QqrBmNg54k+qw/0q
 hy1A5BGueWgrW0QIwh11k7wYN/3rTd9nGgfz8clOejH+siVT5Hp5RhnftQuEX2hann
 8arOQBxOsNKdQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 68B991C0AC4;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1F5833EAF4F;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C09D713355; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 57/81] scsi: adjust error_prepend() formatting
Date: Sun, 12 Jul 2026 00:58:35 +0300
Message-ID: <20260711215904.3757-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The error strings will be concatenated so add a separator to make the
combined error message easy to read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260401171927.396672-2-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 15c57ac351ccb4af625cd7dc582831f472c1a68f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index a2316a5266e..b55d0683238 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -439,7 +439,7 @@ static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Error **errp)
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
                      buf, sizeof(buf), s->io_timeout, errp);
     if (ret < 0) {
-        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER");
+        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER: ");
         return false;
     }
     return true;
@@ -463,7 +463,7 @@ static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key,
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
                      buf, sizeof(buf), s->io_timeout, errp);
     if (ret < 0) {
-        error_prepend(errp, "PERSISTENT RESERVE OUT with PREEMPT");
+        error_prepend(errp, "PERSISTENT RESERVE OUT with PREEMPT: ");
         return false;
     }
     return true;
-- 
2.47.3


