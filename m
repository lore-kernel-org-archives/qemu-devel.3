Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF81BC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MyI-0002lZ-2Z; Wed, 23 Sep 2026 09:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MvB-0003CF-8p
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:04 -0400
Received: from mail-dy2-x21.google.com ([2607:f8b0:4864:36::21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mv9-0007ef-8E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:01 -0400
Received: by mail-dy2-x21.google.com with SMTP id
 5a478bee46e88-33bebf0aab6so436558eec.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169718; x=1790774518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20fmaOno77HQJxryAkVKJDwkjIsA6lPsyx3HFEs6GYM=;
 b=PMEkrb/Ri/F4T5LjCFoieBle/ToHgeQB+JQeO6a9z2TYc5AiaS04dnO7AgHRuEyp4V
 2o5LimxbInUl+xJpmYdfprqfL759qSkv5v49hCMgvG8PNwTDy8ZbXkDvu/UNzUuAzTk7
 Vz5Iq4BM4TwNrwM2Oa6ND/OdcsZ7bRAmWmWlA3YbcfiGzaVv6kVmmA6Zkq/PYxnn7NE1
 ZO3Q9fYq8SpKg+LcBF3TCIAsPJ1hlA5uanbH69WvVzY4xV7h3DeauB5SbpglSiJGimUY
 RQ8DUhmrqEKQXz7/GezZD5IqPG1DH3V7sP1pvoW0E8XSEaOQPtSGEmIQa8f0SbiDNAGh
 3/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169718; x=1790774518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=20fmaOno77HQJxryAkVKJDwkjIsA6lPsyx3HFEs6GYM=;
 b=BkdhVB3dMQq5oHnCe0aQS2mlOAFBOzXa+MLmEauwgSZOYmsoubKE8t9yLIfU8eWMHE
 uXO4x7jVkHfu3fHqNNqPQe9aN+p/Ln9bILr/X2d5kedbW9X/krXd40X6s2RqciSyjD4A
 wj8h6qMOJLlWkFwA7jBM4u3PHyg1XbBW1U5Y8/wg7V0nFoTI0wHUl4q5hfRwH8hNl6Zb
 bqug+ugI6IEqE+T8nhIe1hF4rAVqSy6nitNC/gA5ABTjVI+g70mCxS8Y1ajRQ+gRF6CW
 nZaT0kM4U3FliV+6v6v98XtcXQ7F0mUcp1mETE2hs8lgFVjPVg6+M4ErOeXOFc/BjJLv
 NkEQ==
X-Gm-Message-State: AFuF++nYYwLxL9448iH0+VmPsbmGLustXDYhO8wklP8urRovE8r5YlYw
 8WktLPQcAvwK32RxKYuJFLy6oMW7wFR+P+tVbYi6gzCGtkcX/zjIAe0CJCqja2wph+o=
X-Gm-Gg: AYBFou2ySkzMwbdOFyGqAz3OMt0I8nPk8lbGj7QCQ/U0Tvt9xkME2J9WImwxaGeViex
 Amj/efxiqTuLL0r9oeAW4oiV5QT07Dvh+j5eWow/+3jZB00n5CxZMnIPoR2DbB/e+6ZOK+bLFHx
 bd/nT2UkxgZfAIYgmHxVsILNfJL/jpxiAuAdSg5VmRSfahQ+zDObaOIjxgokczQgaCxRL8K6W3D
 TKX3VAPAU/1gKhfyC5qr1vLozm8KRQ1aCHkcJQLZIGTulMTbkcNn+s742XqKZPUsXk5C51JBX4z
 vCAsjLQ+Zn+KF5eSAJV0fhclsCBf4mhPLrT0mQLMzkZXP31AVMDtRkipNbcM2VjBfme/vraG5Xy
 rqQH58owcoMOP3Rj5z0guvB46T/toddUt6gRqtZcWnuJ8i3OtjqqAiO7ULIxoTjMeCF9lnEutT+
 rRnY0vd8QWimQV4fVrY7DdFoKmoXJ8MqUWtUrXIlXMSV+1iCrZB1O6kT3MgRnZJDD2TpJdCW5Pk
 VZQb2r842MO4AiKpo7XNaTETVtOKVqWdV8IqOu/UQ==
X-Received: by 2002:a05:7301:db0c:b0:33b:96b8:3818 with SMTP id
 5a478bee46e88-33e8ddbe14cmr1962518eec.32.1790169717553; 
 Wed, 23 Sep 2026 06:21:57 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:21:56 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 030/114] target/riscv: add kvm stubs source set
Date: Wed, 23 Sep 2026 21:15:04 +0800
Message-ID: <20260923131635.1894-31-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::21;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x21.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Add riscv_stubs_ss and kvm-stub.c, matching the ARM target_stubs_arch
  pattern (has_mp_state returns false; other entry points are
  g_assert_not_reached).
- Register target_stubs_arch += {'riscv': riscv_stubs_ss}.
- Leave target_arch / target_system_arch in place; next change can
  move RISC-V onto target_common_system_arch.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/kvm/kvm-stub.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
index 64e39c96d89..1c8c324cd44 100644
--- a/target/riscv/kvm/kvm-stub.c
+++ b/target/riscv/kvm/kvm-stub.c
@@ -9,6 +9,37 @@
 #include "qemu/osdep.h"
 #include "target/riscv/kvm/kvm_riscv.h"
 
+/*
+ * Safe to call without KVM. Return "not supported".
+ */
+bool kvm_riscv_has_mp_state(void)
+{
+    return false;
+}
+
+/*
+ * These functions should never actually be called without KVM support.
+ */
+void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
+{
+    g_assert_not_reached();
+}
+
+void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
@@ -17,7 +48,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     g_assert_not_reached();
 }
 
-uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
+void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 {
     g_assert_not_reached();
 }
-- 
2.52.0.windows.1


