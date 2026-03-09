Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9FCFCA191
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziu5-0003ON-Ao; Mon, 09 Mar 2026 18:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTq-0000wC-LD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:40 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTp-0002Eo-78
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:38 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso10237327eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092975; x=1773697775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D/QsI3DD7X5Dh80Hl4jlB8RQkOI+XiHXNDi/tDqEd+k=;
 b=e8ZtHMmWTQCHnA698cssHD781kr5RIa7muBZpLNQOzW5NCpyfFoaoI6t1WHcG7Hj9u
 t5xRjJbZ30BgqpODCqJH/knkfEDJwI/t7wLmDrFJ/MYGbykHTWJBIEnIP7bvcjxQFpvC
 K2wn8Z4vkkS8xI3yuYwR+a2Gex75zMeLNcd6huEPD24ROjCHiUqCuoeCqME9jRG78Sqo
 jd4v6jAfaNdzKp56TemfyK+D7UZEpWYUQ4YpwQ3XCGLMiFvU4KUfUwTfVBQhl1Eo8jsH
 2U+N6QOVXtCDLIYUXEuEt65ghV0m4jZrRPyjlMPvV0IfHyPfeehSjDCFumDsh09/DScx
 pCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092975; x=1773697775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/QsI3DD7X5Dh80Hl4jlB8RQkOI+XiHXNDi/tDqEd+k=;
 b=N35fhLRxGU/leoyybp9lkAu39hKpeEGhMyrMakMe0ROzg2RmuBJuymVTAiYa8Gretx
 2TA+nLU7JkT51JSC50+IXPo8o9pwQ51ipw8qPVuuGYY0KHyfTXvrDwRS1BI2N4uaGkd5
 uckJneKWSvM422RvLyDt1NXb81dwZxomdCdN9Pm+Q/KCntsLhmhqu/20Y6rG275JBEZY
 GA50nm+HqQ4aVgYhRCTVLXVy+Q6qAtYzjkex8y4b6ZJkvFicuSdJ6I9rk35tfFasg/vL
 f9S8fgnz8MzTCyWV7PWYt9IZSK1mD2ShNZDqZohF7r6jG0xJ680slKcKHvDim9xYi///
 Nosg==
X-Gm-Message-State: AOJu0Yy0lYfqdchWcZDtcO4tGHqmGyc+SsAQpBlc4L3brnv88VheEivJ
 nIx0K8o32bKkTQBR7veup4qdp1LZyenuGQt+Ggz5rut00l8wnGifI4+Uh7G9ium5
X-Gm-Gg: ATEYQzw0p8MKdGiYWLTatBBRWswT68qbHZ4sZQynl2AiWfof8aw5Ygy3PlidFCnNYYN
 a0TqthUuVOGxfk0bEjkzAkeXxy+aHMolHDIdYchyO6EQ/F3Gg6RlDwVjYZ0umuislYoOdZIwiNN
 7KEZWo1Gag0LFwETdQFRxt0TLVv6kjRdEVeKNUSV4UR9C0vjXCk9YA5qwbYCAGD9Kq2UfeVNBWU
 60cQsgQMUE8Qznj0icx8X2VTDeO23QxFI+jqMbRfPbpj/GM6r2ZiVPL/gGyN3uvguOfNzvyUrQb
 mAgWni8kKKnsz3nRiawOgtUPst4r4qO3CsVhd9UJt0z96Vu1iH4J1eb+kED94hSBgOT473u1Vx+
 zX/eugQQkJ1GB9WTBKWj7Lo9Q7Frn/JjWWIsNPHETkbGHP1njFrQAdG0QW44qm1wtYuoTzuT/pf
 SRplqLBAiMzqY/MWw73rFWXNexZnfl3MVitUjyM0+qFOoJOYdkp3IjTQYubdYBot6uohkA8Q==
X-Received: by 2002:a05:693c:2c97:b0:2be:778:49aa with SMTP id
 5a478bee46e88-2be4e03d0e4mr4197205eec.27.1773092975164; 
 Mon, 09 Mar 2026 14:49:35 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:4cc9:ee1b:bd8d:dbab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f96f25bsm10519495eec.28.2026.03.09.14.49.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 14:49:34 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH 0/3] virtio-gpu: enable Venus/Vulkan without OpenGL display
Date: Mon,  9 Mar 2026 18:49:27 -0300
Message-ID: <20260309214930.92616-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Mar 2026 18:16:41 -0400
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

Venus (virtio-gpu Vulkan context) currently requires OpenGL display
support due to build-time and runtime coupling with the GL backend.
On macOS, no OpenGL display backend exists (only Cocoa/SDL2 without GL).

This series decouples Venus from OpenGL:

1. Define VIRTIO_GPU_F_BLOB_ALIGNMENT (feature bit 5) in the virtio-gpu
   header per the OASIS virtio specification.  Header-only change.

2. Remove opengl.found() build requirement for virtio-gpu-gl module
   (virglrenderer provides Venus independently of GL).  Gate GL-specific
   code paths behind CONFIG_OPENGL and display_opengl checks.  Route 2D
   display commands to the software renderer when Venus runs without GL.
   Define GRAPHIC_FLAGS_VK for future Vulkan scanout support.  Gate
   Venus at device realize when the HVF map granule exceeds the guest
   page size, ensuring blob mappings succeed at runtime.

3. Advertise blob_alignment in the device configuration so the host
   can communicate its page alignment requirement to the guest.

Patch 1 is a prerequisite for patch 2 (which advertises the feature
bit).  Patch 3 is independent and can be taken separately.  Guest
kernel support (Sergio Lopez's patches) is pending upstream Linux.

Dependencies: none.
Independent of: hvf-isv0-emulation and hvf-map-granule series.
All three QEMU series touch disjoint files and can be merged in any
order.

Lucas Amaral (3):
  include/standard-headers: add VIRTIO_GPU_F_BLOB_ALIGNMENT
  virtio-gpu: decouple Venus from CONFIG_OPENGL
  virtio-gpu: advertise and populate blob alignment

 hw/display/meson.build                      |  8 +-
 hw/display/virtio-gpu-base.c                |  8 +-
 hw/display/virtio-gpu-gl.c                  | 17 +++-
 hw/display/virtio-gpu-virgl.c               | 89 ++++++++++++++++++---
 hw/display/virtio-gpu.c                     |  7 ++
 include/standard-headers/linux/virtio_gpu.h |  6 ++
 include/ui/console.h                        |  2 +
 ui/console.c                                |  7 ++
 8 files changed, 127 insertions(+), 17 deletions(-)

-- 
2.52.0


