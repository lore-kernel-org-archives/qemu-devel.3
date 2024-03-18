Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05E8C54E69
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHET-0000TV-2v; Mon, 18 Mar 2024 13:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHER-0000T1-H4
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHEP-00076r-Ts
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710784623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w8cIUJO8ScEMfsYSb0rWH8G6K5GgOtk0GCZLgzIExDM=;
 b=gfq8tze0nodEWtDuqMnU/WpQjCQvjuz8DwVzQ5vOKp8zHq9Q5RfZ3IUw2E8/U+9twWDmaR
 R57ayYHqAOvlb3hpFawefKmvtkNTePq9db2RjCwCtNVdF63FKjNqaqWSfkNJvqSxvvc23l
 bDdp5TowOnWBckbFUmcmOESt462GYgw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-O8p-ghY6MqiMEmLYD_fYgg-1; Mon,
 18 Mar 2024 13:57:01 -0400
X-MC-Unique: O8p-ghY6MqiMEmLYD_fYgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C76B3C0CEF7;
 Mon, 18 Mar 2024 17:57:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EBBF2166B32;
 Mon, 18 Mar 2024 17:57:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/4] s390x and misc patches for 9.0-rc0
Date: Mon, 18 Mar 2024 18:56:51 +0100
Message-ID: <20240318175655.756084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

 Hi Peter!

The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:

  Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-03-18

for you to fetch changes up to aebe0a8552e8d419c8103e60e593f2778eab41c4:

  travis-ci: Rename SOFTMMU -> SYSTEM (2024-03-18 17:18:05 +0100)

----------------------------------------------------------------
* Clarify s390x CPU topology docs and CPU compatibility error messages
* Improve the Sparc CPU help text
* Rename SOFTMMU to SYSTEM in the travis.yml file

----------------------------------------------------------------
Claudio Fontana (2):
      docs/s390: clarify even more that cpu-topology is KVM-only
      target/s390x: improve cpu compatibility check error message

Philippe Mathieu-Daudé (1):
      travis-ci: Rename SOFTMMU -> SYSTEM

Thomas Huth (1):
      target/sparc/cpu: Improve the CPU help text

 docs/system/introduction.rst       |  2 ++
 docs/system/s390x/cpu-topology.rst | 14 ++++++++------
 target/s390x/cpu_models.c          | 22 +++++++++++++++-------
 target/sparc/cpu.c                 |  5 +++--
 .travis.yml                        |  8 ++++----
 5 files changed, 32 insertions(+), 19 deletions(-)


