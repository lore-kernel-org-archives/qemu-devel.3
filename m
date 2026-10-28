Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E44606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGT/B7WR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fu2XXPJs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Er-0005K2-Nz; Wed, 28 Oct 2026 13:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EQ-0004wk-SD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EO-0003TW-Cb
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qytJW0iqt2yD4JxOmmbyNbw3L3GEuMcZae8wZpG4qY0=;
 b=FGT/B7WRkjHfFKSIr6GcSev3EAPVEbWJrzUwsrPpi+O6bN8cKduTdTAaShAZVGkALnQMe0
 BnIxSR9RsB3MRx2sTGwpQ3P9SH2CE+3aHs+NNrXaccdY7LNRLvhK3RFAys/6mnRI/vO8wu
 djosnHP/tUHES1ZLlPCq9lR1KIsXAD0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111--_jUiW54NNSWB8Wrk2YOPw-1; Wed, 28 Oct 2026 13:14:27 -0400
X-MC-Unique: -_jUiW54NNSWB8Wrk2YOPw-1
X-Mimecast-MFC-AGG-ID: -_jUiW54NNSWB8Wrk2YOPw_1793207666
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0fc747a7so999617f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207666; x=1793812466; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qytJW0iqt2yD4JxOmmbyNbw3L3GEuMcZae8wZpG4qY0=;
 b=fu2XXPJsFH7GwVmLl7nOZgOC64o1M0j/VngmGcegAGfpSkG544hp/5w4RFQSyLWAQ8
 NHGURX7qkn9SVIqjnLlLecAmGOrhJTlgdNwRJDsPoVLK+dnSeW9ebc2b4tpzjih3elHQ
 MBQOURzz9auYIG78zYNf2W1qakNmY4FAGP52fXXlVrab5yH2xQK8hvzbEzjX58hX81Ee
 HpizURRfmsfoqo68h69KlR/cTFv+BXeXYyLFyO4+4QfKbsAu9alehE70NsW3VwG+u/11
 NVQ7FU9gUGtOSSC4kuUsMlXy5sAcMAIFj4ev5H07M6UlArhZm3UOkeHQz5YAWhyzmU3H
 IpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207666; x=1793812466;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qytJW0iqt2yD4JxOmmbyNbw3L3GEuMcZae8wZpG4qY0=;
 b=wtm267ikl7ZzG4nBCS3iilFgD3r8WogxgvzcTNiUI/fqyJFzWRBKvF+V0U0t5n6Ngb
 uXT9xQ93GMFjkI2UY49ssYG6Kf6EFFNOzsDF83c9XF3pU5iKhYiJhobh/xreRhlNYbjP
 bKAK5kBynpEjfIKmeLBU1z7lhRPkQlBGrRMp9O+6Lq9gjtHP+IBIMPh9IiY8MEqaGKJA
 nqcpLWTJ6viqVootdefZvHbcEFEvdKPOu05d/xHAqeQYl36/+3ufPByZux89jPPRGNYg
 NZ8moLR9C+OqKqbeE6SG2mjmVIjELRRbCdENuOqWTLW00qZW1/aRgMVyq9tbw8pLD8jn
 Se6A==
X-Gm-Message-State: AFq9FYJYBYWknUBifc5pe3/mz/CVOHGE3gUrjhbbb9/u8+3n5RvUchxj
 5DFW6Vljqn3AuyLaI12F+Tdz3nqR1n6F36iRKjPeRT4OTMnqE8sk8Gy+xX6KYaYCpNdW7LUeTXJ
 Mdr5305/qTRjtwsDoX4R18jWh8f/GaN82JcPWfcdKpeKtT3fAfFj9/saEFox44WSe74E6Z1cKwX
 7jQwyzIwYRr6BppP1DGudsEps9zZtbDF/uMg==
X-Gm-Gg: AYBFou16iSX3oGQ3vgYW/4G1uKFBBTK27J4ENbQUKwKSbXBLOnifPWTurerMJr6hB3d
 K8XN1EWH2o7klRayj8q2tw4sq1kn+UKkDBmYpt8vmSi0B4sE5F0WmN05wma3Qf/NxSkw+3of5KL
 kpQEm4R4WlEknMybhitFVYSoMR1Pxm5xQ+2U/0r4Av2tsIxK9Bz0Sm/pXDg/rSOmz/7IU9NMNio
 klqUmJCPAjlIr+4vtU3EjBdO8/aVh3onrpXgp2yU3EBNpDdtSy/NARlPc7Gmklw3cP4OQCNQFbS
 bvFIF94voK49ykjBMmKlkoXzQZ44CIZHmJOTejsYzKTHGEU8pbSk8VzVX+g4jHKIcMEZrM00wzs
 RILTmLvUEvIxkD/CFogTzJzKQ+zk3zu6/tlyElZQ+
