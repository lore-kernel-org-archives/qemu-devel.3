Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAA9EC1130
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucyv-0006bM-OS; Mon, 23 Feb 2026 15:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyu-0006aY-5B
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:40 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucys-00081M-It
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:39 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4d8712b40so1756339a34.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880197; x=1772484997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DXHA2h7Br8C+LSz5HTQrqgfqpli3Jfh+QwtGKDTA7k=;
 b=h7tW2tHSB+1w66eAxwYvvbvsVOEJuL+rvuSM9ixs+YCuhHakeLrVRu0FnNaw2dm2UB
 AXQblZUShIe6JOdTOuGvE8TKfwnu7gxkEaM624Efi2sZ7QK7RS21CVT4GH6u28I/tU8e
 y7PmHiWaBH7NUaV97RrbUgeLwpEVk7q30VqVO1K9rBPJdYL+FXzo93IMblEmuf3ETn9K
 cE08/Qcjii/2yrpwZVSazezwB6O53fJy4kRCb+j6Z0F7WxTFjd8TisggWD/fow8te9TG
 0jnKOFWpy980Ce4p9QfX/+ap6TRSpaL8OXeDzPNqmVTwkE3RNaOzxSuxwQxWTIulXkO8
 PlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880197; x=1772484997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4DXHA2h7Br8C+LSz5HTQrqgfqpli3Jfh+QwtGKDTA7k=;
 b=ApaCOrx7Lbe7aHGSe7CtJs99aMWh/oM2Mkr/HHahf5O+LwAiAT6f+zRGDlC7mKPxFR
 Gb7maYquCnToDZtMWaWqCDex+BHJ6n66p6PWfMQ79QkgdWOfSAE+oFuwNOWmDSISHXXE
 HkZrc92ZAgfnHKaZa6bjAt5wSRQmhG9xFTrg2eblDMV04D8I8epDeBx3MW0zhNXgZtTv
 0HwVntEN0bZKh17f9alP5SP2p/cQqq7fUwiws43z20QJfYYkfWWAq8LZNfCfvcRMeOWW
 caZT3mLbYd2c0M/jk8APq8N4/y5eUUks6IFBUni7rGAbKd3bQ1UElcwlWuHAMuTvBvgV
 gC+A==
X-Gm-Message-State: AOJu0YzcFkawBaNnqOIBObIh3Uff4RSgyyfgJqiViFaZB1rmNdf2Ujgu
 Af+NwsjpEnckBSqaRhU1zcsnPWdUyOwOI4aid+l4NUa188uSgxa2W2DFNrDg5Q==
X-Gm-Gg: AZuq6aLn2Q51fxA68+Abs5uuruHMJOPN7NmHGVFjRak6RfHH7YDA3ZuURjTR4YR07DB
 l4hD0JcvJotr1hwMSay3Tp+cUur2T3RQxyTmfMkL6rMxmWdqTwLwgWOaruPy0zvx4/UQraFHsXt
 d53zVRRFi5wADxBe7xDmt7SmCVUei/VqxUCZns7YxTBIT/45TaRM6qIWC5o04Rulbm4ilzj3M2y
 kTegn2+Pxf65idK8/X2jTyCCWLdevz2LWQa80JN6VW14NzF8vDiiv9/7gTquCvPJAs4+VJ9Q16B
 zamY9FhB/d+TLqoGJwzJSbtwjy1tZPuvu3E3p931Knx5McebgRF5hGyo0DqxmXjU/qO2X0psq3V
 WYc0qXa8ka5uNMUarKT6ITEyQKPSH7OJ5tHquSJAXvcdYa4O8/4nne3C5laYv/2OeK0yhPt8S+o
 48lg044Yau5NcbTbxNpbQGGA6aZ4p4M3fhN8B/0nEXmuXk1XY2Tn8HMmxkvuOSSe4qCZdDUl0nU
 wndLItFPnJGyuAtDk38SpuX4Xl0LCwIP1Kc1w==
X-Received: by 2002:a05:6830:6b0a:b0:7cf:d4b2:d664 with SMTP id
 46e09a7af769-7d52be8032fmr5857102a34.4.1771880196928; 
 Mon, 23 Feb 2026 12:56:36 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:36 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 3/8] Hexagon (tests/tcg/hexagon) Add tests for
 multi-destination instructions
Date: Mon, 23 Feb 2026 13:56:27 -0700
Message-ID: <20260223205632.223714-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32e.google.com
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


