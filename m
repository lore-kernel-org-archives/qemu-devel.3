Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB314C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5798-0002Ql-0j; Thu, 09 May 2024 13:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s5794-0002PF-4f
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s5790-0003ax-5G
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hcm1IKa8Lax1aQxNeVEkxaMcKmsJIcXMqbmtbDBUs4=;
 b=G1xoXpT2HHfG7+630ZxmN6DAtjZtKKTKHNKRwqLlgCHxAA7et5yfjqWdrOa2o93cGWyLXc
 XRbFTFoikzLiCLVLJAey+pzYocawMSmVr1AYqHNnfeQRITcWCvAEBOPVmNwyzePV8S+93G
 p4i4ACxL2IibyCXLKBg83wZpli9ZcwI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-3A3bRGTbNyyAAm5GD7kJSA-1; Thu, 09 May 2024 13:01:17 -0400
X-MC-Unique: 3A3bRGTbNyyAAm5GD7kJSA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572146eeed3so525443a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274076; x=1715878876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hcm1IKa8Lax1aQxNeVEkxaMcKmsJIcXMqbmtbDBUs4=;
 b=Ia7fjbUJkpw4ZeicBHOwOVcNNFkpTlu9rBau1rozlfvbmkNktbaCIa5dWSYxxMUnBN
 q57Yk3eLby4aZ5q7IosQaKsO0cF1pzyOes5ZfRokDJssoWI/0wz2cA0GJhyOudYJOt1E
 o/QqWV2pG6qphvYb4/beW5GTF+fth+9hPIMZyXyHioeOnFpztXKaGCTsbgk0X446+YvD
 wEMD1gYSt8mq5UBbnIz+yBDyR6rlKBj0PIi31WnjYAFNt2b8Td8Sf7XEexny7a6aYCnl
 f2oaEW4UedtGSExQVNlBAYtp5LQC2Fb/e82q5Lcl62wFPm1ZQIk2j1v+vx/jUJaFqbNv
 NMwA==
X-Gm-Message-State: AOJu0Ywn/YfOlDPKDbvgFHRHpVWdjCnbjiUNvE8P4x/Sluqh69QNxnc7
 lT4AZ4Q+AWn43X24fUniRFIK4hr8ST9Ebw5Osapxw3QrcO4QDRDLXEaGxfXXdlUC4SalLXjdRPs
 XhLA+9A6TuVa9Pa6cef4qtZGnnGjFSeTBRJrwRYEtKpztjo8Qt/U1ci+h7QmL3qrjT6hWckKmO3
 fyuB+Vq8gAvkcQ00lxmWRzGmGMR26MsEL+/PVL
X-Received: by 2002:a50:870d:0:b0:572:5fff:accd with SMTP id
 4fb4d7f45d1cf-5734d590348mr230616a12.6.1715274076032; 
 Thu, 09 May 2024 10:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm9+FqysnC6/VwSzSZ14Ys8hBrm8NopkBaatfbB6POVSgRGtxAQjSM8OVv6l9TDMSvhi+dcg==
X-Received: by 2002:a50:870d:0:b0:572:5fff:accd with SMTP id
 4fb4d7f45d1cf-5734d590348mr230600a12.6.1715274075691; 
 Thu, 09 May 2024 10:01:15 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7d6esm880328a12.72.2024.05.09.10.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:01:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 13/13] tests/qtest: arm: fix operation in a build without any
 boards or devices
Date: Thu,  9 May 2024 19:00:44 +0200
Message-ID: <20240509170044.190795-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

ARM/aarch64 are easy to fix because they already have to pass a machine
type by hand.  Just guard the tests with a check that the machine actually
exists.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/arm-cpu-features.c | 4 ++++
 tests/qtest/migration-test.c   | 6 ++++++
 tests/qtest/numa-test.c        | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 9d6e6190d55..966c65d5c3e 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -632,6 +632,10 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    if (!qtest_has_machine("virt")) {
+        goto out;
+    }
+
     if (qtest_has_accel("tcg")) {
         qtest_add_data_func("/arm/query-cpu-model-expansion",
                             NULL, test_query_cpu_model_expansion);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5d6d8cd6343..31045b69fa7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -813,6 +813,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         kvm_opts = ",dirty-ring-size=4096";
     }
 
+    if (!qtest_has_machine(machine_alias)) {
+        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
+        g_test_skip(msg);
+        return -1;
+    }
+
     machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
                                       QEMU_ENV_DST);
 
diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 4f4404a4b14..7aa262dbb99 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -558,6 +558,9 @@ int main(int argc, char **argv)
     }
 
     if (g_str_equal(arch, "aarch64")) {
+        if (!qtest_has_machine("virt")) {
+            goto out;
+        }
         g_string_append(args, " -machine virt");
     }
 
@@ -590,5 +593,6 @@ int main(int argc, char **argv)
                             aarch64_numa_cpu);
     }
 
+out:
     return g_test_run();
 }
-- 
2.45.0


