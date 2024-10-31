Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF9EE68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQn-0003hR-9W; Thu, 31 Oct 2024 00:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQg-0003dR-IB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:03 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQe-0004ph-MB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:02 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e30116efc9so392169a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347498; x=1730952298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpgvBPyGx65kpjq48fx4MpdW5Aw7ymp2tboHQxxKolQ=;
 b=FM//VtgL48k9OtEeWPfmQ3f0wtXsDJ2O8rPQNzK6SxUhLgPzaV5TTlx3gLvBd8bvCO
 l0zzzKjUVw12e19SDEatsOuccsFVhu6JslcAZWTCXGuvlHTZ64EPnsEAq0Hzi0JpqJkk
 36sKnzS1x0np1nsEw57InouMvDTZjSzbwvoMeMToaaH4MOWLLUzfxsByo6pWDG2CxWaH
 ZfD/X1h9wM47E1ILEXiQu+I1yUZosEe9Mt8lXeLlE56H28Ucksh1rjgsVk0oW863Xgir
 Vh/tT33ODlBgwbzvD+cmpom0z7nxA2aDgabvmNcg6ppCMdYk3u1ArX71ibi6VfpZhtim
 PNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347498; x=1730952298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpgvBPyGx65kpjq48fx4MpdW5Aw7ymp2tboHQxxKolQ=;
 b=cI7bDcW2MKaJPBJyR+uwMfeqhbYG9pJYU+dYNXgEnBctFDr6N4+DdpctUR06Iyngbf
 XXQBMfslcQRz5Sbo0U00I+Yl7tGaC9/20fqkhl05Mb8FGTMSb4gDGuo3YC7prtPBZAE+
 YANbm277cLYfxJl6n1T6kEXfqydydxgJw5Rp+iPyEZwTlzDzcNzz89Po9xcImfo6T02T
 MPml1+KvtPFy2ZaVDyVSBczOk1R8aieylxy1ZQmYa9ytzjMZwew9ksA1PpxR51whNcqY
 swUf1oyHyQrkKNj9xQ+TL4AGUXQguchHmNyJeSe5iJheXQKMF+5UDAb/d26963QWZ/Y7
 PDUA==
X-Gm-Message-State: AOJu0YzYxISZRl7a68edi13MZ4kzJlq3MUZIjvq1vYDGi3dtTQqOECMr
 b7QuklIfezAT5M+dYeclDenq/XB76abcWaLeXAILr3RdivJsqcS5jven3a+OYhYeOU0vTpWipDt
 IdjBYgw==
X-Google-Smtp-Source: AGHT+IGKeVwrQKTxPrVzUsznsDEhBcZ6belWBpoT0d+OrQfk+qtv6nOpV+TR2yOmlRGGGAYWdHteEg==
X-Received: by 2002:a17:90a:e154:b0:2e2:e148:3d30 with SMTP id
 98e67ed59e1d1-2e8f107354amr21150840a91.23.1730347498653; 
 Wed, 30 Oct 2024 21:04:58 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:04:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 02/12] contrib/plugins/cflow: fix warning
Date: Wed, 30 Oct 2024 21:04:16 -0700
Message-Id: <20241031040426.772604-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

contrib/plugins/cflow.c: In function ‘plugin_exit’:
contrib/plugins/cflow.c:167:19: error: declaration of ‘n’ shadows a previous local [-Werror=shadow=local]
  167 |         NodeData *n = l->data;
      |                   ^
contrib/plugins/cflow.c:139:9: note: shadowed declaration is here
  139 |     int n = 0;
      |         ^

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/cflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index 6faa55d10d1..b39974d1cf3 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -136,7 +136,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_autoptr(GString) result = g_string_new("collected ");
     GList *data;
     GCompareFunc sort = &hottest;
-    int n = 0;
+    int i = 0;
 
     g_mutex_lock(&node_lock);
     g_string_append_printf(result, "%d control flow nodes in the hash table\n",
@@ -162,8 +162,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     data = g_list_sort(data, sort);
 
     for (GList *l = data;
-         l != NULL && n < topn;
-         l = l->next, n++) {
+         l != NULL && i < topn;
+         l = l->next, i++) {
         NodeData *n = l->data;
         const char *type = n->mid_count ? "sync fault" : "branch";
         g_string_append_printf(result, "  addr: 0x%"PRIx64 " %s: %s (%s)\n",
-- 
2.39.5


