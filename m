Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB32CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENBg-0000nh-5I; Wed, 07 Oct 2026 04:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIhp-0006Ua-HV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIhb-00033A-T8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791345135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LXwj8h1DG5DBfUPpp5pgrU49CGUAo4PJ6q4HymCjp1Y=;
 b=Y1bwNGUaoU7c8cZBnNPG/Xy2mSo2As2TdlVyYDdunNXHCSr5ShlJR6P2gqol66EW7qHhMV
 oQMRsVlQbM7v8tB7xUEJVQX1XC1Z8ZQChCJ/2qjK7LgkkEkFtuONacof+dQWj+htCKC7v4
 eDS1Ev8dH2bkrGtyQAsdVu+XHelZmcI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-7fns-ZafN2GEULQ-Qt8G9g-1; Tue, 06 Oct 2026 14:20:49 -0400
X-MC-Unique: 7fns-ZafN2GEULQ-Qt8G9g-1
X-Mimecast-MFC-AGG-ID: 7fns-ZafN2GEULQ-Qt8G9g_1791310849
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf7856ffso528635885a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791310848; x=1791915648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LXwj8h1DG5DBfUPpp5pgrU49CGUAo4PJ6q4HymCjp1Y=;
 b=D+GFH2PRMQ8/gLGxDv0yuWLclNgaHI9QJM72srqU/wUOi9dBv52zF48ym4oHt5ejOi
 2fauAx/1JT4yWq4NqDUqp7xUcYAq7M461EC8C0tiv12M6oVKlJ9imZ41QstLuC0aS0nH
 3T/q9Du7J5ocfIoCprGWgy0merN7YyUjfPCq5eYLdbVBdS2VaCG8+COaQdnU9emX0Wfl
 ge4SttPTfzIWOaq2vjKmGFCe/1E1+Eu4tHOOpr0cxkP2nHFkNYb8zCEQfWYYUT+SIZxO
 U20vIJfkQN4yrmbGWTgUZsHa/9Xoo5M5HUv7izAImzKnl3y/FxB3sKBG1mobX1Su+NKi
 VEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310848; x=1791915648;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LXwj8h1DG5DBfUPpp5pgrU49CGUAo4PJ6q4HymCjp1Y=;
 b=C5TUOXooG6j0BAtCGtNw4Rgn7UOlLkIQ7PcqxI1pAKoWNv/c9+zbL6Z5kzxu5h/UQy
 T3AxgXPrI4lByxbjAMALUk7OM7clKibOQtaUjrbkAEHk7aygvzycvtHpX/ijHmciGgTA
 3u5g4qYL6g24ttoMMtgMVAqROeWWj3mYkB1DipbaZUhWPbi0XYYH7FNamuVncNRoCePz
 a+EH35Payi2LJTSHnEVfbXldsY/HJkqrLjj/AV4dviJOGWxwE1KOpKTXl6wSHhypNGS+
 0JvvE/Onzrw5CC7kebMFNVGB2RLToFsi0RHK/GfKF+7jNPIUUVKEzdvbc6RfMcliQb+9
 ZrRA==
X-Gm-Message-State: AFuF++mnIykpykQgUp9c01otrFeNAt2p6FAKbPQSZCVHKPHh5YEXx78v
 fuYYCufCiRuAbBu3MOtNVU/2UZffQG46d+LYyHyvkIHYinEi9ZmxlXqVLbRJOjPFJkbxQ0wrkUg
 7hsdqSph66rST5pKD1KaWoLxpxksad6ig59cNSIeaKp9ByhPxOUmIvb2i8OD3rKhx8k02DxWocf
 uzK2LsCFdy+GdzdV8j/suWB4bYzYIQE1kjnF+DTg==
X-Gm-Gg: AYBFou3xR8wMB2xzpOxvvjF+pi3QmLC/peRGLcD16+iG0ULuUsQ3jzwPGmeJ/UXy9zc
 TFcC6pewDv30ksBNC225hNyNvtBTTUJibbOccXCmTDCjjSk6KoikP0hDyBX1CggRd0hsNM8xYvw
 bv0wFJLHODnH5Sr6kiBSn+YEkhu7Cswz4r1eL3X9DjxiWNe84oA0IHmmgZYJ6zr9iN4+HJSbsSW
 n2Q/Pk56L0HwoVrgu1iRBatnohO2/ZbdHN66fGWAX55rHEpCEroHIXl/yex6mUW49KlAYo2IQCX
 c/5h2mWkQQRSss0PtJ15jjdJUQLkZ51JAjZiXm/tt/Tw+6k9vFE3VvPNULq1MQo50QVJA2Y=
