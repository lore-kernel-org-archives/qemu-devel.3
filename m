Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6EAE7718A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgDE-0005Oo-Ms; Tue, 17 Dec 2024 17:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDC-0005NX-Ja
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDB-0008SJ-4U
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:42 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21619108a6bso44650615ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475119; x=1735079919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUx/z/kSAyzvf2YQEv1ycgw2smpEnSTqQjMUa4oS88s=;
 b=dGsTA6a27CRLRR0SkoTzkDvDT4QSGAmcYpjbnId48ypKSJWdedJu7btzVkSNaEvB/j
 GxvjshG4+Urcq8sTX6AAon+15G1tLItGSlthU00N/izQ/cUwOQuwxX6f9uZzlWNcd3DJ
 2n66znSXOu0BBlwo4BPRtKWMBf68ZsUMSZtKP4UuPcwfxm5QOHg18Uy1+2xrdqXWQDcC
 XaYrb5Az/ioxMgJ6FOU79rH1Y9EA6sW5x592gFeTnJiKg3PbEk0LoyCpXsAUcmVjLGTI
 y5hv6TVk7I6Q9oc1zHiat89zaEGfdzJ6H4+xf8XcAzcUva7BjgNK374U8g4xYphLSteX
 gSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475119; x=1735079919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUx/z/kSAyzvf2YQEv1ycgw2smpEnSTqQjMUa4oS88s=;
 b=tq1s/9lC7HMpIKqePxTYekCikZBQF0b6Ywjxu2xLKKuXiIPz3W+tj1b89tm/FQaQp3
 MO4Q2mkG98wk0aoHRJdCDiNZZaNj64J6S9deB08sPv3EcoRhO9Fd3JR0+MSROauoDknB
 sTgi1WNmT9K2db4jOO8KHeUON8cbuovEGX14lcUN7iSHBeFRf5Ylbxm79viKYlbRMtJD
 g5ZAV6dfXsWw9L8a1XeQULrHe2CifrJWzOOxpe5WwY94HlDZFcocTJay8HYlqEx5+BLU
 J5i8jsE7O3KuJFB12CKvVuq4xniuWUXzMRFBYf6E88PtUCgH7cIC0g4hy/Gv1QBYqwUm
 HJbQ==
X-Gm-Message-State: AOJu0YzEc7+bDUn1HaeBiGqtTY65XSbCpGtjJZOc4XzRxVk41Y2rnTDD
 cQ3VR40KA6xrloXFdZFniMhqMhXVXf4xZiStQfUZnYG0QnzAaL2vsMDhGouHZ03T4ezn3OLugLF
 GnLg=
X-Gm-Gg: ASbGncsroFAS0vuhdGJRRHW9iRMbtW/7oOPzBFHE0f8Er/9DQYW60fQrueH5hCHv8Yo
 his1FyABr/sa7tPMPvb1tm86GGyS6gibY7HWnjq8t+f4Utcd9AdlVUmdbvMWXI3mAd4FNWx5zX5
 LAlzeDjPqvP0d4zH3fNZvy+enUDGp/2a6ePdFTA8M84TUVEW0+52A+cOjdeXAZ5+WU4/y1bv+NM
 KPn587M7jQ3mpCG4/c5XWo+fXUPIy8hdngEWqK0OqAvkD3pg9pH6sgp
X-Google-Smtp-Source: AGHT+IFGOetp6+opKiK1RSaKW9+bDZX9d0G6jl5pXpeMnl/6tvmiQy90+KEVPauWhikWbEYTXaA3VA==
X-Received: by 2002:a17:902:e741:b0:216:6fbc:3904 with SMTP id
 d9443c01a7336-218d6fe1aacmr8664245ad.13.1734475119543; 
 Tue, 17 Dec 2024 14:38:39 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:39 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 10/11] contrib/plugins/hotpages: fix 32-bit build
Date: Tue, 17 Dec 2024 14:38:24 -0800
Message-Id: <20241217223825.2895749-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotpages.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 8316ae50c72..c6e64937194 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -103,7 +103,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void plugin_init(void)
 {
     page_mask = (page_size - 1);
-    pages = g_hash_table_new(NULL, g_direct_equal);
+    pages = g_hash_table_new(g_int64_hash, g_int64_equal);
 }
 
 static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -130,12 +130,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     page &= ~page_mask;
 
     g_mutex_lock(&lock);
-    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+    count = (PageCounters *) g_hash_table_lookup(pages, &page);
 
     if (!count) {
         count = g_new0(PageCounters, 1);
         count->page_address = page;
-        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
+        g_hash_table_insert(pages, &count->page_address, count);
     }
     if (qemu_plugin_mem_is_store(meminfo)) {
         count->writes++;
-- 
2.39.5


