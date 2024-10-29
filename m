Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616CCD2AB14
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 10:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5jNz-0003sg-SJ; Tue, 29 Oct 2024 06:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5jNx-0003sS-CY
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5jNw-0002za-02
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730197414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=o4r6Zjq5iqQmm4pTURpvjTCNWZpzGZScaEBPlHBJaJw=;
 b=RjvoM1J1XrnyVBLej0uAh/v3HiptaEjH76RVIHTbHhf5ahPro9hPKABUTGTj9u7FpelT55
 kR7Wd3/EgcFKMUCQEnvj+Lh72Xt2MSxefM4JT7Vt/hBTUPXdbRkGtgl8xy5B5N3Jf6X9Qi
 FPtaUseX+m3rFKcB1F85XEfwqtdRb1Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-tmLD-tpoNF-cUofOtHd-Yg-1; Tue, 29 Oct 2024 06:23:30 -0400
X-MC-Unique: tmLD-tpoNF-cUofOtHd-Yg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43159603c92so35540975e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 03:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730197409; x=1730802209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o4r6Zjq5iqQmm4pTURpvjTCNWZpzGZScaEBPlHBJaJw=;
 b=JchFQVqYiS2CUGGvhWEAjHiVTxxMRP89r9wpi8F/vqZrF3tMSJM4sTlQz8MXBI67rS
 3HuKjtG6+OeO0OOntteMLVjSECTcNUho8Y2H1tyaisqAFi3Xax/L7Vii/pPNSLr8UQhg
 xMR7b0XdUCsqXlsIuWOEZmsJfsCOcf8En/bsfSXc2rpxdu3SRhqamDrUhp9ZRNQIy8Bw
 LQBLEhogoePphf+HiES++jPXsY6jl6bnWm1IHwz6FqXLkyiOGMQDbkyBtZZeBDKGXPyA
 hokL8L1kOqp4tkprV9XOO2MrCDohigQZ1LY7sWsn9K0R29dtfU5TQq4BwQUl7AtM4mb0
 E/pQ==
X-Gm-Message-State: AOJu0YyrzKNNu/ig8Frwp2SG+uhuDWEw7Tq6MyMu15WwVXh6GeB8WxPN
 epFfPhYYOfvrB0Tpymn9blfsaJXwDdQeRA5KTJmaQU210fKEdMYTHz5XN16nYQSdnGrjqjIxz/O
 J8LNpdXf9j3wAKEt+HqTGfGt4ogHQ4ix8MluWUiLATi2tS4Tb3Qng5MiPC44Utpwq8T5azCPGEz
 hrP/QCIIb3OoojiflfYRimP2TAj5Q3LsF/0jt9nfg=
X-Received: by 2002:a05:600c:1d09:b0:431:47d4:19c7 with SMTP id
 5b1f17b1804b1-4319ac6e976mr102773685e9.3.1730197408770; 
 Tue, 29 Oct 2024 03:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOADmaEqunPvtO8QeCs9X7fTtaqXgvISPPFr0h6G3IkcWvAUo/7HQNtHjqYBQsmmc4JMHhBg==
X-Received: by 2002:a05:600c:1d09:b0:431:47d4:19c7 with SMTP id
 5b1f17b1804b1-4319ac6e976mr102773515e9.3.1730197408314; 
 Tue, 29 Oct 2024 03:23:28 -0700 (PDT)
Received: from [192.168.10.47] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b472sm174583035e9.43.2024.10.29.03.23.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 03:23:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel: remove dead statement and useless assertion
Date: Tue, 29 Oct 2024 11:23:26 +0100
Message-ID: <20241029102326.473133-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

ops is assigned again just below, and the result of the assignment must
be non-NULL.

Originally, the check for NULL was meant to be a check for the existence
of the ops class:

    ops = ACCEL_OPS_CLASS(object_class_by_name(ops_name));
    ...
    g_assert(ops != NULL);

(where the ops assignment begot the one that I am removing); but this is
meaningless now that oc is checked to be non-NULL before ops is assigned
(commit 5141e9a23fc, "accel: abort if we fail to load the accelerator
plugin", 2022-11-06).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel-system.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index f6c947dd821..61d689935e1 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -73,19 +73,17 @@ void accel_system_init_ops_interfaces(AccelClass *ac)
     g_assert(ac_name != NULL);
 
     ops_name = g_strdup_printf("%s" ACCEL_OPS_SUFFIX, ac_name);
-    ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));
     oc = module_object_class_by_name(ops_name);
     if (!oc) {
         error_report("fatal: could not load module for type '%s'", ops_name);
         exit(1);
     }
     g_free(ops_name);
-    ops = ACCEL_OPS_CLASS(oc);
     /*
      * all accelerators need to define ops, providing at least a mandatory
      * non-NULL create_vcpu_thread operation.
      */
-    g_assert(ops != NULL);
+    ops = ACCEL_OPS_CLASS(oc);
     if (ops->ops_init) {
         ops->ops_init(ops);
     }
-- 
2.47.0


