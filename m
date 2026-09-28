Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDBECA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBACK-0002bp-My; Mon, 28 Sep 2026 08:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan260699@gmail.com>)
 id 1xB4W8-0005Ll-O1
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:07:14 -0400
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan260699@gmail.com>)
 id 1xB4W5-0004Pa-EA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:07:12 -0400
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso18796675e9.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 23:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790575628; x=1791180428;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+pW1EFE25rYVVX/ykHFItI/J/UlMh+qjOL7y5z0hrqM=;
 b=Zx9cEurzRkBpPxSpOlHsD3AJdIMYvQT6ip1QAlKU4BRP0cZ+kA7MAGkY1gZI6bwJdn
 2yIoOt88+kwWwYJe89xg4o32mrifc50/bCJ2opRuS1cxE9F7h77Xsgp5F44a0GDGXzwe
 bxq9Cnur2gPDDiuBWtdHdyAzbrmetjIftku4JgeJsRNFhHamg3W3kZ+64sdOqJ+8Q23c
 RHe6osi7qdLYcLQDKIIe6uB3LYtAmrAEci8I1dPNyrtHGsAPJCYRNMwcdvK5LbgZtqEF
 0qdnF+k7fnGHQiLHJPOlfDch7BpNsGrSH4gP378XVg3WwW8xPZ4qmDUmy5U0mN/DPWcH
 ISNA==
X-Gm-Message-State: AFuF++n0aT3rl81YdoOFIS1zMeNhceGbPwLRiEf307VQHKw7yhFUTj/f
 t9aLpQd5AkjQ52V5MXGiWMVAp4s9IcUEmTPr6jSl+B+C1zOC4qNA8GmM
X-Gm-Gg: AYBFou1q6F3unHixbn4MiaOeZqlfaTbrGhLnCoqm0HrE4WHwUx32wx71E4OvVHXJht/
 5ftBp4lTuXNsa8cNFXycbcciZxTKHg9DGBL/8ogiMhQmYw+6X+z17lZI1XGoBVf38+v1Y4AvBfo
 gMjdapUpTv4JXM5PV3BX6Jtu78GrAGr4lJr0zqtTxLWIdVOp6nhuh/bN+G2GSGgK4RQmLB1hMo/
 wM74lSeofcibINqRKeUvw85b0liu0nLPuXvaHndFwiTgCJBYdpd+Yh7Y+Dv+YKODxcZhPSBeXID
 mdfNOwdyt7QmxAn8OVS/jhbLIJRnA3FrEh1w1dMdoerwuUuwrtqMrvOxuSsNCHRAyfuDqTCC/bs
 hGIkaPTIwp3zWqbDCKUKa/d3vKkgevq7OWZpuEEp3ppZKJDe4nETmodgOPyDR46QMkD1FtBuuxQ
 Qvuxnc4dAwbXipWi/30AgwaIif0EkpgaOVcdfZV2ImOYAQfm2hi+l0HXraRlYdHbsKVSH/4KMYy
 X7fW6PI0RaIspv1iu5cQhQPeQlq
X-Received: by 2002:a05:600c:3494:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-49fff7399f4mr63284515e9.18.1790575627904; 
 Sun, 27 Sep 2026 23:07:07 -0700 (PDT)
