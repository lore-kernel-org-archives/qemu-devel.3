Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86865C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq0t-0001pc-9X; Tue, 14 Jan 2025 18:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0r-0001mA-D1
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0p-00042m-5i
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J1uBAjgWxFI7eYg8ttPiC1zZuel1qeh6OOxS/SCAb6o=;
 b=MabGa6MXAjNHLL/h6rztex6tyYdiVg8Rot0EpDgFOrdYC1a2d+gWUwjOHPMlEjcYJ0v+Uu
 C81nyX9EzIC8YhvJaLst+caBig2QjVnYLe16ysoP5POW+HNJySuM8RSkBpJ3aZKjWuJ+QW
 xxbWnuhGEsBUhiWuxvAdIz0fDF16FsA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Ku71zmVMMwa51Wy3SixwZg-1; Tue, 14 Jan 2025 18:07:51 -0500
X-MC-Unique: Ku71zmVMMwa51Wy3SixwZg-1
X-Mimecast-MFC-AGG-ID: Ku71zmVMMwa51Wy3SixwZg
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6e1b036e9so584079585a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896070; x=1737500870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J1uBAjgWxFI7eYg8ttPiC1zZuel1qeh6OOxS/SCAb6o=;
 b=sjwLo3pd12xv1OKqhQ+UmJl0U2H3K+fiPngwSZWEeK8nTYXmAMTRaeGg0/Vb3BIIb6
 x61Blb2jCAakKiIfjMnneSTtU2CMsHuRTvJAoeU41V0R5hTKfNdt31cNlNyKty72HN03
 PIkDWgkaHA292GLRudgrk++RMadzNGsp7YSgdwuYB+7fa6jWynzCIv4mwniCd6AN/duO
 LaVhH2GhOG4+azGIkQi20WUBHHDAyhsWC6gpodR9Cp8lrzqYrGZLOT3+z5NVMm3HYmx6
 iPxGkxVNFOwTnBdOPkK9bFm5BS6ar5KffRTEv5/awZSAPjwCZOdzIvIffBf/03GRcybp
 LO1Q==
X-Gm-Message-State: AOJu0Yw5fQxlJv02gOwVHUI+xZh8aZSy0BvAWojmIqzNJbOQ9A/TaeKB
 aNuWyRYvhYgtrG57NL8dU6bbpELyQm339Ji05Ejk2njoDLUPqS6MEg9sPrpNogC9pod8ytf1LQH
 sHEI+hGLnD0JYxLW5+FhSMNvkkCCKJgkKWtskYA3fo3xHZ5D5nqChFOmfb1Ekxd6Bnnv/fNW5zg
 b7OGQs6AgqSyjq0yf+Io2lte8sSbhAysTNKw==
X-Gm-Gg: ASbGnctJp8g+bY3dXsfJ+Rgp/9l/WWnuOtSKdhTO1cddKYFJvXG355vhT0tVGweWtH1
 JRvBpI3BAWOvZMlo6GLYY4n9f2OkmDjxS/hgx+4Nb+wxGPKIr0SBZ6Dg6aWgR/lLa/+wv+xBWIX
 7fGf73CMqJ8nyswSAPHoYU7zjRXTLL3xbAKET43zzbWWfCBffrqc/3M/SV2x609zjPmCH+D9tvH
 91THWo36dt/NWMLF929BQpLxSpQsZ39xsTU4lKToHP3G/cuFSdrezLjge2bKITe64/A6PJJCjIM
 ReO1VHoFdiFq3m1aMF3ed3x2LKOD+JNh
X-Received: by 2002:a05:622a:4d8b:b0:466:9738:22de with SMTP id
 d75a77b69052e-46c710e16c2mr442248411cf.41.1736896070093; 
 Tue, 14 Jan 2025 15:07:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXRwHPYFyGOhmbtn7HR77dcklwG7f7wrE6EzjBupP8N8evcnZiR5Ha+aAJ/6iN1zFN0zLk+g==
X-Received: by 2002:a05:622a:4d8b:b0:466:9738:22de with SMTP id
 d75a77b69052e-46c710e16c2mr442247901cf.41.1736896069573; 
 Tue, 14 Jan 2025 15:07:49 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:07:47 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 00/16] migration: Switchover phase refactoring
