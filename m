Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6A3CCF2CF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRah-0005ki-5g; Sun, 18 Oct 2026 10:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRae-0005kG-PH
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:21 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRad-0004yd-7V
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8a0673d9bd2so154544b3a.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792332618; x=1792937418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Yb92bKVAbeQ8k8U6ZwO25vtKkZS6qfdf0XOHDe+dsw=;
 b=MqgnD3oLdOe0ABDTM7Yp4WlyJS5v3OK2DYBPUcHEkrwZqppL0onNqhHGeTTAeAXWjg
 s/ci7BjI8eLnq9OCMqC7k77f8gW/NSdnkkwmduTQMoN/t234fUW/b7sVlWn9IY6CrrEy
 vQGwptkA8WkFl802BKjqq6vpUYyNEHMThMDQ21JcNAfg3P8kFeZdY4wfjuD9Ho1VpB5k
 qBikbRQmgrLcaAUMpbUpddJbQb86FoybqNRsN57kdZq53hY/oTujBcogPeK6XMeU3Mgd
 YVixfG5NGGPaSjZLw7bUMr/GDb1Caf4hl4tdKHrhG73y6hPtfpsyLT1ojURXiF689VVO
 KjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792332618; x=1792937418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Yb92bKVAbeQ8k8U6ZwO25vtKkZS6qfdf0XOHDe+dsw=;
 b=tv3EX4B/fYb831EA+jB+sNbGQsPgxVnR3KT9ExfMA6BObjuI3h8pXDukV+dRy3LCP4
 Ws87hfwwjmj9AVrmJ6MFpLtZ/5stjrQ5c6iEs1CS+7MLBynBaWQYylKvdUuaVDJmlK6N
 5Sk2ieoqyXjiRNMHUs4U795na9zwi5kEgClSRnkG8tlrBJAiMCPmwGC2O/C3FzdY9RFw
 RjwNTgsBPvjza1J+oekKepb1qKsj6xqmzmPdthmahXXF0A5RNkji4lsCFRFWTREdbubu
 rpc1rSk39JGgP+eJ8p9dvNMXBp88fV5AICa2KN2K2KB2fJ3JeozChqCAKYCfeJcYyNMV
 1w4g==
X-Gm-Message-State: AFq9FYJkSKA2pvVN1dF6D/byo1t1Qma8j+tdCp/v8u3eIj8fpCSaHqO5
 Hxk166A/YLPcymhQhMFnAxHBVZa3tLrEwi3Ch7vkIfcvqoflEkSaFDya2DxW9XVf
X-Gm-Gg: AYBFou04AZpbYG2DM4Kj4HyW8l4Ri82YyIocYQ9TXIQ/nDik9VZ02kMUbSGGw47Pcrl
 iYzdaWeqE7h3YM7uCt7UjTUcXNJS9oiIMftQ/FrxTM59revRbvFjr7v2CUQ4V/2LOEnGxHdoo9Z
 7fGybcwDwv66Mru7wYFTeKpqWOWmShlWx8s9sWdS3uByYKcGd2cD1Wr4qWRcg49rRSIECuLNESJ
 nbiK8CSt6R1e1GRP/8bw7f6osufdceGrQVpLvfX6V87dRVFfO2PxRgTmrXnQCNKTwGs4qK9tXKk
 9tnI2b5I+Ww9Uefgn6aJuaf+W8ZC9mD9Y5ROTAKIOwPxu9TR3QfOSECBoN6QuMxksovf7J1lZ2k
 cZlD/ttaIph7pu3gittlFUQABgVpu16pTWbPR4fMeVbWOTRPSQVIZDiq2A7iJLsbgM1M+WoAUwr
 YGvB0F8V5z5wV1t7G5yenE7yyyz9h9tVk3JDKZ6ej2zUFc1aNxQmpeFIP/q1ziZ64N8B1bxguRv
 77K2BL0QvJWHsXg
X-Received: by 2002:a05:6a00:1806:b0:851:8baf:5b26 with SMTP id
 d2e1a72fcca58-8a04ba18476mr3928177b3a.14.1792332617565; 
 Sun, 18 Oct 2026 07:10:17 -0700 (PDT)
Received: from dt-VM.localdomain ([101.204.150.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2949430b3a.32.2026.10.18.07.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:10:16 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v3 0/5] Fix integer handling issues in k230_gsdma and
 k230_decomp_gzip
Date: Sun, 18 Oct 2026 22:10:01 +0800
Message-ID: <20261018141006.16398-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi, all

This series fixes integer overflow, truncation, and underflow issues
reported by Coverity in the K230 GZIP decompressor, its qtest, and GSDMA.
https://lore.kernel.org/qemu-devel/5fc57f49cea0ac3542128d0e2208edd6d7484f7e.camel@wdc.com/

Thanks.

The patchv1 series is posted in:
https://lore.kernel.org/qemu-devel/20261002140245.30214-1-dingtao0430@163.com/

Changes in v2->v3:
- Separate global and channel register handling to prevent unsigned address underflow 
  when calculating GSDMA channel offsets.

Tao Ding (5):
  hw/misc: fix calculating output address overflow in k230_decomp_gzip
  hw/misc: fix calculating input address overflow in k230_decomp_gzip
  hw/misc: use hwaddr for the k230_decomp_gzip input address
  qtest: fix k230_decomp_gzip test integer handling issues
  hw/dma: fix k230_gsdma integer handling issues

 hw/dma/k230_gsdma.c                 | 84 ++++++++++++++---------------
 hw/misc/k230_decomp_gzip.c          |  6 +--
 tests/qtest/k230-decomp-gzip-test.c |  2 +-
 3 files changed, 46 insertions(+), 46 deletions(-)


base-commit: 0a1ebd448b38afaa118597cbb633dbec24ef74d3
-- 
2.43.0


