Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADC4D5B16D
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Dec 2025 14:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUnZE-0003BN-ER; Sun, 14 Dec 2025 09:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vUi7m-0001zh-2n
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 04:10:43 -0500
Received: from out-183.mta0.migadu.com ([91.218.175.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vUi7j-000395-Mg
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 04:10:41 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1765703426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yMLdG0X/4GrxUPtcNfmeFD0jj95EBl9BZrB7WIj/4nk=;
 b=KdCboGp4Rx68GSzGpHyqD00cDspkm6qcJ/bY3K1G6INpMXYrFgzPreE7JPLx5yoWojUFnj
 ASh5qxc/bLjc6kHCc6lqFQauwanoTChO1QdkAV4tGNBL7U9rNG32M78PllP1ju4IJoqfDm
 u5yakpn17xwM/WwsvbSXIylW0Y3OMfY=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, nakamurajames123@gmail.com,
 qemu-security@nongnu.org, mcascell@redhat.com,
 zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH 0/2] Avoid QEMU OOM on huge request from guest
Date: Sun, 14 Dec 2025 17:09:37 +0800
Message-ID: <20251214090939.408436-1-zhenwei.pi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.183; envelope-from=zhenwei.pi@linux.dev;
 helo=out-183.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 14 Dec 2025 09:59:22 -0500
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

Fix two issues in this series:
- Verify asym request size from device level
- Limit the maximum size for cryptodev builtin driver

zhenwei pi (2):
  hw/virtio/virtio-crypto: verify asym request size
  cryptodev-builtin: Limit the maximum size

 backends/cryptodev-builtin.c | 9 +++------
 hw/virtio/virtio-crypto.c    | 7 +++++++
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0