Date: Tue, 14 Jan 2025 18:07:30 -0500
Message-ID: <20250114230746.3268797-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/1625266692
    (note: warning is present on rust stuff, but shouldn't be relevant)

This series refactors the migration switchover path quite a bit.  I started
this work initially to measure the JSON writer overhead, but then I decided
to cleanup the switchover path in general when I am at it altogether, as I
wanted to do this for a long time.

A few major things I tried to do:

  - About the JSON writer

    Currently, precopy migration always dumps a chunk of data called VM
    description (QEMU_VM_VMDESCRIPTION) for debugging purpose.  That is a
    JSON blob explaining all the vmstates dumped in the migration stream.
    QEMU has a machine property suppress-vmdesc deciding whether migration
    will have that JSON chunk included.

    Postcopy does not have such JSON dump because postcopy is live session
    and it can't normally be debugged from stream level (e.g. as a streamed
    file).

    A tiny problem is we don't yet have a clue on how much cpu cycles we
    need to construct and dump these JSONs even if they're only for
    debugging, and even if suppress-vmdesc=on QEMU will still try to
    construct these JSONs (e.g. also for postcopy).

    This series has a few patches just to make sure the JSON blob won't be
    constructed if not needed (either postcopy, or suppress-vmdesc=on).  I
    tried to measure the downtime diff with/without these changes, the time
    QEMU takes to construct / dump the JSON blob is still not measurable.
    So I suppose unconditionally having this is ok.  Said that, let's still
    have these changes around so we avoid JSON operations if not needed.

  - DEVICE migration state

    QEMU has a very special DEVICE migration state, that only happens with
    precopy, and only when pause-before-switchover capability is enabled.
    Due to that specialty we can't merge precopy and postcopy code on
    switchover starts, because the state machine will be different.

    However after I checked the history and also with libvirt developers,
    this seems unnecessary.  So I had one patch making DEVICE state to be
    the "switchover" phase for precopy/postcopy unconditionally.  That will
    make the state machine much easier for both modes, meanwhile nothing is
    expected to break with it (but please still shoot if anyone knows /
    suspect something will, or could, break..).

  - General cleanups and fixes

    Most of the rest changes are random cleanups and fixes in the
    switchover path.

    E.g., postcopy_start() has some code that isn't easy to read due to
    some special flags here and there, mostly around the two calls of
    qemu_savevm_state_complete_precopy().  This series will remove most of
    those special treatments here and there.

    We could have done something twice in the past in postcopy switchover
    (e.g. I believe we sync CPU twice.. but only happens with postcopy),
    now they should all be sorted out.

    And quite some other things hopefully can be separately discussed and
    justified in each patch.  After these cleanups, we will be able to have
    an unified entrance for precopy/postcopy on switchover.

Initially I thought this could optimize the downtime slightly, but after
some tests, it turns out there's no measureable difference, at least in my
current setup... So let's take this as a cleanup series at least for now,
and I hope they would still make some sense.  Comments welcomed.

Thanks,

Peter Xu (16):
  migration: Remove postcopy implications in should_send_vmdesc()
  migration: Do not construct JSON description if suppressed
  migration: Optimize postcopy on downtime by avoiding JSON writer
  migration: Avoid two src-downtime-end tracepoints for postcopy
  migration: Drop inactivate_disk param in qemu_savevm_state_complete*
  migration: Synchronize all CPU states only for non-iterable dump
  migration: Adjust postcopy bandwidth during switchover
  migration: Adjust locking in migration_maybe_pause()
  migration: Drop cached migration state in migration_maybe_pause()
  migration: Take BQL slightly longer in postcopy_start()
  migration: Notify COMPLETE once for postcopy
  migration: Unwrap qemu_savevm_state_complete_precopy() in postcopy
  migration: Cleanup qemu_savevm_state_complete_precopy()
  migration: Always set DEVICE state
  migration: Merge precopy/postcopy on switchover start
  migration: Trivial cleanup on JSON writer of vmstate_save()

 qapi/migration.json         |   7 +-
 migration/migration.h       |   1 +
 migration/savevm.h          |   6 +-
 migration/migration.c       | 209 +++++++++++++++++++++++-------------
 migration/savevm.c          | 116 ++++++++------------
 migration/vmstate.c         |   6 +-
 tests/qtest/libqos/libqos.c |   3 +-
 migration/trace-events      |   2 +-
 tests/qemu-iotests/194.out  |   1 +
 tests/qemu-iotests/203.out  |   1 +
 tests/qemu-iotests/234.out  |   2 +
 tests/qemu-iotests/262.out  |   1 +
 tests/qemu-iotests/280.out  |   1 +
 13 files changed, 200 insertions(+), 156 deletions(-)

-- 
2.47.0


