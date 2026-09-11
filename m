Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2330C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QD-000370-7U; Fri, 11 Sep 2026 18:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QB-00036L-Cr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:35 -0400
Received: from mail-oo2-x10.google.com ([2607:f8b0:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59Q9-0002Gc-R9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:35 -0400
Received: by mail-oo2-x10.google.com with SMTP id
 006d021491bc7-6b1ae6f5fc5so231642eaf.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164512; x=1789769312; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4DXHA2h7Br8C+LSz5HTQrqgfqpli3Jfh+QwtGKDTA7k=;
 b=IY0v2RYpJQ0+Q55CRzQ34DyK4cZMhpYSpUAaUHq+KPHgK5r0fC6i04KFE3Y9mu58zG
 oRNbTB1lysYEKZUsHyl7H/eCTFJhiZr8LFgj8wE7xUF4dOtcLhgYl5Ebws82RE1KA2TX
 ib4ezoCbTTMuv2ZFibbfHjHNCt2UcbKzoONifT2dNXZubePk7cBVYK3JgvGph2+4JhPt
 SalO0YaBLNk+YmRVKi9i+5SDoudf8e30VIVTrrj4Gs27qhrKWJ7P9KHU2KVvz5PdeBi/
 Qxj93d4ygtVAMAlk3eY2AydnNIb3YKPrRwo9pdGuRh6T9+GWozl9u1+KBn7S1hnqqHOM
 hfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164512; x=1789769312;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4DXHA2h7Br8C+LSz5HTQrqgfqpli3Jfh+QwtGKDTA7k=;
 b=YGXzHIcbAZR7oXb3qu5pNHmDG7CKiHsFE6qfnM1AFpcaDEBy+GsmBrlWZvGtXnS1jP
 EeFndQiaxRh5gQn+XyaPgXUMoG+We6yl/Djj1FuDxd0Yjsj6GwJ6LwgBRGRlgqrkYI3a
 HMfSS/2SVQ4mMqoIOEcrrq2ctjaz+c8t7zPK/wn5N6ig2Mn3slKG+ULQN4v9VaIfb6UT
 jcSxR222RMLEF4tBiBPoIMXQTBY2mWKi+tQFDCaqbByfGgJuwC+JeDCOhu4zV6EfXEwe
 tM8BAR2JdSylMsilhPDONPcocS6HXB3UXiGDDzprSdT2oE/bvftKCw7vjmRk78onhSLL
 eirA==
X-Gm-Message-State: AFuF++maYTSmthcUZCqE40kpPqzThgG3ScO0jLGEdAhATQLglzFV9/Lc
 QEBogdAHhZYiP+uT2EZ5LDhC4p34vFlNuRJqrZ1/9mZTYgb8VZJJkbD3MjD0vZR/
X-Gm-Gg: AYBFou3P1l47z7BUyicFcexYU0LEavA3yCBDLBix+X4KkOVNJV7huHQmSh/kwEqb9Jj
 qzPoUiCAFCcUAYceEx/tO+IV0wy3rzKl06fv2j2DxljZKQb0BnHenU/KyY3MIhh9QiwTKblpq2m
 RxzzYLiujiNsmgm6I2xI7k1WaYggiHguIW3zRChpC26VAL1CDBDJVOc38yIcXU8PLkk2TaC3F0l
 oCtb88k99KiY47/Yx4GCDWw/6a/AnCk11EZ5DiBDCrvhTqyW7U05gThmle8bkIfD3+qRQNsZVga
 dTbmFWzllTppB5anAooAoVLXVcaIuL3lpYG6RH0TW2n7lXg+hxrSSXsl5pV5rac6zyKNiTxxN5K
 kej2Vr7bsp7AkbFZ4o9N3nQJrAXyd1a4F+vmf6mezq+9HMSsUh6csMFOpIIs0qAfQcUAKFrYtGp
 siIE8h8khK+mAbSemqebb8RYKdkUsODobzAgJ9Zch9w0kjOUX8sMsr2fQyNU7IniAn6wnhpbjUE
 xoW2DlfN7H2FHdJc51WVp4tGPz5zoXVJ21StALOF83yuZupm5aR2hWQaFxJ9NityCCbjZP/2V8=
X-Received: by 2002:a05:6820:339a:20b0:6b1:8f51:e174 with SMTP id
 006d021491bc7-6c0bdb6bb5bmr6719410eaf.29.1789164512580; 
 Fri, 11 Sep 2026 15:08:32 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:31 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 03/10] Hexagon (tests/tcg/hexagon) Add tests for
 multi-destination instructions
Date: Fri, 11 Sep 2026 16:08:18 -0600
Message-ID: <20260911220825.143115-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::10;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo2-x10.google.com
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

Instructions such as post-increment loads define multiple destinations
These make it harder to detect multi-write conflicts

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/multiple-writes.c | 60 +++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
index 8686317fdc..4305903547 100644
--- a/tests/tcg/hexagon/multiple-writes.c
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -143,6 +143,62 @@ static int test_zero(void)
     return sig;
 }
 
+/* Test multiple post-increment writes to the same GPR */
+static int test_post_increment1(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x9b004021    /* {    r1 = memb(r0++#1)      */\n"
+        ".word 0x9b00c022    /*      r2 = memb(r0++#1) }    */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
+static int test_post_increment2(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x9b00c020    /* r0 = memb(r0++#1) */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
+static int test_post_increment3(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x9bc1c020    /* r1:0 = memd(r1++#8) */\n"
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
@@ -164,6 +220,10 @@ int main()
     /* Illegal: zero encoding = duplex with duplicate dest R0 */
     assert(test_zero() == SIGILL);
 
+    assert(test_post_increment1() == SIGILL);
+    assert(test_post_increment2() == SIGILL);
+    assert(test_post_increment3() == SIGILL);
+
     puts("PASS");
     return EXIT_SUCCESS;
 }
-- 
2.43.0


