Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64419C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 00:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBkxu-00007I-7Q; Mon, 27 May 2024 20:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkxs-0008TE-Db; Mon, 27 May 2024 20:45:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkxq-000227-JD; Mon, 27 May 2024 20:45:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b4404dfso2826235ad.0; 
 Mon, 27 May 2024 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716857116; x=1717461916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZyn79nnxkPwl3oi0R+R2zUQX2JpkgjOQGabZyaJRaU=;
 b=DBNyFN8PVHiLu174JklePpT01/DFZyWEy2/nXSIXu5Ll0uZReoj25bSnP2ioJ835ta
 u728+SGfwXTexwOrplLLCayq5DfM+PWW1+t9rDrSlbMruhbi9n3hfKKmLxIIFJDD5Sl1
 dk/i6IxARFRN+0yflCMVMcdRnQBHqUvzNUtJHoG/rnai02DKmlHjNlZZ9vJyWOaKwdRS
 TZFgLi9dy1HJhGasIcXygkQAYDeK8BG0n8fDnWt/EdttWD+O/aeY0m1vs6/X+oRU3D6X
 5e67dDt/wsqv5ovocIWWreoPUcH+7piIGxjt7QHukewk2aSaIDvQqNEorT4+ov788p7o
 wKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716857116; x=1717461916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZyn79nnxkPwl3oi0R+R2zUQX2JpkgjOQGabZyaJRaU=;
 b=eOp3s02vsw3ZuPd+qQYy6npKD3up96Ru6kUUvw5KScB8lLpAqCCUj16+jRrWsMYiZd
 bbFpgH+qflD7dzDd7p3Nu5XTq+DaM7ppVsK5S41yZEri5dINTUZJ7fWT1pn5W8wlFXMT
 0w3bC9NVUTFW5V2lk1iKXP7VUY8E3ycIJ18+PkOMgNMYiXhbzaXSYXYvqk4xMEGinTve
 vOIFruhXfF+xuJnFXgg1xdK5Pzk/rcUGDex6HN2JJJE7Cl7v9SL4YtvvOMZeiCTgeC6n
 pUgYD8QrBUCEtOaX7hSdhBZLWeo70OzN9PLWj2hwscxiIIjFhezGVC1jyV/l3LWbT35u
 wP3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeKS/Mr839Rt9g4U0xiYhvY5bzw2RQI/KV4AKIWSG6/GQjG9xjsA7f8Pxj2+msbXK7MBmNdmW68sUAepmHsSZily8f
X-Gm-Message-State: AOJu0YyVHErqbFy7B5E2MM2jHugnhKlshBuQwkvDnsRenotPh6HIpIgN
 h3p4H5bunOqfnxL4aQeitR0Ikem9V5O4Og9z8z1zdIOcBabPyRzqlbtHPg==
X-Google-Smtp-Source: AGHT+IE+EM8JAJ0GoIzzRIYlhNmvLO5T2gZ4m7rY06yGSZ0SfhC5MpHSjoSkn9i6dgNmiwm5O59gJw==
X-Received: by 2002:a17:903:1c6:b0:1f4:befa:7a79 with SMTP id
 d9443c01a7336-1f4befa8b8fmr19066735ad.27.1716857116438; 
 Mon, 27 May 2024 17:45:16 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75783asm67613595ad.23.2024.05.27.17.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 17:45:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 5/6] tests/qtest/migration-test: Enable on ppc64 TCG
Date: Tue, 28 May 2024 10:42:09 +1000
Message-ID: <20240528004211.564010-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528004211.564010-1-npiggin@gmail.com>
References: <20240528004211.564010-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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
index 7d64696f7a..87fa733d60 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3463,19 +3463,9 @@ int main(int argc, char **argv)
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


