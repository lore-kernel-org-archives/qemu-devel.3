Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D574CFA47F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3iu2-0000nc-0y; Wed, 23 Oct 2024 17:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3itz-0000ml-PM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:28:23 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3ity-0007cp-Ad
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:28:23 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so157384a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729718901; x=1730323701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYFstZ300Z1RMHxxN1v3kF2XX3UeGjweCaXeStNcbZ4=;
 b=SKtdMHxMTlR2eazkK+VY9Mm1JeTQtUDgaOxWoa0Js4+WonIBEwNW2AmIorK0QOvNkU
 GVdyD8zJyxdyH5MztShFjQof4zjjIkgSy1cXD+IVEMjFbgmledpwYiqyLy9ILVIRVWqM
 kI6zVp9wN4L/GrfiRt+bRRJ14OUWunFz5ssd2ykzp1z/ky03RKaQTLBJO7AD+jjHwFRD
 T4IcyQTGLYsbZ1XWZtS1MurhCkHqCFCyXG3w7N3YnuiqfzMDd5LOJOiqyC5AtSi09Zo2
 PueEUmAAD4mIozywBPfHEMSq5AQXYfdYosd1d0/xPP0CXCxI00r/TtxxLGifKPasJbn8
 VMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729718901; x=1730323701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYFstZ300Z1RMHxxN1v3kF2XX3UeGjweCaXeStNcbZ4=;
 b=Mz6R3OnoW9oDPxqaotK7kFOasZfxORQvwYVgjtKU+iCjLkzP3MRSC02Zzc9idpn4zO
 qBJkj7V88d+QLsj5L4P2KUnbIOZU/y+x61pWjCV3UunD3iQYjG6jN+cNWs5o4sWaNxKX
 oLGnX9ixwBIxTN2S0DWxpUrdSCGH63DYjsWip3VXGHdBLoifwzbrg/+D1pclLp7MNxBP
 yqggLCmQ8frHSO0svZaq4GNYgWhKmQcwYZO0CPpP3ZBClFmYPZdkec2OCJX5C1gDb7SJ
 jn8uzfbxe1HshUj4a2N1Ip6UVeriVa8XtCKDfnga4vc0GjksxRwvS5a0rEy67M7/U5+/
 SjEw==
X-Gm-Message-State: AOJu0YzlHKFwZR+COlo1xcIUlYY7jM86XCfAAL/wJp6rw45xtZsCJVwi
 5Vbunkd4F/oJ66VIVrWfao2d9tcoRx7zVNa0ffVpcfO72vibbeHeD25hKY6qntXpq1r8uTMjPHA
 a3n9jVQ==
X-Google-Smtp-Source: AGHT+IHN/2vSsO/glVdl1/GTorHaQjw1brMmKD2uF2L8aDy4EJ3pWpMOVzr2ydMx1ysUyErGiuu6Wg==
X-Received: by 2002:a05:6a20:d8a:b0:1d9:2994:ca27 with SMTP id
 adf61e73a8af0-1d978bad9bamr4254073637.36.1729718900844; 
 Wed, 23 Oct 2024 14:28:20 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeaafab5esm7228137a12.17.2024.10.23.14.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 14:28:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 1/3] contrib/plugins/cflow: fix warning
Date: Wed, 23 Oct 2024 14:28:10 -0700
Message-Id: <20241023212812.1376972-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023212812.1376972-1-pierrick.bouvier@linaro.org>
References: <20241023212812.1376972-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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


