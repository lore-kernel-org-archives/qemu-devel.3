Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8711FE7716A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 00:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMzJJ-0001O0-F5; Sun, 15 Dec 2024 19:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzJG-0001KI-Fq
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:50:06 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzJA-00075b-Ne
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:50:03 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso2789831b3a.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 16:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734310198; x=1734914998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/txMo+Nnraz9AAcWBO+Ht1SEClLczXwE0l/xGp309E0=;
 b=ZQ79rw5yMoXteReU93aya5jSGkqUHK8c1CM55eWycUxoGivb/ogC47OWoNXa57fSyW
 r340yCGHSX3g0vPhdtXNPsrpiuLtJTPEpY7ljMAL1w0ARycHzkMdR+uH4FHTiMeECE2C
 ckwOR5ZiPaD7CB4axXb6UAX4SuwfuEUT0jToKFFsqxkQMxEi4djVVkUpQQdru64LDJ11
 aRX6AiAE8bOFMvjLOvgHYpDyzUgt/vFpdMHhbzzGRYFSivJTlB7BtDwiLrhuJr9e67L0
 YumdacWErYtx3+UoGRdQBiQjrmxXuWGg/eYCz7RWisFfYpvWBtsHRog+n9loLv9P1Z8P
 jouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734310198; x=1734914998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/txMo+Nnraz9AAcWBO+Ht1SEClLczXwE0l/xGp309E0=;
 b=TxYlVTsR4rJLMza8+sL75Uhz6mSJvviZmX2LbThnp8AvkM83uKXHsCxyqO+b3xNNDZ
 UXA0+7wpKzPszXANgmCzk7A/1w+5Q2WBcbyg6Qv/gDAlDAZdDld/Tey/heU7w/8v0Gxq
 dlt8/mWXuFO/RZwpJH4Ci/k8b8WNB2+pJYh7JDw1NrB0RGpw41gB11WSYaoYiFI1k1qt
 aZdVZKXA1Jk90zL5A7hGPr3EVExUiEdRphhiA/JEEvEzevNxz+60ITK2PVG3s14ex90v
 0vj3xXI5TcZJSsiYNujvltPk2fCthaCagKhSpPW8PbfUxNfiyGSLLvk+KteGDxhZqp80
 BDJA==
X-Gm-Message-State: AOJu0YyJITMtqfNDe+j8Ux1oh9Le6LqpKexKYz1BQ0BZ9YcHzJqxUWYl
 Ssr6bWJIPkdWLg9pznm5sZU8DdBBnHs15s7cy6NbfecMPwDu5WFKIdG0W933/NX+q2rfjfV2JEX
 vszcVSJUiHcB7I/okRPeZatmj/84L/wo8D9du/y0RgKwL6lBwSFO6n4/nWaKiEzmoJfnUrfcZS4
 XpyJbCj93/cRGMApd0A+jw9n574EhSQoTgMlyn6zqW1Q5Kmjs=
X-Gm-Gg: ASbGncvCCa7ohwFFJQqxf1XikiTCJfRqzIZazj7uJKTd9+4D1hk8omlQ/R7+ssvvmJk
 PMay7uwihuSMxj0CDqwokor8uVSP/HPhbiG7uby9te2asyK4kBeSuukfihoAAiRrDOfqNRBU2vS
 u5Q1BqOX25SwMSM4zAzRngWuTHKOXnnL4I2azUIgZ4buh4nt1EJNggLGBu58i0vRHkyXSqMg3I3
 pO0d+3Q8kyqGBchOQ11Zt/+Yj1ISiVrDwloWJq6qkDroVLR47f23BEV/EEoyvaGhHmdlgBA54G9
 AmwH7rNA
X-Google-Smtp-Source: AGHT+IG7C/z9lqXQKhZELwgwHH6ev+PqxHmUpUtpuDtnyBnjuDPC1LlZ9b9OL21KR951RrunYjL69Q==
X-Received: by 2002:a05:6a20:9f05:b0:1e0:cf9a:87b1 with SMTP id
 adf61e73a8af0-1e1dfbfbcbemr15265933637.6.1734310197718; 
 Sun, 15 Dec 2024 16:49:57 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5addbf9sm3059586a12.47.2024.12.15.16.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 16:49:57 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...),
 Jason Chien <jason.chien@sifive.com>
Subject: [RFC PATCH 4/6] hw/riscv/riscv-iommu: Allow PCI hosts with iommu_ops
 registered connecting to the IOMMU
Date: Mon, 16 Dec 2024 08:48:55 +0800
Message-ID: <20241216004857.9367-5-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241216004857.9367-1-jason.chien@sifive.com>
References: <20241216004857.9367-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x42b.google.com
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

pci_setup_iommu_downstream_mem() is called to set the downstream memory
region of the PCIe devices.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/riscv/riscv-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index e9a0775d6e..f5d53a36b2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2436,6 +2436,14 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
         QLIST_INSERT_AFTER(last, iommu, iommus);
     } else if (!bus->iommu_ops && !bus->iommu_opaque) {
         pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
+    } else if (bus->iommu_ops && bus->iommu_ops->set_memory_region) {
+        /*
+         * TODO:
+         * All memory transactions of this bus will be directed to this AS.
+         * We need to distinguish the source device dynamically.
+         */
+        AddressSpace *as = riscv_iommu_space(iommu, 0);
+        pci_setup_iommu_downstream_mem(bus, as->root);
     } else {
         error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
             pci_bus_num(bus));
-- 
2.43.2


