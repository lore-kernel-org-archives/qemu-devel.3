Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EE5C021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz65-0005ck-0m; Tue, 11 Feb 2025 17:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz62-0005bg-7j
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz5z-000536-Tu
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtKB83nCEIcfUbQsfBWETjnjuPR1FjREZuxsSZmMbL0=;
 b=IPpmzgE9imYLua/xnW7SGJ81UL0U+ba5HMjOkB0Mhwq61+Gn93ecdjc4JZaasAFZ0fUjn4
 aOLV/UPyFqImh+mM/nbP7z3ATn9eFWvf3l4ymrRBjPAr2NzpbQ/hwhOyg037YKMXUxIeT4
 fPk9EXhANfqbH0n3ZSzxBx4Gpa8rFy4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-zTBhmZclMY2McRWCTTQqwg-1; Tue, 11 Feb 2025 17:51:10 -0500
X-MC-Unique: zTBhmZclMY2McRWCTTQqwg-1
X-Mimecast-MFC-AGG-ID: zTBhmZclMY2McRWCTTQqwg
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-724d17262dfso712909a34.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314269; x=1739919069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtKB83nCEIcfUbQsfBWETjnjuPR1FjREZuxsSZmMbL0=;
 b=pskeYWcu8Lqe4j1ogj7SMDbWcFGyxjfP+wNjkuh0DFCpgSXZgFHYCL3rcXqYEOKfvo
 d1q5I9XIIbS/XOctZLGrQao6eh7vz6cJbq6APMb4EtE21UPVxh/eRCjPkUIhbVhNKg99
 +U+9zy5FvEzhhXCcvnJq1V6smY4GdS9iLXsHZBCfs8fzF3PJxB+ws3qVUMzj1sT5hxuy
 YRl4Z+gg76KQITylAB9p1dcKeNSVDryK2UmXtcwOFVlhvNraZnDJ+pk8iYU0mw/2sMJe
 fNXp63fqIsIwwNAhWoNl67RZWwfyjjexa2fzMa/B1z3dYc7UmxYXGz7ZaFr7lDNn+H0S
 NQ7A==
X-Gm-Message-State: AOJu0YwP4YE0Q7cIi1imahvpKGHF0HrsWtBE7PU/uGAB/coSAeBxf10Q
 DW9eaRHzk7wv+79/1TlGPFZUevoagbWcbtJOP+d04Gd18ofvNjWGK4okNPLxFLOgyvte1BboXg/
 PKTUbtYFq7+Y3OIBnmTfl7/WhdIfauIkZkTZ9y9++5GA8VEcnQOKOyb2C4mE2id93KROF6K3sJy
 UcXVG/bvw3E3frgRVJxu+9GbRmxcGaEwsAgA==
X-Gm-Gg: ASbGncsokzFki2tZ4QiXnxxBALdLxmNGfyOR8g6ArUTrTZbEML/aVoqdxPpQBcyQJRn
 xnE7Q6FK1fcNPWCef9PQr+By9OZA93EN3t6AKXpk4yzJeXn3LqVdFrEcik0d1ZAQEKBNpwHZLpF
 fog35xUSaIhBXiV0Z5sncuo6NLOndtH/gKgvKKvVUjYbv9avCMvS2Bxb8sIVcEjqD6v6hIBNofd
 Og5Tlb0aQTW0Mmp9hv1oboxz0xE93Id3RXPsco6tQzOpDc+rgJaiVLl
X-Received: by 2002:a05:6830:3881:b0:710:fef4:3c92 with SMTP id
 46e09a7af769-726f1d17825mr996842a34.21.1739314268937; 
 Tue, 11 Feb 2025 14:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7BhxmEAcP5cvyNQrF3iK+rfkuaRAMaEMgG64EKe4BizwGguLyDBbiQgoUU6MlNQoQa/kstg==
X-Received: by 2002:a05:6830:3881:b0:710:fef4:3c92 with SMTP id
 46e09a7af769-726f1d17825mr996819a34.21.1739314268502; 
 Tue, 11 Feb 2025 14:51:08 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 03/14] system/vl: extract overcommit option parsing into a
 helper
Date: Tue, 11 Feb 2025 17:50:47 -0500
Message-ID: <20250211225059.182533-4-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

This will be extended in the future commits, let's move it out of line
right away so that it's easier to read.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Link: https://lore.kernel.org/r/20250123131944.391886-3-d-tatianin@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/vl.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index e94fc7ea35..72a40985f5 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1875,6 +1875,19 @@ static void object_option_parse(const char *str)
     visit_free(v);
 }
 
+static void overcommit_parse(const char *str)
+{
+    QemuOpts *opts;
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
+                                   str, false);
+    if (!opts) {
+        exit(1);
+    }
+    enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
+    enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
+}
+
 /*
  * Very early object creation, before the sandbox options have been activated.
  */
@@ -3575,13 +3588,7 @@ void qemu_init(int argc, char **argv)
                 object_option_parse(optarg);
                 break;
             case QEMU_OPTION_overcommit:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
-                                               optarg, false);
-                if (!opts) {
-                    exit(1);
-                }
-                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
-                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
+                overcommit_parse(optarg);
                 break;
             case QEMU_OPTION_compat:
                 {
-- 
2.47.0


