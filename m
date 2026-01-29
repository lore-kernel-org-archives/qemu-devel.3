Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F81D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyM-0004V5-G9; Thu, 29 Jan 2026 12:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyI-0004LV-Vf
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:22 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyG-0000dD-Ip
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:22 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso888276b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708299; x=1770313099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Adf4h3CDLT/aaxvTVJM3JKdsOLodwkUsTuO/3VBrEfU=;
 b=kEkR6x5En7eR5IZJWq+HEWnxecGSeTwIMn8l00lhKAbu9Qsl5Dw1yi0WmJIpuGXeCM
 muciUwmfW8rYhQC4epHRpsA0D3L2heu/m48vWMdn9ZDOdC35FSeP+7VPsKSLr6hVxBK2
 j3WcChtNmVxRfgXTPxBxJituCNAKw7+UJEhgxgxnAs4ms6E+CrgiEx+fIwAm4wEiNZYk
 f8XLz1MCSnQKqGhXLckwG232ILbFG4Y1XNFNlbUlR4LfiaVJnApj+D1Zo1hxyV2IdFFw
 QeNtcDK8hfREdjD3ndMO/tLKZJkIR4d/TY+gscs/TPvnira9R+W7lRr5gnrhbo8r3LW+
 3/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708299; x=1770313099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Adf4h3CDLT/aaxvTVJM3JKdsOLodwkUsTuO/3VBrEfU=;
 b=udfpx3nVZSFuG0BOigkzr5yAWebh/rBa7kukL0W68KjON6L6W+pO9Lc/T11J6X1nM8
 6L//xXWnO0qg0d5fzUEM3mdTP7Vo/9S6Q/hc2TYN015C1BBsMXA5/68QQ9AgamR0GyiF
 3RUvyNOa8tQA2VG/1HoqTZKk8IQcNnRO4Z5lRJUozfvbuiXU0RMIJCXhbeZwJimPN8jp
 M1bUIUUu7ejcoaS2ZayyF9btexERIUHn+bHafPUfyvmsi7S5taNHu0QuhD9wXsg431zy
 npRtLBpsu0Zcc2/AYIW5bEjWEEbWQgllRNa/asr9jFHjRyePbGt0IHna+64ez+apt9bK
 XDDw==
X-Gm-Message-State: AOJu0YxiMhH6KVbfArQ6dXc1UyGbx2hU/5EM2MdnxdQvowqOTjMLV0Xk
 RvNyYktr1hoU+WezkXVtpMMzr5qZj6T7kzbwAwA2+NHIlwW36rcI5dCar9g1Lq17U2mJ5XS6q+F
 LBuZy
X-Gm-Gg: AZuq6aK7NuaXQCS/fs0GDg7/Mvi5OzcEtaQSLIlOISdICdIvgFkNamVdkUHvKcOaPI/
 p9QC8tUjpat1+SxjZbNrH6nFY8oJHn+042YeNJer18C4sSmQi9BbfR3zViFdLE8MjbFz4pLLl0C
 GK2fup7qPocwYF/RoxQ8f439pJB9UeiG/TR/LZd8YqMx2TvS+oww3sNP5+ZCAmSoDNNkzzyOTlM
 lDk74wMtO8bW7tf3r5j9NW6FJNDNl211FuRwpHThQqCSvnURITDb/Nkj0zguBpELuU8bplZzYgx
 TvFcOKQwrYIUijel5F7E8Tty3JsgCob5RkzAK8LkJSURwDKSlz95a+p1sxWEGHrL3+lfUUROnQ/
 6qA49SEvXHRzkvx1UpjihM/pFr4M0+PRyKIseb/q/jpnALJcte1I82PaCCWxFbPE9b6kre4An+i
 VHu484C7FS5A83vhU6BwtTO/4qi+wurl8iJImI4l6V6Wa1K3DUqvBIM6V0vhHhBYDX
X-Received: by 2002:a05:6a00:3929:b0:821:7c07:ccb0 with SMTP id
 d2e1a72fcca58-8239208364amr3635522b3a.15.1769708298832; 
 Thu, 29 Jan 2026 09:38:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/21] contrib/plugins/hotblocks: Fix off by one error in
 iteration of sorted blocks
Date: Thu, 29 Jan 2026 09:37:48 -0800
Message-ID: <20260129173811.138036-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

From: Alex Bradbury <asb@igalia.com>

The logic to iterate over the hottest blocks will never reach the last
item in the list, as it checks `it->next != NULL` before entering the
loop. It's hard to trigger this off-by-one error with the default
limit=20, but it is a bug and is problematic if that default is changed
to something larger.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/f1ba2e57c6126472c0c8310774009f2455efc370.1753857212.git.asb@igalia.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index d3dd23ed9fa..cf4d6b8c363 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -82,10 +82,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
     if (sorted_counts) {
-        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
-        for (i = 0; i < limit && it->next; i++, it = it->next) {
+        for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
                 report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
-- 
2.47.3


