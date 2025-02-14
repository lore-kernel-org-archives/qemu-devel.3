Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB2C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 10:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1titN7-0003DY-Fr; Fri, 14 Feb 2025 05:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titN5-0003D7-Hy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:35 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titN3-00067e-2C
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:35 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fc1c80cdc8so2272084a91.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 02:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739530590; x=1740135390;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/zk84E3VOndU9iCHGxi7vjLZZ+ayxet22f2jMNf26vM=;
 b=DRNSuUftK6SBuctgOBPazNa2AMutprknAyG5uu7xsi/LHUHcHoGbQyOp0uHyc42/Yu
 dd1v0xUMW9Trj+DQE//mHmQwJcVUgywqX9v4L+U4odl/HKsGHqaIuPeibA5dDdJILkFr
 jyioVQnebMb75E5e9E2uyHwDo9saAbszzpFeyFQk1qg28YPrcNsXQLaYjnB2XsbK5YG/
 Hwon4LW5yt5RdYW1s9DqaGNZvOErDhtKc9nReil8EIDQXi0FRx1JYPPUYhVMaIof70cd
 G0E4YCx7/cd6o+w86LwfRCxfkvLpqntqDMGRKG013NT4K00DxujusDRDtIER/SVTaU++
 x/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739530590; x=1740135390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zk84E3VOndU9iCHGxi7vjLZZ+ayxet22f2jMNf26vM=;
 b=GIZt24fqSkg+peQObwg4Ea6Af25bxKVCNKuKUmd+jXWxPArPC8D1a4wdt+P3vD3/tg
 /4FxXWPj/c1mZUhwzmZCJmw3fE/8oyZUBcS82dINhvFbECa1uVTsvo99sUjXagoCdl4P
 gCl0WnL8d/G7/dm10KVkBuqIG34/W9YRb6FdXHRvHbyc6KN7dUM4Pch86dUIM10aHOxX
 214UUOsr3ZDFbyjTD4pikwQkarxLQkRE3zkIyZVMJYc5ShfIRTO1i3ieHDROA1t47oi7
 Pez6ESBwk1J50KqM4p3zsOd2iFspeJsVrHQPj5U8Icsjzr03iuX0jEhZ3Us+56m7j9Zv
 N/ig==
X-Gm-Message-State: AOJu0Yz8iIBpTue3cbJTwABg5rOd5lU3MLNpdFg6MOpxoM9Qs7guNPjX
 ydlDd2umVkiNmsDXuBzSf6qapbi/QrEEC8iqfP/SEHfpvemSz0WqyrJP9WCRdq4CxmIvU7GVFxv
 PveqdJw==
X-Gm-Gg: ASbGnctG9uqFC/caEj9XFZKWq9YQi87qxAbJ9QCId+C15BQRPDYvK/fqSdLoqKK3rR1
 aUR7x1Bj7dizhK034x2j5h9dVe4XQ+K0bSl5+OWljv9Z/UYn3h6kyoXhl/kN0iO/G1bz5PJjku/
 Px3X3LFYh5tIawXGmpVZiGlsxV/BAgd7+vtW9nrxM8joTq2FaTnOr19OQ9OvaeTWj5bNNEt2ycn
 jFwfsyca/B/A1dsv1XYOOI5BY/fr+I7WMX3ybLzDy/mhiu8uxYf6b8vj8CpScs2brzenu00T9w4
 hkFE97ilAkK0zxZlgHJdd1P4ivjXl/L1TSDqJvnH
X-Google-Smtp-Source: AGHT+IG/XugB6plzXkQfc2ntaLgPv9ZcBY5gSLrPQy7yaPktyNKb6I8w/e2786Zgq7tDntoHhNyO0w==
X-Received: by 2002:a05:6a00:3d46:b0:730:76a1:3935 with SMTP id
 d2e1a72fcca58-7322c383f82mr16676111b3a.6.1739530590160; 
 Fri, 14 Feb 2025 02:56:30 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add0987b223sm535013a12.17.2025.02.14.02.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 02:56:29 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v4 RESEND 0/4] Guestperf: miscellaneous refinement and
 enrichment
Date: Fri, 14 Feb 2025 18:55:22 +0800
Message-Id: <cover.1739530098.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102a.google.com
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

From: Hyman Huang <yong.huang@smartx.com>

v4:
1. rebase v3 patchset on master
2. build initrd-stress.img manually like before as suggested by Peter and Fabiano
3. drop the [PATCH v3 1/5], [PATCH v3 2/5] patches
4. add an extra patch: [PATCH v4 4/4] guestperf: Add test result data into report

Please review, thanks
Yong

v3:
1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by Daniel

v2:
1. Update the MAINTAINERS section suggested by Fabiano Rosas
2. Ensure the dependencies when build the initrd-stress.img suggested by Daniel
3. Fix some bugs

v1:
The previous patchset:
https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/
does not made the necessary changes and tests for the upstream version.

This patchset works for that:
1. Move the guestperf to scripts directory suggested by Fabiano Rosas
2. Make initrd-stress.img built by default suggested by Fabiano Rosas
3. Make the necessary changes to adapt the latest multifd behavior
4. A nitpick for multifd migration
5. Support multifd compression option

Hyman Huang (4):
  guestperf: Support deferred migration for multifd
  guestperf: Nitpick the inconsistent parameters
  guestperf: Introduce multifd compression option
  guestperf: Add test result data into report

 .../migration-stress/guestperf/comparison.py  | 15 ++++++-
 tests/migration-stress/guestperf/engine.py    | 43 ++++++++++++++++---
 tests/migration-stress/guestperf/report.py    | 20 +++++++++
 tests/migration-stress/guestperf/scenario.py  |  7 ++-
 tests/migration-stress/guestperf/shell.py     |  3 ++
 5 files changed, 79 insertions(+), 9 deletions(-)

-- 
2.27.0


