Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2124D7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAeb-0001k2-Sh; Thu, 21 Nov 2024 12:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdl-0000Ty-JR
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:50 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdT-0001cb-0d
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:49 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso9764035e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208789; x=1732813589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAGsBPtTmpGlZjFjwkSGWhc1on1nGzftLOgY8SHHshk=;
 b=diIj3p6bBvvxD4wu5dFjlXyphXZ7EY4EAx5vg8FwOifWkmfwPh7vVIfIvNy7CdmbdG
 BJOApOhrWdMvOsVMX7VKHrGToMCkfDG10LIhCzHC51ofUxnh61zK81SgAvJ7DbVg7qlD
 kusIzlScLOVnYpN9bpH+wAwnT9OsHLKigaGzns2m1wnIqE6QQEI3xx1uco5Fc6RCsf0K
 3d8HvnNiBYztI3Qv+Y4DeMYArlGDHidcdwrjTjw9MCkVRMxNhDpB7AuD4MvW3mgSs2Kc
 NRM/b/0FNftMBIPVI/XCvYfoKVjz4sQr/tjv9oRLevgT6XdP4j6OkJ5xJ8Ux8vohNkbN
 8Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208789; x=1732813589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAGsBPtTmpGlZjFjwkSGWhc1on1nGzftLOgY8SHHshk=;
 b=YIzo/mACzNO1i4DhsnS+XSgjjfvrC+3qB1sWJUgPru6zFoM+TfMa14bI20qCOzd77X
 AxrkslIyJpE3f5bLoQVmd9PElxw4L3SzV96g6N3k8DD7AnfzwokY1YvH/AQ0Gblwiy69
 VZ1VluBcOiE1K666bXUoiEHsM/MaOoEj5ZMAPRjB7U+1lhi0DI/Y/z/LBXrwKVn8QF1O
 nxUFdeB2V+w7p8qYpuXdSNCkOehq+9Lilbi4NZkbOMpPNt5Il9INTD7xQFM3M9VHxPi0
 iP5v0SmEyGQwerpYCw3IZweIPmqs4IBGECYWEZogbExm6J8rGFxVNQM0clOJL0KSwdUT
 c80w==
X-Gm-Message-State: AOJu0YxfHm4+G6HmanW1UtH5CAU+cXYHs1vQXESDga2O8xfotHevdV5E
 dsDILTPexjtVNy7qGMuqATbBKlhU+yM8H4JirPNlsgb//CmZTKu6TCWJE2gt4mA=
X-Gm-Gg: ASbGnctG8TiOdtSR/2865fSaqtBErdGr5mDYed3WN3jAR9vjDXnbsIkrAPowxbMu1CY
 c76tyV8Yay24UqMB48oLIykxJBSZAwTvOreSVE+eXS/RPLItvw9CPqmTDOkUAftMZv250ZWH07k
 10cOB6jQWpdfRMY5Ks/rmQOQPaMOEc+umsWiLLDMFLncvE6F5mXijKigquBkxsw0Ukvd8Pxg+AV
 eu2rXslMiMnOuqyP8QI9ClCiQ547uU9RaIX1iimlNpKosa/
X-Google-Smtp-Source: AGHT+IEVnLw2xUtf0J9uvurODmXKtzkjOY30qGhQ5prc0K46NKf1TqRr8l+lGSKt4CWPqimkHrCH9Q==
X-Received: by 2002:a05:600c:314b:b0:431:51c0:c90f with SMTP id
 5b1f17b1804b1-4334f0202damr60948965e9.21.1732208787559; 
 Thu, 21 Nov 2024 09:06:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4616636sm61146695e9.19.2024.11.21.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F412A603F4;
 Thu, 21 Nov 2024 16:58:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 17/39] tests/functional: add a QMP backdoor for debugging
 stalled tests
Date: Thu, 21 Nov 2024 16:57:44 +0000
Message-Id: <20241121165806.476008-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Support the QEMU_TEST_QMP_BACKDOOR=backdoor.sock env variable as a
way to get a QMP backdoor for debugging a stalled QEMU test. Most
typically this would be used if running the tests directly:

 $ QEMU_TEST_QMP_BACKDOOR=backdoor.sock \
   QEMU_TEST_QEMU_BINARY=./build/qemu-system-arm \
   PYTHONPATH=./python \
   ./tests/functional/test_arm_tuxrun.py

And then, when the test stalls, in a second shell run:

 $ ./scripts/qmp/qmp-shell backdoor.sock

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-18-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing/functional.rst      | 10 ++++++++++
 tests/functional/qemu_test/testcase.py |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 6b5d0c5b98..b8ad7b0bf7 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -176,6 +176,16 @@ primarily depend on the value of the ``qemu_bin`` class attribute.
 If it is not explicitly set by the test code, its default value will
 be the result the QEMU_TEST_QEMU_BINARY environment variable.
 
+Debugging hung QEMU
+^^^^^^^^^^^^^^^^^^^
+
+When test cases go wrong it may be helpful to debug a stalled QEMU
+process. While the QEMUMachine class owns the primary QMP monitor
+socket, it is possible to request a second QMP monitor be created
+by setting the ``QEMU_TEST_QMP_BACKDOOR`` env variable to refer
+to a UNIX socket name. The ``qmp-shell`` command can then be
+attached to the stalled QEMU to examine its live state.
+
 Attribute reference
 -------------------
 
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index e2a329c3e5..fceafb32b0 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -175,6 +175,13 @@ def _new_vm(self, name, *args):
                          log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
+
+        sockpath = os.environ.get("QEMU_TEST_QMP_BACKDOOR", None)
+        if sockpath is not None:
+            vm.add_args("-chardev",
+                        f"socket,id=backdoor,path={sockpath},server=on,wait=off",
+                        "-mon", "chardev=backdoor,mode=control")
+
         if args:
             vm.add_args(*args)
         return vm
-- 
2.39.5


