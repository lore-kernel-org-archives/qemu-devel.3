Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842DFD5B84D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 16:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBst-0006Sn-0b; Mon, 15 Dec 2025 11:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vVBsm-0006Rm-9C
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:57:13 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vVBsj-0003LL-UG
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:57:11 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so15962725ad.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765817828; x=1766422628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4/GsjTwUGDM+K/KryRV+8rwc2Dd9RocmQUXhcfoTr8=;
 b=hXHL2mGMByqQm30BMsclKvsYMK1qZfllHvdVBq/d4xcFK12tCsvQzY4bRgnX+qdtv5
 XYz0bq6YMf6H/ksZof6shyopacsbUm/tiRJUbQpNdw9kebevI6SbD3hait6OiV8hsKsq
 rwNoNOOvXcFHWgOMiGqaXkxFQV9I2+iBVo9M38POejTGii9v+ZJjR+R3dLGaZ82oMuqj
 MB/on4aroTduvT0k3RvK48Fc+P4T1uZYNqr4FhkjfDb4YrpSYPH6BBoJNtwkZMOzhiOE
 Wxx2ZdM9fCocl3e+kHHdAJePfDQDmCmjvNjoPmNEm9yeBRrItU7oPl2zoWJJzsb+2Ot8
 mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765817828; x=1766422628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H4/GsjTwUGDM+K/KryRV+8rwc2Dd9RocmQUXhcfoTr8=;
 b=lQzlWyoewmariq9kROId9p7Xzhhl7Qd4aKsjINU3ONt+GmpDaNPnO64mbOT/nWd1KO
 EhiIAs+nuNe4Lm0fiHQOcmgLBN+KMozMwR37Xy8YQmPi5D40T1TBbYWoYsFfAQmns0el
 NhZsNt6FicLe2BthbvglkDC3nVy4TOHytN7RhTqWYIGUFZ34MO3lQFThovM9b4jOMQcn
 EdL7p5FNRL2nkw1/fDs23DIAepvBo5bW/iZSLDatVmMSPJjztE0Jo9MnVdQXLDBKGl/I
 0SN473OVhmQ+D7Ulup7+3+YpFL40aumSi9FBo3CcS+9XqEIbz08lN0htesID5wBtMR55
 EWhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgP48AVkigatBqY7z5PIzACNz5b/EUOfqarHck4i8gnFHIr6qPBNh8/SY7UQEIDSWy63LVEY2xcRtx@nongnu.org
X-Gm-Message-State: AOJu0YyocsBR6YTG0cv7pMYl61t81HQEXRgpZTTZVBf82ZxZ4fhavB+i
 Yt0cqPamlSjkZEZPl04b8v+lNKv+Qgn65e1PCim0tuotrdHAD8lrbpx9e5roBRYZ
X-Gm-Gg: AY/fxX4bYggPzO6Qo31rkDlK/opCvpDlu5w+H22B2yojytH0AE4YxChNT2xpDrZrjNg
 AGrtpfV8hnuF17pXUlkkcNvd1lBjuojE4iGcpwZU644NtHZAKNuQjjNU+WG4V+QV7S2MWHJ0/0I
 MHPfNGl7CKnSlDMKYR3S7RXBs0VO38ITLgy9Jcw0u/sUkA2tOBmgWj8tQhNoRE14QmfG67+v6EE
 sYqbB7bTcJoLXdRODDboUAGDHJQRbQvCLUCr6j9JKF9qtsDMyNbZnjCKq4bzCy97lSo+jvCa9SY
 LYcTKeB7xCyeEZxs3dRDvAW2wYxE4Txna1y5oQC2gd8euj+b+W3rrdUE6HpwQg48nq+wfXcR//O
 7FpyDs2Z8ZiC8u4ELY6FYgi6C4JimKJCkQfOCiD9vtA9T6sU6CaLB9LsJczIu0YlP9IBSkI6uVg
 fT8pZaOrWCMYfstBkQ8cvQ/3M=
