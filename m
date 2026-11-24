Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB9606A327
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o1aWp5vF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnHE-0001Vh-1M; Tue, 24 Nov 2026 04:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnHA-0001Un-AV
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnH8-0007sB-Hy
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:24 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so36510155e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 01:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795514241; x=1796119041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DK4s94WLMXirrXaDesQfMUQKpgYxGP/0yCSUedmqLRU=;
 b=o1aWp5vFZ2ya8tQpAmA/z+HibFiH7nYbjTH6VGUcAARQsaklF0Vc2/pi+pDYyVhvZl
 agsQKaI3ERCahPpGCubFoqMveBnuTGsBA3r1XEvCCcj38JO+ZyMopXbllYnqPpZ5S/br
 7hROfWFFAXHihogq4fllU4GhWTPDZT4evb3Wnb0va4pQ2NxJNyig/4lMIjkdZiJZ1sTf
 Kz3jZG1Te956hTYrqsMr78MaSzzYVYZE8hkXRtQLnUJLya8+XvrrMT/TNK6XmCfncJ5Z
 h44Oka+3Y8ScBZu23CKrVL50A4uVI6CyzOg0kZl5g6t5U5LAc00cmP+fyFRfVjx9N4+w
 6wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514241; x=1796119041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DK4s94WLMXirrXaDesQfMUQKpgYxGP/0yCSUedmqLRU=;
 b=QP29P/80QTqzLpcK/NfNE9cbACGkdHwDV3kWZ6eNw5cnhzd7RADdw/BQP5qvxSJf0r
 1RcktU38lP3PmvUEMWNDWMdhPKQiUU1sH9sttOqC1m4PvQp1RTBo1w3A47pZvGGBrfuf
 a1IDPYgUwhsWpswL2PkA8ZpcCh5VhKv717aB2sWRzXBUCp6ryLG7AaXkynriU+kSKeil
 pDvWnPpNpjNo1Nihx06KD9GdCWpDc6L+yXDQ5xdfZh3AgDBQ+dhH196QPwkfg9hAAv0v
 hXdQfQ2QnL/vpa2u8W88fEOK8DzldBoBvt+KF97kvUlo0UEpSgsBOk1KwLRa7Dz/n8cE
 UgAQ==
X-Gm-Message-State: APuU4Z9Bed0dsWZVK6pmjWwBa5rr5JbGNbaJ6W8NEbx7qt//G9CAKb0K
 tofPkf5EChus5/5BeiH0Amg8PYVhH1A3+0bjfKvuqhB1bYWzMjgbaEQqbQtmxpFTzTu27Xil6Ju
 sXUdN
X-Gm-Gg: AZFdTZcBB0Yd3MQTUv+nAAJkeTSFfM4GRK/UuTaupQZcCn0RD62Y/CWwb3TCGK6yTvA
 1Q98jmtEvK1UHM0skgw+hb754pp90JI4rVtlpIeSrbt1+KWStWSInlVOKMPJCZPfZ3iB2pM7sLw
 DXG+12nl7TrmlzdmZnKtrRyPI+xBMdZkFvibvDQjdht+lMt4VY0DYrxKUYjbWHvK942/6hpzagG
 f0WIT/NugPHD1bA++etFCQ6OUYKV50SgLYHzFAxKz5p/a31e9K6qVufh7CzFzMidieuac8Hsuz3
 2AlfxSjfutherzyK/5FxncdCLjh+S5dQVVrsyioRHeXuz2lwHV4H9dte1773LjK0hpcNIhaYOLU
 FCNgLjjmRrzNdrjx4EYnWmrC6QtGCSyRDtRLcaOqVI6lX2K4HT1cG34HB9r1iHLragMFN/03Bxd
 4IYrilNACjt4t6Y2hDIq4PIP/RAc6VJxNcF9lC+HzTmrSvM6ooRzwiEfZKqF8rW29fNMYhFd29P
 Ca97CMsMgHnf6lnn6PjXeL6cvzwesm8jKI2OPmLtH5B0uxxj7ClyK/BrXaYrtJ6q0WwF8/mAFB1
 Kg5fm7gO9Z7cBvgwEMCk82W9hsw2gycWCoX+3UaVAJg4Ci3MYzbbOmxRlFl7yKIlz1wyeTZZ7PV
 TjAZSwHv17kvWFawLJvLGOQDdE5Wwn6azew==
X-Received: by 2002:a05:600c:1389:b0:4bb:6519:477e with SMTP id
 5b1f17b1804b1-4bb88813b35mr291173895e9.17.1795514240749; 
 Tue, 24 Nov 2026 01:57:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm783591885e9.4.2026.11.24.01.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:57:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH for-11.2 0/4] hw/display/vmware-vga: Fix various bugs
Date: Tue, 24 Nov 2026 09:57:15 +0000
Message-ID: <20261124095719.4126146-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes various bugs in the vmware-vga device. These
are I think 11.2 material, but as this device is outside our
virtualization-use-case security umbrella it wouldn't be a
disaster if they drifted out to 12.0.

The bugs are:
 * https://gitlab.com/qemu-project/qemu/-/work_items/3870
    -- we don't check the width and height in incoming migration
       are within sensible bounds
 * https://gitlab.com/qemu-project/qemu/-/work_items/4898
    -- the guest can set a width and height that are too big
       for the configured vram size
 * https://gitlab.com/qemu-project/qemu/-/work_items/4519
    -- an annoying "multiple things at once" bug, of which the parts
       not covered above are
       (a) we didn't zero the backing memory for the scratch registers
       (b) we could be tighter on checking the validity of the
           fifo_stop and fifo_next registers
  
thanks
-- PMM

Peter Maydell (4):
  hw/display/vmware_vga: Zero-initialize scratch space
  hw/display/vmware_vga: Check for bogus FIFO_STOP and FIFO_NEXT values
  hw/display/vmware_vga: Reject attempts to set resolution outside VRAM
    size
  hw/display/vmware-vga: Check incoming migration width and height

 hw/display/vmware_vga.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.43.0


