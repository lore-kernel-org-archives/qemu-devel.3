Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0A7C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlpf-00063E-09; Tue, 30 Jan 2024 05:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUlpa-000621-T8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:59:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUlpX-0006rX-GV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706612341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=krAmzH0JZ6VOqQYOs4PlOILyNh6/3GAroC2fm1GAt6g=;
 b=VXruWM3+YLH5VAcJbtQlUrXXVcIFVauFM0UrYyyB3iPNRZxWmms4cJTVCmuaIXKNrTezAl
 RgMvcvCl6MdB+WQwekDrdYrK11iT98CAwZM+osAdjRuRZaRcve8p0uHmZgUv1hHhG94z9m
 Slg5e31BcrIQqerEgn9txa6uUz3qIME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-31UuwtC6P-2nMXRkXU7Ggg-1; Tue, 30 Jan 2024 05:58:59 -0500
X-MC-Unique: 31UuwtC6P-2nMXRkXU7Ggg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6465800074;
 Tue, 30 Jan 2024 10:58:58 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0369F494;
 Tue, 30 Jan 2024 10:58:57 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/4] Misc changes guest agent
Date: Tue, 30 Jan 2024 12:58:52 +0200
Message-ID: <20240130105856.27178-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 11be70677c70fdccd452a3233653949b79e97908:

  Merge tag 'pull-vfio-20240129' of https://github.com/legoater/qemu into staging (2024-01-29 10:53:56 +0000)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-01-30

for you to fetch changes up to b3e0f64487a4b937d871ce4ce9c259e02ec02191:

  qga: Solaris has net/if_arp.h and netinet/if_ether.h but not ETHER_ADDR_LEN (2024-01-30 12:14:28 +0200)

----------------------------------------------------------------
qga-pull-2024-01-30

----------------------------------------------------------------
Angel M. Villegas (1):
      guest-agent: improve help for --allow-rpcs and --block-rpcs

Nick Briggs (1):
      qga: Solaris has net/if_arp.h and netinet/if_ether.h but not ETHER_ADDR_LEN

Peng Ji (1):
      qga-win: Fix guest-get-fsinfo multi-disks collection

Samuel Tardieu (1):
      tests/unit/test-qga: do not qualify executable paths

 docs/interop/qemu-ga.rst | 8 ++++----
 qga/commands-posix.c     | 5 ++++-
 qga/commands-win32.c     | 2 ++
 qga/main.c               | 4 ++--
 tests/unit/test-qga.c    | 6 +++---
 5 files changed, 15 insertions(+), 10 deletions(-)

--
2.42.0


