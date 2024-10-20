Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2E3D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 21:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2dcp-0003Sy-EA; Sun, 20 Oct 2024 17:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2dco-0003Sm-G4
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 17:38:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2dcm-0003wf-Uc
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 17:38:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso33610915ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729460287; x=1730065087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7vFprbnmB2ueZTh46/6yM52n7wcdaWMGkbgty+cVJvs=;
 b=cUtZeH8D9xIDFzRzwyMXo48abMxJnfOLzFm2I+oyRkAurla79XH1OjMso4+8my6/EX
 z5fflIIFRG1kjUhoi6R/XXX0N0KsAGOtJbrt/KqUSnA3c5GOT9ngIMHF7rNPdf+vAUp1
 KbBTbJhufFeMb5RC1CvbUGWESdsSBl8eij2NloljppGNHnLyccptbL43UOvVIzr4hCeG
 cYuKiBuWZ4tAzLpvOBGI87gzt8rgLpphOgb5ktW5pH+F9rISNrpe6Mxo83XnNC63r7t4
 w/mIdZtTJ+lSGPj3gGGhpBTkXTcM8lrLK7AQ94XK2XLWx4F3zNFoFNbXkgn2nL3jEOCA
 L97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729460287; x=1730065087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7vFprbnmB2ueZTh46/6yM52n7wcdaWMGkbgty+cVJvs=;
 b=hY7s0vLF+qejI2wjRGd7fG6/v9lDUvdL0zcCZdvmIyVkdSBJ4CfcdXs/Ig2M73F90p
 2sdaSgKVcke8g/sX+Edqk2icQkkYdBFtGrMWaSubEGicJivrTkrU8aAW0//E/zZr+iOX
 OWT0SrvKd8y+nMe722eW1pQLVzO3DFqzYH0gQLQcZR/A1jB7YGP+Yz7nvFwjyNDXoLbu
 T1IJ8cM/P8n0XJSoLK47rgj44xPTW6YYHVzhJdz/zCYYaBaQebDs0QxgDg3myvrQRJFm
 fypqJa9aa8D8NiwGgcPhzRvfPxaLosiov36UARy/loEMIciY/viPryRbaDoY1GCjlGzK
 jQyA==
X-Gm-Message-State: AOJu0YwnSB06GhDvBQ47SbC+VjEM9MZcey9giVm2Q3lOPgD6ln/gmOx4
 MqLa3r6FCRzmno6LyH2CqYcLuk6a1QD3lkH4uIoNirJa974IbJsVizr6H9fi1/cTpC2JMdfsZel
 1NtgoFg==
X-Google-Smtp-Source: AGHT+IHsSx9gBBiR36KpEUq7ugYN9ZGBLNfBllhJSU2KZh83s34PNhnOwrn7ydct0Dv4nXvYBK2pXA==
X-Received: by 2002:a17:902:dac7:b0:20c:5bf8:bd6e with SMTP id
 d9443c01a7336-20e5a8fb30amr126470235ad.48.1729460286763; 
 Sun, 20 Oct 2024 14:38:06 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad4ed40dsm2014060a91.38.2024.10.20.14.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 14:38:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] dockerfiles: fix default targets for debian-loongarch-cross
Date: Sun, 20 Oct 2024 14:37:59 -0700
Message-Id: <20241020213759.2168248-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

fix system target name, and remove --disable-system (which deactivates
system target).

Found using: make docker-test-build@debian-loongarch-cross V=1

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/docker/dockerfiles/debian-loongarch-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 79eab5621ef..538ab534902 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -43,8 +43,8 @@ RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.
 ENV PATH $PATH:/opt/cross-tools/bin
 ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
 
-ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch-softmmu
+ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
+ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
 ENV MAKE /usr/bin/make
 
 # As a final step configure the user (if env is defined)
-- 
2.39.5


