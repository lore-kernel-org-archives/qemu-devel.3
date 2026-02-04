Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBF1EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhbw-0003o7-8Z; Wed, 04 Feb 2026 13:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbu-0003hY-JQ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:18 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbs-00018l-HI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so157366f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229695; x=1770834495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQAJVYtXe6Sn/UI/A5OH3OSD/hxJES4kcCI9tUH5Imc=;
 b=OQUU4GYt04KiHLwURBxabmqZ9v0sFSpzKk5MjKLix6gCjEV8yOTs8qCKcvA6qIztq+
 AEHj8RJ9RFYQvnahDIaRt55ramJsZwxxIz/WkhVrwyyx8oefW96yF6MVWIMOfwIHfPSx
 AsXv1/4wsIbNfA+eQ4CtQdG2APJyNpLUTLQJp2cCvezog40Zc/Hcn4sCzRG0AW/COlWr
 +ENba9Se6aDE0bfYwAEt6BdoY+vTbVCRGvgY3zOsPvcAJs9+iWY+jfnU+Z3mxD1O+tTk
 MhvAz/Xk9cjk1o568e28ASvQMPN9ybtfeuSEvnjzIt6mNsvuUT0ktRbhw0ybesrWSQ5R
 vlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229695; x=1770834495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gQAJVYtXe6Sn/UI/A5OH3OSD/hxJES4kcCI9tUH5Imc=;
 b=dXQD2gfMgThF0ZuHzqPxgMkuDp7daj0Sm+qLdV1FDzHxY7hqiVZ6vBpEEOGjCBndEb
 pDkeKscvI2rGDDcjVr1OXDs8t7cGcJTibR+u/FGB9Kr8wODR6ijLB4wocBP4vTrgNCzn
 ZI15xAo8Nco8KgWYFNWq8rLxqNVSFwsdcLCuxCjx6GlclxbVNZyZVQj9xVTP8gMqB2XH
 g1qm4bvK95aLo2V3HVUVt94z+zFp8n4lasosIbbIEG3Ad/Fyk88s/Bw1CK38On57ajUh
 +Bpg8sDJRiJgnPO1w5gbNsfHmHQhe8KknYasCIg6SATiYLyH6Ir2q0huOYTzIDE8g3PO
 sjmg==
X-Gm-Message-State: AOJu0YyZDdoqfkHVsNT/0VJecKva04H4GJdv6+KR2542WIRJHRAgRCU+
 u9BPgQyjQ7Q950ht6B1nvlipovG6qEVGRk/iQvTH2EmNlxqudMWoIIWjEa7TJjLRWp9Wne3Bck0
 jd8wr9Eg=
X-Gm-Gg: AZuq6aJedHwBevICwmtBvNVQ3qV+pJnhpDDSI7ccYsda7iNB6sqoTNvyH6ckJSlT5Cq
 kOBjMaObTUfgW74npUJUQeChYQc2LLlVxdwxu2NGvSzDEqcJAwX3qtpDxgW8ZDYUEcS9UvDl1RI
 +bDCjUqmhdaHB7tqXRIJQGHcYajyxZEYi4qFh559kKogfPx1wDXInamJ/81Cpmikejn5H8KJ93G
 YIUI9IYmWK5HPkrQesFbj/HW2l551VXOEe9kjCvZMVSQV6VeTRdXSFUifzEbe/46ry/o/zFYKHN
 DP3ytH2BDuj9h5haTXUX4xWeargFdwpKCBslAwVlKUOggucl5tnPs8R6PuCcPXlVMmq+JWSyP3X
 BMGJ/0gJy/BgiwLzjFRDHy5Y7tVfoWRT2EtPewhwUlMA2OEMXBxIajkiDQuR5xihRiChscL6iTp
 G4L1NuHSuQrMVCi2G5dZGT/NbBkCP22/lVkF1AHQWoGhNUKnudOgTkwDxVAAtU
X-Received: by 2002:a05:6000:2c04:b0:432:dfea:1fa8 with SMTP id
 ffacd0b85a97d-436180581cfmr5643755f8f.45.1770229694481; 
 Wed, 04 Feb 2026 10:28:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805edcfsm7818170f8f.35.2026.02.04.10.28.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:28:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/9] target/s390x: Build system units in common source set
Date: Wed,  4 Feb 2026 19:27:20 +0100
Message-ID: <20260204182722.44062-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204182722.44062-1-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Except the ioinst.c file which uses the TARGET_PAGE_SIZE
definition in the ioinst_handle_chsc() method, all other
files in meson's s390x_system_ss[] source set don't use
any target-specific code. Moving them in the other
s390x_common_system_ss[] set to build as common objects
ensures these files won't use any target-specific API
such target_ulong / TARGET_PAGE_SIZE, thus forcing to use
the appropriate types instead (such vaddr, hwaddr, uint64_t,
...).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/meson.build     | 7 ++++++-
 target/s390x/tcg/meson.build | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 3b34ae034cb..0fb45103afe 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -20,10 +20,14 @@ s390x_ss.add(gen_features_h)
 
 s390x_system_ss = ss.source_set()
 s390x_system_ss.add(files(
+  'ioinst.c',
+))
+
+s390x_common_system_ss = ss.source_set()
+s390x_common_system_ss.add(files(
   'helper.c',
   'arch_dump.c',
   'diag.c',
-  'ioinst.c',
   'machine.c',
   'mmu_helper.c',
   'sigp.c',
@@ -41,4 +45,5 @@ subdir('kvm')
 
 target_arch += {'s390x': s390x_ss}
 target_system_arch += {'s390x': s390x_system_ss}
+target_common_system_arch += {'s390x': s390x_common_system_ss}
 target_user_arch += {'s390x': s390x_user_ss}
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 515cb8b473d..17c9374d09e 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -12,6 +12,6 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
-s390x_system_ss.add(when: 'CONFIG_TCG', if_true: files(
+s390x_common_system_ss.add(when: 'CONFIG_TCG', if_true: files(
   'debug.c',
 ))
-- 
2.52.0


