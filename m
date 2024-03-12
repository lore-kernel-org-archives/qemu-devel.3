Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19054C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk71G-0003aT-R7; Tue, 12 Mar 2024 14:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk711-0003NE-R5
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70w-0000c9-I0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41342849a15so1965085e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268692; x=1710873492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YLwrLK6pe4v4As4FiQrlSek3puRi+quH0IgezmVNfJ4=;
 b=HcRIvthYq4A0mQf2YXObfenS22poAr8WP07lH/HI+PHs/eVo/EX45zagQmSu/zky5l
 KvJdCXezzTIsYmiqRYo2HJhVF6rYZSRi8+ZCiw/UsEKG6SIFHCHN9w6j8gtS62Q7uTt8
 PoT6s9SL34EJsFerAqZPN3bPbEQGm/MMKuShqMRAGHTv4XlDQu6fMAU7RgSQJCbMqiC0
 OOep0it2IvzMPehED/Q+z8KCX8LP1DVvkMfUOjnu3SpGByTObeX0tzY+6EQeD6zIQuVg
 WFGHv5Y+beVPzSv9o2NKnVfRddTyWerqSN1XW8aGNA6/dR6zJwP/K7+L6iu6bUNCRuL0
 7nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268692; x=1710873492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLwrLK6pe4v4As4FiQrlSek3puRi+quH0IgezmVNfJ4=;
 b=X7EPUvmmbOUmwVolrSlsHKlFd35sYqnhJk6qFnSXZm6H7qBsMObzmg5F053BRPZMSX
 a+mZyB8xE+tmU0uTPctpfwkv3RbHsxJq53X1n7Z3YoY3chTd/+yM8vcZ8FZxDTesNCLD
 SRIcu2laqrPjS99DVeJUngCS97wt8zRN1c6f3Fipd8OgU7lwhjGSozQGbvPB0hnE1j/Q
 MpQD+tuHUx3GEpGT4PBzDxQHoK+YeHX5ZAQUess2GwDTdg40BDKxoH+TooBiNCoeZ5xi
 ANxgtIHJAjEMxI+LcMABt90Y3O53CpaPCVxagZqRMSZLME0GmnTVeANs+4jmlkgcNMEo
 GibQ==
X-Gm-Message-State: AOJu0YyN5KcYsHorpQIVo/4HGnzPvQnyWSXonJkUcG9i1dTqojeum7VZ
 abYzvolSw2HpKYTxA7TYXC/EhKgWltC9MYoIX1eE9sEPSWtEEgmWlJ6Ze8XsGMk7+Z68uTv9XwZ
 f
X-Google-Smtp-Source: AGHT+IExvX9etNjG2m9zYy8K6UGpWBI2GcYWr81eEb9/KCcQ75QINY31KfIJcjROtSG7maBP2G1IXQ==
X-Received: by 2002:a05:600c:4e56:b0:413:1645:29a6 with SMTP id
 e22-20020a05600c4e5600b00413164529a6mr733115wmq.22.1710268691930; 
 Tue, 12 Mar 2024 11:38:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b00412ee8e2f2asm19836337wmo.9.2024.03.12.11.38.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:38:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] tests/qtest/npcm7xx_emc_test: Don't leak cmd_line
Date: Tue, 12 Mar 2024 18:38:04 +0000
Message-Id: <20240312183810.557768-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183810.557768-1-peter.maydell@linaro.org>
References: <20240312183810.557768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In test_rx() and test_tx() we allocate a GString *cmd_line
but never free it. This is pretty harmless in a test case, but
Coverity spotted it.

Resolves: Coverity CID 1507122
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/npcm7xx_emc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
index 63f6cadb5cc..2e1a1a6d702 100644
--- a/tests/qtest/npcm7xx_emc-test.c
+++ b/tests/qtest/npcm7xx_emc-test.c
@@ -789,7 +789,7 @@ static void emc_test_ptle(QTestState *qts, const EMCModule *mod, int fd)
 static void test_tx(gconstpointer test_data)
 {
     const TestData *td = test_data;
-    GString *cmd_line = g_string_new("-machine quanta-gsj");
+    g_autoptr(GString) cmd_line = g_string_new("-machine quanta-gsj");
     int *test_sockets = packet_test_init(emc_module_index(td->module),
                                          cmd_line);
     QTestState *qts = qtest_init(cmd_line->str);
@@ -814,7 +814,7 @@ static void test_tx(gconstpointer test_data)
 static void test_rx(gconstpointer test_data)
 {
     const TestData *td = test_data;
-    GString *cmd_line = g_string_new("-machine quanta-gsj");
+    g_autoptr(GString) cmd_line = g_string_new("-machine quanta-gsj");
     int *test_sockets = packet_test_init(emc_module_index(td->module),
                                          cmd_line);
     QTestState *qts = qtest_init(cmd_line->str);
-- 
2.34.1


