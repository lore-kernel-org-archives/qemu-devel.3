Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A47DD116E0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOPdC-0002oL-Cu; Wed, 26 Nov 2025 19:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3jZcnaQcKCqoXKfSNOWQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--navidem.bounces.google.com>)
 id 1vOPdB-0002nh-4I
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:13:05 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3jZcnaQcKCqoXKfSNOWQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--navidem.bounces.google.com>)
 id 1vOPd9-0005zk-Ez
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:13:04 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-3436e9e3569so443995a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 16:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1764202381; x=1764807181; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=t/chO5DIn5GA4cXM3oxbQXVijgyx+nIIIuznv+j80gs=;
 b=bVnVgjAjbu+PUK/JmAOaZwsLkNdM5iRYMpfJyU3ho0BUQWygR1OyaKo/tk/7b9pP4P
 NoEbiaLa6zswS20Zh666w9A/jR/R3W88jsWtJNdRXeLxNSA8uh1LiM339SUnilfYhmNy
 E31X2tQ6yFrGS9X0KrGyVR5MnZUY1CeDxtQFUv6DM1s8Zj5bdKwnJcXBFdNRX1CoPLX+
 6mbHoVCvWSUeMznJJAkYuSEiVPPVK5Q59mfDGuUGxb5NhqGJ64ImIQcTE2+klxweumPy
 1CRCctuWi0C4p4LDyRI+6hUF+kFa9F7yrB9YasXmVOABhNN6Bn5RmenWkaVj49ngW/Jb
 itaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764202381; x=1764807181;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t/chO5DIn5GA4cXM3oxbQXVijgyx+nIIIuznv+j80gs=;
 b=cURY8qc31fEwobwar+8YLvAi7SQfnmFvF/9pyEnaJ758hu3RvQ7MAh2oL2G0I2Eewn
 MvzahXIzBhYyB0qtKkBK63oN2apaR6vQftWmq6ptBTvJaMULSa3gxzElfFBobvY4JqMJ
 8xwzmn9kbwEBSCHgrO0Zcafj42aAdA60xnsnnPwHD72KMlY5x5nbFaeXfJ05MuyzUKEv
 +RoBLfyCahfHFKiY0Gp7PubanH4sGgpCcvPVa9Jhx/FKfS+Q+0MJFwLDACjSC8TdjxO1
 SA5R/c9PIgwzDiQYgOhcWIqpqgVBg5egiFScvIypQWP6vPo7X9JaM1ikTUHaUsklskGA
 clmA==
X-Gm-Message-State: AOJu0Yw12S6+TxF4xC0JpP/vNKFP7jpp8dHzwA2+yQ4/eWPraOx/DiHA
 Z4y1b2jVGLG9vxDo2Qf5mTA8MU1GCB68Yg0SLuOa6JTGSCordCXIG0ZuVpirN0WqijDXIDeNZYH
 Un0DXnQpSVZPkWblmXxwjjzdk4RZo9PQX2QYm33bV1uVojqKIkN+22gu+/r1jHvhWfsNVewzsb/
 kQYWtT74SGmxQ4TEJL170S9Bi0zXF00ut2cceJW54Y
X-Google-Smtp-Source: AGHT+IHFYvdFPgvnpDgrBCUMlc3yuFEr63+8tYPJmpKk2arlAYdMtaTqkkZ+6ZNBnuAlH3+w61ryzkOEZH1Z
X-Received: from pggr17.prod.google.com ([2002:a63:d911:0:b0:bc5:4dbd:5a2b])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7485:b0:361:4b9d:b9a8
 with SMTP id adf61e73a8af0-3614eb8c1aemr24791493637.20.1764202381179; Wed, 26
 Nov 2025 16:13:01 -0800 (PST)
Date: Thu, 27 Nov 2025 00:12:46 +0000
In-Reply-To: <20251127001247.1672873-1-navidem@google.com>
Mime-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251127001247.1672873-5-navidem@google.com>
Subject: [PATCH v2 4/5] tests/qtest: Rework nvmetest_oob_cmb_test for BAR check
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, zsm@google.com, 
 alxndr@bu.edu, Navid Emamdoost <navidem@google.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 "open list:nvme" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3jZcnaQcKCqoXKfSNOWQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--navidem.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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

