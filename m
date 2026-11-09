Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98030606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pqt0G6ZQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXtv-0005Fv-Bc; Mon, 09 Nov 2026 17:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtb-0005BW-Az
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:27 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtW-0003mm-En
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:21 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-886e61fa30fso588335b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263477; x=1794868277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b1idv5Llys8jErTecMkb9GaJ9uep/EhQy4rAz/RX7Cg=;
 b=pqt0G6ZQEikFSGi//GiBc3uYmMQQz8j8o3Jo2/ZsuRVVLPneM14JkEtHdI+5fCpF3/
 mkf9eLpQ336JNvu0L0F0XnAqEANHfKLN0bcsTyaqVeDfhEPDNaeZejwTXu+Jf3xSYqzd
 kESo5tGPhq1y1aGokeGdjw9MX9A/sV5b6V/QrHcV10lwrfUzwTQuPQzRA7DQb5nvKs4c
 59/LhqXPCs/EyLxkDTihP/IgxYPYq7QpNNyEDw5JwVqmRO+0/x+DCNLaul62NMtt45Pf
 2cW+8xjs/E2CXUWVr7t6li/cdioxA1V3N0XY7qPNyew2xLEb4srDpprl7tqfmVY/swmu
 x87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263477; x=1794868277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b1idv5Llys8jErTecMkb9GaJ9uep/EhQy4rAz/RX7Cg=;
 b=dHxj+ToOsY4qnTh5NXQNVhuZDdUkO4L7u6esAsJrESM/bIW8r8/ELyjbeK5eIjWhvg
 snYYEnEcAzOi7fJmhSV16PHUsfaMx1vNtdcnWJ7E5J+V0B5y1SrAY95+dXTxTqMo5G/l
 RPhOrD3CZI1MQ7v7dHtMc4KZWSSfNalNYYFoN9JkcUh/vt9+bVt9qeuTrthFQ41hLBCE
 r5XAUpl8G7HOgkwlNzlE7Drso7IBXdSUWkR5Kzg6fwZwUV+lavdpZ4uG92slyK2RWQtz
 Dm08PwxhXo5j1ZZZgDdLiFHjK/j3sHqLbA5anire9hDv33IqM7xiuivzy4Oxe4YgEj4I
 lDFg==
X-Gm-Message-State: APuU4Z/AawCK5r7mdO55PvCwyEYERiTwVBgckGZP3YKoWC7UqZe0flGp
 +IU4JtJnLPM/8+seY3koGvEvRnuiXG6fovzcKeeo4xFASicZJ80OaA6wUfTmiCAMcmY=
X-Gm-Gg: AYBFou29TWYp2QAXt9EKY49yPhItRqwHNC3xCB8foxDgz0XhTXaVSUKTMY3HzzQV6EK
 BwRUIw8/OMQAelzQ8yNRX/ehV91RNBbMUsGwQ1Zu2I5GDXxYpI2EjtsisAxT3aeXw8I4IfJJOJy
 ZJu8U1eCUYdgA2GK0Hbr7pNK0DLeJcO6zZjj9sY1rhCJ0Y9XJlqQLN1m9PVlpJ6qeAhxygsi2Jg
 EeS9sFZ4+dFi25LaTKLFXNTKrCl1pJynvr4ayfbw63PQ3AipUpN42Erp4Oj5aUYWDuZwSs2Y1a8
 POT9M+lEjmyiyzEYpDiO74Y1cLua1FKHMihRgLtJlkB7XWybIPK6nqKWlOQFXhYsemV/YwfR8di
 C/kNNOI0N4ARv+HtxOTUUNhKAlDdKpnn29qcoxHXgd6YBXTHkLBFEhA32YHMwTyuHbERjNFIT5/
 PC+ttDHG9JwGK7ohr9rw5/5RVAIRs+ib11OkwGEz+j8YE8Azzl1QsUNcK6WpdV5avZzVJXAwVkk
 Zi193i49qF/H36JRK5seq7rolGkBHDgl0G3do7gI+5ibZSP4GjrqJw53gl2Zq48ck373efIwSmk
 Lv1W0LL6oxIclPkvzTVYJxVyPF2YCEi2I+tGcglxVstYoflkVFMaXQ==
X-Received: by 2002:a05:6a00:4f87:b0:8b6:4eec:f501 with SMTP id
 d2e1a72fcca58-8ba885c7a7dmr901188b3a.14.1794263477020; 
 Mon, 09 Nov 2026 14:31:17 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:15 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 02/23] target/arm: Add confidential guest support
Date: Mon,  9 Nov 2026 16:30:49 -0600
Message-ID: <20261109223110.1619504-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
support the Arm Realm Management Extension (RME). It is instantiated by
passing on the command-line:

  -M virt,confidential-guest-support=<id>
  -object rme-guest,id=<id>

This is only the skeleton. Support will be added in following patches.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/system/confidential-guest-support.rst |  1 +
 qapi/qom.json                              |  1 +
 target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
 target/arm/meson.build                     |  5 ++-
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/kvm-rme.c

diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 58732d658f95..2d0b5c1b2654 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -44,5 +44,6 @@ Currently supported confidential guest mechanisms are:
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
 * AWS Nitro Enclaves (see :doc:`nitro`)
+* Arm Realm Management Extension (RME)
 
 Other mechanisms may be supported in future.
diff --git a/qapi/qom.json b/qapi/qom.json
index 7fffc949d3c7..18c1d88b4cc4 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1298,6 +1298,7 @@
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
     'qtest',
+    'rme-guest',
     'rng-builtin',
     'rng-egd',
     { 'name': 'rng-random',
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
new file mode 100644
index 000000000000..42e1d1e7b859
--- /dev/null
+++ b/target/arm/kvm-rme.c
@@ -0,0 +1,42 @@
+/*
+ * QEMU Arm RME support
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright Linaro 2026
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/core/boards.h"
+#include "hw/core/cpu.h"
+#include "kvm_arm.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "system/confidential-guest-support.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
+
+#define TYPE_RME_GUEST "rme-guest"
+OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
+
+struct RmeGuest {
+    ConfidentialGuestSupport parent_obj;
+};
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
+                                          CONFIDENTIAL_GUEST_SUPPORT,
+                                          { TYPE_USER_CREATABLE }, { })
+
+static void rme_guest_class_init(ObjectClass *oc, const void *data)
+{
+}
+
+static void rme_guest_init(Object *obj)
+{
+}
+
+static void rme_guest_finalize(Object *obj)
+{
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 0369f96b4cc6..9d322a7aad28 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'hyp_gdbstub.c',
+  'kvm.c',
+  'kvm-rme.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
-- 
2.53.0


