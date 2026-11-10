Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9B606A335
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=c9irRewx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqeb-0005Kt-Ql; Tue, 10 Nov 2026 13:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqeY-0005JW-FD
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqeV-0003MS-Uw
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so25733185e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1794335581; x=1794940381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cITEKa0UAMnLwDdLiTGBYGuTUBxonGAgrfEPt9/kBiU=;
 b=c9irRewxaGyfShsHLPCpFX1Z4P64+6gmKdYVd28ObEV6SeoHXDy/CrzT9KIKJ6IjZA
 UyZZuB9i4sCJbatNvHTegkuQXHRoxNpsZR/wI72UiDx75IUa0ADL44TUcEt6mC5M/5/R
 548YrlHR/3oxwASagFIDuV01wtSQ3HHB8og+Gmulomai5bdzGreGcK1TBuhEsfTMrjhH
 fSW7la4wpwJTtqfmpSUfMLbaFnGbEdYtbCfEQW+flUr+47mUIbYCbVamkIWPclDRVOK+
 a1WFqhc6hLi3NG6c3VC1Mh99gaRGu+NueGfm2zW0TuPM9SdGlhcsf7RZSVa7psp6G25Z
 73Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335581; x=1794940381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cITEKa0UAMnLwDdLiTGBYGuTUBxonGAgrfEPt9/kBiU=;
 b=hTTamh4AFxYKBEaXGAvGqkEr1YLTCf1Yi8XwfbyU8AQVodmWAus62TEfT9GxiA2fEJ
 O2YQq3uQCPYsIkk1E8Sujw35Q2uFua5fwKsQ5dCIy2EbDbMPSugLczAoCtZVAMDfjsem
 /W+RcZ7b9hQh4v+GoqwtnQHVYZjjbmUJGxagH0VYEYWm72POMQyJEbTSi1rOjr1nsDRo
 JbPk/n5T+/DID+9wFvIjesPIyQ2iQfbcXtt9HXyCGwOuldxrKtnLyha0utJJWBc2iZeh
 Z1O09FALpYLeSzIHYVBjQlOaUZ2d3JLA5S2TjhGbZXUjlhoAMTFaZjE4pVQ6cgEzqqaR
 rWgA==
X-Gm-Message-State: APuU4Z/HNB5Vvl1s3E+vqkY5/zJ5k2Jue0xB4CY8Rw8jFy1LsWUL7MIK
 SrzMX8tQ98M++rp+M4wlgqEjihc49SShektiTuY0rVQojLNcG3BIk86r+J6d6EceipeEUqy5jyW
 UJ+ez
X-Gm-Gg: AYBFou3vrxBCW8Y9S82JNKl3pesF+MKAvviBS2aIYk49rIQ/ogRiyUtSOKlHTPgM659
 DqGFcb6W5VC1Ade0bIbB5l9dAFO2n5WIvxQTH3JhVi8jHKd2MHz/NujOMCC/sVGj35PfFXA4dt9
 YJa6Rdtl8EnjLqXa4tQu0GRF+Jontmx/i5CaZ21bXYDZ6W8ExAYGdbOTRUZ25eK+u5/cYfp8z1G
 ZaHdZtxZM+Z21d3dVwMQ1oQiFQrEDZ3AdGH4Pc17qm7HS6F5mRRcZ1KVK9KjFdPhDji1qN1vja8
 qikJr8AKMV8FbYSk0Z2P2ouViLeJhwVqUr18CO0RhEdW+SWQcTne1dfs/Tcerwrs/AeVK3nUcMv
 59dA+eEn5yTHxCbhmuivG9i00h2kDRAaUb9Gx4b6JCbwf78f+G7Vey0wmrPZnjr4npG+iCh1ziQ
 JUqw4wdj1nuy37sUlYXFe1g9RuUR2a7ukYwV0vEOH++32TXOahben8tXR7hKBTIUt+7C0SASLHP
 3L75/XmPQ5SQjm7CGpl3nABRMEhrswQS73WmqaF1EQmsfGckG3NzgtEZ8S+0pFmca+aqXmKO5Gw
 QSieL+EMXC+kzwJV8DmwBjnBzDs=
X-Received: by 2002:a05:600c:4f48:b0:4a4:4d57:8462 with SMTP id
 5b1f17b1804b1-4ba0234bc33mr68655435e9.24.1794335580771; 
 Tue, 10 Nov 2026 10:33:00 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f78:6441:d0f1:22af])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm6384827f8f.37.2026.11.10.10.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:33:00 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 0/5] migration/postcopy: report destination states only
 after the run state change
