Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FD6D70DEF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkKx-0005pE-PS; Thu, 28 Nov 2024 14:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4ec984965079b51a9afce339af75edea6de973a2@kylie.crudebyte.com>)
 id 1tGkKm-0005jz-PP; Thu, 28 Nov 2024 14:37:54 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4ec984965079b51a9afce339af75edea6de973a2@kylie.crudebyte.com>)
 id 1tGkKl-0001VB-0V; Thu, 28 Nov 2024 14:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=70oy+zIhcKqU3nbM95roDK6p30oLfuPq18fgj+sPGlc=; b=nMj0Z
 HxYrcgTBnv5/lwX0zcTNSbYYyDyk/SKyJ9hEMfosmWMbwk1TDmqD4wI4pYMCmoR3AoeEXNJ33Hz//
 wbPMfdBLIuTJlu84IHoHSLXEgLwH296+6AHRDf0hOLBNk554P5deAif0jKU4je/JZYNM+ft/N/b16
 E/Hq4O6OrgTpvtQPd8uQjmd+etOYCXHb3W2tsZMFooRKU/3vepZ81jDTO2fOF/8vO7Aue9TztQ6UN
 I8SnX7iTVqqqZZCmtO8N88yV/zuanmo8oE8l+JLRUmMRxlVA6uun4GusbnWTIXFID5U7d89qzJUV+
 hChjyT1xvE+aKW/4iUS5CSJHbCY1ID/dy3xd/cwLcxvbCTksWSwVgRKKqOgUQYyDkbeJNhsTzRkjw
 I6+L8Ebl0TpOFktMF1FEc1CXyISezh8llbtZl2OJXWJ9WgjEW0xze6VEYUqVFmXggNdlg6lYyj7PP
 X6/YNznwsOBInSaxkdsk3Q+ETAgzCDJ18w+TmL9fg14tUX70raWEWDPFuTDaU9/fzk9x90Tz+4ucQ
 LNWAnP1HQcMYXe/4zxcAua0Eb1lAPkEWUuy+b2StpWiJ+fGSDjnZ+0v3agI5CZAdrXdWmhNn8krfo
 AdnbR5UIKSSlhdL5jhlyS5i4ptaRr6C2EJmevKGpxVOiYMoprUGR7QBJ13eFrA=;
Message-Id: <4ec984965079b51a9afce339af75edea6de973a2.1732820037.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732820037.git.qemu_oss@crudebyte.com>
References: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 28 Nov 2024 19:53:58 +0100
Subject: [PULL for-9.2 4/7] tests/9p: add missing Rgetattr response name
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=4ec984965079b51a9afce339af75edea6de973a2@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

'Tgetattr' 9p request and its 'Rgetattr' response types are already used
by test client, however this response type is yet missing in function
rmessage_name(), so add it.

Fixes: a6821b828404 ("tests/9pfs: compare QIDs in fs_walk_none() test")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <e183da80d390cfd7d55bdbce92f0ff6e3e5cdced.1732465720.git.qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index c61632fcd3..98b77db51d 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -235,6 +235,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RMKDIR ? "RMKDIR" :
         id == P9_RLCREATE ? "RLCREATE" :
         id == P9_RSYMLINK ? "RSYMLINK" :
+        id == P9_RGETATTR ? "RGETATTR" :
         id == P9_RLINK ? "RLINK" :
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
-- 
2.30.2


