Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649F5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2odW-0002HG-KZ; Fri, 03 May 2024 04:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2odO-0002Fz-KP
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2odM-0007R0-96
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714726269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hgzzAOP1rWfV7F6hU3+OZxbNE/reBXCgjqwJf/VqjhQ=;
 b=N4xF10Le6cy5P/9+h9cwUELiK6suLyzpzNQCGO6b8nheanUQhC/y8Gou9RigKFt6S6x/W6
 MEd/kIade518FoYkFLiI/FQ3yeoLjPbefkT9S/Boy/OozCFiIse/A8RHWhuQy6feAVwEbj
 /x5nYD/RCbRchkX29GdJomQjI4fFK2Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-w3EBsqp6NSS5gpAHfl46HQ-1; Fri, 03 May 2024 04:51:08 -0400
X-MC-Unique: w3EBsqp6NSS5gpAHfl46HQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572babec6c6so1848968a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714726266; x=1715331066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hgzzAOP1rWfV7F6hU3+OZxbNE/reBXCgjqwJf/VqjhQ=;
 b=Rt9Ea/7jNrKwG4xYKWzE/7gPJz2j6i4jl0QfFizt7LTKaYKnFEOawh7+dxIkUvWHZk
 s5gQWykgiX02VeJj6cODc9Va1uvEuPg1y/FnHqzlgkY/LSE3Pb49lPFrrnx0ijTT4THZ
 V8FA28pLOCFApnX4Nyr+MJxGP+kLeMzy/Hzdluqn80iszkHw8EY7ykrbIrR6P5y6+kho
 EREZKwbbh5ZHhCsx/PjW85z8inLhiGDhbhnjCPlZRpXia55tCTRSSk57hblSmMMbqt6l
 QyVlTbWamzyhmncr7ZIKbmEVE3W1wYErB4od3eKahgG169KgrwANOduEzBb8fmIDxWn7
 nPhw==
X-Gm-Message-State: AOJu0YzxaybDg9B1tPT4Mqt/G5RcyWrWV3nj1eQzfYdslJgiof/6fIpL
 kBAblt0UALmETPRbCuXE2m+giwls88kCoYtzoZsT1ydE4YTjdVFQYtqbn9nYlc/sX0qe6jyqlYC
 c9HJ6P/uHjcN9x046hgQj62GcK65ebiLdtnG1yEuBmi5Dylp0CCshu9BpOCe7peCVRtJmrgw3Z8
 CZAUlYeRou9mjoJ3vQwA3iEXp9sZfh8Ot5/1oQ
X-Received: by 2002:a50:8d53:0:b0:572:67de:5fd2 with SMTP id
 t19-20020a508d53000000b0057267de5fd2mr1779693edt.0.1714726266495; 
 Fri, 03 May 2024 01:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuugCCYa3zCfx5tu6lSlXSpUBB/RqFFDjvdOf2Mhl1uFg5F81MtYLl122WTGlum2rxqfAmkQ==
X-Received: by 2002:a50:8d53:0:b0:572:67de:5fd2 with SMTP id
 t19-20020a508d53000000b0057267de5fd2mr1779678edt.0.1714726266032; 
 Fri, 03 May 2024 01:51:06 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a9-20020aa7d909000000b00572aa4a75a6sm1431540edr.83.2024.05.03.01.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 01:51:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] tests/qtest: skip m48t59-test if the machine is not absent
Date: Fri,  3 May 2024 10:51:04 +0200
Message-ID: <20240503085104.187538-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Together with the series at https://patchew.org/QEMU/20240423131612.28362-1-pbonzini@redhat.com/,
this allows adding sparc-softmmu to the target list of the
build-without-defaults CI job.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/m48t59-test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
index b9cd209165a..605797ab785 100644
--- a/tests/qtest/m48t59-test.c
+++ b/tests/qtest/m48t59-test.c
@@ -262,11 +262,12 @@ int main(int argc, char **argv)
     base_setup();
 
     g_test_init(&argc, &argv, NULL);
-
-    if (g_test_slow()) {
-        /* Do not run this in timing-sensitive environments */
-        qtest_add_func("/rtc/bcd-check-time", bcd_check_time);
+    if (qtest_has_machine(base_machine)) {
+        if (g_test_slow()) {
+            /* Do not run this in timing-sensitive environments */
+            qtest_add_func("/rtc/bcd-check-time", bcd_check_time);
+        }
+        qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
     }
-    qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
     return g_test_run();
 }
-- 
2.44.0


