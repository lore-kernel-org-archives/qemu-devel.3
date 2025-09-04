Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931BFCA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuAzk-0008Sa-8J; Thu, 04 Sep 2025 10:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qKK5aAcKCiEMBCLIBVDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--pefoley.bounces.google.com>)
 id 1uuAzg-0008HL-Vg
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:31:21 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qKK5aAcKCiEMBCLIBVDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--pefoley.bounces.google.com>)
 id 1uuAzY-0005AZ-4L
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:31:20 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-722693d5a44so17368947b3.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756996264; x=1757601064; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j9eklwrxm9Jmn5nmZyAWnhWrh7yT3Ilpxmn8N+6K6UA=;
 b=2zQGTtQzOAJ3yvqbn23LcDsUKCCY37CBYiskxHnvhBn6YUp8m4QKZBNUySO7j//6+v
 FKoktryO7kZxny3hGMxfv9Qc0Xae96dS7+uEWQZqf13B3J/83qRGupugqfBagYJ/4qNg
 ayxePd+TzxrcTY+itvHzQae9P7DIibi6abTAZ97GFzyegjpfvvq3NVfO0PmUXNQVSxv/
 ma2aPB9EzMloU7sW6bgDzxVclxSe1AJhdNJLijezNKZuP2IValauZiqgdP7Tq6PC4b5W
 K9jWwQsGUfk2RVZflcN56wlne7ubWrpZEeY815nJvmTTC0aKnOjZkfkeBh0Xwl4VUB/3
 7wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756996264; x=1757601064;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j9eklwrxm9Jmn5nmZyAWnhWrh7yT3Ilpxmn8N+6K6UA=;
 b=EMnhuUWmxDp9QuLRRrkgP9miLlh9ls9X9a//1BFHd1YeV0aF30sg4NiKqinPlI1Wec
 xjISixHJxipcDktFdKtb6Y71cv9curKDG4Pz3kzaDs7ExkXelYB/JhJs+IXCaGJRNBT4
 XmggERALuvNUi0WXXt+87xVfZKVNp0q2Nd0HmibmUtF1d4ZbYRIiENUi3u8h5yEj6+iU
 ZM/J0545Exmw5rQC1lTlVoDonsoTkrgexngBLbt+OoV0KpJCXx8rywH+qrLQdfuppOqE
 UQ8TX3LbJMjsBPqmnCoJ3iTN4Exfq6cieA8nc9QUXu3nr261Yng8rjjFW0PnFo/qKsPa
 jJfw==
X-Gm-Message-State: AOJu0Yw/Z2jmgYTxZV1AakY0uyjAEKSBfPMWBdVPjrMS6S0q/wog7JlM
 d9uo1EfhFCmq5OUJ98tMPdIre4qO7Nt6VwIiAe68tHKeLmo083J5VrrydxFRU08MYB+oA3MiiDX
 7BrA6XFA/o3+ukI7NSRIQtSniBk67R5PbVkfUO32TOWaJnnD3fyx8cDUryNlwEGEZpP80AyoQMG
 1RRrEuuWZjea6iut7LxgXiUgUgep+cgFGSDMi7+xqR
X-Google-Smtp-Source: AGHT+IFYJJvX/refcQ1jlqjLs9yLf+o8zV2Le+Da2Aekw/vxunPtmtbtiJTQo80asgi5cU4tiNp8wTlfxh8W
X-Received: from ywbhc2.prod.google.com ([2002:a05:690c:4802:b0:722:6a54:5341])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:9992:b0:71f:f359:6c9c
 with SMTP id 00721157ae682-722763ba24cmr208397227b3.18.1756996264440; Thu, 04
 Sep 2025 07:31:04 -0700 (PDT)
Date: Thu, 04 Sep 2025 10:30:54 -0400
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ2iuWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMTXcsCXUPDZAMTA9PEVPNkUyWgwoKi1LTMCrAh0bG1tQCYGKwsVAA
 AAA==
X-Change-Id: 20250904-9p-11c0405ae7c5
X-Mailer: b4 0.14.2
Message-ID: <20250904-9p-v1-1-e634cb374c80@google.com>
Subject: [PATCH] 9pfs: Include glib.h
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 nabihestefan@google.com, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3qKK5aAcKCiEMBCLIBVDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--pefoley.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

gstrfuncs.h is not intended to be included directly.

Signed-off-by: Peter Foley <pefoley@google.com>
---
 hw/9pfs/9p-util-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
index 4c1e9c887d00c44bc073bec00c07ed09d3868bf5..93c38e40f693a945f979ca89555cd9b1ea3175d6 100644
--- a/hw/9pfs/9p-util-generic.c
+++ b/hw/9pfs/9p-util-generic.c
@@ -2,7 +2,7 @@
 
 #include "qemu/osdep.h"
 #include "9p-util.h"
-#include <glib/gstrfuncs.h>
+#include <glib.h>
 
 char *qemu_open_flags_tostr(int flags)
 {

---
base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
change-id: 20250904-9p-11c0405ae7c5

Best regards,
-- 
Peter Foley <pefoley@google.com>


