Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2A606B0DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GOxqrGOc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuw0-00072A-BK; Mon, 02 Nov 2026 11:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuvs-0006kO-3W
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuvq-0002Mz-Gj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2VloB1kJtnNK2y3OGMuA50FXNKUgSiFNyy7Vs/YFzTI=;
 b=GOxqrGOcD/gC5Nfvd+Z0P1ccL/7jr9PJ3iRfaQM5xJNCQR1RZ7Y6GdK8kwKK3OKsCcQvpi
 3fI2QRbgf3SD8VZZaqx3D6vzURXoPIpB0TgxkO8WvZzMm4jDUuIiTwiCvCdFs71T4CyDIc
 Cn8fxqBxGxs4OPxF8IQ6mIlc+9DlfHw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-Ze4hqV8gOYKHbpu6rRbHbg-1; Mon,
 02 Nov 2026 11:30:48 -0500
X-MC-Unique: Ze4hqV8gOYKHbpu6rRbHbg-1
X-Mimecast-MFC-AGG-ID: Ze4hqV8gOYKHbpu6rRbHbg_1793637047
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B2221800603; Mon,  2 Nov 2026 16:30:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A89D81800444; Mon,  2 Nov 2026 16:30:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@linux.dev>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/5] Misc patches before the v11.2 softfreeze
Date: Mon,  2 Nov 2026 17:30:39 +0100
Message-ID: <20261102163044.644663-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

 Hi Richard!

The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:

  Merge tag 'qemu-sparc-20261101' of https://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-11-02

for you to fetch changes up to 213c716c58738be9d39488e56e6d6ed25dacd14e:

  tests/qtest/usb-hcd-xhci: test Address Device with an unreadable DCBAA (2026-11-02 15:34:15 +0100)

----------------------------------------------------------------
* Add a "check-thorough" test target
* Make sure that the next-cube machine shows a deprecation note
* Reset the open retry count after a successful open in the usb-host code
* Make sure that XHCI code does not ignore failure when reading the DCBAA

  Note: I really don't have time to look for USB patches anymore, so after
        this pull request, I'll stop helping out here. We really need a
        dedicated person acting as a maintainer for the USB code...

----------------------------------------------------------------
Junjie Cao (3):
      usb-host: reset the open retry count after a successful open
      hw/usb/hcd-xhci: fail Address Device when the DCBAA entry is unreadable
      tests/qtest/usb-hcd-xhci: test Address Device with an unreadable DCBAA

Peter Maydell (1):
      hw/m68k/next-cube: Show deprecation notice to users

Thomas Huth (1):
      tests: Add a target to run all tests in thorough mode

 hw/m68k/next-cube.c             |  1 +
 hw/usb/hcd-xhci.c               | 41 ++++++++++++-------
 hw/usb/host-libusb.c            |  1 +
 tests/qtest/usb-hcd-xhci-test.c | 87 +++++++++++++++++++++++++++++++++++------
 tests/Makefile.include          | 13 ++++--
 5 files changed, 114 insertions(+), 29 deletions(-)


