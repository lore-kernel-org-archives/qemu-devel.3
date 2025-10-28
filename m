Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932B2CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeP-00086q-7a; Tue, 28 Oct 2025 12:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeB-00082x-SG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDme2-0003Tz-OX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6PUeoOSQntpzk2Qx2PLOstzj96niPQ9IFJGqCOSv5oQ=;
 b=W+hnZOqpbTvlGKbkTwtJXTwHq29VAfoMf0AFXS5zzgCEOpX9Xfc5OL2XGm18gAlOnN3l38
 R8zq2yKevCCKnWBIm3nmN/3GV0Ska2dWcHxn+iYLCMEpo8vdxpifa5R+8BIWc1/nuqQcG+
 D1Hq6M5bmsWuvOeWSqX+pTx+8p8Atgo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-Cbs0BiLCNXytJyeSGiXSpw-1; Tue, 28 Oct 2025 12:33:51 -0400
X-MC-Unique: Cbs0BiLCNXytJyeSGiXSpw-1
X-Mimecast-MFC-AGG-ID: Cbs0BiLCNXytJyeSGiXSpw_1761669230
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-427a125c925so3107905f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669230; x=1762274030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6PUeoOSQntpzk2Qx2PLOstzj96niPQ9IFJGqCOSv5oQ=;
 b=gwMFp8oGFZXnyJDGzSmbOjJMvv9z2xiGNAhU8cKkjWsdFGTeCpISsvBzcJ/K6WqMYp
 osPbKXSPgWF806p6gIm3S3UbD4hPYAsOd0VH7LdXkdamWXxTTPVWWRl27kUvDNe/tYB5
 VYEsmvJOVOMyS/q0n+aRZLv0qm6DIfu0TiZ8kyfCL2fNO71Fa1o/xRx4+lG7o5fyjnj4
 fkeG9ccAVNnfWMOAoQp9UyRxlUkPS+8gZ84nGLJ9UwkwuARvjFY1ScUcPioSXIcPOo9V
 VDCUVkE4UxWIR8WADQtyLaaPyPZy+O5gaddeu9fX+2lWVe8qsCcUoCLqeUsFp758484Z
 mp2w==
X-Gm-Message-State: AOJu0YwoVdDgx3XToBQjFRPRSvXiTRtnRJBhEXezlCoWM+zyYE1ufvuy
 tKSvayZkNarQ5LH45kiJQNy1yIpOb4Laq2zoMqyIyV7fpudx9QzdUTofoSdYQV6XsQipafNNT8J
 GPJXbqD9XwQnZxSWMmNeeoLJfEnRpjVKkIcNgTYl661oZcsdIVGGGFihW
X-Gm-Gg: ASbGncuo/4SdIzTK048UYOtFonNhaCZ8DuxrxcSd2nXXGT4SO7rRSQOaxyEXsNcZ2rO
 xdG+wrdwdlupC6jHx5ICplyabshtmMXGR+gPKd06CKufaXE/yL2+VGdhrqW/77BdS3b35qaUjYP
 LEfxOHaUCgR/y9GhqGDq5kjJ7h52zY8gjJUwD+E/l5hhZUDxsaKginsD0IkE6sJFSLu8/bXQZG0
 dyGuyT9xt9sTFxmXFrxgCcu71LfQp7jJ83+qXqKiEEyebVQnWb0xj3nBsLB+dEEHR08mYXD/zGP
 blg306CmQVO7Gj0rYKKlnt0fatFyJoAy/ED5lC2oGByiMsIjoWaCZc3D2p0Dllzcm9JnMrpIJbN
 ukls2DKJwikWXXPxBA8Q77TOwladOE95lDc7l4DNURgWakgP+/ewqyyvBJg==
X-Received: by 2002:a05:6000:230c:b0:3ff:d5c5:6b0d with SMTP id
 ffacd0b85a97d-429a7e4eb8fmr2946718f8f.4.1761669230136; 
 Tue, 28 Oct 2025 09:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1rnO9Vj1teyZLbfLSa0ormhS7E7gzTdJKO4ukf1QlRT11j285aOUrbabo99eZV/ZHRf05Ag==
