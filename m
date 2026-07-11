Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D0FC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 09:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiUKE-0004wr-Uh; Sat, 11 Jul 2026 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUKD-0004uE-6l
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUKB-0002wS-HL
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso15714565e9.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783763322; x=1784368122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nSS+ZcwWj4Ni5L09hF7IWokv0OgsMWy7o3GfUeXb5ns=;
 b=kDMrg4UiylaOSvwFT4/7YXQf0QRdEzeQrCuGBlAqBo3pOss5lbAzmzNZrQAmOrrSLO
 I1/MJdfL4/k/RtUKv50JedTTu2lfS41l9tA80FR8D3Y/IMNkvODR4O3+bGsU52HVeAvK
 lNdWzVTjkpgFgJ9LSJlDs2s5T3AL5hLHuSGWCo/2iR/c17QPMl1hrFG0+hSkF6SJwRGa
 30PULhwmmhQ2VgbHAoUJbbYUXIyodAyV0e3BSw5r4Sa//oGaB2nb69EAMfYu2bNw14Wd
 CpP7piOYQOuQJGhD3kC6B8Nc/sgQN/GvofVpMHi39OAMUGcnODYhGIReQ6HpKdTDWjtu
 Tf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783763322; x=1784368122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nSS+ZcwWj4Ni5L09hF7IWokv0OgsMWy7o3GfUeXb5ns=;
 b=Im6t9ElE6tiBGPI0XKpJTeIpJNW/+VzUJgFPRCaurOeA8uoB0YqjlxD914SHqss4Xn
 6iA7c2/8NYmrjT8WlanrDF6AR4aqqydCkTFL4cq75HmLiDJTILB3u9AgBx9EPwLkoVSf
 9p3HYyeMSLgBUKOlG9EnHsHYYouNeMPdszCxMXrRUzbsi77oMwQgDqz6Gdj7W6o2vTkW
 86eM6vs6aVNWn3bTLq/D6f/ztjrzMzKIwiSdfRO++6FPLjSO7qFLf2KzREWp/pzbBfnU
 my/unUMJhB/T+Wh7lQf780x2OJeoKjEwJEFsgrlo+mnmDNaHlXpDgnGxRrQAHbPhcNBi
 6o/g==
X-Gm-Message-State: AOJu0YymMLKx2H+/lkuVXXbuXgykbNLFqG2tCtV40bduK/QjxclQ/GfS
 +yD82Ll76GWQ7e++5miewftF/FecbIQLyfwk8ieqzrGn0pRskaxUzUh75wtWkITg
X-Gm-Gg: AfdE7cm8atv9DcKKZcEG1TpzDM/DvbpRKvUO4Mqib8vb7pY0bhk5/BvgMiicTokqdi2
 Esa0tAk6Nz7KXJdOcurG8sK63V+cTrlnjSEyfMGrhYJvtEUlmk1/Y3iLsZ488KmcHQIKeKNhurK
 Qep9W5U1CVd4EU4efqjiInLRHilltAzXBiuRzPDDDGtBybFJUMd7XuLIg/fr1oCSbCDsQc2L7Mm
 RPvUJUBqyfXyzblbmZHrVIjlmaNW8f6tW9X+YOuJx40o0PwQqoVUeiec7BhMLNGvyHmfEyuZVQa
 NMD+Yo59M3WKC+lUTXxrXvh1MNrEO2C4GbUJuuuoiqtHyL9lmGYTS9EziKBvaY0pfKdPAu3mRTU
 n+re89A/CXnzyRfxjqoFT95QQ7DbBJg0l0nTRx/0Y9iNY0UD2tKTXmyhbPJvDANJtS3kkd2u0dE
 LFA1CaaKeDPTWidZsW7UmOp4sGF0JH1yWL9E+wdwaMvxsZsdDcdGxgru4iQ6Zwt0GJr6o3pr0oc
 9VZpZhOqNbF/sLQJIA+XcD8WE31cQ==
X-Received: by 2002:a05:6000:1a88:b0:47e:81aa:def0 with SMTP id
 ffacd0b85a97d-47f2dd215c1mr2285557f8f.61.1783763321836; 
 Sat, 11 Jul 2026 02:48:41 -0700 (PDT)
