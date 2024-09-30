Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48435CEBF73
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMYU-0004ah-9T; Mon, 30 Sep 2024 15:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXw-00042z-2l
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXc-0003v9-9k
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727726322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NfuDRBiNCJ1xGiAHkQPTyvtU5zYl01WVk4ySapfprRY=;
 b=hm0TmSTpoKCR8GpeOLf1plrV++eDvfFNyNW80K6yKoDminbZV9+kIxusXYPNJsFoKsx86Y
 AvMEh9JeZc28EwVevS/5mJblTWdFkoDhjp1j/UrLe0Mtbc3Xu3gbz6OvFWkVfeSNP9gu5x
 8B7r+ADayDyEo/9QJ8pmLQxrvaW0KWs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-YqjGuKDgP_ap-NI1BPS3oA-1; Mon, 30 Sep 2024 15:58:41 -0400
X-MC-Unique: YqjGuKDgP_ap-NI1BPS3oA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4586e0c6597so74596481cf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727726320; x=1728331120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NfuDRBiNCJ1xGiAHkQPTyvtU5zYl01WVk4ySapfprRY=;
 b=r1wDsH4bO/R3cz5i5yHGHO8Kj1jl9xAbGcXR7nNiDtfI1N3HKxF1yGtzXjN/kbXL2e
 ndpJaz0S6qm04A3ZrJUElRDmQ7FJAwvexAwZesG5Q4hwvqodDMz0Dk28lgOXeqMVQalX
 1OxUttXEIKQUb8cXLtX/WX/eLPzVsnRLoXXOugnl5tDp3ljlhp7N4BoDddUa8WdBs2p8
 p5I83u1tqwXJgUR64YLJuuri9yjajVfrzXaQALWoUZeAYcBhV1dgKPCTf0RoVQvVswVS
 WmHCG8VWFT5WUUEQGG1UVb9jRsINEzmuwLuy5YiUG+f3RhOUKTlNToIpTmqiqjtFNSk9
 Lb7w==
X-Gm-Message-State: AOJu0YzmXrQ+HJ3SuQrON69Jv9GC2eES+hjp+km8wR2iywrX/9F6ql5a
 ahxf6NXIGefMOzUi0ukLqClaV+gPEWRQ9wVtpa3wdpU6H/m2udQIFICeM2aNN0xRyblZmECnogm
 j3Zv0rQAsrSl6i6ScEMwKJdsH5lUpXR7uPqzgOqq2RZ18pW3Rza9h88sSrFpvFA3VnuiMsifE/c
 VyS/EZN0cJ5kpq4oqXc4Fhb7s39koNObQtVw==
X-Received: by 2002:ac8:7dc1:0:b0:451:a12d:b9d1 with SMTP id
 d75a77b69052e-45c9f1e3792mr141213491cf.10.1727726319982; 
 Mon, 30 Sep 2024 12:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiPzs3fUnb/Ai7jaAYmJoPVnVYwD5hBp2OHZc+zd0F9uQDE61H3+YLMlTpRByGBspBL5RWSg==
X-Received: by 2002:ac8:7dc1:0:b0:451:a12d:b9d1 with SMTP id
 d75a77b69052e-45c9f1e3792mr141213251cf.10.1727726319569; 
 Mon, 30 Sep 2024 12:58:39 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm38879371cf.16.2024.09.30.12.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:58:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 0/7] migration: query-migrationthreads enhancements and
 cleanups
Date: Mon, 30 Sep 2024 15:58:30 -0400
Message-ID: <20240930195837.825728-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Prasad reported a misalignment issue with query-migrationthreads v.s. the
recently migration thread name changes.  So I prepared patch 1, which will
make the main thread on src be named the same way reported either in
pthread or QMP query-migrationthreads API.

Then I found quite something missing around query-migrationthreads.  E.g.,
it so far only accounts multifd sender threads, while it ignored too many
other kinds of migration threads (either postcopy ones, destination multifd
threads, temporary threads etc.).  It means even if an admin can get TIDs
on src QEMU and does pinning (assuming that was the goal of the original
API), it won't be able to do the same for dest QEMUs, which seems to lose
its purpose.

HMP is also missing, I added it too, as thread IDs can definitely be good
candidates during debugging.  If we have QMP ready, it sounds like it
should naturally fit the HMP one too.

I did some cleanups here and there all around.  Feel free to have a look,
thanks.

CI: https://gitlab.com/peterx/qemu/-/pipelines/1475958754

Peter Xu (7):
  migration: Unify names of migration src main thread
  migration: Put thread names together with macros
  migration: Remove thread_id in migration_threads_add()
  migration: Simplify migration-threads API
  migration: Add all threads with QMP query-migrationthreads
  migration: Remove MigrationThread and threadinfo.h
  hmp: Add "info migrationthreads"

 include/monitor/hmp.h          |  1 +
 migration/migration.h          | 17 ++++++++++
 migration/threadinfo.h         | 25 --------------
 migration/colo.c               | 10 ++++--
 migration/dirtyrate.c          | 13 ++++++--
 migration/migration-hmp-cmds.c | 25 ++++++++++++++
 migration/migration.c          | 19 ++++++-----
 migration/multifd.c            | 18 ++++++----
 migration/postcopy-ram.c       | 16 ++++++---
 migration/savevm.c             | 13 +++++---
 migration/threadinfo.c         | 61 ++++++++++++++++++++--------------
 hmp-commands-info.hx           | 13 ++++++++
 12 files changed, 150 insertions(+), 81 deletions(-)
 delete mode 100644 migration/threadinfo.h

-- 
2.45.0


