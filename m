Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB33C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oAr-0001zO-8J; Mon, 07 Apr 2025 11:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlG-00024A-Nn; Mon, 07 Apr 2025 10:47:42 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlE-0001cr-9c; Mon, 07 Apr 2025 10:47:42 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so3697698b3a.0; 
 Mon, 07 Apr 2025 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037257; x=1744642057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=303oU4ivEV4o+skcvNL6xtz8+P6ObO0/wi+L6EFBQWE=;
 b=A8dg5gahA06cTrlzeBL9cdZHeTPb+3sTG1L7M9qnhgDprht7ofb3sD2Esb4bAbqgMU
 fUd3Y5CR3nzA30PvDKiEWgTJJbZKkm0lXvDmYzDvvopvscWNAjY42zp3Tn3nSr7ERlAp
 S3gVUAQASh7ODj6YeYgd3lySXA8eua44VejbpbeihFkHMcrg+BT1f2IffsSCT0IZacy2
 5rUd5S24c4Ti6Se11NA3aZtQq6Qq0POZazLFEEyoy+NH5JOB1jMD/VsaRyqel7Qwu1eE
 f+DK7WExJRB3twYDdrYl0v8E5JLE3ZZlcNw5Mf5ahRGryWlkW6Aa57PdncHd+MqJvnRT
 uCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037257; x=1744642057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=303oU4ivEV4o+skcvNL6xtz8+P6ObO0/wi+L6EFBQWE=;
 b=AaGzab3XDcqZL3UhNjOS8dEpOWem+iWBtqJirWB7kwb0pQGn2tP5k/c7xd4sigJ+nx
 JMRe3euCZf5SOPskriTWoAJdV3jmypPbAjRQCdlec0JwvWlZeJig+2q4gthQmk2SD90d
 2AOxHGdgpAj6R7np3OEI5+1P6rjRw132a1s96Q347QHjG7qjQ8FP0DVFfAvOugnotfYj
 F1ND1zHWsQooHkv3LM0Qg0JCwHdyAcB3AcEiTrP+w1jlTZTSYBXxX6CdkiReMMMfDyv0
 2MoKyqLrAMINdUeHreBaL17v+8S+V/HdqFAvJQuKvp5H9JXcn0w/JMGr140ZizLkLcxf
 bUmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8iOOdhnQHk91LaoVOaaJeZoBE2DAG0prPFzFSOEqz7xNw7QQa9/p8oxX/o4Z2o+V0sXjv5ippIQ==@nongnu.org,
 AJvYcCUkcRW7xNUJgWtBR3boYRPPmu7BRNyAmGukgurAkILmVSPAbx3TtG5h8Z47wsrA0mTs3/UUyTKLlBpF0A==@nongnu.org,
 AJvYcCXgzMDmIMnEXG6cSf6+S/Hh3GUpcx4+TXKHGqkIljDymHvrGMyYnesVIROr7LVyi8jrpzR6tMFPziIxQA==@nongnu.org
X-Gm-Message-State: AOJu0YwdVxwPbdbWXDIu9gI6o+hq+OMrLI7HYyv5y6XIf+jw+o4MvVTu
 /twmN53KlXStJilag8n3fSYzEUSimG6dHSKmCjgQXp5P5pBdLQZkkDRQnnG5
X-Gm-Gg: ASbGncsSberGk7eWem3Ihuk+Mg6O0m8M6ebar7QyfMfFYyKoaKlzqXuspTRJfmRF+Sv
 l5E6SKwIh1Q2QrrAE9sCiEy11Mt6xgRryTc7/2BVFoOTVHX+wvTNOWVh32ptUXBu3i4y/vsw1II
 p2XiuDU/Rap8dj9+lSGAQVSnaNRTa8jmI+DufqZICicbaEM2vTSk/lW8GnFFw8MpPNZgEyZAKT8
 trMqOGdQWPQk9+LcEVG5+b6WxpIFdaVLo2F9ScKCvKGZs3eOYd3fbdq7Zim4ehSKtnp6x+51Znx
 mENIJaDwsQRL78XY1joEK76AWOGEDer2mljeuq8mh1kUSvvBTmaqNDbPNY3/BQ==
X-Google-Smtp-Source: AGHT+IGZ2Wz0Y1VNTDZ7pixroI/TzMaEKIf24Xwu3jGbGdGuKfSQAcxOo2mpyOC9HsbIY+yWz/StLg==
X-Received: by 2002:a05:6a00:3a0a:b0:736:53ce:a32c with SMTP id
 d2e1a72fcca58-73b6b8c5773mr8623059b3a.17.1744037256768; 
 Mon, 07 Apr 2025 07:47:36 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:47:36 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 01/10] various: Fix type conflict of GLib function pointers
Date: Mon,  7 Apr 2025 23:45:52 +0900
Message-Id: <2be81d2f86704662c9fa33ceb46077804e34ac77.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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

On emscripten, function pointer casts can cause function call failure.
This commit fixes the function definition to match to the type of the
function call.

- qtest_set_command_cb passed to g_once should match to GThreadFunc
- object_class_cmp and cpreg_key_compare are passed to g_list_sort as
  GCopmareFunc but GLib cast them to GCompareDataFunc.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 hw/riscv/riscv_hart.c | 9 ++++++++-
 qom/object.c          | 5 +++--
 target/arm/helper.c   | 4 ++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index a55d156668..e37317dcbd 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -102,10 +102,17 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
     return false;
 }
 
+static gpointer g_qtest_set_command_cb(
+    bool (*pc_cb)(CharBackend *chr, gchar **words))
+{
+    qtest_set_command_cb(pc_cb);
+    return NULL;
+}
+
 static void riscv_cpu_register_csr_qtest_callback(void)
 {
     static GOnce once;
-    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);
+    g_once(&once, (GThreadFunc)g_qtest_set_command_cb, csr_qtest_callback);
 }
 #endif
 
diff --git a/qom/object.c b/qom/object.c
index 01618d06bd..19698aae4c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1191,7 +1191,8 @@ GSList *object_class_get_list(const char *implements_type,
     return list;
 }
 
-static gint object_class_cmp(gconstpointer a, gconstpointer b)
+static gint object_class_cmp(gconstpointer a, gconstpointer b,
+                             gpointer user_data)
 {
     return strcasecmp(object_class_get_name((ObjectClass *)a),
                       object_class_get_name((ObjectClass *)b));
@@ -1201,7 +1202,7 @@ GSList *object_class_get_list_sorted(const char *implements_type,
                                      bool include_abstract)
 {
     return g_slist_sort(object_class_get_list(implements_type, include_abstract),
-                        object_class_cmp);
+                        (GCompareFunc)object_class_cmp);
 }
 
 Object *object_ref(void *objptr)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb445e30cd..68f81fadfc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -220,7 +220,7 @@ static void count_cpreg(gpointer key, gpointer opaque)
     }
 }
 
-static gint cpreg_key_compare(gconstpointer a, gconstpointer b)
+static gint cpreg_key_compare(gconstpointer a, gconstpointer b, void *d)
 {
     uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
     uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
@@ -244,7 +244,7 @@ void init_cpreg_list(ARMCPU *cpu)
     int arraylen;
 
     keys = g_hash_table_get_keys(cpu->cp_regs);
-    keys = g_list_sort(keys, cpreg_key_compare);
+    keys = g_list_sort(keys, (GCompareFunc)cpreg_key_compare);
 
     cpu->cpreg_array_len = 0;
 
-- 
2.25.1


