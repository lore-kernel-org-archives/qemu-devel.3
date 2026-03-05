Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1460F3D31C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBMb-00089n-LP; Thu, 05 Mar 2026 11:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBMS-00088Q-Nc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:15:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBMP-0004Wi-Kh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:15:39 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso55302155e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727336; x=1773332136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66f14nHgF3hsPxrBBUn4yi70/4pZ5+fvKw9BgRnowjE=;
 b=yh5M28cbnQVrp/wkm1WVb4mY9i+CuZAbREB35P/j8sDWPevq2itKkCc1IV6e1hYh4/
 93U3mS1DmUWLwLNth7xc1WDTBtlPqOn9Fwxf/11yNgfjWOVBX51HA9JlsEb80Ou84fHP
 5r4/v7g5paGlGz7mw6KlPySbWN+uD3JDpzODPc5g12Mi3TQfWVvQQNG+1q5qx9LmYcCt
 TTX2PyHiTcqgYjnECF6JaOx2vHDBKRr3qiNv3lTHAdT1EAc/LZpzf1ldw7VWZEn9nurj
 bFqh+/LfudU5O12T/OClxaHIMxz6mr4qm8ArX7Y+xBIAlUrdHMqdJoLe0KZjeU+cCFtT
 44vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727336; x=1773332136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=66f14nHgF3hsPxrBBUn4yi70/4pZ5+fvKw9BgRnowjE=;
 b=flb9CQ1J+Vnd5QFHsVor1H39pPtGR6272cnqtsMNLPdLX21g+Bv0/3eUZzrx5w3nn9
 yxOmEgDo2Sw7KXa2MPkbsqPSFohgey05XZk5IVQ0hvo84HII8nzUBmjbo8T26xhsg5xb
 PKGMcbzWeqV3S8H0Zxy+MXqIuBPxw+MlV1q0rGbh2arNvJAnWGN3WN6ImFGrG6ykeShV
 eVSBbvh2tiIMnisKstV+aM/fOC2rT+tQL1RrfWCg2jML3QADrypXGQZHgQ1cXCYrvshX
 n694xO82p6DJDOu84KgI9L2xO0xbIsYUriPM+6fzllZmDOilzJEDq5yemsnFbZrdlMyH
 Vbkg==
X-Gm-Message-State: AOJu0YwT7GZ3aTVpUR87Mle5rz7dw350BU9b/4MkQdiFExmNsJvrV+q0
 2LgQsaxHLqUINhplt5kUXgkIwAWJpFYlKv0C1JPaOyX25tFCFvKUx2D358DzdSJHQ4rmOJZHc2l
 oxybH
X-Gm-Gg: ATEYQzw4F4SMI3/7rBFXgMfGGGHJJlZMRimzFqBtSZ/HWEZTrWwYMIcybSFv+PWrELu
 IvhJfWE/+qFeWx7EqxMoxfdW/XSmTQJ6yE0ATBQWvRCr0jOPpFu2LweQkT16ye4GH1H92vgKIq1
 PSENFdb4rvg+yfe07+YwCH6TYt3FPBOU/jR6k2rSOrTQuECNFGtZeCs4MlVfk3uIcHMdNd5yIwK
 5OKJAsW1XDB2lkYRrnDh5BiftrC+DsGtuaaAYfcaE3X8OE/DJO0w88PkWuTOI5EIKbY3KyRh1xD
 Xne0PrJB/V+cJ3GY+wbOe4ygkyea9z/zxX5u+2LBgp4btAWy4c5NhC70tuMEnztmIjhepzLp+bN
 w7wxoi2XsO/RYDdzLqbNK6CBSgjNNFE/frSap8yXBb4Bl9tpvgtx8+6kdran39dsExulhx7Czks
 py8lqmfYCUgLx4hlayObHQl8r0uH1/XnqGek1fU5UgLP3yjOAZVfeZxmy3skN0IRLQ9Z5cy7BHE
 rENdlsoeIBQyeIdr/RK1h3RulN6AwQ=
X-Received: by 2002:a05:600c:8189:b0:483:4b37:8620 with SMTP id
 5b1f17b1804b1-4851ee91f1emr45938655e9.10.1772727335989; 
 Thu, 05 Mar 2026 08:15:35 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad01d2sm53466465e9.3.2026.03.05.08.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 08:15:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 2/3] tests/tcg/plugins/mem: Correct hash iteration code in
 plugin_exit()
Date: Thu,  5 Mar 2026 16:15:30 +0000
Message-ID: <20260305161531.1774895-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305161531.1774895-1-peter.maydell@linaro.org>
References: <20260305161531.1774895-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In plugin_exit() we call g_hash_table_get_values() to get a GList
which we look at to print some information. This code has
multiple issues:
 * it names the local variable for the GList "count", which
   shadows the "qemu_plugin_scoreboard *count". This isn't
   incorrect, but it is unnecessarily confusing
 * it doesn't free the list, and the leak sanitizer complains:

   Indirect leak of 2328 byte(s) in 97 object(s) allocated from:
    #0 0x5589b0b72293 in malloc (/home/pm215/qemu/build/x86-tgt-san/qemu-system-i386+0x1a2f293) (BuildId: 26964cad9e3f81d35fc144d7cc88b53adf6f60c7)
    #1 0x78fd8cfa1ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x78fd8cf96e4a in g_list_prepend (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e4a) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x78fd8cf8b318 in g_hash_table_get_values (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c318) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #4 0x78fd84d1a90c in plugin_exit /home/pm215/qemu/build/x86-tgt-san/../../tests/tcg/plugins/mem.c:87:25
 * in iterating through the list it updates "count", so by the
   time we get to the end of the loop we no longer have a pointer
   to the head of the list that we could use to free it
 * it checks for the list being NULL twice (once in an if()
   and once in the for() loop's "while" condition), which is
   redundant
 * it skips the loop if g_list_next(counts) is NULL, which means
   it will wrongly skip the loop if the list has only one entry

Rewrite the iteration code to fix these problems.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I am assuming that not printing the region info when there is
exactly one region is a mistake, but perhaps it is intentional?

 tests/tcg/plugins/mem.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index f3992abc8f..1ee257f855 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -84,24 +84,22 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
 
     if (do_region_summary) {
-        GList *counts = g_hash_table_get_values(regions);
+        g_autoptr(GList) regionlist = g_hash_table_get_values(regions);
 
-        counts = g_list_sort_with_data(counts, addr_order, NULL);
+        regionlist = g_list_sort_with_data(regionlist, addr_order, NULL);
 
         g_string_printf(out, "Region Base, Reads, Writes, Seen all\n");
 
-        if (counts && g_list_next(counts)) {
-            for (/* counts */; counts; counts = counts->next) {
-                RegionInfo *ri = (RegionInfo *) counts->data;
+        for (GList *l = regionlist; l; l = g_list_next(l)) {
+            RegionInfo *ri = (RegionInfo *) l->data;
 
-                g_string_append_printf(out,
-                                       "0x%016"PRIx64", "
-                                       "%"PRId64", %"PRId64", %s\n",
-                                       ri->region_address,
-                                       ri->reads,
-                                       ri->writes,
-                                       ri->seen_all ? "true" : "false");
-            }
+            g_string_append_printf(out,
+                                   "0x%016"PRIx64", "
+                                   "%"PRId64", %"PRId64", %s\n",
+                                   ri->region_address,
+                                   ri->reads,
+                                   ri->writes,
+                                   ri->seen_all ? "true" : "false");
         }
         qemu_plugin_outs(out->str);
     }
-- 
2.43.0


