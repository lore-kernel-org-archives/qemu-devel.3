Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896B7E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX57I-0005sh-Ux; Sun, 12 Jan 2025 16:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55e-0004Ya-UU
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:56 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55a-0006Qk-PC
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:46 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so652975766b.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736715701; x=1737320501;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCll5w6Y3h75LA54Ck5Ksah/JGL+Wp/RXIpJEp+i2Ls=;
 b=U9MgSGwRL+lDEenQJfaZi7o3GhyffHiKB6zA1KqA74QfKPxEFIsUJnvWyHpVagpwzN
 IAmwH022JqfRbkARA6rGGXKf3asGfQYqq+l3vPBdavgUL9+94NP6aP3cOVEHqGxhIjZu
 eYPVWU/8rSL4ZCWEpmtFiSJJAkaMZi71LERrUsEdbRL8mCftcl0SxNa2qi3JFiOqqvVL
 uLLtQahT6U1qa+5MGvc1Jrip1I1x/sX5dHjHGWjiFCrxE2TI1Keh8sIxO1m5PgPBHdG7
 DD6gkTqxIe9QNwpzHj+9GSL7WaJUq7kxly54U9nJjUqFJNuKrZoE6PuV32ADdGHpGdr2
 OZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736715701; x=1737320501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCll5w6Y3h75LA54Ck5Ksah/JGL+Wp/RXIpJEp+i2Ls=;
 b=sY0Sgfmqru/MHwHGzkUTZyZHKesZp1S8jwBF4YIMoUMO5ZG2d0721vYL/6MsPPnnML
 m0ffJRyxsCE8ryLY6skSQi7T/chyDkWkJ5DfWv+QidE/rw2u9RqkCIvXKlihFLVo9wtF
 vLHohG5PJS9GGjtTZ5xJqOMlKyvoLPcIuv7Kx7LXX3szDZuTnGNOgA8ajwBPgCvB81Jf
 rhZhjJqtizU+J73tkbXAOxmBkyNQW/pJYGQrtoQZwZrQaCxlSWrcUn6BymQdEXz+8I0z
 nnk1aGdq5/EgvozZ3gSnHICGXfutXN0xL25UdgVavcyy58LW6vQhPNzotwe1BWe6TG/d
 NZoQ==
X-Gm-Message-State: AOJu0YymdzuzoWmc7ItX+Ure3R0XbdEFEePqH8LRDVHZ46k/elLvwju4
 yh3Y+wKy2da02UAxiVLDy4R+97U0+ixJEJCylgf3Sa8Z/3Hi/sJqIZnh3H8aoxbuPe+xICnZwDt
 a4Q==
X-Gm-Gg: ASbGncu7zkm2iM4lOiD49+dZjW+mUcQE+bxHRdwOa968UnzEnsfcrwOcQJAQil9Fm3H
 R6G+zvJAsVtzmumh+w0nBrxRrkoyX5CMuNEBNxQXA8/g7LPj+71Krb5f0zc05m/JXbgPVHCO/6o
 pBVZvetFfXZgnceaHVyX1Oz3J4zAWkGqfq3KnzYi1CMCo/bSQlTUpSnwKA3oj12Rc1TefFUVHpa
 repPrshrtMYo4zIp2mM5g3rBpvl63i7tUrMVvA/BpUvpIPoapSRPlGqoaeVaakVNylW2soDXjsM
 upfkfGxA3LYkx3EmPWVkpaDvgY3yi5LB
X-Google-Smtp-Source: AGHT+IEZSE8Sv/rn3O3ua1pB7MRufezn9UA8mQk4YQCBv1ZMeEdD6WVmYa08/QSfrgpE1nAX29VTMw==
X-Received: by 2002:a17:907:3f92:b0:aa6:5d30:d974 with SMTP id
 a640c23a62f3a-ab2ab6fdb8cmr1617214166b.28.1736715701176; 
 Sun, 12 Jan 2025 13:01:41 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e283sm418276666b.31.2025.01.12.13.01.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:01:40 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@linaro.org,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org
Subject: [PATCH v17 10/11] hw/intc: Remove TCG dependency on ARM_GICV3
Date: Sun, 12 Jan 2025 22:00:55 +0100
Message-Id: <20250112210056.16658-11-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112210056.16658-1-phil@philjordan.eu>
References: <20250112210056.16658-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::636;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x636.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The TYPE_ARM_GICV3 model doesn't have any particular
dependency on TCG, remove it. Rename the Kconfig selector
ARM_GICV3_TCG -> ARM_GICV3.

Fixes: a8a5546798c ("hw/intc/arm_gicv3: Introduce CONFIG_ARM_GIC_TCG Kconfig selector")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/intc/Kconfig     | 6 +++---
 hw/intc/meson.build | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index dd405bdb5d..7547528f2c 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -23,13 +23,13 @@ config APIC
 
 config ARM_GIC
     bool
-    select ARM_GICV3_TCG if TCG
+    select ARM_GICV3 if TCG
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN
 
-config ARM_GICV3_TCG
+config ARM_GICV3
     bool
-    depends on ARM_GIC && TCG
+    depends on ARM_GIC
 
 config ARM_GIC_KVM
     bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 510fdfb688..602da304b0 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -6,7 +6,7 @@ system_ss.add(when: 'CONFIG_ARM_GIC', if_true: files(
   'arm_gicv3_common.c',
   'arm_gicv3_its_common.c',
 ))
-system_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files(
+system_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files(
   'arm_gicv3.c',
   'arm_gicv3_dist.c',
   'arm_gicv3_its.c',
@@ -39,7 +39,7 @@ endif
 
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
-specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cpuif.c'))
+specific_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
-- 
2.39.5 (Apple Git-154)


