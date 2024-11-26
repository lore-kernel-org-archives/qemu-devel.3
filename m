Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B81D5A6DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 04:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFmqD-0002Tk-NJ; Mon, 25 Nov 2024 23:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFmqC-0002Tc-Pg
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:06:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFmqB-0000Q9-A5
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732593976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VPcaPf0ek3RGB5CC1KrZKYV8HwtmuSAnfGJrOVM6XII=;
 b=WCJBcdq4ICquhDwSiOZFqp+PCi26bvX0RGUn0NX/PawHW2MYvGT5oBGATH+VZZyfc5FIaX
 2qe18nO7BgJEQY5R/MDoHN+1zqdbw2X9W9KxCtGKyImlwK8cmiif5DtZrkkG3ykr1tOrRC
 YPtflhzQaiTDCPOp3aKIAUQIe3+3oy8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-OjvJ2nW4P9O1do14_0TTbQ-1; Mon,
 25 Nov 2024 23:06:14 -0500
X-MC-Unique: OjvJ2nW4P9O1do14_0TTbQ-1
X-Mimecast-MFC-AGG-ID: OjvJ2nW4P9O1do14_0TTbQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 936A21956089
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 04:06:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.25])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF62A1956086; Tue, 26 Nov 2024 04:06:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/1] Net patches round 2
Date: Tue, 26 Nov 2024 12:06:06 +0800
Message-ID: <20241126040607.1704-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 791e3837c1105aec4e328674aad32e34056957e2:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-25 10:44:11 +0000)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 9379ea9db3c0064fa2787db0794a23a30f7b2d2d:

  virtio-net: Add queues before loading them (2024-11-26 11:56:44 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmdFRyQACgkQ7wSWWzmN
YhFU1Qf/T9bBOCrbQqbZSG7eKk8QuH35zcgNU7FzFTrGeVCc1bUMNYhiioqAFmE+
h5h/3vmkmt+01vaTuimTRumI2SJnFFwggveJDWf+ICSl9MRtCXB5+w0n71vJ6gUO
njm36pIl+aMkZIrsDc7lLewVouZkF8mAKP7mn9x53s5lX/HbXZSdPJmrkdUXtNT5
d3nXlUkNhEWKL9dKIQ9dWYmj3l+tLfuYPiR8a+kKFMEwHlGBuFbNoVN03v5VvFyf
Dmy1P1ZFApP0SsR4SiccXg7C8AslBC6wc7Bhd0aiKpGBnlt20mE9EJSVyrU8yP1p
UTKzzB0QHN7Nnd6AcFRhWvo9C74mGg==
=qP+q
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Akihiko Odaki (1):
      virtio-net: Add queues before loading them

 hw/net/virtio-net.c        | 10 ++++++++++
 hw/virtio/virtio.c         |  7 +++++++
 include/hw/virtio/virtio.h |  2 ++
 3 files changed, 19 insertions(+)



