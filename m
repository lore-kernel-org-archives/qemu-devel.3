Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B5BD3B7DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 06:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFSGt-0007K4-Jd; Mon, 25 Nov 2024 01:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFSGk-0007JH-85
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:08:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFSGi-0000Ow-5I
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732514898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WOjigm9hIE+sZC/HrHpDVMHBlKkNfp7b6U/FebyKFGk=;
 b=cQVDfdCOQUbxEgOdbbVeiOOjSSBxWlO9jaX+8Oxz4pdGUw/jQLgDuTPSGoW6WFVl54YFCh
 2jPOMjakt0QcBl5Bi7rSUNddwIndUck5YNxlT8u/UYeabXD6HnPbT50MxFx/9JsS1XVZwk
 EM9tsN/kwWkLFoAtqJGhtB+v/huOItw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-0mMP1CumN8eG0bcHpEJMVQ-1; Mon,
 25 Nov 2024 01:08:16 -0500
X-MC-Unique: 0mMP1CumN8eG0bcHpEJMVQ-1
X-Mimecast-MFC-AGG-ID: 0mMP1CumN8eG0bcHpEJMVQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7168A195395A
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:08:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.241])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CECD930001A2; Mon, 25 Nov 2024 06:08:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/6] Net patches
Date: Mon, 25 Nov 2024 14:08:03 +0800
Message-ID: <20241125060809.15543-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 6b99bb046dd36a6dd5525b8f88c2dcddae49222a:

  Merge tag 'pull-lu-20241122' of https://gitlab.com/rth7680/qemu into staging (2024-11-24 13:39:06 +0000)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce:

  virtio-net: Copy received header to buffer (2024-11-25 14:00:51 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmdEEtgACgkQ7wSWWzmN
YhH5qAgAlKdcx/gFt4EBXtjVq/qbPluEGOQxvcRYLlN90rPLHPgCjAoT5ly3fIv1
4kCgcVZyG8SdGu1n0TzTTS9kg5tL7weQ9xEWwF0oyyuZABgAB7w/wpC8MHSkJFOn
2Tv+2Iab0dJ+e1pw71OMpE/YR5X2xq5vopsSHRtnyGWfRPGswJFwka+f8FS5DSiq
2CeNxADgTkPxJgDmOrNSsAPz8Rns77FAZdvDMqFjx1Lrqm8kPv9jzwOMO+a/2LpC
t6OkpFzGjiiskPjSnSn/tzo4TfWYoABjJaI7b3vEqmNEJSTAaxltZNtSXZucctEt
1ihnFdjr/wPwGK/5Wu+qGnfDbFNxBw==
=W4y1
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Akihiko Odaki (6):
      net: checksum: Convert data to void *
      virtio-net: Fix size check in dhclient workaround
      virtio-net: Do not check for the queue before RSS
      virtio-net: Fix hash reporting when the queue changes
      virtio-net: Initialize hash reporting values
      virtio-net: Copy received header to buffer

 hw/net/virtio-net.c    | 108 +++++++++++++++++++++++++++----------------------
 include/net/checksum.h |   2 +-
 net/checksum.c         |   4 +-
 3 files changed, 63 insertions(+), 51 deletions(-)


