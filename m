Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F326CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgFK-0002d1-Na; Wed, 20 May 2026 08:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wPcqV-0003Px-62
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:04:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wPcqT-0003Ae-HA
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:04:06 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-83f674f978fso1458225b3a.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1779267843; x=1779872643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V8l91KCbhmmMOGdEL5Jr6qsO1Ke07nQKSiZ/N8ikqRs=;
 b=OoJ55OcCjEGtkbjDhj4sDOIiuGRe6Qn418tTPC5zj8DDbEyukLOHb7LzsNkNB9AmQl
 ZaZX9QnGiZ/7qfB2j2ZxFtCRfOrDtmQitSakraP8GrbC9F+j+K5diu9TnfBdhKw4l2wz
 69W9lEEYanAnD4A1MGzz2+XFj44l1VcftAV3xi3H9/Y3jAYCwWjsfiFGNhzdhgfippqc
 Z+muNoYGbGVBMC7DPVVZwbffq9EhkDf3/u3R1PuCQ/7aIE3LWQ8KgY2QyWpdgsQ94iZu
 cCQI/fCOQX4Fn5xUN9hYgh7V/2TFSxkzgJ20dzr5Nlh+ZvAgfK6oEL5XQoWV4RS0X43n
 r1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779267843; x=1779872643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8l91KCbhmmMOGdEL5Jr6qsO1Ke07nQKSiZ/N8ikqRs=;
 b=EIipvhqku2k4cnLhPG4ZJCjpybr85nk5wcS2m4+Ln7kgwdQw3RQZJdez7NaLyBoT+b
 HfkBlKB7mRADSy/CsEPtgcjjjfnJTTCRp4sCXw38ZhM/NhT06zSYWImNSdG80rGMT0UB
 05qHZpf+Grnyq3Si0yQe53VM23Em0yeTVMbS332RMDqyika1pbVXV746kU6yyCHMhOcX
 jHsHkwMBO6PMIWWt+XXg0A3VDgwT5NGp2H5rQqnR9CSFWws3pDDRucE46hwNz7H728Pm
 EYymzFlLXo2PDXM0NK/kFWH8eQKdUP1Ktcj7xYghTDLFISVyMgILWPugTxDsLAmGvXSq
 y6jA==
X-Gm-Message-State: AOJu0YxsofRxwhAkm2EW0sLI3i4xMyuniXVty+vKCm7/URVqJ5B9l4ji
 AMNx2Q0ZzSUiiZpu81v1WJd96u1YrDOh40fj1Y9EQ8MHsVOQGfB4JFjrKZSg15PFGoVsHFWVt5S
 ho3mRgruv1Q==
X-Gm-Gg: Acq92OF4J5cae/BZJc4GKU5zGufJOfBrVBVQ83Cn18ousvOWkPbmVn4CQ/hRneMILUx
 2Ep6auVdMKuiQ+FfnmOuTVAsTiFnBtFd8YVvUTs9Ps1ZnrSEqZuebEIKjbGG71mmbNN2+BilCea
 cIgYDntxbaQ8heTWjr0eu/HFdD6pKDWTkZp8XFZ+zP6FwfT152HLi3k2NTQ8Q+XI1sLiz1XcTFM
 ZL2t9SJEgk78906JiLMGzZ9fV/bgxYl3fCRMt+b7zjgQiWEXqZiwZ7xx5LRdP7PXk55HhgVS6xj
 DceusB81PDliEOcqR14i0HUNmJ9Yi/o3N0dmO8MKwRD5FQzu4oQ3ycsTYAHkg5wTxiIsvzqJAs+
 RDSHHjE9bMxD2g85hKSAMHS3K0KbfSAfhDCg5AXJKBi/TgUGDWLxYY/us1hNMONgsLyqRXMiyvc
 kaIyR8neO6XwpwqHIwIMLO8splbUHWd7LTExY16WCjb3xeA5L2fHVPUJ41dQ==
X-Received: by 2002:a05:6a00:429b:b0:83e:b125:ff30 with SMTP id
 d2e1a72fcca58-83f33ab698bmr23397260b3a.7.1779267843157; 
 Wed, 20 May 2026 02:04:03 -0700 (PDT)
Received: from localhost.localdomain ([103.114.192.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c78844sm19591743b3a.47.2026.05.20.02.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:04:02 -0700 (PDT)
From: infra.ai.cloud@bitdeer.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Hyman Huang <yong.huang@bitdeer.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>
Subject: [PATCH] MAINTAINERS: Update email of Yong Huang
Date: Tue, 19 May 2026 16:18:12 +0800
Message-ID: <b3bd81c3d9f425bb750a76d7bad7ad0284e55123.1779178180.git.infra.ai.cloud@bitdeer.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 May 2026 08:41:32 -0400
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

From: Hyman Huang <yong.huang@bitdeer.com>

I left SmartX two weeks ago. Update my email to stay reachable.

Signed-off-by: Hyman Huang <infra.ai.cloud@bitdeer.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b75f3222f2..1308ee5a0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3784,7 +3784,7 @@ F: migration/rdma*
 F: scripts/rdma-migration-helper.sh
 
 Migration dirty limit and dirty page rate
-M: Hyman Huang <yong.huang@smartx.com>
+M: Hyman Huang <infra.ai.cloud@biitdeer.com>
 S: Maintained
 F: system/dirtylimit.c
 F: include/system/dirtylimit.h
@@ -3794,7 +3794,7 @@ F: include/system/dirtyrate.h
 F: docs/devel/migration/dirty-limit.rst
 
 Detached LUKS header
-M: Hyman Huang <yong.huang@smartx.com>
+M: Hyman Huang <infra.ai.cloud@biitdeer.com>
 S: Maintained
 F: tests/qemu-iotests/tests/luks-detached-header
 F: docs/devel/luks-detached-header.rst
-- 
2.43.0


