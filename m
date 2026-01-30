Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AA9E6BF10
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 21:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlvsI-0007tu-6l; Fri, 30 Jan 2026 16:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlvsH-0007tE-2G
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 16:17:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlvsF-0005T3-Du
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 16:17:52 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-480706554beso26966295e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 13:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769807869; x=1770412669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yN1mXRlrekOt8tw16+k9JgmNJ09/+KhlhuCXYyL5KHA=;
 b=tZrAOZzkf7kbZMwVj1uzTqjiFnn4SgJzJWauRB/efIn1ENap9TrYwwWcaRBirJDiNC
 /qqsrwG47SVaGCcvzGwS6wr1tmw3qLcfPXxiPntP+q8llPO5cWFiNuVULC6RQFoqUZNt
 +NEqpPjpnHYnlZBO+oBi9T1bLJW8kJeJikNglSQbD0iabOtikQh4HrmbmLsQKwxYcUHy
 qhZXfBhEsjdZeRaANgkGcoTfVsf8a8/w1+eluVyJx6Q+f+7TFccrPVcpFGm1Pha65Lel
 A5FC/UR2b4xTD0bjd8VuJAcYnyDPW6ZRnH3OMscjpe6QU8SqW39YBWxHvWYsKqwjhUOS
 6IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769807869; x=1770412669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yN1mXRlrekOt8tw16+k9JgmNJ09/+KhlhuCXYyL5KHA=;
 b=O4MQhDSsIgd6jQF3bTv2ODhbDK0sLDs+CnypTxZlan0OjWKQd+ErxFBXp9qjPhFUH4
 JcNf4BJHArTGKRgGGz7rrR59D6b3a2heqxZo1wbMNm9FHxKBgd2fOfVLgDlXuNFsRFP8
 kF3ONuOC1UIu+PXer7ug4XbDsK06kN7TH4EJR1a+17DQFzRmZtIV7PRfAeVe1lPVxmGn
 9qHXsESexOt8VgRxBKLMI4dTVqfHqjjochrJJmalLFVAAexmOM76lbdPcmwvessa4MXX
 GxbURsZQF7N/1f5Y1esoYgEa8RhdJOGUCHf+WBKlMerw5DOMQyep9uTLMDOmdeG5YdDC
 jx1A==
X-Gm-Message-State: AOJu0YxfK0eIew2r81yh0aniTl1Gz9P7Npt91rRWh6cMGSXyBDmcLdch
 jW4zmUxVuqDvmjygsQcdvVbI1KWzwaZc4zSTaH/zXx2AwTh3k1ELbZpy3asCoWCvtHK3Kmc1d9a
 mnNCUHdw=
X-Gm-Gg: AZuq6aIj5jOdtz24VFwV3zAXW9LCxeKNfAutHS/cVuOGNKUezDViVgIx4LO31Fzr4GV
 cCVZToCt9aajqxfbd0ThxbCLQZKS6Ah39pJcgwaUtni/FI6yC7feQiwhXfTcUMnkZDA39WPRfOq
 gEPu+7FGyxoNXc8ZxlZxXvznMT0jL4WR+CugyvACKAbi4M9BR+aorTbQSo15tu2Xn+nbs6C5C4q
 sPybAIa26lyyFhCYZ52oQBOI3WW83NwO5iKGazzv8/E70cqspYT8AnkdAquMSldW/Ie2e1+/Lyz
 RgzGM0yR4zxmBVWJ+AYBs27URklJQ4c0JPZM5UrmHJ7vGcQXOxTW2ixJaEAE2xhSDpVczGt9uRe
 LXahNOUl2WHJrSBFP2AITsKKaXsWaPa/72h5rI7kcf9jHqo6o+DAWRmiAxd6dhH3dPGN0SAef8z
 BM8JKRiInXBYmuIJbUQjGddypYB8YLCcHicP3xVvTwUsYEjuks93PdybIE5DpZvnd+Ly/vIIo=
X-Received: by 2002:a05:600c:4591:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-482db45fc65mr53579025e9.9.1769807868903; 
 Fri, 30 Jan 2026 13:17:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482db623407sm35302715e9.0.2026.01.30.13.17.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Jan 2026 13:17:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: jpcottin@google.com, Markus Armbruster <armbru@redhat.com>,
 Roman Kiryanov <rkir@google.com>, Will Hollins <whollins@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jansene@google.com,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 0/2] bulk: Stop forward-declaring enum typedefs
Date: Fri, 30 Jan 2026 22:17:44 +0100
Message-ID: <20260130211746.46667-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
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

v2:
- Fixed QemuClipboardNotifyType typo
- checkpatch regexp
- Pierrick's R-b

The C99 standard chapter §6.7.2.2 point 4 mentions:

  Each enumerated type shall be compatible with char, a signed
  integer type, or an unsigned integer type. The choice of type
  is implementation-defined, but shall be capable of representing
  the values of all the members of the enumeration.

Align with that recommendation by defining the typedef
along with the enum.

Philippe Mathieu-Daudé (2):
  bulk: Stop forward-declaring enum typedefs
  docs/devel: Mention enum typedefs forward-declaration is not allowed

 docs/devel/style.rst                 | 11 +++++++++++
 hw/riscv/riscv-iommu-bits.h          |  4 ++--
 hw/riscv/riscv-iommu.h               |  2 --
 include/hw/misc/auxbus.h             | 11 ++++-------
 include/hw/pci/pci_device.h          |  5 ++---
 include/hw/ssi/ssi.h                 |  6 ++----
 include/hw/xen/interface/io/xenbus.h |  5 ++---
 include/io/channel.h                 | 11 ++++-------
 include/system/replay.h              | 10 ++++------
 include/ui/clipboard.h               | 15 ++++++---------
 include/ui/kbd-state.h               |  6 ++----
 pc-bios/s390-ccw/virtio.h            |  5 ++---
 tests/qtest/libqos/qgraph_internal.h | 10 ++++------
 hw/core/loader.c                     |  5 ++---
 hw/display/xlnx_dp.c                 | 11 ++++-------
 hw/dma/xlnx_dpdma.c                  | 10 ++++------
 qapi/opts-visitor.c                  |  7 ++-----
 qapi/string-output-visitor.c         |  6 ++----
 tests/unit/check-qom-proplist.c      |  6 ++----
 scripts/checkpatch.pl                |  5 +++++
 20 files changed, 66 insertions(+), 85 deletions(-)

-- 
2.52.0


