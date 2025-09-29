Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C26CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G4r-00031z-Bb; Mon, 29 Sep 2025 11:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4X-0002tp-7b
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:45:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4I-0007z6-VS
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:45:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e414f90ceso770445e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759160731; x=1759765531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y2BqBLcXOCVlrkuufChgWQXiOv3DJ8+apNhO7PXtQ28=;
 b=rSXYsqQs6G2BArrKhnz0mePgiZJfaYmF5nJK0ZxHNpXSW2OHV1b+AmwH83VoBWd6n0
 UDUBQz5rWvVXcaQK7q0wK/0xDo6oPo3adZMq//7tCYC+rWvEgwYlzEbfKmUgPP7d2/mH
 iziRCpFD1ZModnC+bAznuHEk57dwZg+dmHCapenCsgxT+HBi/H2gh807sd0GMaD9Zg6Z
 KFOHXX3Ve6aLg3zIT7oQRSjDDpQ0nDC6tWvqBqqCi3xK+Kbh7RHA5ke0G9ymw8PldEMG
 W2fqulSuuxh7HRufSf9C+ckmbMNSqDLKGzX7NmNiY1v0COKuHntlNK3ld19oRIpFeCg1
 lftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160731; x=1759765531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y2BqBLcXOCVlrkuufChgWQXiOv3DJ8+apNhO7PXtQ28=;
 b=b0VCduGODSVKmdLYIAI5MFhZeZzxyquAT7B1dbVLASoVc44nK5ltzUSG91ITiUVoJk
 aclzHYBfdXW/wT5/6zLmluw5bYIxxkjX0hhYYGhc1HxRIaUlv/moErKyOa5GC32NCdf1
 JPKN8QmsIc/NzII3Zsct/YlcaMaCsB5ry1rV1mEbY2ruJy5VrxVzF/6LcoKWsKZXIYQs
 z7uHQKnSh3Sbt/l+6bMsfYSMDq9epPSlCs0zJbezWLc2vA8q66MamOTHJGRYQr/dsr5R
 ZyUztpuNR7SIbvC0+bnzp4p8IMaOM2c1AwVq/FbQQkpmFbO/hDuNy1w7AVa1mi1J8Mzs
 AViA==
X-Gm-Message-State: AOJu0YxzeLpPllV3S6bOiZzAKVkD4IC6L6dXhEnGROfbLmfsxkE7RGar
 MwMREmBrFvxzROJDP8SYp+Rho3kWGkt3SC9nPPr+cu8a+nYueoRh1e+3RyomA+i6lPDxXkRPPyg
 OONdHYwU8lw==
X-Gm-Gg: ASbGncvI/h4iI4I+PbJmqHHi6pDhQVnRn/4pDtO33jt8QRWrWeJ/7uXdc3tzGiWhVgn
 Rq//cUp+X6rJJaFRPvuf0fGTej4k61X33s3FbzXGb+yp8vp7/q5A9QsEqSXz1JKDMsYZDyHhthD
 qQxCel/1gsQFz5nr8hYQo8wpdDU8F7tACCZgNDABFJ3Qc3LfM2Qlp06Q06GrXdItdsLv9M4Pbmj
 l0ZXCABDpI3a7wsoWBIK3Wofi87+oi+AylfEUg17PrJGgZYEf84fHOzTtsaVEJNlFIlp6smJvBQ
 cV08meXLPWq8hyaAxdLxtlXCHI1VHOvaByHqdNjHKe4Q4BAm8b7t2TtCu2F2BG0fJw2i+P8PbIN
 bB96yh2lQibBuvSuS/A0LDViMELLw1Zdm3Cv2zxbBjOWVd1n2fKN9IP8cMcBHC9o9hRI1qcOa
X-Google-Smtp-Source: AGHT+IEuhKbNb5pks8P6yOzotxlB7PvN7376bBGCHSTQ7yaWpATyoy9ea46zy2XTRQv+Klen0bxxMQ==
X-Received: by 2002:a05:6000:1866:b0:3eb:6c82:bb27 with SMTP id
 ffacd0b85a97d-40e4accc83dmr14058555f8f.61.1759160731258; 
 Mon, 29 Sep 2025 08:45:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc8aa0078sm18625546f8f.59.2025.09.29.08.45.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 08:45:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/6] system/ramblock: Sanitize header
Date: Mon, 29 Sep 2025 17:45:23 +0200
Message-ID: <20250929154529.72504-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Usual API cleanups, here focusing on RAMBlock API:
move few prototypes out of "exec/cpu-common.h" and
"system/ram_addr.h" to "system/ramblock.h".

Philippe Mathieu-Daudé (6):
  system/ramblock: Remove obsolete comment
  system/ramblock: Move ram_block_is_pmem() declaration
  system/ramblock: Move ram_block_discard_*_range() declarations
  system/ramblock: Use ram_addr_t in ram_block_discard_guest_memfd_range
  system/ramblock: Use ram_addr_t in ram_block_discard_range()
  system/ramblock: Move RAMBlock helpers out of "system/ram_addr.h"

 include/exec/cpu-common.h                 |  3 --
 include/system/ram_addr.h                 | 13 ------
 include/system/ramblock.h                 | 27 +++++++++---
 accel/kvm/kvm-all.c                       |  1 +
 hw/hyperv/hv-balloon-our_range_memslots.c |  1 +
 hw/virtio/virtio-balloon.c                |  1 +
 hw/virtio/virtio-mem.c                    |  1 +
 migration/ram.c                           |  3 +-
 system/physmem.c                          | 50 ++++++++++++-----------
 9 files changed, 55 insertions(+), 45 deletions(-)

-- 
2.51.0


