Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B50C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzzd-0000tT-FR; Tue, 12 Mar 2024 07:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjzzZ-0000s1-75
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:08:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjzzW-0005b1-Ar
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:08:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e959d8bc0so1920577f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710241697; x=1710846497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QHUmaWQn0ldrlIK8tQw5bpDJbHvqza+98v6FJpbFdXg=;
 b=c4Bg7vd2YcdpuAVzFwtJLSfM5t1SzqW8lIKaTfbnVr9gUYdOlEEtZ61Rply2CEdYNS
 5RQeNBvsRhq8AKFXXTetGIpWYrtpwnINaBZnOb/pp7BkU0zVleVqUaNPp+/lmOwoKyyk
 rH8dhJbNbNh/ZniWrQAxSCsq1yuUKqnMwiKPlH64g5TlumYguf3bhl6+dvZwUpZhfrnT
 DEbMjL674N3SDAMFLIF2WM8gPbOlH9L0jit3X+dwV4U3yl5WqswlVS4yYCaQ2o6bKpkH
 Y6ulat6EhUZ8D1ZL/bjd1t7CHHUT1L5Sz4MV44zVbpvMWJcWrgyTgc6e8u4o7qd2jCwn
 dAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710241697; x=1710846497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHUmaWQn0ldrlIK8tQw5bpDJbHvqza+98v6FJpbFdXg=;
 b=Es5WbpOR9p9pFgNp0yymjt0eQEi2sKJcSknFyu3i9eETPMVNlYSWUIKsnpBcL4nohZ
 VDPxk/oXEL2N4njEIBV6g39AT97ZJNDWUQOK8Dyp1JLhbstNn1GC/LjHjCe0OApOLu3O
 RLEMmj1ByATZpdoaFRmO6CWI68PL+x1R0E6QhpsPZRAYknnN3k3LFjBy+6cNrJWYuKPc
 Ae/RqXJMfJXwH6tjXcl7GzwXdTs0lKRJSEkCHC7fSCAcRyv36hAPFrPpTpsjl77zJR0B
 kJaQkGWfTFOzN2I82q0EI3yqMoERh9CfWvrMBuagkP7WhKo6ujEMYdoelhGSuOX1orlh
 fK5Q==
X-Gm-Message-State: AOJu0YyjQjfF1BDOirK5cf07Wp8cOZK+MgfObdFyorga16kkKfzORulP
 nUQH3xwZ8nAeyQZ/2rCWy53iymmI8Y0cSKun/KtvgvNQtoKzMei9ATxmc26l1PshBgABaLzmrLV
 y
X-Google-Smtp-Source: AGHT+IFEGTRbbaHEZ5tXNkASgM4NDARvHLeJdsiC3pHdjaEBkguaCOTf/KiWBRvEHN+7LTWtjpyjIA==
X-Received: by 2002:adf:a390:0:b0:33d:27d4:2fec with SMTP id
 l16-20020adfa390000000b0033d27d42fecmr6121078wrb.35.1710241696682; 
 Tue, 12 Mar 2024 04:08:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a5d680a000000b0033e0dd83be1sm8770431wru.91.2024.03.12.04.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:08:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] tests: Raise timeouts for bufferiszero and crypto-tlscredsx509
Date: Tue, 12 Mar 2024 11:08:15 +0000
Message-Id: <20240312110815.116992-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On our gcov CI job, the bufferiszero and crypto-tlscredsx509
tests time out occasionally, making the job flaky. Double the
timeout on these two tests.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2221
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
cc stable just because it probably helps CI reliability there too
---
 tests/unit/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index cae925c1325..30db3c418fa 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -173,8 +173,9 @@ test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 
 slow_tests = {
   'test-aio-multithread' : 120,
+  'test-bufferiszero': 60,
   'test-crypto-block' : 300,
-  'test-crypto-tlscredsx509': 45,
+  'test-crypto-tlscredsx509': 90,
   'test-crypto-tlssession': 45,
   'test-replication': 60,
 }
-- 
2.34.1


