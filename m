Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E675606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=c1ZyaIFZ;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=c1ZyaIFZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbhd-0007j2-3v; Sat, 24 Oct 2026 09:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=in2V=IO=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xKbgr-0007TC-Up
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:21:45 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=in2V=IO=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xKbgn-0000nc-7d
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:21:39 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 67043A1A1D;
 Sat, 24 Oct 2026 15:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792848090; bh=JT3UIavOFwSvfZJZTRN5keFgQ3L0kR9rBOp51DObuSU=;
 h=From:To:Cc:Subject:Date:From;
 b=c1ZyaIFZ4Yf/6/91w4xm8ENcrrs5f6/wQu2OPlLJFAKRqfDUgG9sBOQ07pSI3r/oT
 PNXD2vwki1kVnPFA99IvihmGx0zV+djaNMBBPNvNjymqLFp3/vENWhMAHuai9fWJvK
 RUjIP8FOhliEYDsLAxPiUWfyVBRM+C9ETCjHPLoA7IB1CaKZrL6UYbd4+KkhD07bqU
 FtTOCxEGhy6hjxpN2o25kZpsfHltUjPZ4TpcvX2Hq/J5UcNlfK63+0BhiGeMWzv3bj
 0OQtLnrgU8Lf7mVmIT7tYHHcWp3B53FrWp+d2UTdP70GNQDROqC3kskXkZsYhOPMOB
 NNlA3GH/aIgMA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WUH9jtxGy8hV; Sat, 24 Oct 2026 15:21:30 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 37E0AA04FA;
 Sat, 24 Oct 2026 15:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792848090; bh=JT3UIavOFwSvfZJZTRN5keFgQ3L0kR9rBOp51DObuSU=;
 h=From:To:Cc:Subject:Date:From;
 b=c1ZyaIFZ4Yf/6/91w4xm8ENcrrs5f6/wQu2OPlLJFAKRqfDUgG9sBOQ07pSI3r/oT
 PNXD2vwki1kVnPFA99IvihmGx0zV+djaNMBBPNvNjymqLFp3/vENWhMAHuai9fWJvK
 RUjIP8FOhliEYDsLAxPiUWfyVBRM+C9ETCjHPLoA7IB1CaKZrL6UYbd4+KkhD07bqU
 FtTOCxEGhy6hjxpN2o25kZpsfHltUjPZ4TpcvX2Hq/J5UcNlfK63+0BhiGeMWzv3bj
 0OQtLnrgU8Lf7mVmIT7tYHHcWp3B53FrWp+d2UTdP70GNQDROqC3kskXkZsYhOPMOB
 NNlA3GH/aIgMA==
Received: from samy by end with local (Exim 4.100.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1xKbgf-00000002b0f-2bhi; Sat, 24 Oct 2026 15:21:29 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PULL 0/2] baum braille device updates
Date: Sat, 24 Oct 2026 15:21:26 +0200
Message-ID: <20261024132128.618909-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=in2V=IO=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 4c0fe2b6a9adb155c18691a19311ac2bae6cae8e:

  baum: send device identity and cell count on protocol off/on (2026-10-24 15:15:24 +0200)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 4c0fe2b6a9adb155c18691a19311ac2bae6cae8e:

  baum: send device identity and cell count on protocol off/on (2026-10-24 15:15:24 +0200)

----------------------------------------------------------------
baum braille device updates

Hongyan Xu (1):
  chardev/baum: unregister the brlapi fd handler on finalize

Samuel Thibault (1):
  baum: send device identity and cell count on protocol off/on

 chardev/baum.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

----------------------------------------------------------------

