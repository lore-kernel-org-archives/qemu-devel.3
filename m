Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B10C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl7x-0005TM-Tc; Mon, 11 Mar 2024 15:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4s-0003MA-Oa
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4q-0000MK-MD
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:50 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4132600824bso9416795e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184366; x=1710789166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fGBqfc2Yb7ffBuCcbEGM7TZH/G4A1wFOIdL+pttdZZw=;
 b=la+fglUHuly6Hdv0x5TRg5v5Zo5+EQ18+7gga57ztCuVg1Co55kNDC0yWNnEgOARCm
 JIQaJeJWu2EvmmGk4ednb1teA2VSA/k0QO0uTeF5CbLoU7YPR27zX3+KdhMou5//x7S0
 1tuAI9HH4jwlCEe7QLTH4vm3PzSZKq3UnC2WWVqbuaULfeoIXhc1Avn6TwevH9CwD+kx
 ytDOIXiI5lSWgIPeqYfRy+SD/sFC33AvH6SfhRiQcBPCCOM1bpC7Fs4NV0M1IecVw0Q9
 okqmf1VcZBc+g7Cu/xt8bFosbnR/uur6GGoGN8nKVwbRaISTzvlyGq0fmrt6A+luwuhL
 NzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184366; x=1710789166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGBqfc2Yb7ffBuCcbEGM7TZH/G4A1wFOIdL+pttdZZw=;
 b=qLkKf0nafrE2dpR3a/s34zPB4x/CVajpzV2cf5pgl+3ivpIffKnDj9ZaSqMDZ1ufpu
 24R8WBSRE/BJVhHjP+/jwnMnp01VF9uUFkjyGjGeMkc1fAaF09iCsp+pvUcMvw6EMYjT
 F4+edbw6WTJJK1GgVUKIPovjEihGse1uprgXPThp/ucxuadHYhk2ukHHSYbn8FoznQze
 +wcu5JDp/ys/EnO5jqyvx4s76wa/IhagJCpDSu1bC7/wbORlGk4V8uV9AvzBtyE1vZ/7
 NV3nr0cZzhQ289NtpLQMGkJ/c47pmlABx79ngQUGKonFKas6dzPokhxGWcUMxNn7nNz6
 92sA==
X-Gm-Message-State: AOJu0YyVreU2MjCPLJN9tgFm9nlXssNcg8ojzy/r+zKisZNUVQ6xYZbc
 KaAa7j4z/4rMNpVwqu1U1+Q/a41PnLFn+u7CDBtusrTsLIYXh11hed3pkx4O0wyrsJNeFG8HFTp
 n
X-Google-Smtp-Source: AGHT+IFO72Prp/vYNGWceoHrIoucf85MFCZyNRxiZx/Ox7vgSPlguCFo79V1crpfAfYHhvTX+AAm3w==
X-Received: by 2002:a05:600c:5116:b0:413:2e49:3e05 with SMTP id
 o22-20020a05600c511600b004132e493e05mr939809wms.12.1710184366242; 
 Mon, 11 Mar 2024 12:12:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] contrib/elf2dmp: Fix error reporting style in download.c
Date: Mon, 11 Mar 2024 19:12:28 +0000
Message-Id: <20240311191241.4177990-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240307-elf2dmp-v4-6-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/download.h |  2 +-
 contrib/elf2dmp/download.c | 10 +++++-----
 contrib/elf2dmp/main.c     |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/elf2dmp/download.h b/contrib/elf2dmp/download.h
index 5c274925f7a..f65adb5d089 100644
--- a/contrib/elf2dmp/download.h
+++ b/contrib/elf2dmp/download.h
@@ -8,6 +8,6 @@
 #ifndef DOWNLOAD_H
 #define DOWNLOAD_H
 
-int download_url(const char *name, const char *url);
+bool download_url(const char *name, const char *url);
 
 #endif /* DOWNLOAD_H */
diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index 902dc04ffa5..21306b3fd4c 100644
--- a/contrib/elf2dmp/download.c
+++ b/contrib/elf2dmp/download.c
@@ -9,14 +9,14 @@
 #include <curl/curl.h>
 #include "download.h"
 
-int download_url(const char *name, const char *url)
+bool download_url(const char *name, const char *url)
 {
-    int err = 1;
+    bool success = false;
     FILE *file;
     CURL *curl = curl_easy_init();
 
     if (!curl) {
-        return 1;
+        return false;
     }
 
     file = fopen(name, "wb");
@@ -33,11 +33,11 @@ int download_url(const char *name, const char *url)
         unlink(name);
         fclose(file);
     } else {
-        err = fclose(file);
+        success = !fclose(file);
     }
 
 out_curl:
     curl_easy_cleanup(curl);
 
-    return err;
+    return success;
 }
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 09af39422f1..d295fd92be2 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -591,7 +591,7 @@ int main(int argc, char *argv[])
     sprintf(pdb_url, "%s%s/%s/%s", SYM_URL_BASE, PDB_NAME, pdb_hash, PDB_NAME);
     printf("PDB URL is %s\n", pdb_url);
 
-    if (download_url(PDB_NAME, pdb_url)) {
+    if (!download_url(PDB_NAME, pdb_url)) {
         eprintf("Failed to download PDB file\n");
         goto out_ps;
     }
-- 
2.34.1


