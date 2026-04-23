Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872D6F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquf-0007vx-Nf; Thu, 23 Apr 2026 06:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtt-0006Ut-AC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtr-0002Eg-ML
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so5318100f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938590; x=1777543390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PQd8vWYqkY7XkwicXMTKTl7BUfClkSukzruz/1XNzs8=;
 b=hqnD/IAtaHalwhne9biIFgHf2+OBZiBVSM3Np69GBoc5d/yl/WkEqeu1ySVnX29MWw
 5rFuYpZ738J7hytIEVLriwjvYV/EWhPTw+OOSmyMtGhZOBH24vLAbq1RlC1DSU9rM7f1
 CXGslgHM7R2umOPRTY3//gKY5wPaVetV8kdpzgNN0pADbaxFbYc5rr91ib6ADUiow7CB
 s/MDZWXq4KgDomWVN4qP4kPLe9Mj8lZmh190ADgvS5B4or4+JvkSkr5y2UpXPBRbbotO
 nSz2EFiK8gU+sv8PpTVjLJ77C/Lccwt/8DISgDIqsALmzO3Ez71V7kfHjrC6qFAJZPOy
 TSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938590; x=1777543390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PQd8vWYqkY7XkwicXMTKTl7BUfClkSukzruz/1XNzs8=;
 b=oLbeqL3YgO1Y+XD45zYIxAXtLK0851ho9iVFdIqNmo31e6DXOjzQTD49fN/ao9YZcK
 5gyBOPpyAI/W0on1Qq8Z3hdGO3CAhB+0I7ga0Dbg8C64ZV7uEwg9hLCZKAvt8kiFdAWt
 mbUcd+XKNTuYethgVreuTHl/F+2LfIyaXSAeBDE9/wxffUQRMNKiUASkL2QJ9OcLEmKr
 7IXRh49iArKvGeFHXzGmJgcZF9qdQ5hiGTAo3u96ztg3/7LSRo8qAeYrke9xqXquNeYQ
 gI5iE+qnRkmX5iX891NgzC7BL3i2eUterJc4Aw1u6NDp9cQe+Jn6bFEfmdJJPenmjhHV
 nHHw==
X-Gm-Message-State: AOJu0YxXbDsbP5CbhWfwp91jSLqG6X2H11VObdsQeNWrQ1mDBIUynBBp
 O1Lcw5/4vc38MZyL1+myDplrz8PcYrcwzX3qAJiosANzaAMYJbItfiLutQiq4bmEaUDWgYDeU/L
 Abpyf
X-Gm-Gg: AeBDiet4i9NAAf1IfoUzfTxCWhBnDEy2oK/hOF3+AozJHT/ieW5BMK7g4a5j6QGiKi+
 QQOMLY+O5r+HSB15mdfE6cOSHtMvfkgbeDkDFmAyu9Ok1imWfW8eAqAGbgPLNcxAtWe91FbVf4r
 tPEhN+65crC3XNkupd04m1gXG/O6aaRhHnbSccvX5xKOUXyQ02cykXHG/OHyelN0ecIONwNwN+f
 RmHwFNsLnt9z9vkZ0zxPxhbjJnVY9uvAdYuF+FavczjpzU39HSVS5zTXNWfcIXuukDHHE1AO+kH
 m1Mxj6Gq1xg0BpKx/HVwPSbRhN3Io1vOwKDEkzygJ5eqXcbyll/zjPgrN3pqftGRRlMmhbjpT0/
 UnFhHdYQwRiwd/Gdl1XlmETdFo9HAqY1qnK14QEucMRyLMgecyBiaP6yS7weWz3LnbV2xcJB/Um
 CE5sX8i/n2pXmNRQ/z0zNxXrgFVz32Xxi5q8a0fNUmO7XE4Mnw7ypdDliPQ1Tf+D3nCRVsZh5X+
 15xNR32FwybIOJIlCZBzObHUp8fGr8Yheyl6LaSlA==
X-Received: by 2002:a05:6000:1863:b0:43e:a69b:d818 with SMTP id
 ffacd0b85a97d-43fe3e0ab5dmr41387287f8f.38.1776938589473; 
 Thu, 23 Apr 2026 03:03:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/59] MAINTAINERS: Remove Beniamino Galvani
Date: Thu, 23 Apr 2026 11:02:05 +0100
Message-ID: <20260423100229.2941820-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Beniamino Galvani has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-4-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b5b686e76..567b918a70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -720,7 +720,6 @@ F: tests/functional/alpha/test_clipper.py
 ARM Machines
 ------------
 Allwinner-a10
-M: Beniamino Galvani <b.galvani@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
 L: qemu-arm@nongnu.org
-- 
2.43.0


