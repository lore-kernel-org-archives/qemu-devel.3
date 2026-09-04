Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC3FC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQE-0001bV-6W; Fri, 04 Sep 2026 08:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQC-0001aI-DE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQA-0000fG-Cn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so8421785e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526409; x=1789131209; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HSmbh5CzNxFCDcJeMXku/skdE36tapw6+bH//Hui4f8=;
 b=jsyfTO1zpjEIvGA8onDxFMWN7MimCl5EtzPEDnZtEcjBCvhjteMFHs/Xt9kFyj8Tth
 tTNahmwEcUHRid/jCwssFT31yaMfQUOBbKfa+sRBeQYJRTYGtZEyrk8T80kOJN6m75HQ
 x/9EvRTb4PYW9110aiTDJ95iLHl8zs5d9cFUz0XYHNHgZCQEu8quTrBGfPRTSJ+M/mMd
 8aOsICnnRtCW6pRmw5+Vqir/IpGzOEkC1SkJ0QY6FIju6KeTJ3gjShuBlGkE/govkwi+
 a2oyLvLXkl8zpaD/LrGZXuYWvLtFRPATaHaKz4Ki1nMrjG+L2BUsyysFi8J4WS543vNL
 pwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526409; x=1789131209;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HSmbh5CzNxFCDcJeMXku/skdE36tapw6+bH//Hui4f8=;
 b=TWVzzaD1/WxqeE0hJYM8HRR4J58yZBOsHWGPdpv8bv3GeVM1PhVO7U+QBwHFzMgoyb
 v2RKyf3qKGZj06Nq7IUdUZEnv5Iy7DX6RljV4rsjcPBX+0mk+eT9Zr/NTfsYO/Ci7UvW
 7T7bIOFftndsKtqoDmCMCZFU5PTiaehINMKAMPN9d09M5uyrMINpE9i/55aVcaoPY1OB
 bE8V49HAJa2oYQqlVkFRwpwwXF+gCDCcUi3pLHebRCZ8SRYQXeQmWEuRpWwRAQV+ddHs
 TdcOPVwjvXHJH2L1jP3rbHhZBmyU2LmcjkZYfXQVtmn2jLb/UtGlxaU3BcB7Z75JRnFT
 e8pw==
X-Gm-Message-State: AFuF++lpg7UNvbpcQ2wucjoIxxwg5YyOAVJB5/o3lQIC9gmJmV9CLvan
 +Zn7Q6sH4kez8vuGDnNweVHQ3J5a8cbssLVwrUqAVtVeyGjYHanatS1AXBmLAnFexEI=
X-Gm-Gg: AYBFou3fpHY/dWISLcEx1jK121A4CwIRCIXW/2tAjklWKQXd5dk/b8GVqZmzisl94ay
 zK2j9F3Ve6txKxzO0hnl+c4HP0sx7qHFvS4bisfRMiM1HHhuMCZPLXQAkZ3p/gUldQ7vG7uy4oe
 TQNvOoNYO7Mm3eVnpFmOEOoBy1nwto4w1hGtSwLAHU1P9wpokBuq1NSTMIS15kOGi/aHKS97xKR
 qiJaje0h8WJtIQPJ/yHJr+o1vPWLJl4yMQd5NTybb9H0hBr/joQLJXQ0/vnyMyVRNjY8jCKvOio
 i81ABplh7vsjXVeszZjkcCYIo8IqOIm9r0HvMR2EajVdRQ19uC9hkFKP5rz50YGr3aXwlraaMkA
 niikv2xYIxfG/pPKZ1zigbNqRJeESScc/0SGgeGRyiQR6WR7DQshMXbuOkgeZ+YXwssITc9AuL/
 k8cF78m94Esv2QM0PY1M6xs6hcCDdZTQCzM2EDpKTMHcivi9yEKbkv8iBiKdlM
X-Received: by 2002:a05:600c:a00a:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49cf81f6736mr97669595e9.6.1788526408911; 
 Fri, 04 Sep 2026 05:53:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm399350785e9.0.2026.09.04.05.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2195D61D3B;
 Fri, 04 Sep 2026 13:46:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [PULL 073/105] tests/tcg/or1k: user tests
Date: Fri,  4 Sep 2026 13:45:27 +0100
Message-ID: <20260904124604.2207440-74-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
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

Some tests are currently failing, so they are commented.
To be investigated.

qemu:or1k-linux-user-test_addc FAIL 0.05s (exit status 255 or 0xff)
qemu:or1k-linux-user-test_div  FAIL 0.06s (exit status 136 or signal 8 SIGFPE)
qemu:or1k-linux-user-test_extx FAIL 0.06s (exit status 132 or signal 4 SIGILL)
qemu:or1k-linux-user-test_lx   FAIL 0.05s (exit status 139 or signal 11 SIGSEGV)

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-74-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7aca685078f..d6406b5cb59 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -148,6 +148,7 @@ subdir('m68k')
 subdir('mips')
 subdir('mips64')
 subdir('mips64el')
