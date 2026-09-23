Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07167C9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9My2-00024l-Qo; Wed, 23 Sep 2026 09:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mv5-00037l-9m
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:22:00 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mv2-0007d4-FB
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:21:55 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-328664d3421so561262eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169710; x=1790774510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RGdh00utr6Q+OpO6+8fa0s0hS8SKHylDK/Tx/Y6cmu0=;
 b=cDDfpBCySBH32oiRMbbc3wET7+qAmSUbgRgPbREKfLnwc8Zx+7WVgGLof5BQPPrZxI
 eU98aNmX3P9/z5jzjdUjnfMB60sSF2uu1Wb4jmf0xj+7zPNuVdKKqspWUc+JSvIDvk7n
 dDlZHS8+M/3PLQNkysmhzIB0QL/dODTpTWZJdNgV1OQ2hrBaq/mvYR90hcSKPQK6vGV+
 YcQsaQVj+V3o6z8TdOlxBj8M0GGDZjvocOA50pZA/X0XVA89hHcVrCvX/SKVzZflQQCf
 BuG8y1akNEzv4pHoJAJz52vSR4ESpsNwTlj9ij/W4FWKI/EGG2s+GeecRznq2642U1XX
 GlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169710; x=1790774510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RGdh00utr6Q+OpO6+8fa0s0hS8SKHylDK/Tx/Y6cmu0=;
 b=Gy2QHFOYWoNGuJDngk7VWIkdocelFN4vHJTB1UaHCNyDf/mATsz3Vw0F+/xy34MKuL
 7+77kfUC7SduQNazx2xaLLhyv938t+paXz2d1xiUROtUxtEigsgU6Pg6d/dsPsNWmXxP
 8vH2bstecJSf072dj4HaI3ojNgmdYxshVaOWiAQDEEE5PRlrBLPUv0WNwKkoKtXxTDAm
 y6+rB4MqafprjgqzLkRdczEv27ICscHXIQWvlpZ43y08y0yYs2ESZ2/toDNlI498Usfr
 8TafIywKAoAQgceUEY/dhWitEIsV4y2SVk8lD+LXxf6JX8H7C3xjx3ow2ql7eKjAkzu6
 xTxw==
X-Gm-Message-State: AFuF++khyA6CDZb+/4d3mw0G6n6WPw09dwdSy7wYAuHVA77cnJdLusSw
 Z4huJ3OXSauOcBr2Z59Lqy72u2459vtJ0kW9wR2kiRUvQ3MUDT87n7sik6NuQqe2RZQ=
X-Gm-Gg: AYBFou17ZvAuZs4deGz3D3SU9xjn27WfMrxItOX6xczPiRc6ls5dDygFkiCWLlQLEqu
 KRFpi2huuogRq3WZuIJdIE1VSR87c54moVxJn3BY209kXJhhY5YZIIVUIHzTH4VKjFy9V3zpSyz
 Vt8CpLEwNOm90Tk9+/UdQ5REGW/USDTZqKkX8R1nNR3RVicBNIUEzz4QHKwCc0tcGbwsEUvIQBm
 l2jskhPP4dDDCkwFPqMEBZP2BazFb0SsWWSOWcwDQ9mQkknmuOebn9FVPsUF2bVHGzIODHljyie
 v0ZS8XmqY6iDDsfX2i7ZEVS8c00gGTnxNnmTnRPkTLbueocc2EbcPKTaFwezFbvv2bKBx4vCaKa
 s74sEcA/nMuuStiimI+i4xdxOY73hPcYpgjKXgqz0PfaMQPqVQ/oLeZtQgI2OIx/CVFdYlTDsVU
 AWvOuKFt8c+e0tmeVwQWxBYFHb0cPfACjN/5smaDN9tTZgPhHY0PgQ1ak8JLVR7l20h1yx25gjz
 PynMs3KYQBsIEak4xACSoN3oUKrvG8=
X-Received: by 2002:a05:693c:88d4:10b0:33b:dcbc:6046 with SMTP id
 5a478bee46e88-33e8bc70ee6mr2596067eec.7.1790169709341; 
 Wed, 23 Sep 2026 06:21:49 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:21:48 -0700 (PDT)
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
Subject: [PATCH v3 029/114] hw/intc: send IMSIC MSI via kvm_irqchip_send_msi()
Date: Wed, 23 Sep 2026 21:15:03 +0800
Message-ID: <20260923131635.1894-30-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
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

- Drop the CONFIG_KVM ioctl path and call kvm_irqchip_send_msi() when
  KVM and an in-kernel irqchip are enabled.
---
 hw/intc/riscv_imsic.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 30fb60cc312..033b7813060 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -311,19 +311,15 @@ static void riscv_imsic_write(void *opaque, hwaddr addr, uint64_t value,
         goto err;
     }
 
-#if defined(CONFIG_KVM)
-    if (kvm_irqchip_in_kernel()) {
-        struct kvm_msi msi;
-
-        msi.address_lo = extract64(imsic->mmio.addr + addr, 0, 32);
-        msi.address_hi = extract64(imsic->mmio.addr + addr, 32, 32);
-        msi.data = le32_to_cpu(value);
-
-        kvm_vm_ioctl(kvm_state, KVM_SIGNAL_MSI, &msi);
+    if (kvm_enabled() && kvm_irqchip_in_kernel()) {
+        MSIMessage msg = {
+            .address = imsic->mmio.addr + addr,
+            .data = (uint32_t)value,
+        };
 
+        kvm_irqchip_send_msi(kvm_state, msg);
         return;
     }
-#endif
 
     /* Writes only supported for MSI little-endian registers */
     page = addr >> IMSIC_MMIO_PAGE_SHIFT;
-- 
2.52.0.windows.1


