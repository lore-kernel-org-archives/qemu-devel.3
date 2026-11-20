Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDF606A6E8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vOjigwHB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUrv-0001LN-V6; Fri, 20 Nov 2026 15:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrP-0001AA-LV
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrM-0001tk-RK
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so10527305e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205123; x=1795809923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fnmqKdmm58bKwG+wkVcI14sV7PN4tzLg6CI/lKCm1QU=;
 b=vOjigwHBJoCBL/FluVoeLE8in5JwABWnTlj1iMzU5MWCvh1o6tMw7GxdFyuhlo9xrZ
 uEOuuAkW9kMZkEZ8WuefIvsnI2cnkVZYI9T5wiSsZpwJD4bglnI/QX/Pg/d5FjCN3mn2
 lQHqPMM3AQRMiBZGBYt/zaMX/Thvft1xM3EE33rTG9d9xP4PDL585cI81Neynzvi+vw0
 JT1lADLzFFeCUaRJd1UiM3LEhVb/SnVSy50wzM34NOA7cE0VJ/n81C7jT+Fcgdud6XuM
 ehf9RY8mvRtG7eM64g2JYRmILMSqC6fsT7TKNBsIlg8cu/lnOKSn5+mDM0FUt9+DuD/N
 /daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205123; x=1795809923;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fnmqKdmm58bKwG+wkVcI14sV7PN4tzLg6CI/lKCm1QU=;
 b=JgiLCv2suTS8/tNfDFTO7vQbQEmsVFg/AfrlBGfCzoihQXXr89CDqaNKAko+fm4IgU
 JlUGJKOMPyMOkEhT9749FahJDZiIqTaqPPnVmKbOe9C1FT3C9g4dgODfTe92f/QDnmn+
 oAXqpqjYHTYqKsRR3hXGW9wzApITSXZqztx8WH8vbp6bmGArxBiQ9ELQApxtcPFSJa27
 +dzzbalNv4u3cMUDPIO/+/uogf71afNRootCA/e84bqz0pTkRCVTKzYwPUSacCXpOYSe
 qqaYEgaa12f88mcAhdC26+H4NJ2v8KdaPNfALroWv5IjvhB9FJuJLY7adFQolAQZ7RCp
 JVHQ==
X-Gm-Message-State: APuU4Z+Xp7BQUVMOCpp+ulFSXvd48zlBqsbhnC6gi40a1QCkQKGFIRXH
 N9TAPIsQnynzxHUKS0u0zzbu4P5qlQHZ5YgzwBVwVXKszB+Dk5qwXHXr0hWos0mOYMtkwIAJcda
 IsuXZ
X-Gm-Gg: AYBFou1p9xYgeyote+n0t3kgYn/LQcyVOO8eaBKj69b+0bm5Em8Q0mRGiSAO7Ak/kqD
 /BwURvbRjvFznEOJvDuPQPNr9SX0Y1jyciz8wiIRhE4oocLXayDRtaT2XktdsyzVRkF2m3wP41U
 CWtU5D96BpNqpYJsIyBLwdLSGizFeh8V+tIJ9PYq1rGqOJ5lfQachJ1AnvUm96zqN7ew65iR172
 XREh/Dv0WSUuakH00v9PdAgTpIBvNwVfSiliokKr/NThC00sZHbY/IenB3erZYwKPxrVp4kBTfN
 ExjUX39au/P8cjmP8nxqSPAwd5ZB6e8znChRJNdReWAt706uTTpkz8vj/l1zCaeKniu1N0Jrl+a
 UgrgTl/PFjlIJW9bNqHCqN6BYfbhMvDNU46nf1s86VU0+0yUTVX4G4H9HmVOPCx8GsgSX41jjxA
 yPeyO4oF0X5kSvSpPcjAVMepmMdGJq7P31Btn7lncVfhx3619AzRF99ORV2CsK4K7f3N9neqWjq
 3T3/jnNu41ChDlGiQddEcrqN0DPmgeoHDg9XU2gDzmrR8TcstOhubbRcfk+8F1PCVkZ91R+WPXA
 H3d7DwXZ6bGqM8XypL+LRQpFPQI+
X-Received: by 2002:a05:600c:154f:b0:4bb:6842:66ef with SMTP id
 5b1f17b1804b1-4bb8893a963mr92679415e9.30.1795205123150; 
 Fri, 20 Nov 2026 12:05:23 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm155069345e9.14.2026.11.20.12.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36DED5FC4B;
 Fri, 20 Nov 2026 20:05:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 18/22] MAINTAINERS: update Daniel's entries to be consistent
