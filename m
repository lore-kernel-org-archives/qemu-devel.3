Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C44BC48BC1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsSc-0001sq-Fq; Tue, 13 Feb 2024 08:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSQ-0001qP-Lm
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:19 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSN-00063x-Np
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:18 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d10ae127ffso6304221fa.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829452; x=1708434252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tP5MZohIYd0wVaYtS+mlCIb83dpcfafYILJYWOltnx8=;
 b=NR67svxfy4CVQ9Y3Ufhe2Buu/SXfQph6ViYpwJz9gf3V/ro6EAfhuvsjsTrjF12rK7
 Yor3ZLaRqDJuCKuazcdPzojN36oyMXQA0VcOFVxxpkApw/ymarkSKzs7iy1OpxhpOwe0
 +MgamQ/jI55QVDcCu9jll4t5cehi6XxMGcCe9IIed/XBMaU2HD27VTeB9RIAWL0JJM7Y
 JiPmdw6DCTh37skgELUK8DTz/MpE/EL6zzHu2i0P4Y+qGRKFT8CTGIC5bOwoa1z5xZOk
 cYtvntN3xZAqd+dBSyUMpC3guDyzfvsSsc4XddQjRs6qGFx0/zOveyPJx/OcxaH5q7VM
 VRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829452; x=1708434252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tP5MZohIYd0wVaYtS+mlCIb83dpcfafYILJYWOltnx8=;
 b=q3h6HKA8dAdakW0aWLr+Nc15ydzejM1/JYDBcYbOoFZm2cyAa9HVuG3RXD8pRcA3jW
 ESpc7g7j6t1yMvmIXAl+miw3QUMYlgGNjQUeUHkSB+Um2StHOV3ruZHtpWQcQIW1xxrd
 vnrih++jccbRAL0JZiW+Nb3uQVqU+rmJSulqU6UNdOucJAnkYDdJIGfHYiSsf9W6SnKB
 GGvdNLzD2JsPnm+gQwJGL/l2LZz4odha39y4oJVR7fHaa2yfdb8WOUGCHLPZLvwaQ/Kg
 HSXX3H/138QCkzLTQrD6xrLIaSSgY4+xxQCuWAVZH26tP77y1suFThTG1lTKRIC9kJ9m
 8IGQ==
X-Gm-Message-State: AOJu0YzlfjLgRdZNxqQpmKUEYoAAyhSr2jpYFsWLWwjzG7kI3qSX97Vr
 e0DnUiIyBV1mOWQIgyvgcEchL7N7O0oR7cjDgXnM+PxXgcleh/7TNmr4svnzPI7PwWbeROHL1Xa
 g
X-Google-Smtp-Source: AGHT+IH+R0sL4+6QcHy4som/HakATTbYidfEW1FF9ORTYpAcaSIbiG/7167QqttOcgPsfERR0wn+cg==
X-Received: by 2002:a2e:b8ca:0:b0:2d0:ce3c:5848 with SMTP id
 s10-20020a2eb8ca000000b002d0ce3c5848mr7125795ljp.51.1707829452257; 
 Tue, 13 Feb 2024 05:04:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUNc/1kZ+RlDRWhqliOhyerbcazasaX8PwLsgb/PcmLCzq5tltp5lVOb+0w+3h9qgI+39eNzsHMTrXljpK4ukoRvR9WyKtuY761oWVAL0MDIjcTRPqWwjFpvLmB8H1gkYc7ZKwd2xmfC4BzeZlhZyXazUXCrQc/3a61GiCMxYEOY16gLQTRQeLYaY8bvLJ+Y1l3qcis11l9D7y6CPc05llooWrVnYVQuCklXYDzgPiPtzaJqZXaKeGOC1KH/YUwVs9gC6F7K8UvqPqShtyaMM2UCOGWb8C6tFBW7Y2ekM1UbS1ycYgo7wjp/sk38rhA8nx18k3Th4LyA/KWdrK5fBSdIq6C4czoTAM2Hj793qc5ErovfhDNPPY0EuHyMl4pj1ZmOiapsTMY
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 jv23-20020a05600c571700b0040fdd7cbc8dsm11631611wmb.47.2024.02.13.05.04.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 04/12] hw/i386/q35: Realize LPC PCI function before
 accessing it
Date: Tue, 13 Feb 2024 14:03:33 +0100
Message-ID: <20240213130341.1793-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7ca3f465e0..b7c69d55d6 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -248,13 +248,13 @@ static void pc_q35_init(MachineState *machine)
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
-    qdev_prop_set_bit(DEVICE(lpc), "smm-enabled",
-                      x86_machine_is_smm_enabled(x86ms));
     lpc_dev = DEVICE(lpc);
+    qdev_prop_set_bit(lpc_dev, "smm-enabled",
+                      x86_machine_is_smm_enabled(x86ms));
+    pci_realize_and_unref(lpc, host_bus, &error_fatal);
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-- 
2.41.0


