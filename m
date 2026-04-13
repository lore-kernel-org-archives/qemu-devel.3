Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351A2F34C65
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKZv-0004JQ-9w; Mon, 13 Apr 2026 12:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKZu-0004JG-3J
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:56:02 -0400
Received: from qs-2004f-snip4-1.eps.apple.com ([57.103.84.54]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKZs-0006Mn-Kg
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:56:01 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 A4F9F1800B1C; Mon, 13 Apr 2026 16:55:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099360; x=1778691360;
 bh=UzCpYCxioU37a8LihFnYJRJpzhI5QkED2mBVZIjSzck=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DU7QJL1Nv8KQtdMjuIJrUY5vBbyZdUZy0HHSywLwLbITXs/Ha3F5To6TcYSibeOvoGl+9UUftrWQarTXEL4jJP/1TVSnzGgbWAVgMtroxGoUsfRTuDuiNJ3qX8LiOywpUt6tjjzI7ynwiGWIC+wZ0LU3BPRlaZMlMkz6yrHHC7Jx2P8JIk/9Lbx9FsMB/3tZ5RI5iGtaSxPxYq+0bSYyiHSKXEiN/6FNIc0Gb5lCaKvBF7bTn+db+YSy4SpO+GcPfP0WgByP2ur80v3yV3NpeLwV5qv/FgO5jvPbd4CLa4z9V8gyDapRym9anqw2Og3j+Z/UoJ0BkOizpWM/foFTaQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 1D0A41800543; Mon, 13 Apr 2026 16:43:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Werner de Carne <werner@carne.de>
Subject: [PATCH 1/3] serial COM: windows serial COM PollingFunc don't sleep
Date: Mon, 13 Apr 2026 18:43:36 +0200
Message-ID: <20260413164338.42894-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413164338.42894-1-mohamed@unpredictable.fr>
References: <20260413164338.42894-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX+9BrMHpOftiv
 vGsR3UKdQZBbBFwcBn3+VS3Kl6wi9Fj3Rg6mT6xy+p1GiQjtm23gYehe0+a1tv/LYTJZu52E3S5
 /r/2u+R0rJFedqIPFwl6m0JTp1Q1tALu9vCoOED6m55r0qMMEPII9AACdDB0QmQmpKTGi/MMea+
 93Kz5556jusU4ei/jR4aoKE53rWRVjUdD00liJ7IPCU2Uo0lgJjgFRLwqyOU9o+nf/0tioPyJKc
 DZ5fe8GUzW5/7aDKypfpQt1UjqhmSEp+sQx+GuG93gHg9Cc38vvvE8Ptlh1QbAYpbgzY1RyF+cR
 VBh599MsCxrtKuIuZuTlJDFTEwN/bYcWv99Z5xgCueCfEkEJK2vliS6SQxA2w0=
X-Authority-Info-Out: v=2.4 cv=I4hohdgg c=1 sm=1 tr=0 ts=69dd201d
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=Unios6BkgxOyw5t3swQA:9
X-Proofpoint-GUID: M1xfhkaEUfnbwya6K2NO8vctu68hy48b
X-Proofpoint-ORIG-GUID: M1xfhkaEUfnbwya6K2NO8vctu68hy48b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=679
 mlxscore=0 phishscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.84.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

From: Werner de Carne <werner@carne.de>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1802
Signed-off-by: Werner de Carne <werner@carne.de>
---
 chardev/char-win.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/chardev/char-win.c b/chardev/char-win.c
index fef45e83aa..f13d526e2f 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "chardev/char-win.h"
 
-static void win_chr_read(Chardev *chr, DWORD len)
+static int win_chr_read(Chardev *chr, DWORD len)
 {
     WinChardev *s = WIN_CHARDEV(chr);
     int max_size = qemu_chr_be_can_write(chr);
@@ -40,7 +40,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
         len = max_size;
     }
     if (len == 0) {
-        return;
+        return 0;
     }
 
     ZeroMemory(&s->orecv, sizeof(s->orecv));
@@ -56,6 +56,8 @@ static void win_chr_read(Chardev *chr, DWORD len)
     if (size > 0) {
         qemu_chr_be_write(chr, buf, size);
     }
+    
+    return size > 0 ? 1 : 0;
 }
 
 static int win_chr_serial_poll(void *opaque)
@@ -67,8 +69,9 @@ static int win_chr_serial_poll(void *opaque)
 
     ClearCommError(s->file, &comerr, &status);
     if (status.cbInQue > 0) {
-        win_chr_read(chr, status.cbInQue);
-        return 1;
+        if (win_chr_read(chr, status.cbInQue)) {
+			return 1;
+		}
     }
     return 0;
 }
@@ -147,8 +150,9 @@ int win_chr_pipe_poll(void *opaque)
 
     PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
     if (size > 0) {
-        win_chr_read(chr, size);
-        return 1;
+    	if (win_chr_read(chr, size)) {
+			return 1;
+		}
     }
     return 0;
 }
-- 
2.50.1 (Apple Git-155)


