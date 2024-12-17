Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A714FE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgDA-0005M7-8f; Tue, 17 Dec 2024 17:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD9-0005LN-0F
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:39 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD6-0008QK-N2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-216401de828so47026345ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475113; x=1735079913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYQneB+NKqjuG7StTn0XWLjAkA1JJLLeS7nr+5pDNNk=;
 b=QfQwUY/maau59D4gTf2aCDO6uKr4ZwnoNrv3lJzhjQCi7o3qBhMDjfseOWp6l98e66
 gu8KnxTILNks2p1rHAsBLOHrLbZWdBhDlJJ5Qlsc6QgxwPBpK2KY9bkHrdrCg2iwlAPn
 VQxnl4QU1v/hkw/TdkSsbzZ8c03/FWPzq9vtOxZRQBEmvXJztbHY5Lx67mg1skXHNGTS
 5FvxlpORiNHBtYvmk6OliR1LmRxI54mxngSUXbJA67FvwwozFDx39q2yjRgKPd1D6Oop
 cBps+x6cIV6NUF0R+OqtzUALJRXPIU6AbHa4TUg3+I9SUB4RXXE2MBMBqC5la00NvEvs
 ufng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475113; x=1735079913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYQneB+NKqjuG7StTn0XWLjAkA1JJLLeS7nr+5pDNNk=;
 b=ILO5HnevVs9yw7p7QhFiXvq6yfZ0bytKS+EoTpmCFCcWiCoVED24FgrlO5IzumtGU7
 /hdcqvdsUOBDxt8J87t/1vBa8LDidTsNMBQVf0N+MfCo3AtVPM1ihcKP+nSrCrcvN1hA
 e1q7a3j2JyKtabKqDDvHfuvbI1kOomZ5hDIdaDDmYG/els9jlaILt4Og6DHzxFFngNtD
 idQ07tqNasdQMKPEuyyOFSF4J3XLBSdBKuV26Xq+rLWZMOYmgzMHJWmF4d5mDypLxwt0
 lLB/6NRHY9Qv2u+fIldR/0lsXeDO6mjbE7Ke8xUKNzE0HNwo/mAHR3iRerJQ0UDuONFU
 DsZA==
X-Gm-Message-State: AOJu0YxnMakLIfAO3jjBOQRxnn+Nqi9tj9iWoa2q5WPqbMWB2qt3fTSq
 os3tBDyfwjsDVJ8M4/5K1LhOtPeEFf7yG77DSrjg0HfhgB89/N4pQqyWlZlLwsZBp5tXLPLnCFj
 CnOo=
X-Gm-Gg: ASbGncslKhUWzmX1dfjALTpsTVIPbzjUwhxQiDe9zbCUTiRljvv+q7mxVEk1izZrOHE
 5VC2bP1CbZrtXDDMtXcpjNh7McvkoQaIbV7r+TT2CHXIqvBBP1WXHWP4zh4b2WaV2zj82xgHs2+
 vc7g+4TIFAfQ1OXX/QI6xbHvFPMW9j/oEhLt0axo68uOlXcocYTCsOEqajpydhuNaGeSv3BEg6Q
 f8SG0b0NY5NXLa0/rsu4SJiLsH5rgR6+QSAQfg6oL3s4lgM6JQ6ipkW
X-Google-Smtp-Source: AGHT+IFmZ7+Xtsxq3Z/8M9pcT48oQmjEIcUudYFWwlAiTrYaOUoQiuAjoq91oBnlA/DnHjDztL26JQ==
X-Received: by 2002:a17:902:d552:b0:216:5448:22a4 with SMTP id
 d9443c01a7336-218d6fbf48dmr9236895ad.10.1734475113239; 
 Tue, 17 Dec 2024 14:38:33 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:32 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 03/11] tests/tcg/plugins/syscall: fix 32-bit build
Date: Tue, 17 Dec 2024 14:38:17 -0800
Message-Id: <20241217223825.2895749-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
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
 tests/tcg/plugins/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index ff452178b18..47aad55fc1b 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -76,12 +76,12 @@ static int64_t write_sysno = -1;
 static SyscallStats *get_or_create_entry(int64_t num)
 {
     SyscallStats *entry =
-        (SyscallStats *) g_hash_table_lookup(statistics, GINT_TO_POINTER(num));
+        (SyscallStats *) g_hash_table_lookup(statistics, &num);
 
     if (!entry) {
         entry = g_new0(SyscallStats, 1);
         entry->num = num;
-        g_hash_table_insert(statistics, GINT_TO_POINTER(num), (gpointer) entry);
+        g_hash_table_insert(statistics, &entry->num, entry);
     }
 
     return entry;
@@ -232,7 +232,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     if (!do_print) {
-        statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
+        statistics = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
     }
 
     if (do_log_writes) {
-- 
2.39.5


