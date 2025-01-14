Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF37E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfG0-0005Fp-4I; Tue, 14 Jan 2025 06:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFm-000588-D0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:39 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFk-0005S0-IN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:37 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so853684266b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854715; x=1737459515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDXNnBxwJoyhgKzJMRdJdgCJlpb7weenjpk6uMi/xEU=;
 b=vkTjeihMvfC4FGejwkazgVoEKymzwpqpuWa3w07fd0bgaR6WDu+E6to/KEyd9gzEsl
 MABI18ivqvfchtdXMjdnMeGlDLP5YrUS8xOXg5WKHgVedMNHjoULAkGdN8nY1Nja4Kt/
 Obh3L72pJ/KByXixjHMzxY2+iTC9x6DsGuyn+Fg35A3dUD8NDmWEf/sf4milb8gKMPzF
 AQXug/vyhaSJbISRCDKs5Ca9V2lCwmCvNROm8n7HxumuYkYfDRfXomc0lQXshq4aPzHA
 TmGbt+Mo0Ke+9knATJub2MjlMimWr1qjISST/TAM7o+M3RgAuz5IehwwWVDgzuQo7bVA
 4+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854715; x=1737459515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDXNnBxwJoyhgKzJMRdJdgCJlpb7weenjpk6uMi/xEU=;
 b=b/cRkFd5ly+l7+XU8L6Ch66EeFQKoOtPK2O81i8ONFggVVSU1OoLgSug+Kwrg51q2Z
 8YE/GvKIhiJTzcSSheK7vvJ3KraAgF3BWy0LBBt0Rt9ieGEkVJsPZm8gH0QgygHkTvLW
 kbdRTB0YgqXxGEYYYV0wBJoGfQj/JmNchk3fwqc+jixSR7NhKLHrOsIujaVPhHfF19Np
 S7jpbCC6pZx9ArQO0ZuD5ajnHoqEJWCkBtX0p32AArTr6jJubYm9Vy9LRkmi9Iwiz0RP
 HvXkyfgRiBikrm6/f8Bih2oS5DR/DsKQ4YTuFJURIRSMu53oIz/RH0psUvWSfrnVJVvf
 i46Q==
X-Gm-Message-State: AOJu0YzgvSIa4EmKNFA/06IB4VgcgdS2/Pkned+fCV9xxSDYR2j2N8cU
 adeMKIjqCIy2P4IqRdTMfqolCFn/VESM05kDb4bN4UBdFFwds7g5iD7TvvTDmetTuJE8z1AmHbT
 LcxQ=
X-Gm-Gg: ASbGncu2EsmvLGiTYHfmVCwOVWHCt/0PYeBBq1RVgijl1KpHSbXka6KI06+iXSbALC7
 gI23yRprVTu0b8Dybl7v4LDwCMNFb6wqx/Bd3GuuqBAjYdoePybJ84d2yBXI1M66Bbt2lVA0HtR
 DR/fhNZ5IQ5d6uctyiWfQ0kYM98dCT2BRI4cnYzfEAf54z8dWDKJY6a/Ezz1csNaEnlbYw2ewu1
 Ol4VpnH1c25/ggIyxlpGFV4rR/8D971IiuEDcEfOUOMwYEcpmJmCss=
X-Google-Smtp-Source: AGHT+IF6AB4hDlV3ZMwbBiLRdFpJ3HRrXBR/Mqiw9QdIMEd/dgQJvlBSQa1OVcSy6eSzrw6MVORGlQ==
X-Received: by 2002:a17:907:96a0:b0:aa6:87e8:1d08 with SMTP id
 a640c23a62f3a-ab2ab6bffc3mr1834463066b.8.1736854715006; 
 Tue, 14 Jan 2025 03:38:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9060b9dsm621953966b.4.2025.01.14.03.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6397D5F8B5;
 Tue, 14 Jan 2025 11:38:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v2 37/37] scripts/nsis.py: Run dependency check for each DLL
 file only once
Date: Tue, 14 Jan 2025 11:38:21 +0000
Message-Id: <20250114113821.768750-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

From: Stefan Weil via <qemu-devel@nongnu.org>

Each DLL should only be checked once for dependencies, but
several hundred (781 in my test) unneeded checks were done.

Now the script is significantly faster (16 s in my build).

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250111215244.1680931-1-sw@weilnetz.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/nsis.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/nsis.py b/scripts/nsis.py
index 03ed7608a2..af4e064819 100644
--- a/scripts/nsis.py
+++ b/scripts/nsis.py
@@ -37,10 +37,10 @@ def find_deps(exe_or_dll, search_path, analyzed_deps):
 
         analyzed_deps.add(dep)
         # locate the dll dependencies recursively
-        rdeps = find_deps(dll, search_path, analyzed_deps)
+        analyzed_deps, rdeps = find_deps(dll, search_path, analyzed_deps)
         deps.extend(rdeps)
 
-    return deps
+    return analyzed_deps, deps
 
 def main():
     parser = argparse.ArgumentParser(description="QEMU NSIS build helper.")
@@ -92,18 +92,18 @@ def main():
         dlldir = os.path.join(destdir + prefix, "dll")
         os.mkdir(dlldir)
 
+        analyzed_deps = set()
         for exe in glob.glob(os.path.join(destdir + prefix, "*.exe")):
             signcode(exe)
 
             # find all dll dependencies
-            deps = set(find_deps(exe, search_path, set()))
+            analyzed_deps, deps = find_deps(exe, search_path, analyzed_deps)
+            deps = set(deps)
             deps.remove(exe)
 
             # copy all dlls to the DLLDIR
             for dep in deps:
                 dllfile = os.path.join(dlldir, os.path.basename(dep))
-                if (os.path.exists(dllfile)):
-                    continue
                 print("Copying '%s' to '%s'" % (dep, dllfile))
                 shutil.copy(dep, dllfile)
 
-- 
2.39.5


