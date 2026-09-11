Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10317C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QI-00038a-Vj; Fri, 11 Sep 2026 18:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QH-00038C-F2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:41 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QG-0002HN-1x
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:41 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-804e42309a5so35474a34.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164519; x=1789769319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rAluVMYKeWfHKHjN37UGG1wr+/XyqdD3i5t7V6iE0KE=;
 b=QwDzYG8i6w6dpa002E5UTcyXqzjp1xWEWvPt38dvfpN8JPYiZbQ5CBO7Oi7vCZODve
 VYOnKo+wrY3AzME0zH7sbrfOUQxO2Mxo5RFsfnXCiNkI2FfBa0dH5s5Gp01oE/v6V7xd
 M43mhnJCnXp5AR27SE/xAbZUkd8KVwQzqiDe6MaHdtIqN+qtEnqTSdfhNvCvXDxhwHNU
 YandoWRcCJMIs7j+9OjCxaQJZ+7Zwq1aNwqaSlIDklTEsUDUVbC26pWhehH5IpvbXVH/
 44NTTNnR1xsRLlJ+2rLOgLDpJF2A3GmWUji8B1RIvV3attvHNPu9O3fQCxb4fV7YbPQi
 Knqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164519; x=1789769319;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rAluVMYKeWfHKHjN37UGG1wr+/XyqdD3i5t7V6iE0KE=;
 b=TuPUygB37kts9BOBze1V6heDkF3Z3Jw98yPYPFDRLPBPuTDo28vcvpI9z5QWHwWucK
 9nDGAIeUgBUf+DeDNoQReNzw1UzJSlxWQXbrctEz5C16T5GY3r7PilJnsiwyZVsy0bAV
 3lGmCmMbH2m6FbdMlqUkt07W8mNWhzqmTgQ3aEh3U+6Sbf8qvGg4aWo2u2DLZ6XgEqgS
 EsJQ7m77IUHKrdQIQ4+DRXc7xlP2MqUFLKtMEOvIZyhAWruHfNyN62SpFykf4fysv+sp
 c07DZINNzDUPMB8QqOOrjmHWt+r88y8ViwAN7LEtI0jVyBefd/iNbZw+Em21b9r7UM8U
 FKQA==
X-Gm-Message-State: AFuF++m/WXBcisFQlk9rRRJ7cz83o5ohyJ6DZaMvCQNi7zh7bpB9jrpj
 FG6s8BgGCBG0NjSjNAGpW4w80gyflE5oV6xd14DcnlFkEWvqzDKiDA8iQieqtaqQ
X-Gm-Gg: AYBFou16pQRQM1nPrOxMFA9fNA0HPcT2OhRZw3U10oJspCahhvcvP2HP3IJlORv032i
 6JqiMBe52He3nYX5/WF94qvHoWy1WhgBfBfyEmcfxa8x4Dz/njjseRxDq6yKR9oVv1KzaszjpSY
 s4r9pDxrRpqZ+QokdI7EOnercaZBDEIPGV8HorjZajTalnzrtksPv8kLoGC1HaLgvDsjvvkS7EI
 E/Ow96KPMVpQ6miigH80o6VltqqCKOACxJFQUweCd4fgFfDUum9gYz9WFKm2mkaOPgCziTv2S9U
 d9QD1Wf2TArL6zU2aB47UW/faa+WP/Rhbobqi/rwc4ov5135l+E69wOA03WuUhRChqV1ay/4WoL
 yiuxtVufZSAAOaAS3BbVDfHoLglqmuygSbCcobANfoHhocTLqpkwo44oouKUBKgIWMqZASx0vQk
 +Arjr5QDe4wIW0HZa9EJHYsE1wrds/HZ9XU6wFZ4cgQnvboXXLmClOyivKaekND0axSr2LriZlo
 S0ci69ubA8ldHWp9sVPWaEZwEXXxOItgrO/P1wm7DxHCbX7NQQhOlOzGMTT1Pk5
X-Received: by 2002:a05:6830:6f86:b0:7d7:ea9f:c0f9 with SMTP id
 46e09a7af769-8059b382fdfmr266407a34.0.1789164519078; 
 Fri, 11 Sep 2026 15:08:39 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:38 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 07/10] Hexagon (tests/tcg/hexagon) Add tests for qreg
 multiple writes
Date: Fri, 11 Sep 2026 16:08:22 -0600
Message-ID: <20260911220825.143115-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo2-x0e.google.com
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/multiple-writes.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
index b93f2ab32e..86adc1331f 100644
--- a/tests/tcg/hexagon/multiple-writes.c
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -242,6 +242,27 @@ static int test_vreg_illegal(void)
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
@@ -270,6 +291,8 @@ int main()
     assert(test_vreg_legal_predicated() == 23);
     assert(test_vreg_illegal() == SIGILL);
 
+    assert(test_qreg_illegal() == SIGILL);
+
     puts("PASS");
     return EXIT_SUCCESS;
 }
-- 
2.43.0


