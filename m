Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C50CF58F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srZrF-0003Ca-Nv; Fri, 20 Sep 2024 05:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1srZrA-0003BN-Jn
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1srZr7-0005k6-VM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726824191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n2thAEmqjrP7m90I5n3ZJalFoh5gQspTvsKDG+XgxZA=;
 b=YvCjDljQwne4HfgfZoKcQrbPdic0O/45EiBECwhTy2wmJp4I1N082+axdutJTs+e2kekjY
 B65mI3gTxJLDuUvTAjf8y46dFymtxpjEg+3GMvdoB8KHwIMe/qJtrPfpHnKWdIKEEAEfht
 UzVvzDWo3MPxvY3dA42Y6ZRDJ9HdcnE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-u7VEhqSCNkuTeGjVSFDf0A-1; Fri, 20 Sep 2024 05:23:10 -0400
X-MC-Unique: u7VEhqSCNkuTeGjVSFDf0A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c2483adeeaso3200067a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 02:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726824188; x=1727428988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n2thAEmqjrP7m90I5n3ZJalFoh5gQspTvsKDG+XgxZA=;
 b=MRNYJf4ouxIbsTwjoJQBPaVbs44avZU0m4S9gZXwfgpNOS9fpZh03qUHMO92T/F+Z6
 zdsh8EHzQwB19dW/9kFA6tBAr7gMm+fxeeuuZlLp9uxP5DTlzraIL3Fvjq/S4YWCB9RJ
 Y3h/CSKYgLcDrCbLbDURC4QfXkjiKOZLhMg1sp5BSt3B/f1xXl693uXqUoDPlBHPu0xg
 8tSDgDo3TKwvQTw9q48ryxPa+6jSek6ZH3wDV+Zf/mY8EQGdT1lvdV5pyzF92U1K6bjZ
 EurfVnVZuMuRXIcDgE9fT30j7UapXTUswZ0EQdjpQ5isT8Bdm8r3WRxeu9YbRl5NqSs2
 Cxzg==
X-Gm-Message-State: AOJu0YyS18wVvX7erBisztxxn7eNPhweJV2lKxOXHcXFQwbjbRNcQdiA
 TvordVqXzCEuO1uxT7kr5Ak8xj8dcUgLt3FawvahZl8vbGwqF97fgwVKDs5ASFbZWhW/Wn/B/1D
 LbXK4l4ckWZF19iAFv7HPV8OoaEmXz9sUgIJp+8+OM2a3KhHyPQR0y7zYSpu2RIfN6vFEmkAd3G
 bIUcZQbw6GAXFGJa05rg8XvxtHxRmtJ1snOLw=
X-Received: by 2002:a05:6402:4007:b0:5be:f5b0:fc38 with SMTP id
 4fb4d7f45d1cf-5c4592208f2mr7243509a12.10.1726824187971; 
 Fri, 20 Sep 2024 02:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgqPS5yYTQsbFq9N5ak7XnMHEX+qQQhSNhwuABeo/qFDxD5oNLMIl0zsbymWsuVJgngQmKjQ==
X-Received: by 2002:a05:6402:4007:b0:5be:f5b0:fc38 with SMTP id
 4fb4d7f45d1cf-5c4592208f2mr7243482a12.10.1726824187489; 
 Fri, 20 Sep 2024 02:23:07 -0700 (PDT)
Received: from top.fritz.box (p4fd6b76f.dip0.t-ipconnect.de. [79.214.183.111])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb5fcf5sm6978771a12.57.2024.09.20.02.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 02:23:07 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v6 0/1] linux-user: add openat2 support in linux-user
Date: Fri, 20 Sep 2024 11:22:19 +0200
Message-ID: <cover.1726817664.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvogt@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

This is v6 of the openat2 support in linux-user. Thanks agan for the
excellent feedback from Laurent Vivier on v5.

This version is very close to v5 and only fixes the small details
that I overlooked in my previous patch (sorry for that). This time
I hopefully also fixed my git send email setup.

Thanks again,
 Michael

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


Michael Vogt (1):
  linux-user: add openat2 support in linux-user

 linux-user/syscall.c      | 108 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |   7 +++
 2 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.45.2


