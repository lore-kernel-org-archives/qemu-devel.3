Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F09E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3v-0008L2-5T; Mon, 16 Dec 2024 20:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3h-0008Ia-Qg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:36 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3e-0004zE-8i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:32 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2164b1f05caso43438585ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397649; x=1735002449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUx/z/kSAyzvf2YQEv1ycgw2smpEnSTqQjMUa4oS88s=;
 b=KL+jpnPXdUs3udCGlQjsC46UYU6uOZBPcWj9zcp3Up58LNzsOa3jYDXqS+xQkKMbFv
 uniqjmBW9tMRAculV2+jRSoMZP1CTDYuCwSBfu7ItiziflUqpPxwHTaPQ/2rSSrqs1Gx
 UT+tGccBBjw2E24FDU2vZeuB44m0vWG3s1DF8qKg3MM/OlIUullcc5fl8hIfg07tJ9C7
 z2f8tDGBYszslDNWwTVMz0ehnXNybXfLgUeNyM7rvmeiV67zAGUQl8TSlZ5Wzr/7lmex
 XUjL/+heAnKpqoYUuu98e2p9PpjCqLrlvc/lueXTbI/zfCfSP24NF/cXpFW0YsnEv4JO
 rSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397649; x=1735002449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUx/z/kSAyzvf2YQEv1ycgw2smpEnSTqQjMUa4oS88s=;
 b=HWXaj/iuWg/jkVLpoUdomEN63lovtxvQwkb1o3zQWenxG22AE3S/oEXFu77/Q8MUdv
 B+bu/T1BHxYiQnMjfTceck9rfvzkEJ4LGrGrfV6qTmz1oVxrQ96pG7FR6IbpLDHuBWSE
 83RI7IGejvwgGNbaAeDf8070yV0SD11ePqAjfyQDeLg1ieADOffdW5pTlXAUkTbjdbFM
 d/4ubRgCCJpm8rv3Djb9p+Duspj6mwy6mLMvFnLE5S3MnytVJIicLvvd4FZ7ZqmjFMDo
 OoPyYoTRPaKFfuTnjNLQI9ifC5pr1Azxji2xeeGQS1wvg74WlFAUpEC6e+IsNNzu0pDM
 Sn4w==
X-Gm-Message-State: AOJu0YwE2peagQW4T858C/Q/dXb0KUoOImW6d2p00cinKMV3U1T44/ZB
 ONQcSBKjhemPyFhkegSyVvglhTtYwKsLwiQpGRWZKt/1snhs1H5G0wigZ0Tj1U3RDOsp7bl+9qH
 AnX8=
X-Gm-Gg: ASbGncsYvbW3d0So5Qm5rA8spj/HkBKC+TVH2sj/cL+UuCsX46gGYEmzlsxPzHORcDk
 G5TcxXENnOl2aoewvOGOt0/5shPKu50e6QkdDH1xLMpE3Ee+U9eEb1A2x+ZRAQVcIxf8YBTU0XW
 5kg5Y6CaO3PFKj5c0PCoJsEFXWnFU+lxWlfw1fHGM9xiEX1zNC6MXH8y5M9902gZATExlFTMC5I
 P2IbusRJ0sek45CT2J/Zntcnnlt0VVg3slF7ghUR8JFhv90NIrjXTdN/tkJ1En4U5y9L4tj2Zaa
 plqEntbqWA7rvzc=
X-Google-Smtp-Source: AGHT+IHI99Y90NE1wFfp/KJftXkx6z24BTKHfmq+EBay4HTqB6rMJZB43aazwBmT1zGzeHgfCOtfrQ==
X-Received: by 2002:a17:903:2c9:b0:216:3466:7414 with SMTP id
 d9443c01a7336-218c9009468mr24597185ad.44.1734397648750; 
 Mon, 16 Dec 2024 17:07:28 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:28 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 12/13] contrib/plugins/hotpages: fix 32-bit build
Date: Mon, 16 Dec 2024 17:07:06 -0800
Message-Id: <20241217010707.2557258-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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


