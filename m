Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19468E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 01:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUyq1-0005Bt-5d; Mon, 06 Jan 2025 20:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tUypz-0005Ba-6X
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 20:56:55 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tUypx-00052M-Op
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 20:56:54 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so17634899a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 17:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736215011; x=1736819811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JWDRZeUAvK4U5nqOKgFhcdv5xmNToSgFPy3WjUmGny8=;
 b=kUvGMEsy5jcZUyy3hIoulm0dfmS+bQMJJ2EGRPNyLJ8E3W/SV0WDx2erZ5MSs9Zwcs
 UOYhe/RBwSDIB5bbWEKXCsMIsILsnLIu490163h1bsPLoZ+4bwPccSu8VVOFaWxcJ2c0
 0+5Ms5+xcvqWp7falb7VnU3Vw+/InDoBKpgwKqWarHNxqsijX0TawUBmUbAC65l5GVl/
 KYSOtTQQTE+mjTVFo0b9yhz+PI4UQtAGtHzGLmcy73vukJzQ2HWv8lB8Rc8HCrhhjQoC
 UrBdRsgFWrN2vW+2RD5GWlZO0yGwEC7RswUL0FggBc4excWgbX9ArGZE6W3qcB19tLME
 exFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736215011; x=1736819811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWDRZeUAvK4U5nqOKgFhcdv5xmNToSgFPy3WjUmGny8=;
 b=LdE63F6z+q0LiuPqpRIWsJlZFMydSqDkLPqylLYNPY9wDpDzNMc1Awi+DTYmZ5cYBP
 6c+T7CfHZmbJlaS5d+45LmaHw//PgHavCptjAORsZKSkzN/990pQJqNYGTBi0wh0z7k3
 3yRReZ3CQpl2MdzToFjxSNrmvhIzvRxokNR/WtxPODBWqSw6CjRtc7qkfg6m7WzOqU77
 3FxbQodiJzYflGhHmXNoV7CYiMYREi5qdFdr0WhdCQlPk9w48KxVcvJDcCGXiPFqqoc2
 tFCJZhk21rayA/CcaBSxaK5SC7UyeXti+HMlxxl7B51xV4hSNzSDv4SnNfTGHPE9UXfm
 57Zw==
X-Gm-Message-State: AOJu0Yzr8TloJhH0HuuYA1hFK6fa6xTh96DikHYuRx2mibVS4FSD9RcO
 diptJ8Ms6ll53HWQDvMgtozpT7tUl8HZcnvEEmOYu5Oh12saFoEK3A7AQAxDJxGERWZtrsXeE5A
 U
X-Gm-Gg: ASbGnctSu9LfQxwqe0SCk9M4069cxmS9AZhN+Nto5bCmgZ0tCSwCuojICKedlnxLpLN
 RGezaZe9RKlkUU9ZrmyseHsNop30z7y4PNLV7AAemaz08tM9M7WL20qdqzDOtGj1obttyf0gvMi
 28m+UWbHPhEl0vftGzycg5tn7MI7xm4fvLVz5dzXJiJZILVeNzmUDTviiHpYV+VMyGr76ha5pDq
 3+eBrhq3lOmsdI0Oay6qSRQlJZXZ6IrseShdKMAkMapyBsVfKQGEWu9R6TR0w==
X-Google-Smtp-Source: AGHT+IGHLmLOSA0wsL6PseJXmU3fFaNJDDLawVChZqyAxx4/tLHRBLoNUg9cZfChVap/lH2Dbeyivg==
X-Received: by 2002:a17:90b:528a:b0:2ee:8619:210b with SMTP id
 98e67ed59e1d1-2f452ec3589mr90077881a91.29.1736215010854; 
 Mon, 06 Jan 2025 17:56:50 -0800 (PST)
Received: from gromero0.. ([191.8.218.247]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4be2b1f43sm16680910a91.17.2025.01.06.17.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 17:56:50 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	philmd@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH] MAINTAINERS: Add me as the maintainer for ivshmem-flat
Date: Tue,  7 Jan 2025 01:56:39 +0000
Message-Id: <20250107015639.27648-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102b.google.com
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

Add me as the maintainer for the ivshmem-flat device.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2101b51217..461f98525b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2785,6 +2785,13 @@ F: hw/hyperv/hv-balloon*.h
 F: include/hw/hyperv/dynmem-proto.h
 F: include/hw/hyperv/hv-balloon.h
 
+ivshmem-flat
+M: Gustavo Romero <gustavo.romero@linaro.org>
+S: Maintained
+F: hw/misc/ivshmem-flat.c
+F: include/hw/misc/ivshmem-flat.h
+F: docs/system/devices/ivshmem-flat.rst
+
 Subsystems
 ----------
 Overall Audio backends
-- 
2.34.1


