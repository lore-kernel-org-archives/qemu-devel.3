Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C68E6401C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 12:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Msb-0007J4-WE; Sun, 05 Apr 2026 08:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w9K2Y-0008FV-Jx
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 05:45:10 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w9K2V-0004QH-0k
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 05:45:10 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so2812002a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775382305; x=1775987105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=okzbMsYPMprqPyZYbFak0QDQb7u3TnkwG80rvryVJXY=;
 b=SSV1Ymt+zlTsIwQhbi4l8QTiFQ5tmoY6WfgfyIMrqn9FWzfQpYDdM/7iUr/JkKs9+p
 Nw/NkdxMBpsH/1ZCcBk/HZwKGClK/0BvOOZx7Aucb7Fy9v2GQfcSV6rnpQ+XXDmHz5MM
 ag5gA5GAX0toxlaRyGDRbBVs/CaNQu3M6gRhIciXabtPCrGog7WSHMs3iRWs+EBvkvc4
 40ikjNAJNPjJ5lj2zzSCNCHDGa1ymIfiipkCTMw33sROBwukEdapmphc/pusNgr4Kx0F
 tAz24lpzQxPC6Am/kRy4seQ/vUyRpCOO7+6IA5m3LEVMUZGelrtkjSVCuoGVGjQsyoL6
 ppiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775382305; x=1775987105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okzbMsYPMprqPyZYbFak0QDQb7u3TnkwG80rvryVJXY=;
 b=K40X0zWT5YULRw1DUmQu4sgahdv35vIoywvFd+UwKmNaU75lvNfJ5Eb3pHR4qsbqQI
 /FQvFA3xPAcHe6ERk9LEksa0qqe+ZhYjU4oxiHj85r5f5QGULzK/h+C8lU2xPZwmicHc
 oxACRWyz2nfRSkiYCMdj8fPpMqj3pdNmVMEIT0ft7TKO6DMotY8z/fwuv9ZExBeoWQXi
 tbfAshPTLd7dqGJ9Qp+DHuTS5BfZ857EKtIcRsvgHlDkXVzb1Y5XzlcHiwkX6tW9gJ63
 mMeMnhnFuhHRGnavgUm6MkAI4lkyII4NvR9x6vfdtcTEsIbmOM/uHipOZiEke/WOFcbK
 S1DQ==
X-Gm-Message-State: AOJu0Ywm74t9cXWEEljuvGui7+prXXgSuNauuyZPJ6nD5vDKThuOeQMD
 3Vz2vHD1SE4fB2rvkFaA8h+gjkKgHwse4/9msEXd0v8do+p2/ujyepPbc+Tb8jIYjBaXVQ==
X-Gm-Gg: AeBDiev5AVlcyJ3sDiyrwZ0Rt/qS8sFm3G6w25v4584n1dgtgoTGq7EeqoQH6Czd9bj
 qe4Hx307TD5AaYLfl1aN33ZFyrY0cXRNXxHPS5Q90Q+ETb7GpXpp6R9CTM2Rsc9TAxIOyK4K+vZ
 ClZ8PTMt7v6aUyJPTfHSGlfGcpkhrVx7Kd7ebdcc5ETXUzhgWtZzKUGRuceaaP4HBCRO+4UMZbU
 +zgTtIfm6rKKr2UKPOPSgBo8gYwHAfNV6r9E/ygCqD2fncelF/iQd+UxMr58xHYZ8WuazlPMi2R
 j9ZMHfu2a9VBcCYim9VmFTH/Es5xq9TET4BRH+syZ+X7Rk5Oi54C+LvF+Hx3JDzAF44QBYFPbXH
 gwmMdRs0W1DvklKyTZIw1WoONs0aJGueit/FXa2+hjCAVpqZwCDCtZl2XIYCp401eHh9JJt1JBW
 BBc5zJILvf4jVkSac89B29IGn3gYrY2FSA7l7ei7TWpQ3xD5s=
X-Received: by 2002:a17:90b:3d8a:b0:35b:e4f8:7b2b with SMTP id
 98e67ed59e1d1-35de68ebaf3mr9445875a91.18.1775382305260; 
 Sun, 05 Apr 2026 02:45:05 -0700 (PDT)
Received: from localhost.localdomain ([123.19.199.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd367c142sm10565232a91.11.2026.04.05.02.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 02:45:04 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Trieu Huynh <vikingtc4@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2] migration: validate page_size in mapped-ram header before
 use
Date: Sun,  5 Apr 2026 16:44:47 +0700
Message-ID: <20260405094447.11347-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Trieu Huynh <vikingtc4@gmail.com>

mapped_ram_read_header() reads page_size from the migration stream and
stores it in MappedRamHeader, but does not validate that the value is
non-zero before it is later used in parse_ramblock_mapped_ram():

num_pages = length / header.page_size;

If a corrupted or malformed migration stream provides invalid, guest
resumes either with corrupted memory or crashes unexpectedly (eg.
page_size = 0)

Add validation in mapped_ram_read_header() to reject invalid page_size
values early and return an error instead of continuing with an invalid
header.

Steps to reproduce:

Create a migration snapshot with mapped-ram enabled:
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate file:/tmp/qemu-snapshots/snapshot.bin
Modify the snapshot so that MappedRamHeader.page_size becomes diff with
target psize. (0/512/8192/1GB).
Restore the snapshot:
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate_incoming file:/tmp/qemu-snapshots/snapshot.bin

As-is:
* [0]: Floating point exception (core dumped)
* [512/8192]: Silent corruption
* [1GB]: "post load hook failed for: kvm-tpr-opt" (EPERM)
To-be:
* All: qemu-system-x86_64: Migration mapped-ram header has invalid
  page_size [val] (expected 4096)

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
v2:
- Replace == 0 check with != TARGET_PAGE_SIZE, which also catches
  non-zero wrong values and matches the actual invariant of the
  mapped-ram feature (suggested by Peter Xu)
- Include actual and expected values in the error message

 migration/ram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 979751f61b..2046f16caa 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3088,6 +3088,12 @@ static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
     }
 
     header->page_size = be64_to_cpu(header->page_size);
+    if (header->page_size != TARGET_PAGE_SIZE) {
+        error_setg(errp, "Migration mapped-ram header has invalid "
+                   "page_size %" PRIu64 " (expected %d)",
+                   header->page_size, TARGET_PAGE_SIZE);
+        return false;
+    }
     header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
     header->pages_offset = be64_to_cpu(header->pages_offset);
 
-- 
2.43.0


