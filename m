Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD42CCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6whD-0007wr-0W; Thu, 09 Oct 2025 15:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6whA-0007so-4I
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:53:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wh3-0004XU-4i
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso10924275e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760039568; x=1760644368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnoVU9PkzxRhq273VX1ANT/1nCaEAcbS7E7sJHM05Mk=;
 b=aRKdZ1eOi1VQQyXTiYlbhVrNXL0W2le+z82Yb3zQvFtkhcSLID/OfCo48arxF/U0nd
 3vuadWnzW0aGYC/PfrngIxetzHn5WnDMBUzxOTv5+44Y9cHdRjHjHUOIYKde/Ky6CpC6
 7PD53W8pSkGgCRMZoHuBdy+TT7DjApJ4sgCzCHvGHuH8sQnnwwJJZzc1rEjr29AqPmAZ
 BgD4xZlf48U95yVhjcZJNMabQSz2ZO22o0C9WgIwmD7AfsBXoxX6Cvp8BCKgkaCfZC/0
 RbmzpBJ0lhX+AV9vjn6ZtX0sCMfuoQBasHBJAs0OMMFAo5i/YEN96lxM+tgGwj2e0skq
 q9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039568; x=1760644368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnoVU9PkzxRhq273VX1ANT/1nCaEAcbS7E7sJHM05Mk=;
 b=cK6R9qow3v6oAG/e0d5s1lWbexhHRlEI/q6vpB4+cq1xrEW6hiJKIDQzJAJghs3Bef
 u4YIBAjVwxfy3pRRBQAga4AJv/RBMAznDRcEV8C4PP9FUgt3Wxu5NbfylLeJc/BntRQJ
 rFrdBqpggCN2i1kj6nRDy6RWZTeC++nT1Cr8FyRG1fFoyJIQejm+da9Pp3A9bWrTIgh/
 KbSoIVMweFfKOGNbz6vlxScofmiWzN+pBoi49ENnCbxZQhRNJahnvr69Ht1k1KYip0Le
 I2ksQ2b0jARweZbG8QLM80ydArVSrhwd82k/S+Qrx3ag09nXglgWinLqomxv8uW4e+OE
 x8kg==
X-Gm-Message-State: AOJu0YzHz3TkQT70j5sTMko4RwsrBHuwN9FyksGBo0+dly2uuztNXSeQ
 0r+hErKcESzPLZq8Z5NUr05IwPQ5EBnkFK9DwaEzAXVZE6GEKZVAo0cczsCXXu9O4goyWAq2tGL
 EuaLWwqg5EA==
X-Gm-Gg: ASbGnct5M1als7X9+FiGlW5tsHowbQpBHNyvPdWtPBfHPmGs96Uf+CL+cxaoEoMrvXc
 xndQvVz1EZEn0BItYFhPXlnfGu2ZjrC5tKh9fuO1RkXGHFNDTYwgtLTLjXTQdY+q3KBUt8HeYTY
 LjL2FuRKS19+Lve0URMuwIxtpXpExmXn+MaYnUVnaC4pnw6UL885wSbiQ/Xq9XLNGRLEy6ReZYq
 E1VNljTYdlB3uGDNTQQkdcoyxMI6ieUxWmiaydpzi+Ewu919ZyDha3daqxRmTqSZXhli/WH8bET
 PULYCNv9IPz7BulCdVawxUqHfZjbRazJvXkCuuFlQVTKJZO/ibaCD0kcLAei45yJ/C3+KLoWtLN
 Ln+XcuEQDvtz5eYqCF18K54r+cFczfX2h3vrSzAKX9hz7IPz6aRa3tGxlk4LBgD/nj/tjK/LByL
 ksSCM5AbZLxrs6RK/WTBTv+siR
X-Google-Smtp-Source: AGHT+IHD05VI+VUxrgZGD7ltEMp4z3Ptia3651WqJPgf3dTLFn3O6SAG+249BZWyozBAvp0kuw5UwQ==
X-Received: by 2002:a05:600c:a309:b0:46f:b42e:e390 with SMTP id
 5b1f17b1804b1-46fb42ee4b8mr10771845e9.20.1760039567669; 
 Thu, 09 Oct 2025 12:52:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49c4027sm9842925e9.17.2025.10.09.12.52.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 12:52:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 7/7] buildsys: Remove support for 32-bit MIPS hosts
Date: Thu,  9 Oct 2025 21:52:10 +0200
Message-ID: <20251009195210.33161-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009195210.33161-1-philmd@linaro.org>
References: <20251009195210.33161-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Stop detecting 32-bit MIPS host as supported, update the
deprecation document. See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       | 13 +++++--------
 docs/about/removed-features.rst |  6 ++++++
 configure                       |  7 -------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 67e527740c0..79cc34cfeb6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -172,17 +172,14 @@ This argument has always been ignored.
 Host Architectures
 ------------------
 
-Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2, MIPS since 11.0
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+MIPS (since 11.0)
+'''''''''''''''''
 
-As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
-MIPS moved out of support making it hard to maintain our
-cross-compilation CI tests of the architecture. As we no longer have
-CI coverage support may bitrot away before the deprecation process
+MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
+maintain our cross-compilation CI tests of the architecture. As we no longer
+have CI coverage support may bitrot away before the deprecation process
 completes.
 
-Likewise, MIPS is not supported by Debian 13 ("Trixie") and newer.
-
 System emulation on 32-bit x86 hosts (since 8.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a5338e44c24..53829f59e65 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -896,6 +896,12 @@ work around the atomicity issues in system mode by running all vCPUs
 in a single thread context; in user mode atomicity was simply broken.
 From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 
+32-bit MIPS (since 11.0)
+''''''''''''''''''''''''
+
+Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
+maintain our cross-compilation CI tests of the architecture.
+
 Guest Emulator ISAs
 -------------------
 
diff --git a/configure b/configure
index 6a633ac2b16..8236f43e8f9 100755
--- a/configure
+++ b/configure
@@ -404,8 +404,6 @@ elif check_define _ARCH_PPC ; then
 elif check_define __mips__ ; then
   if check_define __mips64 ; then
     cpu="mips64"
-  else
-    cpu="mips"
   fi
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
@@ -473,11 +471,6 @@ case "$cpu" in
     host_arch=mips
     linux_arch=mips
     ;;
-  mips*)
-    cpu=mips
-    host_arch=mips
-    linux_arch=mips
-    ;;
 
   ppc)
     host_arch=ppc
-- 
2.51.0


