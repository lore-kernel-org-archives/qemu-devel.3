Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3F606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O4jIaxxt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC9C-0002i4-UP; Sat, 31 Oct 2026 12:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8y-0002bw-Tw
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:25 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8w-0007mU-Lq
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:24 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-14394530ec6so2227994c88.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464881; x=1794069681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F4BZlHQ4uuWh3AcM0lAUJwiu4sRioxBd7xwErjYLxjk=;
 b=O4jIaxxtb6Ih1uoqJWOKOaTWBdm2KZQPfsu71kkUYDnrNmqUHFj99inGb9RVSOvjtc
 NgOpWkIMUW0i+Djy2fmaq9IuvsAc1evDVKjUjaCylbJsFlawUfxQZ5LGWjZ2f815rALy
 kU4I+oP0xMEBXIDRjiSC580oMh/u7yj507+V3r8kjrPyVrCdn+a0Zt2kS6fDAyA9f7b7
 vE0WpHaFS7AgtHjebawKG1Cf2k5nIAMTUAHV9vItibL2tw6DwN84cEZk0LgREssbGG9G
 eA6zmBzZ5bvtIrbykv6RBP+3EiHm+40Djdyc00QDmQ2OWobFgy8gctte00u0teOLKJxN
 Pgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464881; x=1794069681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F4BZlHQ4uuWh3AcM0lAUJwiu4sRioxBd7xwErjYLxjk=;
 b=Tbx5a7I2Y1YPEe6PVFA3Ae8KCYJfD6NDU673z5kvQYXJOTn392NivAmdFj9Dt19Hiv
 zLNLNOZIwB2PyBnDj8Qo3nZmMltjMY4iBYgpJmFgANTsif3WrzEcraUksM6MocsKObHa
 hWLVNQhon2hpNmRS6jtBUuTKtvjCnXoq49OhjJu2kOyLM3ZiVwzuXkGPaoZcFZ7GK8HL
 cbaI2pUfWfWfvuDovsZLPPWvRDKWKrYasKOpv27ir9aiGgOaPNwjPeMVEOlQROf8GoOx
 W7XAZLyYjrcnD9pG5HvCPVJG9snw+Y5lqIrFi5F2RZ7NkcZLgc+uBF4DnrpOLJXJ9kya
 Q4Hg==
X-Gm-Message-State: AFq9FYIBd4dK4C3kJL3ovzkluJxMMDYh9WfVDJGDLFKE0ufu8oJcfFAp
 H2cuVK86eyzxOq1w0cc138CdiH0cVO6mgmh8RwKP2ETqG1m+rX5vGIVpnqm2zfGz
X-Gm-Gg: AYBFou0f/G0nEWG1m3qH/dpuWvM9Z/GbMq4VoJ/t1+EpQI9RhKFyRaZRkeqY5+J3gDk
 ye/XGJqvUM1cOWYaR7xvEDWfvTKjtP/Cv1I/jdtCbTtaYM5J+Lb7DQLPh6mOkw281h6XbILrR+k
 iiWF81YTweFkEFGGuPsZMQypQ5gv1tb51SGOFykR1xq9jWUSAWF3KYstpMUwtp0F0ONyiEsU/aC
 taGvUqtAHCKbBhOdG9lyz1bZFPxaomWTfTzSulrYkCz4QCtPaEzIGx+1MTV5F844Ufx1SM7kQV+
 D/GwyQQEkuP2aacu+syAZCHV9k7QEkA2zmhdzDSe2ZtsHJS+o67pCJdUm7viJyTjLC1ev1fAGtn
 pjuUvet7IKilfLdaV6aDPVyis/lfFhtE+GtIWapTpPdgWeADM0znWz9tB1HPKVCa6Vytq38dTiv
 sX1gyCjUyA2HMOs1prvfWT7OQhq12ePirl+CsRrbURUQq9qYLVc/dIbPe42EOM3S9UbdLaS6LMb
 naxczgISWfONTk8YtiUe/TaCZlgWJb1szuWrzzLjNKEQUp4Dc9sYHH44HgehrHjU+ydK24hMZEG
 fmNxGvAFxg2SishPkrAR1NbZ45y8Q2yjZtnSRacgfWDKQI01
X-Received: by 2002:a05:7023:90c:b0:138:30b1:4c00 with SMTP id
 a92af1059eb24-1ac56d95448mr8838301c88.3.1793464881306; 
 Sat, 31 Oct 2026 09:41:21 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:41:20 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 10/12] target-info: add target_base_i386()
Date: Sun,  1 Nov 2026 00:40:05 +0800
Message-ID: <20261031164009.2048-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1234.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

target_base_arm(), target_base_ppc() and target_base_riscv() report
whether the selected target belongs to a CPU family. Add the same
predicate for i386 and x86_64.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h |  7 +++++++
 target-info.c              | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 1d6c6f4472c..beb7980ca87 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -57,6 +57,13 @@ bool target_heterogeneous(void);
  */
 bool target_base_arm(void);
 
+/**
+ * target_base_i386:
+ *
+ * Returns whether the target architecture is i386 or x86_64.
+ */
+bool target_base_i386(void);
+
 /**
  * target_arm:
  *
diff --git a/target-info.c b/target-info.c
index 07dc88fd366..d8cd2209018 100644
--- a/target-info.c
+++ b/target-info.c
@@ -59,6 +59,17 @@ bool target_base_arm(void)
     }
 }
 
+bool target_base_i386(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool target_arm(void)
 {
     return target_arch() == SYS_EMU_TARGET_ARM;
-- 
2.55.0.windows.3


