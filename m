Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E925C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQQc-0004pu-EA; Tue, 18 Feb 2025 11:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQY-0004p8-9Y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:30 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQW-0000iN-4M
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:29 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f3913569fso1792712f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739895986; x=1740500786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LIM0sFFVBkCbyArsjA9gzE/mDTxyAKavFGTWagdWog=;
 b=oywqo1D5kyfnsY0B7eXVSyTYlqiYPUKIDy4C7O79hAR6ToCJ8Z8ScCLwIFTZ2o3ALY
 qNcbGKOmLToiOGZYfX01aKhimFZ/s6xtA/wJXo1QMpyKcDw/iUYMMdwiaWYQkuCWsxzs
 BGkJl943rNUTO4MQR2YiPQi6c4IFL3yPF+u+esJyG88fg/mbj5ohkTpU/vXBPJqmX5Qn
 4Rng//gqqN6E+JwmgtwHQGzwMxSRG7TGWPlOOSO4LcRKdIdxNMgZ8lw3L1wy6bEPxSWv
 a/d01ly9tCpM14zbFGBLcgLcEqCPLx9j8Zx6Viok+EPZW0kbvkeegw/Iw1KmGHtpL3Tq
 WoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895986; x=1740500786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LIM0sFFVBkCbyArsjA9gzE/mDTxyAKavFGTWagdWog=;
 b=gEeNa+Pv+5312nEmMdSWca2F4S6Ua++kK3Q+o2svC8cEf87TKEtfl8Au8OElzA31GO
 QAhLGMC7umsZkYz1+dm7mUX8XOwVfSu761t2oNMXBnQZDBOJqmJT2dCXmNhZNkQ6AxTy
 VJPb154NmQOc7LeQb4LzZLCGIQks2554YM7ba4cJlc+jteCMwqXcONOt2lcOcFWwZkRn
 L75rFtaYu9ClSDjmm1ML1SR7m2jYJk1VQHrgLbfCa/gG5uLRYFuL5NTylwH8fJRxQE6B
 Cthwox7JW/+JKsjBzTOZgczjbsGFr1y4M6hBcJnlpxxKPgSR2Zy+ZPjKPVKG/ZUWQYQS
 uzAg==
X-Gm-Message-State: AOJu0YwtU+5nKskisEiPuEGe14JCd13sX/yeeE2J20v2MzaWzjVS/Skd
 QW4m9uOSni8ezom3R2Tj4ugkknKFEI0YTNeTx4QnLoLSREIErjpGNloJM2lWRRd4f2NxFF0WBkY
 aLlo=
X-Gm-Gg: ASbGncuR6Bh5Szg2hNNOg2pRqBxMLGJYD32Rh08tHJkwqmyHtFOUnMnEeywl4PveQZ7
 cH6RxeTyJqzLmwDsZ650JPz2gPdraMuCyW4V+cjnBtKSpXpyUjNm/CGL/UIrVlZjHa1x29jyakO
 ocwDzw9Ea/L1B3oy+7D+tb7TTE2GyxtJrHAcSDrDX0v9CPRTpBoCeuvHRCuoD8CZbTALvWqweSK
 I29MvJNM2r0hRiR/IU6+VQyS2yOPWC+WQDpUyQaaMW57SxYyeI5s8cMLZcs2vWcChgcl+Qye0j+
 eCyRozd0jodesXHpTU6mQZpWLUy4lAifFhCGCtfCtAAxDuCg5fBkdwKgHKoNQFCqxQ==
X-Google-Smtp-Source: AGHT+IGaFoLwpAXJM1RKXJyqOqbFhBQZJoShD8QgSKhjB3EukdihrG9J+ztpEYBn+Bs+2lZBx3sx+g==
X-Received: by 2002:a05:6000:1fa1:b0:38d:c6b8:9fe1 with SMTP id
 ffacd0b85a97d-38f57ea1cfcmr360586f8f.24.1739895986072; 
 Tue, 18 Feb 2025 08:26:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7df2sm15426607f8f.84.2025.02.18.08.26.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:26:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 1/8] accel/Kconfig: Link XenPVH with GPEX PCIe bridge
Date: Tue, 18 Feb 2025 17:26:11 +0100
Message-ID: <20250218162618.46167-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
References: <20250218162618.46167-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

XenPVH requires the PCIe/GPEX device. Add it to Kconfig
to avoid when configuring using --without-default-devices:

  /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-pvh-common.c.o: in function `xenpvh_gpex_init':
  hw/xen/xen-pvh-common.c:174: undefined reference to `gpex_set_irq_num'
  /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in function `pci_dev_bus_num':
  include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in function `cpu_ioreq_config':
  hw/xen/xen-hvm-common.c:412: undefined reference to `pci_host_config_read_common'
  /usr/bin/ld: hw/xen/xen-hvm-common.c:428: undefined reference to `pci_host_config_read_common'
  /usr/bin/ld: hw/xen/xen-hvm-common.c:438: undefined reference to `pci_host_config_write_common'

Fixes: f22e598a72c ("hw/xen: pvh-common: Add support for creating PCIe/GPEX")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/Kconfig b/accel/Kconfig
index 794e0d18d21..4263cab7227 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -16,4 +16,5 @@ config KVM
 config XEN
     bool
     select FSDEV_9P if VIRTFS
+    select PCI_EXPRESS_GENERIC_BRIDGE
     select XEN_BUS
-- 
2.47.1


