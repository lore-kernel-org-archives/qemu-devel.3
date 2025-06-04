Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6248C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoAQ-0006kT-54; Wed, 04 Jun 2025 09:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAO-0006jH-TU
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAM-0004hV-Hg
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PiY0TziwcUH+b9ueEem3h88xuf4Pn7hOYcJ8LXI9xG8=;
 b=jRseNgcmTLX5HukPQHv6LxJMEY7LSwYUtSyvNqXiBNgSpjdWaRwCV4g0SUWFVHX52Zmo8J
 YAJ8eX1A60A7WzztzTivck1ColVIMTpRLijyK7Gqp2I7Dua+7iye3yrNBaFuFPCRRnbODO
 i5npU8l9S13bSLjcHYnE6goGxohsFJM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-OBzkijmwMv-S5-HonK6gLQ-1; Wed, 04 Jun 2025 09:28:22 -0400
X-MC-Unique: OBzkijmwMv-S5-HonK6gLQ-1
X-Mimecast-MFC-AGG-ID: OBzkijmwMv-S5-HonK6gLQ_1749043701
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d64026baso30267585e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043701; x=1749648501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PiY0TziwcUH+b9ueEem3h88xuf4Pn7hOYcJ8LXI9xG8=;
 b=U+AFdomIcux5Gq3RYD+s89M05PJzyqUgFl/5A+DUQ1Dv+BXHbS86bXNLVdIFRx8Fe3
 UcwDFUV/YSIrZiEqrxwncjPKwz0SFiI8AZCZu/C1oEUEwrCv0dLPv2lLPUvhjfBMMQZn
 7dGR8u/d7Bj7pflLwaeQCXVi1WXeIGfoUV3hay4D6Yg7TRpOJAWY24PVL1UOPR4pOeTZ
 9N5fZbeD3j0+tuHIds3ExHZ6ZE7VV/dh5tH9orHwlCbhieT+VtTptDTpQzErB1AUWAqb
 2tKOKBnS6lqO/KExVjtJAop2mHFZBQgoaaWBMhTKLBChyTGkjfMEga5zDSxqWOzeu+OF
 sQQw==
X-Gm-Message-State: AOJu0Yw5OxH/yLVA/N8ZdmN3QPkSSPZwzwBqduzUUXB5MMhkWdB7K7/A
 n6ZXpg02H5MnGKvqHvZScMsrE7maXoSNcAja3uTtrn17rLx7ENW8BHGZau7i7esF34YsGv7Q2sk
 mBbru3K1+hHGUFfgD/Nf2b4V4TwnxXlH2j23MFo/9SMsIW7BA5f/F/0iM
X-Gm-Gg: ASbGncvDmZbOZPE6MfyTbKWOK+E6PsLuf0W8OxveU26i5PenQFhueIP43AelNQ4J8VD
 W5pZJuov73bAlrHeEeo+5bf+oaBqo1uWSGnEF0KPylI9ztR6zx7XG0pg28jBUR5QYSqeh3+D9vH
 Y2+MRUk4B8TVqZfo0djgKimYRMBDV8YnsCwYVqGXjKoscJV7wkMqMkjqRFVgbSs2BLAxDoGI5L9
 HotuTUvRas5fn7iUpeWBmEONaQOjybAsWj7VhyU8FGVcETvtbq0Lf6YlpfO6WdYRmdGmk1b9rZZ
 5dIcb+RMgj6bOXnpaG3P4t1QF2rZDIEdVujfDdeEEXlBwNLtpNxiCVTZEypbHxLdb7gFcA==
X-Received: by 2002:a05:600c:c0d2:20b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-451f78169eemr1080155e9.13.1749043700874; 
 Wed, 04 Jun 2025 06:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErkQiv2t2IRADdUF1rZJF+CcnGymhOciE7hHzX1Bf+OuNeb+wCGtmjdSkXKR20ZQo52LmudA==
X-Received: by 2002:a05:600c:c0d2:20b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-451f78169eemr1079935e9.13.1749043700353; 
 Wed, 04 Jun 2025 06:28:20 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012b09sm197393485e9.37.2025.06.04.06.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:19 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 00/21] export/fuse: Use coroutines and multi-threading
Date: Wed,  4 Jun 2025 15:27:52 +0200
Message-ID: <20250604132813.359438-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

This series:
- Fixes some bugs/minor inconveniences,
- Removes libfuse from the request processing path,
- Make the FUSE export use coroutines for request handling,
- Introduces multi-threading into the FUSE export.

More detail on the v1 cover letter:

https://lists.nongnu.org/archive/html/qemu-block/2025-03/msg00359.html


Changes from v1:
- Patch 1: Clarified “polling” to be `aio_poll()`
- Patch 11 (new): Pulled out from patch 13 (prev. 11)
- Patch 12 (new): Suggested by Eric
- Patch 13 (prev. 11):
  - Drop false polling handlers
  - Use qemu_fcntl_addfl() instead of fcntl(F_SETFL) to keep
    pre-existing FD flags
  - Add a note that the buffer returned by read needs to be freed via
    qemu_vfree()
  - Pulled out a variable rename into the new patch 11
- Patch 15 (prev. 13):
  - Simplified the co_read_from_fuse_fd() interface thanks to no longer
    needing to support poll handlers
  - Increment in-flight counter before entering the coroutine to make it
    more obvious how tihs ensures that the export pointer remains valid
    throughout
- Patch 16 (new): Add a common multi-threading interface for exports
  instead of a specific one just for FUSE
