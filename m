Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88326C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teupk-0006Fr-14; Mon, 03 Feb 2025 06:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1teupi-0006FS-5r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:41:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1teupg-0007Uo-Nv
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738582898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gP2iVdjr0Y32gX1bV2/2F4tLSlKCLx0SB9Cr67ePsuE=;
 b=ZgBdrSBp/6wkkQSRSOAwbLedsSHBZUHdEwtbF7Iwdswvv+Kr1zfqab2vArME45QFm2Lvg2
 Y7E1JKZYPng95NXfOk+YrFujipFl6x0euHYkae30L3qhEuXA27xZUKtqRTe/8IQDsbJpqS
 etEdujRb75cvz5YzScDESER9+blSSgo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-557m12RVO1mts4M3W9niOg-1; Mon, 03 Feb 2025 06:41:37 -0500
X-MC-Unique: 557m12RVO1mts4M3W9niOg-1
X-Mimecast-MFC-AGG-ID: 557m12RVO1mts4M3W9niOg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43628594d34so22056055e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 03:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738582895; x=1739187695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gP2iVdjr0Y32gX1bV2/2F4tLSlKCLx0SB9Cr67ePsuE=;
 b=ubwoYmwSwXG9yvFOe8KypXwJ+d3iWPEkbf8N59Nf9GL7ifZFUwY/U/T+wwT4nDMjXO
 G68/2DEIiHHePwPOggU+3esGMRGOIITaHrkCEKwwHMdht4zyxk8VNS8BpMUeTToRa7lX
 PPpeJjwqxFlKTbEmDxP415ecWSuCF3LwlVK2Fh9MdoZA9v5iK/QODdsBbXUXk2vjH9Oh
 whHF2z65+bapRZQIuzlmrYWOcnqSU8i0wfz69eccnu6nNCMNDElWVBAu1twYg85q2+2W
 hHm+M0OLNeGcKu32qOCJIKsBMi2mddC1ykLXlT9wR3YJ55sHGcBHiW1iX33gwkcAc7tO
 fiXA==
X-Gm-Message-State: AOJu0Yz1zGNS4X9dDgfpmuncKR9IQf0FHGd7OcOs84yF8auiz9DF9lj1
 9EsAsiT5EAl9AhBK4b4LGzvxRI4GyCjysuz1kgU4Oq6LdRPZeYks4IhiBLD6jk8EThOhw8jZDjB
 3iW8QnDY3gNLujS8V+jG+dV8ZE6pPF0zC/7Eimg4xswJNYj7bubszSgL75Vhb7QLkENNwL4cN7j
 jqgbcu0ot5Hi7fM0fD0mO7sctg9Rsmp9k37hW0Uwc=
X-Gm-Gg: ASbGnctUm/qxH9VD3pKT8ddDAYiBlkhKsC3JjlrNlBOJPXnmXt9V6lHQ/Wmeu+56awN
 9I1yNy/A3RC+PnxXeIk1QfbYg0U+Hm9e3lqTe0oH1Nq8odY2J2lsjmHciHfF/ABDHuX+UPIEIKC
 6g7aAOU8Ej5ygOlkUXTJQJ47mi55Cp0siM3oIyUfWz/jXPCf+imh14tLP8GrsN+c7qZ+JTBaPC8
 2HZctTTcg35yOJX+u5hV7sdaFBOS9RuTfs0fMjCa/4BJUpDLI+h6lbvbEpCae0XQjukVaQ7TuIh
 dwCkaQ==
X-Received: by 2002:a05:600c:5486:b0:434:a525:7257 with SMTP id
 5b1f17b1804b1-438dc410b0bmr168754775e9.21.1738582895032; 
 Mon, 03 Feb 2025 03:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNURjt8KeROce2XZLT/4IMm49wUTtjmmLWFFLpaLubHcLs5lmpfEKMzt/8WFIFpuL4Zv0LAg==
X-Received: by 2002:a05:600c:5486:b0:434:a525:7257 with SMTP id
 5b1f17b1804b1-438dc410b0bmr168754505e9.21.1738582894648; 
 Mon, 03 Feb 2025 03:41:34 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81589sm186346045e9.33.2025.02.03.03.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:41:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, alistair.francis@wdc.com,
 xiaoyao.li@intel.com
Subject: [PATCH] qom: reverse order of instance_post_init calls
Date: Mon,  3 Feb 2025 12:41:32 +0100
Message-ID: <20250203114132.259155-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, the instance_post_init calls are performed from the leaf
class and all the way up to Object.  This is incorrect because the
leaf class cannot observe property values applied by the superclasses;
for example, a compat property will be set on a device *after*
the class's post_init callback has run.

In particular this makes it impossible for implementations of
accel_cpu_instance_init() to operate based on the actual values of
the properties, though it seems that cxl_dsp_instance_post_init and
rp_instance_post_init might have similar issues.

Follow instead the same order as instance_init, starting with Object
and running the child class's instance_post_init after the parent.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 157a45c5f8b..c03cd3c7339 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -423,13 +423,13 @@ static void object_init_with_type(Object *obj, TypeImpl *ti)
 
 static void object_post_init_with_type(Object *obj, TypeImpl *ti)
 {
-    if (ti->instance_post_init) {
-        ti->instance_post_init(obj);
-    }
-
     if (type_has_parent(ti)) {
         object_post_init_with_type(obj, type_get_parent(ti));
     }
+
+    if (ti->instance_post_init) {
+        ti->instance_post_init(obj);
+    }
 }
 
 bool object_apply_global_props(Object *obj, const GPtrArray *props,
-- 
2.48.1


