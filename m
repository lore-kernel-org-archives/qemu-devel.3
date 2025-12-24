Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25D2E7491E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 08:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYKgN-0006XR-NW; Wed, 24 Dec 2025 03:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYKgL-0006Wz-VP
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 03:57:21 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYKgK-0007SR-77
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 03:57:21 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so58367915e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 00:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766566637; x=1767171437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6bMhLdj6U31m1U4WkUe+4rIkOUeCEhnJeHcGB1IQ6U0=;
 b=ttvvaDTaPmwbeghHgOPG4ygJ/cyyhz6M7XEo24CSPalK3a7aGZPNXVfBHMuhaHOp3n
 2OWJceRxp9iVS/afLyU5D3yHiT6pi44cdAecdGsw7fLUhaROiqj2mvHkRt+ODYxYPwsg
 F1Cjm3qXD9supfVvhiJw2+LPBQlsHhdRZwK7ROUCYbscUMTQ3oVAanutHGFy0kPP87kQ
 i9kfL3wuw/VKIX2VPgcDxfzgLVfE5tso87E4MTnC9RvEZERdxq6OI4YosTw/+mTPw64H
 t8CyR117jhFA4Iduv3XTMP+XgzFo5ViR61zLeF1CX8EOH4PKwSL9MWKleKgT9QIj8aT7
 ALNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766566637; x=1767171437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bMhLdj6U31m1U4WkUe+4rIkOUeCEhnJeHcGB1IQ6U0=;
 b=Rltx6d5G5I/kYLgue1IRnVbTtUMDJM9XD1XLbtz44Yxh8OrVDBNG1h4vgypGSJa1Hi
 uK+ONIWSwMKcMKXZjCJNEskJSvrISwnZ7lnQjX1GUJ6Fy8H26Gc0YGhwoQGiBk1lfMeQ
 AiZcamIp4LzU+zjW8Bpp6vEsLc8+HBDT0bz51hGQzIDKH8A1WDR03js9DGWDGuDWuKr7
 Hab/P2MQNkw66e1+uLXDrZ2pR2koPateV2n4Ha4eBrM4khEHud5MsjDzPux91+x4whYv
 VvSnTGq2UCOWUejQi6X4pEn8P2scM8pmq5b9P1hPvGwBaW3/q8aHxD0tGiz8/diD7W+2
 7UoA==
X-Gm-Message-State: AOJu0YyBr2HB7Qh6FxXaSl0uzl9lwW5G1ZWteipxBKJVbUbnNBrmoxQ0
 SAzJ758UNYVP1BSUWsAMOl3gRNZknSOaM3vF/qRWP2nfojg3lgdJ4EDXi6PwHkPJIiFUi17iS6R
 3w2rFptU=
X-Gm-Gg: AY/fxX7fST5b+Qz9r3qqijIrpobbCOuCDlLfqlTLyAuxt3Cv9QeU6PmtcN1Omp/Z9ng
 5iQCSlGZR1S4cSvnp1dG98ZxaMImnxX+D/fcucA+/piZY3JNq8u+mcCEU2gtTEg4osU5sH+XuQl
 IQ39N68ttKa+AtEv1yRIJqCtSXt3/xqN5SpLKa5sgf1EIU3/9g8GEJdKVBs4Y5j9qGgwUTAd/Bc
 hb/ufgT68igs+ETyOIv9L2sLpz+2tp4l8Rr2S+YkFajskBobOE5OPrFJp1gswl+EVKoOLjr/VQa
 PJsvqBXJYhS48cCfpTHeMtYBJoAjXQKwhAkYXoizWb0zMAWHlBj/+4b9jZImRsuHdS39JKbswHc
 4+qg1LGjlFvcuL2a/ViC0IRpL29fQHVhkEqnKdShEHm0Eqk05FW+pTxLrDcGTOQVs/W89w1BcCJ
 iJ6lFqVK+lRVegwRScBQTESyJUkAhyJX6uGrTN3DbA0nz15dIzHeoO/MlDnu6u
X-Google-Smtp-Source: AGHT+IGri8KiB9YlEqurIukj7pjdk0eRyHvIQjamt6PTav+dfVJReDxdZFfbthlCaFsp0jPhWSQyvQ==
X-Received: by 2002:a05:6000:4308:b0:431:808:2d56 with SMTP id
 ffacd0b85a97d-4324e4c730cmr17038174f8f.1.1766566637410; 
 Wed, 24 Dec 2025 00:57:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab257asm33438945f8f.38.2025.12.24.00.57.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 00:57:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] tests/qtest: Do not use versioned pc-q35-5.0 machine
 anymore
Date: Wed, 24 Dec 2025 09:57:14 +0100
Message-ID: <20251224085714.83169-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

As of QEMU v10.2.0, the v5.0.0 machines are not usable anymore.

Use the latest x86 q35 machine instead, otherwise we get:

  $ qemu-system-x86_64 -M pc-q35-5.0
  qemu-system-x86_64: unsupported machine type: "pc-q35-5.0"
  Use -machine help to list supported machines

See commit a35f8577a07 ("include/hw: add macros for deprecation
& removal of versioned machines") and f59ee044067 ("include/hw/boards:
cope with dev/rc versions in deprecation checks") for explanation
on automatically removed versioned machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Since all builds are blocked, could we apply as build-fix on master?

v2: pc-q35 -> q35
---
 tests/qtest/fuzz-e1000e-test.c | 2 +-
 tests/qtest/lpc-ich9-test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz-e1000e-test.c b/tests/qtest/fuzz-e1000e-test.c
index 5052883fb6a..b66a2e2313b 100644
--- a/tests/qtest/fuzz-e1000e-test.c
+++ b/tests/qtest/fuzz-e1000e-test.c
@@ -17,7 +17,7 @@ static void test_lp1879531_eth_get_rss_ex_dst_addr(void)
 {
     QTestState *s;
 
-    s = qtest_init("-nographic -monitor none -serial none -M pc-q35-5.0");
+    s = qtest_init("-nographic -monitor none -serial none -M q35");
 
     qtest_outl(s, 0xcf8, 0x80001010);
     qtest_outl(s, 0xcfc, 0xe1020000);
diff --git a/tests/qtest/lpc-ich9-test.c b/tests/qtest/lpc-ich9-test.c
index 8ac95b89f72..460d459c701 100644
--- a/tests/qtest/lpc-ich9-test.c
+++ b/tests/qtest/lpc-ich9-test.c
@@ -15,7 +15,7 @@ static void test_lp1878642_pci_bus_get_irq_level_assert(void)
 {
     QTestState *s;
 
-    s = qtest_init("-M pc-q35-5.0 "
+    s = qtest_init("-M q35 "
                    "-nographic -monitor none -serial none");
 
     qtest_outl(s, 0xcf8, 0x8000f840); /* PMBASE */
-- 
2.52.0