Received: from mac.fritz.box ([2a05:fa40:300:1a00:d105:6a41:99ee:cbff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a008f7f1c2sm1325775e9.1.2026.09.27.23.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 23:07:07 -0700 (PDT)
Date: Mon, 28 Sep 2026 08:06:39 +0200
Subject: [PATCH 4/4] hw/riscv/virt: Limit interrupt identities to what KVM
 AIA supports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-spacemit-k3-v1-4-8c57d0596b87@butz.st>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790575623; l=3577;
 i=mail@butz.st; h=from:subject:message-id;
 bh=zco9IcETS7x9MDnAKzoLsHBGgCpQ+QrZXh6rm0qqZlc=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBAOJW8yHG2FdKcC8jiWoQyd2Z6
 SNHh+aJB0RLkH7BFF7Yy7MymfE5UJE2mmoucIa3HiNQdlVZjgqLY7wph/VSM4kniDO57IG9Q9jN
 x96oOAzzWWJEVrh8vlxRGXatNy8ywcO9WExvzLop5s2ddP08f0Wrzn/55mpqoLJyoKaIbk10kxz
 JW1GONHT8nsNvBpVB2lnzA2jhv7DC79UlHzA98+sp8eX6kmUips+9LpTJLDeVna8f/vwkU708PI
 Qxt/5nhmFXKj/su/CMFivCLHckdmMOem/4UNoTyRcAbcoFQ9WWyYHvAD/bRuYZVEA2hfoBEQVu2
 FGHdG/OimvbT/GseVmWjiw7WV9HUOJJawVmfoTEJynX9BbV+VNMKZVpW5YaAaps6/KOC7V2bM7P
 hvORUmj3b8eUr418GYC3M4rLJtrj6Vu2cUyTV9Q5dvq9Lg2TIj/jpbEWpOqn2FSGkQcLvcDksNk
 jOSGmdG4h+OJ3vbGrva5UCJF/KIyuV4ozlSU7awAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgCvOxGyd1iT/JPJIDrH6VyKGSxzkgZ7WMRUVlXj9yKL5Wx3JI
 UsaxcuYaGcl/GjEUbVSp48bD7dqN1jAbjEsqURvO1MVxK8+vvfn3o6nBe/8UQAShKJ6aKuI1arz
 8BjuL//smisUCq8m2q42fkFAiE/5bPDzMzIkkO17dMGwXMWGF1k2c9fqCbIsCZPSqkW3GvSiDFb
 wLLOBzqhp/IoC1H5HWmLiMUUW5fdA8kaQFDF6ChoXP8ndkiQA8C+lNP+PLAxnfHm9PwHILgClx7
 Zvnck0IX+VVq5tm3JJjxUXYktLxrZWO7JvVPGAGKtEO/Pn8d1EgJweae/GPGzmDJtXTdldxgig1
 uZWgSrD+WGj/rJUAvZq68cXz7JwkJyLnPmMgXF9/q+6DbZ+xuZ5ETfFytEO/vZNS+bf9OSiiH9y
 bhPp94+qhnTxqi72wnggHmaxZ1dbe/xtZq6Dn2tExsftxiZI2Q77yeHPOKyrVG10RJ3icmonRui
 9xzo/WXym3QiWGQ==
X-Developer-Key: i=mail@butz.st; a=openssh;
 fpr=SHA256:jcZFBs39daoQJIontO/rJaVachWp/oqTbhNpQk8+REQ
Received-SPF: pass client-ip=74.125.225.141;
 envelope-from=stefan260699@gmail.com; helo=mail-wm2-f13.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:10:56 -0400
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

The number of interrupt identities supported by the host's KVM AIA
is limited. On Spacemit K3 and Tenstorrent Atlantis to 63.
virt machine alwayas aks for 255 identities, so it fails if on those
platforms.

Read and apply host limit from KVM AIA device and apply.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4599

Signed-off-by: Stefan Butz <mail@butz.st>
---
 hw/riscv/virt.c              | 12 +++++++++++-
 target/riscv/kvm/kvm-cpu.c   | 16 ++++++++++++++++
 target/riscv/kvm/kvm-stub.c  |  5 +++++
 target/riscv/kvm/kvm_riscv.h |  1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 28fa31d538..2af85ec5c3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -78,6 +78,16 @@ static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
     return riscv_use_emulated_aplic(msimode);
 }
 
+static void virt_kvm_aia_create(RISCVVirtState *s)
+{
+    kvm_riscv_aia_create();
+
+    s->num_msis = MIN(s->num_msis, kvm_riscv_aia_get_num_ids());
+    if (!virt_use_emulated_aplic(s->aia_type)) {
+        s->num_sources = MIN(s->num_sources, s->num_msis);
+    }
+}
+
 static bool virt_aclint_allowed(void)
 {
     return tcg_enabled() || qtest_enabled();
@@ -734,7 +744,7 @@ static void virt_machine_init(MachineState *machine)
     }
 
     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
-        kvm_riscv_aia_create();
+        virt_kvm_aia_create(s);
     }
 
     /* Initialize sockets */
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1098581e7a..0409af3255 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1870,6 +1870,22 @@ void kvm_riscv_aia_create(void)
     }
 }
 
+uint64_t kvm_riscv_aia_get_num_ids(void)
+{
+    uint64_t num_ids;
+    int ret;
+
+    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
+                            &num_ids, false, NULL);
+    if (ret < 0) {
+        error_report("KVM AIA: failed to get number of msi");
+        exit(1);
+    }
+
+    return num_ids;
+}
+
 void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
                         uint64_t aia_irq_num, uint64_t aia_msi_num,
                         uint64_t aplic_base, uint64_t imsic_base,
diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
index 672f635b08..f5f5418b3c 100644
--- a/target/riscv/kvm/kvm-stub.c
+++ b/target/riscv/kvm/kvm-stub.c
@@ -14,6 +14,11 @@ void kvm_riscv_aia_create(void)
     g_assert_not_reached();
 }
 
+uint64_t kvm_riscv_aia_get_num_ids(void)
+{
+    g_assert_not_reached();
+}
+
 void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
                         uint64_t aia_irq_num, uint64_t aia_msi_num,
                         uint64_t aplic_base, uint64_t imsic_base,
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 532e42b0df..d8ae73fa1e 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -24,6 +24,7 @@
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 void kvm_riscv_aia_create(void);
+uint64_t kvm_riscv_aia_get_num_ids(void);
 void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
                         uint64_t aia_irq_num, uint64_t aia_msi_num,
                         uint64_t aplic_base, uint64_t imsic_base,

-- 
Git-157)


