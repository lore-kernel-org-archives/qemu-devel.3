Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2661BC54F2E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHlO-0001Ei-1F; Thu, 22 May 2025 22:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlJ-0001EO-Gm
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlE-0007il-EA
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso7577700b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 19:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747965825; x=1748570625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q6IZCxPHOErIy/7d+K2FcIwXEgoynpc1K7JF3CUWKwQ=;
 b=imRSphb6nWIXRKuqVXah7pywWfKZ4CZzWyXeDZHVVg32AdUpUt27k2Q1rjUz3nvTnB
 RFjrllro7xLDGq27sXfB4v+5emcglp+yiFERnpJbxDtlKIQjNon+5MQHAfcrgWpaiFXW
 jLm7dyulnrEYMHCMeQZaE8zd03pIgRcMEA+UGLvQX8TM6px7YqvODgHGyTbZIDRY6Z6r
 zu0B5dGLT5dsEluX82rD5Kh4xCu+5ZrMIs7iN9BzYM8ckdnBu6m78eO06qD6oxnmqQT0
 6EnNXAIQwa2SVY8X7u+YJ0xLBRmlIfHzUjwl9YGZ5RWU1oY/f+FoQNmyxPFQARApo7kW
 cyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747965825; x=1748570625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q6IZCxPHOErIy/7d+K2FcIwXEgoynpc1K7JF3CUWKwQ=;
 b=F+0s9mls8O+OIDWHGiJI/Si1zdhhcx82SC0+fEsr6OxM0zjWeJLKrE6NzTk3DV+4Um
 lg8dKWToChbxS0D2aFUMEBsltL5z/d9HMNEHl6Su8qYSH/WmLzz6H47+T7c95DdKAGJS
 LOn6n0x4+Ppi2NP7d6g7nAV7RvjNCCwZQ3UCMQEBnutkbnFiqSS1ToV7fq9KvlALUdm5
 XEj34MjydCOrb867mhUPE92/JHWCWnHj9/7q9KFtPhnXBu1ZkkYMydI8ByLASUgChuFP
 Xm5kC/MGTrC6JL1k+Bdngfm3sJfI9mnlT5SPLLJqQc7lhknLRqHPBMgDl4SewVbmfUr8
 id2A==
X-Gm-Message-State: AOJu0YzVw1vCSCVrzSF3xCk2IZ7B1gsZl3EKuwTkP4G3YncOeIgghQqK
 5LLbu2S04bfb23BjPov4cD7F1zRDaRhFMW5xggVeOx/1qi1XBD6VVzLpkAwTasimX7I=
X-Gm-Gg: ASbGncuKc6A9Z+w09LX6ZBYHQcp7QAs8bNTyhCjk19VO/DshmTIP4zyTQ1XdoIfufIf
 kmZg6k/6PU5WpPQg9J5JEkPgdpYVaQdzaHF33hcP2EiIL31SYhf76LqB3KTemxst9rtGYn+AvUE
 HnZkSewtv9yCztcL4mpagxQ1LRY83GkwomgqOHCeBMr6NbSBotFs14aLDq5VCDvnTPlRWAL8Vd7
 62Kin15BkarjOjzjyJZ/50TpOcA4ct6VrBS42m8sFLjfBin8YMJn+4RQcwiFXoY8v9m0H75k5Qf
 4CLVGqrc5mVQOy0hT9nCd9I7F4YNOlRIvYZvCCnw9/65JJsE9xfDHhyVqa2uiQ==
X-Google-Smtp-Source: AGHT+IEROyaLLuP567MQ1wGjSNlXMwMHhABV1rMgFs7jAH2E9DYeOheUws7wemkP+d++f8fbGHyWLg==
X-Received: by 2002:a05:6a00:a81:b0:736:5dc6:a14b with SMTP id
 d2e1a72fcca58-742acce23fcmr35061555b3a.13.1747965825419; 
 Thu, 22 May 2025 19:03:45 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a242asm11820818b3a.164.2025.05.22.19.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 19:03:45 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v4 0/9] Add additional plugin API functions to read and write
 memory and registers
Date: Thu, 22 May 2025 19:03:34 -0700
Message-ID: <20250523020344.1341179-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series adds several new API functions focused on enabling use
cases around reading and writing guest memory from QEMU plugins. To support
these new APIs, some utility functionality around retrieving information about
address spaces is added as well.

The new qemu_plugin_write_register utilizes gdb_write_register, which is now
declared in gdbstub.h for this purpose instead of being static.

qemu_plugin_write_memory_vaddr utilizes cpu_memory_rw_debug much the same as
the existing read_memory_vaddr function does.

The read and write_hwaddr functions are the most different. These functions
use address_space_rw, which works well in most cases. There is an important
caveat that for writes, the page being written will be set dirty by the
write operation. This dirty setting requires locking the page range,
which can contend with an already held lock in page_collection_lock
when called in a tb translate callback with a write to the instruction
memory in the tb. The doc comments warn against doing this, and it's unlikely
anyone would want to do this.

I've also added two test plugins: one that implements a simple hypercall
interface that guest code can use to communicate with the plugin in a
structured way with a test to ensure that this hypercall works and writing
virtual memory works. And one that implements a simple patch utility to patch
memory at runtime. The test for the second plugin ensures the patch applies
successfully to instruction memory, and can use both hw and vaddr methods.

I've had a few comments from the last submission that I've addressed, and some
that I haven't for one reason or another:

- Enforce QEMU_PLUGIN_CB_ flags in register read/write operations: done!
- Fix my commit messages and add long messages describing commits: done!
- Un-expose AS internals: done! Functions operate on current vCPU, current AS.
- Clean up use of current_cpu: done!
- Make functions take a vcpu_idx: not done. May revisit but it allows footguns.
  Even for translation, seems best to not do this now. We can easily add _vcpu
  versions of these functions in the future if we change our minds!

Rowan Hart (2):
  plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
    callbacks
  plugins: Remove use of qemu_plugin_read_register where it is not
    permitted

novafacing (7):
  gdbstub: Expose gdb_write_register function to consumers of gdbstub
  plugins: Add register write API
  plugins: Add memory virtual address write API
  plugins: Add memory hardware address read/write API
  plugins: Add patcher plugin and test
  plugins: Add hypercalls plugin and test
  plugins: Update plugin version and add notes

 accel/tcg/plugin-gen.c                        |  27 +
 gdbstub/gdbstub.c                             |   2 +-
 include/exec/gdbstub.h                        |  14 +
 include/qemu/plugin.h                         |  12 +
 include/qemu/qemu-plugin.h                    | 166 +++++-
 plugins/api.c                                 | 135 ++++-
 plugins/core.c                                |  60 +-
 tests/tcg/Makefile.target                     |   2 +
 tests/tcg/plugins/hypercalls.c                | 552 ++++++++++++++++++
 tests/tcg/plugins/insn.c                      |  22 +-
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/plugins/patch.c                     | 302 ++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target      |  36 +-
 tests/tcg/x86_64/system/hypercalls-target.c   |  45 ++
 tests/tcg/x86_64/system/patch-target.c        |  32 +
 .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
 tests/tcg/x86_64/system/validate-patch.py     |  39 ++
 17 files changed, 1438 insertions(+), 50 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


