Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BF3F47CD6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFgD-0006dF-Jn; Thu, 05 Mar 2026 15:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFgC-0006cT-7w
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:20 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFgA-00068k-Cn
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:20 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-899fc265126so66558426d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743937; x=1773348737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yewNvrkaWayeKlBhTXGZFJI4Efdx0EXSDMpOkfMlPlI=;
 b=FfztDeIO3fQ7BMTtvR40x25e32QpheLQUdaI440q6YOarJIoreCM4kCJGYLHV6rbrW
 zrEPGGGkY8HnQFR5K1IGbuPR95I79u3f0fI+OMT2uTwAGW6Z6LK5dPUqsehv3k/LiYRs
 uvl8EnWQyi43b24BAACjc7nQJq9V/qIC4mkm8mxv3Whi1fXxho/O9zRP7b8h3rFrNeTs
 x+MF7kpjIogeAPAuv4pY8Kcg8ixBitlH7m1JyTp+AOHo9xanX9mJtw/rrR0N7BGzaLcb
 XTjYAIuz2a2WAMYe/M0oZxMiYWsrwhpNTTPsd/v5evOttaGqOgD4ccjG2tETVZzT3FxX
 t5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743937; x=1773348737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yewNvrkaWayeKlBhTXGZFJI4Efdx0EXSDMpOkfMlPlI=;
 b=LcoOkZpNCV0NDO0MgpaWY+JYKAf4Dwu+QTu3CBmkcpKlZXKZnQL117rL5UxLuarrZ3
 MY7rDFCL93Z87w0wF+drB2Ww+QrakQLjMOJ6Y//cjealR4veEzxoCHLTRGFBZy4fu7YJ
 /B/Es2ZTGtkeJjJpeTo55eizcxREQp8Fm5lN3+trH+iKIaN3uDBez2ClhXbN0E31+m9R
 C+UwpR8O0hKj3qy11Tw/AOHzZJ/u/xKjLHkdcsrGhWJP5e5u1/V6OwcgQcBwKfB5PcB1
 ObEJShL9f70pWBxasd7FDytm1611hao+kUAqHFgFietJZacpQDsbk1Am8ZrKY8gVgs3b
 7xhw==
X-Gm-Message-State: AOJu0YxhSFt5SXx1GWkFy/yiEnLqDOY+u7upT0ZFpBJp5J8f9qKhHRaj
 h2jrV+QccrBs7B5eXfHuZh6vLdDz+jO60aEHxxriRVK0hv5LoB8G/2vcRVsU79D796ttGEiNypI
 Hg2/f
X-Gm-Gg: ATEYQzyKomXx3D5LNcxgcTudVwT0G2Xr/LPITI5h+kvWQjIjDh8iAaT7HIjcX8yYO64
 JH56sIW+Bw7pM3GsSj2WAVIQq/zEu1FFQriIQCAI1gC3RjGShUkvH7TdR2qn8Tm24lDMVzjMWpj
 hNeMK0Xmm6ewocaTJZTr8yM+ZQOX1CEFQbDaAJGVInz0pfEB9xtL9VyM61V5iYKk4VW2AcYQHFs
 HNl0/nojZ94ItDLP66JMKGa3JrRDhKHeW/SZveyHMC728kg1WCQa5rho7+76JKpvteFFSsC0yzh
 R+67v7++LPjnZPhJYzrLFG9G3cVViL2At3QZvHWIQaAfRQKn9/kk9GTh3OQcwMs8Pu+kVQmJgkU
 NEBoGHVisGcdgcpjsO7+zpw3nxh+xvqRDYvXy654eHfR52L872aIwgU2CluZTs86pdL/dJ/XsQU
 gPi6ZEIGE/pNJmQfr0kvSenyJ6Cf9lRxh+mUH6iPhs2OH5v3Kct4R4utTZoX+ivqnwKzVdXpgcJ
 bkX
X-Received: by 2002:a05:6214:f01:b0:899:ad51:fb64 with SMTP id
 6a1803df08f44-89a19aee9ebmr111853156d6.41.1772743937383; 
 Thu, 05 Mar 2026 12:52:17 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 11/12] tests/tcg/plugins/mem: Correct hash iteration code in
 plugin_exit()
Date: Thu,  5 Mar 2026 12:51:51 -0800
Message-ID: <20260305205152.2121854-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf2a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260305161531.1774895-3-peter.maydell@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/mem.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index f3992abc8fb..1ee257f855b 100644
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
2.47.3