Date: Tue, 10 Nov 2026 19:32:52 +0100
Message-ID: <20261110183257.2930908-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the postcopy destination, the postcopy-active and completed states
can be reported while the VM is still in RUN_STATE_INMIGRATE. The run
state only changes in loadvm_postcopy_handle_run_bh(), but
loadvm_postcopy_handle_run() switches to postcopy-active before it
schedules the BH, and the listen thread can report completed before the
BH has run. Precopy does not have this problem: the run state changes
before completed is reported.

We hit this in production. A VM with a persistent dirty bitmap migrates
its bitmaps in postcopy, so libvirt runs the Finish phase as soon as the
source enters postcopy-active. Our libvirt reattaches disks on the
destination in Finish, and the blockdev-add calls land while the
destination is still in RUN_STATE_INMIGRATE. The new nodes are created
inactive, the device cannot be attached to them ("Block node is
read-only"), and the guest is lost on both hosts. A bitmap-only
postcopy makes the window wide, because the listen thread has almost
nothing to load.

The series orders both destination states after the run state change
and adds a qtest check that fails on master; fast snapshot load
(postcopy-ram with mapped-ram) is not covered. The series also gives the
source's postcopy-active the same meaning. It takes Peter's idea from
the review of Juraj's RFC [1]: record the package-loaded ping and send
the pong later [2]. Here the pong is sent from the run BH, after the run
state change, rather than from loadvm_postcopy_handle_run(). Juraj
confirmed that this fixes the unrecoverable source he reported [3]. The
late pong keeps the source in postcopy-device longer, so it can be
dropped without affecting the rest.

The late pong has two more consequences. A bitmap-only postcopy with a
return path deadlocks unless dirty_bitmap_load() stops holding its lock
while it reads the stream. That fix was sent separately [4] and this
series is based on it. The new iotest case covers that configuration;
feel free to drop it. And an autostarting destination that dies between
vm_start() and the pong lets the source resume after the guest has
briefly run there. This cannot happen with -S, which libvirt uses.

[1] https://lore.kernel.org/qemu-devel/20260423154525.10292-1-jmarcin@redhat.com/
[2] https://lore.kernel.org/qemu-devel/afJg6VzsaslzZQW1@x1.local/
[3] https://lore.kernel.org/qemu-devel/20260929132150.2215007-1-jmarcin@redhat.com/
[4] https://lore.kernel.org/qemu-devel/20261110155113.2721134-1-den@openvz.org/

Many thanks to Juraj for the postcopy-device state in 7b842fe354c. It is
what gives the source a point to wait at, and this series only moves
that point to where the destination has really left
RUN_STATE_INMIGRATE.

v2:
- the run BH sets main_thread_load_event instead of a second event
  (Peter)
- the destination's switch to postcopy-active keeps the explicit
  POSTCOPY_DEVICE check (Peter)
- new iotest case for a bitmap postcopy with a return path
- the commit message of the late pong is updated; the code is
  unchanged, so I kept the tags
- rebased

v1: https://lore.kernel.org/qemu-devel/20261002110258.1835979-1-den@openvz.org/

Based-on: <20261110155113.2721134-1-den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org

Denis V. Lunev (5):
  migration/postcopy: report COMPLETED only after the run BH has run
  migration/postcopy: set destination postcopy-active in the run BH
  tests/qtest/migration: check the destination run state in postcopy
    tests
  migration/postcopy: answer the package-loaded ping from the run BH
  iotests/migrate-bitmaps-postcopy-test: cover postcopy with a return
    path

 migration/migration.c                         |  1 +
 migration/migration.h                         |  4 +-
 migration/savevm.c                            | 25 +++++++++---
 .../tests/migrate-bitmaps-postcopy-test       | 39 +++++++++++++++++++
 .../tests/migrate-bitmaps-postcopy-test.out   |  4 +-
 tests/qtest/migration/framework.c             |  6 ++-
 tests/qtest/migration/migration-qmp.c         | 10 ++++-
 tests/qtest/migration/migration-qmp.h         |  3 +-
 tests/qtest/migration/migration-util.c        |  8 ++++
 tests/qtest/migration/migration-util.h        |  2 +
 10 files changed, 88 insertions(+), 14 deletions(-)


base-commit: 723622bedb0b423de7d1c61ebbe6e7a71934949c
prerequisite-patch-id: 67b7337e86202ef7509fc53ff8915a814a477e3b
-- 
2.53.0