X-Received: by 2002:a5d:6d22:0:b0:48e:4f1e:5e24 with SMTP id
 ffacd0b85a97d-48e5d59097cmr5485811f8f.14.1793207666103; 
 Wed, 28 Oct 2026 10:14:26 -0700 (PDT)
X-Received: by 2002:a5d:6d22:0:b0:48e:4f1e:5e24 with SMTP id
 ffacd0b85a97d-48e5d59097cmr5485744f8f.14.1793207665431; 
 Wed, 28 Oct 2026 10:14:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8ddasm32208402f8f.48.2026.10.28.10.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:24 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 11/78] tests/unit: add test for duplicate keys in CPR FD table
Message-ID: <9d3a7aff6fd014b58cbdd4506596c1ee336bb5af.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

cpr_save_fd() now refuses to register an FD under a (name, id) key which
is already taken.  Add a test which checks that 2nd registration fails
with an error while the 1st one is left intact, that different names
or ids don't clash, and that the key can be reused once deleted.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-2-36c38bd15ffc@virtuozzo.com>
---
 tests/unit/test-cpr.c  | 98 ++++++++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build |  1 +
 2 files changed, 99 insertions(+)
 create mode 100644 tests/unit/test-cpr.c

diff --git a/tests/unit/test-cpr.c b/tests/unit/test-cpr.c
new file mode 100644
index 0000000000..dfc6b1f2ec
--- /dev/null
+++ b/tests/unit/test-cpr.c
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Unit tests for the CPR fd table
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/cpr.h"
+#include "migration/vmstate.h"
+#include "monitor/monitor.h"
+#include "hw/vfio/vfio-cpr.h"
+
+/* Stubs for the parts of migration/cpr.c that these tests don't exercise */
+
+const VMStateDescription vmstate_cpr_vfio_devices = {
+    .name = "cpr vfio devices",
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_exec_output(Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_exec_input(Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool cpr_exec_has_state(void)
+{
+    return false;
+}
+
+void cpr_exec_unpreserve_fds(void)
+{
+}
+
+int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+static void test_cpr_fd_duplicate(void)
+{
+    Error *err = NULL;
+
+    g_assert_true(cpr_save_fd("dup", 0, 10, &error_abort));
+
+    /* A second registration of the same (name, id) key must be refused */
+    g_assert_false(cpr_save_fd("dup", 0, 11, &err));
+    g_assert_nonnull(err);
+    g_assert_nonnull(strstr(error_get_pretty(err), "already registered"));
+    error_free(err);
+
+    /* and the first registration must be left intact */
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, 10);
+
+    /* A different id or name is a different key */
+    g_assert_true(cpr_save_fd("dup", 1, 12, &error_abort));
+    g_assert_true(cpr_save_fd("other", 0, 13, &error_abort));
+    g_assert_cmpint(cpr_find_fd("dup", 1), ==, 12);
+    g_assert_cmpint(cpr_find_fd("other", 0), ==, 13);
+
+    /* Once deleted, the key can be registered again */
+    cpr_delete_fd("dup", 0);
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, -1);
+    g_assert_true(cpr_save_fd("dup", 0, 14, &error_abort));
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, 14);
+
+    cpr_delete_fd("dup", 0);
+    cpr_delete_fd("dup", 1);
+    cpr_delete_fd("other", 0);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/cpr/fd/duplicate", test_cpr_fd_duplicate);
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d17435c187..5d2b413fca 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -140,6 +140,7 @@ if have_system
     'test-bufferiszero': [],
     'test-smp-parse': [qom, meson.project_source_root() / 'hw/core/machine-smp.c'],
     'test-vmstate': [migration, io],
+    'test-cpr': [migration, io, meson.project_source_root() / 'migration/cpr.c'],
     'test-yank': ['socket-helpers.c', qom, io, chardev],
     'test-ram-discard-manager': [
       'test-ram-discard-manager.c',
-- 
MST


