Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ACDF55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 21:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyylM-0007FR-CB; Sat, 07 Mar 2026 16:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyylI-0007Ed-H1
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 16:00:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyylE-00044P-Ov
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 16:00:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so45813025ad.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 13:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772917231; x=1773522031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppBvMB0MGQLX7SauKgF3WOflsJK22BcBvff7uKgpkqs=;
 b=IOLZoGZZstjBTOlN38Oy5fRXBtzgb6RwbDh3oF12fckyGLMULrp3yvZJeEA3wUneFS
 uYutQkJBUvQFh59a3G6tjtayLYC8/UQcpdTZwTFVMOz+5cLvdT1FhVgAKhT0hJZsR4zN
 EWPdiVMPKZJHTxkZo/SNXrbI7Lj0e4Zpmk/kZ0AmdoWHmxI0NEibmwcfYiSwX3G0ewsv
 17b2oEXbrl6B2d54GteWSAmSN6OTW8b4lwUIArPQBf8012nlgNqWJfyqOqh8TF27EyIQ
 8EUNx9MWixoUJ7bClUpYnnKudrquQFd4r6j3E5uzhZb6jv4gSO1SPtL7VYIemjBIaMrF
 wdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772917231; x=1773522031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ppBvMB0MGQLX7SauKgF3WOflsJK22BcBvff7uKgpkqs=;
 b=T3nMCO3tfTVC7+hzDivaksYZNXU0nogk6/mfWy73VhQ34B5sbkTZ6iN1oNlW7YZxyj
 YoekRrvOcQ9hy7yJlArU9sBYvaRf9+1twKbvuyaSq9QI9ZaLnYLaRYXzzq3BZalNDck1
 /g7Eroujff+Cu/q1/ljxDHKty8s2tBUGNsMq9uBzzVLHvqDixS99ApFPP58kPt5ixoqG
 J93auz7ZHvhjXM+21CbcOwaemgLR2EmVvtKQD/wUitj+YrnJVfdu3DPThbZN4Ojnt3QA
 Fm+SpQI49r3vDZdePyzkjJfAu1bekQy2mFrO265uBRUqA9NqQwsOXOUMCQxB2rmE8zDN
 ZNXQ==
X-Gm-Message-State: AOJu0YwZ/TWUnq9E+qX1ZMBN+BtWzNcYX+oZk9GQ78vWD0TPOkhXteMt
 2fqWVuu+yRMs0rcI17ResHXZsCRNZ8nWDYAz0nig090tE6sz1Op84hQRi+lxkAiYqhdRlf/Whrq
 Rjorw
X-Gm-Gg: ATEYQzzeSvweAcso0D2mn/ntmxcTRW0tH9+WDpHGHzfzPwtj/qb9UgsSahRLCHOYs6d
 NsHzEZaqFX2fEiOVLwJXx/sJUNC4rEcblrgW0TpL+H8GWFq367sEbe6acEfcSNwfZm/3RvAd6gl
 rGfpR5JgBcZHA3LkbCYWt95xfPVRiEHbOuvIYIyoo73lhU0qPyu0kWoCP8Xnu4icg6mNcaDgm9t
 YX85PNjAEQ5XsCy3AZwj16CG4ZClH5Vo+KxZauYVJ/mR2s1Y7Lx3K1fRNNbuB6zEyDqSv291Y3c
 KWpgwOy8Vd1tB2/blBB7y3VDajHbc0wa6HBU9eoUAUzJhnrN0EZVprZqvdzmT0R/TEvXsiqxHSr
 /ssb9QkbP5JLdsOXsNsydOGbPPGDzvWtLk39WVuZ6BC5IVCEIYyZF3tiFZVEz7yQ+VqY/P1raIQ
 MRWSrUbwI2Fz/RKjQFFOzTQLl5jCzQbyKidj5hj0V4saZffD8hgIEZ2QKtBYJqGrZ4rpUVx8Slv
 Lgi
X-Received: by 2002:a17:902:cf0a:b0:2ae:8293:74e6 with SMTP id
 d9443c01a7336-2ae8293798amr61707795ad.51.1772917230876; 
 Sat, 07 Mar 2026 13:00:30 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83f8cfb0sm79975935ad.67.2026.03.07.13.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 13:00:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 2/2] contrib/plugins/bbv.c: Check if file is NULL
Date: Sat,  7 Mar 2026 13:00:21 -0800
Message-ID: <20260307210021.878274-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307210021.878274-1-pierrick.bouvier@linaro.org>
References: <20260307210021.878274-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The file pointer can be NULL when e.g., opening the file failed.
vcpu_interval_exec() already implements a NULL-pointer check, but
plugin_exit() misses it. Handle the condition by adding the missing
check to plugin_exit().

Fixes: 0d279bec0f14 ("contrib/plugins: Add a plugin to generate basic block vectors")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/bbv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index b9da6f815e3..5913cc6c637 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -30,8 +30,13 @@ static uint64_t interval = 100000000;
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
+    Vcpu *vcpu;
+
     for (int i = 0; i < qemu_plugin_num_vcpus(); i++) {
-        fclose(((Vcpu *)qemu_plugin_scoreboard_find(vcpus, i))->file);
+        vcpu = qemu_plugin_scoreboard_find(vcpus, i);
+        if (vcpu->file) {
+            fclose(vcpu->file);
+        }
     }
 
     g_hash_table_unref(bbs);
-- 
2.47.3


