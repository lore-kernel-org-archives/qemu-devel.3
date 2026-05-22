Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ED5CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPR5-0004iX-GS; Fri, 22 May 2026 08:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wQKv5-0005OI-Gm
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:07:47 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wQKv1-0002jG-Ru
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:07:46 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-39396f873adso104058011fa.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779437259; x=1780042059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nPhCP0TNqZBQf/eUZJjjJdyyip7nhjXYU1GYT6M/8i8=;
 b=ebIj84/mIY++KYV+M9u5PLqkpitm5tO28luM0fG8MU8DEB7+HwbFORcvFYAU/rl/2F
 tSpBmn/6BWgD94RO75ZvnjswOObdcMPNBZB8ssN+X/kb183f8bUCrt1W7E6sMUPpr/tI
 mQPq00+lDiX7w5CTZ6dAi7lVBqrupdM86j0sNxtijexDr38cgAbxWbdbAf0Pm6NlVuCZ
 bKSi5dw+J2U5VoVSEzdzgXamk/M+VUt7wp/EMwq7sgqFJnncl5D/m17qil9cEFw/HBki
 Sw3FRwMOZsn0wzAJlN0o//Pv8Oetr+GapU2BaQLavVu4R3nBBVcYvtLDUL7NzLZAl0pK
 yvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779437259; x=1780042059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPhCP0TNqZBQf/eUZJjjJdyyip7nhjXYU1GYT6M/8i8=;
 b=hMtx5BlvurvwGLH2aLl8CZEbMop1pxyG+4iqygy6n0j5/sNz9g0sUyDAqnLll8JRCp
 mqVZVImnuhh1bPW8372aQFEwVWFTpqRfo83Lp9tKY2eu4EIzj7mHpmtxNaTTsOrq1DNE
 Fnj3/5M6NxVOlKN6OgmaTB5UIFdYQ/v8n4NfcfBV6m8oFEV+E1CekpvHgU2kAd8tKw49
 O2KffpkZS1qU87WXCRnxBZYuDQ2klG6SHh1f9XlaNv5hWetCuFcCA4AvT5mUquq2CQG9
 CIdn+Wl8QhDaLwP2P7YtjJK2iAuxn8npNnnNPjXpxo8tXAepMwyHrEYxPgXSRZXdwsf7
 tc5A==
X-Gm-Message-State: AOJu0YzsSYFzjhIAAkYVClpkt9DUwDZWnMa7sKdtCc+4oEUegaxng3d+
 iOsBkkSuIYzpQiNRNvfvu8A/WQV1A85iPs7zifA8dSGDzZsSETc7KH7CQu6n0OBtCyk=
X-Gm-Gg: Acq92OFwTIrt1dK61lKsJEuGWohVodyyFO+TcVSq5QlUj9CAr7wh3DKYP816mSAvv+M
 6ninXp4gJK+p27Jz8IyWjCBKP/hH3SfjeCmhuo7zuZh2M8gqy/9t3vn0caKHgRlTpaHkfw/6doz
 8WJFdkuSDtAWl+4xWd53UExuSJDhIRVvl9io+RZk+sWTOPoLDSy7XPO1y4i0gd/2uzRA2s2zhla
 YRFh4Z/dI6u7MEZBRDqMe9Qi90tl3lKuw6AYloUpJ3lAO2jfv+CsILx3K6FuBgDgS+92bIcuPQO
 6QvzAhv8j+YXWzs9sC4F+U8lUd9rjIkGPVykLJD9wqMCy1Addw9A+9c4708khJFAkaNu/xlSgGj
 06IQl/AXfFwhIqnw00JsJEPe1S8bwiJaw/tpgMhexbFjVsfPfh1JJItlblZGQL97QydN7FxeC6m
 Kf2bR8UYeKUMJP
X-Received: by 2002:a05:6512:1084:b0:5aa:b6b:f6ef with SMTP id
 2adb3069b0e04-5aa323d79e6mr672703e87.45.1779437258424; 
 Fri, 22 May 2026 01:07:38 -0700 (PDT)
Received: from machine.. ([37.113.215.232]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf95c9sm239722e87.78.2026.05.22.01.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 01:07:38 -0700 (PDT)
From: Evgeny Kolmakov <randomjack94dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jasowang@redhat.com,
 Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PATCH 0/2] Mechanical conversion to QEMU_LOCK_GUARD
Date: Fri, 22 May 2026 11:06:42 +0300
Message-ID: <20260522080644.9531-1-randomjack94dev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=randomjack94dev@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 May 2026 08:57:05 -0400
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

This trivial series replaces manual qemu_mutex_(un)lock() calls
with the safer QEMU_LOCK_GUARD() macro in
  net/colo-compare.c: colo_notify_compares_event(),
  block/io.c: bdrv_co_get_self_request().

Evgeny Kolmakov (2):
  net/colo-compare: Use QEMU_LOCK_GUARD to simplify mutex handling
  block/io: Use QEMU_LOCK_GUARD to simplify mutex handling

 block/io.c         | 4 +---
 net/colo-compare.c | 8 ++------
 2 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.43.0


