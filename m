Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C14C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 18:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7eyh-00031R-Gs; Wed, 23 Apr 2025 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bDMJaAwKCj8obcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com>)
 id 1u7eyW-0002xW-Dn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 14:37:38 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bDMJaAwKCj8obcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com>)
 id 1u7eyU-0000g7-Jy
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 14:37:36 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-227a8cdd272so905145ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745433453; x=1746038253; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nY1a3kHuX2lbkjX+z4gIYyiMc7As84sOZpTaaoTLSGA=;
 b=E+kXi8t+m5wPOhqkpbuaDlATCNVQuQgukU1Wn3/TADIexmpx9Bhu4rBflxvJLWOCaP
 6akacFrjRK2UP0zUa5dQbkLKucyXMDe4Hd/DEI0sawfqGHI3cAepsDtEmnzDy/kSetxi
 6mvNyKbiRWzoBanYPXiBmuAmeAoJO7OjNLCfSjECjUFyLP+5AFMP3w3zklLpdprpK8hu
 bjoMY1zmxN042ki57hQIiBg/NQs3QVJwOMBQs78B9ZRJLrSwzKjoSG1you5TgaJZWBV4
 PhFrcoQOhJG3kwpSiFhfm4m1YNwFmNvlr79BQkJRrj3rXuNbCn5JPyS10oS0vvlbx/ud
 tPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745433453; x=1746038253;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nY1a3kHuX2lbkjX+z4gIYyiMc7As84sOZpTaaoTLSGA=;
 b=PpqzHorhbOTQe8sy5vSHrIGJxPxhp+/cChx0oOupNkA0Sqfc78IWOksyVMKqx7oL7G
 EO2MELj7v9tp5Ce0P0Ic/S3vfFWZR2MmhYdJz6U5dECKo33zYe76dnX0XLpXa96bHCtF
 SQaT1Q/GYXemqmaddjVV9dYRGYXGS+sAN0QkzU1FdNN8Q3Iptg6LYI5ZhqWNoRDf5FqX
 ZNRjCs1CIuMf0igdJb7y9I2YK459bvVoPNA+1KHcJS5Ns1yC762u0SEvsFiCNEiXo4sl
 wELuLFHpEYzdR/tt19LGm/jH7BJVjIbNkB6kIzCkhZ8ETD4OfR1/3jCk2/xnS35A2TSb
 +8hw==
X-Gm-Message-State: AOJu0YwTWZSPSqX8tEKxhr1x06o8z3G4rukp8+osF4fuLEZm3nphmC2t
 CusQd0V+Zv9xV22u9n0gLW5oziBccp1t2pdk7Hc0pvFGegE0BHyCJJAm1z2ab+7zRt6vSSWVk42
 Z2CSd0yGmekaZVD5NcfAiVu7uTaDQYBq4NVqxXcyQOPzaxF7O5/w0mtNdipLmWqWE0OT89lReW4
 PN/iNmkZpQ1G06thOUNih/AtaETbRKBL4LGmdL6ogjcnnpf7t0IaTdIKTeq4WBM9M=
X-Google-Smtp-Source: AGHT+IESBL6Ft8dkObtuVCZvyVQf10sDkqAj7azX903oUBxUS06u3rNNyzEgUTRN24uyJ+feO+pUKJiMHbvnEhTyP0M=
X-Received: from pgct21.prod.google.com ([2002:a05:6a02:5295:b0:b11:dd2:e84f])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:19ed:b0:223:54e5:bf4b with SMTP id
 d9443c01a7336-22c535bfe32mr332222985ad.25.1745433452608; 
 Wed, 23 Apr 2025 11:37:32 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:37:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423183728.3860325-1-nabihestefan@google.com>
Subject: [PATCH] scripts: Add exception to license check
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org, mjt@tls.msk.ru, 
 berrange@redhat.com, thuth@redhat.com, alex.bennee@linaro.org, 
 peter.maydell@linaro.org, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3bDMJaAwKCj8obcjiftufgbohpphmf.dpnrfnv-efwfmopohov.psh@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The documentation for trace events says that every subdirectory which
has trace events should have a trace.h header, whose only content is
an include of the trace/trace-<subdir>.h file.

Due to that, we should skip it in the checkpatch license check.
I'm adding it as an exception to the check instead of its own if so it
still throws the warning on all new files instead of ignoring it.

Change-Id: Ic2dae14f8cded0dd02d5b231588bd38d8a00e40d
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 365892de04..b2c6ac2477 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1685,7 +1685,9 @@ sub process {
 		if ($line =~ /^new file mode\s*\d+\s*$/) {
 		    if ($expect_spdx) {
 			if ($expect_spdx_file =~
-			    /\.(c|h|py|pl|sh|json|inc|Makefile)$/) {
+			    /\.(c|h|py|pl|sh|json|inc|Makefile)$/
+				and not $expect_spdx_file =~ /(trace\.h)$/) {
+				# Files to include auto-generated files don't require a license
 			    # source code files MUST have SPDX license declared
 			    ERROR("New file '$expect_spdx_file' requires " .
 				  "'SPDX-License-Identifier'");
-- 
2.49.0.805.g082f7c87e0-goog


