Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166D5C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEl-0006vH-2x; Thu, 04 Jul 2024 05:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEg-0006lh-IW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEe-000889-RL
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRScqcX5QDybTFLfNWFpvTz+PpMZynX466ZxF4qnzH4=;
 b=ADkYR14syI8Mrpob96w3B5deOz/PhINzoQ4zAuDCJtG5Nvr/8JKKzapzdJxuQFHt3ntsN8
 oWu7JRctDsDaiIvWSJXloyW17Q5QRakqoYUXX7yzCZbPWrGLZx6q1GgAI9QIvOfy7soWHG
 ZVBhqyXdMWTeAv/eZinEKbHHTRym+bs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-Qg6uIkizPTOHD_QYMkfFbw-1; Thu, 04 Jul 2024 05:58:37 -0400
X-MC-Unique: Qg6uIkizPTOHD_QYMkfFbw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42648daf064so2826785e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087116; x=1720691916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRScqcX5QDybTFLfNWFpvTz+PpMZynX466ZxF4qnzH4=;
 b=qavvhOs/DTN/ry/pVDVLrxl8vEyik5Mad+2UTnQ/FPgXQ0Xj/N/YzkqI5rWWc7pGzu
 iCHiRt/AGpNqZ190mfjTMLDYnD25FpWFjeFvMBFIN7yW2rUUkulkR+IdMP6XXSz/YDXS
 jT8h2ctVIeChvnV7E7PuevRyWsZ2fzG1I2tOWBpLN6A44Q5Bf0rFT0YhXiRs9Sqbom0D
 KMTX5agfS4HuuUqIJFO6EuabWAEDzoH7JjFAB+xygcJsXIh1RUB/3+QDKVXvVnWUB16o
 kDYHyf3mfkKQummjGAKshBslFLG3Rs2u82fZLjfZphoOVMt2C2S1GO8ny6EY2H/EDoSt
 Kegg==
X-Gm-Message-State: AOJu0YyLIMbomC0fVzfiBDunYngbljj/JQxVxYymD+FSkFwqrOibU+1s
 sKWW1PjV3Km/RuBsCE7w3Zi27IL3UZu8XRsw3jtl5D69Tembqq3H0JcyPDcTVz17eL/op883aNo
 7HQDB6PF1u1MA4pPlBvjYWvS44rNBf+7Bv9eWTC63vrOlYc2RvV35ncZrCQVqfYcfdWr6aoEXcy
 +vtTqvSuQJdIaRdoQsNfryN9ZH3+Ztb5Sfm43C
X-Received: by 2002:a05:600c:47c5:b0:426:4765:b905 with SMTP id
 5b1f17b1804b1-4264b1275dfmr10103155e9.7.1720087116065; 
 Thu, 04 Jul 2024 02:58:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvHS8Ui8lUT2zZuT2ZO17MVP1SKwRLd/pL2wqAGdo1MH6IGfrxk7WBCAxWkzsOpWUxqdM99Q==
X-Received: by 2002:a05:600c:47c5:b0:426:4765:b905 with SMTP id
 5b1f17b1804b1-4264b1275dfmr10102915e9.7.1720087115691; 
 Thu, 04 Jul 2024 02:58:35 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d6677sm17316115e9.17.2024.07.04.02.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
Subject: [PULL 12/16] i386/sev: Fallback to the default SEV device if none
 provided in sev_get_capabilities()
Date: Thu,  4 Jul 2024 11:58:02 +0200
Message-ID: <20240704095806.1780273-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
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

From: Michal Privoznik <mprivozn@redhat.com>

When management tools (e.g. libvirt) query QEMU capabilities,
they start QEMU with a minimalistic configuration and issue
various commands on monitor. One of the command issued is/might
be "query-sev-capabilities" to learn values like cbitpos or
reduced-phys-bits. But as of v9.0.0-1145-g16dcf200dc the monitor
command returns an error instead.

This creates a chicken-egg problem because in order to query
those aforementioned values QEMU needs to be started with a
'sev-guest' object. But to start QEMU with the values must be
known.

I think it's safe to assume that the default path ("/dev/sev")
provides the same data as user provided one. So fall back to it.

Fixes: 16dcf200dc951c1cde3e5b442457db5f690b8cf0
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Link: https://lore.kernel.org/r/157f93712c23818be193ce785f648f0060b33dee.1719218926.git.mprivozn@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 054366878aa..2f3dbe289f4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -587,13 +587,13 @@ static SevCapability *sev_get_capabilities(Error **errp)
     }
 
     sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    if (!sev_common) {
-        error_setg(errp, "SEV is not configured");
-        return NULL;
+    if (sev_common) {
+        sev_device = object_property_get_str(OBJECT(sev_common), "sev-device",
+                                             &error_abort);
+    } else {
+        sev_device = g_strdup(DEFAULT_SEV_DEVICE);
     }
 
-    sev_device = object_property_get_str(OBJECT(sev_common), "sev-device",
-                                         &error_abort);
     fd = open(sev_device, O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "SEV: Failed to open %s",
-- 
2.45.2


