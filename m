Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A11DFCA19A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziu3-0003M4-7i; Mon, 09 Mar 2026 18:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTS-0000uB-Uv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:15 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTQ-0002C4-O6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:14 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso10237091eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092951; x=1773697751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ISMYXFH5tdDCQqEWSez1J6/wnG6ZlO60zawalycHLO8=;
 b=Zawgz67kszvXgMJUpU6/DyUs0lAdUDgiB04g0KJ5F4F9CpV+k5CWOEPSBTejNlyUWK
 nMCIsXx7ct4uPwbPazw30YFealW1t7qC3zg7jFUchvH0S1ipYVk6t9uKY+rFIplIjPIG
 eqm2iPQPOVo3FWfoXdW7wOqvRR2qF8465ZOS7oFiLLlmvAFT/4lCbobtDW9Cd1w5f9of
 LvSWrTJyLtYV/ew3yFnf/VEIPn3T61OmVCCRLnFo+nxOppC2uvCFhWAHvrCK85+VH2EC
 NGstNjUl8GZ0LAdOE5oeCwIHEN685WuUjADuwX1vK0klFXhCvO4Ro8unmWUcC7cRdbqJ
 Jazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092951; x=1773697751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISMYXFH5tdDCQqEWSez1J6/wnG6ZlO60zawalycHLO8=;
 b=KWQ35X8I4Guxbs2n76VHLLBzvV6yhSDPiYyOo/uyOsWTT/AIA67yQqdRXDoWRdn4F6
 cqx12YtAv8OHDeoJX8toPS8FL47vDuSuyjFTEQSyr1i2JuozSXhs72wj7xiz5yc5tRx5
 vVqoQ4EXq6/4caASdmMA+rz75CIe4UEzcAv7q/t2jLyK4L2mBQkIHaDziCPP6ZW84FWf
 HT7l9PHv9tU4eBvjfV4qsISAtSoGqOBqaFAk/Tl0h9bgQDBpSY70l7zha7d5cR4XTSXG
 bZl5f6VdpnKbBFnRJACAaCo1O/LWZ6bJXy7Qt8oif9QGIB/83piXMqsbKi3khpAvP88C
 HBPA==
X-Gm-Message-State: AOJu0YyzBdiXcJ4moRTZEZ0q/xl5Ax8c1zCuY4tv1kU/WRIVbQD26W7g
 GMDn2wGGCFJhx62NgtosErsCW0+3zSB0ej4GvwPNCO50OofGj45OZeFc264jAKqA
X-Gm-Gg: ATEYQzznb0N0ui3o0yFRktdmFcgFnpeMD+YkdbZN62nVpLPVZqu0J8xES6ayNF36fyr
 k99+U7+tTRI6PNYQ66+CQiqElVy70As8gd7Wn5GaYJGOv3HHcEOxlwFXxEfBJ4IIswr2fhnUUcF
 eQAHjt80WMOkfXaQHm4+Xfzr2W6NRXRLw1ikvL+0xAKkw9XLSRBI8AyEt4bV2XEE23q3CSLWt3z
 oe4B31TlFWpGJ/xDvj6O5BSdZOSIB/c0ibxT8mkRfMfmlqBHOwFqpih2vEMovDl+D5PtLJQs+tQ
 hWibtbjb+dE15km9kq58MfS+t6ncPxZyvz2VSIc7iC1T/DXkPFV6CtXuZlx7v4kY0JNFmRVGzxk
 1p22zbdkvxM94yLn9imU6RfmSo5PAK+pPl8VS5QXYyGP402HG1DOyhSZHOJp5w+wfXcBPohUtIt
 89it0SVPXeWxFlE1HCwQWaDRf6IfwSEZFMbpZ8ad98CL/9isSRxsc=
X-Received: by 2002:a05:693c:300d:b0:2bd:d04c:a433 with SMTP id
 5a478bee46e88-2be4dea59fcmr4687173eec.15.1773092950882; 
 Mon, 09 Mar 2026 14:49:10 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:4cc9:ee1b:bd8d:dbab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b1d3sm10821438eec.11.2026.03.09.14.49.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 14:49:10 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH 0/2] hvf: map granule abstraction and macOS 26 4KB IPA
Date: Mon,  9 Mar 2026 18:49:04 -0300
Message-ID: <20260309214906.92578-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

macOS ARM64 requires 16KB alignment for hv_vm_map(), but the guest
kernel uses 4KB pages.  When virtio-gpu blob BAR offsets are not
16KB-aligned, the interior-mapping path fails, falling back to slow
MMIO emulation.

This series introduces:

1. A map granule abstraction (hvf_set/get_map_granule) replacing
   hardcoded qemu_real_host_page_size() calls in HVF memory mapping.
   Non-aligned regions return early instead of proceeding with
   add=false (which attempted an unnecessary unmap).

2. macOS 26 4KB IPA granule support via hv_vm_config_set_ipa_granule(),
   which allows HVF to map at 4KB granularity, matching the guest
   kernel.  Gated behind MAC_OS_VERSION_26_0 availability checks.

Dependencies: none.
Independent of: hvf-isv0-emulation and virtio-gpu-venus-nogl series.
All three QEMU series touch disjoint files and can be merged in any
order.

Lucas Amaral (2):
  accel/hvf: introduce map granule abstraction
  target/arm/hvf: set 4KB IPA granule on macOS 26

 accel/hvf/hvf-all.c  | 21 ++++++++++++++++++---
 include/system/hvf.h | 15 +++++++++++++++
 target/arm/hvf/hvf.c | 14 ++++++++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.52.0


