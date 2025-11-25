Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5068ED0EE00
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNwrl-0004KL-T0; Tue, 25 Nov 2025 12:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vNwrk-0004JF-JQ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:30:12 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vNwrj-0001BV-22
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:30:12 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b3669ca3dso2323749f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764091809; x=1764696609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cE4zWqxoR5+5oiaIAFjXGBUkxQl2niviIDP70vHfSb8=;
 b=lSg0qPIf9a9s72sC7AjesXhSSu9u1sgbAKCcT4RT881QcjEt95ibwakQkVgMTJqQoe
 NkdCrMsXRvyJ8wJLyj5LEmVONWhCYoc/vz82Py/9JBIqdANbLPVXIfGqnCBa3jBBI1NV
 ZgwRf3l8oH9+hkdMoiP9HNiQhZE6QDPFXl2fdq6oF1giuuFSf2DOMFPsmSaGtI3qk1b3
 M/iiKU3oz2VDz5Ou2lK49FLf4QsdEKdfDGKEOGMRgpVdXAdD2NHXHjABoXBs+6jZPdX4
 mn3gkWRGSdoqTM3WxkZUpN8YoIWWHiljml+iuVQgKDKA421sq4qAX5dVI0fA8CvjW4Dg
 +MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764091809; x=1764696609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cE4zWqxoR5+5oiaIAFjXGBUkxQl2niviIDP70vHfSb8=;
 b=tzslZgE/LfqYT9uJTIAsZ3E46eLw4Gn8oGl+Q4NL/BgRVzwm9rcYUH7d8v9h+/HHuH
 Gg84nN80iRF8fkHag0/j7ggY2shrr4Hd9rja4ok8xzFcOKnhs8/2KKFR2EV82IIJq+q/
 A5qtuSO3XgZPhNzckP5EeqsYo6hR7P0HAYZ5sdkkZzAqsbXmWTUIgKrG9ezjWlxUVxiR
 LmRyR9e4LTibICY3cjAJYvTph55xBwJs8q93ZWmBz8kxbOrOILPSyRvmbPvEaBuhrn1a
 UyqiKmrlyO+hCtPBjBez0O2jfjHZ4HJcHEQ2OM7sM0hGiaIn8zChMqx5dh51tFOUNhu1
 oGEA==
X-Gm-Message-State: AOJu0YwU/xA67OXh0W228DCsj4v7J/aHUXCKBq7IwbNI1bZAYy+ywDPy
 Do1kXN2o5Dtmb/VcXNG9l15A4Hg0RvLC8OPSCOHgPnM+oAFfTmaQM/GEGEgnKaILc9A=
X-Gm-Gg: ASbGncso2HsSWnsQrICPu7SmPRXirUIUaRfKSnotgXONlzQIqajBBLOFVPXBdtXv3E9
 JUXkHiYFa5X9TakZkSNLfuFZcPAV+WmPYJUztV8zmwp4L9p6YnW3IglvPPfYs+o//ehoN8Ynw1Z
 qwsRCXcQ7IZD0FG1vCwA0y8dfebJ+PsIkIkVmWDw8QBicH7xQ/YaAoh3nTWapaFYY0nuLtlqfFo
 o1dqv1e3hflYguAEDOER7+hmdniJAb4wijStEweWcsHJ2Sp0GeBopfSI3JWlvTejUSYym2Zrrhz
 8mjWmei7y4QoO6IRTbubNKp4SLZx4X6StDi5WJze4k12Zn7jRKZk8POg68Jr49S0ugyqlVbNauu
 lGvG1wVnt+nQ907ad7hHn9krr1UfzvOIIqqeymKCnTJcoccBUb3gR15oMDVDR43CS6PQM
X-Google-Smtp-Source: AGHT+IFf5ToJ4Dv1sHWCOlki64r/p9Nt16ygfNQ2y/1BRb1Ebnz6q/bt8qIxbGMO4Lz1fDMtrzonxg==
X-Received: by 2002:a05:6000:22ca:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-42cc1d23c80mr16686990f8f.55.1764091808824; 
 Tue, 25 Nov 2025 09:30:08 -0800 (PST)
Received: from localhost ([51.37.163.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba20esm35640501f8f.37.2025.11.25.09.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 09:30:08 -0800 (PST)
From: Pawel Zmarzly <pzmarzly0@gmail.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	michel@michel-slm.name
Subject: [PATCH] scripts/analyze-migration: Rename RAM_SAVE_FLAG_COMPRESS to
 RAM_SAVE_FLAG_ZERO
Date: Tue, 25 Nov 2025 17:30:07 +0000
Message-ID: <20251125173007.245607-1-pzmarzly0@gmail.com>
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

It has been renamed on the C side a few years ago. In modern QEMU versions,
fill_byte must be zero. Updating the Python script to make grepping and
understanding the code easier.

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
---
 scripts/analyze-migration.py | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 67631ac43e..6364fe4f72 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -107,7 +107,7 @@ def close(self):
         self.file.close()
 
 class RamSection(object):
-    RAM_SAVE_FLAG_COMPRESS = 0x02
+    RAM_SAVE_FLAG_ZERO     = 0x02
     RAM_SAVE_FLAG_MEM_SIZE = 0x04
     RAM_SAVE_FLAG_PAGE     = 0x08
     RAM_SAVE_FLAG_EOS      = 0x10
@@ -172,19 +172,15 @@ def read(self):
                         mr_addr = self.file.read64()
                 flags &= ~self.RAM_SAVE_FLAG_MEM_SIZE
 
-            if flags & self.RAM_SAVE_FLAG_COMPRESS:
+            if flags & self.RAM_SAVE_FLAG_ZERO:
                 if flags & self.RAM_SAVE_FLAG_CONTINUE:
                     flags &= ~self.RAM_SAVE_FLAG_CONTINUE
                 else:
                     self.name = self.file.readstr()
-                fill_char = self.file.read8()
-                # The page in question is filled with fill_char now
-                if self.write_memory and fill_char != 0:
-                    self.files[self.name].seek(addr, os.SEEK_SET)
-                    self.files[self.name].write(chr(fill_char) * self.TARGET_PAGE_SIZE)
+                _fill_char = self.file.read8()
                 if self.dump_memory:
-                    self.memory['%s (0x%016x)' % (self.name, addr)] = 'Filled with 0x%02x' % fill_char
-                flags &= ~self.RAM_SAVE_FLAG_COMPRESS
+                    self.memory['%s (0x%016x)' % (self.name, addr)] = 'Filled with 0x00'
+                flags &= ~self.RAM_SAVE_FLAG_ZERO
             elif flags & self.RAM_SAVE_FLAG_PAGE:
                 if flags & self.RAM_SAVE_FLAG_CONTINUE:
                     flags &= ~self.RAM_SAVE_FLAG_CONTINUE
-- 
2.52.0

