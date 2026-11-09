Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FF606A323
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qa73sO54
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0K-0007FD-UQ; Mon, 09 Nov 2026 09:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ00-00078s-TZ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:31 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQPzz-00088Q-3m
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:28 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so591327f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233125; x=1794837925; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ExDvu1IdVw5uhCyqLTHc4X7eF5v1OJqlZPzarkYlg1A=;
 b=qa73sO54yy/yABRBhpeor3Anr7FWdUauGojyH1TRMAxzh+Ff/nt2uF9tnrS6CKF9Jn
 KVzcgemx0npR2ZNpIm0YgEBqHQ2TXg0Vppbz7iwzVeiGbeWJhHZKzR2ERbvk/MPewwig
 5BV8F5LQKLFjHV4PGnW1vErsRk1A480uLDglDFrHNRZNSFOWkwTrzgnVIb+9nrsyCPl0
 lfZVygCGll8WJSQEXCEhSbhbdCAeAAg/UMdr8JcorIYPnnyYs2bBJUTpLtEA+VYMDs4H
 q1gIpasqCj57lbO3jBNKOavQA/ED93EIiKjzgorAZ8fhU8oBQEElWn9CdeJmBkv4XjSC
 xTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233125; x=1794837925;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ExDvu1IdVw5uhCyqLTHc4X7eF5v1OJqlZPzarkYlg1A=;
 b=gzfwZ6gAhq5KoYqtVbpu7Dbjx/uMEUBogL2Nh1gcdFyzbpUr2xuL0y2IuoKfIco/nI
 gGlBFbeVkFpfedEs6JpBoKC3EyWgzlQ+jbhwK8xMArlHu87BKw1ClxLwkbkc0bXMuvMt
 ev5I/bSHRtygNJOYh8pR2ysR0oy0zDzVsISnyXITPAWwZc0A4uyDqb58DU2lpJx9/Hnr
 VCfrgTbkUmVFnI0E/ftBLVHsr1HX4keQMmAymOkwfZC7z4sv6AjoUwTpW77rZgRt5lh8
 48TU6Z8emrd63Kxrq6Q1C0F9FRaPJqO2pCX1swmypmQAUPOm6cpzYrCXr/NHi78iCItG
 SZDw==
X-Gm-Message-State: APuU4Z/jOxqcddshwuixunq5jyf2rHLULbqvKRwKcXk0QIgvNkI1ugIv
 C2PwwYQd08lHBuKMRZCSRKXk9cHxFJesrQ9mel1VKxNS8Sn940bpAeAxCJzzDAysEbnmMzfsqnf
 52UXe9/0=
X-Gm-Gg: AYBFou2I5jnOHhrQUSUce1CFvYFqLF3B4m6TgNpRhYozn6uFCqew76Re6Y2TeD4pypt
 VeC0brLBMQjEeB0E2367j6ndlVyOWBkjoBHKN0ftli6mSB1Z7reYnCnyvDVZ2ZvmE86W1NtrXx0
 +lAF91LSKmwF8NvDJ/UfKh+pIN2twf6g3jcvIuJuVlRUZYXfwL6sHaQ2uhcF7KYZgZT1e8TGYMN
 +Y/mNLilD7aoR4C8FDuKIRW+Gf/4r1otl+vFGTVgOVXnctP3bP5wJoAoSTXVyjtlLwvyEVqIa1v
 gBnBSi6kVMoRvszn8JCUUQikH9VVluCjNZzOtNiyNdzZH1T2OKTOmZWRvkp8zTFfXhe4XJmzCfL
 pnjWxHPpM+p5i8kXON674pBkxCZmoLoJQGb7YPtEKWvHdqtBHNAlANHlqF+x8P5AsBxuHcL20wq
 d1XQWG3xpVHFBqslAcip2jipmFueZyF/Nus0029BuKVG/wKgRhji48//UCiX4sI71H7ae8TmwTA
 UwaOPkeRnQ8VfANJEBDwMlu94FYNc14Xdo3NFS+ucQs3L7VOaQEtjQTj/09WEfIpHlqfkQ4VSuG
 V7zL9kMYHhKw4z/YoMcyucSQI6xblp3sX6VJ58J9hc+pKGKW6ZJeKyG6UsvMnylS8XLl03EXA1C
 wAhuj78IvKhXndpzI8F4DzYOACHrQtxJS+CTSPnzI7PbXulBsZ45vZLI=
X-Received: by 2002:a5d:5d83:0:b0:48e:61c9:4e32 with SMTP id
 ffacd0b85a97d-4958382558fmr8158333f8f.32.1794233125279; 
 Mon, 09 Nov 2026 06:05:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target-arm queue
Date: Mon,  9 Nov 2026 14:05:14 +0000
Message-ID: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi; here's an arm pullreq; these are all bug fixes.

thanks
-- PMM

The following changes since commit 71f25c75417d31c214ba2cd26b273c114fc99987:

  Merge tag 'pbouvier/pr/multi_target-20261106' of https://gitlab.com/p-b-o/qemu into staging (2026-11-06 12:28:21 -0800)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261109

for you to fetch changes up to e927ac974c94ce98c36ba3e84563a94ca8237358:

  hw/intc/hex-l2vic: avoid shift into sign bit (2026-11-09 13:52:08 +0000)

----------------------------------------------------------------
target-arm queue:
 * target/arm/ptw: check XN for ARMv6 in get_S1prot()
 * hw/net/bcm2838_genet: various bugfixes
 * arm/cpu: fix GIC v3 flag for a64fx
 * hw/intc/arm_gic: do not hardcode GICv2 minimum binary point
 * target/arm: Clear the local monitor on AArch32 (v8) exception returns
 * hw/intc/hex-l2vic: avoid shift into sign bit

----------------------------------------------------------------
Chris Copeland (1):
      target/arm: Clear the local monitor on AArch32 (v8) exception returns

Ferdinand Schober (1):
      arm/cpu: fix GIC v3 flag for a64fx

Lorand Marton (2):
      hw/net/bcm2838_genet: wrap the TX consumer index at 16 bits
      hw/net/bcm2838_genet: hold RX frames while the ring is full

Manos Pitsidianakis (3):
      target/arm/ptw: check XN for ARMv6 in get_S1prot()
      hw/intc/arm_gic: move num-priority-bits check
      hw/intc/arm_gic: do not hardcode GICv2 minimum binary point

Marcelo Manzo (1):
      hw/net/bcm2838_genet: fit the RX frame within the guest's buffer

Peter Maydell (1):
      hw/intc/hex-l2vic: avoid shift into sign bit

 include/hw/intc/arm_gic.h        |   2 -
 include/hw/intc/arm_gic_common.h |  18 +++-
 hw/intc/arm_gic.c                |  24 ++---
 hw/intc/arm_gic_common.c         |  14 ++-
 hw/intc/hex-l2vic.c              |   2 +-
 hw/net/bcm2838_genet.c           |  66 +++++++++++--
 target/arm/ptw.c                 |   4 +-
 target/arm/tcg/cpu64.c           |   3 +-
 target/arm/tcg/op_helper.c       |   4 +
 tests/qtest/bcm2838-genet-test.c | 204 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   2 +
 11 files changed, 305 insertions(+), 38 deletions(-)
 create mode 100644 tests/qtest/bcm2838-genet-test.c

