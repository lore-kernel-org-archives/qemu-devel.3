Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C0606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ekZGFJch
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2lT-0004sx-NJ; Thu, 05 Nov 2026 14:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2l3-0004s3-5E
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:23 -0500
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2kx-0003m3-68
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:17 -0500
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-19305bcb72cso2064500c88.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793905452; x=1794510252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WYnK/5FUcuPI98SgD7lnkqCIUD6xFC/0llqmlHc4wws=;
 b=ekZGFJchKTHLlyrq+PjHFDJDp2uEgJQ4XCz75yJtxS5n7y/BZa7CFEt7eZtesOc8V6
 phaXT/2glX52vfOb+eS9NVasDWW1pLKg4LzPTnH5jrP/XyT9+NGocdDTclO2neVCoqyI
 QnlCL3ObMGxKwJ2gR/5CtMlBaBobZVhivEbtWbUbn236a5k+gF6zPZyD9yhnV/BNC4wO
 hUA83UDUYcWzYC0TImNzb5UQ3wCSZkJLYFEEySV5E7kx7EqZh8izKkPo0P/K9pTElrh8
 kYA/3feDitOao1efVujHUUvNCfjBQUtrGIsKgkFgoF5t+9BE4nklhu6UJPsJ+d1s9TWK
 UUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905452; x=1794510252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WYnK/5FUcuPI98SgD7lnkqCIUD6xFC/0llqmlHc4wws=;
 b=aV0fTkVrZW3HxMAiot1JHR0wLtvyOy0nDge+X7el9XYMk8qDRNcxKsNy4H3CK6dXZA
 oCoW/qxOPqd3NuRBC7dTAI4zJlZgVaUe5b+oi7A3xgTKD9TDX7DxTqHTTNnzA7kWw8uv
 CksOcPGtZl9DVln7BRlnulDaAfECTxriU3k+X/QXYi6aZj73K2WS1ZMXMv1DeSoWw5TH
 62x3+igX+D+izyWd/Vbn6UEVq1eSYAg+ZpSsgQ/C7+CIudcpiQQataSaoNIw0CPniM30
 SL7pna4CrL9biYBxkxNtTC1N9zOzmQHAC7rpv1Y6Xo/z+VDN4B6pA+/Gi4IBKzQXyZrH
 HWwg==
X-Gm-Message-State: APuU4Z+EOqBRw3GmHnP6tIZ0iE3zumwQ24nPNwxlfhwK9HQupttA+LKt
 9Ii0h03Akhu0DIomBjAGJgy3YAcHShmdOztZjmkNPG7f23GmOmPZhM02w7bqxVAt/xE=
X-Gm-Gg: AYBFou1jO2ILo1wi7iSIYaSq+e4KQHDLW+MUAoT5IsRt/FHXQxtse1fQ41eT53zqMqN
 5Oon2+SpcWxEEU+3W9Mh7cBSkSCoIyD+TSA75mHnrfgi1M4HBJGzyIXFsbjjOGSq2AMwa/TBULY
 8YE29xAhonTWNj10hF2Te+Y0MwlAjmcuIUJD4vGyInsnX+CdBo4wNZ0Hs3NMOZZ3PUswrNX1YQm
 leikvV6WzQb2qdrSwFeOTBkL0WO5ljxnuVk5BZOkYlGnwbxnao987gQuk0L4RRN5txm8U03r3JT
 CHsV/p9Ld+LzzTUXjuBnadYieGBIn/Di1JK8LFCfZgqpTzCd5VpBItlL6PWKST409u4GoFwXgcb
 rdwCBAR40ej38YbX3B5XMDJkGQ2dR8swhg1OsWBMIkJsGiif/VlDulRJvS30+2PMdaTtdAqDJfK
 1axgrY1v6YD7Iub+55luvdf4cgeK88N7V3Wbt/K88eyGRRNeGVs0wuc8n4agxJLEO/hbeVaBObM
 nf+eoRfAjpWckqD0Hu16rn4MgNfQx4rMxk6rQrA1ukN6Q7cJ6RKsiRt+APfP6wkmfLuRmVSUon0
 mRGsFC565tkYD8nCbw27IrvN/TUUFpxSgHXps4Lbv5nzAfq7
X-Received: by 2002:a05:701b:2806:b0:196:bf5f:8bb with SMTP id
 a92af1059eb24-1ac5d69f9ccmr26423629c88.45.1793905452433; 
 Thu, 05 Nov 2026 11:04:12 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm22924284c88.15.2026.11.05.11.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:04:09 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH 5/5] qom: add type_register_targets()
Date: Fri,  6 Nov 2026 03:03:46 +0800
Message-ID: <20261105190346.1539-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105190346.1539-1-luoyonggang@gmail.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

type_register_static() always registers with QEMU_ARCH_ALL.
type_register_targets() takes a QEMU_ARCH_* mask and passes it to
type_register_internal(), which filters the mask and returns NULL
when nothing remains. As call to this function needs QEMU_ARCH_*,
so include "qemu/base-arch-defs.h" in object.h

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qom/object.h | 12 ++++++++++++
 qom/object.c         |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 70d8ea3e29..bda9b8901e 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-builtin-types.h"
 #include "qapi/qapi-type-info.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/module.h"
 
 struct TypeImpl;
@@ -988,6 +989,17 @@ const char *object_get_typename(const Object *obj);
  */
 Type type_register_static(const TypeInfo *info);
 
+/**
+ * type_register_targets:
+ * @info: The #TypeInfo of the new type.
+ * @targets: QEMU_ARCH_* mask of targets that may use this type.
+ *
+ * @targets is passed through target_mask_filter(). QEMU_ARCH_ALL stays
+ * QEMU_ARCH_ALL. Returns the new #Type, or %NULL when the filtered
+ * mask is empty.
+ */
+Type type_register_targets(const TypeInfo *info, uint64_t targets);
+
 /**
  * type_register_static_array:
  * @infos: The array of the new type #TypeInfo structures.
diff --git a/qom/object.c b/qom/object.c
index 265cf19041..0e50b0011b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -274,6 +274,12 @@ TypeImpl *type_register_static(const TypeInfo *info)
     return type_register_internal(info, QEMU_ARCH_ALL);
 }
 
+TypeImpl *type_register_targets(const TypeInfo *info, uint64_t targets)
+{
+    assert(info->parent);
+    return type_register_internal(info, targets);
+}
+
 void type_register_static_array(const TypeInfo *infos, int nr_infos)
 {
     int i;
-- 
2.55.0.windows.3


