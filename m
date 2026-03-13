Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F3F106FD6C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0su6-0000uQ-Dp; Thu, 12 Mar 2026 23:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0su5-0000tz-2G
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:09:33 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0su3-000176-HW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:09:32 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso1839670eec.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773371370; x=1773976170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZIVAjqIYXCWR6WUJm/qsC3AdXFy/nBezIYLkrruDpo=;
 b=UPwMvTrQb4esOystHFeJbxqhZ4oGXu3pimve5l/4W7wGsPLINmy3B8LP1dUivUJuw7
 P82FL5J24G8PpACRUEOPmd+2jaN6qHNWy+98p5Um3Xt4V77nCM649HjUmG9VZolTEof2
 QVXMkaEeq8UT/xgLetdUx+iTX3/jWY6K95JKIhE0kAHLZzc2bQULQUa9JjgQxlw0prPK
 qdxrt1gOHwYC/TsAMGBfHmhDrRsT3VduAGN7/t7tlLuBaK+CuECQFyvk1CGN50SK0xG+
 FSzRot7P1WdrS0nRDHdU26uHwBmK9P91tBGCT7APzIK1Yf2XJsJetyQKEnP/ufjcQk4W
 tAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773371370; x=1773976170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xZIVAjqIYXCWR6WUJm/qsC3AdXFy/nBezIYLkrruDpo=;
 b=SBouWml53Bxi9wXTOFwTo4TPDOvgqRXmmLYqYbFf3rRCKp4dOAEFLwLWRmghMUlU6d
 fM0S8NYXFZ43TxG0qfZOcGMf/C/ruyEp+MJarAt7OXqm6eAlpWj0iOdRSwsWPTAGdkDw
 WzEJIgca849iwL7Pj2m0GFMcaD1vPMlZRbBSWtDXytQslLcCIKAIJ3FNTMCCaIVR6qwZ
 R3byi7qERF0RTMk8bpnndL+pDDrXGBDnVOD/aOFVfxW8tbR64FO6YhRfRYwezWEWZ3zj
 xySvT1QIaYP3UZBw9lp9+HtzD2Qdz0arPbTmatIWc6QNFaEBX1Oyge8CHtv+mICrYnCB
 iSJA==
X-Gm-Message-State: AOJu0YxEsCqF1IdMp264vjQV2hCQztslS8NxEyBQdTBFyYYN5P1GsZHM
 d7Jh7fdTe77I/rqjvBnmpJZbKFibtxxijpsUsusCuju/a8TBEWvZhh4SAjp3ot0w
X-Gm-Gg: ATEYQzy8jHIgvuBY54f7H0HoNY/j6PBQ/Z2bTWVI1g3LHS8JkSx451VPNlG/H13Z7Lg
 7UBNSHMxZ/WYF0UZkZFTCDZOzg5TviLeeVzxsyCfpUQXjQI32OOn7KWJ6U/oVBmtPibfOPeCCLC
 usMv5X5mUw75H1H0EsnwhImCSTahW1Ye91dYmuGz87XQMwKmgSp53yP1+tl0tlTHEGy0iREt/S8
 OXQKaVbH7Dx6zBorofzPDAbICa2n5qYb+FQOQXUx3mDqm3iHkCTh9D4bxiIW/Vxquh/H5qA4sbp
 YEUn0eNBqEyE93iYHGk+aOgQPeoTcu9hRYSoC3FPARztNpcee869S86bbAaOBwYQq7+om34jTaX
 xkAh8c7EIvfPvCfcAWWsJ7ju1gPPGDyvClgQ6XMjv8VoUn4ezQntwNJ+p0iG+0GAqF5HqFnwEqG
 /0MJpHH/i4RqArQ0GrNHzwQHzwJ5orxvF/om6wc0YO9L/4VveCaoQ=
X-Received: by 2002:a05:7301:1688:b0:2ae:5e93:b69 with SMTP id
 5a478bee46e88-2bea55edfafmr772851eec.29.1773371369592; 
 Thu, 12 Mar 2026 20:09:29 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:588a:39d7:d008:37c2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab52702asm902472eec.16.2026.03.12.20.09.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 20:09:29 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v3 0/3] virtio-gpu: enable Venus/Vulkan without OpenGL display
Date: Fri, 13 Mar 2026 00:09:21 -0300
Message-ID: <20260313030924.45299-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311022752.64192-1-lucaaamaral@gmail.com>
References: <20260311022752.64192-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Decouple Venus from CONFIG_OPENGL so it works on hosts with no GL
display (e.g. macOS with MoltenVK). 2D display commands fall back to
pixman; 3D/Vulkan goes through the render server as usual.

v2 -> v3:
  - Rebased onto current master
  - Fixed line-over-80 warnings

v1 -> v2:
  - Remove hvf_get_map_granule() safety check (moved to hvf-map-granule)
  - Extract GRAPHIC_FLAGS_VK into its own patch
  - Fold standard-headers addition into blob_alignment patch

Lucas Amaral (3):
  ui: introduce GRAPHIC_FLAGS_VK for Vulkan scanout
  virtio-gpu: decouple Venus from CONFIG_OPENGL
  virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT

 hw/display/meson.build                      |  8 +-
 hw/display/virtio-gpu-base.c                | 15 +++-
 hw/display/virtio-gpu-gl.c                  |  6 +-
 hw/display/virtio-gpu-virgl.c               | 85 ++++++++++++++++++---
 hw/display/virtio-gpu.c                     |  8 ++
 include/standard-headers/linux/virtio_gpu.h |  6 ++
 include/ui/console.h                        |  2 +
 ui/console.c                                |  8 ++
 8 files changed, 122 insertions(+), 16 deletions(-)

-- 
2.52.0


