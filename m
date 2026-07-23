Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A96C531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsgw-0008CS-PX; Thu, 23 Jul 2026 08:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmsgS-00089g-Ao
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:37:53 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmsgQ-0008Tc-KR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:37:52 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15b1da6b82so60787166b.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784810268; x=1785415068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k8GqY9Pn+OcOahI5BfH6uKU3i8sjczwucasnYPYtgzM=;
 b=T1nPnDiOoz2uj/YFE3ekPVFwXO1CKxrTvrNx7NjBS2B7Xx7RiuXm0tvMby24TsQD3A
 yMQncQ5SF/f7i2fIRuotG9CtGCQjkKOiTEqACC3LYoiZOhpApXzXPLACSEcWiN33Pqij
 V7Uxzp4jBL8bFOnjjkpga/21uu2TLs7M9a9POGvAibQK3reyEsXoiJak/g+fehb5pH4d
 gCZeXr5ZIvU6070QmR32aFcqUGzZJ1sRCZtNJGj6+sc/qdYmymB8DNu4bbIyZAVpbrlV
 rVY4OAlINQ66lQKCDlhZL+gdGetvPejG1VUPJ0stLI95kQKPG7Hyuiepjg85QCEnQ1Mc
 oXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810268; x=1785415068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k8GqY9Pn+OcOahI5BfH6uKU3i8sjczwucasnYPYtgzM=;
 b=q+8nXeigjgYIMJT7oGiGe17VdFY1G/QGnJcshYvngDOwjzm/7uzslYajNzxZJvo3j+
 Us67bCVccfhufuKRUkKgO/CIhsQtYmX5SWVd3uZjGpORP7VRO+RVpndvRhs3WTlUj3XG
 o0NOMFYSdprVzWmRuO/J5BeGin+bwC7Fv568cYZEWMAhovc5qoVdQY5fc4OKCPwp1WWm
 b7iBZn0S7WeEqhLSz1Woo1KYGoCGfcjS+pTAqJW9qLL+5kWuHdJ9YpX5H20VzhgUEZAW
 iRwvz9c1kN5jCViMykTLpRFS1uPB39+LV7mhw/UFsIHqLB39UXOjqSuo8G/E5KVj3mUx
 UDEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfkUxTSO5fVJqNurURySTgON0CCCogSrnwb61p1+CV2rixc4ETICFTfq+Wc+r179J3NlY2bYIeSSK3@nongnu.org
X-Gm-Message-State: AOJu0YzQfds+4DmzW7uier/U8uPrHrANfVH5gPO0YZXM0hLmixhq9HmZ
 l3hzLgXKzsvaLRHlZQ23B7QAxRRNmXGPSzGWnYugF3BQH1gzFjE/6EyrHZaOwQYXj3k=
X-Gm-Gg: AR+sD13sBJabAzN4gDXBS3/1TyQDO7A5mgDSo7JicGAjqXz1m0fSC9azufDhXMMW9IK
 f4krhdIDwvvv3B9DaAXmv217ODe5uSjb+U3Q6jl98ZwkZijaCXLtEzFg51ARhlBEXkUiTpuctt0
 /O4j6RFFA7ohJw3twc9AeXgZUarbZSl4j7BeGjkrFKztMSnpDaKKPaj2YtMKQBhhdAf/T4G7Hl/
 f79kIBKRGR9romZjWrb8tOlxBPRHP5EH8h+Q3pq6FmfT+AI/MA+eFuX42av1T8MkZiCsx0KZDDL
 qPa/4As258xmdtdPKnKxyWrrIYG+wXxvAyqn0/4EatBtwU2sOKc5pmLekkRieAf3Mna9fk/SzyL
 LloUmqdy2ezG8JvOnO4r2xSJpbUZMS2+Ad0bXGWCZrikMxObkYTm1pIglvVxVxT5gKV38dLm6rt
 I=
X-Received: by 2002:a17:906:4fd4:b0:c16:e14:b8ec with SMTP id
 a640c23a62f3a-c1c509c0691mr119929666b.58.1784810268197; 
 Thu, 23 Jul 2026 05:37:48 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:b8fe:da40:80d9:ac01])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b58sm222619166b.39.2026.07.23.05.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:37:47 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 0/3] block/accounting: fix unlocked latency histogram
 reconfiguration races
Date: Thu, 23 Jul 2026 14:37:42 +0200
Message-ID: <20260723123745.3294227-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=den@openvz.org; helo=mail-ej1-x629.google.com
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

block_latency_histogram_set() and block_latency_histograms_clear()
replace BlockLatencyHistogram's nbins/boundaries/bins without taking
stats->lock, while block_account_one_io() reads those same fields
under that lock from whatever iothread completes the I/O. A histogram
reconfiguration (block-latency-histogram-set QMP command, monitor
thread) racing an in-flight completion can therefore observe those
fields torn, hitting assert(pos != NULL) in
block_latency_histogram_account(), or corrupting the heap outright.
This showed up as a qemu-kvm SIGABRT on a customer's virtio-blk guest.

Regression test is added for illustrative purpose but I am unsure that
it is viable long term. Feel free to drop.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Denis V. Lunev (3):
  block/accounting: take stats->lock in latency histogram setters
  block/qapi: take stats->lock when reading BlockAcctStats for
    query-blockstats
  tests/unit: add reproducer for BlockAcctStats histogram locking race

 block/accounting.c                 |  34 +++++----
 block/qapi.c                       | 102 +++++++++++++++-----------
 tests/unit/meson.build             |   1 +
 tests/unit/test-block-accounting.c | 114 +++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+), 57 deletions(-)
 create mode 100644 tests/unit/test-block-accounting.c

-- 
2.53.0


