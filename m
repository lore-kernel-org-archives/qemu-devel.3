Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684EBCF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 19:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssoyL-0003hf-5T; Mon, 23 Sep 2024 15:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1ssoyH-0003fn-07
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 15:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1ssoyD-0004fm-3I
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 15:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727120615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wliavXaA4V9yE5oMctpD/KUSKvoUnvA4IKL6JxEY1R0=;
 b=RL5XYu6rnhlI3XGv/YQw2W/gRAvvWBRZeSiQ6NYms+v1n2ZDAGzgWL4MZtHoAgl7V9RkAI
 WNebaYwaX9ryrOVteW6hG/5cUMjztT/VVzFH5YuWHrtZFj4YJy3SGsHWR7kSzNRhupArWC
 zgfd+Iwlh3S7wWZRWkrJIrl4FFHxIOk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Eu26RONsM8u_WBKsnEGMjg-1; Mon, 23 Sep 2024 15:43:34 -0400
X-MC-Unique: Eu26RONsM8u_WBKsnEGMjg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2f759001cb1so35656101fa.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 12:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727120612; x=1727725412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wliavXaA4V9yE5oMctpD/KUSKvoUnvA4IKL6JxEY1R0=;
 b=E5vH10ElQsZTGnYGEFR9/UL4Bls/zi6JEmgbzA0zoDmhmwByTA3/I+zqjWe7ovukCQ
 AQ66uLuoOEjVBaHZHruJyH3tH1PmaPzVckh6Qe0fvw2GQXuFqS2bWkfZhh6XeXDVZiza
 ZQn/ca8LYrXhk6ajiJ7QwpjjLR7fBFgveRUlHMGIbG2ESv0wxaeS0AJJbVKW/8KhtjjE
 HLJmF0T/uLkcm4/PztXwMVaui+fcnz5nIOVrotHe+HO6nWWp4Rel4eA81RNvDT7rTqIY
 lzsGYhA99bHPFlfSTdTMpccWbvOzytWuztW6Ki64TWj2O7Z7i7Ym5Z7FVCFBfBaDax0V
 w/Og==
X-Gm-Message-State: AOJu0YzxAaattZXAIcINYS9K0DgSqrZ6Ih1UO0yO4AYJu9Ebabeb1fpv
 Gg55ukjlfKYN9VK9oaDPLttBB6n4tfShmpnQ5FKfMtVK4Kn9F4uKX2wRL+5E/haHyS4ctKbdWZ/
 kI6rmp6WRlatRq4dz0VMoQ09BNZ0HLYH53qLSb/rUHPiNBlRUjKO6CkDqT4D8YK3/Va5Vqa3Z6e
 o/z/ctkEFLkk0jE6TbyDIsmjOAWOfGx5+C
X-Received: by 2002:a05:6512:33ca:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-536ac2e5b7amr7556188e87.16.1727120612036; 
 Mon, 23 Sep 2024 12:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy9j6xGkr6FlYGTY7u4KMvjUo6P2qiCh19pr0w1xWQ8aIP1r36HLvvBhqZi5PZL3ArqOujng==
X-Received: by 2002:a05:6512:33ca:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-536ac2e5b7amr7556156e87.16.1727120611430; 
 Mon, 23 Sep 2024 12:43:31 -0700 (PDT)
Received: from top.fritz.box (p4fd6b76f.dip0.t-ipconnect.de. [79.214.183.111])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df5cfsm1289084366b.146.2024.09.23.12.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 12:43:31 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v7 0/2] linux-user: add openat2 support in linux-user
Date: Mon, 23 Sep 2024 21:37:48 +0200
Message-ID: <cover.1727119903.git.mvogt@redhat.com>
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

This is v7 of the openat2 support in linux-user. Thanks for the
excellent feedback from Richard on v6, really appreciated.

This version addresses the feedback for v6. The fix for the LTP
failure requires to pass the "resolve" flags to maybe_do_fake_open()
and check for RESOLVE_NO_{MAGIC,SYM}LINKS in /proc/self/exe. This is
the only magic link we support currently via the faked files. The
check is not perfect as dirfd is not honored. But if dirfd is used no
fake open will be performed anyway and the host openat2 call will
honor the resolve flags.

I split adding openat2 support to strace.c into a separate commit
but if a single commit is preferred I'm happy to do this of course.
The second commit keeps copy_struct_from_user() in syscall.c, maybe
uaccess.c is a better place, but to move we would also have to do
something about check_zeroed_user() so I decided to keep the diff
small (but happy to change that too if preferred).

In the second commit I also had to move open_how_v0 so that strace.c
can use it. I moved it into syscall_defs.h but it seems not a great
fit, suggestions for a better place welcome (or a different approach,
I could e.g. always rely on openat2.h in strace.c).

The second diff also gives me an error in checkpatch.pl:
 +UNUSED static const struct flags openat2_resolve_flags[] = {
which looks like a false postive to me as all the structs are
formated this way in strace.c (but maybe I'm missing something?).

Looking forward to your feedback/ideas!

Thanks,
 Michael


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
 linux-user/strace.c       | 40 ++++++++++++++++
 linux-user/strace.list    |  3 ++
 linux-user/syscall.c      | 99 ++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h | 18 +++++++
 meson.build               |  1 +
 6 files changed, 168 insertions(+), 2 deletions(-)

-- 
2.45.2


