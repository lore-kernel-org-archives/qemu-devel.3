Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FFFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUkl-0003s2-2R; Mon, 12 Aug 2024 09:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUki-0003qT-2L; Mon, 12 Aug 2024 09:06:24 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkg-00045u-2o; Mon, 12 Aug 2024 09:06:23 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f189a2a7f8so44355201fa.2; 
 Mon, 12 Aug 2024 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467979; x=1724072779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0MBRxvJH0y/bIJK1xHx6k1kVCY+2jxCQ2h5fP5Rdc8=;
 b=GC1Fa9CLRQTiJR7TxBqPA1ioj6d9KlQTjmH5B+8hf6Pfzz+75i6vguK1PzXHDubp30
 kBscQ1la7hb1R0xln6n0+EncRYnY/Tn9H/plIzbM0oVhvcpA6M6+SLwDfNu6yo6Gxyzs
 AxJdjEeopNiham173tI3C72t5ARcT8+GovPqMIhSNiNeZTzjJl6Nsm4t7Gnmqo69RaMK
 zFelu1R2g+H6G0nLYpKSZ4UZqZagmPBBb6giSFrUyt2LC1jOZiiUtCiT9jkxgKDBqVKV
 kza5xVk6tGQnKP9q/AlBD72srPohx2rH+3IkfTbhKfYRRov4P+hX93wr1gxg+eSWCCdb
 ppNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467979; x=1724072779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0MBRxvJH0y/bIJK1xHx6k1kVCY+2jxCQ2h5fP5Rdc8=;
 b=kl4LX4lrMvW8v+oUdYhnvbGDV7iuopre2i0ouy9K1YYXaFmhwnMh2bfRmyLI7VBWcz
 M1N6gwJ/6VdsMHiNMlvxB2jOBFgw5mEw2EF7LiMRt7E/MpCm7ZCEOsUpwauuyH0hTcZS
 F+ay3jWAyzyEvsdYdidb1GytXwnSgwQ1jV6HY7jWrEys1GDFlNtHZX9jzzvB0hJsIv2H
 h1o0d9CbjvTK7ykaFnP+6O+5VCYheiIxfz04PBWhaG0jVAp+ochtB2vOwek3i+I3aO48
 zb0lEjIYfoczFq148ZlJfvUY+qqZ7SktXzHt2hxW5qt7XX8BRO4rOFuPMD4KT0n1vOux
 kTBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkMchgDMcNwifw3SynlCHqIlo5QRwvcAiDKwMDxyo3fV5CpqHCEjaN3WtlBjo7HlM3P6Em+WeY54CMKzC60yZBN7ZI
X-Gm-Message-State: AOJu0Yzd/RdXEX6Hy6Dk1kVlfmcI6Ve/EJdXCfnUb/oj8zhG3hZDClFL
 +DeFz6vVVlHIGBKu4Ovop1RlMkar3xDkizNHQVqdoY4fZfWhRnGMgXvtbO3e
X-Google-Smtp-Source: AGHT+IFl4ehD3FYz4UFHWYeyrWigmFf76jU/CdxDFMCU8WOzXI0nnlPyTlTXorwYYcOTf9CmvnlIAA==
X-Received: by 2002:a2e:8e6e:0:b0:2ef:2b45:b71d with SMTP id
 38308e7fff4ca-2f2b7154f70mr1527581fa.24.1723467978593; 
 Mon, 12 Aug 2024 06:06:18 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f291df57cbsm8687111fa.52.2024.08.12.06.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:17 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v1 02/10] hw/arm: xenpvh: Update file header to use SPDX
Date: Mon, 12 Aug 2024 15:05:57 +0200
Message-ID: <20240812130606.90410-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812130606.90410-1-edgar.iglesias@gmail.com>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Update file header to use SPDX and remove stray empty
comment line.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen_arm.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 6fad829ede..766a194fa1 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -1,24 +1,7 @@
 /*
  * QEMU ARM Xen PVH Machine
  *
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
+ * SPDX-License-Identifier: MIT
  */
 
 #include "qemu/osdep.h"
-- 
2.43.0


