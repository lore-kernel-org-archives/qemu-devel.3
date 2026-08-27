Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC8BC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcgH-0004ab-ED; Thu, 27 Aug 2026 12:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcgC-0004Yq-4m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcgA-0007uz-CE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso21224225e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787847012; x=1788451812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y8pOTuQTygf728JvHILh6d5V4mR5TMERZeFgcXgTwJQ=;
 b=ZQylZqanSZIoofCcHAksuE21pnNbeCtx3C4g5echx28s5qa/bNKdVDSfl80qdWUope
 aYRluoWq7cRSj/Yqu7qdURldJ7CkCOAq3iG/MyrTrjfSbf/gm5yffycIW/5zGapEEOTH
 Icyw+uaKRA0ebEoCxJitJ5D1bTEQsaPrZ4pEQllLnoR/YA/OC7wMRFrgRI1BuVuuSB2R
 v70HfazpTGKf5uQhAXElPgXaHWG+cfAHC5oJ3xUbgwFxbURJ7s3PHo2lXn+ES/IhRVBi
 tA4NZD0QvUAQm8QIg6GliFK6Mn7+ZPh6xvhFXtq5zD3YydkR08n33CCWreRGWG0p2mPD
 otAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787847012; x=1788451812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y8pOTuQTygf728JvHILh6d5V4mR5TMERZeFgcXgTwJQ=;
 b=gmkfMT3uvn0hSZm0tk8p0pHTRyMdZOC18XwaxNHbOUk3rlH/8Nieng9vK/F/grr7h2
 ARPnYLn/TZtL55D98c+rhDzlnCHJj/XEU0JBTu05ajz1ys90LjLJl14/LMPkFq5wFBuN
 GK8DtHF+2r/7CVMTDmPiWWObezZkQ1SYmM+Hyew1xRehq9GxpYbazfTi4GazfUD/sYC0
 GKgeaphTsR3DusH2Gx/byuqXk39Kr+/L3ovtnuax9/jMJz/E9WVGrVBFr83ayAURlLjx
 bMt1klPKbRnupMf07odAuK0ySP5bRQpu4GoSla5HobzWjf1oSK3ep42Z7WZXwt2xrYoi
 ym0w==
X-Gm-Message-State: AFuF++m4GcEKPRZSdwrvZd/pPD/plrdSs9WGTKAjCCrfmvRGR7XuQtdu
 X/uXOYf4bL8QJ8DRBLzOAQHZ5b4Xpps+uKiYlGpxZFCOpD0C0H+iGD9atil5MCHyODkbHBeA1iC
 94Eju
X-Gm-Gg: AR+sD13m4JD4p9asqQdaJyoNhP78CLVrtp+UGDdi/c/2N37tkN5PnSbyF/hIBgXh1Kx
 eHzt60jqMgovwpvFsDaG5819PVLPYRYP0jdWjQ4ppzrdZNa2PxxsgL2dIUytjGtNlEOi7C5fsYF
 w/nHMw9YBY1yQqcHBqVJRuWWMcfkOjStKJD56p2nKm4PsM1V8St2YGO0rp2O/CJ82H00OL5FZR5
 nukKpCqibmcBYIux+/2znZncnEH40HM9PUuwlyrG4UJU7xiGJKj1HoH83btEr5LeC/GSGEomjZA
 ragV7blmByJbs/aCwpNWdma/xrLHuFogVjlYB/FlKLsBgvK5fY7wi9AqT9qt+/7FMc8nMgygSOW
 Riz971uF7FIl6QZG9jbYyYdOd2gB7e8REHhyvbVzVnQz5mRHcdRU1WpcGncTR8Pwzcqa3pcE6ym
 5ToG1PxpCeq3z4EpCCaWIXkahTd1aQY8a+QNx9HrFr4xAHlw8T
X-Received: by 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id
 5b1f17b1804b1-49b91bd99b7mr1848545e9.0.1787847012489; 
 Thu, 27 Aug 2026 09:10:12 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:e57e:de8:330d:26d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm71359465e9.4.2026.08.27.09.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:10:11 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 3/5] iotests/nbd-commands: exercise the simple and
 structured reply modes
Date: Thu, 27 Aug 2026 18:10:00 +0200
Message-ID: <20260827161002.310688-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827161002.310688-1-den@openvz.org>
References: <20260827161002.310688-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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

From: Denis V. Lunev <den@openvz.org>

Every NBD request the iotests send arrives in NBD_MODE_EXTENDED, so
the server paths kept for older clients are never taken. Instrumenting
nbd_co_receive_request() over the whole auto group and every test that
touches NBD gives mode 4 for all of them, which leaves
nbd_co_send_simple_reply() and the compact header handling dead under
test. A regression there would only show against a third party client.

libnbd can negotiate down, so run the same command set three times,
once per mode, and assert the mode that was actually reached. Block
status is limited to the two modes that can negotiate a meta context.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/nbd-commands     | 29 +++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |  4 ++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index cbfc47782f..3dfe913190 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -119,6 +119,35 @@ class TestNbdCommands(iotests.QMPTestCase):
         self.assertEqual(self.top_extents(), [(0, size, 0)])
         qemu_io('-c', f'read -P {pattern} 0 {size}', top)
 
+    def check_commands(self, structured, extended):
+        self.connect(structured, extended)
+
+        self.assertEqual(self.h.pread(4096, 4096), bytes([pattern]) * 4096)
+
+        self.h.cache(size, 0)
+
+        self.h.pwrite(b'x' * 4096, 4096)
+        self.h.flush()
+        self.assertEqual(self.h.pread(4096, 4096), b'x' * 4096)
+
+        self.h.zero(4096, 8192)
+        self.assertEqual(self.h.pread(4096, 8192), bytes(4096))
+
+        self.h.trim(4096, 16384)
+
+        if structured:
+            self.assertEqual(self.block_status()['qemu:allocation-depth'],
+                             [(size, DEPTH_LOCAL)])
+
+    def test_commands_simple_replies(self):
+        self.check_commands(structured=False, extended=False)
+
+    def test_commands_structured_replies(self):
+        self.check_commands(structured=True, extended=False)
+
+    def test_commands_extended_headers(self):
+        self.check_commands(structured=True, extended=True)
+
     def test_cache_past_end_of_export(self):
         self.assertRaises(nbd.Error, self.h.cache, size + 1, 0)
 
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
index 8d7e996700..3f8a935a08 100644
--- a/tests/qemu-iotests/tests/nbd-commands.out
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -1,5 +1,5 @@
-...
+......
 ----------------------------------------------------------------------
-Ran 3 tests
+Ran 6 tests
 
 OK
-- 
2.53.0


