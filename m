Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD947CA1005
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 15:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk3jS-00071s-P0; Fri, 30 Aug 2024 11:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sk3jQ-00071J-Bo
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:40:13 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sk3jO-0000TM-Ii
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:40:12 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a86883231b4so219779366b.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725032408; x=1725637208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bchXpF7ADrqnfQ/TYs7pddO/ExF0L+VyIsDGXZRYdaQ=;
 b=eYNJEilsrSKEvdJnh/XksU8uLU10WZydNs4HCZ205/MzhEcg4XLFavruOwYMqHJRDH
 TQITAb+ljH7EOR0Dw5eCZzOqodKzl93clQaRNDTiTpkoeR5HHsTqAu5dv/dLxjry8eyI
 lxOVdukkTuuWutHsPDaZWA1D9rlR9XnJC0Ed3nu0msvQz3Warc4/sDbtaxVPH27OPggj
 Ka/ng0KLvDh9ge9pRNlpkKU2u83UHtqsl5CiqRYHsbe5S04T83o25FkwXW2FkqoBfYLm
 LsCrAAfDW3nMcErdQnwHPyrSGdP8Q4gYSn4BWQx+AVIo5czLp+p4TLahIsc7QIG8XM1p
 z1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725032408; x=1725637208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bchXpF7ADrqnfQ/TYs7pddO/ExF0L+VyIsDGXZRYdaQ=;
 b=tjuCStZyFJxDDgjzF5xoJaWA/y/nOfMy7rO5TIdPQ2m4rGbzr6LpsieQ7H+ouGGLyf
 dpcAnvOwXfmIFCpzYGKmcaqIC8oykxnALM6cUjUqHvk3wyxc3BKFvjOhFgK7q3no0lCy
 U3Px56+LCPcKRzGcPbl1t6xSMRUi9sRBqgikEDKs1SBwS/zbKt+x9BNzUjzzeBey5H1S
 HJhJVkekrkIQbjCF4/oYE17KedfaysA0AW5MM4WJ2LXEcXHPTRQ8jP+OlqYq/seHte4P
 mKZXde+aQzpJ0kKmoKr1aMwq5styZ1m1moAfYgfxVqTXU6RR0PuYqUOOOnTnB6F0MZ+f
 TyMA==
X-Gm-Message-State: AOJu0YwAb3xy1/P+P94vi110M2ungfrAPXEDJ7/rQ2NhmrxqD7X4y9a2
 RTFg6J3UobTxE+GLC9IhovK3pwL6jERaH763RkvTX+jFPoiQvIo+Hc8h3D2R
X-Google-Smtp-Source: AGHT+IECEr0wZYyg4aIWX1p7jhcL+BWy1+gSJ+gGtWbpaww7ZCt3IXj0Iybx64LNpOzRSJeNTtsN1w==
X-Received: by 2002:a17:906:478a:b0:a7a:9144:e242 with SMTP id
 a640c23a62f3a-a897f83b359mr514932766b.27.1725032407397; 
 Fri, 30 Aug 2024 08:40:07 -0700 (PDT)
Received: from top.fritz.box (p4fd6b0d7.dip0.t-ipconnect.de. [79.214.176.215])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89891964d8sm227525766b.129.2024.08.30.08.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:40:06 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <michael.vogt@gmail.com>
Subject: [PATCH v3 0/1] linux-user: add openat2 support in linux-user
Date: Fri, 30 Aug 2024 17:39:43 +0200
Message-ID: <20240830153943.5337-2-mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=michael.vogt@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michael Vogt <michael.vogt@gmail.com>

Hi,

This is v3 of the openat2 support in linux-user. Thanks again for the
excellent second round of feedback from Richard Henderson. 

This version tries to be closer to the kernels behavior, i.e. now
do_openat2() uses a new copy_struct_from_user() helper that is very
similar to the kernels. This lead me to also drop incuding openat2.h
(as was originally suggested in the v1 review). It now contains it as
a copy named `struct open_how_ver0` and with that we can LOG_UNIMP if
the struct ever grows and qemu-user needs updating.

To answer the question why "maybe_do_fake_open()" uses a
"use_returned_fd" bool instead of just returning "-1": I wanted to be
as close as possible to the previous behavior and maybe_fake_open()
could in theory return "-1" for failures in memfd_create() or
mkstemp() or fake_open->fill(). In those cases the old code in
do_guest_openat() failed and returned the error but the new code would
just see a -1 and continue trying to open a special file that should
have been faked. Maybe I did overthink this as it's very
corner-case-y. Advise is welcome here, happy to change back or
simplify in other ways.

Thanks again,
 Michael

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



Michael Vogt (1):
  linux-user: add openat2 support in linux-user

 linux-user/syscall.c      | 116 ++++++++++++++++++++++++++++++++++++--
 linux-user/syscall_defs.h |   7 +++
 2 files changed, 119 insertions(+), 4 deletions(-)

-- 
2.45.2


