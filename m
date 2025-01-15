Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322B9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCkp-0004pc-Iv; Wed, 15 Jan 2025 18:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkX-0004fL-44
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkV-00041b-Aj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f796586so2175025e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983473; x=1737588273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6gCnpU/Y2GXgiWgcA00csT8poFSxQKI6kWtg9WbUPU=;
 b=VyKEaqAO5+yrqNd/ChEPmXyiA6POXJRvTv6GLkyCrSzhlAp19u8Mc0BpcFvjquWcre
 OpnaZ4Ro0PchTsiuwFzt2IKJConQBzhDAqNH+xXfVDaxpOVv9qWY0IcHKs7Bz0yiuQJf
 W0xlQJE8Kh5XPMXtjVQpjKsvHM9PJzZQftENZU7O9jLCDp6Jhswf8F0W1zyBG7ckkPdt
 Zy2XjW1gxKGuzqrp2U2BPB9nI6SUbigoiojaz+VrDZa6hLk4n/QFKP85tUAc4+rDcR0L
 DJiCc4ubO4ekvcgqvLIsBO4kO06MgDC321NIkReov3nENLVZl9sV3l9NNzWRXxiOiLPD
 EYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983473; x=1737588273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6gCnpU/Y2GXgiWgcA00csT8poFSxQKI6kWtg9WbUPU=;
 b=bk+Av/JTlc2JheMn2CQNstVKEjAMnHvT2eYpdjmsWbcf/JrmSJx+8PaLcahGvZESuy
 7WiTecgyYxJkCU3HkKlqKdgP+iFl7Kwx62/2ue1XEl4z/+pWMT2mWCqB4h/QgBy3dBzF
 dj8fFEVYjGDG2wmHt/89y1PeX9xb/kspIbEiMkzuyUXUWSGZgjpub76HfC/8bs1L4eks
 44AfD8+y8FQATdCP6iwiG2Iy9O4lnRJ/lG8QOg9zcJes+vEj5d3nkRwGf2XLmJayJGox
 3GVkO6S2YikawkU61TWyiv0sV2znfyV3f1OofsdNAO25XnC7A+HPX1e7oKd6FNG+1g3z
 EU4g==
X-Gm-Message-State: AOJu0YxZckhFgZH/EuizF5AFyL+OTUVYlUKRoX+98VHbIG0zSXuxK5T0
 g1UACLNNyYjOITe6ycOZ0wXd6Y7/yYtkDQLFQqPoSU43sZkWtwmfI9VZMRml77jF6Sl8WoB8jhR
 2rv0=
X-Gm-Gg: ASbGncu75roznS1NUk+PgDv7EAZ6bkvtHgdtoxk0/uG0FshkQxaTZuG6aQR7bfRRIxz
 oZaU+FAOAmzzFNkWIm5f/bOeB3yXLYl4RNCFGACsdMJCNsKrcEyRPrghBuvGJMeY3PR1myGLTr4
 PY/il4kHbFMTJw2eaVCbHz/D4BwvniYprQAcse9gNpVVoQz/y5xqQ1m9Edmwvmry8UuIoJ1URDr
 xYaZJhFvd4hhyiUmwBr5dV1kHJHaD7buI5MRhIPuPlnc4v6D2CXunhEXpZ6uVPzPwGwaaJORJbM
 4bd43zBS/ObtfKmvKiDV9NA751+Du8g=
X-Google-Smtp-Source: AGHT+IHj3acvcSkeilY24aLkNF+xUq1J6OMmZLhHQRhAMjWTdkVXm/kSsLb70NUg4uFDaOuTeMu9eg==
X-Received: by 2002:a05:600c:1c1a:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-436e2679a94mr310444315e9.7.1736983473309; 
 Wed, 15 Jan 2025 15:24:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753c60csm38180825e9.36.2025.01.15.15.24.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:24:32 -0800 (PST)
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
Subject: [PATCH 19/21] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
Date: Thu, 16 Jan 2025 00:22:45 +0100
Message-ID: <20250115232247.30364-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
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

VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS was only used by the
hw_compat_2_5[] array, via the 'x-old-msi-offsets=on' property.
We removed all machines using that array, lets remove all the
code around VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/vmxnet3.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 7abed664690..a527042ab32 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -42,18 +42,13 @@
 #define VMXNET3_MSIX_BAR_SIZE 0x2000
 
 /* Compatibility flags for migration */
-#define VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT 0
-#define VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS \
-    (1 << VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT)
 #define VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT 1
 #define VMXNET3_COMPAT_FLAG_DISABLE_PCIE \
     (1 << VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT)
 
 #define VMXNET3_EXP_EP_OFFSET (0x48)
-#define VMXNET3_MSI_OFFSET(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0x50 : 0x84)
-#define VMXNET3_MSIX_OFFSET(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0 : 0x9c)
+#define VMXNET3_MSI_OFFSET    (0x84)
+#define VMXNET3_MSIX_OFFSET   (0x9c)
 #define VMXNET3_DSN_OFFSET     (0x100)
 
 #define VMXNET3_BAR0_IDX      (0)
@@ -61,8 +56,7 @@
 #define VMXNET3_MSIX_BAR_IDX  (2)
 
 #define VMXNET3_OFF_MSIX_TABLE (0x000)
-#define VMXNET3_OFF_MSIX_PBA(s) \
-    ((s)->compat_flags & VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS ? 0x800 : 0x1000)
+#define VMXNET3_OFF_MSIX_PBA   (0x1000)
 
 /* Link speed in Mbps should be shifted by 16 */
 #define VMXNET3_LINK_SPEED      (1000 << 16)
@@ -2123,8 +2117,8 @@ vmxnet3_init_msix(VMXNET3State *s)
                         &s->msix_bar,
                         VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_TABLE,
                         &s->msix_bar,
-                        VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA(s),
-                        VMXNET3_MSIX_OFFSET(s), NULL);
+                        VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA,
+                        VMXNET3_MSIX_OFFSET, NULL);
 
     if (0 > res) {
         VMW_WRPRN("Failed to initialize MSI-X, error %d", res);
@@ -2222,7 +2216,7 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
     /* Interrupt pin A */
     pci_dev->config[PCI_INTERRUPT_PIN] = 0x01;
 
-    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET(s), VMXNET3_MAX_NMSIX_INTRS,
+    ret = msi_init(pci_dev, VMXNET3_MSI_OFFSET, VMXNET3_MAX_NMSIX_INTRS,
                    VMXNET3_USE_64BIT, VMXNET3_PER_VECTOR_MASK, NULL);
     /* Any error other than -ENOTSUP(board's MSI support is broken)
      * is a programming error. Fall back to INTx silently on -ENOTSUP */
@@ -2473,8 +2467,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
 
 static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
-    DEFINE_PROP_BIT("x-old-msi-offsets", VMXNET3State, compat_flags,
-                    VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
                     VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
 };
-- 
2.47.1


