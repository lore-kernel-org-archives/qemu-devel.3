Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AA4C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 06:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Jvm-000196-NT; Fri, 10 May 2024 02:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvO-000155-0W
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvL-0001WI-0P
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715323206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1froynyYaz/+qgfV59l89I9485QKIPsqzAocbiLlcyc=;
 b=QCbXG7ekLMLCAUAXmZFTqpeoIuOV0EYgJrN8BlYsRWJhybMTYBFuob1ZvehXpYrqKIKFEa
 ecs+KFnXhQweC/p+JgdoJjd2Y2opDpvo0tnv0wwzywbHwHDB1soyTMwP69yMqSbv2cFg8p
 2rhwpsY0E2hRsXtZjz4GljRKLdUToN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-OILuKjHPOr61Wtd7BGXe2g-1; Fri, 10 May 2024 02:40:03 -0400
X-MC-Unique: OILuKjHPOr61Wtd7BGXe2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A550800656;
 Fri, 10 May 2024 06:40:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25AEA2087D72;
 Fri, 10 May 2024 06:40:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/8] s390x and misc patches
Date: Fri, 10 May 2024 08:39:53 +0200
Message-ID: <20240510064001.26002-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 36fa7c686e9eac490002ffc439c4affaa352c17c:

  gitlab: Update msys2-64bit runner tags (2024-05-09 05:46:21 +0200)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-05-10

for you to fetch changes up to 0d497106a71a3b17b0228cb87922ef794296cb24:

  tests/qtest: Add some test cases support on LoongArch (2024-05-10 08:34:29 +0200)

----------------------------------------------------------------
* Attach s390x sclpconsole to a proper parent in the QOM tree
* SCLP related clean-ups
* Report deprecated-props in cpu-model-expansion reply on s390x
* Deprecate "-runas" and introduce "-run-with user=..." instead
* Add some more qtest cases on LoongArch

NB: I'm seeing test failures with "tsan-build" job in my CI, but
    they also occur on the master branch in my repository, so
    I assume they are not related to the patches in this PR.

----------------------------------------------------------------
Bibo Mao (1):
      tests/qtest: Add some test cases support on LoongArch

Collin L. Walling (2):
      target/s390x: report deprecated-props in cpu-model-expansion reply
      target/s390x: flag te and cte as deprecated

Cédric Le Goater (3):
      s390x: Introduce a SCLPDevice pointer under the machine
      s390x/event-facility: Simplify sclp_get_event_facility_bus()
      s390x/sclp: Simplify get_sclp_device()

Thomas Huth (2):
      hw/s390x: Attach the sclpconsole to /machine/sclp/s390-sclp-event-facility
      qemu-options: Deprecate "-runas" and introduce "-run-with user=..." instead

 docs/about/deprecated.rst          |  6 ++++++
 qapi/machine-target.json           |  7 ++++++-
 include/hw/s390x/event-facility.h  |  2 +-
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 include/hw/s390x/sclp.h            |  2 --
 target/s390x/cpu_features.h        |  1 +
 hw/s390x/event-facility.c          | 13 ++-----------
 hw/s390x/s390-virtio-ccw.c         | 18 +++++++++++++-----
 hw/s390x/sclp.c                    | 15 +++------------
 system/vl.c                        | 15 +++++++++++++++
 target/s390x/cpu_features.c        | 17 +++++++++++++++++
 target/s390x/cpu_models_sysemu.c   |  8 ++++++++
 tests/qtest/boot-serial-test.c     | 10 ++++++++++
 qemu-options.hx                    | 15 +++++++++++----
 tests/qtest/meson.build            |  3 +++
 15 files changed, 99 insertions(+), 36 deletions(-)


