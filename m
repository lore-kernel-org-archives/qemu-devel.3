Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19088E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgsk-0003Kw-Ii; Sun, 01 Feb 2026 18:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgsj-0003KP-FH
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:29 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgsh-0002R5-QR
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:29 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so42271545e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988566; x=1770593366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PzpxPYgrDKqbPfDNtViXKCEGCov6rxUV/r7gNJjWVyY=;
 b=J9hYYXtUAiK/paGi2sa4iNp7aarI0B7EyAvj3X4MmgHWQuFQwJ1u+aYA+UZ2YBOjDw
 6liAbREV9subR+VSQmm1G1nFhvSfX9egf8XKwZfi7vyiTCr8+Z/i3P1BwVCELpnIYDjt
 iwAOlQF78YhV0LlPcoTKR9S630qfeVO/5xNJ+j+qJK4bMecD1/UJedGoh8cJTiubPAEd
 Zc1PP9Kf63KY8qBVxRFMmC4j+SpKgXe35o0kUBnVXp1JWpDoEcUWxQagqgrRROscTKl2
 vZjWi+BkDN9I/4h163Bmgz5yMr/kWJM4praQslBWB2qYzQ3w49m1P6x74ksiR0y/Mdff
 nt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988566; x=1770593366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzpxPYgrDKqbPfDNtViXKCEGCov6rxUV/r7gNJjWVyY=;
 b=oQyBZtZ2MYaEJmGScZUB4BgRtSl4qitPFZtF0rIyAZEEqrg6FMV3rdM4TMdTI6KllM
 obRYQUwmzwx0dXoOkqcuPDIFIwweudahTRpm37Kz6XBqejNmnj06B1l1uIZ+fPk328MU
 L6zwTJuBXQNOKf8CG/gyCUEbTG6pNv/jeHRjGl2WAeAdeEyl+zuXnFOp5NYDSQqtzay+
 bh9jfvEgXvzj+Tas/fUW6hxIkeEr4K+MgWAfjglq6Ro3wF307Qd/VI0JpkwEf5nFrdGW
 /3mjxszrG5g/bzsW40SoUZY44t81q17JdvDxMxY2nECsidZD4rXklbvc34pHYtI2MQoj
 yk3w==
X-Gm-Message-State: AOJu0YyyKeMPJDgoDUSubOfio45nSjwHHmCVoXChsfDNAMSNpMCDuaG5
 haZEasYF+guPmCjANRxSUY6EYwHS9CUJBPIAhLaD/5fSPzIi95INM459GLtyrWoOhQB93dQAtO2
 F8gcdT0M=
X-Gm-Gg: AZuq6aKZoIWw7ft5vbCOAErceJig/Cikx3HGUEYmYz2lKCKoI3okPhT+Avxz8+FyM2p
 9X2c45U+dcl0OsMsOKtKf19kS8xuCGfMWHh34+8reeWXYN3p5pVjf3EkPoHTKl6pLynhvLcNrRu
 InWAjR6YlsVFmOP45lL6mMqF5G7L8Pse+91bn4pzlo7ca+F2b4GE0jWg/zZkUbwuQ0FqiqfpG8g
 JyESd0YqqwGugh5nyheWPPHhscK6/3on5p9jusU9loAuWJiZJWJ/vXINfkebMLy75B7HtU3SL6o
 3IUCRQu+HAvGDZxHdlxnS2I+Q22kZeqBv+rofOp9ya6cmDmmz62YXJTOp4/ZhN9AnZjNVmiU0j7
 ZkRnhBSIyOGZMnA8g6wgZyCFq6RjfpZu2pldeSJuUrBP5BhUXz4JdhtBDcTkh6ks3FFCnRbhD8J
 nUQJEMrDuWnjMTZ4fuuG1XZBHFsCqtFAQsqnNd/j+A+yRMgRxhJfKH4DSo8DwPPH5vtFuZfTU=
X-Received: by 2002:a05:600c:b99:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-482db4a8ba1mr130679575e9.36.1769988565889; 
 Sun, 01 Feb 2026 15:29:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066aaf235sm400535915e9.0.2026.02.01.15.29.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:29:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 00/11] single-binary: hw/virtio
Date: Mon,  2 Feb 2026 00:29:12 +0100
Message-ID: <20260201232924.93399-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

This series eliminates target specifics in hw/virtio and replace them
with runtime functions where needed.

v3:
- include missing SPAPR_MAX_RAM_SLOTS patch
v2:
- Reduce runtime calls for performance
v1:
https://lore.kernel.org/qemu-devel/20260131020100.1115203-1-pierrick.bouvier@linaro.org/

Philippe Mathieu-Daudé (6):
  hw/virtio: Constify virtio_is_big_endian() argument
  hw/virtio: Introduce VirtIODevice::access_is_big_endian boolean field
  hw/virtio: Use VirtIODevice::access_is_big_endian field
  hw/virtio: Reduce virtio_access_is_big_endian() scope
  hw/virtio: Check target supports legacy bi-endianness at runtime
  hw/virtio: Replace TARGET_BIG_ENDIAN -> target_big_endian()

Pierrick Bouvier (5):
  target-info: add target_base_ppc, target_ppc and target_ppc64
  hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
  hw/virtio/vhost-user: make compilation unit common
  hw/virtio/virtio-qmp: make compilation unit common
  hw/virtio: make all compilation units common

 include/hw/ppc/spapr.h            |  8 +---
 include/hw/ppc/spapr_common.h     | 17 ++++++++
 include/hw/virtio/virtio-access.h | 46 ++++++--------------
 include/hw/virtio/virtio.h        |  7 +++-
 include/qemu/target-info.h        | 21 ++++++++++
 hw/virtio/vhost-user.c            | 11 ++---
 hw/virtio/virtio-qmp.c            | 70 -------------------------------
 hw/virtio/virtio.c                | 25 ++++++++++-
 target-info.c                     | 21 ++++++++++
 hw/virtio/meson.build             | 17 ++++----
 10 files changed, 113 insertions(+), 130 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h

-- 
2.52.0


