Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3A7C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 13:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sArCx-00015c-3X; Sat, 25 May 2024 09:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sArCu-00014l-Q1; Sat, 25 May 2024 09:13:08 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sArCt-0007Fp-Bw; Sat, 25 May 2024 09:13:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f44b52f86cso33125ad.1; 
 Sat, 25 May 2024 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716642785; x=1717247585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skPSuF1WhcswVBprHeljIeYPo7mMMqZfxAd2KjroudY=;
 b=YepuLwpMILo5o8H3cSQhaFXa9WOlU5mV8Al5zex3BgkcQBWajWFjG/90RR9rvpo+JW
 S1NmEWnqPc6tf0GEYedL+mviXYQzYdNG6OjpG3i8fMQbmCJnbg+9txbuF4lguo9Xo6Dt
 SHG8EEGsWZfOAETGSvG6McS92zexjtwidtYHi+WaOLLuGPKGM0HzoAmx+483Zbp8SLBg
 ZBomZGe3SMqerDXA7JI0Al3Du/br9YdhFrAqrAmIkqyuu5TRbxGWfpQ5BWz0JS1Peo2p
 GHeeVAmBwmPbytfbchQLIB3ldsEKU1B4MvKEDhK3jI0UOSSEzc70Yi48GQUV0XLr4eov
 QoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716642785; x=1717247585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skPSuF1WhcswVBprHeljIeYPo7mMMqZfxAd2KjroudY=;
 b=g27koEtxb8v7fbBSZRfbeYNrGPCIhB0QRFZXwp4aFGAPV28uy5+uY9nPmRmbnKtmEk
 T9IvqKgTGFvELjnDz1aSo4Bt4yA3l/e+ta0E2GUP4QgEpSNP4sHJ9js/aIGi0QqD+2Uu
 90VZtk5kuiQ4K2dQmxQdl5357Bm7X4XfwSTrFUcmIlI1JrCIZZjxyMl/TZTLTm2riuQq
 3zgfIDFOkhDB88ivWNkUdYQBhuPTdiksitXAqWIdT1nfY2Lj6X7yzR7/Dw0hAawAmkOf
 z6OVH/5Am//WYjkx9fJeJbhOP/07OonyFUq1Ju0ESBBfjjYy4BXePHmW4nR9C9DsYem3
 g2eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7LGOELqoRuknFj1OtFl+3ThETjqZmfrHjY+RkrexXUImQ0B9aZEsV4/9qbqSnDQtrIutNNJ//BsHnKcJKFUMt9gIWDs0=
X-Gm-Message-State: AOJu0YzGVJTCZbC3NeNa+eEr8BAY7cz+OXhnF5W0HWe25N/t0L3JC8+v
 TMqscIl2Fcj5bgOjrGPcVA0GRbf6ng5/KkQ3Knbr5K2Xib5B9Nceqwqtyg==
X-Google-Smtp-Source: AGHT+IFvDpXG+Q1a4Nvy6pYX84kKHAw8q/E/g3deRZX8YvW63HM6gBAS9JK9GRnQvyigG0+qdAVvjw==
X-Received: by 2002:a17:902:da91:b0:1f3:7f0:74d with SMTP id
 d9443c01a7336-1f4486c6241mr69926065ad.11.1716642785264; 
 Sat, 25 May 2024 06:13:05 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9dd1efsm29653525ad.291.2024.05.25.06.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 06:13:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-s390x@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] tests/qtest/migration-test: enable on s390x
Date: Sat, 25 May 2024 23:12:39 +1000
Message-ID: <20240525131241.378473-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525131241.378473-1-npiggin@gmail.com>
References: <20240525131241.378473-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

s390x is more stable now. Enable it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 94d5057857..7987faaded 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3428,16 +3428,6 @@ int main(int argc, char **argv)
     migration_test_add("/migration/analyze-script", test_analyze_script);
 #endif
 
-    /*
-     * On s390x, the test seems to be touchy with TCG, perhaps due to race
-     * conditions on dirty bits, so disable it there until the problems are
-     * resolved.
-     */
-    if (g_str_equal(arch, "s390x") && !has_kvm) {
-        g_test_message("Skipping tests: s390x host with KVM is required");
-        goto test_add_done;
-    }
-
     if (is_x86) {
         migration_test_add("/migration/precopy/unix/suspend/live",
                            test_precopy_unix_suspend_live);
@@ -3619,8 +3609,6 @@ int main(int argc, char **argv)
                            test_vcpu_dirty_limit);
     }
 
-test_add_done:
-
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
-- 
2.43.0


