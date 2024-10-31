Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4482CD767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZM3-0000Q9-Jv; Thu, 31 Oct 2024 13:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLs-00005S-TH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLq-0007J6-R5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAf9Rw9T2ciU5LDleiHhXlQ4Sh6dCoA/J7BuqxW01SY=;
 b=gIkdRZ7ZUGWg5Pk+X9wejFnYiUTE9vbt8BB6g+IAjAurXFMQRPx/fwzbXrGE7R7mouDADN
 mHtwZfxoS+SHSAO+lMe+N6+m7xivTVHqSb/bbs/P1cXF2zNtGE91puwOepv07zq+CX5s+S
 N1YOw44L1tuRG0T3W6Je/5pR2cgg3ws=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-PZxhPfgJPruU6pY3SzE7uQ-1; Thu, 31 Oct 2024 13:52:52 -0400
X-MC-Unique: PZxhPfgJPruU6pY3SzE7uQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so8657995e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397170; x=1731001970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAf9Rw9T2ciU5LDleiHhXlQ4Sh6dCoA/J7BuqxW01SY=;
 b=SiR+NqRBJ74PzVly1SCTx6S2Ol4B60UZE0NZSkDY475lG7r0Je0HokUvEXtyfTf9PY
 e2iH+m8tbTiJRFUtGtPhOP/vVkwbHZCWdWeZwoTTi8xDGeA6j7NaM7OEmh5BnFZV0WaO
 2e7f2qsA8BYq4YucENVSBbo47HKXuSF+6tfd++6Yc227mQm5A0NrHhfi+IZ43uL6h0yK
 N5shhlYBy0LmHEaijsVid4iCs1hAG4r/cIpmLLWsqZckkqggC3pbex1kQwFoa35FRSAk
 IyhVGAaWEmWcpp8ta5MVWH+z8KK4KcckRJQDcJOn/0dFbiJcxor5/gi1BFx4LzcHvIPJ
 yaUw==
X-Gm-Message-State: AOJu0Yym7pmimcEViklNCWVbC7wLdLxbH7rK2SitPtGovoLBAX8a65no
 FT3mDJNWrx5/wsrw+dmDtNG6wgiZSsDBW+ugslaHdvPtY9qyCPjea1pNSbXIKxvZZdIb2HyHtGO
 q1v/dltlD2bJ/Przef1hjs1cwAcCCHPwIAXaAw9I+Ntgknd3G105SnFR5kL679lideFKQNatfQp
 I8aIb25KRN4+YQTVhdWXaReKh1yv4NVEeI3xKwpuI=
X-Received: by 2002:a05:600c:46cf:b0:431:58bc:ad5e with SMTP id
 5b1f17b1804b1-4327b80c8bamr31313555e9.28.1730397170098; 
 Thu, 31 Oct 2024 10:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHFVRilZ/WGc/Jk37hYCkpBL7vnxcMIuV+FGyMJlBZaErCn/Zsx6+8Osyi0Gg9+0fuWZhseg==
X-Received: by 2002:a05:600c:46cf:b0:431:58bc:ad5e with SMTP id
 5b1f17b1804b1-4327b80c8bamr31313445e9.28.1730397169728; 
 Thu, 31 Oct 2024 10:52:49 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b97sm2817710f8f.2.2024.10.31.10.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/49] qom: allow user-creatable classes to be in modules
Date: Thu, 31 Oct 2024 18:51:39 +0100
Message-ID: <20241031175214.214455-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

There is no real reason to make user-creatable classes different
from other backends in this respect.  This also allows modularized
character devices to be treated by qom-list-properties just like
builtin ones.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object_interfaces.c | 2 +-
 qom/qom-qmp-cmds.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 1f2aa133066..1a6f29c053e 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -90,7 +90,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
         return NULL;
     }
 
-    klass = object_class_by_name(type);
+    klass = module_object_class_by_name(type);
     if (!klass) {
         error_setg(errp, "invalid object type: %s", type);
         return NULL;
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 69a8e17aa80..46e4562300c 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -186,7 +186,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
     ObjectPropertyIterator iter;
     ObjectPropertyInfoList *prop_list = NULL;
 
-    klass = object_class_by_name(typename);
+    klass = module_object_class_by_name(typename);
     if (klass == NULL) {
         error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                   "Class '%s' not found", typename);
-- 
2.47.0


