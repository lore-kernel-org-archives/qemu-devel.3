Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2631C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBACE-0002Gz-5E; Mon, 28 Sep 2026 08:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan260699@gmail.com>)
 id 1xB4W7-0005Lg-Ex
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:07:12 -0400
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan260699@gmail.com>)
 id 1xB4W4-0004Ol-6C
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:07:11 -0400
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso6896835e9.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 23:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790575625; x=1791180425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YvbufSJ8de3jLwpO62dY2tmldsGbWsZ+fJKLfQ7LzTc=;
 b=YGKXRftB/zFGppmAAQx5j/8qBrLI4lZ+urNxCGqYrtHa1JAZNVsQ2cOimbSHvUOV27
 xI/Gx2mn6ps2WO/vW8UwgAqkgaq/CJsiciF4TKsPoqtNhIjfUWVK03SlF/Gurp33hwtR
 fkfBr9zRXqQpTzheR5Tn54lBhD1Gvqq4aexpNPK7vXPKI9ke3NC/FLPckoe+5xxtr8Mz
 C9RjYFyTHoPV8IRAh2xQe+CC10XrWenQuItpnCjnf2d2e6sE/BbiHKbH6x1Op3XieUiW
 abxmm2hLkGY7PzNTgCMcPDfGdWBM5hXozqbcmoiVPdutSwWiTgRzUlyQpQm2OcogSi4N
 cupw==
X-Gm-Message-State: AFuF++m/qdEK42kfdmLzi8mTAauTcprk6CEKL2YgeEe3v2xONgGrQztl
 3EuxIr7nPLtoG4c0ZJiMdPs8lCjA3e9ISEXSk7/xYjzY/IylfwOQhaEu
X-Gm-Gg: AYBFou02EI21mwsjnWr/DnUxAsvNq0BkRepE/SucqOMP5iwgrmCMI7eGFywVzJuP0w3
 PzFFcRgSLmcBE/6hbKqG4ixuPndesN0bqnVxGmJdGYlNPm3DM3ZA1+qerD53SLFbVLSKTdc7JZk
 o8tcKwsAI094XDjsriQwjCKOZ5D0HdQu4E1dLjz4qbztHK+YdAsqgGUmph7w7jPrKySlZ6IcYRZ
 GxsBWjMGdu3E8BMKeDNf2/AOXlJFENzYYj5vpZCHHZQ8yRLsJK3Jnm1E0Y2TaP4puhDZL0yFcON
 d0XVi3RN4X55PqrJ1r4JV3Qw50T937C1+Vdws2kyNdMm3r8WMXr2AgUX5RdzIQ0FuNRd9icY9Ih
 B39RId0B+E5pfzK2svMRBAMgqHFVQ8EAPBDFBvljNPv8lGCe7iQeHbLhF5wBaXMqIU9osWo9V4s
 xleXc5Vr8YintjVctT+xZS77fTdVJgYuszd010s8YGHL8zQ7b2D+RIKUHqLh+AvyX5tU6UkZQZu
 jGrNg/BwloVc+KUXg==
X-Received: by 2002:a05:600c:5394:b0:4a0:25c:8ad2 with SMTP id
 5b1f17b1804b1-4a0025c8c52mr56865615e9.9.1790575625341; 
 Sun, 27 Sep 2026 23:07:05 -0700 (PDT)
