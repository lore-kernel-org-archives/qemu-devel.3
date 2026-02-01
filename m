Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A6CD172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgkr-0007A7-Ph; Sun, 01 Feb 2026 18:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkp-0006vE-HV
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:21:19 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkn-0000PE-IZ
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:21:19 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48069a48629so39820695e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988076; x=1770592876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FazXBSYedPJMCAc2qLR8vcJOR6e+azw1WcJZB+T60Vc=;
 b=hhDi3vxClcfv1N5L30CyF7XQcsQmQKeuscubbR85XNkAhM8D/+N3xnmOxCqrbG6mZz
 KFzztZT6p0Y1OGl8uedLEMEk/wW/mROiKJELE5RdD6ZoNIOvvu6069Ygzb4mSY9Q2bfM
 JjfJx23vvypt4fkq29B2LUzYa53CFlnH+1EI+OzkJxjh5hrrp59QLtB5xIXtfSrQVMhh
 L1qSrKoTKSC5/6ufFxOjM+ujPYW3nhgxcLumrE7iwK8UP9l+COdgNnytKbvCIHY5hBX9
 9WKDmFeu9uPSFZgce28Ij6ip6y1T1PXFBurwvbqmMlw7Eixxw3FFuumhXnq+7eO7Fxio
 sY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988076; x=1770592876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FazXBSYedPJMCAc2qLR8vcJOR6e+azw1WcJZB+T60Vc=;
 b=FBvNmXrlldMrGXic3tvBpG7P8BxlWyA91IuTPojvTDysLDfRk9+bS4fZ6bhwsAbNu1
 GZ9+wGicsf5JP6LaDrboJ++XHvNhP96wVxsBTQ4j7q2jp9lrKbQAyAmNpTpMgFWyG5dD
 rokg/aIxrChxzg6ndOTC5p4RCvMrnWMidy4nHPB07hywxepacqvhVu2FtyRJBaE1Gd/A
 ZArsX2/ECFhvC6jHnhvJC7A7ZdtL7R1UqD/y9//350JUHOEFtzCTdGwBd/jbRjDkfmEx
 EX1oo0MG0wRHNRUx1StDuhPmyET0Et7rAs15OMXEshTB7Deg1bKWbZFicw/HTH6MXDdV
 4eHw==
X-Gm-Message-State: AOJu0YyxO2LCM5YtRa8EeDjsoI+1Jy1wl3aYgAXf4flndSQkwJC0X8qx
 acsOARnX5XG3ZumliEXKBj61WMZC4JdvRJojJLPkZEqiGFy39k2t1FTahZOGd/+1LHDSGZm3Gss
 aNuwHWUo=
X-Gm-Gg: AZuq6aKRHE8dkMTpcvjzr/8xILFFtL/++MpZVS80ueqE4R4GLlqtJOBFuIvSS6Uf09Q
 56E3MvJdXeiq1VlD8xg1B1pebCqfx3aGp/RC2A7OQm78UeXEHUQvXrPbQXku10awHlcGa7p5DN8
 2xIUnmmyuSEL7QCPMToiTObLQw9naGfn/oArTaW8AFXmtLTKSTTqodhg9y0b0BZmVie0xQQreZ3
 VpmkZ29a+oCt9qpbibr9yjAud4eEsH5IpaSu+ywSIRFGU0qAvtGeBWhFjc1VKZofqDoNbf4ciUg
 VLZuF8JmD2AC4y4SZEqdYA3pgQ/ox8/NPmN/2feONkgdDcnMQhfC1It90NiPDqiVISd7DLX2KY9
 7gaXHg4DqvFTpDyXfylfYEtYF8II0nmkdVi5GGughQtThWanI7KGtAVrsXfhPNPqfNtebWXzN1B
 n3d+nb4jqAH8wJSOeDjO/rbl0U3r0x1VFnAGLSVa8+IljRR7mxwQ/bvliGqaTh
X-Received: by 2002:a05:600c:8289:b0:480:32da:f338 with SMTP id
 5b1f17b1804b1-482db45cb90mr116343225e9.14.1769988075640; 
 Sun, 01 Feb 2026 15:21:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c37420sm446556255e9.9.2026.02.01.15.21.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:21:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 10/10] hw/virtio: make all compilation units common
Date: Mon,  2 Feb 2026 00:19:59 +0100
Message-ID: <20260201231959.88559-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


