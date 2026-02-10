Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFB7EB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu8i-0006Tq-V0; Tue, 10 Feb 2026 15:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpu8Y-0006Jr-71
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpu8W-0007t5-0E
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770754501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7vMYHOxYpwJHtoyWqbu05RZsH7Z/JHjtBTzY/s/wBC0=;
 b=Wq42MMmkj9nGtQ7mdEsAnTEm3A08hnjkLVoG8SF/7bc1hw/NfZPNGi3TMY5DJscxVb7G5w
 p8dpq8ANqf4RF+68/GFt7JxsvWxaD352RBUPFCPvREl7yXjqw7Z2Ba0HTHeqirBcEKIWXF
 VFJM5Wbd7dwxqBLwwocdYg7MHpqx1x8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-7kXRaOL_NZeCh07wsOgF5A-1; Tue,
 10 Feb 2026 15:14:57 -0500
X-MC-Unique: 7kXRaOL_NZeCh07wsOgF5A-1
X-Mimecast-MFC-AGG-ID: 7kXRaOL_NZeCh07wsOgF5A_1770754496
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 900081800454; Tue, 10 Feb 2026 20:14:56 +0000 (UTC)
Received: from localhost (unknown [10.2.17.130])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDD7D18003F5; Tue, 10 Feb 2026 20:14:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/1] Tracing patches
Date: Tue, 10 Feb 2026 15:14:53 -0500
Message-ID: <20260210201454.177202-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:

  Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 80c15bcc5eb6d30abf90b2fd120cdf01f6ed2082:

  tracetool-test: add QEMU_TEST_KEEP_SCRATCH=1 support (2026-02-10 14:47:14 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Stefan Hajnoczi (1):
  tracetool-test: add QEMU_TEST_KEEP_SCRATCH=1 support

 tests/tracetool/tracetool-test.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.52.0