Received: from debian-for-building.localdomain
 (static.244.71.243.136.clients.your-server.de. [136.243.71.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm66558181f8f.20.2026.07.11.02.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 02:48:41 -0700 (PDT)
From: Dmitry R <rdmitry0911@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry0911@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 4/5] tests/qtest: cover Thunderbolt VGA hotplug
Date: Sat, 11 Jul 2026 12:48:00 +0300
Message-ID: <20260711094803.3589239-5-rdmitry0911@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711094803.3589239-1-rdmitry0911@gmail.com>
References: <20260710133440.2845828-1-rdmitry0911@gmail.com>
 <20260711094803.3589239-1-rdmitry0911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=rdmitry0911@gmail.com; helo=mail-wm1-x32f.google.com
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

Add a qtest that starts a q35 machine with thunderbolt-root-port and
verifies that regular VGA remains non-hotpluggable while thunderbolt-vga
can be hotplugged behind the Thunderbolt root port.

The test also checks the constrained thunderbolt-vga display defaults used
by the macOS validation flow.

Signed-off-by: Dmitry R <rdmitry0911@gmail.com>
---
 tests/qtest/display-vga-test.c | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tests/qtest/display-vga-test.c b/tests/qtest/display-vga-test.c
index 75b341a9c6..c5f526a56e 100644
--- a/tests/qtest/display-vga-test.c
+++ b/tests/qtest/display-vga-test.c
@@ -9,6 +9,21 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qobject/qdict.h"
+
+static void assert_qom_uint(QTestState *qts, const char *path,
+                            const char *property, uint64_t expected)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments': {"
+                          "'path': %s,"
+                          "'property': %s"
+                          "} }", path, property);
+    g_assert(qdict_haskey(rsp, "return"));
+    g_assert_cmpuint(qdict_get_uint(rsp, "return"), ==, expected);
+    qobject_unref(rsp);
+}
 
 static void pci_multihead(void)
 {
@@ -18,6 +33,51 @@ static void pci_multihead(void)
     qtest_quit(qts);
 }
 
+static void thunderbolt_vga_hotplug(void)
+{
+    QTestState *qts;
+    QDict *rsp;
+    QDict *err;
+
+    qts = qtest_init("-machine q35 -display none -nodefaults -vga none "
+                     "-device VGA,id=bootvga,bus=pcie.0,addr=0x02 "
+                     "-device thunderbolt-root-port,id=tbrp0,bus=pcie.0,"
+                     "chassis=1,slot=1,addr=0x05");
+
+    rsp = qtest_qmp(qts, "{ 'execute': 'device_add', "
+                          "'arguments': {"
+                          "'driver': 'VGA',"
+                          "'id': 'badstd',"
+                          "'bus': 'tbrp0',"
+                          "'addr': '0x01'"
+                          "} }");
+    g_assert(qdict_haskey(rsp, "error"));
+    err = qdict_get_qdict(rsp, "error");
+    g_assert_cmpstr(qdict_get_str(err, "desc"), ==,
+                    "Device 'VGA' does not support hotplugging");
+    qobject_unref(rsp);
+
+    rsp = qtest_qmp(qts, "{ 'execute': 'device_add', "
+                          "'arguments': {"
+                          "'driver': 'thunderbolt-vga',"
+                          "'id': 'tbvga0',"
+                          "'bus': 'tbrp0',"
+                          "'addr': '0x00'"
+                          "} }");
+    g_assert(qdict_haskey(rsp, "return"));
+    g_assert(!qdict_haskey(rsp, "error"));
+    qobject_unref(rsp);
+
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "vgamem_mb", 4);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "xres", 1280);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "yres", 800);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "xmax", 1280);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "ymax", 800);
+    assert_qom_uint(qts, "/machine/peripheral/tbvga0", "refresh_rate", 60000);
+
+    qtest_quit(qts);
+}
+
 static void test_vga(gconstpointer data)
 {
     QTestState *qts;
@@ -31,6 +91,7 @@ int main(int argc, char **argv)
     static const char *devices[] = {
         "cirrus-vga",
         "VGA",
+        "thunderbolt-vga",
         "secondary-vga",
         "virtio-gpu-pci",
         "virtio-vga"
@@ -50,5 +111,12 @@ int main(int argc, char **argv)
         qtest_add_func("/display/pci/multihead", pci_multihead);
     }
 
+    if (qtest_has_machine("q35") &&
+        qtest_has_device("thunderbolt-root-port") &&
+        qtest_has_device("thunderbolt-vga")) {
+        qtest_add_func("/display/pci/thunderbolt-vga-hotplug",
+                       thunderbolt_vga_hotplug);
+    }
+
     return g_test_run();
 }
-- 
2.47.3


