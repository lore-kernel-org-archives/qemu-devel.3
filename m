Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B05CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3L3-0005xG-Ud; Mon, 01 Sep 2025 08:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3L0-0005tr-So
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Kr-0005eu-Q2
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id; bh=uAF5i3WN3fItFA93A1zyXeXVwztLjZUgCW96JtE6BWk=;
 b=fCJe1O9kli9fMSA//klsoujoNJDOmN9tAOYbpgiWyHx8WUrVOBQQ5gnmf4CajPQtlKklUt
 BlLK9I1oqDeNAcR8nOGlbAyb5YlvAckf5ewFsNEw7d7XtrjExW8Nesif4vsJW6vvaIhq1l
 GcEJ13JHw2nx5ZrAMMrCht+SmHCp/Q8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-i1_vothyNLu_3Gf-zXGtXw-1; Mon,
 01 Sep 2025 08:08:27 -0400
X-MC-Unique: i1_vothyNLu_3Gf-zXGtXw-1
X-Mimecast-MFC-AGG-ID: i1_vothyNLu_3Gf-zXGtXw_1756728507
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBFCE18003FC; Mon,  1 Sep 2025 12:08:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5879818003FC; Mon,  1 Sep 2025 12:08:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99CE321E6A27; Mon, 01 Sep 2025 14:08:23 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:08:23 +0200
Resent-Message-ID: <87y0qy4bpk.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:19:06 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9657A21E6A27; Mon, 01 Sep 2025 13:19:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/3] Error reporting patches for 2025-09-01
Date: Mon,  1 Sep 2025 13:19:03 +0200
Message-ID: <20250901111906.2403307-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 91589bcd9fee0e66b241d04e5f37cd4f218187a2:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-08-31 09:08:09 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-09-01

for you to fetch changes up to ec14a3de622ae30a8afa78b6f564bc743b753ee1:

  vfio scsi ui: Error-check qio_channel_socket_connect_sync() the same way (2025-09-01 13:11:13 +0200)

----------------------------------------------------------------
Error reporting patches for 2025-09-01

----------------------------------------------------------------
Markus Armbruster (3):
      ui/keymaps: Avoid trace crash and improve error messages
      i386/kvm/vmsr_energy: Plug memory leak on failure to connect socket
      vfio scsi ui: Error-check qio_channel_socket_connect_sync() the same way

 hw/vfio-user/proxy.c          |  2 +-
 scsi/pr-manager-helper.c      |  9 ++-------
 target/i386/kvm/vmsr_energy.c |  6 +-----
 ui/input-barrier.c            |  5 +----
 ui/keymaps.c                  | 14 ++++++++++----
 5 files changed, 15 insertions(+), 21 deletions(-)

-- 
2.49.0



