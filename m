Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB60CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlVq-0000cF-W2; Tue, 11 Nov 2025 05:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIlVp-0000bC-0f
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:22:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIlVm-0007Y2-WA
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762856525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2R07ri7lkVY8D7SMSDxoYlUQC9fTpNIpJHTbomXy730=;
 b=KWN966ErbS3AO02REBFYAjwvmGGk9Xq2xILjBvlJJaEZlQDSOTYNo5vXsAICKRGFAo67Q8
 bjYqUrQV8q4LAniiLa00RpquTrRfQIX9RDwVSb9ty9ehnAZIyabsBnx4nEPcRh3st0v9Lt
 5+l7dJrglBH17kWSHv5FUaLduC3Rps8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-0lLG3_fUOMGhQvWDNUcFGg-1; Tue,
 11 Nov 2025 05:22:02 -0500
X-MC-Unique: 0lLG3_fUOMGhQvWDNUcFGg-1
X-Mimecast-MFC-AGG-ID: 0lLG3_fUOMGhQvWDNUcFGg_1762856521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2352A180057A; Tue, 11 Nov 2025 10:22:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.97])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D77E930044E0; Tue, 11 Nov 2025 10:21:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/4] Functional test patches (fixes for pylint issues)
Date: Tue, 11 Nov 2025 11:21:54 +0100
Message-ID: <20251111102158.92091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

 Hi Richard!

The following changes since commit 593aee5df98b4a862ff8841a57ea3dbf22131a5f:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-11-10 16:49:59 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-11-11

for you to fetch changes up to 0fa4b130a8d4fc46fb7b0b97b34656ac0c69c3c9:

  tests/functional/m68k/test_nextcube: Fix issues reported by pylint (2025-11-11 09:39:03 +0100)

----------------------------------------------------------------
* Fix some issues in the functional tests that pylint complains about

----------------------------------------------------------------
Thomas Huth (4):
      tests/functional: Fix problems in testcase.py reported by pylint
      tests/functional/aarch64/test_device_passthrough: Fix warnings from pylint
      tests/functional/mips64el: Silence issues reported by pylint
      tests/functional/m68k/test_nextcube: Fix issues reported by pylint

 .../functional/aarch64/test_device_passthrough.py  |  26 ++-
 tests/functional/m68k/test_nextcube.py             |   4 +-
 tests/functional/mips64el/test_malta.py            |  15 +-
 tests/functional/mips64el/test_replay.py           |   4 +-
 tests/functional/qemu_test/testcase.py             | 243 +++++++++++----------
 5 files changed, 150 insertions(+), 142 deletions(-)