Date: Fri, 20 Nov 2026 20:05:06 +0000
Message-ID: <20261120200511.822573-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When testing my get_maintainers.py I was shocked to see:

  ➜  ./scripts/get_maintainer.py --list-absent-maintainers-since "2 years ago"
  Maintainer              Last Seen   Email(s)                        Subsystems
  ------------------------------------------------------------------------------
  ...
  Daniel P. Berrange      2024-06-10  berrange@redhat.com             QOM, QDev, Seccomp, Cryptography, Buffers, I/O Channels, User authorization, Sockets, File monitor, Functional testing framework, Build system architecture, Meson, GIT submodules

Which is of course incorrect but tripped up by the fact we have been
utf-8 clean for some time. There are some entries that are correct so
fix up the rest in solidarity with my fellow utf-8 using hackers ;-)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2bd501f18e..031183706a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3748,7 +3748,7 @@ T: git https://github.com/kostyanf14/qemu.git qga-win32
 
 QOM
 M: Paolo Bonzini <pbonzini@redhat.com>
-R: Daniel P. Berrange <berrange@redhat.com>
+R: Daniel P. Berrangé <berrange@redhat.com>
 S: Supported
 F: docs/devel/qom.rst
 F: include/qom/
@@ -3763,7 +3763,7 @@ F: tests/qtest/qom-test.c
 
 QDev
 M: Paolo Bonzini <pbonzini@redhat.com>
-R: Daniel P. Berrange <berrange@redhat.com>
+R: Daniel P. Berrangé <berrange@redhat.com>
 S: Supported
 F: docs/qdev-device-use.txt
 F: hw/core/qdev*
@@ -3996,14 +3996,14 @@ F: tests/qtest/dbus*
 F: scripts/xml-preprocess*
 
 Seccomp
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Odd Fixes
 F: system/qemu-seccomp.c
 F: include/system/seccomp.h
 F: tests/unit/test-seccomp.c
 
 Cryptography
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Maintained
 F: crypto/
 F: include/crypto/
@@ -4024,20 +4024,20 @@ F: include/qemu/coroutine*
 F: tests/unit/test-coroutine.c
 
 Buffers
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Odd Fixes
 F: util/buffer.c
 F: include/qemu/buffer.h
 
 I/O Channels
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Maintained
 F: io/
 F: include/io/
 F: tests/unit/test-io-*
 
 User authorization
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Maintained
 F: authz/
 F: qapi/authz.json
@@ -4045,14 +4045,14 @@ F: include/authz/
 F: tests/unit/test-authz-*
 
 Sockets
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Maintained
 F: include/qemu/sockets.h
 F: util/qemu-sockets.c
 F: qapi/sockets.json
 
 File monitor
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Odd Fixes
 F: util/filemonitor*.c
 F: include/qemu/filemonitor.h
@@ -4190,7 +4190,7 @@ F: docs/specs/fsi.rst
 F: tests/qtest/aspeed_fsi-test.c
 
 Firmware schema specifications
-R: Daniel P. Berrange <berrange@redhat.com>
+R: Daniel P. Berrangé <berrange@redhat.com>
 R: Kashyap Chamarthy <kchamart@redhat.com>
 S: Orphan
 F: docs/interop/firmware.json
@@ -4691,7 +4691,7 @@ F: tests/vm/freebsd
 Functional testing framework
 M: Thomas Huth <th.huth+qemu@posteo.eu>
 R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
-R: Daniel P. Berrange <berrange@redhat.com>
+R: Daniel P. Berrangé <berrange@redhat.com>
 S: Odd Fixes
 F: docs/devel/testing/functional.rst
 F: scripts/clean_functional_cache.py
@@ -4723,7 +4723,7 @@ F: .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
 Documentation
 -------------
 Build system architecture
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Odd Fixes
 F: docs/devel/build-system.rst
 
@@ -4753,7 +4753,7 @@ Build System
 Meson
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
-R: Daniel P. Berrange <berrange@redhat.com>
+R: Daniel P. Berrangé <berrange@redhat.com>
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: meson.build
@@ -4785,7 +4785,7 @@ F: hw/*/Kconfig*
 F: target/*/Kconfig*
 
 GIT submodules
-M: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrangé <berrange@redhat.com>
 S: Odd Fixes
 F: scripts/git-submodule.sh
 
-- 
2.47.3


