Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A62EE0AE0
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 14:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voiv4-0003SY-4b; Sat, 07 Feb 2026 09:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <22296f2db9f17f9954f85de9e99b09498936eb51@kylie.crudebyte.com>)
 id 1voiv2-0003S5-8a
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 09:04:16 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <22296f2db9f17f9954f85de9e99b09498936eb51@kylie.crudebyte.com>)
 id 1voiv0-0005jl-Ly
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 09:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=Jez3WBmbKMAJbGQNaJhOJY0IBrIFqpZAUP2uxRvlAnk=; b=GM/To
 5vJrf11utK9MwwVoAgtR7/7rxgHXvtW1u4LYvksXbyg+eaZ6PNJPfcefn+9shtTpRZ1WE2A0qspVo
 Nei/MXFaP5hTdgmatctdz0uC3hvn/lr5/9ecbtRsc4eIKae+AJPGtTTlU7Rs2PywBwGK+YSbmz2D9
 1i7EtCjbaqztemnVWAQQw1X22KmNaiPeAxPZkc0hM3ulrf6VKT30uza79xT6L4Rhm95Q6xwNYecYZ
 dWUsN8/oc35D2kf+DYIfJLryjtUqnpdmiTL0fqzylfQTNHjgZiYVI4DkfgRZGtm9RdA0L2mMm9T1W
 DKYD0qtJQeLjnq36BkwWM+3kkhakiDkC3PkPun2r+wmBXhfkp3Zq4uwifkqP4D4Zn1Mq9EJKbZfsG
 8lIcTy6Y93MCeZmitIayeUlO6Q186Ab2efDbTWmXT+NP9+s/VissTEA/IRsd7BgEUgPyLT1YUj9At
 T2/wVFOzm/AgfOnbnZ9+TTJH7rjBEJppTkQiIdOzBd2ESp2eqzJO5fvF/YsnKZIrz7hX4l9HUBXIB
 9VE6uHOIGa6Rxb2Ou9hOQIqhQuPS/7EqhwZ+z4YQyc6aXQqpBrk+LyQ1492rXgh0PviKOyv/SZkp9
 RD/3erd4ZITfsvCGCNVqywJLopNfabK6y2o6eFsygAE472yLtZiMvQWrOmBBZ0=;
Message-ID: <cover.1770470220.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 07 Feb 2026 14:17:00 +0100
Subject: [PULL 0/1] 9p queue 2026-02-07
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Andrey Erokhin <language.lawyer@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=22296f2db9f17f9954f85de9e99b09498936eb51@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260207

for you to fetch changes up to 22296f2db9f17f9954f85de9e99b09498936eb51:

  9pfs: local: read native symlinks when security-model=mapped (2026-02-07 13:38:56 +0100)

----------------------------------------------------------------
9pfs changes:

* security-model=mapped: add fallback for reading native symlink
  (if no mapped symlink present).

----------------------------------------------------------------
Andrey Erokhin (1):
      9pfs: local: read native symlinks when security-model=mapped

 hw/9pfs/9p-local.c | 4 ++++
 1 file changed, 4 insertions(+)

