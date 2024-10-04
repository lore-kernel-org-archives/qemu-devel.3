Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92896CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlGx-0007yO-78; Fri, 04 Oct 2024 12:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGN-0006WH-0n
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGK-0006A6-FG
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwAi0zbVtrrkRs71yZC6BRcXMXEBnLA8T1zN9S8kLxs=;
 b=T7gPxmNXN9p21AGDMIx0IrrtRVnz0H1f7A3woJ8xdKIaQoHEiZqzi1HB9vOMZZcxQ4siU9
 coX9yh8pehFSEhqZFbnlk14bGppcYAptmgCcGhmvxKnPT+uC3g2NuI8s1IlG7NuprcDfK6
 pA3HQCEAN6hA0NJZwFbnSzIzBWaz+5o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Ick7QVX5MNe6wZYnYzRxzQ-1; Fri, 04 Oct 2024 12:34:35 -0400
X-MC-Unique: Ick7QVX5MNe6wZYnYzRxzQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42e611963c2so17700305e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059674; x=1728664474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwAi0zbVtrrkRs71yZC6BRcXMXEBnLA8T1zN9S8kLxs=;
 b=G1uYcmamIGS+PY0BG8wNb4vOaNtLGWO1EyuUhH+QZKPWZoWix9+XOBFJh4DRvfr75D
 Efc7HSqd8HE2o7Bjk/cGQ+NkA5NrYV1xgkI1TJsvNCMwvh3Zg1dSIhddTprfCXGp2gTe
 kY4J+Vt/tb89iyftuiZXsm57/8lGzUXC8bPdlaUts3KnR2qlvn8tm5fK3RHl4Ad9mH7d
 u4VnMwIfIoHbrlRNCu35nrO04dwDr5UHSNRq2QG5jKpBnf3SHFD17eVIytqF0uMAkAkd
 9PB9ubKI09aghyU33as0AXtixfJgxst9pcKnkciIfN970hQhDxXTZRMgV6cwxHDO5RTZ
 XvNQ==
X-Gm-Message-State: AOJu0Yx0E8HF27NmKMj0wNO1zODWFeSdmEXEWBV68+aifieljLj0nvsr
 ryxO76jg2XatXjLptq6b+vFJGb4ziHvpaNCyoVBkyiZe7ep52qREOlfplZyoGgsSY+zlr+qh5Ut
 ZVyhwQXdZsVO46H6I8L651od4PsbGr3CR/V1looIYSSvH3laigldNbfBlpVuigr+F8vJT/wTk/Y
 SmvBqL4Xmsn+VxqKj7H0cORe81+hdJ7bxvznEQnv4=
X-Received: by 2002:a05:600c:1c17:b0:42c:ae76:6cea with SMTP id
 5b1f17b1804b1-42f85aab261mr30139565e9.9.1728059674214; 
 Fri, 04 Oct 2024 09:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0AhMMEYhIXPAT9qO1lOS42kcGtW02NqXex6DfuEN30Jby/XFPwJXH3dc+RhkjKFJRShMoIA==
X-Received: by 2002:a05:600c:1c17:b0:42c:ae76:6cea with SMTP id
 5b1f17b1804b1-42f85aab261mr30139325e9.9.1728059673748; 
 Fri, 04 Oct 2024 09:34:33 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e8360asm1611325e9.1.2024.10.04.09.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Kamil=20Szcz=C4=99k?= <kamil@szczek.dev>
Subject: [PULL 05/23] hw/i386/pc: Add a description for the i8042 property
Date: Fri,  4 Oct 2024 18:33:57 +0200
Message-ID: <20241004163415.951106-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Kamil Szczęk <kamil@szczek.dev>

While working on exposing the i8042 property in libvirt I noticed that
the property is missing a description. This adds a simple description
so that QEMU users don't have to dig in the source code to figure out
what this option does.

Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
Link: https://lore.kernel.org/r/15fhXFY6x78KW8P5gw0eKTW8kc17zejrJFxqnOyoBy6vw4W9rCmgDhoxssWosWFs_dbFtfsyjn9wpPrV3x8Nlzhy8mTJSEnXCr4qyHAhXSw=@szczek.dev
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 80a65d965fb..67a921779ca 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1823,6 +1823,8 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_I8042,
         pc_machine_get_i8042, pc_machine_set_i8042);
+    object_class_property_set_description(oc, PC_MACHINE_I8042,
+        "Enable/disable Intel 8042 PS/2 controller emulation");
 
     object_class_property_add_bool(oc, "default-bus-bypass-iommu",
         pc_machine_get_default_bus_bypass_iommu,
-- 
2.46.1


