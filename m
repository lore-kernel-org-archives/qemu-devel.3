Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E972C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgjRG-0002I2-1q; Sun, 03 Mar 2024 05:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRE-0002Hp-Hn
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:24 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRD-0001vc-ID
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:24 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3213592a12.3
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709463082; x=1710067882;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ot05ideaXjHDt/XtCs48E+XgUuov6SHY9sSACugHv/8=;
 b=rTRGAaMtiI4Z/8gWecRIiW0SCnN2fqQX4sA59lp6Yi8UqRvMFynz3rQvje2OANignS
 eyjHHQ6tn9VAFCXxm4QlnUeRKRFi8bT9CZCfEQ0oxbVDELv76HesGMCTmAunn98eP1z/
 lK+aSvA1G2kUrwx1wJqTVyg9dUjUsYSyT9Z30zst2BcmSM8rtT5VpVpCNoqAOQMnNUSt
 NoAixkgvTp57Vzjc+gAog/xkt2cm6FHXcz1ypLPRl006QIujQOLYOrDDgYSFzDaqAqPG
 JMD68v0qMuAzV+GtK9p6tncQVo5YueXu/3ES2HoBtgn2BP7gruwgH7A6BmuvZ4rhlqxF
 zoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709463082; x=1710067882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ot05ideaXjHDt/XtCs48E+XgUuov6SHY9sSACugHv/8=;
 b=DTfyaL4ukvLoO84nmdyVUfR6HRNX5QFUAamyjqzC9bKyihu1rNm8YR0fUqanmyj27b
 w4Gk45+wXPye3505mgtrnp9PZe9g4GcF/iXDrVfDj3QKhu8RZT4Hvgo7n/vVmbVYX+bb
 SIsusl4ipLGGRusDd1OEZ69rk1SkeGmgxEG+S+FnHuRD/SjMgnnnZgt0THGTWFMCUnqf
 vCPCpk/pBMXRM1JfOOVvNlydb55GOOgex9nAPVPwJ7nVPKdyJZivrnMusMZ0vwLReCQm
 wxABG19YaTaiy4U1Dr2VOjcglK8Y72eWQK68x7P7c0v7YN4ZvFAjfE1Y3g3ugQiLVdgD
 WCOg==
X-Gm-Message-State: AOJu0Yzq/658a1m9GzSryshuFQXcLXqU8bLezqDqC86SsDqZ7xMhnqQp
 b7TYBCQ/Z60CTDQ7Hq/35unasUogd1EPkfYHkClkDbT7MLDKlK4yq/89SbVmmCHaSZndG4Dh3b2
 e
X-Google-Smtp-Source: AGHT+IHPLsrD8aWFPj7I2exnN8z+GxwL27lj8jZ69zrPuabL64JztbfLxsWydaTz1Sp/aJ/gi6agYg==
X-Received: by 2002:a17:902:c204:b0:1dc:f913:797c with SMTP id
 4-20020a170902c20400b001dcf913797cmr4779179pll.51.1709463082191; 
 Sun, 03 Mar 2024 02:51:22 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 u11-20020a170903124b00b001dc01efaec2sm6435731plh.168.2024.03.03.02.51.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 02:51:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 03 Mar 2024 19:50:38 +0900
Subject: [PATCH 4/7] contrib/elf2dmp: Use lduw_le_p() to read PDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-elf2dmp-v1-4-bea6649fe3e6@daynix.com>
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This resolved UBSan warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/pdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 40991f5f4c34..2541234205c3 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 
 #include "pdb.h"
 #include "err.h"
@@ -187,7 +188,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
 
     r->symbols = symbols;
 
-    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
+    r->segments = lduw_le_p((const char *)symbols + sizeof(PDB_SYMBOLS) +
             symbols->module_size + symbols->offset_size +
             symbols->hash_size + symbols->srcmodule_size +
             symbols->pdbimport_size + symbols->unknown2_size +

-- 
2.44.0


