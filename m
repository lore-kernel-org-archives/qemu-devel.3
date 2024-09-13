Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2355FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80o-0004TB-Ke; Fri, 13 Sep 2024 11:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80D-0002O8-T0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80B-0007pL-V8
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso21937875e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240466; x=1726845266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oz56FWVaoXtsjD0nTboxI30R6YmbWaqPQt/nyHE7yKc=;
 b=bqYJoUNKyXBjIUbjMxSYDztBFzKEiEK7H2F8BXSFAKLQXFqq/2PD2OXKRyQko1sTtH
 xvNBZm11riEp7kLUJa49ynUWwR38PSgJQVtvSsYwE4qM/Ti+JDftcHSGff0Y4BKnX63v
 z2oZOMFCbkp9raDy5ZNCT+iDlzN5gFr77wxhwgm8oeGIv7xhjo/hVeVKbLQbZ2AJgsgn
 FV5QWEQmM+Nw6bwsHffXa/cl/GH++CwQBiFXxKvCRpURZysXjMxU+OSMPY0MnNF1rPZ3
 HEfQKWBTYsVOb/FB8defVkOtv8Y0Vis9uMAtqxAbNQpyoHVghWf5gl2zbRV3/PeQgUZC
 myFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240466; x=1726845266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oz56FWVaoXtsjD0nTboxI30R6YmbWaqPQt/nyHE7yKc=;
 b=Fu6DpxLnj+aiTdzIjJy0GtKMAtNmcoTtkYkGWOS1S+NDdGEKBtWnU7+b2FIFwwXK9m
 W9bnyLoq+ggnmZUObvXptQZ+tnjN2MG/aCoJabfGS63iVUSeMUDsmXrKkQ+ogWDy4HSL
 crjSiPUgX24ErIECBOhHmvBZKCsIynmPoyCWRnH7BpBxY9Kfk50Sqc0Id7NXUKmaDfsw
 GL/IGeIQZZPDIcWhJmhM0VLzCV8to4K+SS33Mx3ilI5VOn7v3UhzZd01+wf5F14hSxQx
 1fn1sHjPZMf27lG6H0mpIDJgBfoA6VRgFsYrb7ChMw5XVGAOzD0q1pfwlDdQ3S1GwYG1
 rBiQ==
X-Gm-Message-State: AOJu0YwHRaxeAA564mCLC0pdglUiridjB1SPpm5pnVoF5TQe5imyvmJC
 Q5mgnE5SaPCT9fxvcp4Z7WmJ93xrNwXB0P9qzD10MscrLG7wo43Wz2remVCOzzZ8iOUPTwDHEua
 K
X-Google-Smtp-Source: AGHT+IGs9qDHqW2o+DRJBFB/gEZPj1X2dgP5MNLyeJS5VxHy5Rezrcmc80c34ciZD2B6jnUJChWLfw==
X-Received: by 2002:a05:600c:4709:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-42cdb59148emr55845905e9.30.1726240466242; 
 Fri, 13 Sep 2024 08:14:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/27] MAINTAINERS: Remove Vikram Garhwal as maintainer
Date: Fri, 13 Sep 2024 16:14:08 +0100
Message-Id: <20240913151411.2167922-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Francisco Iglesias <francisco.iglesias@amd.com>

Vikram's email is bouncing, pause his maintainership until a new email is
provided.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240906181645.40359-2-francisco.iglesias@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c59f7b25382..8be4f524779 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1951,7 +1951,6 @@ F: tests/qtest/intel-hda-test.c
 F: tests/qtest/fuzz-sb16-test.c
 
 Xilinx CAN
-M: Vikram Garhwal <vikram.garhwal@amd.com>
 M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 F: hw/net/can/xlnx-*
@@ -2708,7 +2707,6 @@ F: include/hw/rx/
 
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
-M: Vikram Garhwal <fnu.vikram@xilinx.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.34.1


