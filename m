Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FF2C48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUD6-0007h7-RU; Mon, 29 Jan 2024 11:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUUCz-0007ek-KF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:10:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUUCx-0002Mf-3G
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:10:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ae3cc8a70so1534092f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706544600; x=1707149400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c1D1QWxLv9n1FAmCrJuS8BwGpLuNTIMzH6ItcOpVnrs=;
 b=BXOuIN2SBTB/Swz6UWYQkTftak+Y8JUayxh6v4Zvh7Fxau1Ry/VIS1AhO0K1M6qccu
 io2YYzLdeww9V4vaXtdT7UOZ4FvQMT8g1F9HwK/O2TldMw84PaVqogBssAvbcmFnd67Y
 v5W9PhslMzftsWAbUqtgMaa6BuF9lwhxGn8E9iQt1ZkXdEUPDDfG2LnltZlhqn04LibW
 qJKyKEnQKARiooU2d0FmZDyrAo4vstTAc+ojE96BLYLEpkKt+sM9cMQpl+yWGWcTkPQt
 VkBfPcbRXN3vSfMU8y7tsIP1gVRpzLARyFB95Nflb82qF63azQ6+9nFKSZlDfVUb4hhN
 voCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706544600; x=1707149400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c1D1QWxLv9n1FAmCrJuS8BwGpLuNTIMzH6ItcOpVnrs=;
 b=V8A/NY2QTv117MK+Ftr6PvBXL2SR2DpJd/j726s0XDsZGvLKiOoUB7YUSlatt591gy
 IP64Ck4NvL4OPGHkdNIMKKmMXKkRzPoEpPlesbh/YFWR51M3EmW4stdNgh0ikweF3nzr
 DZopg31+Snrl9EbSEV9bLDdTwfCIYS71X30cQbCpqbuD1rem/uXh+rBCjmzSLptitUGv
 tnpEbzHacUqGCCD6Pw1JLuwpiqJU+dHjmXT4z8TbytXSP1/i2cAkXgkCgMuTaAyF0Lv5
 GJnE81YRmdTHnWKC4+RtiqjTzmYpyYOZLt3MWfoZjKYPEEe5UdWWYIr0d1jhN+H3Lv3e
 R2WQ==
X-Gm-Message-State: AOJu0YysVR2iRM8mqHn6c2hI5fVLP7S44IH/gm6YrfXnBnkYK272q3vy
 YrXW0VkE6bFs8gq5mtuekfBLF5L4AtFNqbtDUXL4PYYpHh6aUohgL9+9O7I6qK5fDZENMwryobG
 Rpj8=
X-Google-Smtp-Source: AGHT+IH/bOzdB/hWLHnlC4utuFQ6+hGt+tEbKVS9IZSSoBHTJXpbHWy4lCR3Fz6iq3mXqvJWYwIstA==
X-Received: by 2002:adf:cc91:0:b0:33a:f340:d09d with SMTP id
 p17-20020adfcc91000000b0033af340d09dmr1781371wrj.49.1706544600632; 
 Mon, 29 Jan 2024 08:10:00 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 co6-20020a0560000a0600b0033af4df8e1esm1219957wrb.47.2024.01.29.08.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 08:10:00 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 0/6] hw/{arm,xen} convert printfs to trace/reports
Date: Mon, 29 Jan 2024 18:09:35 +0200
Message-Id: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This series changes some printfs to use the trace event framework. 
Additionally, it converts some error/warning reporting fprintfs to 
error_report/warn_report.

v2 -> v3
<cover.1705670342.git.manos.pitsidianakis@linaro.org>:
    - addressed Peter Maydells's review

v1 -> v2
<cover.1705662313.git.manos.pitsidianakis@linaro.org>:
    - addressed Alex's review


Manos Pitsidianakis (6):
  hw/arm/strongarm.c: convert DPRINTF to trace events and guest errors
  hw/arm/z2: convert DPRINTF to trace events and guest errors
  hw/arm/xen_arm.c: convert DPRINTF to trace events and error/warn
    reports
  hw/xen/xen-mapcache.c: convert DPRINTF to tracepoints
  hw/xen/xen-hvm-common.c: convert DPRINTF to tracepoints
  hw/xen: convert stderr prints to error/warn reports

 hw/arm/strongarm.c      | 82 ++++++++++++++++++++++++++---------------
 hw/arm/trace-events     | 15 ++++++++
 hw/arm/xen_arm.c        | 23 ++++++------
 hw/arm/z2.c             | 27 ++++----------
 hw/xen/trace-events     | 21 ++++++++++-
 hw/xen/xen-hvm-common.c | 47 +++++++++++------------
 hw/xen/xen-mapcache.c   | 59 +++++++++++++----------------
 7 files changed, 156 insertions(+), 118 deletions(-)


base-commit: 7a1dc45af581d2b643cdbf33c01fd96271616fbd
-- 
γαῖα πυρί μιχθήτω


