Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1F2103E183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rOE-0001gk-BV; Wed, 18 Mar 2026 09:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rOC-0001gU-Cs
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:56:48 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rOA-0003pl-LW
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:56:48 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35b905e9dc0so2373359a91.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773842204; x=1774447004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2UQu/8KYky8JSPU2qLEbt0t2n1mVt5gYHVb0GutUIgE=;
 b=bw7YkJ8AGaSAZLfvE30GrC+cYEaPWvbNdSODyFOkXM1+UKhaXuGANh0PkKWlw/L79u
 1QvmKrmTyKmhwlBaHgLYhhbtK1vf8NbmbQqBztSueSCJFZ3YyTcS9BBG7LAXcG67qXNi
 Bwm7yQB3IiKuPF05wHJnrZnIOdRhp3HG877rvzJyQf2BFKO9dbflpoZPT/hgoF3l4JUT
 rhWnBX9KyJTaqcV7VLMCBYTwLqGaiOobEEYufM3ptm9JcHbEvFRiBC7CzaTBU1O5wKN7
 DygvxzzpBYEbScpft+tS/klZoGIMlTNGfzQDu08j6xc30H1r4q8MoNCch0wB3zOgoiOI
 P5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773842204; x=1774447004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UQu/8KYky8JSPU2qLEbt0t2n1mVt5gYHVb0GutUIgE=;
 b=fQ2UFqcFkuaRbMlxaiPV6Z4xMZPIZlUE1fJCH1x57ID3QwMq0W5VQdU2BSW6aOj4Hq
 e3zWJWoQOpD59tV2Hf/T+xYoBGpqrCW3YcrftCH++WCGFhOByuRpBuwVkt3LL0Q3jxfJ
 pjrHT7ryqCEPkyG0sjibyzIQ88ejEMKfpGpGbh4buD62pEwjsEf5EORWr2dJZbOFEU0/
 eApiF4BxL8TMgmpf6qf2r2uOezN00GIREwKWsJqk2s2H9Nqqafcjn/rA1QWYOQBrzqaC
 4JeG9f2r+LD7ifVX0U3RID+4Uc9M65r2xTXlNQdWUOYsXYxFsou1VYy0Y7EEGp1MUxpg
 qF8g==
X-Gm-Message-State: AOJu0YwPdU6TkFkYUuFlPNxq+O2rLhdZqD5HZOufo/Kxssrq0SVPDvBp
 WWuf2j6ubqVklubxzcwvWo1Up07YQQtYeTlNqzRWQL1Wszf1RZnh0hL4yDhVe2thcLg=
X-Gm-Gg: ATEYQzyY7LSSzVtmFHMUqAGJSTeDjPk/UbqMF+wjHpCuXK9ub1SaSdiwOuJtJFO2ttx
 5rowhB8eFTP6rF30UJd/+wSvl+Q5xt8/NU1bJUqngtu8Y1+4Zia5/WhzMi11YfW/lm6Ku91Zdm3
 gTDUX9Q+Z9ueknlomXoWkcS5UKpwMw/I4ZNMqILzv4CgTrCzcdFFf5pQqtJ34aU51F9aKJuLeix
 uxqfVSWC0zyGKOL4F5DoecWh29+ZJjEILrxxzipSiUCVEXIMHGJMaoADKYHMYAlVXlW0b4CQmFX
 8K5pXqYGK7Lezd8Y1VN9/QdWKrwbBCr3+Qm2CxWtpq2eviCh5Hx0uVcSzyhjtcIeFNrVcWpGBdz
 cmZeD88ZF1q5UXqBtUpJrtfKe/+G0uno+2FMvPJ+qHvspypbbTHVyJcdcc1p4+jGre2S++TMzZO
 WoPLdckVmYfVV7TjP/UU4JKKUyA/v4pwyqe5UV9SgSk1V4GemStmfMWn59eg1Zb6I+XceQwllAH
 zMLCkdJ4Q==
X-Received: by 2002:a17:90b:4c0f:b0:359:f8c3:dada with SMTP id
 98e67ed59e1d1-35bb9e7792dmr3430473a91.13.1773842204391; 
 Wed, 18 Mar 2026 06:56:44 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5d3b9fsm2926177a91.17.2026.03.18.06.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 06:56:43 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 v2] plugins/api-system: Handle migrate_add_blocker() failure
Date: Wed, 18 Mar 2026 22:56:38 +0900
Message-ID: <20260318135639.6815-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

migrate_add_blocker() can fail (e.g. if migration is already in
progress), in which case it returns a negative value and populates
its errp argument with the reason.

The previous code ignored the return value. Pass &error_fatal so
that on failure QEMU exits cleanly with an informative error message
rather than continuing in an inconsistent state.

Resolves: CID 1645470
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
v2:
- Pass &error_fatal instead of returning NULL: the plugin has no
  recovery path, QEMU should exit cleanly with an error message.
  (Peter Maydell, Pierrick Bouvier)
- Remove manual error_free(migration_blocker) + migration_blocker = NULL:
  migrate_add_blocker() already does this on failure. (Peter Maydell)
---
 plugins/api-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api-system.c b/plugins/api-system.c
index 9a70b9caa6..fbf905cd63 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -108,7 +108,7 @@ const void *qemu_plugin_request_time_control(void)
         has_control = true;
         error_setg(&migration_blocker,
                    "TCG plugin time control does not support migration");
-        migrate_add_blocker(&migration_blocker, NULL);
+        migrate_add_blocker(&migration_blocker, &error_fatal);
         return &has_control;
     }
     return NULL;
-- 
2.43.0


