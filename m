Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15454E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 17:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vslHV-0000rG-1R; Wed, 18 Feb 2026 12:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vslHT-0000qx-I6
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:24:07 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vslHS-0006VT-3Z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:24:07 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8220bd582ddso1024b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 09:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771435444; x=1772040244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=go8zD64Fw6NrSCUlR0CioUzF+vztoGXWF68Lnwt2cTI=;
 b=JamVy/hNYOm/mVQEDzsyjzMOBCNSduNkLYJRBbr3PshBDXZ4O6BfpDWu5XhOGpRpw3
 OdTdlBzA+97QyAl8mg41NxpKzvRo0jszvUAl+yXbT+RXmhbLczmSPEn3rDyPLM1qt3+S
 QC7C9Tou27seJiPZZ9+OfRMPSFXCwgTbxLlEPsGGYf07tJaA6xRE7490vFOQZttSf4Ri
 MGLzpFmuRZvEcG4EhXZVfcACouE/QymsyuAx/OF2jnpdsjczrHfGfCdIpm5/NSBJ8ItH
 qCd5c7E7pbILdjZmL5mhHrgkg61nVX1MwcvZcEf03jAFB1zgxQaLGMuAYkBnn9kLanlt
 xEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771435444; x=1772040244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=go8zD64Fw6NrSCUlR0CioUzF+vztoGXWF68Lnwt2cTI=;
 b=kXDEumEaiMEE/IMTAWvkZUIypcZ3hdqMfd9VtDTZ05ppdwWEn4cGwNbmxZxMFAKMfy
 7wzPdwdYzProgyzHYZGrJKfqWIu/FZhsuFja6lPGrakUQer33MvhIeRk7hfsx0pvidVI
 CfMsdEFzo4rs0Fl4PKv0rs2g3zCRs1TkxawHL+ySApYH2kdXs1TwDvOuGLNGhXJL393m
 yGGXnX60r6qwxUMup9M2wN0Ai4E0Cv/M/VfjY4M0SazZ5XYj0xpPcy9AULA8iQnXv6z5
 j3qdH+FBiXN7wBeYbYidGlLsz04ZJQtPX8mVuUX9Jtca3btxANos8T6lMg9RMwKT3WM5
 bX/w==
X-Gm-Message-State: AOJu0YxDKPbZhUum1iFmZ/KahnmI134W5xhpnvbsrJGlwold/qP0B2hT
 vaE+BFTRFKuaX2xlMYEHK6CrJ5PAI6wnx/ciQRCeY7sPeblA1xIkqV21LspXoYUsf0BAQoxI22o
 HaQrT
X-Gm-Gg: AZuq6aLnv19qMOsne0RGOmvMBv7DPwHtn+4WGiZJUuuKFuJhgZNAgBVCSam0QXNKlR9
 KGGIgvdgMaibW1bArJ9mnUMPAILMtDUH77Y1TMcO1AuPqbD9CchgGTPdSuSR8VpJYcAka7FuXUr
 PMw2ar+HFR5hDXDWfs+ogvZhFeGwNW6KTsWnsXfOUXYiI1c3HUk97b5sU7oWKrXC31xY5xE+oIO
 Csl8AYuzxk3fZHy2BlnuBTgmu5WLA2QUBLH4PgziQ2te2gC/3ABjXT7qcMlqsXUk8/6bvIDUmmD
 aLCTppVEbCd9xdM0W1XS8qDvEZZNmCqX2flXYlpV5qfqFtJ+oepuqRbnD3+IJDN2FRwklnYoEDy
 EvtIRwFYkhlBRIgWAPpsdH7eVH8OCYJAqEQlyYNL9pO7poCkHT1poWWGck8Wwhbdn5tS1ncTKa7
 mfcQMt8vt/t7hdX6ChrI4oPKDCp0oFj1CzKDeqbJ2oeVWkXrCZn6UVDNJoKVmhggbPdXRc/xyKV
 VEO
X-Received: by 2002:a05:6a20:914b:b0:38d:f9b0:118b with SMTP id
 adf61e73a8af0-394fc31d45dmr2287672637.41.1771435444229; 
 Wed, 18 Feb 2026 09:24:04 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e5301176dsm12660681a12.13.2026.02.18.09.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 09:24:03 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH] contrib/plugins/uftrace_symbols.py: filter out some addr2line
 error messages
Date: Wed, 18 Feb 2026 09:23:56 -0800
Message-ID: <20260218172356.938236-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This was found when tracing Hafnium and SLOF binaries, and it's probably
related to a bug in toolchain used. It's safe to ignore those entries,
and related symbols will still be present in output, whether they can be
found or not.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 21704541a6c..7d79b81cdec 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -59,6 +59,9 @@ def find_symbols_locations(elf_file, symbols):
         print(e.output)
         raise
     out = out.strip().split('\n')
+    # filter out some addr2line error messages
+    skip_err='addr2line: DWARF error: mangled line number section (bad file number)'
+    out = [src for src in out if src != skip_err]
     assert len(out) == len(symbols)
     for i in range(len(symbols)):
         s = symbols[i]
-- 
2.47.3


