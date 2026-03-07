Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C29FCB638
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytZC-0006J9-Bq; Sat, 07 Mar 2026 10:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytZA-00067e-DW
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:44 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytZ8-00087v-Nx
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so159515e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897260; x=1773502060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ed60oJ9++GzKnqTVaAPhSrwDc/0rjw+3z9nRpzV/t90=;
 b=W3xVFGlNgBMflQIBcagAg5vVnQJs/JVyQlRwxnCQArd7J5Oc6dQtBMjkOT5cQG5Zdk
 bGYPG63FZip877DyZ1q1KyTUdmo0tFm/HkREVy5UszCOsbEZNYrEKY/oEWF1/4X2dMLF
 ffSqpkHwC6kiPHaS7TVs4aMX3OB0O5aAl848ZLPLZ1DvjufuQkxBnB0X4KMHiPlo3+Ki
 6NCFhrE48fn7uCgjMpWkHo3Zp/NWYgFMgFy+7+3E1LrVdTUoYv+qTW71okveofNIYppw
 NWVi+KrxsATWHBiVTpyoZNT0Ty0JU1P0wtTzJrzK53+6ulGQ5tvl6PjQS83vMlDSk4TU
 C3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897260; x=1773502060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ed60oJ9++GzKnqTVaAPhSrwDc/0rjw+3z9nRpzV/t90=;
 b=rMj2DYDw0yi91f+zLss78QIJ9Ex4rrwc3SzOewnhRWNoMYU90veP5/fjWFxdIKVp0n
 48n5M8NxKZJ7XCoYdxzlEPuu6tNIuUfb7UnZA8DFPQmKx2PhuDOaBa3fzG/6d3O7rU/b
 HRiEMqTdj4vNt8aAzhUMHkxwlBkhQdA6T9NUdRkWhKaGnBygi0S0NL/dDQxuDlp+M/9P
 75lNXP89FjsWbh8HNTAeMTJFQxtIaTqXW8ZjOlfhah5iARuIT3SQVsvDxDHS9GpgR7n1
 NIiWpiRkfLgQS/p2nPcsxGMnl7sJlzbsqZg8EwFg+u9hB3admZhQ7gsFxtKF7p9K546F
 TXcg==
X-Gm-Message-State: AOJu0YxYPtUyOSngI+dbtzx1VgUOQ8u6HsHxFu22n4IqCzLVDRk96dQ/
 LJz1RUk98HOybwITPrGEW/SnI54c4gyOvP8L9snYZsmHMqeUysT+UhxipI6dEZQtRY5cXrWW8zQ
 UVJiSa0g=
X-Gm-Gg: ATEYQzye6pI86czTHYijmyHXD+hxjqrYapfRIiDBZixIyGN6Rp2guiRgXBFH4uHmd28
 piX+z9ijUDn8QGIK2bnluMVbU8QtTG7beYm5/tF3IQLiEqE06mor0r5AKMb7RokL27BK2VrG1RR
 1KibEl/CkJL849Jw/Ej6O+/iD2UXI5VskvF+71ubkm09pmEQvdQ474+25mar9quL+fSwcZ7xr3N
 /f1BZUYUQgn7nP3qDys5HsvEBDJinTEpHBpHI0ba4IXsfWtk3RPYAfL7Yn5OzkMpuCvghqv8Sdq
 xfG812W0+7DISt8YOzXmvyB2UPdJWCpkbEpYetToGX1C9dYiGf3toCE3x1GKwt20DRwT1j0P7bZ
 6B2dAXmHy7WWvTGL+mjZUr4QH5AjHZC00/wt26wNFx5aExJrbVIlZMMkXd4sSIYztEn8IRmuvVp
 p7cMC6A8rqG32dZDif01jvKjvH5FVTHQiXkBjhcWJujQ+D2ZHFirMD6OlG7G/eBUJkA6DHhIz8
X-Received: by 2002:a05:600c:500d:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-4852695b9f7mr96612415e9.16.1772897260438; 
 Sat, 07 Mar 2026 07:27:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276bc6bbsm113721785e9.15.2026.03.07.07.27.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:27:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 09/10] hw/pci-bridge/pcie_rp: Remove PCIESlot::disable_acs
 field
Date: Sat,  7 Mar 2026 16:26:33 +0100
Message-ID: <20260307152635.83893-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The PCIESlot::disable_acs boolean was only set in the
hw_compat_3_1[] array, via the 'disable-acs=true' property.
We removed all machines using that array, lets remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pcie_port.h     | 3 ---
 hw/pci-bridge/pcie_root_port.c | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 53cd64c5edf..b28af067a66 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -60,9 +60,6 @@ struct PCIESlot {
     PCIExpLinkWidth width;
     bool flitmode;
 
-    /* Disable ACS (really for a pcie_root_port) */
-    bool        disable_acs;
-
     /* Indicates whether any type of hot-plug is allowed on the slot */
     bool        hotplug;
 
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index fe3ced56851..7c3e78010b4 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -117,7 +117,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
     pcie_aer_root_init(d);
     rp_aer_vector_update(d);
 
-    if (rpc->acs_offset && !s->disable_acs) {
+    if (rpc->acs_offset) {
         pcie_acs_init(d, rpc->acs_offset);
     }
     return;
@@ -151,7 +151,6 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
 };
 
 static void rp_instance_post_init(Object *obj)
-- 
2.52.0