X-Received: by 2002:a05:6000:230c:b0:3ff:d5c5:6b0d with SMTP id
 ffacd0b85a97d-429a7e4eb8fmr2946689f8f.4.1761669229611; 
 Tue, 28 Oct 2025 09:33:49 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db839sm22101553f8f.34.2025.10.28.09.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:33:48 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 00/16] block: Some multi-threading fixes
Date: Tue, 28 Oct 2025 17:33:26 +0100
Message-ID: <20251028163343.116249-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

As noted in “the original patch”[1] (which, in slightly different form,
is still part of this series), with multi-queue, a BDS’s “main”
AioContext should have little meaning.  Instead, every request can be in
any AioContext.  This series fixes some of the places where that doesn’t
seem to be considered yet, some of which can cause user-visible bugs
(those patches are Cc-ed to stable, I hope).

[1] https://lists.nongnu.org/archive/html/qemu-block/2025-02/msg00123.html

A common problem pattern is that the request coroutine yields, awaiting
a completion function that runs in a different thread.  Waking the
coroutine is then often done in the BDS’s main AioContext (e.g. via a BH
scheduled there), i.e. when using multiqueue, still a different thread
from the original request.  This can cause races, particularly in case
the coroutine yields in a loop awaiting request completion, which can
cause it to see completion before yielding for the first time, even
though the completion function is still going to wake it.  (A wake
without a yield is bad.)

In other cases, there is no race (patch 1 tries to clarify when
aio_co_wake() is safe to call), but scheduling the completion wake-up in
the BDS main AioContext still doesn’t make too much sense, and it should
instead run in the request’s context, so it can directly enter the
request coroutine instead of just scheduling it yet again.

Patches 7, 9, and 10 are general concurrency fixes that have nothing to
do with this wake-up pattern, I just found those issues along the way.

As for the last four patches: The block layer currently doesn’t specify
the context in which AIO callbacks run.  Callers probably expect this to
be the same context in which they issued the request, but we don’t
explicitly say so.  Now, the only caller of these AIO-style methods is
block/io.c, which immediately “maps” them to coroutines in a non-racey
manner, i.e. it doesn’t actually care much about the context.

So while it makes sense to specify the AIOCB context (and then make the
implementations adhere to it), in practice, the only caller doesn’t
really care, and the block layer as a whole doesn’t really care about
the AIO context either.  So maybe we should just drop the last four
patches, or keep patch 13, but instead of stating that the CB is run in
the request context, explicitly say that it may be run in any
AioContext.


Hanna Czenczek (16):
  block: Note on aio_co_wake use if not yet yielding
  rbd: Run co BH CB in the coroutine’s AioContext
  iscsi: Run co BH CB in the coroutine’s AioContext
  nfs: Run co BH CB in the coroutine’s AioContext
  curl: Fix coroutine waking
  gluster: Do not move coroutine into BDS context
  nvme: Kick and check completions in BDS context
  nvme: Fix coroutine waking
  block/io: Take reqs_lock for tracked_requests
  qcow2: Fix cache_clean_timer
  ssh: Run restart_coroutine in current AioContext
  blkreplay: Run BH in coroutine’s AioContext
  block: Note in which AioContext AIO CBs are called
  iscsi: Create AIO BH in original AioContext
  null-aio: Run CB in original AioContext
  win32-aio: Run CB in original context

 block/qcow2.h                    |  1 +
 include/block/aio.h              | 15 ++++++
 include/block/block_int-common.h |  7 ++-
 block/blkreplay.c                |  3 +-
 block/curl.c                     | 55 ++++++++++++-------
 block/gluster.c                  | 17 +++---
 block/io.c                       |  3 ++
 block/iscsi.c                    | 46 +++++-----------
 block/nfs.c                      | 23 +++-----
 block/null.c                     |  7 ++-
 block/nvme.c                     | 70 +++++++++++++------------
 block/qcow2.c                    | 90 +++++++++++++++++++++++++++-----
 block/rbd.c                      | 12 ++---
 block/ssh.c                      | 22 ++++----
 block/win32-aio.c                | 31 ++++++++---
 15 files changed, 251 insertions(+), 151 deletions(-)

-- 
2.51.0


