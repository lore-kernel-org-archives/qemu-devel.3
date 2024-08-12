Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA68C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUkj-0003rU-9B; Mon, 12 Aug 2024 09:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkg-0003py-JV
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:22 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUke-00045r-TZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:22 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f035ae0fd1so46982211fa.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467978; x=1724072778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnvsVFgAwwQYqvVPxF+lYxfpYXdBbERxwoGEJpJUJUI=;
 b=E3ZkjDrq2BqsR83/DJJcwnb85eiv7xKGN6xN5OicuK3nKNrSK/MRUpShpZng40BwO1
 1SG73c9c+1VMuzCfIx8MerlCVLv5Ci8SW9AVF8USeFhNiB8FcAyZNRv22C+YLCQnqa4k
 Z+1WI5Fhkiauc2io4nVoKDF/Kdpst2Wq9iT1PVPGuqWfXMxj0QqnL53StE+5WnMrWelq
 v/7gnSKeBmAty92sCgh11C550UIwEtiJPgQR4vGyYHDgw67BJaCUc/38FTgd0dPFOCtJ
 oCYQiV3jcyqslkLd6T/0YJVcxL+ga1D2dPrBnL6K1WFbpa831gu6VrJE6hPqGE3HYyX5
 ru1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467978; x=1724072778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FnvsVFgAwwQYqvVPxF+lYxfpYXdBbERxwoGEJpJUJUI=;
 b=bnExakmswpuAiIyxOW//WYPbv4zFh9H8RQXuFxrWHmIiipwKIrR8xLp+59/3FQYMJR
 7YmA0z5EqG7bC+GxnmF7PyzmM9TdCh8Rj41DT2vBxj8MglxITm5+JvnJqTqpRNMA4Bd1
 RnG5iCg+HXHXYFfu79a/1OYUt171gBoKHopT9ofpG3d6o3QcWdae7RStD0ygs7DFbi24
 lGeMV39gbc58k/Gr/bJUkq2/QMW3/kuTf+MzGFZpkr8NzLdvDCW9gJkMv1ooY18iWIa+
 O65GM6QUxhLx4nibEKGRcLZ5gIOWKbjNT735jP3GCTl0f8go0akjgZXqzW+9XZcKbbNp
 CEhA==
X-Gm-Message-State: AOJu0Yyt1Tmb5vG2rb4Rn8uCfioNBTmWm8jSLqR6WUzf6HStTcvp0rxk
 nZFV6G6CWFvYXeucWWdRZ0Zi5dO9+/pMtLjEs/4kpqS33y3XR2ieJ2KAxf+c
X-Google-Smtp-Source: AGHT+IEH+rt8R3wDG+QKY36k4z1epabtE0qsH5Q2v+VF3qRP2OiK5eGbpOcoKlfiNpSaMtmPoTatVw==
X-Received: by 2002:a2e:721a:0:b0:2ef:1d79:cae7 with SMTP id
 38308e7fff4ca-2f2b714cfddmr1523661fa.14.1723467977110; 
 Mon, 12 Aug 2024 06:06:17 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f29203d817sm8573481fa.99.2024.08.12.06.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:16 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v1 01/10] MAINTAINERS: Add docs/system/arm/xenpvh.rst
Date: Mon, 12 Aug 2024 15:05:56 +0200
Message-ID: <20240812130606.90410-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812130606.90410-1-edgar.iglesias@gmail.com>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x236.google.com
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

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10af212632..a24c2e14d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -559,6 +559,7 @@ F: include/hw/xen/
 F: include/sysemu/xen.h
 F: include/sysemu/xen-mapcache.h
 F: stubs/xen-hw-stub.c
+F: docs/system/arm/xenpvh.rst
 
 Guest CPU Cores (NVMM)
 ----------------------
-- 
2.43.0


