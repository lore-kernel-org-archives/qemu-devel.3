Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAEAC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENva-0004FE-3P; Tue, 04 Jun 2024 02:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvB-00045j-GY
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvA-0007XL-0m
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsVpLdbmx/uPeSaF81fFP7gyNO79Fr2K1Tb3dOWWZos=;
 b=dN1GTR9nQutqHib0rsmxfMLu8LIPCigmZ4R4V6H7jIqO4Uhv8ZHDfj1DNQQpbLtaG1ig02
 D7kcvysblljQ0hbn2vkU/3ckxsieyR3xZtcyFWR+kXX7BHQBae/apvygSWCWtHecmVFrTy
 CqGSRbKinTi2bCsUTKxtaCE3lX49/OI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-8KReu0TsMMqUrVI9AYnB8w-1; Tue, 04 Jun 2024 02:45:19 -0400
X-MC-Unique: 8KReu0TsMMqUrVI9AYnB8w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68b41fb17cso228170966b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483517; x=1718088317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsVpLdbmx/uPeSaF81fFP7gyNO79Fr2K1Tb3dOWWZos=;
 b=V5lyU/uUFw/XgZB9N6xnAlI3ODc9uY6lhR8e0/qRSKK6jyKQovvWoMDbyktYl27niV
 W2acO68bxSDiBO7Vu74QOyKG6iRv2Xg6C7id4S4KIpFO/+Mz8M2S+hdX5hoOe6QzigbO
 lcwYwxn+elturguypuUhpLYnnXxSpIOxDhBYvnQc6i2VsvOJmkuDCbROnxJy0//F94iC
 NT9WQBMT8XnAbdomsNqcjqha+9+996DeZs6eFfsNlT3oPsvNvhMvzhIjpQZjFXQW3Tak
 Kt92SLhCRv6SAw4Mm/YYz1nAp6RpvRdchz/tZbznVJjvHtJmAWJn6NpJlpkQLUuXP47z
 0gMw==
X-Gm-Message-State: AOJu0YwTJfiQ1HgAx/9Jrduzqt2YYZ4D/AqPRHYiIwQVrbVj63qIr9d9
 ZkStBeVFIqbYhm71L1gz+Ewb0Olw504mcDc+Mj2f7bARkhEo13BigquyK64S/c2DgXTOhLBxk+/
 cxXJejihk9cbL5N9iypgqNDbaU1ptPKrrl19GFBhbmWdmAGepcOYOhnDNM+8eec/umIzV/snTNX
 SmPs8upCcrUrpYJs5TeFLs8yAViPjsR7Jf/gS0
X-Received: by 2002:a17:906:16d2:b0:a68:b5ea:171c with SMTP id
 a640c23a62f3a-a69542a0f0bmr128002766b.16.1717483517574; 
 Mon, 03 Jun 2024 23:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCkyL+1eb4HhYrUjYTM1c6MEz6bRO5hWqWuOjWTRHopjBThP9l2GzNsYdZE3xRqAfvLdGQ8w==
X-Received: by 2002:a17:906:16d2:b0:a68:b5ea:171c with SMTP id
 a640c23a62f3a-a69542a0f0bmr128001066b.16.1717483517210; 
 Mon, 03 Jun 2024 23:45:17 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ed879eacsm351732466b.99.2024.06.03.23.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 22/45] i386/sev: Add a sev_snp_enabled() helper
Date: Tue,  4 Jun 2024 08:43:46 +0200
Message-ID: <20240604064409.957105-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

Add a simple helper to check if the current guest type is SNP. Also have
SNP-enabled imply that SEV-ES is enabled as well, and fix up any places
where the sev_es_enabled() check is expecting a pure/non-SNP guest.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-9-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.h |  2 ++
 target/i386/sev.c | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index bedc667eeba..94295ee74f7 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -45,9 +45,11 @@ typedef struct SevKernelLoaderContext {
 #ifdef CONFIG_SEV
 bool sev_enabled(void);
 bool sev_es_enabled(void);
+bool sev_snp_enabled(void);
 #else
 #define sev_enabled() 0
 #define sev_es_enabled() 0
+#define sev_snp_enabled() 0
 #endif
 
 uint32_t sev_get_cbit_position(void);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index a81b3228d4c..4edfedc1393 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -325,12 +325,21 @@ sev_enabled(void)
     return !!object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON);
 }
 
+bool
+sev_snp_enabled(void)
+{
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+
+    return !!object_dynamic_cast(OBJECT(cgs), TYPE_SEV_SNP_GUEST);
+}
+
 bool
 sev_es_enabled(void)
 {
     ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
 
-    return sev_enabled() && (SEV_GUEST(cgs)->policy & SEV_POLICY_ES);
+    return sev_snp_enabled() ||
+            (sev_enabled() && SEV_GUEST(cgs)->policy & SEV_POLICY_ES);
 }
 
 uint32_t
@@ -946,7 +955,9 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                        "support", __func__);
             goto err;
         }
+    }
 
+    if (sev_es_enabled() && !sev_snp_enabled()) {
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
             error_setg(errp, "%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
-- 
2.45.1


