Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22686E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTG4-0007cz-2x; Fri, 06 Dec 2024 03:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJTG0-0007Zd-Ln
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:00:13 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJTFx-0005mO-81
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:00:10 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21619108a6bso1979705ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733472006; x=1734076806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SqlPZW822Rhjs88FPMPj43/ynkf0cnOKLf+wTsO/7N0=;
 b=Z9SzZJhRWCzL4pLXm1lY8haK7SX77tLGSUil6doNkA0Q6mtB17FLlGaFoaKKk7qTaX
 oVj//XsGdB5PNpGQctQApG6GeEeUKr0P7xLiZicN0A1QxDP8/a3t8e4tScoVn/yIco8b
 beLLaexpPhIsmMsNyKeIrrPm03+zzp2CQDForo7ZmD92g29SkjqGTeb/K+foI7L6RwOk
 WDbKL4P+XuxvyUSsqqWE/a4H8cDvg/FQtFDVKF6YKksfPghd0qYntwxpaq7OkM1q7gu1
 ZFD3z667za3f0HKJYhuiAmpp7qEE+yRm+N7VCk/AZJeDVwBKNldARep3g2jMK2ijcEDe
 aprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733472006; x=1734076806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SqlPZW822Rhjs88FPMPj43/ynkf0cnOKLf+wTsO/7N0=;
 b=D6ufY/FBI9983ani+cTnMStLm0AvxNH+nf7sR9VVmYRvi8MescMhXLS7OyW9sit/ox
 FB8VSdUiniHR5jZPpK8REUn98fuxfGLR3GSwZDIAL/GoZtJVxRWHbEFZvRSqhkuGA7OS
 5ZjM0z5n8cnJGv4m6wuvi6NWG4x6vikFjRD/3GYOChUCo+bZ6OOsyxerXtrCJ4FfYQ/i
 /wX/Dwwglqp/nYw0TO8vEGDbME6AIIc9ambn3wZ5wXvLAQqiwWRUFi6Le7LVWpG0rSwf
 52fVIPS3ZCtQFQBQG+yD00Et7gLQbasCVglbXr1KZADa7au2xJAzaYqiyI4NuBF0qWGt
 05RQ==
X-Gm-Message-State: AOJu0YwndzWxZgUXo04yuSyyI7bwRcky0l8jTYSZjhB7+O6RlZpVdVzp
 5PrKGHNC6jqTuiaFyUfa1juL+tm8gAkUcobw8dtqsf0TBDpFIirQIU4mcuSzEyM=
X-Gm-Gg: ASbGnctqWk7X2piy3f3CC7L9snXvyqPcTSfhI2CoqxTptVO2+VWEdDyN9+Djdat+0XZ
 U9IdtScQdWP0htQbsaLGLvV8TlB3sV/9Q/ROrLyne4durAeLCcZnqsqaZl2R5kNM05NEIzjfG7e
 Cn2+FTg0Dq1QcoxEZHKKCjH7Lfg851+Gx01yPumnQlgoZCPcva0ulw4HeSAtMRfWS5I45rVCVJC
 XEu1Z5L9ez10cP17NKzv/sELjaPKrxE+ihsv2sPlTi2kEE=
X-Google-Smtp-Source: AGHT+IGIyv3d9UhN7sOtBDdzBqRIiFWN6iqDVFKs0iPlYn/05HEbVsx2IVNTgXljuS7d4qsupX0ozQ==
X-Received: by 2002:a17:902:c40d:b0:215:9ea1:e95c with SMTP id
 d9443c01a7336-21614d32c3emr34635175ad.13.1733472006458; 
 Fri, 06 Dec 2024 00:00:06 -0800 (PST)
Received: from chaos.lan ([50.39.253.148]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e5f601sm23527525ad.73.2024.12.06.00.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 00:00:05 -0800 (PST)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 0/2] Add additional plugin API functions to read and write
 memory and registers
Date: Fri,  6 Dec 2024 00:00:02 -0800
Message-ID: <20241206080005.775275-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x629.google.com
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

This patch set follows a previous patch which added the
qemu_plugin_read_memory_vaddr function and adds a set of similar
functions to read and write registers, virtual memory, and
physical memory.

The use case I have in mind is for use of QEMU for program analysis and
testing. For example, a fuzzer which uses QEMU for emulation might wish to
inject test data into a program at runtime using qemu_plugin_write_memory_vaddr
(and likewise if testing an operating system or bare metal application using
qemu_plugin_write_memory_hwaddr). It may also wish to read the initial contents
of memory using qemu_plugin_read_memory_vaddr/hwaddr.

Similarly, a testing framework may wish to fake register values, perhaps to
simulate a device failure, perhaps by using qemu_plugin_write_register to set a
register value to an error code.

I think all this functionality works together to make QEMU
plugins more powerful and versatile, hopefully removing barriers
to using upstream QEMU for these tasks which have historically
required maintaining a QEMU fork downstream (like QEMUAFL
https://github.com/AFLplusplus/qemuafl), which is tedious, error
prone, and results in users missing out on enhancements to QEMU.

novafacing (2):
  Expose gdb_write_register function to consumers of gdbstub
  Add plugin API functions for register R/W, hwaddr R/W, vaddr W

 gdbstub/gdbstub.c          |   2 +-
 include/exec/gdbstub.h     |  14 +++++
 include/qemu/qemu-plugin.h | 116 +++++++++++++++++++++++++++++++++----
 plugins/api.c              |  66 ++++++++++++++++++++-
 4 files changed, 183 insertions(+), 15 deletions(-)

-- 
2.46.1


