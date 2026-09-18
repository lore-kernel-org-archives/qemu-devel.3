Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683EDC982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mgj-0006eR-JY; Thu, 17 Sep 2026 20:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mgi-0006bq-ID
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:42:48 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mgg-0001PF-Tp
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:42:48 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fbef5018so2511575ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692166; x=1790296966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wIZSbkvaEy6mXK2aVNYREGi8JRqUA4yskA/TpdLSFIk=;
 b=jLD5FTVQXrmNS66hfw30vJ7DIYX/Wtfw96WXMbvGNRrl2I4RqNSHGYCQUvvxsY1Kqc
 QaSV5pP92Dby1Qvn8w28jAOLII/16b7UiMNsM/K/5bfqiYsUeL6bWHXvuoW5qNedm8Xt
 IKQMMZ5TKBDMJjGjMVRfw7ff9nCCrcvfdGZOCQgwGkKhwDFPVAGu8EIGSl/r8akJdrb+
 Q0/tzXqAHmUQVkdGmY2mVCCq50T9htlmypOo2yyjPo62EuSUMV0N254x7H+GFbISk4i/
 HfATDbdSLfcC2oIWZjlgOe+pSOR2kbtNe19m+x6eociz4ZANJGfTfdzHonYs5nVwAV3p
 PC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692166; x=1790296966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wIZSbkvaEy6mXK2aVNYREGi8JRqUA4yskA/TpdLSFIk=;
 b=BdR6V8qQDouBuyAG0EvwIyKJydMlDyU4dgaGkqvPHeXAL4ywxuURZpsaLR05AOQR6Q
 kbNQzV7I88Q0xPWvL0i68PDBPA1aOv5cpvKY3Rk0Q0N597YxJKTSBLI9g2A+E0ciiRsx
 7lS4J4D7peFoKHqlj2oLdlOhTLZpN76ldqJV+NE38pMu8e4tG56U/fDLAnnQN+pZJYYL
 DN8RxBftlaBZYOYLgLenr1L42O9VUDr91bNKYqK+adsRGhaxcIRJw0s0Gi0KeGWy9e4g
 xoIYC/7eEIhIo36JGp+Fvjh29G2GtUOML7eqHOL7Z1j+mA/+/nNsq86qnWnuRVZEXs1A
 K0OA==
X-Gm-Message-State: AFuF++kmXtoGpOZWzk/kGrY2hZFX12cUmEvt/xZN7Y8by5S+aKdh27dV
 zdYzlfDMMLIBSXf2ipXzJ3fVg/a/dxbzZQe10+/vYKsdpG3pU8K4BBVIeqbqEEDGwPk=
X-Gm-Gg: AYBFou28Sudg1jkky3NeYfYLCfArkJw2noywHXvEh8Hu0L7VmMLcqBvk5e9vMRCISKR
 Tkn8pX3/Pa83klY1TA1ZrF9nxDpPfx0iOzUDYFeOjnrEoVKSKzU3hQvhxevBsFw+7iiE1OGZ2v/
 ecdjCOLa7p0kJkDQGbvA+5EaMChpcKmj/3J9Ka6sbc6cxyoHPgm4Oj2j8rnYZkkzc1zNAV1Ec3A
 OWwZfrdWVNfYeDgVmDfJaL0CzOiYPnYHDaqNRWgPiDZEB1Dq/lDiGW1r4JSlUp2/1GIY5H45Kam
 EqAPeak0bYhsjY1lzyT2FLihRJsvenR8Eboft4oQjeicrkjPp9oYgsWVLAPeaShsOqECHRFT/Iw
 o+7P7yIKLb4Cssv9VMSXlY+iF1SK7w4aebI80yBNOPJ0PNlrXIt+K/4fj9B5ky+WnwGI1xYRgCR
 LOuadc8FVlXnAwhIgbpwvgY+9RwszhROiIhmSTw9zx4ucny63AUx9PyYi2vOx+drBONuY5B1A5V
 5vmDLNKMWOmrOPL2R+5qwP9w5bifODV
X-Received: by 2002:a17:90b:17c5:b0:39e:1633:d29e with SMTP id
 98e67ed59e1d1-39e54cc6ef6mr1830117a91.5.1789692165578; 
 Thu, 17 Sep 2026 17:42:45 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:42:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 01/21] accel/tcg: add cpu_loop_exit_excp
Date: Fri, 18 Sep 2026 08:42:03 +0800
Message-ID: <20260918004225.827-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj2-x10.google.com
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

Add cpu_loop_exit_excp next to cpu_loop_exit_restore. Set
cpu->exception_index then restore and exit the TB. host_pc == 0
skips restore, matching existing wrappers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/cpu-exec-common.c  |  6 ++++++
 include/accel/tcg/cpu-loop.h | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 44e84344f3b..a33ec922745 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -82,6 +82,12 @@ void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
     cpu_loop_exit(cpu);
 }
 
+void cpu_loop_exit_excp(CPUState *cpu, int exception_index, uintptr_t pc)
+{
+    cpu->exception_index = exception_index;
+    cpu_loop_exit_restore(cpu, pc);
+}
+
 void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
 {
     /* Prevent looping if already executing in a serial context. */
diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index f4d38bc2bca..04c14396d93 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -65,6 +65,19 @@ G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t host_pc);
 G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t host_pc);
 
+/**
+ * cpu_loop_exit_excp:
+ * @cpu: the cpu context
+ * @exception_index: EXCP_* or target trap number
+ * @host_pc: the host pc within the translation, or 0
+ *
+ * Set cpu->exception_index and exit the TB. If @host_pc is in
+ * translated code, restore guest state first (same as
+ * cpu_loop_exit_restore). @host_pc == 0 skips restore.
+ */
+G_NORETURN void cpu_loop_exit_excp(CPUState *cpu, int exception_index,
+                                   uintptr_t host_pc);
+
 /**
  * cpu_loop_exit:
  * @cpu: the cpu context
-- 
2.52.0.windows.1


