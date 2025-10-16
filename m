Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91FBCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Qo3-0002lL-6r; Thu, 16 Oct 2025 12:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9Qny-0002jI-TA
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9Qnp-0004v1-4e
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760631967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fzHzX4/c7bKYXw27BtHo12UWi3Ao1C/4OSHKZSAUK5g=;
 b=DjE/IOJHBFWQ/pP1bYIeGiTa3oDC4qG2u2jJQSYK6qzgF3PLo28zqTS34nu0kL4g3KvkzE
 EA24UfAuDqD5tO7UmdKDKdYCTh1/IJk3sIhp1Hjv6Iiph47KpcbtPPsDeaL6sZHhXKacK6
 lX6yxCCSzwvd39xwteVON92RZe1icnw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-pY3o-AnVNveZE483rGzKZg-1; Thu,
 16 Oct 2025 12:26:05 -0400
X-MC-Unique: pY3o-AnVNveZE483rGzKZg-1
X-Mimecast-MFC-AGG-ID: pY3o-AnVNveZE483rGzKZg_1760631964
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32DD218001E9; Thu, 16 Oct 2025 16:26:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 065701956056; Thu, 16 Oct 2025 16:26:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/10] Various testing and s390x patches
Date: Thu, 16 Oct 2025 18:25:51 +0200
Message-ID: <20251016162601.442557-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

The following changes since commit 8109ebdb95c45d9062c7e6e7beae0ee571fca4f8:

  Merge tag 'pull-loongarch-20251015' of https://github.com/bibo-mao/qemu into staging (2025-10-15 14:49:51 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-10-16

for you to fetch changes up to d6f7f9254e333c56226bb7051e74ea57daea2fff:

  target/s390x/mmu_helper: Do not ignore address_space_rw() errors (2025-10-16 18:19:23 +0200)

----------------------------------------------------------------
* Improve cache handling for the msys2 CI and the functional asset cache
* Clean ups for some minor issues in functional tests
* Don't ignore errors of address_space_rw in s390x MMU code

----------------------------------------------------------------
Daniel P. Berrangé (3):
      gitlab: purge msys pacman cache
      tests/functional: remove use of getLogger in reverse debuging
      tests/functional: ensure GDB client is stopped on error

Philippe Mathieu-Daudé (2):
      target/s390x/mmu_helper: Simplify s390_cpu_virt_mem_rw() logic
      target/s390x/mmu_helper: Do not ignore address_space_rw() errors

Thomas Huth (5):
      python/qemu: Replace some remaining "avocados" with "functional tests"
      tests/functional/aarch64: Drop some sbsaref_alpine tests
      tests/functional: Set current time stamp of assets when using them
      tests: Evict stale files in the functional download cache after a while
      tests/functional/alpha: Remove superfluous fetch() line from the clipper test

 MAINTAINERS                                     |  1 +
 python/qemu/machine/README.rst                  |  2 +-
 python/qemu/utils/README.rst                    |  2 +-
 target/s390x/mmu_helper.c                       | 17 +++++--
 .gitlab-ci.d/windows.yml                        |  1 +
 scripts/clean_functional_cache.py               | 45 +++++++++++++++++
 tests/Makefile.include                          |  1 +
 tests/functional/aarch64/test_sbsaref_alpine.py |  6 ---
 tests/functional/alpha/test_clipper.py          |  1 -
 tests/functional/qemu_test/asset.py             | 13 +++++
 tests/functional/reverse_debugging.py           | 65 ++++++++++++-------------
 11 files changed, 105 insertions(+), 49 deletions(-)
 create mode 100755 scripts/clean_functional_cache.py


