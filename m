Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E2606A335
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a0eMuRMb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTIl-0003Mc-3N; Thu, 12 Nov 2026 06:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRTIj-0003ME-8L
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRTIh-0001F8-Ms
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794484146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G8FEghpdV3BsWJ5YGls1n5pjBP9jznqq7QkaJYYGk/8=;
 b=a0eMuRMbjzHiN9syH/ggSBGdkEo/fssEUN16u6W94G9zTl8JsBxPRrOv40lbw1PLSUTCnt
 jtG0Ttx5ETVuWkPCJYr0kTFNhgIOfFyeFseSp8vFylIpyxeYm8i+NKPq/SZrJmLWEHDNk2
 c8GEVY+grD79sThYL9OStf2Ca63HLr8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-LemKy8Z5OL-w3HRA1CIdKA-1; Thu,
 12 Nov 2026 06:49:03 -0500
X-MC-Unique: LemKy8Z5OL-w3HRA1CIdKA-1
X-Mimecast-MFC-AGG-ID: LemKy8Z5OL-w3HRA1CIdKA_1794484142
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16C9A18A323C; Thu, 12 Nov 2026 11:49:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1488410; Thu, 12 Nov 2026 11:49:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/7] vhost-user-gpu fixes
Date: Thu, 12 Nov 2026 15:48:43 +0400
Message-Id: <20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDXRpqFcRSxUB2NR0kEk0rsrl
 m/x/w2MgZChyW4IeBLT6hNknsEw935CQS4ZVKFKKaUSxHyg0EYb4XTtSusMVlZDCraAI13frO1
 +82EXHPb3ADE+k9InoG4AAAA=
X-Change-ID: 20261112-issue-4848-d49d6bd8e7b4
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DDwm4eFt4JJ5rIupXwWKD4AvTD+f+fLeswZdLRjCiGU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9aepd4/hQF8gJHA3Fk2DTiNioDOIQyYcESLKt
 ghslbSuNjGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavWnqQAKCRDa6OEJdZac
 5XFZD/0UvnHHKnS5HgcTO0EA5+9DZ9yLtWPBhnyvM410NFSua34/M2IEQrqQLoqZgmxN4mH579q
 jyJqd58DTPe4itKw9NtJrDWmogTax2RLxckA5bjKfBqCkL8Ez+KlJ6ZfMAZwhNeSWjLUZuVVPDO
 j3rpbYDPtqcNID3z4bCqv75xAlvHv/V03ED3ijBEDMxbrP2V5zkXa/8JcAHRjBPuE5NlpD5ECR/
 x4HlD6q2LJRdDLX6NL3f9RCNXtOQjIunYXGfs0CXTixqq+2J8B5la6CDUIcPVL6urH2NfmuxifN
 UVIXuCmY/e7OsyDzcdkagFTUQ4OhtCC1RewhYR4MpZPxMK/S4LsEigV48/zOUwmWKX2cJ9pB6+y
 vQu961sVzxHDELyvMQQfAQlDn/o9ULJHFvi94+G/PoKye34vApkxh/s6aj4Gt6UiWPi04mMFdy4
 BkZy54CGsPeIlFLybWjSXMp7aUtJhqzG5IiSbklrmf9z/l6Xf0TsAXB2SHwhuWPPMBPSr5aA6jy
 wu/0aL/pfYXiENRT3fy1NjdNeh9uYhDzc1Ta1wCteY6Y7LDoxF4El5X2bzN3sXzgqEztZE4Mj51
 XaQs+mZsnQF6hPbhL37FbGLdbfjY2QHVTcdeK/jYoQIdvggcw4wUQZ70FQX7FONPyS6UJdqRZUP
 TT/mfD9UGXv2VIg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dmitry reported a handful of vhost-user-gpu issues (#4846-4849): crash
when a command waits for a reply and a fence is signaled (#4848), guest
losing display when the device is restarted (#4849), segfault in
vga_update_display() after a guest device reset (#4846), or main loop
spinning on bad descriptor (#4847). The first patches address those.

The rest are problems found while working through the code: console is
not resized on dmabuf scanout, the 2d scanout path frees a surface it
does not own, and the exported dmabuf is imported with the wrong stride
in some setup.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (7):
      contrib/vhost-user-gpu: don't fence commands waiting for a reply
      contrib/vhost-user-gpu: reset the frontend socket on stop and start
      hw/display/vhost-user-gpu: reset the console scanout on device reset
      hw/display/vhost-user-gpu: don't set an fd handler without a socket
      hw/display/vhost-user-gpu: resize the console on dmabuf scanout
      hw/display/vhost-user-gpu: fix scanout bookkeeping on the 2D path
      contrib/vhost-user-gpu: use the stride of the exported dmabuf

 contrib/vhost-user-gpu/vhost-user-gpu.c | 169 ++++++++++++++++++++++++++------
 contrib/vhost-user-gpu/virgl.c          |  70 +++++++++++--
 contrib/vhost-user-gpu/vugpu.h          |   7 +-
 hw/display/vhost-user-gpu.c             |  71 ++++++++++++--
 4 files changed, 265 insertions(+), 52 deletions(-)
---
base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
change-id: 20261112-issue-4848-d49d6bd8e7b4

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


