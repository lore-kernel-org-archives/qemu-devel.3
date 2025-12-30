Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56755EE57C6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vah00-0006K3-K2; Tue, 30 Dec 2025 16:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzx-0006Ag-Mk
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:21 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzw-0002s5-2y
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so51651395e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129078; x=1767733878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DK0mq3Imy0OD9x4GM+uaaTCwAi8dtPUGh7Hpx81Zgo4=;
 b=QKFFRkncwAuRAJsuDYAT9fodRqEzKbE3tOvzs8RFWm28QbHlkD1UszpOMR1YmeSAXw
 in047styG9NgJce01cy7D7azbR+4qIyTqJ6bhJic1/qyp9UampAfQBiC3+CaAXzW9e/C
 gUxR384RsmWNgB/KCfmIneTdOCFwIanT9IHAACYbVPEVdrcMdgrYCjxYA4+A2R7cNb6C
 kiFpMsruj3XxubCKqNIhn3gxEwM6XYRibO29+g87F23m7coq9y8XUTFw8iGbim9rxpgI
 8Mbt79ZkSYgEf+al92c29NBaqp1aYm/l1JXPoqnniOyk+g8z3VpzlkYRWrxL3S3ootvx
 SAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129078; x=1767733878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DK0mq3Imy0OD9x4GM+uaaTCwAi8dtPUGh7Hpx81Zgo4=;
 b=OLOW47c3sIivNM/v++bQVLOnQ0kL5ENERvKgIyMKh+YSoDJ/T+6/5Kj1AFDh3V3oU0
 v9kzSVzE4U1Wg/cY8zf4WePz9VpqE8AHwk1SOFuNWcvHYzlkZGVW579m5xl8bPEcFHjZ
 GMF2w4bkZY9BQt6NmrH+6kE/fh0DABmVV9ms6uOGoXm9E1sBaMu0I7euR7CNxUSOlRM0
 F/HKCUw7USoxsaKNNZDPj9gGi28t9WoO4InN9s65sjPK7eA0a+Wb1b47fcfghGZE8thy
 QtQYqPafTkICy2q+rvLDv6GZuzJWDooJnKO5X5PZgSMQX5SuLQDOppLorwCLQCuaYtID
 JBSg==
X-Gm-Message-State: AOJu0YxHsdMpsAep2XMnJ11QRoyuu6xFqyq3b0ajfZVmL7eWQVc8sFr+
 6OBCaJLGOH3i6EGgQ0J6aqsqTTpPRQBz6XRAeYDf7S2FbMEn++lTWBOR+k8SUXjpAQ1XLd1d3yg
 F0DDvtss=
X-Gm-Gg: AY/fxX78VLebH+MMWqjcbf+F6p3tMAl8z7X+0qUKHsYYCoKMsuxgf729uBwOGe352GH
 Q8XNDtkHKHV9gJ4WpFRXm5mge7QdKRRGGlx7IBjpvg0MiNZdltdxP+PV7LH/Fzg6UaDTMG9VBfs
 A1R3a233yIrLyF/CdFlZ/8QqZa1ELYCPPVHsN6PXChOLTPxDi4bY6bQKFS9iecJZ3EYhlnawlb1
 4KVafafcFrl8plb6b7HaWcfD4R238Txq0EF32gu36e/VdzaxZkRX0YU0HqxeI8cVJayThgbEj7q
 GZdmITh4E4u1NAHBZ0IwZVRc0E4aKSBHz4hJvt99QFka0LuZLflL0d3X+HBwZUykCEu5kDx36hn
 4qCR4kTaPrnyxtG/z/eFrh/uHeiLF3WNW6EBMDThVDCshJ7cykE2Wm2xcU93NXEHBXnrrBa2piV
 6Fn1s7+oWz8coVTdjgAK8Ka1SeldNrKm6L8l3pEHltZyJBF9gOXp0/Skz9CVmhoxfUxtjmXJo=
X-Google-Smtp-Source: AGHT+IE2F7DhkxNEtfOf2eklwmbApFPpcM98snmmVlx2xzbXi7i3GIOlSsvqJma4Bi0YXoMI2xTaMw==
X-Received: by 2002:a05:600c:4f15:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-47d19538dfbmr457544785e9.1.1767129078117; 
 Tue, 30 Dec 2025 13:11:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346e48sm597817615e9.2.2025.12.30.13.11.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:11:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/34] util: Move qemu_ftruncate64 from block/file-win32.c to
 oslib-win32.c
Date: Tue, 30 Dec 2025 22:07:52 +0100
Message-ID: <20251230210757.13803-31-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

qemu_ftruncate64() is a general-purpose utility function that may be
used outside of the block layer. Move it to util/oslib-win32.c where
other Windows-specific utility functions reside.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251218085446.462827-3-phind.uet@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/file-win32.c | 32 --------------------------------
 util/oslib-win32.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index 0efb609e1d5..b00039bf945 100644
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
index 839b8a4170e..5f3e8f4d980 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -899,3 +899,36 @@ int qemu_shm_alloc(size_t size, Error **errp)
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
-- 
2.52.0