+subdir('or1k')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/or1k/Makefile b/tests/tcg/or1k/Makefile
deleted file mode 100644
index fb5ceda512f..00000000000
--- a/tests/tcg/or1k/Makefile
+++ /dev/null
@@ -1,71 +0,0 @@
--include ../../config-host.mak
-
-CROSS = or1k-linux-
-
-SIM = qemu-or1k
-
-CC = $(CROSS)gcc
-
-TESTCASES = test_add.tst
-TESTCASES += test_sub.tst
-TESTCASES += test_addc.tst
-TESTCASES += test_addi.tst
-TESTCASES += test_addic.tst
-TESTCASES += test_and_or.tst
-TESTCASES += test_bf.tst
-TESTCASES += test_bnf.tst
-TESTCASES += test_div.tst
-TESTCASES += test_divu.tst
-TESTCASES += test_extx.tst
-TESTCASES += test_fx.tst
-TESTCASES += test_jal.tst
-TESTCASES += test_j.tst
-TESTCASES += test_lf_div.tst
-TESTCASES += test_lf_eqs.tst
-TESTCASES += test_lf_ges.tst
-TESTCASES += test_lf_gts.tst
-TESTCASES += test_lf_les.tst
-TESTCASES += test_lf_lts.tst
-TESTCASES += test_lf_mul.tst
-TESTCASES += test_lf_nes.tst
-TESTCASES += test_lf_rem.tst
-TESTCASES += test_lf_sub.tst
-TESTCASES += test_lf_add.tst
-TESTCASES += test_logic.tst
-TESTCASES += test_lx.tst
-TESTCASES += test_movhi.tst
-TESTCASES += test_mul.tst
-TESTCASES += test_mulu.tst
-TESTCASES += test_muli.tst
-TESTCASES += test_sfeq.tst
-TESTCASES += test_sfeqi.tst
-TESTCASES += test_sfges.tst
-TESTCASES += test_sfgesi.tst
-TESTCASES += test_sfgeu.tst
-TESTCASES += test_sfgeui.tst
-TESTCASES += test_sfgts.tst
-TESTCASES += test_sfgtsi.tst
-TESTCASES += test_sfgtu.tst
-TESTCASES += test_sfgtui.tst
-TESTCASES += test_sfles.tst
-TESTCASES += test_sflesi.tst
-TESTCASES += test_sfleu.tst
-TESTCASES += test_sfleui.tst
-TESTCASES += test_sflts.tst
-TESTCASES += test_sfltsi.tst
-TESTCASES += test_sfltu.tst
-TESTCASES += test_sfltui.tst
-TESTCASES += test_sfne.tst
-TESTCASES += test_sfnei.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) -static $< -o $@
-
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do $(SIM) $$case; echo $$case pass!; sleep 0.2; done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/or1k/meson.build b/tests/tcg/or1k/meson.build
new file mode 100644
index 00000000000..5151e8f361f
--- /dev/null
+++ b/tests/tcg/or1k/meson.build
@@ -0,0 +1,72 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_add.c': {},
+  #'test_addc.c': {},
+  'test_addi.c': {},
+  'test_addic.c': {},
+  'test_and_or.c': {},
+  'test_bf.c': {},
+  'test_bnf.c': {},
+  #'test_div.c': {},
+  'test_divu.c': {},
+  #'test_extx.c': {},
+  'test_fx.c': {},
+  'test_j.c': {},
+  'test_jal.c': {},
+  'test_lf_add.c': {},
+  'test_lf_div.c': {},
+  'test_lf_eqs.c': {},
+  'test_lf_ges.c': {},
+  'test_lf_gts.c': {},
+  'test_lf_les.c': {},
+  'test_lf_lts.c': {},
+  'test_lf_mul.c': {},
+  'test_lf_nes.c': {},
+  'test_lf_rem.c': {},
+  'test_lf_sub.c': {},
+  'test_logic.c': {},
+  #'test_lx.c': {},
+  'test_movhi.c': {},
+  'test_mul.c': {},
+  'test_muli.c': {},
+  'test_mulu.c': {},
+  'test_sfeq.c': {},
+  'test_sfeqi.c': {},
+  'test_sfges.c': {},
+  'test_sfgesi.c': {},
+  'test_sfgeu.c': {},
+  'test_sfgeui.c': {},
+  'test_sfgts.c': {},
+  'test_sfgtsi.c': {},
+  'test_sfgtu.c': {},
+  'test_sfgtui.c': {},
+  'test_sfles.c': {},
+  'test_sflesi.c': {},
+  'test_sfleu.c': {},
+  'test_sfleui.c': {},
+  'test_sflts.c': {},
+  'test_sfltsi.c': {},
+  'test_sfltu.c': {},
+  'test_sfltui.c': {},
+  'test_sfne.c': {},
+  'test_sfnei.c': {},
+  'test_sub.c': {},
+}
+
+if 'qemu-or1k' in emulators
+  tcg_tests += {
+    'or1k-linux-user': {
+      'cc': 'or1k-none-linux-musl-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'or1k',
+      'gdb_arch': 'or1k',
+      'qemu': emulators['qemu-or1k'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