The nvmetest_oob_cmb_test was designed to deliberately perform an
out-of-bounds write on a PCI BAR. This was intended as a regression
test for CVE-2018-16847.
The recent change to libqos introduced strict bounds checking on all
BAR accessors, which correctly caused this test to fail with a fatal
assertion, as it was performing an illegal memory access.
This change reworks the test to honor its original intent=E2=80=94verifying
safe accesses at the BAR boundary=E2=80=94without violating the new API con=
tract.
Instead of attempting an illegal write, the test now performs several
valid read/write operations at the very end of the BAR (at offsets
size - 1, size - 2, and size - 4) to confirm the entire region
is accessible.
This makes the test compatible with the safer libqos API while still
serving as a regression test for the original issue.

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/nvme-test.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 5ad6821f7a..8be37ae043 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -48,23 +48,37 @@ static void *nvme_create(void *pci_bus, QGuestAllocator=
 *alloc, void *addr)
 /* This used to cause a NULL pointer dereference.  */
 static void nvmetest_oob_cmb_test(void *obj, void *data, QGuestAllocator *=
alloc)
 {
-    const int cmb_bar_size =3D 2 * MiB;
     QNvme *nvme =3D obj;
     QPCIDevice *pdev =3D &nvme->dev;
     QPCIBar bar;
+    const uint64_t expected_cmb_size =3D 2 * MiB;
=20
+    /* Enable the device's I/O and memory resources at the PCI level. */
     qpci_device_enable(pdev);
+
+    /* Map BAR 2, which is the dedicated BAR for the Controller Memory Buf=
fer. */
     bar =3D qpci_iomap(pdev, 2, NULL);
=20
-    qpci_io_writel(pdev, bar, 0, 0xccbbaa99);
-    g_assert_cmpint(qpci_io_readb(pdev, bar, 0), =3D=3D, 0x99);
-    g_assert_cmpint(qpci_io_readw(pdev, bar, 0), =3D=3D, 0xaa99);
+    /* Sanity check that the probed BAR size matches the command line. */
+    g_assert_cmpint(bar.size, =3D=3D, expected_cmb_size);
+
+    /*
+     * Perform read/write checks at the very end of the BAR to ensure
+     * that the entire region is accessible and that boundary accesses of
+     * different sizes are handled correctly.
+     */
+
+    /* Test the last valid byte (the fix for the CVE was about 1-byte acce=
ss) */
+    qpci_io_writeb(pdev, bar, bar.size - 1, 0x11);
+    g_assert_cmpint(qpci_io_readb(pdev, bar, bar.size - 1), =3D=3D, 0x11);
+
+    /* Test the last valid word */
+    qpci_io_writew(pdev, bar, bar.size - 2, 0x2233);
+    g_assert_cmpint(qpci_io_readw(pdev, bar, bar.size - 2), =3D=3D, 0x2233=
);
=20
-    /* Test partially out-of-bounds accesses.  */
-    qpci_io_writel(pdev, bar, cmb_bar_size - 1, 0x44332211);
-    g_assert_cmpint(qpci_io_readb(pdev, bar, cmb_bar_size - 1), =3D=3D, 0x=
11);
-    g_assert_cmpint(qpci_io_readw(pdev, bar, cmb_bar_size - 1), !=3D, 0x22=
11);
-    g_assert_cmpint(qpci_io_readl(pdev, bar, cmb_bar_size - 1), !=3D, 0x44=
332211);
+    /* Test the last valid dword */
+    qpci_io_writel(pdev, bar, bar.size - 4, 0x44556677);
+    g_assert_cmpint(qpci_io_readl(pdev, bar, bar.size - 4), =3D=3D, 0x4455=
6677);
 }
=20
 static void nvmetest_reg_read_test(void *obj, void *data, QGuestAllocator =
*alloc)
--=20
2.52.0.158.g65b55ccf14-goog


