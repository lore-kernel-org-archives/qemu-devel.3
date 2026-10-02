Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7F6CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChQ1-0003v1-Kt; Fri, 02 Oct 2026 13:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChPg-0003mt-Dn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:16 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChPe-0007Je-KB
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:15 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-34b1743e9c7so2340381eec.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963473; x=1791568273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kLOBJyItJ1+wNCmx4Q5Z29VyAFIZnj6HoQfSvPthpZk=;
 b=ET9WTKKNOsAYEA+HuRudT08kUE8vVbVJxBXLVf6gzjoFDQ1XhmkZU1rA9wbIzvrmnV
 H0CCu0KJfSewgJOr1D/OUU5qTHHY0PRD6sScrNFnTYCkGTBSp3GjX+QfoE8ROETVM75E
 PDXxCXBglB3NimuXAjIMRLCoQTzdGxWRFSO98Mf2ns9Tuy6iCq3l2AQAWoC2ji4vOFp5
 T45McXq1mqe8spVRN0NqXcnxtNTo1VtiJxm+Fa5xx6CkeWfQ8Ya5p22afIuIgnpqsYu0
 g1YKQtiJUBgudC9jbOcQ5ea8+2GydZzrij5murSKr7v6xr4wXGDXxizsLftUCLIKVfnJ
 qhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963473; x=1791568273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kLOBJyItJ1+wNCmx4Q5Z29VyAFIZnj6HoQfSvPthpZk=;
 b=1O6YyJ5RjiQ+G8VMexu8KJmBMC8MBWkWvTxA6lJEheQYDM6tUhwsm5WronNme+T90Z
 8G0Xni/x9J6/03Y+t2COj835MY68vPgXCed6IlthghbX0bLBKDMQ5FbiGqNcKCpeVxqm
 097VaefzSFJjyqIQAOGe5lHuHwWKPoECbz5qmFVyxpq/G8BQPtZUBClTV0DT/IZDzkm1
 x3yOHj+PPi6Cp4p2VWuqqbZ2H+ALcHgq/wFpbvag8yQ7UaDscyhScpryc56tzog9JbcQ
 OsDhoLSvmenGbThDbfBMBXuxhjeX3LdsuirqCMwei9/r7m0Yo0ABhoibm3EgOR1fZYeb
 O5sA==
X-Gm-Message-State: AFq9FYIu71eOZnRZ3wAccU1d0kIvr+dZIrHB+xXWhTwwh20wsUMvsvw3
 GjGO50I3ftaRdeVQ02jrkpuGbjkCpmJCpReyQeQBYF1rdDuAL0kC+GEJr3hiODXjD8w=
X-Gm-Gg: AYBFou0Ywu8NcmXPu7ajDSGHH7lV9YpIH4D9yx0nnrT6Duo+Z2CQhnEm6Ne49UtGJbz
 4OTM6lUvdlxSK+5awt3GEm/hkGWmTfXaNnmN00zCrypNUOvaO1NjEreAW+Ulhis3DVBHeFi3Jxz
 xPVK0l0zVhI7hzvBgDSClJ4dGi+upfzUpkGjIQOWLooPDswL9g0NGhlHhh28gSsU9lu5sSIWN+6
 t1h8fx0+9TL374pppjoGTwSQ6/6WeWXkOppZhUoDRK53algkpWzwIXLqVrz/oZoGS3qpktREwmb
 MxcuxgJpg52lRGJ9KfumTEABl7zXzsJ2t/z4v1RV6/NslQ5udH9dYEBiDE8O+fbxAIxicivxf+1
 JzJ8KKqChBM6I1d9O6A0JkB5qH5tGnGXzTpjO+SyYFynCzaELIlfqjnj9n0AjjyFX8KTIauUmee
 cAOLHv3XOQZrLKgbA1b/T928ZDoxk06lCKlscH65JSjPZUDmW+9s4prlg2DpysHSUY3ey2+R73l
 +zjrYb2QA7cDU0SiLDIXBfake9cGj0=
X-Received: by 2002:a05:7301:b0a:b0:344:1bd9:1f0d with SMTP id
 5a478bee46e88-34f150d42e6mr3480798eec.21.1790963473082; 
 Fri, 02 Oct 2026 10:51:13 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:51:12 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 03/27] accel/tcg: add raise_excp and raise_excp_restore
 generator helpers
Date: Sat,  3 Oct 2026 01:50:11 +0800
Message-ID: <20261002175037.1747-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/cpu-exec-common.c | 12 ++++++++++++
 accel/tcg/cpu-exec-common.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index b551c1439ec..715e3cb327c 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -131,6 +131,18 @@ void cpu_raise_excp_restore(CPUState *cpu, int exception_index,
     cpu_loop_exit_restore(cpu, retaddr);
 }
 
+/* Raise exception and exit the TB without restoring guest state. */
+void HELPER(raise_excp)(CPUArchState *env, uint32_t exception)
+{
+    cpu_raise_excp(env_cpu(env), exception);
+}
+
+/* Raise exception and exit the TB, restoring state from GETPC(). */
+void HELPER(raise_excp_restore)(CPUArchState *env, uint32_t exception)
+{
+    cpu_raise_excp_restore(env_cpu(env), exception, GETPC());
+}
+
 void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
 {
     /* Prevent looping if already executing in a serial context. */
diff --git a/accel/tcg/cpu-exec-common.h b/accel/tcg/cpu-exec-common.h
index 19359a97bae..1e82f3b14d3 100644
--- a/accel/tcg/cpu-exec-common.h
+++ b/accel/tcg/cpu-exec-common.h
@@ -1,2 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
+DEF_HELPER_FLAGS_2(raise_excp, TCG_CALL_NO_WG, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(raise_excp_restore, TCG_CALL_NO_WG, noreturn, env, i32)
-- 
2.52.0.windows.1


