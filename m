Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C5AC52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewuQ-0005Qt-Bl; Fri, 16 Aug 2024 09:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuK-000597-MC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuH-0007k0-7k
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so13831155e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723814535; x=1724419335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qDfeY+CsvBUJu7CFKOtFh4EY2RJKFqnGcNsx1NoFx4=;
 b=lLNr/K3QeQ7ARwo1nnHRnMBfEQlxaklE85pxr8pvnjvvy0uZlsI2XHCHNi5rqmc86v
 p4ptX5iUDU8y/GQCngm2GnnwyZmOiPWadrhUVJGaUHHno/luJ/sJ3fUsRjGChozwydLD
 MyN128P2EfL0W0LC8vNr/kJenDTHv9nkjHzKGr5BnyG0B2iXz2oJQVQA8psXcSYwTXj/
 6Z4c0RENxm3JZDf4cRZq/a7SpDECAVjU2O86xi4xguqwTQd0KWt9trH9/5QCOptAGbtl
 dvNx0Y+xp+JlAvC9EJccwazEAdxZ1VVEt5Z9huS7qVMCGP0aFU+I+z6oMehyRbzpDQZr
 cNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723814535; x=1724419335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+qDfeY+CsvBUJu7CFKOtFh4EY2RJKFqnGcNsx1NoFx4=;
 b=Fs9w4JpsAhfSIa7Za3XiRkl3gjuOyRScIrtFqbREsRONZrP6TcYBlOoxXI2uET2/ig
 acM17I7StlfIg97E339aWQR2wjepxPf9l78fPXu3rtVS6yd63wYKDb8EqUkLqlarDqrV
 N7DLyH9puCmimVEQWgm3p2Zms3cslBvPzclI3Uc+6e2e8pVctLdC5DDFhlcz97Z/qOZV
 38HDrvSwCHhJosrDTcmfqvjpK6zKtaGvbN/ruxBjTHPgEAhtbDeeNxQ2QjKz8oBmchiP
 J+LblCfevi3b39KVfTJA7kshQp3wAsK0j+LILJ/qpcTZlJYAL5cRkMJAbj9ZKseuGLct
 z50A==
X-Gm-Message-State: AOJu0YzwZvsPEY3lWPuYlBJG/XDefxLerisb9lKMwBfqv88OB1yxQGLI
 ggOXBRPCAxSF1p8BJ6TMcSQfwJwAOCX/QSvNi+QSDlhK6o5EKlXnqgrQwMNWPu7rtY3UlP3lz1k
 Y
X-Google-Smtp-Source: AGHT+IHD9HdZOmNwrGd38VGkIRMdVdizqRIEkJxVJwu/k/RfR7I6U6FI3bkIzZzQdErliciSB8959g==
X-Received: by 2002:adf:ef4b:0:b0:368:3ee5:e3e1 with SMTP id
 ffacd0b85a97d-37194314e6emr2086023f8f.7.1723814534888; 
 Fri, 16 Aug 2024 06:22:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ab855sm3631948f8f.105.2024.08.16.06.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 06:22:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/7] docs/devel/blkdebug: Convert to rST format
Date: Fri, 16 Aug 2024 14:22:06 +0100
Message-Id: <20240816132212.3602106-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816132212.3602106-1-peter.maydell@linaro.org>
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Convert blkdebug.txt to rST format.  We put it into index-build.rst
because it falls under the "test" part of "QEMU Build and Test
System".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
At least, index-build seemed the most plausible home to me...
---
 MAINTAINERS                |   1 +
 docs/devel/blkdebug.rst    | 177 +++++++++++++++++++++++++++++++++++++
 docs/devel/blkdebug.txt    | 162 ---------------------------------
 docs/devel/index-build.rst |   1 +
 4 files changed, 179 insertions(+), 162 deletions(-)
 create mode 100644 docs/devel/blkdebug.rst
 delete mode 100644 docs/devel/blkdebug.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6d..ca0a5c731f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4015,6 +4015,7 @@ M: Hanna Reitz <hreitz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/blkdebug.c
