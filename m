Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D72C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmm2-0002WH-Fu; Fri, 17 Jan 2025 08:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlu-0002U4-8y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:26 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlr-0003kv-6M
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436341f575fso22323415e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121939; x=1737726739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9E60eH4NFvltUAEYDSdM5V//h4nzKoVHstzvrxeFhY=;
 b=eEpiqNoqza0cU6LkqIbyfHOsBNyFUu6u+6vma9YecLDLmT0GVoG2okc1xivodJbnx5
 EoHJfln8xRYAtP2JLwO2c12Znt2jzehMm2+/FtPbzKumbhDqPX6aolsmfqN2f+T7JJSY
 2Mrc0Y6wCamXD1XnNXMRy59bjJXbBds2gKg4pmf8KDyrDIk8bR79WmSK+5LW5Hld1R8u
 1+9RUBHpnxgCt0woEO0PwXaCZLHuLjPnar0C04yNm3S5nIuGLo+alF7e+NeKDmNXqdXw
 032VrRqDh639pl2pQpF+25O8InTijGDpTNdtdR9DKBIxfg4OyKx4esjLy97/+ihWKkH2
 ByyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121939; x=1737726739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9E60eH4NFvltUAEYDSdM5V//h4nzKoVHstzvrxeFhY=;
 b=pAm9KHee8Y/fFKmW3QrdICanyf7Ri22rgtHyGBe3G+1fcU4BpngdttSWz8g+K+TBHO
 dnaV0NI7H0siWzIZq7b4K+vGf17suf2vDeugRbUiX6TZVu/4CNWPFS7ojSZNr1sU0Tin
 CHQZqbrHYMBscSsHlm+jdAFZw5ILXVzXmDH19/U4t3DDmD018Dz9h9QzL5uvTk1Fsx2o
 cSd2FK5m9DVEIhb9UZGClpZ1tMZdCd2PVtsmX3+B2FNc438Qhf3JWoslHUwdXTIQwEOz
 UiPQDGemEHKGiwMo4nGtd282XKB8s1nqyLvjF/y+PkAzvt15lxysqKdwqcJpKwBKIIRm
 107Q==
X-Gm-Message-State: AOJu0YwNqTpw285sEMDMBQ/eJ39Qoo/vCR7aRHWVa5MdbSy/zbUT9qFl
 VeeIMIWtbT6hJB/a8AAVWorgZikevgpRcF83u94RA6EI6RYmvfuuQo9aU9UEQv8=
X-Gm-Gg: ASbGncvevLJKegkcA2m74jdeCq1BglGhHaFpknYQJEmaNPlay12kzHayXZwRpjzwbde
 LBm6nPKyayp6oCK+wogztNE+0wXFVFs7J9Nsgfh/brXilsLufUUxISyFlTJ4T9Ov1DJDnT4QBJs
 ceKmsbjjur3eGSvwd5Q0afljX16rfj8A7vIExJBTRsRUW7GLK58Lc81eKgVL70REI165TDlNW8H
 W1YNNZtGbVnC4gsod+fmAdmccXUE769+QplRJj+g/vj0lf87aBWEYg=
X-Google-Smtp-Source: AGHT+IG5mcO1rxRyOUbTNuwhLXWjAL/+7wGngHsS4rZECwG9QK7TrsUE2tUSBjPSOA9n7LnzLzLYbA==
X-Received: by 2002:a5d:6d86:0:b0:385:fc00:f5e1 with SMTP id
 ffacd0b85a97d-38bf5649261mr2859093f8f.9.1737121939007; 
 Fri, 17 Jan 2025 05:52:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384cea151sm173570766b.74.2025.01.17.05.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 960BD608F7;
 Fri, 17 Jan 2025 13:43:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 37/37] scripts/nsis.py: Run dependency check for each DLL file
 only once
Date: Fri, 17 Jan 2025 13:42:56 +0000
Message-Id: <20250117134256.2079356-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Stefan Weil <sw@weilnetz.de>

Each DLL should only be checked once for dependencies, but
several hundred (781 in my test) unneeded checks were done.

Now the script is significantly faster (16 s in my build).

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250111215244.1680931-1-sw@weilnetz.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-38-alex.bennee@linaro.org>

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


