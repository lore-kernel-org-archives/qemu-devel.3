Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32C3C5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuiA-0002Vs-PV; Fri, 30 May 2025 04:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui6-0002Tz-U8
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui5-0004aR-H1
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myOvVFZKA+ce91dh+2uxifrByBNZxhGHP7Vbe62GjBw=;
 b=WC1Q50b3Vq7rnv00hjhZL7dGR95lt7biFl9HX0iMVIm1j245cIgO4bIK+uO+P+X1YL601d
 IV3K5KdOCWVLP4TVfAcOC4TuD4R0MuBDBIt+tMhyevAnyEUItJI0B0DcH3+V/ZPWS0dW1v
 7pua9AF9AseRW+cFRsR6880789E5FvU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-C2pr7AM5P02nwvMsW2CE5A-1; Fri, 30 May 2025 04:03:23 -0400
X-MC-Unique: C2pr7AM5P02nwvMsW2CE5A-1
X-Mimecast-MFC-AGG-ID: C2pr7AM5P02nwvMsW2CE5A_1748592202
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso162788666b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592202; x=1749197002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myOvVFZKA+ce91dh+2uxifrByBNZxhGHP7Vbe62GjBw=;
 b=adMEpoAip6H01eOSLqQoGwvn82n49GeWlFBl8W51R23g0hzOb3+27OMBIXsU2UqdSM
 TbTmjGI5WScBShmltDu+xA6lCirbt0Gt3fDlAyOl+BTWYSKEEy8NZn/9Ir3tWiCUddRA
 CuW3krnDSvCyFJnWQwumg7BveaiqeyPWwIv8bhZMlB91b1hzUtFB4bC8yqk7QczlPfF5
 Fb/agnDXDFDPIUpycEqmbpAZBZ+vzBKDpFU+QswbAEzK087ZctC/wtRh9wJzzQpabN2i
 SABZETjmkdq0flxLbSySHWyQbxcewrQaWTsyxLAt81kfpyqxQsb8gGd7/bqHyzTi3lo+
 DGCg==
X-Gm-Message-State: AOJu0Yw58hyQZZ8640KKOEg/cQbSER5OLqgvKMdGncyg6D7DuHNFQ6Pr
 R1woINR92r/YPi2Vp9a3AMCVVOirRA0LNje4rEsmhZf/Y+K+7dmOPneHWXhsW0oXnnYbUwdycnj
 Be/UzuLGkZQTzheoERUJHAvC8MvwW2ecy99djc/KqS4o+HRsHuonE5r1CWxger0hRdcjFgcSxOx
 Emjed7eM0PWRwk9OsPUvvSB4lB0yQVP5thZwAHtLg/
X-Gm-Gg: ASbGncsgvlaQtJnih9cbPWTtY9T97gBMMVDoRcRmPUQ9DWbrwqDPOK/9gRRZk9FiPXH
 0ZSESzO0DJd+eYAlLb0ZZXjv4aCEXaojfOXYF8XRPaOoFfZeTRQCY64UPDTmUcQnOgogSq+0RxO
 lOSRA5kdv/ZK2WmjqBdFP1lQOq84GCTIQ2X/IxNZj0onWtBH6XpD6RM2Pv7aRGMWlu3Lo9cXGyS
 1esr1vTEEOH2tQIKp/Ypk0VpGa+9TmO95kI42LTU58PrweQQVF4c1CfuLymaMNkjhwyRJcLKyNO
 hJ7qWyzlo52T7g==
X-Received: by 2002:a17:906:478d:b0:ace:5461:81dd with SMTP id
 a640c23a62f3a-adb36b05802mr118174266b.3.1748592201662; 
 Fri, 30 May 2025 01:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGudTLYnNAM1SlXn1/5qLjhSkUub+t2LTPYnLarw/rLSgeYw9bvLuyVa3Da0r88P1XO23KT/A==
X-Received: by 2002:a17:906:478d:b0:ace:5461:81dd with SMTP id
 a640c23a62f3a-adb36b05802mr118166766b.3.1748592200534; 
 Fri, 30 May 2025 01:03:20 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad3a6ccsm279233966b.156.2025.05.30.01.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/14] util/error: make func optional
Date: Fri, 30 May 2025 10:02:57 +0200
Message-ID: <20250530080307.2055502-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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
 util/error.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

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


