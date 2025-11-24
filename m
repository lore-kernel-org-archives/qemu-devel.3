Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FC0CFD340
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 17:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNanK-00022C-I5; Mon, 24 Nov 2025 12:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vNZgH-0005q2-Mr
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 11:44:49 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vNZgF-00079o-2K
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 11:44:49 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b2e9ac45aso2680642f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 08:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764002681; x=1764607481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qdm6L8aPTUarri4dLQG06r4ueEE1UnAzh3pNSwoLyIA=;
 b=OcRlXkUM916UlNZYRcv1W7fzjvQQPknIqXTtd5MLfnQR+WFBUM70HjZatIT6/VNycm
 uWyYxIm8ebxaby4axl8KDGt3LHTk5oHQ272Ke1YN5jEz5dZ3cSoz75aE/3rBNShS6lFt
 xGSDlA7YJlqhJ8Bxm9T8pepbAshqvUdxB5gXKduthsUaVY9K9z3wL4UgE/f3Xrs5Gjo2
 EIjEmumtMDYaEaUAN8N7uLrvuymSgB0b3/PPhMcPAjwqMxgICGYG1R41JkLxGzvX3b8g
 bZPKdusgUbYyBriIbm7It7WyDJBOGw8RtWOn2RYrI6b3pgct8fN60zQOACqUW2azKe8P
 PLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764002681; x=1764607481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qdm6L8aPTUarri4dLQG06r4ueEE1UnAzh3pNSwoLyIA=;
 b=fthBvPsb7f8OtAadAvb0W7TwEHpT7IIDNZ3vw2eqJfC8BBnYHKDBT234N+Soo/sRS2
 0xgXfCQD2U0wf3eP5hKDrIGW3D+MnPfXA8ssVBdALA2nA2XReRN0vf+Ks85EyNp8lxLL
 8NNGUGh+dER+Kd1iTjBty4rU3kKThOQVWWHi61AmSgkMLcYruCzFmiw9wNEM56/ugV3C
 ezWE9YPF4sz+pj015KL/U5tfPfGihEUB6xuIhgnDifWceWBw5s3Gh9XJCw0O210AUw6s
 p6D8uvr5tsagIfNfAPoemQ24BdMDvJP/M4ER5grYujDH/NoxRqSth8TOlw01xcH3Yz1f
 a2Sg==
X-Gm-Message-State: AOJu0YygCwkqani0C3+I1+zZWXizVLY2VCI7kg7bLCk8B+5p6cSJRTkN
 2SoM8qKdHtQ1gcEYq0sVk525LXaugjhSNkdu1RXfBlvSyD8Vup+vvlEXEXB4GZozcfg=
X-Gm-Gg: ASbGncsrkQXj3MNVH154I/syxg2Yr8bVmYq73SjKbUuLr9cCs5Vu8YUBL9+D6oBSC9M
 L/JshMEfaTxtKss2DnMkNiqq1ybONzUKcdSHGCFQCIL1rI2JKJ9Ms0z3n95/v2FEowFhXIuxSWc
 Up/jE29TAgDG9JfMTLnD9gpR4VmZWY5wUR2VKwIndENGxGY+YyNDrfjhfiDH2AdwNJayi7rGpGL
 BoWaxBfwc2ZSBH783tF6mdf7+cwc0CJ3l4TlFpSiNDrjPvqw8EoWqJEEmKFqUmAfyPLR+uRZ5NU
 6BOzd06pPrhV0xrUzlU+04t2QqYqtxQ56zXgk+q9qJr8kgk+db+TlSsueaICz7Atmyl+fDTeCC8
 ApMtbDVA8mukmPrGFV/QXJqCptQR1NIBFHkYPZlWly5YhhyUP0Wj9jBRUgKvLGIwMjN2bwg==
X-Google-Smtp-Source: AGHT+IFcpY7jLwr6hMFMLlh08P2s/lyWcVaNWkJQHyMeUy3zu8nYQXhefijYR+1j5ZAuC32gQqVkBQ==
X-Received: by 2002:a05:6000:1446:b0:429:c4bb:fbbb with SMTP id
 ffacd0b85a97d-42cc1cbb561mr12141613f8f.13.1764002681144; 
 Mon, 24 Nov 2025 08:44:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::4:fda1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba20esm29507601f8f.37.2025.11.24.08.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 08:44:40 -0800 (PST)
From: Pawel Zmarzly <pzmarzly0@gmail.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	michel@michel-slm.name
Subject: [PATCH RESEND] scripts/analyze-migration: Make it work in Python 3
Date: Mon, 24 Nov 2025 16:44:39 +0000
Message-ID: <20251124164439.67948-1-pzmarzly0@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=pzmarzly0@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Nov 2025 12:56:09 -0500
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

Currently crashing on Python 3 with:

    $ scripts/analyze-migration.py -m -f vm.state
    TypeError: ord() expected string of length 1, but int found

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
---
 scripts/analyze-migration.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 67631ac43e..3303c05358 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -56,7 +56,7 @@ def readvar(self, size = None):
         if size is None:
             size = self.read8()
         if size == 0:
-            return ""
+            return b""
         value = self.file.read(size)
         if len(value) != size:
             raise Exception("Unexpected end of %s at 0x%x" % (self.filename, self.file.tell()))
@@ -200,7 +200,7 @@ def read(self):
                     self.files[self.name].seek(addr, os.SEEK_SET)
                     self.files[self.name].write(data)
                 if self.dump_memory:
-                    hexdata = " ".join("{0:02x}".format(ord(c)) for c in data)
+                    hexdata = " ".join("{0:02x}".format(c) for c in data)
                     self.memory['%s (0x%016x)' % (self.name, addr)] = hexdata
 
                 flags &= ~self.RAM_SAVE_FLAG_PAGE
-- 
2.51.1

