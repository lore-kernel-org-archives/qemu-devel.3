Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1834E7718D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 04:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPZlS-0000Ge-D6; Sun, 22 Dec 2024 23:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tPZlQ-0000G7-Nx
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 23:09:52 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tPZlP-0001PD-4N
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 23:09:52 -0500
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2165cb60719so34737635ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 20:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734926989; x=1735531789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JPRqhMMf2OJZ/4ZGMyzVwFYbZ4UoQtphtP2rZJZe5+M=;
 b=KNwR5AvJyAB4G1JIv1EhJbD8jEHuX86/sWbH//9DKlCNIedGNvh9fQIudp9fQNOANk
 2vyW0CTUREA4rid8kDW3opAL7pkfs+Oh7EYrUkQJGH++svJqHTeTsHoDIjRuxEXs5mR8
 jrtNqrPR8d1PsNGqfHZaVdG7+Xm8otxQctG6mFIWyJsp3SQ7NjTFlCoOzxtIpsJ9ExU1
 Z1hPaRlGeefE2YjATv5GTKIQMFTC0jF3cQqgkDAxq676am+brd68J1jqqYC4/soXR4J5
 EZGae6B3rMWAeUN6/EGemc2gnDC09C5M0xTojxxRkG+SMTmlqyDAJIhY3o1e+X06/zag
 O7nw==
X-Gm-Message-State: AOJu0Yy8ALy1HfOCYv699vhAfuKlNY1+wmn7DZVcKv9b64VfStHyMiXk
 ClILFMxJ8CNVr5jerOH/ZUcmeTm0g0lt+yGfmG8xAz7hUtXea5P92aGjRA==
X-Gm-Gg: ASbGncsGi6nxy4Ua0FIg5IGZsEOPs6zMYnaK343RLYuiVYvvmoL5o+DKsw+pzluNOh1
 k+0+TU0LKKdJDcSDOL5lGnj5EDHlbGm0jvQzhKiNWUMQFxm2chP8SUA4CqT2KPKS5dJZb5xMg2U
 PKssEg/by+itfOHYj4QOAfnq1lEqbv0L3rxrj+XZOsHy8urrCb3hIxAEEjdc8Rv3DIWH3OEpeo+
 TJjbkWFDmlSeEElbgxoBayMoTHjgst7T79mn2tE4YJTPPFiDDjiTpYj/PA5EDgh4fqu4ttNLyUA
 zGWAwNjThA==
X-Google-Smtp-Source: AGHT+IE3nCayNwWz6yG4y8B0PREhN0nlQrWAvJzmpFAzUBnmnhkdaBRkq7nTN4Ok8YLVjCY2iQYJ9Q==
X-Received: by 2002:a17:903:2acb:b0:215:6b4c:89fa with SMTP id
 d9443c01a7336-219e6e85aacmr149220195ad.8.1734926988612; 
 Sun, 22 Dec 2024 20:09:48 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c02:c8b4:911f:687c:35b2:bc4e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f4429sm63921115ad.173.2024.12.22.20.09.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Dec 2024 20:09:48 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Disable unavailable features on older macOS
Date: Sun, 22 Dec 2024 20:09:43 -0800
Message-ID: <20241223040945.82871-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.178; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f178.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.167, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Some features require APIs introduced in a recent version of macOS. Currently,
this is not checked anywhere and so either the build will fail (if building with
an older version of Xcode) or will throw a warning and then crash if run on an
older machine. The correct way to handle this is with availabilty checks. The
checks are a clang extension that only works on Apple platforms but these files
are only built for Apple platforms already and link with Apple frameworks.

Joelle van Dyne (2):
  vmnet: disable unavailable features on older macOS
  hvf: arm: disable unavailable features on older macOS

 net/vmnet-host.c     | 48 ++++++++++++++++++++++++++------------
 net/vmnet-shared.c   | 23 ++++++++++++++----
 target/arm/hvf/hvf.c | 55 ++++++++++++++++++++++++++++----------------
 net/vmnet-bridged.m  | 18 ++++++++++++---
 4 files changed, 101 insertions(+), 43 deletions(-)

-- 
2.41.0


