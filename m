Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE67C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 13:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1RIF-0005ff-Ia; Mon, 29 Apr 2024 09:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s1RI9-0005e1-CF
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s1RI6-0001eQ-Jc
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714398208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=giHljWH8xf8DZGqSHRIhoJa3V3e1hkOXsVXRBn0eExI=;
 b=eG/dnaLH7fkTM2O33CJ2lOn+m8enoDmARXI0F1WAfPnPIIHSioHjvM2IdER/4Nlcz2EhVE
 cxKMXiJR2ao4+ghPZyVMk4liYiTI9I/CIDihknlnOTwrscYrMDKo4smtI10wuHO02qkmBn
 yprypFggNrI9FzAltBskIBQSph+2PxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-sLxk98i7Nny5-X_BNMOMzQ-1; Mon, 29 Apr 2024 09:43:24 -0400
X-MC-Unique: sLxk98i7Nny5-X_BNMOMzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45C7B8FDD22;
 Mon, 29 Apr 2024 13:43:24 +0000 (UTC)
Received: from localhost (unknown [10.39.195.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77FEC581C8;
 Mon, 29 Apr 2024 13:43:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/1] Block patches
Date: Mon, 29 Apr 2024 09:43:20 -0400
Message-ID: <20240429134321.321982-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:

  Merge tag 'accel-20240426' of https://github.com/philmd/qemu into staging (2024-04-26 15:28:13 -0700)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to d1c4580662bf75bf6875bb5e1ad446b300816ac7:

  hw/ufs: Fix buffer overflow bug (2024-04-29 09:33:06 -0400)

----------------------------------------------------------------
Pull request

Buffer overflow fix for Universal Flash Storage (UFS) emulation.

----------------------------------------------------------------

Jeuk Kim (1):
  hw/ufs: Fix buffer overflow bug

 hw/ufs/ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.44.0


