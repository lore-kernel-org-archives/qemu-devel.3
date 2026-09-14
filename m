Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1158C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZi-0003v2-AB; Mon, 14 Sep 2026 17:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZg-0003uk-L3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:52 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZf-0001AU-5P
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:52 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4b1ba286f6bso186852b6e.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422650; x=1790027450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yZvuPipwiX8omDNkIQVpE34c4ISewqbxjiFYSNS3wGo=;
 b=bFG4lx6zyy9VLMg8DV4sw2JtogEDVLgNBu3yMq4DNZQ90GxIV6Sp20wJp9Fb/q91Fu
 zJP5lNpbV1ZuX2g1WZ3gt5Gl/Oj7EYUoo4dtb6+zLXu4bxcFZYntMao6UEzzHq+gfMsh
 5rSoh20nAWVDWFfcbUzSTJj/QvhAygoaenbSFnPwkrxqCWoj5VbusseyHPDcXDdOv3z0
 m/4SD9s8hs0+1HybTzSuRMCaO6uqHBq8JhXWFxeTY9cL7TZSg+HvFrc7qF+jF83SXmPt
 jwaOubHb23eFz6U+vNcXQbW6Fw5+b5FQTBX7lBG7AuBMHWUE89iy0i62FYXi/cxWJb6g
 Ke3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422650; x=1790027450;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yZvuPipwiX8omDNkIQVpE34c4ISewqbxjiFYSNS3wGo=;
 b=aIqqfw0bP0QYYzBSCwenBX0e/VYLMALIT1e8uM4eZ6YubRb7WlhtTrQpRn4BeWO9m3
 uo3wJPWj/vHFzflwB7YyB8S/xSNhHYzEsUR2yCFvsgHLeBrfq+ES5wUE0QrqC1VM6y8B
 tGHYXd/fjcojBao0qotGbFypZ22E/CQ0EkLy6HFzqIUabt0Mv4cOPGaFjggbHCsmOQr+
 FzoL+kB/MSMEoNszbciA6J7uK/iaQah7nQ9oLiMc6UIeHp/so33OLGS4nRJC0CpEnOtd
 lBze7b8jBwJD8rZgYncZsb7X4iEjYVmKiXDD3iNvT/RpXyVBh+CPjgI/70kvHY/Ufovy
 3CTA==
X-Gm-Message-State: AFuF++mKm1ZoXX2sSK1CJHEE6ckGSvTY6GrrscxSd5TaTEs4pPLzBr5Q
 oybN5ZumGil6Iy2xWjASi/SZEF9LlhNDWLR8+oOVdtLNnWlkuYDZyYGa9fEhp8U6
X-Gm-Gg: AYBFou1ytRHdLTLb2q3FF0/C0zxCRyPLz9I8bq0G35JTxFW18YcX//oTd+ijT4NpL+i
 ThR+5msAqZK9qKSJYJTkM4+kYF5D5tTE0ortsrC6929EugfGyrpclMsXLLGqfg6oLyrV7nODMTy
 3ce+d32yZUNqRemKDP6IpcmDHyHEeLael+K12AaNEHxNz0lUjCawdBawRQV7MvQg0NfywVfmJ8t
 o5bPLrDi0aedrBNgUj0blSTr0piWd5yS+il9swmL6L8ZacV/sGivnHCLFztCFSNUUTySp+dVOzZ
 ieofI3wKhoecEIRzuQQz4dN28nUzj1vnEiparAxZJO+SS5gPZC9qvFZzuhQYZUxmQ8voELI4itc
 0msWcmFCZDr+D1D9ChFjWTRiY57taltcTFVjcwrrkokUbSSvCw/bXjuVKhF3ZZywHvBnTbyAvFQ
 fmKJwTTJjcSVyrNFYENhF/xzcbHakFz7RkGuPAu0URJ2P9Wbp2MNVCo61aIiWcEJJmBpgWUN+ak
 Qk1Gg5q8ZW+s0VQA3mWvdSjrNBFdFv+KQth/oeZbuuJhaO20nknNOskduGfxIHX
X-Received: by 2002:a05:6808:c28a:b0:4b2:8dbf:ffd with SMTP id
 5614622812f47-4c89ef82b3emr686939b6e.1.1789422649941; 
 Mon, 14 Sep 2026 14:50:49 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:49 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 07/10] Hexagon (tests/tcg/hexagon) Add tests for qreg
 multiple writes
Date: Mon, 14 Sep 2026 15:50:33 -0600
Message-ID: <20260914215037.157879-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/multiple-writes.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
index 62e5828a0a..bd2b1384dd 100644
--- a/tests/tcg/hexagon/multiple-writes.c
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -261,6 +261,27 @@ static int test_vreg_illegal_uncond(void)
     return sig;
 }
 
+static int test_qreg_illegal(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "{\n"
+        ".word 0x19a14048    /* { q0 = vand(v0, r1) */\n"
+        ".word 0x19a0c044    /*   q0 = vsetq(r0) } */\n"
+        "}\n"
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
@@ -290,6 +311,8 @@ int main()
     assert(test_vreg_illegal_mixed() == SIGILL);
     assert(test_vreg_illegal_uncond() == SIGILL);
 
+    assert(test_qreg_illegal() == SIGILL);
+
     puts("PASS");
     return EXIT_SUCCESS;
 }
-- 
2.43.0


