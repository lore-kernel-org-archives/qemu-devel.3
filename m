Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F41C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjw-0002Re-S0; Wed, 15 Jan 2025 18:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCju-0002R8-L3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:59 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjt-0003vQ-0I
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:58 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so190541f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983435; x=1737588235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pE1WNLw0lJJVV/NGjFQTr49kafS0H/nFV3VfMQJlIvc=;
 b=PZn7bMJPl/ABxtXcmsaOp4h4imji9mdfZlPYJS/WgjlPD0d++xiijTxAxujhfOcxzZ
 6rb41xLi5xYj/boUKptspsSznjQFCJLZn07YD4CJGAd52/xFBIjCmdi+MMVyvAKBNglV
 ogtBmYazpcYqI9N1ESyhatga+9YOaEN5iU4v4AOfWlRsVF5ZyNYWrm6NrhqPbeENpcQQ
 UNG5MCN2eVnZeBASn3asFQEtf40OXoy3GrlNcHU0bRgPwDrtIDzwRfk7aInoXTbB58Ai
 cZ1RmRX+8Xbj3Rzmt3K3lXM5Z2j7JpjGHH5OD2BKKemDCVPnCqYCYDuNwzF2QIEj9BqQ
 nqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983435; x=1737588235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pE1WNLw0lJJVV/NGjFQTr49kafS0H/nFV3VfMQJlIvc=;
 b=aNEJfmUeyjnNvHM4TJ3aVcdNNSwZSNd3ZV2Hm4h0mzHb382zNQE+A8YP6L74eVduu6
 Kw2a9Tho9JyVT91Fp96ZQxWb0yRXB1znG2eATGHC3P2ZhX7OPWaB6CHLukCRiBzfituC
 K6G8xSybj8cO3/LiSlmWiO0jWrofgMuolf4vxTj+wxbR66XTT/fhv8ATWKhWvOUqEmkn
 aZA40WUpe3wsJTzfX8e5qABwQLUyXXSo1FOQUsBXDYw56ULFzs4YjGla4wLI37PqFrEk
 LaTejUf6VPSlM3ftOGSGvgL9+wJFRqc8XceportosrB9JMCDes9gRswnAgpdTkYF+WJM
 jsgw==
X-Gm-Message-State: AOJu0YyE1QyORJGdWArd//mwve1DJZvElqnkmHfclfwjCE5kNVr2EriX
 OJ/zxsDoulkVWe3x3HG6dUik48+2UQLZbo8EtnqU4sNXn4D/0IAGvC4d/wcgUZQ8q7Uvf182lGR
 MlsM=
X-Gm-Gg: ASbGncsaLho5RmChfnao0ge/TG2MneOVfGr76XmZqhc5r8e5I1g/2uU0JgRcOWdrd3O
 sO+i/CaIA8/jfbiHt8korHzAiBA5nqpiuXb9Y/zXhNWk5OqhY5T8GtajGcDkS5imiFgHuEHq400
 +bxu9+/zSZlN+UOagWqjv9ofaNRqBDsFlpj1iA636OH0FF7HlTCZqghtztZ4tznV0eAq7Iw5iiE
 OASmCVHSOnIBEOgXdBeJD+vbDhGiMAHGaNRctE//ATrn9qwxDQmcpo406bg6hb1EplAp/wTW9/e
 nGETaiGFiT7fhDq00VVd3Wrrkofk/Pw=
X-Google-Smtp-Source: AGHT+IHAuUG14J19X0M488oc/IPw0mfuW9c9Lp/nrvzWxb26Og7/l/wPyoIeYwLZI54Gv6UtEBEy/w==
X-Received: by 2002:a5d:6d89:0:b0:38a:8ace:85e8 with SMTP id
 ffacd0b85a97d-38a8ace860fmr28733787f8f.44.1736983435361; 
 Wed, 15 Jan 2025 15:23:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm19148272f8f.97.2025.01.15.15.23.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 12/21] hw/i386/x86: Remove X86MachineClass::save_tsc_khz field
Date: Thu, 16 Jan 2025 00:22:38 +0100
Message-ID: <20250115232247.30364-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The X86MachineClass::save_tsc_khz boolean was only used
by the pc-q35-2.5 and pc-i440fx-2.5 machines, which got
removed. Remove it and simplify tsc_khz_needed().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h | 5 -----
 hw/i386/x86.c         | 1 -
 target/i386/machine.c | 5 ++---
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e6..29ffa1f450e 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -27,13 +27,8 @@
 #include "qom/object.h"
 
 struct X86MachineClass {
-    /*< private >*/
     MachineClass parent;
 
-    /*< public >*/
-
-    /* TSC rate migration: */
-    bool save_tsc_khz;
     /* use DMA capable linuxboot option rom */
     bool fwcfg_dma_enabled;
     /* CPU and apic information: */
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 69bfc00b9a5..57014863936 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,7 +382,6 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index d9d4f25d1a2..417cb4cd7f9 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1060,9 +1060,8 @@ static bool tsc_khz_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(mc);
-    return env->tsc_khz && x86mc->save_tsc_khz;
+
+    return env->tsc_khz;
 }
 
 static const VMStateDescription vmstate_tsc_khz = {
-- 
2.47.1


