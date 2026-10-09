Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375F9CA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF6kC-00007M-9R; Fri, 09 Oct 2026 05:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1xF6k9-00006V-2v
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:18:21 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1xF6k7-0001tc-1d
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:18:20 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BBCFB4793C;
 Fri, 09 Oct 2026 11:18:05 +0200 (CEST)
From: =?UTF-8?q?Fabian=20Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] qga: fix typo in guest-file-read warning
Date: Fri,  9 Oct 2026 11:16:46 +0200
Message-ID: <20261009-qga-file-read-typo-v1-1-40c462aefe12@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791537485227
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=f.gruenbichler@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

seems to have been transformed from "read" to "write" during a refactor.=0D
=0D
Fixes: ead83a136d54 "qga: Extract qmp_guest_file_read() to common commands.=
c"=0D
=0D
Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>=0D
---=0D
Stumbled upon this while browsing through the code for unrelated reasons..=
=0D
=0D
 qga/commands.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/qga/commands.c b/qga/commands.c=0D
index 5f20af25d3476ebda08989c91d82c22aafdf5fac..666341a909d2c0cbffb50761126=
f76f8508af163 100644=0D
--- a/qga/commands.c=0D
+++ b/qga/commands.c=0D
@@ -626,7 +626,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool=
 has_count,=0D
 =0D
     read_data =3D guest_file_read_unsafe(gfh, count, errp);=0D
     if (!read_data) {=0D
-        slog("guest-file-write failed, handle: %" PRId64, handle);=0D
+        slog("guest-file-read failed, handle: %" PRId64, handle);=0D
     }=0D
 =0D
     return read_data;=0D