X-Google-Smtp-Source: AGHT+IEB0XnC54MH48uVLSN7aS46+++zYwFuj1f9rEoJIyp5HstTesNj3DtOeABvJceBaf2VvYNzZg==
X-Received: by 2002:a17:903:90c:b0:297:d6c1:26e with SMTP id
 d9443c01a7336-29f23b1e1e4mr150181125ad.6.1765817828390; 
 Mon, 15 Dec 2025 08:57:08 -0800 (PST)
Received: from localhost.localdomain ([116.86.160.247])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38c74sm140084775ad.31.2025.12.15.08.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 08:57:08 -0800 (PST)
From: phind.uet@gmail.com
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] util: Move qemu_ftruncate64 from block/file-win32.c to
 oslib-win32.c
Date: Tue, 16 Dec 2025 00:45:12 +0800
Message-ID: <20251215164512.322786-3-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215164512.322786-1-phind.uet@gmail.com>
References: <20251215164512.322786-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

qemu_ftruncate64() is utility function that may be used outside of the block 
layer. Move it to util/oslib-win32.c where other Windows-specific utility 
functions reside.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 block/file-win32.c | 32 --------------------------------
 util/oslib-win32.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index af9aea631c..8a44853389 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -170,38 +170,6 @@ static BlockAIOCB *paio_submit(BlockDriverState *bs, HANDLE hfile,
     return thread_pool_submit_aio(aio_worker, acb, cb, opaque);
 }
 
-int qemu_ftruncate64(int fd, int64_t length)
-{
-    LARGE_INTEGER li;
-    DWORD dw;
-    LONG high;
-    HANDLE h;
-    BOOL res;
-
-    if ((GetVersion() & 0x80000000UL) && (length >> 32) != 0)
-        return -1;
-
-    h = (HANDLE)_get_osfhandle(fd);
-
-    /* get current position, ftruncate do not change position */
-    li.HighPart = 0;
-    li.LowPart = SetFilePointer (h, 0, &li.HighPart, FILE_CURRENT);
-    if (li.LowPart == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
-        return -1;
-    }
-
-    high = length >> 32;
-    dw = SetFilePointer(h, (DWORD) length, &high, FILE_BEGIN);
-    if (dw == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
-        return -1;
-    }
-    res = SetEndOfFile(h);
-
-    /* back to old position */
-    SetFilePointer(h, li.LowPart, &li.HighPart, FILE_BEGIN);
-    return res ? 0 : -1;
-}
-
 static int set_sparse(int fd)
 {
     DWORD returned;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 839b8a4170..766c602172 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -899,3 +899,37 @@ int qemu_shm_alloc(size_t size, Error **errp)
     error_setg(errp, "Shared memory is not supported.");
     return -1;
 }
+
+int qemu_ftruncate64(int fd, int64_t length)
+{
+    LARGE_INTEGER li;
+    DWORD dw;
+    LONG high;
+    HANDLE h;
+    BOOL res;
+
+    if ((GetVersion()&0x80000000UL) && (length >> 32) != 0) {
+        return -1;
+    }
+
+    h = (HANDLE)_get_osfhandle(fd);
+
+    /* get current position, ftruncate do not change position */
+    li.HighPart = 0;
+    li.LowPart = SetFilePointer (h, 0, &li.HighPart, FILE_CURRENT);
+    if (li.LowPart == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
+        return -1;
+    }
+
+    high = length >> 32;
+    dw = SetFilePointer(h, (DWORD) length, &high, FILE_BEGIN);
+    if (dw == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
+        return -1;
+    }
+    res = SetEndOfFile(h);
+
+    /* back to old position */
+    SetFilePointer(h, li.LowPart, &li.HighPart, FILE_BEGIN);
+    return res ? 0 : -1;
+}
+
-- 
2.43.0


