Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE408C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQR-0001lQ-8G; Fri, 04 Sep 2026 08:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQP-0001k3-Ee
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQN-0000kw-PZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so8552015e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526422; x=1789131222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=giVANm8A48zk3F2cwUknNmD1Ka0brkVNbn2iSQH3HTA=;
 b=rwZQQ7xM/TezSmdXoEGIitjPC8zVrgIMeOMlMGhmRpye1Kr8MCEebBuBXHikU8bkkw
 P8sJbihmkaJ7GUP8oSyEgGompKT+cnJaa1e2ovBzL/iN6IhZFfTC2LnDDPdYYTnExobT
 plnJSGsrbLUdo3CnjJCXlPeDqDb9POeOpefeRoYv6OhvyC8urjTdZDwHm1vHBCjTjlSI
 ZcBREmgtqPHS/rJPIk4f3EQVKmZRothYZH+mU2Y7SQOLBLEHpOsvaBZbaMocGAtXTqNZ
 oR3hI5+MgEuTU1t2KasL9LXSFJHDY8Dt1+EfS8WGVgMwYsJFOsePP5RAU+wrVyaxyJRF
 9tYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526422; x=1789131222;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=giVANm8A48zk3F2cwUknNmD1Ka0brkVNbn2iSQH3HTA=;
 b=THtio0LRIahUrk0xADHYVhdw99adZNpwfoouzixNhLrecM4lu3JCbk8dyLDmoJOBmU
 WTiARydE0pBZQakgxbTFTHcthYZAvInqak6vHH3CzlScjwIZ5MsrDc5MRQomILoZmgwQ
 h7tmF33oRtEtI2vwsqtch3L59kT248y3pZ91iUFV+xR+ieV9lxAfaEKqiKdCkW5Xd04k
 Br3LtL7taiLIwpKCKKrhcfkBYIZluLuvt8KAt1oyWnD5dJwYdALubcmvSNIxmlM4WIxN
 MypwITXSdvKssc4cswKwpQFE2xXLk3frhWBex+PvHjb2eyyYXsuJHd6TvnJawN9+wA60
 3D/Q==
X-Gm-Message-State: AFuF++nK9T/1U1TZsB/fvIajksS3H8EqN4mlot4IMZRDaUD0BFYYpvLU
 pVohzJu8T4d4GQaMo/CHrM73Zg96bJv4Ybw6hu01ZFjFTDNcKsrcL7lfhv1Wxk0asLQ=
X-Gm-Gg: AYBFou2dFmnykY+k+vNaFAtDuW7pMlmylSn2WfbzNQk5b21qhqjHf6NrbT4t1FMocwt
 DYCP0Igb0hGF7tqloXLTPuPqv1j4i5fSQCivcYS14Oybxmo/abCdcp0vv9GYkK/t3g/ye5vUStR
 Z5bcLWwbzoZCe4BuqxsyN+pdK8RpWE+2H2hYUibY8ZfTnZn7ZUlQwJyrZmds2cHxEN7Y0rDkxgS
 slHYLwi4I2UruZbU2mzJYFpvnlaXoAIRqcskodn3OJGqV9PsIBlmx4HACGoUQZ9pXKLsD6dzykf
 dwpvghbjVi/eIWXntb4wbhJXONIB5fAkKF6fLqvcat5gdw+YtuEUE2GPacHAnQvvw+wsCkmPOom
 Iiqjgkxm0j5NXUjBIGKmSzjjziBzW18U2KRN2y7rdI5/tfyjSdGd/Cjk+GFDyxKxCoFsKUQKwy/
 ADrxztKs9dBZ3Kcxr15zETrQyIOoFI1+A/I3U8+NW+zvEdfKlZfnNJcprE2Zw=
X-Received: by 2002:a05:600c:4687:b0:49c:ff8a:44cd with SMTP id
 5b1f17b1804b1-49cff8a4cfbmr5797515e9.12.1788526422266; 
 Fri, 04 Sep 2026 05:53:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfbdacc45sm42042135e9.11.2026.09.04.05.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB9A961D99;
 Fri, 04 Sep 2026 13:46:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PULL 088/105] tests/tcg/sh4: user tests
Date: Fri,  4 Sep 2026 13:45:42 +0100
Message-ID: <20260904124604.2207440-89-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-89-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 6bc2829ba92..1c34b8e63c6 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -153,6 +153,7 @@ subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
+subdir('sh4')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
deleted file mode 100644
index b7a8737be0f..00000000000
--- a/tests/tcg/sh4/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SuperH specific tweaks
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/sh4
-
-test-macl: CFLAGS += -O -g
-TESTS += test-macl
-
-test-macw: CFLAGS += -O -g
-TESTS += test-macw
-
-test-addv: CFLAGS += -O -g
-TESTS += test-addv
-
-test-subv: CFLAGS += -O -g
-TESTS += test-subv
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
new file mode 100644
index 00000000000..d73df074497
--- /dev/null
+++ b/tests/tcg/sh4/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test-addv.c': {},
+  'test-macl.c': {},
+  'test-macw.c': {},
+  'test-subv.c': {},
+}
+
+if 'qemu-sh4' in emulators
+  tcg_tests += {
+    'sh4-linux-user': {
+      'cc': 'sh4-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'sh4',
+      'gdb_arch': 'sh4',
+      'qemu': emulators['qemu-sh4'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


