Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE125C52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbM5T-0006dK-8s; Tue, 06 Aug 2024 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbM4l-0006AH-P8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:26:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbM4h-0005Pi-9G
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:26:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d333d5890so609381b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1722957848; x=1723562648;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOQvMActrzt/xHT+7NqDbSHUDQOSxWIxZCGBdfJd5ZU=;
 b=fmPdpC1PfGGUk64j5JNpDQIKuPxKXXX/S1NBXZipWJInq0YA6Zr4t8pA0ycPKVFT0T
 1EpYiKuLAtApG/+NR/wEPLHQCGg3sT9/BO7DL6CyBNHyG6HlOLGzl7A1ClrwBXdZHfO4
 LNwsazPjpfoNsI+60EQFUGnO+wJKJlG0b6YasS5RZtSWfyDHFOHdZZMW3mSI1Illa8D4
 jlMYr1krm5X0n3dPx6M/q+8A0L0PZ0lRwY4ZeBUfzOiMjxB4rJebW0CEX68jFragEb25
 LTAs8uxAI1QxtvxGvPJPL4JdTHJmUzTXxbYovqC70UaHDJlNpCD0tppzci1RXPK8cKYP
 5oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722957848; x=1723562648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOQvMActrzt/xHT+7NqDbSHUDQOSxWIxZCGBdfJd5ZU=;
 b=G5Ua/S4qZIqiYAO1FjY/ER8Nb4VaLMlUq3eHw8Cltraabm98fRqqwB0WvtJEWB+NWo
 pZqPm4fX9EKuiIW9VOcOXw57Cut4ONmDx+uUUDehPCuVB4llJj4aCPek8ApdfZzS/GMG
 fcmkANr7eFrSC7PfeVqC25Ykks/K5/b6WZZ9xdkNGJWUbolwV08m2Ax/XBwrMbrC9aP0
 V/N/jnOEkiy5odYMmkUuSO/LCnDjwg6D+TPvbfP/R4YEEQp6nyNw+aKOSG6Sf4XsX/ss
 QweAlb/HWQw15NSQ67uz4rj4mygv05CtiyndMctQFPYcgu/cdtE2Kcm7r79ebo5WJ7z9
 6Ohw==
X-Gm-Message-State: AOJu0YwEeIBgbmfNnHnq/Tzrpx0bD6fVU30KmnJa2D0tGPa+y2nblql1
 KaSsbRmA1wgy+t8S68PUdkl3xXVWKXT6BBKZsujGf2IfkFio0mHTwu8Qp5miGjsr2ks5C7+7cfG
 lUBpKss2+
X-Google-Smtp-Source: AGHT+IG2TtZMMFGTEhRlZoYyC6cmWRwEqwOoUlHfB0XwIaqU+mAgsf3A17R2Lq5mMI4bhoMJOsS8IA==
X-Received: by 2002:a05:6a20:2d12:b0:1c6:9e5e:2ec4 with SMTP id
 adf61e73a8af0-1c69e5ecc14mr15914028637.50.1722957847190; 
 Tue, 06 Aug 2024 08:24:07 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed2d04bsm7059727b3a.201.2024.08.06.08.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 08:24:06 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com
Subject: [PATCH 1/2] tests/migration: Nitpick the inconsistent parameters
Date: Tue,  6 Aug 2024 23:23:41 +0800
Message-Id: <2c2a9e1ade9265f708530029b967e160fab74b6b.1722957352.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1722957352.git.yong.huang@smartx.com>
References: <cover.1722957352.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/migration/guestperf/comparison.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration/guestperf/comparison.py b/tests/migration/guestperf/comparison.py
index 42cc0372d1..40e9d2eb1d 100644
--- a/tests/migration/guestperf/comparison.py
+++ b/tests/migration/guestperf/comparison.py
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
2.27.0


