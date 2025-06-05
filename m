Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E18C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eI-0007jz-Qg; Thu, 05 Jun 2025 06:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dm-0007NN-7D
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dj-0001Gu-P2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ww1lY6S2uTksI0wQpy/g8QzaKoXGCoLz7u1pFjqzdyU=;
 b=hzYZYCCEOIGI2O17kfppDlcVFL6wqUiGB50FhPiBowXlBUFguqib5zA6XAhpdGV5EJp5Av
 +ao7bqJ0cHsP/j3a22C7yRfQnMyxEK/15+vhMys4mcItYmsWAgRoWCuHnzKoMDztLkcFRO
 G9GhGK/GoWDemdRMD8vLKJ8OsifJUEw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-7to9j1mIM9-Nwr3ONBdPVQ-1; Thu, 05 Jun 2025 06:16:01 -0400
X-MC-Unique: 7to9j1mIM9-Nwr3ONBdPVQ-1
X-Mimecast-MFC-AGG-ID: 7to9j1mIM9-Nwr3ONBdPVQ_1749118560
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d9f96f61so5307305e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118560; x=1749723360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ww1lY6S2uTksI0wQpy/g8QzaKoXGCoLz7u1pFjqzdyU=;
 b=KR6ZokFGqi9ggeCME1Y+4Olmbh/yrOgXLWScf3wSxrEl+fQVeGgcPrM5gkGbLvUMwg
 fg0pL/35mq3fCVBekU0dC/MctRaIpw5eXPp8NC7tK04CTeP6GVT2zkmpNvmITQEjqmtI
 jk7sJ/SUep3tsJCakcjSKNe3m/3pSo3Ooe3JWV/FJYjdH+FqId5tx+1QO1qqGYU3X5Vl
 2euSveOSFXc1bqDNH6+ndZvHFuRiUkWkiNbFnNvYy46MH+4HBT2Vvlvv1BKl2YDwPu9b
 aMFniQxMR/WPsUDBpNgDuABIU53tiFuKOdYEcv9fYnKXu29IeS658AvlzFHqsaQBSUWZ
 Mw6w==
X-Gm-Message-State: AOJu0YyHMrU0/lKdfKoik9+cGg2MgOEWsrgBo/qD5eEHkCheP37hi/Nt
 vEX+CRDxW2VhxAsaA6XPGO+cwpTO+n5vo2PcgVtKWUFWYXDj7BnncPeOy2I6O0IqU4nnbGVgANs
 5dtqGKXk2lOBiMoqBfyw/ed0o2irlQuD8sk4vyk5kVAJ2Ow82rGgqNOcc6UAs4IJLLrzPO2rZ9l
 g7o5qoFTP/hiIydY8vI5KbNGUjQL4McdCrAUDnPhCX
X-Gm-Gg: ASbGncvU/oXUrrBM5/PFUru7OdH1IxmC/h8diqN7omP1hLpdsiHIJxu3PvS2PlaBDKA
 Nm8durXhkPybm54KBVlUjWvJj82Qb9S09Tu8jqUgJbvg+KgC+e3CtZEF9fOtzV4puxIp2kqFJAO
 Yo5SuKjH+1s/+fQwanIdSWpx8vvBPkxOlOT6GBHpQ7Qn+XbjsrnQCT0WufMVY3pE3L8wTgfZE2n
 mYLa2jzYqj9w8V4cnvCwGgmRP1u9enzF44uRj+K4s0eAS8cmN5ia4ntFt00LfAcsZtq0HlhNpzB
 JHDYTcvV87ic8Q==
X-Received: by 2002:a05:600c:35cf:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-451f0b2b971mr50215335e9.25.1749118559719; 
 Thu, 05 Jun 2025 03:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA7uY2sJxfenVRpiIC/YNB1/Nm4cqdZYFWdoBOao82vWmscWVycTOEpBupm77P3VZTkOqY1A==
X-Received: by 2002:a05:600c:35cf:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-451f0b2b971mr50214985e9.25.1749118559178; 
 Thu, 05 Jun 2025 03:15:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb22a31csm13562505e9.36.2025.06.05.03.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:15:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 05/14] util/error: make func optional
Date: Thu,  5 Jun 2025 12:15:34 +0200
Message-ID: <20250605101544.368953-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The function name is not available in Rust, so make it optional.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/error-internal.h | 2 ++
 util/error.c                  | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
index 1ec3ceb40f0..ff18a2086d2 100644
--- a/include/qapi/error-internal.h
+++ b/include/qapi/error-internal.h
@@ -18,6 +18,8 @@ struct Error
 {
     char *msg;
     ErrorClass err_class;
+
+    /* Used for error_abort only, may be NULL. */
     const char *func;
 
     /*
diff --git a/util/error.c b/util/error.c
index 3449ecc0b92..daea2142f30 100644
--- a/util/error.c
+++ b/util/error.c
@@ -24,8 +24,13 @@ Error *error_warn;
 static void error_handle(Error **errp, Error *err)
 {
     if (errp == &error_abort) {
-        fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
-                err->func, err->src_len, err->src, err->line);
+        if (err->func) {
+            fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
+                    err->func, err->src_len, err->src, err->line);
+        } else {
+            fprintf(stderr, "Unexpected error at %.*s:%d:\n",
+		    err->src_len, err->src, err->line);
+        }
         error_report("%s", error_get_pretty(err));
         if (err->hint) {
             error_printf("%s", err->hint->str);
-- 
2.49.0


