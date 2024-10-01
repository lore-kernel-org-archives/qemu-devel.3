Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0FCCEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveao-0005sF-7w; Tue, 01 Oct 2024 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1sveam-0005rk-N3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1sveag-00030l-Il
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727795705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ct0DP631aMHKPh1GV9JBtCpwCw8dhuxw3vRy4mMX34U=;
 b=DypcPCj4jXwYsP0BYk45yZJynq9gvq+hmJ2sO4405hmAf+xAaPxdvT2zm64n3/gQv+m7O5
 PM+R+LX+yVUXz1EMYTYJ0cCfSmD2jEV+jvCR6QuclnztLgfPnFxboGg+e/ol/DF5KzzaBj
 jTMUVgaXwGn4plvJ6mKGz2EouDT6gMw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-EkJVVaraPhisGof1x5wnDQ-1; Tue, 01 Oct 2024 11:15:04 -0400
X-MC-Unique: EkJVVaraPhisGof1x5wnDQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8a84b60255so534019166b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727795703; x=1728400503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ct0DP631aMHKPh1GV9JBtCpwCw8dhuxw3vRy4mMX34U=;
 b=ldAqpH5WO4azXmZyt8lBeiZIzMmJDbh/bNwKl1JauZBXTrn72RufeT4PsWJlx2+Twq
 5Uc67SbBSQ2BHrkyEqQEAZ772wdgAD+Gq36BAQm6qq2N27jmuAB4V0GfT6ANwDItNi88
 Sv9CK+hKX7wgwIuikND7fBaiu5mWpEuCVrSijrFohEIbPYuTxPIaxUr3XPNoQYTawVVG
 NjoW8qhiSafu17VUsku2BNgZbpGR5b7z3A7ctZZHSGC9mLN7b9TWyRbR1mDyDkmzWOFc
 mUjk3orptkG/7keyLvQNnUf5FnmiGMRa1twM8FBSlt4/ohsxAzR9a/rNZIFlDUn19vRR
 8rug==
X-Gm-Message-State: AOJu0YwEFPUrXoc2tkiTu8aTC6UCMQ/gQbQH0v9lf+a58YbaIhrYmiZN
 QxY2TYyBRepuBuRWN1IYEqPPNm2VEJklOfBizs0ERWCNzTE7I/e5nfJeAqHHS+uS2NjaxEX08mj
 zAWOhh7lBGkqrz40qjjkZ5C8t4JW7zhXZn9dUPFXuHojnHuUJ0LxzUXcR83q6QPSrBNoWy57dZc
 uKnr8pUE9HuhJDvl15orvQOqktu+cSwoNi
X-Received: by 2002:a17:907:9444:b0:a8f:f799:e7db with SMTP id
 a640c23a62f3a-a93c49180a3mr1935238866b.16.1727795702715; 
 Tue, 01 Oct 2024 08:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERBLVHpdAJtbOpfeBp8EwUos3Fcp/eVE3nGpGxgHV89fk3GArQzCHma2e46uRpO19NEumRxQ==
X-Received: by 2002:a17:907:9444:b0:a8f:f799:e7db with SMTP id
 a640c23a62f3a-a93c49180a3mr1935234366b.16.1727795702213; 
 Tue, 01 Oct 2024 08:15:02 -0700 (PDT)
Received: from top.fritz.box (p4fdf9fd8.dip0.t-ipconnect.de. [79.223.159.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2775d23sm732438166b.4.2024.10.01.08.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:15:01 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v9 0/2] linux-user: add openat2 support in linux-user
Date: Tue,  1 Oct 2024 17:14:52 +0200
Message-ID: <cover.1727795334.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvogt@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is v9 of the openat2 support in linux-user. Thanks to Laurent for
spotting another missing tswap64() in v8 (and my appologies that I
overlooked this).


Looking forward to your feedback/ideas!

Thanks,
 Michael

v8 -> v9
- use "tswap64()" in strace.c for how.{flags,mode,resolve}

v7 -> v8
- use "tswap64(how.flags)" in do_openat2()
- drop printing "size=" from strace.c

v6 -> v7
- use abi_ulong in guest_size
- use TARGET_ABI_FMT_lu to format guest size in qemu_log_mask()
- drop #ifdef for TARGET_NR_openat2
- fix LTP test by checking for RESOLVE_NO_{MAGIC,SYM}LINKS in
  maybe_do_fake_open()
- add support for openat2 in strace.c
- add copy_struct_from_user definition to qemu.h
- add open_how_v0 to syscall_defs.h

v5 -> v6
- do not use get_errno(fd) in do_guest_openat()
- do not put declarations in the middle of the code
- do not return early in do_openat2() when we get a faked file

v4 -> v5
- drop "*use_returned_fd" from maybe_do_fake_open() and use return value
  -2 to signal to the caller to continue
- keep "pathname" in parameter to do_guest_openat() for a cleaner diff
- fix two missing get_errno(fd)

v3 -> v4:
- fix typos in the commit message

v2 -> v3:
- fix coding style (braches)
- improve argument args/naming in do_openat2()
- merge do_openat2/do_guest_openat2
- do size checks first in do_openat2
- add "copy_struct_from_user" and use in "do_openat2()"
- drop using openat2.h and create "struct open_how_v0"
- log if open_how guest struct is bigger than our supported struct

v1 -> v2:
- do not include <sys/syscall.h>
- drop do_guest_openat2 from qemu.h and make static
- drop "safe" from do_guest_openat2
- ensure maybe_do_fake_open() is correct about when the result should
  be used or not
- Extract do_openat2() helper from do_syscall1()
- Call user_unlock* if a lock call fails
- Fix silly incorrect use of "target_open_how" when "open_how" is required
- Fix coding style comments
- Fix validation of arg4 in openat2
- Fix missing zero initialization of open_how
- Define target_open_how with abi_* types
- Warn about unimplemented size if "size" of openat2 is bigger than
  target_open_how

Michael Vogt (2):
  linux-user: add openat2 support in linux-user
  linux-user: add strace support for openat2

 linux-user/qemu.h         |  9 ++++
 linux-user/strace.c       | 44 +++++++++++++++++
 linux-user/strace.list    |  3 ++
 linux-user/syscall.c      | 99 ++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h | 18 +++++++
 meson.build               |  1 +
 6 files changed, 172 insertions(+), 2 deletions(-)

-- 
2.45.2


