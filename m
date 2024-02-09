Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688B8C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWqa-0005Tg-BV; Fri, 09 Feb 2024 14:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqY-0005S1-Pg
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:38 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqX-0005AU-7V
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:38 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3394ca0c874so738492f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508055; x=1708112855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDST6ZYRUBMYsgR5athhw3QaJCGBzoioSBcURkEVIhM=;
 b=UuXNDLThMSsIBTTo+CRbRJG4gQRg+tasXJKjS4Bvxq3Cr6IOY9VA7lwP6HhuwrdFML
 ROpUynbQEO6rzyY3eGm8Yc9rHUWFYZ9QWSdA6ISAyDWZlc9ePAoCn+3mBJGw0Jsnt+7z
 XTnrwhUNZGn+DQAFziOvFt9S3kZoUoXwf+qORo0N0LdMbXl8Qoa14w0UVclNuTi/dOsn
 pBt2GFyXKSjPtb8HL0sP1v5p/tbuLSDS7iX4EaSZKt6fBpHWSwPCYAfmbvSHJxvu2CIP
 FOmpo6bMTRCsaUCA1qoaI/rp59SXC2K8tG5Z/uMBuzT4foK5XySITz4o1iJK1APaL7rU
 hmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508055; x=1708112855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDST6ZYRUBMYsgR5athhw3QaJCGBzoioSBcURkEVIhM=;
 b=pSJAnPOtAIJxeRCLssMFgm08B7P0BJqqDJJPvmebizdXI2X/uC0g7IS7wmrXgdm0HA
 gMAEGDPd5fTpcUxeSCxFPX6RyY4ZLeyvqQfaz7b7huzpmIT6B1299rGhdkB+QRZ2yQuo
 gVHiTY+IYddS4l4VYztGxmXTHUW3g4CXZFF6u3T0EVeqH2krgQzTKm7hbmWz+xq8HZ0F
 HbpgfAhsanYPECi1ppGuxrVwgVsyQwRwvA26rNwhROIpfE7/6keiWl8/0nJyL310A9Jz
 YILm0YvXY5qP9FF0FqMlc/zT3zf8GAOOELIMezepMP0MWLC9nKJva6/1/WdCUGIttD1O
 9TMw==
X-Gm-Message-State: AOJu0Yw/ew2k3mu5IEBuR5XatUuHcDx1eYV6ZB4PU4w7HStqeEvkhkyA
 PALF08HC2qzunjGRok2wCliJbkGJTF8KLx14/CVK5pqCkIzeesy57UZTgQPUWAY=
X-Google-Smtp-Source: AGHT+IGY08VRri6USeYHA6D69zAL4Bol8nW8HojVJ3msXJn5z5xH4ipRo3I8gB152OA6XrDg4S+fBQ==
X-Received: by 2002:adf:e384:0:b0:33b:1588:2250 with SMTP id
 e4-20020adfe384000000b0033b15882250mr27416wrm.8.1707508055512; 
 Fri, 09 Feb 2024 11:47:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVwe3OEzZ1eq9nSs36RIp/eIyudTPV4jue8K1Wi0UQvlbiHGcXbW8fgs7TI5XXfYZ5OLm29aAwUvcRjmL1tfLeMoU4mj58Ad4+npX4fADLZAe6zGNQgqSqXhMzGSjyyMTMM6gE/R7zwUTtxj84Pz3t0aeZ79REbwiv1OGhKsHAEg4x16L0XB8eBh11SCCxGR3n93BGtv12Hw1b2nKwHyVpciOyheWtbsA==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g7-20020a5d5407000000b003392206c808sm42277wrv.105.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE9AE5F7DF;
 Fri,  9 Feb 2024 19:47:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/10] tests/docker: Add sqlite3 module to openSUSE Leap
 container
Date: Fri,  9 Feb 2024 19:47:25 +0000
Message-Id: <20240209194734.3424785-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

From: Fabiano Rosas <farosas@suse.de>

Avocado needs sqlite3:

  Failed to load plugin from module "avocado.plugins.journal":
  ImportError("Module 'sqlite3' is not installed.
  Use: sudo zypper install python311 to install it")

>From 'zypper info python311':
  "This package supplies rich command line features provided by
  readline, and sqlite3 support for the interpreter core, thus forming
  a so called "extended" runtime."

Include the appropriate package in the lcitool mappings which will
guarantee the dockerfile gets properly updated when lcitool is
run. Also include the updated dockerfile.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240117164227.32143-1-farosas@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-2-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index dc0e36ce488..cf753383a45 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -90,6 +90,7 @@ RUN zypper update -y && \
            pcre-devel-static \
            pipewire-devel \
            pkgconfig \
+           python311 \
            python311-base \
            python311-pip \
            python311-setuptools \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 0b908882f1d..407c03301bf 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -59,6 +59,10 @@ mappings:
     CentOSStream8:
     OpenSUSELeap15:
 
+  python3-sqlite3:
+    CentOSStream8: python38
+    OpenSUSELeap15: python311
+
   python3-tomli:
     # test using tomllib
     apk:
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 82092c9f175..149b15de57b 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -97,6 +97,7 @@ packages:
  - python3-pip
  - python3-sphinx
  - python3-sphinx-rtd-theme
+ - python3-sqlite3
  - python3-tomli
  - python3-venv
  - rpm2cpio
-- 
2.39.2