Received: from mac.fritz.box ([2a05:fa40:300:1a00:d105:6a41:99ee:cbff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a008f7f1c2sm1325775e9.1.2026.09.27.23.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 23:07:05 -0700 (PDT)
Date: Mon, 28 Sep 2026 08:06:36 +0200
Subject: [PATCH 1/4] hw/riscv/virt: Provide number of interrupt identities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-spacemit-k3-v1-1-8c57d0596b87@butz.st>
References: <20260928-spacemit-k3-v1-0-8c57d0596b87@butz.st>
In-Reply-To: <20260928-spacemit-k3-v1-0-8c57d0596b87@butz.st>
To: qemu-devel@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Stefan Butz <mail@butz.st>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790575623; l=3599;
 i=mail@butz.st; h=from:subject:message-id;
 bh=w2OjWKCaO3jaHKzDKRqYUmo5SBU5u8jG3s//MB19DZY=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBAOJW8yHG2FdKcC8jiWoQyd2Z6
 SNHh+aJB0RLkH7BFF7Yy7MymfE5UJE2mmoucIa3HiNQdlVZjgqLY7wph/VSM4kniDO57IG9Q9jN
 x96oOAzzWWJEVrh8vlxRGXatNy8ywcO9WExvzLop5s2ddP08f0Wrzn/55mpqoLJyoKaIbk10kxz
 JW1GONHT8nsNvBpVB2lnzA2jhv7DC79UlHzA98+sp8eX6kmUips+9LpTJLDeVna8f/vwkU708PI
 Qxt/5nhmFXKj/su/CMFivCLHckdmMOem/4UNoTyRcAbcoFQ9WWyYHvAD/bRuYZVEA2hfoBEQVu2
 FGHdG/OimvbT/GseVmWjiw7WV9HUOJJawVmfoTEJynX9BbV+VNMKZVpW5YaAaps6/KOC7V2bM7P
 hvORUmj3b8eUr418GYC3M4rLJtrj6Vu2cUyTV9Q5dvq9Lg2TIj/jpbEWpOqn2FSGkQcLvcDksNk
 jOSGmdG4h+OJ3vbGrva5UCJF/KIyuV4ozlSU7awAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgAwWtm/L/IcJjewD14QlBPATSiL5yGh982s4fUA7odc/Qsmxx
 EjuLRojyTXVh1Fb+GsymXFV43YUaIKgj22vgFq2Q8GfuxXmo2XM6JHZU8lAkR3aA9DcjVBPB8VT
 REXL3tRtaWGV+CMtp2lEGZdomw4F2Mh+RynyQm1WqpMCCbaGpVassDlOrG1ZHMWq/a2m+F8O2ig
 35WJSe3HiBX2gGScOFjmS1IfwVq+iZfu3kIQeLtZpDZ589S4xuhM3Rowrg3+Kx/mPqQAtbwJ9sd
 IpIARwy6MRJsMt1XSpnzl9bOwLX2WBBE5uGFntcLVq2nczI7dTBPiuK9LdA1IHOBL06FKitiexX
 hSxCFFNqUcXeiuxqBLQyc4lN+LTIWiBLQCbhLNVRgTimQEoU10CA/fwKYY3XhY/Ihrn1Mtrb7Tf
 as51w/C8hH+U4NR8SxrkGdRg2tYVtgajq2lNjYODr1Mp1v1QZ1U2FFX9K/ZHgbS2sg+1mvWUY0F
 5+znUOfsEItlPJw==
X-Developer-Key: i=mail@butz.st; a=openssh;
 fpr=SHA256:jcZFBs39daoQJIontO/rJaVachWp/oqTbhNpQk8+REQ
Received-SPF: pass client-ip=74.125.225.140;
 envelope-from=stefan260699@gmail.com; helo=mail-wm2-f12.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:10:50 -0400
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
Reply-to:  Stefan Butz <mail@butz.st>
From:  Stefan Butz via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instead of hard coding the number interrrupt identities used by the IMSIC
pass it in as a parameter. This allows other machines to configure this as
required.

No functional change.

Signed-off-by: Stefan Butz <mail@butz.st>
---
 hw/riscv/virt-acpi-build.c | 4 ++--
 hw/riscv/virt.c            | 7 ++++---
 include/hw/riscv/virt.h    | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8e516ec114..0ebfa10a02 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -576,9 +576,9 @@ static void build_madt(GArray *table_data,
         build_append_int_noprefix(table_data, 0, 1);        /* Reserved */
         build_append_int_noprefix(table_data, 0, 4);        /* Flags */
         /* Number of supervisor mode Interrupt Identities */
-        build_append_int_noprefix(table_data, VIRT_IRQCHIP_NUM_MSIS, 2);
+        build_append_int_noprefix(table_data, s->num_msis, 2);
         /* Number of guest mode Interrupt Identities */
-        build_append_int_noprefix(table_data, VIRT_IRQCHIP_NUM_MSIS, 2);
+        build_append_int_noprefix(table_data, s->num_msis, 2);
         /* Guest Index Bits */
         build_append_int_noprefix(table_data, guest_index_bits, 1);
         /* Hart Index Bits */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..0ee726b4c0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -277,7 +277,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
             .imsic_m_base = !kvm_enabled() ? s->memmap[VIRT_IMSIC_M].base : 0,
             .imsic_s_base = s->memmap[VIRT_IMSIC_S].base,
             .imsic_group_max_size = VIRT_IMSIC_GROUP_MAX_SIZE,
-            .irqchip_num_msis = VIRT_IRQCHIP_NUM_MSIS,
+            .irqchip_num_msis = s->num_msis,
             .aia_guests = s->aia_guests
         };
 
@@ -826,7 +826,7 @@ static void virt_machine_init(MachineState *machine)
                                              &s->memmap[VIRT_IMSIC_M],
                                              &s->memmap[VIRT_IMSIC_S],
                                              i, base_hartid, hart_count,
-                                             VIRT_IRQCHIP_NUM_MSIS,
+                                             s->num_msis,
                                              VIRT_IRQCHIP_NUM_PRIO_BITS);
         }
 
@@ -847,7 +847,7 @@ static void virt_machine_init(MachineState *machine)
 
     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
-                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
+                             s->num_sources, s->num_msis,
                              s->memmap[VIRT_APLIC_S].base,
                              s->memmap[VIRT_IMSIC_S].base,
                              s->aia_guests);
@@ -972,6 +972,7 @@ static void virt_machine_instance_init(Object *obj)
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
     s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
+    s->num_msis = VIRT_IRQCHIP_NUM_MSIS;
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9a..98e48ac894 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -66,6 +66,7 @@ struct RISCVVirtState {
     OnOffAuto iommu_sys;
     uint16_t pci_iommu_bdf;
     uint16_t num_sources;
+    uint16_t num_msis;
 };
 
 enum {

-- 
Git-157)


