Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76F3C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQ8-00059m-1I; Tue, 01 Jul 2025 07:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQ3-00058t-Fo
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZPw-0003EE-Hr
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X230xMRuC2AZJb8px0TMmN2N+5uco+uzUp9uzbplB0s=;
 b=FH9VgT1IDbwTwRgZfIn/j0cEwefp0J3krm9HgPnFlsEe43Ou+gWF+iUcNRbjgIhZcXyl8O
 HJs8vWyxL8K42BORPGKjFLFwODL8L9diWkQ3797PTmDucBzPZQh20VrToKkfdrceBaKPRh
 MA8GSsTw8Mq8UTOWfPTByeJVYRWhVOw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-E7T52Kc6M-661Sq5rmtf_Q-1; Tue, 01 Jul 2025 07:44:46 -0400
X-MC-Unique: E7T52Kc6M-661Sq5rmtf_Q-1
X-Mimecast-MFC-AGG-ID: E7T52Kc6M-661Sq5rmtf_Q_1751370285
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so3027835f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370285; x=1751975085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X230xMRuC2AZJb8px0TMmN2N+5uco+uzUp9uzbplB0s=;
 b=jVqiZFlh/3Y0lxyroZmJfi3pVVFi+339Jk2k5AlnRHAc9gx57H9e7OFtE6GFSgTgYG
 aDKalgPKBtG/TfnyxpZ5pbPotL/yO/wbqqJ+KxD2JROfO3bJqXPzcJsmoHZVQIA3pb0G
 xpZRbNj6SY5AG3zr7vWvHcRKeYWFvW/J4L0atrIz0Ac5cek5+WAqBBl9CB2ZUioJVU5N
 lpVUlUd1+enLYyy7EfZK5rY4zIsyAxw6QGPmuOP6P4XU2L+Kpl3EiFm0nbZQpW1eMtpy
 acp+2M4wDYD/Zr3qZIjNpo2Xmb/C2ziHHWtN+pqAkrtCD08KFnpTxC3JT31K1blF9yBk
 1MIA==
X-Gm-Message-State: AOJu0Yw8mu88U034rHq9APRxv0N4/Uurq21t63dJh9Ymec385+fOKyV0
 vIihs6U6iaYgLUKZt8CSJRPh85xvAJhi8BULOnp5i6A/md0Vb3WEPi4Za4tWQjtzzp/Vmhaq5sP
 qAV5JhzfKp1H/1t4jcjsZDAOxpxl/sb9kOFOBtbFbgryxqlP0WgARIHUE
X-Gm-Gg: ASbGnctzZm7Bh6UjdF6nqChHH6wH93l9xVMe/bXKafszjx1VijwH/lYYmMtfjuVkq5f
 lwK+b6YxUAkLfbKeTy31vpK1VHJhtLPtNuMZC+XGQ5YB3ZaUIxPJOv+By3dxukFW4HieTHgZAqT
 ETctZvLnecg1prq8qpw002ZK6Hj+k7hQRtm0vb1cJbtixzaSw5+7ik+hd3C3CdFrgYyGvZx9OsR
 t0N5eVetrhoNBnvg0aXPUtCWhQ8CdsYxC9yD+6FqlAWKm4/rjLnEDVxAneflfptfixi51EthFvZ
 /EZO0Gpk5dGdWgD3FpOuXs184zKmcbXcDwatj48dLwwN9ZYPrwpSd+vL3kWDL4udyJQq8wkpeOi
 MaF5u
X-Received: by 2002:adf:ba4b:0:b0:3a5:39d5:d962 with SMTP id
 ffacd0b85a97d-3a917bc78demr9960428f8f.41.1751370284678; 
 Tue, 01 Jul 2025 04:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd8QvK2nqeWJKgeZQuko/9UqHOCAsAZvTFS+mUD5LKBhfg2P1T1S0P2TZcwPSHjuJL21d94g==
X-Received: by 2002:adf:ba4b:0:b0:3a5:39d5:d962 with SMTP id
 ffacd0b85a97d-3a917bc78demr9960409f8f.41.1751370284236; 
 Tue, 01 Jul 2025 04:44:44 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453883d81besm176542325e9.38.2025.07.01.04.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:44:43 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 00/21] export/fuse: Use coroutines and multi-threading
Date: Tue,  1 Jul 2025 13:44:16 +0200
Message-ID: <20250701114437.207419-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

This series:
- Fixes some bugs/minor inconveniences,
- Removes libfuse from the request processing path,
- Make the FUSE export use coroutines for request handling,
- Introduces multi-threading into the FUSE export.

More detail on the v1 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-03/msg00359.html

v2 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-06/msg00040.html


Changes from v2:
- Patch 12: Moved qemu_fcntl_addfl() into the #ifndef _WIN32 section
  where other fcntl() wrappers reside
- Patch 13: Fixed comment to say `export` instead of `exp`; kept
  Stefan’s R-b
- Patch 15: Same as patch 13
- Patch 18: In macro, use correct parameter `queue` instead of the
  non-existing `q`


git-backport-diff from v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/21:[----] [--] 'fuse: Copy write buffer content before polling'
002/21:[----] [--] 'fuse: Ensure init clean-up even with error_fatal'
003/21:[----] [--] 'fuse: Remove superfluous empty line'
004/21:[----] [--] 'fuse: Explicitly set inode ID to 1'
005/21:[----] [--] 'fuse: Change setup_... to mount_fuse_export()'
006/21:[----] [--] 'fuse: Fix mount options'
007/21:[----] [--] 'fuse: Set direct_io and parallel_direct_writes'
008/21:[----] [--] 'fuse: Introduce fuse_{at,de}tach_handlers()'
009/21:[----] [--] 'fuse: Introduce fuse_{inc,dec}_in_flight()'
010/21:[----] [--] 'fuse: Add halted flag'
011/21:[----] [--] 'fuse: Rename length to blk_len in fuse_write()'
012/21:[----] [-C] 'block: Move qemu_fcntl_addfl() into osdep.c'
013/21:[0008] [FC] 'fuse: Manually process requests (without libfuse)'
014/21:[----] [--] 'fuse: Reduce max read size'
015/21:[0008] [FC] 'fuse: Process requests in coroutines'
016/21:[----] [--] 'block/export: Add multi-threading interface'
017/21:[----] [--] 'iotests/307: Test multi-thread export interface'
018/21:[0016] [FC] 'fuse: Implement multi-threading'
019/21:[----] [--] 'qapi/block-export: Document FUSE's multi-threading'
020/21:[----] [--] 'iotests/308: Add multi-threading sanity test'
021/21:[----] [--] 'fuse: Increase MAX_WRITE_SIZE with a second buffer'


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


