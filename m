Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFCDCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 05:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEJln-0000KR-1q; Wed, 07 Oct 2026 01:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xEGKG-0002Rv-Lv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:20:20 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xEGK1-0005LR-LC
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:20:00 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2e43f3d1fdso479780266b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1791335840; x=1791940640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+1je5jbz98cOnDM+2YbUYGnloaQTpMBxfi1H9Ht7mU0=;
 b=nJ7MkUiLM51imZos2fq73t/4KjKTf2kt2QGU5G1pepmz2BbxBfOo9zUIdOZ5jtOQ49
 y0aQzM7hDRhuVeY2506KEj6pPVB8SzGFfqoJ2FHIrMW5oP/Q9V0fjeMrUwveDaq4f2U3
 WerWIj2eMvrFlnCUzfvC+S6FadJxOYH6q7D55+EF49kMmjBFWVNc8ksW08aPGI5FgdcQ
 3d9V78VePfIfsLjpTSI9imG7SiYmYFnREZrsz07aHA/8us6wOoLLlwsmNwrkBNKCs7Sf
 UII1HfUTaQkww59/2HBA3VclxAXIEHIXBwqnLSexlwoFyAdJVNr8dsOK3vZDj6jH4LVU
 ekXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791335840; x=1791940640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1je5jbz98cOnDM+2YbUYGnloaQTpMBxfi1H9Ht7mU0=;
 b=NLerYRuSS1LDrhnnK6EDIaGQ/feAG5b3k146ORZphHw9juiJT2mZauYjXtDt2s7qav
 F8N6RYKIrR1PZ3KMY8vTa84FGdhgCngV7DQyyyLpYLj2oYqM4NcmVN7CND8HB29DFmRz
 jH02ttlzx3gPPlVyEE+CVaXjQ4OAbnsjVfRbEGeZo1zGNPFylDLtazGBUWczgZkTpzO2
 a7Dq3uwyY15/ZkgzGUPYPDZ1/c30SWdAzgR53piEGe8pgEAuBKo6G6DqGv8nP1X3/lU3
 ZFDi/bUmoHo8eVwBY7WYbvJbRxq8vsamLeqwNddVU73SkyKW8bhCSrdhdJy3InaId1KM
 3DIg==
X-Gm-Message-State: AFq9FYISd7xvtWtJc6lAHz0Oaq+IvTKgq1p5gQODw9o6Kyb8oAoXAcHR
 Pwomwp2FTSWj0R+z3Dtl0hFVmnD1B/UiuiFZCiBGcDQglEKw3eGmDrT78eUcaHuKYlbiYVvxBew
 koRBO
X-Gm-Gg: AYBFou1PH4J2XBItfSJ3XLLMT68SB5Z0pXGx2TwLRbZa9bh1b31agpehs+BnR8PU+mX
 VYtZQR+UWLNAdsuS/GFNrH3TLHcKqzQL74Rkvr0WPkNVVt8F6ZHBxu7WrUYi7Pfq0za1v93d3tP
 D9ZX/0avJ8rvUKSBJoZFoZP3zzOamLZALbiXqNN2KdCITJG7C/v6YVQj/5YBZ+sPr71B3o88hGb
 ChCOr7JYZ3sjzcZa5jNKh00r3SD+KLdtMNnTfgrEPBzObg4Qki6GzeSnqgCgmNDOQ8pnP0M/QSC
 zq30JG+cAbSAKmXtNiZBWOODtf0/TwIjlkcNLyxPyOaZXi8NqJ5NcD3pGW7m6THUIt3c0InaIQn
 W0nVkhFZkI5RtJ13qeSBdE1vW7/BFrtAOq2DrQK0/1eEgUNRrQGzy7n4IN7ZC3g3vNaw0Rz5Azp
 sjhRR5QFPbI1KBPbuvcOkit0N6xu7y/zIO8uooayY2mAyMh5JjY5d0zqRwlcbOawG8CHw=
X-Received: by 2002:a05:600c:630d:b0:4a0:2533:c8b7 with SMTP id
 5b1f17b1804b1-4a17b56d40bmr33925525e9.35.1791306462085; 
 Tue, 06 Oct 2026 10:07:42 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a39a:8667:da6e:b69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c5b9d6sm76254095e9.13.2026.10.06.10.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 10:07:41 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 0/3] migration/block-dirty-bitmap: fix postcopy abort with
 bitmaps on several nodes
Date: Tue,  6 Oct 2026 19:07:35 +0200
Message-ID: <20261006170738.453977-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=den@openvz.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Postcopy migration of dirty bitmaps kills the destination as soon as
bitmaps live on more than one node:

  qemu-system-x86_64: ../block.c:6400: bdrv_lookup_bs: Assertion
  `qemu_in_main_thread()' failed.

The postcopy listen thread resolves node names with bdrv_lookup_bs()
without the BQL. With a single node the name is sent only during setup,
which runs in the main thread, so the existing test never gets there.

We hit it in production with libvirt: a CBT backup leaves a persistent
bitmap on every disk, libvirt enables the dirty-bitmaps capability, and
the next live migration of any VM with more than one disk aborts the
destination after the guest has already been switched over to it.

Patch 1 names the counted string buffer size that patch 2 needs. Patch 2
resolves every chunk but START from the bitmaps that START set up,
instead of from the block graph. Patch 3 extends
migrate-bitmaps-postcopy-test with a bitmap on a second node, and it
fails without patch 2.

Changes in v2:
- new patch 1: add QEMU_COUNTED_STRING_SIZE instead of bare 256 (Eric)
- patch 2: drop the "Error: " prefix from the new error message (Eric)
- patch 2: move node_alias to the end of LoadBitmapState
- patch 3: add Eric's Tested-by and Reviewed-by

v1: https://lore.kernel.org/qemu-devel/20260924115611.4098417-1-den@openvz.org/

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Denis V. Lunev (3):
  migration: add QEMU_COUNTED_STRING_SIZE for counted string buffers
  migration/block-dirty-bitmap: fix postcopy abort with bitmaps on
    several nodes
  iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node

 include/migration/qemu-file-types.h           |  6 +-
 migration/block-dirty-bitmap.c                | 62 +++++++++++++++++--
 migration/qemu-file.c                         |  5 +-
 .../tests/migrate-bitmaps-postcopy-test       | 19 ++++++
 4 files changed, 83 insertions(+), 9 deletions(-)


base-commit: 942229961efea74b153c44c59188eb08375f10f1
-- 
2.53.0