- Patch 17 (new): Test cases for this new interface
- Patch 18 (prev. 14):
  - Drop the contrasting with virtio-blk from the commit message;
    explaining the interface is no longer necessary now that it’s
    introduced separately in patch 16.
  - Generally, the interface definition is removed in favor of the new
    one in patch 16.
  - Some rebase conflicts (due to other changes earlier in this series).
- Patch 19 (new): Stefan suggested adding an explicit note for users on
  how multi-threading behaves with FUSE, not least because in the future
  this behavior may depend on the specific implementation features
  chosen (io-uring or not).  Because the actual multi-thread interface
  is now on the common export options, it is no longer obvious where to
  put this implementation note; I decided to put it into the general
  description of the FUSE export options, inside of this dedicated
  patch.
- Patch 20 (new): Simple sanity test for FUSE multi-threading (just test
  that e.g. nothing crashes when running qemu-img bench on top)
- Patch 21 (prev. 15): Rebase conflict due to the changes in patch 15;
  kept Stefan’s R-b anyway


Review notes/suggestions I deliberately did not follow in v2:
- Stefan suggested to make patch 1 simpler and more robust by allocating
  a new buffer for each request.  This is indeed a simple change (for
  patch 1) that I wouldn’t mind, and that I also started to implement.
  However, eventually I decided against it:
  The problem doesn’t disappear with the rest of the series, it
  basically stays the exact same; though instead of an implicit
  aio_poll() leading to nested polling, it turns into an implicit
  coroutine yield doing pretty much the same.
  For performance, it is better not to allocate a new buffer for each
  request; we only really need a bounce buffer for writes, as there is
  no other case where we’d continue to read the request buffer after
  yielding.  Therefore, the final state I would like to have after this
  series is to use a common request buffer for all requests on a single
  queue, only using a bounce buffer for writes.
  With that, I think it’s better to implement exactly that right from
  the start, rather than introducing a new intermediate state.


git-backport-diff from v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/21:[0012] [FC] 'fuse: Copy write buffer content before polling'
002/21:[----] [--] 'fuse: Ensure init clean-up even with error_fatal'
003/21:[----] [--] 'fuse: Remove superfluous empty line'
004/21:[----] [--] 'fuse: Explicitly set inode ID to 1'
005/21:[----] [--] 'fuse: Change setup_... to mount_fuse_export()'
006/21:[----] [--] 'fuse: Fix mount options'
007/21:[----] [--] 'fuse: Set direct_io and parallel_direct_writes'
008/21:[----] [--] 'fuse: Introduce fuse_{at,de}tach_handlers()'
009/21:[----] [--] 'fuse: Introduce fuse_{inc,dec}_in_flight()'
010/21:[----] [--] 'fuse: Add halted flag'
011/21:[down] 'fuse: Rename length to blk_len in fuse_write()'
012/21:[down] 'block: Move qemu_fcntl_addfl() into osdep.c'
013/21:[0077] [FC] 'fuse: Manually process requests (without libfuse)'
014/21:[----] [--] 'fuse: Reduce max read size'
015/21:[0061] [FC] 'fuse: Process requests in coroutines'
016/21:[down] 'block/export: Add multi-threading interface'
017/21:[down] 'iotests/307: Test multi-thread export interface'
018/21:[0077] [FC] 'fuse: Implement multi-threading'
019/21:[down] 'qapi/block-export: Document FUSE's multi-threading'
020/21:[down] 'iotests/308: Add multi-threading sanity test'
021/21:[0002] [FC] 'fuse: Increase MAX_WRITE_SIZE with a second buffer'


Hanna Czenczek (21):
  fuse: Copy write buffer content before polling
  fuse: Ensure init clean-up even with error_fatal
  fuse: Remove superfluous empty line
  fuse: Explicitly set inode ID to 1
  fuse: Change setup_... to mount_fuse_export()
  fuse: Fix mount options
  fuse: Set direct_io and parallel_direct_writes
  fuse: Introduce fuse_{at,de}tach_handlers()
  fuse: Introduce fuse_{inc,dec}_in_flight()
  fuse: Add halted flag
  fuse: Rename length to blk_len in fuse_write()
  block: Move qemu_fcntl_addfl() into osdep.c
  fuse: Manually process requests (without libfuse)
  fuse: Reduce max read size
  fuse: Process requests in coroutines
  block/export: Add multi-threading interface
  iotests/307: Test multi-thread export interface
  fuse: Implement multi-threading
  qapi/block-export: Document FUSE's multi-threading
  iotests/308: Add multi-threading sanity test
  fuse: Increase MAX_WRITE_SIZE with a second buffer

 qapi/block-export.json               |   39 +-
 include/block/export.h               |   12 +-
 include/qemu/osdep.h                 |    1 +
 block/export/export.c                |   48 +-
 block/export/fuse.c                  | 1181 ++++++++++++++++++++------
 block/export/vduse-blk.c             |    7 +
 block/export/vhost-user-blk-server.c |    8 +
 block/file-posix.c                   |   17 +-
 nbd/server.c                         |    6 +
 util/osdep.c                         |   18 +
 tests/qemu-iotests/307               |   47 +
 tests/qemu-iotests/307.out           |   18 +
 tests/qemu-iotests/308               |   55 +-
 tests/qemu-iotests/308.out           |   61 +-
 14 files changed, 1213 insertions(+), 305 deletions(-)

-- 
2.49.0