+F: docs/devel/blkdebug.rst
 
 vpc
 M: Kevin Wolf <kwolf@redhat.com>
diff --git a/docs/devel/blkdebug.rst b/docs/devel/blkdebug.rst
new file mode 100644
index 00000000000..63887c9aa9c
--- /dev/null
+++ b/docs/devel/blkdebug.rst
@@ -0,0 +1,177 @@
+Block I/O error injection using ``blkdebug``
+============================================
+
+..
+   Copyright (C) 2014-2015 Red Hat Inc
+
+   This work is licensed under the terms of the GNU GPL, version 2 or later.  See
+   the COPYING file in the top-level directory.
+
+The ``blkdebug`` block driver is a rule-based error injection engine.  It can be
+used to exercise error code paths in block drivers including ``ENOSPC`` (out of
+space) and ``EIO``.
+
+This document gives an overview of the features available in ``blkdebug``.
+
+Background
+----------
+Block drivers have many error code paths that handle I/O errors.  Image formats
+are especially complex since metadata I/O errors during cluster allocation or
+while updating tables happen halfway through request processing and require
+discipline to keep image files consistent.
+
+Error injection allows test cases to trigger I/O errors at specific points.
+This way, all error paths can be tested to make sure they are correct.
+
+Rules
+-----
+The ``blkdebug`` block driver takes a list of "rules" that tell the error injection
+engine when to fail an I/O request.
+
+Each I/O request is evaluated against the rules.  If a rule matches the request
+then its "action" is executed.
+
+Rules can be placed in a configuration file; the configuration file
+follows the same .ini-like format used by QEMU's ``-readconfig`` option, and
+each section of the file represents a rule.
+
+The following configuration file defines a single rule::
+
+  $ cat blkdebug.conf
+  [inject-error]
+  event = "read_aio"
+  errno = "28"
+
+This rule fails all aio read requests with ``ENOSPC`` (28).  Note that the errno
+value depends on the host.  On Linux, see
+``/usr/include/asm-generic/errno-base.h`` for errno values.
+
+Invoke QEMU as follows::
+
+  $ qemu-system-x86_64
+        -drive if=none,cache=none,file=blkdebug:blkdebug.conf:test.img,id=drive0 \
+        -device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0
+
+Rules support the following attributes:
+
+``event``
+  which type of operation to match (e.g. ``read_aio``, ``write_aio``,
+  ``flush_to_os``, ``flush_to_disk``).  See `Events`_ for
+  information on events.
+
+``state``
+  (optional) the engine must be in this state number in order for this
+  rule to match.  See `State transitions`_ for information
+  on states.
+
+``errno``
+  the numeric errno value to return when a request matches this rule.
+  The errno values depend on the host since the numeric values are not
+  standardized in the POSIX specification.
+
+``sector``
+  (optional) a sector number that the request must overlap in order to
+  match this rule
+
+``once``
+  (optional, default ``off``) only execute this action on the first
+  matching request
+
+``immediately``
+  (optional, default ``off``) return a NULL ``BlockAIOCB``
+  pointer and fail without an errno instead.  This
+  exercises the code path where ``BlockAIOCB`` fails and the
+  caller's ``BlockCompletionFunc`` is not invoked.
+
+Events
+------
+Block drivers provide information about the type of I/O request they are about
+to make so rules can match specific types of requests.  For example, the ``qcow2``
+block driver tells ``blkdebug`` when it accesses the L1 table so rules can match
+only L1 table accesses and not other metadata or guest data requests.
+
+The core events are:
+
+``read_aio``
+  guest data read
+
+``write_aio``
+  guest data write
+
+``flush_to_os``
+  write out unwritten block driver state (e.g. cached metadata)
+
+``flush_to_disk``
+  flush the host block device's disk cache
+
+See ``qapi/block-core.json:BlkdebugEvent`` for the full list of events.
+You may need to grep block driver source code to understand the
+meaning of specific events.
+
+State transitions
+-----------------
+There are cases where more power is needed to match a particular I/O request in
+a longer sequence of requests.  For example::
+
+  write_aio
+  flush_to_disk
+  write_aio
+
+How do we match the 2nd ``write_aio`` but not the first?  This is where state
+transitions come in.
+
+The error injection engine has an integer called the "state" that always starts
+initialized to 1.  The state integer is internal to ``blkdebug`` and cannot be
+observed from outside but rules can interact with it for powerful matching
+behavior.
+
+Rules can be conditional on the current state and they can transition to a new
+state.
+
+When a rule's "state" attribute is non-zero then the current state must equal
+the attribute in order for the rule to match.
+
+For example, to match the 2nd write_aio::
+
+  [set-state]
+  event = "write_aio"
+  state = "1"
+  new_state = "2"
+
+  [inject-error]
+  event = "write_aio"
+  state = "2"
+  errno = "5"
+
+The first ``write_aio`` request matches the ``set-state`` rule and transitions from
+state 1 to state 2.  Once state 2 has been entered, the ``set-state`` rule no
+longer matches since it requires state 1.  But the ``inject-error`` rule now
+matches the next ``write_aio`` request and injects ``EIO`` (5).
+
+State transition rules support the following attributes:
+
+``event``
+  which type of operation to match (e.g. ``read_aio``, ``write_aio``,
+  ``flush_to_os`, ``flush_to_disk``).  See `Events`_ for
+  information on events.
+
+``state``
+  (optional) the engine must be in this state number in order for this
+  rule to match
+
+``new_state``
+  transition to this state number
+
+Suspend and resume
+------------------
+Exercising code paths in block drivers may require specific ordering amongst
+concurrent requests.  The "breakpoint" feature allows requests to be halted on
+a ``blkdebug`` event and resumed later.  This makes it possible to achieve
+deterministic ordering when multiple requests are in flight.
+
+Breakpoints on ``blkdebug`` events are associated with a user-defined ``tag`` string.
+This tag serves as an identifier by which the request can be resumed at a later
+point.
+
+See the ``qemu-io(1)`` ``break``, ``resume``, ``remove_break``, and ``wait_break``
+commands for details.
diff --git a/docs/devel/blkdebug.txt b/docs/devel/blkdebug.txt
deleted file mode 100644
index 0b0c128d356..00000000000
--- a/docs/devel/blkdebug.txt
+++ /dev/null
@@ -1,162 +0,0 @@
-Block I/O error injection using blkdebug
-----------------------------------------
-Copyright (C) 2014-2015 Red Hat Inc
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-the COPYING file in the top-level directory.
-
-The blkdebug block driver is a rule-based error injection engine.  It can be
-used to exercise error code paths in block drivers including ENOSPC (out of
-space) and EIO.
-
-This document gives an overview of the features available in blkdebug.
-
-Background
-----------
-Block drivers have many error code paths that handle I/O errors.  Image formats
-are especially complex since metadata I/O errors during cluster allocation or
-while updating tables happen halfway through request processing and require
-discipline to keep image files consistent.
-
-Error injection allows test cases to trigger I/O errors at specific points.
-This way, all error paths can be tested to make sure they are correct.
-
-Rules
------
-The blkdebug block driver takes a list of "rules" that tell the error injection
-engine when to fail an I/O request.
-
-Each I/O request is evaluated against the rules.  If a rule matches the request
-then its "action" is executed.
-
-Rules can be placed in a configuration file; the configuration file
-follows the same .ini-like format used by QEMU's -readconfig option, and
-each section of the file represents a rule.
-
-The following configuration file defines a single rule:
-
-  $ cat blkdebug.conf
-  [inject-error]
-  event = "read_aio"
-  errno = "28"
-
-This rule fails all aio read requests with ENOSPC (28).  Note that the errno
-value depends on the host.  On Linux, see
-/usr/include/asm-generic/errno-base.h for errno values.
-
-Invoke QEMU as follows:
-
-  $ qemu-system-x86_64
-        -drive if=none,cache=none,file=blkdebug:blkdebug.conf:test.img,id=drive0 \
-        -device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0
-
-Rules support the following attributes:
-
-  event - which type of operation to match (e.g. read_aio, write_aio,
-          flush_to_os, flush_to_disk).  See the "Events" section for
-          information on events.
-
-  state - (optional) the engine must be in this state number in order for this
-          rule to match.  See the "State transitions" section for information
-          on states.
-
-  errno - the numeric errno value to return when a request matches this rule.
-          The errno values depend on the host since the numeric values are not
-          standardized in the POSIX specification.
-
-  sector - (optional) a sector number that the request must overlap in order to
-           match this rule
-
-  once - (optional, default "off") only execute this action on the first
-         matching request
-
-  immediately - (optional, default "off") return a NULL BlockAIOCB
-                pointer and fail without an errno instead.  This
-                exercises the code path where BlockAIOCB fails and the
-                caller's BlockCompletionFunc is not invoked.
-
-Events
-------
-Block drivers provide information about the type of I/O request they are about
-to make so rules can match specific types of requests.  For example, the qcow2
-block driver tells blkdebug when it accesses the L1 table so rules can match
-only L1 table accesses and not other metadata or guest data requests.
-
-The core events are:
-
-  read_aio - guest data read
-
-  write_aio - guest data write
-
-  flush_to_os - write out unwritten block driver state (e.g. cached metadata)
-
-  flush_to_disk - flush the host block device's disk cache
-
-See qapi/block-core.json:BlkdebugEvent for the full list of events.
-You may need to grep block driver source code to understand the
-meaning of specific events.
-
-State transitions
------------------
-There are cases where more power is needed to match a particular I/O request in
-a longer sequence of requests.  For example:
-
-  write_aio
-  flush_to_disk
-  write_aio
-
-How do we match the 2nd write_aio but not the first?  This is where state
-transitions come in.
-
-The error injection engine has an integer called the "state" that always starts
-initialized to 1.  The state integer is internal to blkdebug and cannot be
-observed from outside but rules can interact with it for powerful matching
-behavior.
-
-Rules can be conditional on the current state and they can transition to a new
-state.
-
-When a rule's "state" attribute is non-zero then the current state must equal
-the attribute in order for the rule to match.
-
-For example, to match the 2nd write_aio:
-
-  [set-state]
-  event = "write_aio"
-  state = "1"
-  new_state = "2"
-
-  [inject-error]
-  event = "write_aio"
-  state = "2"
-  errno = "5"
-
-The first write_aio request matches the set-state rule and transitions from
-state 1 to state 2.  Once state 2 has been entered, the set-state rule no
-longer matches since it requires state 1.  But the inject-error rule now
-matches the next write_aio request and injects EIO (5).
-
-State transition rules support the following attributes:
-
-  event - which type of operation to match (e.g. read_aio, write_aio,
-          flush_to_os, flush_to_disk).  See the "Events" section for
-          information on events.
-
-  state - (optional) the engine must be in this state number in order for this
-          rule to match
-
-  new_state - transition to this state number
-
-Suspend and resume
-------------------
-Exercising code paths in block drivers may require specific ordering amongst
-concurrent requests.  The "breakpoint" feature allows requests to be halted on
-a blkdebug event and resumed later.  This makes it possible to achieve
-deterministic ordering when multiple requests are in flight.
-
-Breakpoints on blkdebug events are associated with a user-defined "tag" string.
-This tag serves as an identifier by which the request can be resumed at a later
-point.
-
-See the qemu-io(1) break, resume, remove_break, and wait_break commands for
-details.
diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
index 90b406ca0ed..3a912aefcfa 100644
--- a/docs/devel/index-build.rst
+++ b/docs/devel/index-build.rst
@@ -18,3 +18,4 @@ the basics if you are adding new files and targets to the build.
    qapi-code-gen
    fuzzing
    control-flow-integrity
+   blkdebug
-- 
2.34.1