X-Received: by 2002:a05:620a:2b8f:b0:93e:5fff:db01 with SMTP id
 af79cd13be357-93e8f05c162mr435091985a.6.1791310848475; 
 Tue, 06 Oct 2026 11:20:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8f:b0:93e:5fff:db01 with SMTP id
 af79cd13be357-93e8f05c162mr435084385a.6.1791310847742; 
 Tue, 06 Oct 2026 11:20:47 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e98f6bd92sm22552185a.1.2026.10.06.11.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:20:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 0/7] migration: Fix multifd+postcopy break on qemu-7.2
 machine type
Date: Tue,  6 Oct 2026 14:20:39 -0400
Message-ID: <20261006182046.3767283-1-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CI run: https://gitlab.com/peterx/qemu/-/pipelines/2918307713

v2 changelog:
- Comments, docs, commit log updates [Fabiano]
- Move migration_channel_peek/identify() out of
  migration_incoming_channel_install() [Fabiano]
- Make migration_incoming_setup() return success status [Fabiano]
- Remove a redundant CH_POSTCOPY path in migration_channel_identify()
  [Fabiano]

Currently, upstream is broken with migration with qemu-7.2 machine types,
simplest reproducer:

      $ QTEST_QEMU_MACHINE_TYPE=pc-q35-7.2 \
          QTEST_QEMU_BINARY=./qemu-system-x86_64 \
          ./tests/qtest/migration-test --full \
          -r /x86_64/migration/multifd+postcopy/preempt/plain

This series should fix it.  Note that this solution will not work for TLS,
and due to the fact that TLS is not peekable (which the design of this
series currently rely on), TLS is not fixable.  But as long as the user
doesn't enable all four features (multifd, postcopy, preempt, tls) then it
will still work.  I have much more info in patch 6, feel free to read.

Patch layout:

Patch 1:    Added one more test for multifd+postcopy recovery non-tls
Patch 2-5:  Something I found either buggy or good to have cleanups
Patch 6:    Fix the problem on incoming side
Patch 7:    Fix the problem on outgoing side

Tests I've done:

- The qtest, concurrent execution of a lot of "migration-test --full",
  which I normally use to catch race conditions.  Nothing pops up.

- Test migration with all three features enabled (multifd, postcopy-ram,
  postcopy-preempt) on different machine types and binaries combinations,

  |----------+---------+-------------+--------|
  | Machine  | Source  | Destination | Result |
  |----------+---------+-------------+--------|
  | q35-11.2 | master  | master      | PASS   | --+
  |          | master  | patched     | PASS   |   |-----> 11.2 machine not affected
  |          | patched | master      | PASS   |   |
  |          | patched | patched     | PASS   | --+
  |----------+---------+-------------+--------|
  | q35-7.2  | master  | master      | FAIL   | --------> current breakage
  |          | master  | patched     | PASS   | --+
  |          | patched | master      | PASS   |   |-----> patch any side should fix
  |          | patched | patched     | PASS   | --+
  |----------+---------+-------------+--------|

- Manual test of qemu-7.2 binary <-> patched new binary with either (1)
  multifd migration, or (2) postcopy + preempt migration.  NOTE: qemu-7.2
  doesn't support enabling all.

Comments welcomed, thanks.

Peter Xu (7):
  tests/migration-test: Add multifd+postcopy test for preempt recovery
  migration: Add two more trace points for incoming channel mgmt
  migration: Fix socket listen backlog
  migration: Split migration_channel_process_incoming()
  migration: Dump type of channel in set_incoming_channel tracepoint
  migration: Fix incoming channel race with multifd and preempt_pre_7_2
  migration: Postpone the outgoing preempt channel for preempt_pre_7_2

 migration/channel.h                    |   6 +-
 migration/migration.h                  |  35 ++
 migration/channel.c                    | 446 +++++++++++++++++++++----
 migration/migration.c                  |  67 +++-
 migration/socket.c                     |  25 +-
 tests/qtest/migration/postcopy-tests.c |  11 +
 migration/trace-events                 |   8 +-
 7 files changed, 510 insertions(+), 88 deletions(-)

-- 
2.55.0


