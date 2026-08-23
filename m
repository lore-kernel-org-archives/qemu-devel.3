Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B194EC5DF9A
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy9oW-0007ij-7a; Sun, 23 Aug 2026 11:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9oU-0007gv-KR
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:08:46 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9oS-00004x-F4
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:08:45 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so3512207a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787497723; x=1788102523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/YH/r0SUtYQNEVFWKkWujykCuJ9og3qDjzznOXWq+hY=;
 b=jVX7xjblNshUwCZJtmnB4sgO5YP6dNfPMFFyxzUKu3z5TWwUS71x5hyrayvawIf7Ks
 vrUPo1KHbEPzxyrTZ3aJm/77XhogiijjL61iVIKzNWMQMlYAmv9rtudzuauNwAP5X4kg
 TWbu2kYym+REsP//r+adM7ZM7UYB4avAqbpxHMqlr7Q2MY8IqsgqOYT+p9E7+NBxstgK
 cyDTQ9gyoN3MqQOrp2MAJ2yANfGm3qhpyWqJxseptjRk9kPT1+n1KChVyqzvCyxOYI+x
 PtXBN9qFwyhupPswoxA+B9TCPtY4Xi3nXkETW4kg11BcA7tfYgiEemVEma8+how0AlrK
 HhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497723; x=1788102523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/YH/r0SUtYQNEVFWKkWujykCuJ9og3qDjzznOXWq+hY=;
 b=BaJCeSSex0WMSU5oP3Z8lAeTmlSA1vcRX9fmn4oG/E9wZ2LQgw6uKOP/R4nOdfHyDJ
 t+Nyz7A1+T3q68hVn5SatTIXBbj9U2Qy8ZLg3Hg5SStkm9mVVMGNgQQekWtnWHuK18ty
 U5+EMiRXJZLRiCz/4r68rroxcGUkHOVknfFplB8Vel3QowARWEPDgPMOALU5uXRFrpz7
 kmCA+W4aJV8C4fGoaQxdg6K7CJ3yj09y1+Z/pKy47WKUPYFSFCYQaer8j4taryjlNYXb
 LhCDqsFY3QUDAZ26mSdDkhIGgclR8wxRWPUGFz9s/QiouEvTVwFrF1h/Hd7e36DHrHB/
 gpWA==
X-Gm-Message-State: AFuF++kzEpPWFE6BtnB45PaWOwJP2aHPfNlBQ99uGPU2MCT1W26HHzkh
 djaf0k+fV/j/ILtlpK/FRNekc4kbSzcE1hjbFer2qp2xTCZGmGijLvbzcgIEgLpeLks=
X-Gm-Gg: AR+sD11C8iOmADQtvgIzij+V+6Uyevp8xuZ7Vv6o+ZrGi76AhgtHykTNBQr5m9tGArj
 01S0IRQ3sOc+CvQyheyQFVChReI5m7mFG7UdAmzd28qzBgS6zGbS+GLKe03p4o6mPDbJk0JHDYp
 8uQt6cxDlDnKpMU26oFjZHaM0hQsM2Ha5wP31Di50fXUfHyhXJYGGLc0fxsiEC7aG6vuPUH7THM
 Vzycw7j/KSLNcUtdTalGuij5i9scqPT8cvNazjLFMInBvf+LMPcaiqm/mRdMOvYqzZSQlKjGwFY
 tob1zENLv/394xNZDpurU6OnUutC0ZA3hwlYmKKbl3ylIkZ73BXBZo3t0s5OxYVtwGwTBZdyAOb
 ciOBMcGi2xS8gCTTI7jX65L+bC5n7NoKWPBcoWATORskAkKXjEbN78JaMmWRbJitvgYSdXo/esF
 RD0qq/wbQyWxRkburiZBxuDfYw60V3lTJhcJsR5hLHZv+W1WSwkujkWPFStqBVfaSvWy9/plf+Q
 AwGyVwDWhsx7fLsX7xezA==
X-Received: by 2002:a17:90a:d64e:b0:38e:1497:af5b with SMTP id
 98e67ed59e1d1-395c33dd84dmr37038272a91.1.1787497723107; 
 Sun, 23 Aug 2026 08:08:43 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1418619d6ecsm16024511c88.14.2026.08.23.08.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:08:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 06/12] hw/loongarch/virt: prefix ACPI helper with
 loongarch_virt_
Date: Sun, 23 Aug 2026 23:07:24 +0800
Message-ID: <20260823150731.896-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260823150731.896-1-luoyonggang@gmail.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1035.google.com
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

- virt_acpi_setup is the same C symbol used by ARM and RISC-V virt.
  Rename it now so a later combined binary does not need meson -D
  prefixes for LoongArch.
- Rename the file-local virt_is_acpi_enabled to
  loongarch_virt_is_acpi_enabled to match.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/loongarch/virt-acpi-build.c | 6 +++---
 hw/loongarch/virt.c            | 2 +-
 include/hw/loongarch/virt.h    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index a0b445f297b..bbbac289b49 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -674,7 +674,7 @@ static const VMStateDescription vmstate_acpi_build = {
     },
 };
 
-static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
+static bool loongarch_virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
 {
     if (lvms->acpi == ON_OFF_AUTO_OFF) {
         return false;
@@ -682,7 +682,7 @@ static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
     return true;
 }
 
-void virt_acpi_setup(LoongArchVirtMachineState *lvms)
+void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
@@ -692,7 +692,7 @@ void virt_acpi_setup(LoongArchVirtMachineState *lvms)
         return;
     }
 
-    if (!virt_is_acpi_enabled(lvms)) {
+    if (!loongarch_virt_is_acpi_enabled(lvms)) {
         ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
         return;
     }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6693dea647b..74c9668b6e6 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -242,7 +242,7 @@ static void virt_done(Notifier *notifier, void *data)
     LoongArchVirtMachineState *lvms = container_of(notifier,
                                       LoongArchVirtMachineState, machine_done);
     virt_build_smbios(lvms);
-    virt_acpi_setup(lvms);
+    loongarch_virt_acpi_setup(lvms);
     virt_fdt_setup(lvms);
 }
 
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index d39a9bbf5dd..72268466def 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -132,7 +132,7 @@ struct LoongArchVirtMachineState {
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
-void virt_acpi_setup(LoongArchVirtMachineState *lvms);
+void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
 static inline bool virt_has_dmsi(LoongArchVirtMachineState *lvms)
-- 
2.52.0.windows.1


