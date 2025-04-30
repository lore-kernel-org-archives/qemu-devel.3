Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96057C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uABtn-0000kM-Ol; Wed, 30 Apr 2025 14:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uABta-0000fh-Im
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:10:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uABtW-0004Xw-Lp
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:10:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c33ac23edso2464655ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746036650; x=1746641450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/BF/QNgQ+dJfnTuz/wM3CIpXDTlZt2j5m6REOooE3bU=;
 b=S7i7q5t8hv8LfUlMp7A49IfPyYEP90eDWeYQ/fVzxIklFOpjt4unkbVuL9glWo65QY
 /eEPowr6+ZhvQvl0EqR0G2MjvZPT7+WOa7lhCG0g7DvCoTgfKjwlcTmrfmLMl9pdA5jj
 qfPSjTmOZ8AvL6KDvF+Kc7yVOXg+Q3TTguT1qczX55XMgYIYCYnanxJ74JlKGqS4Sjw2
 0lR8e8bPCFTiWjqKvsAezIfAcN3/hSTl1IxrdDmDg50pciYBlKFrhnRvcQfxCKRJndQb
 jKeo02m9L+WkrYAQ2RXmJobC3yKCbCWtNP1nzzs4t1v0jElJViKOGw1HlGfuzrgimd+t
 4zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746036650; x=1746641450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/BF/QNgQ+dJfnTuz/wM3CIpXDTlZt2j5m6REOooE3bU=;
 b=DNcUDOdotFjLS0QLc/8oRN0KzZ9WKK+BewKntjgC9lwaE6EExsTehLS1SfiltGnte5
 xmCGrlt2Ef08ysOL2ATj5EMX/NSaUblTSwUX3GgQ+ERylNkFu91zgA3naraamjRp7J5n
 Y0GmAqEaLRVI9CViDRZzBfX3v0GrEi1xkvQQIeIIE8nA5Ii69/O3Lx4+RXqubjUdhT0F
 vK3CqIIshhX19Vr5yf4iFidsgjHvQeOxR5qbM26cOBVT1ftKzQcs2kua/PfTxp50NWOl
 erhAZWqEXVYMVmxxyRTFmDgPfPGwz/dfRLYbYHux7Z0JqqcQsXDOiS5r+Om1EN61ndTn
 3UkA==
X-Gm-Message-State: AOJu0YzD4DE1e7scp0/NL7fMm8zOedeXS8YD8DWRCqz/ZBshIdjtEHA5
 X7j7No3hfD3sScbyF+OYVXDH4lpNTsDFu7vOEyiMD5C7B/e18Rz0zZpPunQq6hU1gK3wYKndXKv
 K
X-Gm-Gg: ASbGnctHw86HXxGmhZ1O5FH2nfiTJ9qaA/pDK6A2vbcCOVtVcwt0OyqjTJYAUqqVb4E
 cVDAOHuRCAdrC+K4WNFnEEDPu0G0t9SFd0t6vNJfaiEeOVL7E4suMvsQQf/g+cUnF9+G2NJ1lvU
 2ZlIPJ5Skq3MsD0NmSl2XvpYOZ5gdqYJOYVULKSbd5C+ZLclE+o9NT3LqBw0bNejMzIWvSm8Zzv
 eXqHirdX8DRRVxanJSycycndLbudYb6rkJthD10FuaeovK787PSep12eEOuyqwuERIDhUtmvk7y
 8AfehEmYrULXiYENMTRtDKCaBxoENFxSnjdEReab
X-Google-Smtp-Source: AGHT+IG6nIw1IEbij4FZ9QZraxMQ1qZP2+fabnZRYt8ZtFkHETgVGra9oRaAR7OGlWKjkLpzaY4V7A==
X-Received: by 2002:a17:90b:50cf:b0:2ff:6488:e01c with SMTP id
 98e67ed59e1d1-30a3336b8bfmr6334198a91.29.1746036650671; 
 Wed, 30 Apr 2025 11:10:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3477889csm1982263a91.26.2025.04.30.11.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 11:10:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] docs/devel/build-environment: enhance MSYS2 instructions
Date: Wed, 30 Apr 2025 11:10:47 -0700
Message-ID: <20250430181047.2043492-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Add missing prerequisite packages, and use more explicit makepkg
command.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/build-environment.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
index f133ef2e012..661f6ea8504 100644
--- a/docs/devel/build-environment.rst
+++ b/docs/devel/build-environment.rst
@@ -97,11 +97,11 @@ build QEMU in MSYS2 itself.
 
 ::
 
-    pacman -S wget
+    pacman -S wget base-devel git
     wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/heads/master/mingw-w64-qemu/PKGBUILD
     # Some packages may be missing for your environment, installation will still
     # be done though.
-    makepkg -s PKGBUILD || true
+    makepkg --syncdeps --nobuild PKGBUILD || true
 
 Build on windows-aarch64
 ++++++++++++++++++++++++
-- 
2.47.2


