Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2200D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmguS-0005aZ-VK; Sun, 01 Feb 2026 18:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtz-0005NF-Qu
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:50 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtx-0003Yg-Vr
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:47 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so29160345e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988644; x=1770593444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FazXBSYedPJMCAc2qLR8vcJOR6e+azw1WcJZB+T60Vc=;
 b=buXhS0rkZ9pcO2P/LPgaA3OyWb9kxPoX6E+Un8s/EydoYls+ni0vDynunaA8CciIl7
 wIYJMpza0mrWCZvFgCf5SJ0kNj8saJTdAF3Ac/TJOfjdcY+S8+4V7trnMf2w8mQPDgWq
 a0pY1cvI2Kqgbf32Tj14+Uk3ahSPErH2KJpsupXOVUSrTc7jdJ/UoPNJ+acbbh1bDIIF
 qkPAZAHu0zbcD7M5uJpoYFJrYJVAzxguNy1Vkic1pQAOjmlAC2TQmuR7pQn+JZgrzHMQ
 B3yZCmeSwHPR51bJJb0iGU1G5EEtRsrMOX+YOGdpeCF9NWJ4cDzds6uWa2KcuC9xO4i4
 n/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988644; x=1770593444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FazXBSYedPJMCAc2qLR8vcJOR6e+azw1WcJZB+T60Vc=;
 b=OiTfAG1MIXYDIAWPKIWN09Td1zH82lgVuPBapOjFh281wMpAUaPOv+3Xpw0OUmCt+n
 V10WkAnPLHJumU2QostJLCLyrhszhF6Gavm6+o1wQYYzGw49YuiKMFp+i/gEsn74OvZ9
 yIMOJ7EKLG2AsaIwgXqXtKeIbuawtr7FjrBqg/AfuHn54a6pm0dZCSUreZxsh9nIURuh
 hePKuHQea9Vph+a1D5hAPhMqp4NimXazerOvN6rRJG3+gMfCv0UjaoV4Gx2LWgDNs+pH
 x1KfP0LF7yZH3BFwsPxk4NN8dhFUSo1hFTEl2ywhRXXoxKfaZKxOOqlsu1XbggBEbcuz
 o1NA==
X-Gm-Message-State: AOJu0YzPs0wkb+cg59Ku/foQfoT0DJX3qTDZQ5glyEGUwZMUqIAd68Tv
 2BO/Rs99IMwpIDbrIBuEI+/ZMiEYlzGg9ZoNy61vh3NVtB+mcVFMfPmKApTbfufc0+CUAv/3xbu
 OlEN0TR0=
X-Gm-Gg: AZuq6aJHx5udO1RMVn/tk3rG+DnpJohqab1Tjq7vlGdtKroJ9GwJPuxf8Y9woQBodtJ
 8K/baLXR9Z7Hg70apvJ3Sdi4zgBMIHyEQw9YVyHZ9pGbHe+YC1dowBabVS5T8FQKG5iLndzcaHj
 d0fNZeUsSRnUoRS8Y2z3Dqn73Nh+UCV4JYDSPyaa29m5v3uuyvWCHcQ5auXlCdXebM9Tr0/jl35
 LEtWTTDuAB91ZK04NQVFCoeICDK/x6YYNOJeU3FFQAzSMkxwNrN/53El35CZmeXV7dX8EvRBi7H
 kCFL5OpQsStSrXkDx+aYzWZHlSTP8zmMvSEc0vEWEpJ5ZPhOmFKwya+tEE2JIYRE6K7Jt4mGc2y
 ZG2nbvH0UpycDKEqDSEUnpOebMKnosWjpTT5O0qujUTLw6AJ7wjF9GCih7fVO/1B5WHalH16r/f
 ZMIy6LleocybVDyNlLgM5UW+g0X7pZs6CPBgaOSa0Bp2Hwii18Auo/sDOrQCTx
X-Received: by 2002:a05:6000:40da:b0:431:8bf:f08c with SMTP id
 ffacd0b85a97d-435f42eb489mr13639346f8f.21.1769988643901; 
 Sun, 01 Feb 2026 15:30:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e13235f5sm38437563f8f.29.2026.02.01.15.30.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:30:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 11/11] hw/virtio: make all compilation units common
Date: Mon,  2 Feb 2026 00:29:23 +0100
Message-ID: <20260201232924.93399-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/meson.build | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index d913b94e1ca..4f308beb961 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -9,8 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vs
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
-specific_virtio_ss = ss.source_set()
-specific_virtio_ss.add(files('virtio.c'))
+system_virtio_ss.add(files('virtio.c'))
 system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
@@ -52,10 +51,10 @@ endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
@@ -97,5 +96,4 @@ system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
-- 
2.52.0


