Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FFF606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LJRIRhCZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsNU-0000Xx-JM; Fri, 30 Oct 2026 15:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMsNO-0000W7-Cc
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMsNM-0007jp-Eq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793388895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v2O5BqvlOnOUoic0ttYwllqMws/wE2nDR12sOZ2QWok=;
 b=LJRIRhCZbjoVUlVPFqCTKy/GII01VkTppGHgOi2kMKcXBscawVyD22Yc+CwCqzljrYCEpM
 TQ2Tr2r6SSwuzxTA6i+bnCJgQV1iYmPUZXomxe5dcVBNSww8XnpkkTu3Fjo+xSFqJM3xWR
 /UbP8U8B5kFhnrUd2cSu6ITtw6ll62s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-3mQP1eicM6KyEvCsiKz_aQ-1; Fri,
 30 Oct 2026 15:34:51 -0400
X-MC-Unique: 3mQP1eicM6KyEvCsiKz_aQ-1
X-Mimecast-MFC-AGG-ID: 3mQP1eicM6KyEvCsiKz_aQ_1793388889
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEBFB180063F; Fri, 30 Oct 2026 19:34:49 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 023A41800347; Fri, 30 Oct 2026 19:34:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fam Zheng <fam@euphon.net>, devel@lists.libvirt.org,
 "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 0/5] Block patches
Date: Fri, 30 Oct 2026 15:34:11 -0400
Message-ID: <20261030193416.1691807-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 7f36b1fbeb1f6f070cd5f8eddb3edbcafac15440:

  Merge tag 'pull-tcg-20261030' of https://gitlab.com/rth7680/qemu into staging (2026-10-30 08:16:19 -0500)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 0a7dca50fd1d11e901c37aaac6b2a952b4919fc0:

  virtio-blk-test: Test truncated serial (2026-10-30 15:31:33 -0400)

----------------------------------------------------------------
Pull request

virtio-blk serial truncation deprecation by Kevin Wolf and a qed block driver
fix for CVE-2026-118594.

----------------------------------------------------------------

Kevin Wolf (4):
  virtio-blk: Implement full NUL padding for GET_ID
  virtio-blk-test: Add a basic GET_ID test case
  virtio-blk: Deprecate silent truncation of serial
  virtio-blk-test: Test truncated serial

Stefan Hajnoczi (1):
  qed: fix incorrect denominator in qed_bytes_to_clusters()
    (CVE-2026-118594)

 docs/about/deprecated.rst     |  13 ++++
 block/qed.h                   |   2 +-
 hw/block/virtio-blk.c         |  18 +++--
 tests/qtest/virtio-blk-test.c | 119 ++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 5 deletions(-)

-- 
2.56.0


