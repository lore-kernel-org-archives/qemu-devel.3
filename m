Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BA0C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaTs-0002C2-6M; Thu, 30 May 2024 03:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCaTa-0001tv-6z; Thu, 30 May 2024 03:45:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCaTT-00034m-4z; Thu, 30 May 2024 03:45:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f44b5b9de6so4752005ad.3; 
 Thu, 30 May 2024 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717055117; x=1717659917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbPEeRWPILNUzNuILr/esH7ih7rVY13FKF1oFFMWtjM=;
 b=WPjL4N/mEA0Lt6/CQix5ZckAcZBMbFpC+ohsnSY55FmbsBuGR6KL8QnaB/HDUp6i2y
 v51fkFAoMD2GEyu2rGIYXLDRBfwvW8eAGL7cdPMEcDTNP5rqbGW7sy7V50QAPrGMZOdj
 tlVSHXMlJqZYAfdtumSVUkB/NRtRq9xVobt7ja/paQU8U+kuyomOm+ldJ2RDdyW0AT82
 F/bhkqKB+XiuVRpieEtxs2ahnyFtLETUNVfpj/1wFTWz7gIbxi7Pj5kRK4rK+IJC4jVD
 I05C6gm8CeLlTwhQgaL3oYzuchJJHy9np1Ef2dsvnQKyrf7Aj62K+QcFtJzx1IVaf/uj
 Pm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055117; x=1717659917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbPEeRWPILNUzNuILr/esH7ih7rVY13FKF1oFFMWtjM=;
 b=HsHUMlbw5dHfg7drVXhnzyNKwhhPxI4OpQ9xCrHG7IipwRlb23cJbWLAPROwvfdjSe
 4JVcyW5F2OyDNp/ofJZp3nZp4nrYJbXORCtW5Sbvz4blE0TTnoMmif7hoNjDqs0uPNNN
 zDyWWhbYnTk1wi7FMtcYAnJqgMnvfnpGXJeIPVwjy+dK9XUQ02vpXKTXZJ5Tp4Lc+1HI
 CPYjFiN65xlXXB8QwsNsBI2OxZ2YEEfLqwd37Yb+F3AgsuKx/alT/CJb4fiu9wqQfTsE
 DVf3l70RQFYhepIb9AFJS9vBNWfkvUQvttfVkN45lNOIOjwFVv/TDn2NHVCdGKIUl3kF
 sn5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUle7VuBE+M4iYy2brECUeyhD1R7Z+XUsdP15PnxPZnyq7r2aTgceLgkgAn1uz3c1RLM0tdWBFLjdrgjRTMZ1rRrMiL
X-Gm-Message-State: AOJu0YwqEFfTxJX6h/AbVkXiWa11caLN267vOlsWTHQ/4lVixTuFD5vs
 JTZsDgysaJ69pNkfou/oodniiEy1iNdZxh1ch6dDnc4oitreXtY7kAUr9g==
X-Google-Smtp-Source: AGHT+IFfesfKOKLyxaPOvhXsaTdUqJFJSWerkRxupFW40o8qBxGCF/6Nh75Y0KbFgKwShV9YebWiLw==
X-Received: by 2002:a17:902:ec83:b0:1f4:7bf1:71f8 with SMTP id
 d9443c01a7336-1f6192ed3e4mr15229315ad.5.1717055116890; 
 Thu, 30 May 2024 00:45:16 -0700 (PDT)
Received: from wheely.local0.net ([1.146.118.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f61aa2e998sm8025335ad.62.2024.05.30.00.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 00:45:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v3 3/4] tests/qtest/migration-test: Enable on ppc64 TCG
Date: Thu, 30 May 2024 17:44:51 +1000
Message-ID: <20240530074453.21780-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530074453.21780-1-npiggin@gmail.com>
References: <20240530074453.21780-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ppc64 with TCG seems to no longer be failing this test, perhaps since
commit 03bfc2188f061 ("physmem: Fix migration dirty bitmap coherency
with TCG memory access") which is not ppc specific but was seen to hit
ppc64 quite easily.

Let's enable it again.

The s390x problem has been identified so mention it while we are
adjusting the comment.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 48f59822f4..ef9ddef1c8 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3454,19 +3454,9 @@ int main(int argc, char **argv)
 #endif
 
     /*
-     * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
-     * is touchy due to race conditions on dirty bits (especially on PPC for
-     * some reason)
-     */
-    if (g_str_equal(arch, "ppc64") &&
-        (!has_kvm || access("/sys/module/kvm_hv", F_OK))) {
-        g_test_message("Skipping tests: kvm_hv not available");
-        goto test_add_done;
-    }
-
-    /*
-     * Similar to ppc64, s390x seems to be touchy with TCG, so disable it
-     * there until the problems are resolved
+     * On s390x with TCG, migration is observed to hang due to the 'pending'
+     * state of the flic interrupt controller not being migrated or
+     * reconstructed post-migration. Disable it until the problem is resolved.
      */
     if (g_str_equal(arch, "s390x") && !has_kvm) {
         g_test_message("Skipping tests: s390x host with KVM is required");
-- 
2.43.0


