Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ECBD3DEA6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 18:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1rfG-0005R9-73; Fri, 18 Oct 2024 14:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rfB-0005Pn-VA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rfA-0001zx-HW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:25 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso22743355ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729275922; x=1729880722;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aJGEOCEmzftCukQzy9/QugNmX9x51GzbaO0ef3BSb8=;
 b=ekRb/YkXCBOYRuQIEPKVE25k6kj6iA4aLvYCZkMsF2IGkrd6ftRiHfR5RfbPFSIC6q
 pavDfd9An0pCTQOKc9az5PhwAp6+KoYW/YUv/30k8dQoTfNsd59XzKdpuf4ht+yXFf5V
 GQCH938BRB5/Qz8SxBGj8BLF5tJzm7+7Eg30PmC15GtDWprGH9rtydRwJwrQlG6exphp
 Kp9VngAQZG68bcYaqwbeO7/QPq7R9DF4pEU6YHcr0IfO2Hpo/arWDwG1/W/UxZOkNmQ6
 aJ5EK16vpO3CtGhL50Lyi8hI3/biIk8Vqv7tOhmbXsS+PoXiuLRcz3khpYyFSvZ9EnWT
 aPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729275922; x=1729880722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+aJGEOCEmzftCukQzy9/QugNmX9x51GzbaO0ef3BSb8=;
 b=ElmMB+fTStQ3H8UVK9oyP5lejkZVcIDitr9FD9hw51uLlsATPUsSk8Sq3UF/5xC+Zo
 aYJ2koU+M6puvjoEO0xB4PQf/vc90SmNRucCgl/J8JuBOsvjNWgZNEUPFFEBMVJzAJYi
 Z/hJYMOWn7zagZB8+Haw0E8szILptY9QPHqrTraR1dEkcCE6TOKvwplxLSDLLo+4Ryp3
 +F8a8T8csdUvXeQLCdvxJ6uFnI8QKb7ngTNhGjKYdjTpSrzLJMgbZoMEYhHk95yHWGzj
 R54k9xYrCzwVbfWArtXwmeJTwLGlJHKPgGivvGjaUFHaJmycgtmoW7NCj0g0APDo6NRf
 kw9A==
X-Gm-Message-State: AOJu0YwqrAC9KQlBRRPDO7dSjZl/tCj8BS8R3zryWHzJvUmKSbffab6X
 DqpGgl7LJk0GPRF5c2ViqEXpXZMpqVKTDaS8Foa2Dq99ZIoN5YzLmAqvfU+xAZ4yua15sXNAT2b
 8iPYSNA==
X-Google-Smtp-Source: AGHT+IEyzg/IBhpE2BoUdMYWZSGVK14EpHv2WOES449F0//UiavNLmPFoljnMxmOZ8NNWma8D1/tmg==
X-Received: by 2002:a17:902:cec5:b0:20c:890c:2f76 with SMTP id
 d9443c01a7336-20e5a779011mr46193985ad.16.1729275921937; 
 Fri, 18 Oct 2024 11:25:21 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.204])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8f2034sm15668475ad.193.2024.10.18.11.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:25:21 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 4/5] guestperf: Nitpick the inconsistent parameters
Date: Sat, 19 Oct 2024 02:25:06 +0800
Message-Id: <c5040310664678890f320783dcd4946a16799020.1729275266.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1729275266.git.yong.huang@smartx.com>
References: <cover.1729275266.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/migration/guestperf/comparison.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/migration/guestperf/comparison.py b/scripts/migration/guestperf/comparison.py
index 42cc0372d1..40e9d2eb1d 100644
--- a/scripts/migration/guestperf/comparison.py
+++ b/scripts/migration/guestperf/comparison.py
@@ -127,7 +127,7 @@ def __init__(self, name, scenarios):
     # varying numbers of channels
     Comparison("compr-multifd", scenarios = [
         Scenario("compr-multifd-channels-4",
-                 multifd=True, multifd_channels=2),
+                 multifd=True, multifd_channels=4),
         Scenario("compr-multifd-channels-8",
                  multifd=True, multifd_channels=8),
         Scenario("compr-multifd-channels-32",
-- 
2.39.1


