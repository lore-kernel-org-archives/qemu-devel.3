Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E11BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNyx-0003X4-DL; Wed, 12 Jun 2024 09:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNyv-0003Wj-1x
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:25:41 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNyt-0004x5-DB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:25:40 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe6392eso10219823a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718198736; x=1718803536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z0QNuBoacjhHLlQFHetj58LfpHzHR+p7NA8aWZ0RQNQ=;
 b=gI36jYsLVxXX1FCuD2XTum0svKv9suarYCaQ0R2lZKIgtFtghC7jv+DHe0LDMD+3e+
 vUJQJIRNSyG5nTkCdtElDgZbCvwdS0nS/WmGKPHYy+XmQHxiVD3PjakYbbLKrlHcnLef
 ccqgMvf59cvhaa3XOWfp8jzpWquWB0GTwzZSeIqIlR8s+e8MyRTHcC9NYtqcPMjWlGVa
 n3Yh23YzZlcdn63gUYkOdQaBIHP0Xql6/CTVObBH8pZ415V2W6G1bHsW22AP1xzlsBf/
 EOzeEtp5exQs6xlueJjtQZMouF0f0BzpbVW6gEiPLhQm6PyBQ+FIZoJoDv6MQHLqRLrR
 qKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718198736; x=1718803536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0QNuBoacjhHLlQFHetj58LfpHzHR+p7NA8aWZ0RQNQ=;
 b=kEL3gpOiL+tY+8xOH/My+WeRuj9enpur0FSvXs9DAxoXvc1gEe4OQMIv/MiVXgUmLu
 2rnBVmNzq3ZL1zrSmR/I8nr5H+b8DFwuC9i4NlAMfswBwroBLwC7Nq55Pzx5X/7vB4Jd
 dpJ0WplA2KjCiN/4QV18b6ykj39KYDL43uC+qojPZLBOYWMCCy20g80z040LCidx7G2g
 ms4dMnmz0T5Jakdly6Z0q1610rlwaJRq8FQVOHXrRmvO+14A6i6h/CFfeaMoDANkaY1K
 /FVlXJ0p7Zvz5CFMbPqO7ohB9bVWLxwu6yt2VGTW2dD4W/uinUx0i8GLjVBTBz2UU9Xw
 32BA==
X-Gm-Message-State: AOJu0YwL9g45QzgIj4V+AKKmm0ntXOrm2c8A7qou7C17rZ0bZER7CLnd
 miB+N/pnU7x+0lir6ICu4L7Y2qElS8vwAc5SNGbL7hn2o5ThNe31JL5mCFmSSE2JVvNf1T9gmn1
 k
X-Google-Smtp-Source: AGHT+IFiPegmEauMovQ1UdwwsE9nwBaC4MXJQ1SzF/TqIMYTQETkeSQ/McmVOu3C9huuk6OD68Cp/g==
X-Received: by 2002:a17:907:868c:b0:a6f:481f:77eb with SMTP id
 a640c23a62f3a-a6f481f7b7amr134294266b.20.1718198736520; 
 Wed, 12 Jun 2024 06:25:36 -0700 (PDT)
Received: from m1x-phil.lan (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f408b814esm154946066b.10.2024.06.12.06.25.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jun 2024 06:25:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/3] memory: Constify IOMMUTLBEvent in
 memory_region_notify_iommu*()
Date: Wed, 12 Jun 2024 15:25:28 +0200
Message-ID: <20240612132532.85928-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Trivial patches using const IOMMUTLBEvent.

Philippe Mathieu-Daudé (3):
  memory: Constify IOMMUTLBEvent in memory_region_notify_iommu_one()
  memory: Constify IOMMUTLBEvent in memory_region_notify_iommu()
  hw/i386/iommu: Constify IOMMUTLBEvent in vtd_page_walk_hook prototype

 include/exec/memory.h | 4 ++--
 hw/i386/intel_iommu.c | 8 ++++----
 system/memory.c       | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.41.0


