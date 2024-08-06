Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E58C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbM52-0006Da-E7; Tue, 06 Aug 2024 11:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbM4l-0006AG-Ok
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:26:15 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbM4h-0005OV-9G
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:26:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso671195b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1722957846; x=1723562646;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7YJ4MFV7ndRFltWppm8h5pR+LThRMFuFUpsBhx+Bb+0=;
 b=GFo/bbjrGax8kdhapL7fqyd20aqCAEOdzW6/a+FrGbOfNiDgKh2TFm5SlVxwnprwF+
 QLvrxW8KfeHUmOW9DNx0riyK3OS6EW06uqnkDMiT9eTxwbCOG0R1oLVGg3HvZHO9gHPR
 RBfKIWQHjv14qt03YuYmCCEiFs8j7+BclrLWXdhpjnxuEqCra3I/p6cvIXqPYXSXM+ie
 v+EE++Rw5mjnXzJ92Y4ZAv/F3kmOgNYZVQJMgn4gKS/bzwpcExjTjvoSM1n48DWcjrd/
 L6kPL3/ojAnQEuqZYIvnSMUJV724BMqahD8gZgPFP5x8iOlz01DMtTRTqRZb5y4ck/Kv
 ywxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722957846; x=1723562646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7YJ4MFV7ndRFltWppm8h5pR+LThRMFuFUpsBhx+Bb+0=;
 b=tMAt/stUuP2s2nCrx3/kXxv9yp40+ldmpD/hR1i/j/cz5nKYj8IobN6qkM7dDweMmJ
 Ji/dRm7A7dtZbwMP+7LB4TbB5kdzA8ndcSRRMYG0Yn11QaaoXevFUfoYMSF58tErkoD3
 tAT0t4VgAleHFnn2NrA4l/MwbvNQCNFi3ICsR908a5hR/9fKtmdNuzM25P8FxJ/2H6/j
 vgO4KPMcvlN3jNjJqdgn2aDepGWNaQje5uGyUMjPyGNfSaRskUw5M6yeCZ66qgdVS+va
 nh/LTZ4JFm4sh+4Ih0Gj3rO4ANdMVbY5b8m7WopQ0LgLJx/4KcMFJPaW02j5PXkVTd4X
 6SqA==
X-Gm-Message-State: AOJu0YyRvpE28LX/tTtGZ6kpRJAGTViEeuz96nJ0/tZYuW2mjuMAuI/M
 MVGzYfXhftNc8Vmw7X1Xbr160t3KU5LwzAIDHF6Pz4FgAyJMX9zMxiGNVGDujfHrq36c83ag/aq
 C/hFd67q9
X-Google-Smtp-Source: AGHT+IHGIb43pYFOQDygmhZyvMoWWyaTeBVMNpN2bacAS4PxM7TEO5ymV7L3lWTwXwR6ugpSUmaSgw==
X-Received: by 2002:a05:6a00:22d6:b0:70d:2a4b:4038 with SMTP id
 d2e1a72fcca58-7106cf8fb08mr21843614b3a.2.1722957845050; 
 Tue, 06 Aug 2024 08:24:05 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed2d04bsm7059727b3a.201.2024.08.06.08.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 08:24:04 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com
Subject: [PATCH 0/2] Support multifd compression test for guestperf  
Date: Tue,  6 Aug 2024 23:23:40 +0800
Message-Id: <cover.1722957352.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42a.google.com
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

The first patch just nitpick the inconsistent parameters for multifd
test.

The second patch support multifd compression test.

Please review, thanks,

Yong

Hyman Huang (2):
  tests/migration: Nitpick the inconsistent parameters
  tests/migration: Introduce multifd compression into guestperf

 tests/migration/guestperf/comparison.py | 15 ++++++++++++++-
 tests/migration/guestperf/engine.py     | 12 ++++++++++++
 tests/migration/guestperf/scenario.py   |  7 +++++--
 tests/migration/guestperf/shell.py      |  3 +++
 4 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.27.0


