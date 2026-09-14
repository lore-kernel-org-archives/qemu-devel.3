Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80015C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZf-0003uP-Vp; Mon, 14 Sep 2026 17:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZe-0003tf-5P
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:50 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZc-0001A3-J4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:49 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a3ed714so1562197b6e.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422647; x=1790027447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kGTBgZZyoBgscZLa4XGxTdhsorRtXVliE/QWC4MCN2g=;
 b=m71tIxhQjC/AWaao2v61Ll7lph6sEq7M5Olo56P6rdIxcoBVdNLQ/599ZpQwQYaxIw
 81zIMu4yEcRKoXvwiVQalcCIz9pc5jSnrGsVjv4rAvvfLYwH9j+Nu5WoO0gsqcbu3sGu
 voO4Bf/Jbr1hvpUKeJp/v5SvgrvIRHCSmoSaH1LEk+VPTHHNcPt2zPBL91e237ty04cD
 LRIS4kv+wwmjhlzixQSlcrrDsJNDgjjYNrk16yiNzz7nocNVND1ZbTOMAvxZFCbNFwIq
 9X1OUbK2hHRprfZWaZV9U4M3za9q7xmHksvep80W7c2jncnzUxlSwaRB6MleAJ87e0Vr
 Ilgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422647; x=1790027447;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kGTBgZZyoBgscZLa4XGxTdhsorRtXVliE/QWC4MCN2g=;
 b=epACe7kC9jgbtjf9GAbRClIc6Ml4m1T4NjzFgINHql0I60SRzgvpzIdgsklPVsxXjC
 Y8OmMcWqvyxqIjRJ0tiG0Xe7jxsvBwF0w8QohH1LmpNl1VPpCJ4PclFMOvY2qsaTXvea
 i+5iFWV/N7/JJumLitUQPgmCCdq3POTRq6/PTv4BAFkdC1z28YmZKroDUXWCYxhw7jLy
 kaiQFUM8tSn94xnWTk2FfOf0nTaCM9Ft4KKFqTdGypZ/Ipfg76GpWvrN43HHKr5AIWc1
 XV6g7Xsm+9yDImYPbjgkGM7indc5o7XiWrHf71gZmnNYO2BDnfiwy73oVMIUzhwiZXS5
 mKuQ==
X-Gm-Message-State: AFuF++mtGWfmhx7uxqmh7C7IiLXlfiP+4B8dM04jRHUrRMXl28yNbefP
 OZ6SwWthkAFjTaSSqU+lTn1c0+25WndJi1VXgprm82d0i7nWaZQm4jWsnMJmgbhO
X-Gm-Gg: AYBFou1mpuokzV5QD+YBrLFzlFLtarRe8VtuTzarr3Xp4rIeWB/hRZy92aryJhtqTMI
 54KuzlpMbKftwhTa8/1tGmiofDeh/F+pA9hPnNy8POJ57iDcSJPabZT96EuC2Gpym3SCFenKXJd
 zUGoz7tEPRzciUNhmYb9ldGYCWH80tcUhJpxvYVdnb7G9o6ZcIxhaoRXdaSbS4T1GC7RRupLjdG
 Y+9Kh6TPrbHu/gzNWWiwlLAnP4UDB8yQ0Fx4TdvvTTVRiSIXZdhRDQUrdSHTZOYe6EDvCfVbPaN
 PfOnsh8gRY3djiO4qYmjBI+G6ZiQ1Gc+sGS+FEB9mIjk2nARpNpt7lWqZWf9f0l+b1uSsmhRMoB
 AXaxtecYbps/fB/Lbn82t+dDknMaE8F5/hk66Ei8YZWra032pua8vYdxgXa3yYKLJV5UWpgWW4H
 MaUDTGi64QcecFAc3vBdkpKkOuydpYQjhaPZvQRRNTL4mz+no059zA8E8tVgWMzmJgOJMCLxXgd
 inUr/csynos9lc5rO/S6YshoXYQFKBjdV3tsLyPXZ2e9grvrrx7obtYoGEL5sV+
X-Received: by 2002:a05:6808:15a2:b0:4a3:fefb:899b with SMTP id
 5614622812f47-4c7b2dfaebamr2899062b6e.7.1789422647508; 
 Mon, 14 Sep 2026 14:50:47 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:47 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 05/10] Hexagon (tests/tcg/hexagon) Add tests for vreg
 multiple writes
Date: Mon, 14 Sep 2026 15:50:31 -0600
Message-ID: <20260914215037.157879-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/multiple-writes.c | 66 +++++++++++++++++++++++++++++
 tests/tcg/hexagon/meson.build       |  2 +-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
index 4305903547..62e5828a0a 100644
--- a/tests/tcg/hexagon/multiple-writes.c
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -199,6 +199,68 @@ static int test_post_increment3(void)
     return sig;
 }
 
+static int test_vreg_legal_predicated(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "r2 = #7\n"
+        "r3 = #13\n"
+        "p0 = cmp.eq(r2, r3)\n"
+        "{\n"
+        "    if (p0) v0 = v1\n"
+        "    if (!p0) v0 = v2\n"
+        "}\n"
+        "1:\n"
+        "%0 = #23\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r2", "r3", "p0", "v0", "v1", "memory");
+
+    return sig;
+}
+
+static int test_vreg_illegal_mixed(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x1a004100    /* { if (p0) v0 = v1 */\n"
+        ".word 0x1e03e2e0    /*   v0 = v2  } */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
+static int test_vreg_illegal_uncond(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x1e0361e0    /* { v0 = v1 */\n"
+        ".word 0x1e03e2e0    /*   v0 = v2  } */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
 int main()
 {
     struct sigaction act;
@@ -224,6 +286,10 @@ int main()
     assert(test_post_increment2() == SIGILL);
     assert(test_post_increment3() == SIGILL);
 
+    assert(test_vreg_legal_predicated() == 23);
+    assert(test_vreg_illegal_mixed() == SIGILL);
+    assert(test_vreg_illegal_uncond() == SIGILL);
+
     puts("PASS");
     return EXIT_SUCCESS;
 }
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index 4a2826c427..08c6e34c20 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -54,7 +54,7 @@ tests += {
   'load_unpack.c': {'cflags': cflags},
   # Build this test with -mv71 to exercise the CABAC instruction
   'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
-  'multiple-writes.c': {'cflags': cflags},
+  'multiple-writes.c': {'cflags': [cflags, '-mhvx']},
   'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
   'preg_alias.c': {'cflags': cflags},
   'dual_stores.c': {'cflags': cflags},
-- 
2.43.0


