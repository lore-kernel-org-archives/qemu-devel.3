Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A63C2A073
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 07:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcIwY-00084M-0M; Sun, 04 Jan 2026 02:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vcIwV-00083P-PH
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 02:54:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vcIwT-0002Il-QS
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 02:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767513263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kS+NItb0/UMETeNcaSJf2AfAopXu9JNaURMS2YT3KxY=;
 b=B/K73GlGIynlMzJRXFMwOVOQss1avFzEU53lO9kY4NID682Rpp/CVNwELXp0O9w/hXMIDg
 8j4uMxKvcrExuVoikEL0BYUjJvxHLztsQTtS18P7R2Q8CYjRdulqeCDRGtncna+08vByww
 NEyNXPWSOz4kRXv97bpR100VJHSZHOQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-W-wcmdxeP2G8nA1CQgSXsw-1; Sun,
 04 Jan 2026 02:54:19 -0500
X-MC-Unique: W-wcmdxeP2G8nA1CQgSXsw-1
X-Mimecast-MFC-AGG-ID: W-wcmdxeP2G8nA1CQgSXsw_1767513258
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6281A195608A; Sun,  4 Jan 2026 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 878D9180044F; Sun,  4 Jan 2026 07:54:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: zhangckid@gmail.com, lizhijian@fujitsu.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: lulu@redhat.com
Subject: [PATCH 0/3] Add status on/off switching to filter-redirector
Date: Sun,  4 Jan 2026 15:54:09 +0800
Message-ID: <20260104075412.1262-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi All:

This series adds status on/off switching to filter-redirector with
qtests.

Please review.

Jason Wang (3):
  net/filter-redirector: add support for dynamic status on/off switching
  qtest: add a test to test redirector status change
  tests/qtest: Add test for filter-redirector rx event opened

 net/filter-mirror.c                  |  38 +++-
 tests/qtest/test-filter-redirector.c | 288 +++++++++++++++++++++++++++
 2 files changed, 321 insertions(+), 5 deletions(-)

-- 
2.34.1


