Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08BBC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUu-0003BE-7a; Tue, 04 Mar 2025 20:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTq-0000hB-8P
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:26 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTn-00074U-R0
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:25 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so4770627f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137802; x=1741742602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QUbgFdH+LpUBvr3jWV7pVNPKK1k5LRXJFBmyMiAPQM=;
 b=w3W9wYSqKFkjVuCqfdOLwMdquHGCBVKpYoj9WukBRl5bx+EQbr2OGAa5H8v8QOQEXF
 caJrjlA3eMhK/j8+tHyb7oGD1ALNP9ShShZQiMIu/3MX5oddODay4RuVM323m8mwXTIq
 sjbax4sWgdspIq9NR+O2UDiFzTpR5nW4oprZOOKvkctfBYXyKJ2oXXWBo1Susl5gXstG
 bNngnxdn80ai06MsZYJoLTvAvCh6wUWT59T5bAPIPTzVXGJXimKywgTkalOvbr2UaBBO
 iN9vco/msSJW3SAbiJemdCGZd8LRVkR/ECXkwTMDxDzzCoo9eGRoNoT0TxdAEZMw+Z/x
 Q8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137802; x=1741742602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QUbgFdH+LpUBvr3jWV7pVNPKK1k5LRXJFBmyMiAPQM=;
 b=Vz4jvsl6zDc5xHHPmP49huC14ao0Uovyl6iUR44kBImJWFK24EQN/ZOCT9I8RWCWe9
 lblms1Yh8YlBtRJ1I86ZzIXxpyyxU/06sO5XuCgG62dBd840ftxxLxnhjluDauL5tjP1
 +M58XdyDWokAveO9QGFJB138LOmfErozwU8B+WGhn3902HiybWF8En/aVU2ko9JfKglC
 KCx0uOwScq2PjFQtMBNE839QhVswJ6rW7erYS1Tc6emda0vHHubbAvgn9Fz0Ut/L5MJB
 T1nVPjzMRc1jYI22U9zmrKRIIunDyaQMhtfBjthuR5aN++jJKl/D8I23OmZEFFsexz7G
 J9Fw==
X-Gm-Message-State: AOJu0YyXLWmDASvhemRVfDg2aUQwO4tHXD9nMi05245ydgmLkv8o8bFx
 kkCLRJMl5/VQ+RfvJmsKk6ppJhvpA9QdC+gnp12WsCde5NWUEZx9jsrvhouIAgzHX9ecfUbLkQ3
 kzec=
X-Gm-Gg: ASbGnctFCZa+j+qAZwdMfqIS2QitlFoN9vKYEA9cqWkbCJuN1gmBQLCYMCbDurcOVP/
 9PEUgrvNs4SHxtke948eWDM3dcs5zlyXHRHZKdfW/BEKkdYQLngwAMgkRW6u+nsi7BJmHWYAjfD
 nBnHf6ya/Oji6rk+BVqe5jVF7wOIRrrQEUKblfGbImeryUrdv6DpbbYPSnlxe/ds13O+GN2MABO
 lkNfEcydpxrdFJuPuhuKxbq6S01eXId4Eie7RZfG7j5OR2spmIEWH/Fz5jO8mj6TD4W7uX3nasG
 F7nDpRAZZjDj/01yOolxSOkU+bJFaBo5j65e0qilQC/WIkNR+zcDLNykI6tJUa9D9ShtJPEcgV5
 Gs3wRfRwxIQVWY+yeuLs=
X-Google-Smtp-Source: AGHT+IHkhqNryqZFpM238fJOfII6PO1kZdEUeuykTBuEcIfg3+vfRMOl2LupPUicva2CG9Jz0cGPKw==
X-Received: by 2002:a5d:64a6:0:b0:390:eb32:3fd2 with SMTP id
 ffacd0b85a97d-3911f57cc31mr909806f8f.0.1741137802156; 
 Tue, 04 Mar 2025 17:23:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795978sm18925528f8f.3.2025.03.04.17.23.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: [PULL 17/41] hw/xen/xen-legacy-backend: Remove unused 'net/net.h'
 header
Date: Wed,  5 Mar 2025 02:21:32 +0100
Message-ID: <20250305012157.96463-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Message-Id: <20250218162618.46167-8-philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index e198b120c5d..2d0cbfecade 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -3,7 +3,6 @@
 
 #include "hw/xen/xen_backend_ops.h"
 #include "hw/xen/xen_pvdev.h"
-#include "net/net.h"
 #include "qom/object.h"
 
 #define TYPE_XENSYSDEV "xen-sysdev"
-- 
2.47.1


