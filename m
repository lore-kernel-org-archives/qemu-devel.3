Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B40D116E0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOPd8-0002mk-MI; Wed, 26 Nov 2025 19:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3iJcnaQcKCqUSFaNIJRLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--navidem.bounces.google.com>)
 id 1vOPd6-0002lY-Lt
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:13:00 -0500
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3iJcnaQcKCqUSFaNIJRLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--navidem.bounces.google.com>)
 id 1vOPd5-0005z6-3Q
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:13:00 -0500
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-7be94e1a073so436768b3a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 16:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1764202377; x=1764807177; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0j7T4SaSBzhQATVQOHGTTTyyPAyiP7oXEQJJ+/D5CCo=;
 b=WJ8GrQQkLDDfRfI4KbzV4h7IP0o4TgjIzI637Ao4wNnqPz4AEJwY/PtcsRG8GdZ3Ai
 P5QZuapU5Lu0Esy4Wze43sV2A3R8Xe2bzBrgwWQiGUdbO/7XiyNMyfSSUzgWAVYXEKPI
 x0JHeqzmGsYvnntIxe2V2AY6SKEACDcN52M1XF+wHMdOygDP2kB9yseqlsp5iBVxb+xr
 x7KkPEorHUi89+iNV0rpExNpCIS0LsQjTrv2c/wtCG/XWQwlODks6V9HWBvFZ4utGzaF
 cziNCx0U8V9QaMi18QjaS5GWKCm2kjQYk+Gcam0mrAnuJ0QXHQQ0nF6AR3FxoS4cZ7wa
 7rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764202377; x=1764807177;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0j7T4SaSBzhQATVQOHGTTTyyPAyiP7oXEQJJ+/D5CCo=;
 b=GalYRMSAOYe9pLXx4imwtzze/Hp+wcXYL+S4zs74uPAqeiplLevtxReu7ts/am7l/A
 8+dX89o8spGZPe9kC1dcBXjG30uMN+uvpTbbTYS5V40+BWm5JBNFlDAFUgUUkDtMn/3I
 NOywPs5OzALPYDpLsvWRsQAHjrJVQqJ0GwJI6/myAld1h+xzzOveyPRyoIqLUsoEtcfu
 YLAgZyk0YemSvXDzNPqCz1UhAdN091wSgvjsSTPJVX+xNXTSNPDYN8osgDGBilIlqKdS
 AbX3p5Z3LXhvP019/nR+zoViHX8y7FvOJcmsln+o38svWr1Uy4cgJsuXS1zW7NVAK3JA
 OrKQ==
X-Gm-Message-State: AOJu0YxcjnbkO9BhhSqyMztOZI74ah5KowtDPcZO2w3+ZqascbMWyT1/
 fA3BqHFqH/o8lTPNmE0nDRd2s6pDFw/LMGqBGp0d+jf2qZIuUwHdSatvRQMzLW3XwhOtSN+/tnQ
 NJiuuL6lcyMObO6d4plSIxjg3fCEIN8n13jLtT4XV339aXyg8ZONZ4isClX3Zj5/D7UCu4EAm0W
 ACWn0DtndVtvUHSbaQTflwgZ5Y20akLBtygZ0rBp7f
X-Google-Smtp-Source: AGHT+IG6mr3eIXbPb19wwOkBKn8D1Bl1SdV0RWx0bvYMnE/tJ6s3bT6pJ4RE4gSC7IjbIAfCkKwwrwIX4kOE
X-Received: from pgzz7.prod.google.com ([2002:a63:3307:0:b0:b62:df8e:e831])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a0e:b0:334:a523:abec
 with SMTP id adf61e73a8af0-3614ee01766mr20813467637.60.1764202376217; Wed, 26
 Nov 2025 16:12:56 -0800 (PST)
Date: Thu, 27 Nov 2025 00:12:44 +0000
In-Reply-To: <20251127001247.1672873-1-navidem@google.com>
Mime-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251127001247.1672873-3-navidem@google.com>
Subject: [PATCH v2 2/5] libqos: pci: Require size for legacy I/O port mapping
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, zsm@google.com, 
 alxndr@bu.edu, Navid Emamdoost <navidem@google.com>,
 John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3iJcnaQcKCqUSFaNIJRLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--navidem.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The accessor functions for QPCIBar (qpci_io_readb, etc.) perform
strict bounds checking to ensure memory safety. However, the
qpci_legacy_iomap function created QPCIBar tokens for legacy I/O
ports without an associated size, making this safety check impossible.

To fix this, modify the signature of qpci_legacy_iomap to require the
caller to explicitly provide the size of the legacy I/O region.

Update all existing callers of this function, including the IDE
(ide-test.c) and TCO watchdog (tco-test.c) test suites, to provide
the correct, known sizes for the hardware they are testing. This not
only fixes the test failures but also makes the tests more robust and
explicit about the I/O regions they interact with.

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/ide-test.c   | 2 +-
 tests/qtest/libqos/pci.c | 4 ++--
 tests/qtest/libqos/pci.h | 2 +-
 tests/qtest/tco-test.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index ceee444a9e..524458e9f6 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -173,7 +173,7 @@ static QPCIDevice *get_pci_device(QTestState *qts, QPCIBar *bmdma_bar,
     /* Map bmdma BAR */
     *bmdma_bar = qpci_iomap(dev, 4, NULL);
 
-    *ide_bar = qpci_legacy_iomap(dev, IDE_BASE);
+    *ide_bar = qpci_legacy_iomap(dev, IDE_BASE, 8);
 
     qpci_device_enable(dev);
 
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 70caf382cc..f07fc9140e 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -603,9 +603,9 @@ void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
     /* FIXME */
 }
 
-QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
+QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr, uint64_t size)
 {
-    QPCIBar bar = { .addr = addr, .is_io = true };
+    QPCIBar bar = { .addr = addr, .size = size, .is_io = true };
     return bar;
 }
 
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index e790e5293d..6e8e0fbff6 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -123,7 +123,7 @@ void qpci_memwrite(QPCIDevice *bus, QPCIBar token, uint64_t off,
                    const void *buf, size_t len);
 QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
-QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
+QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr, uint64_t size);
 
 void qpci_unplug_acpi_device_test(QTestState *qs, const char *id, uint8_t slot);
 
diff --git a/tests/qtest/tco-test.c b/tests/qtest/tco-test.c
index 20ccefabcb..3af7c14e73 100644
--- a/tests/qtest/tco-test.c
+++ b/tests/qtest/tco-test.c
@@ -77,7 +77,7 @@ static void test_init(TestData *d)
     /* set Root Complex BAR */
     qpci_config_writel(d->dev, ICH9_LPC_RCBA, RCBA_BASE_ADDR | 0x1);
 
-    d->tco_io_bar = qpci_legacy_iomap(d->dev, PM_IO_BASE_ADDR + 0x60);
+    d->tco_io_bar = qpci_legacy_iomap(d->dev, PM_IO_BASE_ADDR + 0x60, 32);
     d->qts = qs;
 }
 
-- 
2.52.0.158.g65b55ccf14-goog


