Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FEFC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVUOF-0003iP-92; Thu, 01 Feb 2024 05:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVUOB-0003gT-9h
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:33:47 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVUO9-0004pQ-IT
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:33:47 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3637b935e80so2470595ab.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706783622; x=1707388422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tjA8ZQfMxp11FVESjv9XjE+0wnETixglk1RF3My/pgU=;
 b=dnBnbP3sN4MOqo81KJBtonD5YqrH2huQT/KzxZ3FF7nwEmOFIugoig8De172MPNqOk
 GSF8hfa70IOeHCCyNN+qeRZMXibfH3Tu/cAa+DcmMAC56lUjm7y/52/G3iyX733xUE3S
 EIeWp2rWjtGzbkp02+zfDFjYEhrWuBOw9TVZMbkMPypAjUIJvARngJEvJKDuU4y9Mksn
 WsNc2n9fVRRDKVbsKiLlzTWSzbxjntrMAH+e+vfHW4HrGonoPVuwT/wZwUvSwczZzJ7r
 haIWFkRNi3+v0kEFUoRrt9rBgaM5KmkRv+rTKVvSAwb/UHjOagdfDlG2eFjGW2JRStfZ
 ufWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706783622; x=1707388422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tjA8ZQfMxp11FVESjv9XjE+0wnETixglk1RF3My/pgU=;
 b=UjkbsKOmCJsaCz1cAWVBht3t7j/sy2bKv8Ka0/e/5mDKuNJS4llOo9n/q2BZXsut1u
 8c4WTqz8OPgjt6Ch6ku62JwcMLFOw/pfDg5YPTMOGLn6+/isc6NoYEF7ruPdX7Dz8S0v
 4G6AuwpsutZGeu59CYmdn0LbY1RKJtKcrV5UsGv+8qf4J6zDb7tYs6u5cMw3+s1PXdcT
 NHK+H7m6H9m4kLOlrqlOnH9bsYrwGZNd6cfqqzcp9U9hrXaX6zys35RIPHP6SLindvEb
 rl1r6LoPU2qtTLMrsbpYGTdC6oxQLVkCbd5tQJJXoDwBKcanUNQerJrwjhdbFysrRbzR
 nqmg==
X-Gm-Message-State: AOJu0YxXGvghUFaL0Z3VcJqFmwv+2ixravNeqZMMzQlycAAtWvGccdcX
 ZYFg7zvZksSoN3dgld/K/9xUqY8gCcfRDwv+lNY0OEX8GFJCt8qhicU5nghV8D8=
X-Google-Smtp-Source: AGHT+IFMMekxus4fZbOrFVRB5YakyLEetqHRvgQMsY22Ogc14qPwuZfFtRzIB8XSNaB8iDxPzwpDmw==
X-Received: by 2002:a05:6e02:1d85:b0:363:7f81:6bda with SMTP id
 h5-20020a056e021d8500b003637f816bdamr2753109ila.15.1706783622074; 
 Thu, 01 Feb 2024 02:33:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUozol+x/q72cuMny+9KkU1DVmwXUflZ7uD6QhvJY4mOlNe+ELwHK/q1Ua7iIZe9xoE/hAADxNQe7MiBL/CQraSMHzrmvutrrtWXMhCZm4gDuIj7VfiqS1uW8/qKxXSfyxuoaVHxPFU+oH66dhJcEEYQy0QUIlGLYx2NO4QaF+1Qm2QvrQYVJ+IJHjTlDKe/j+0fe0Vf929AEC07uGhkQRxJ75C9dmOwd6MPr8FpkzV0xTIb3AdWMm3QlJiGH9p+j5UGC9O2+5rIRn6q5uKLqAbjgxfB+gHE7rGf6ZH
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a92c003000000b00361b6a1e6aasm3152089ild.87.2024.02.01.02.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 02:33:41 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/3] Hexagon (target/hexagon) Enable more short-circuit
 packets
Date: Thu,  1 Feb 2024 03:33:37 -0700
Message-Id: <20240201103340.119081-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12e.google.com
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

This patch series improves the set of packets that can short-circuit
the commit packet logic and write the results directly during the
execution of each instruction in the packet.

The key observation is that checking for overlap between register reads
and writes is different from read-after-write.  For example, this packet
    { R0 = add(R0,R1); R6 = add(R6,R7) }
has an overlap between the reads and writes without doing a read after a
write.  Therefore, it is safe to write directly into the destination
registers during instruction execution.

Another example is a .new register read.  These can read from either the
destination register or a temporary location.

HVX instructions with generated helpers require special handling.
The semantics of the helpers are pass-by-reference, so we still need the
overlap check for these.

***** Changes in v2 *****
Conform to object oriented generators patch
https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg01211.html


Taylor Simpson (3):
  Hexagon (target/hexagon) Analyze reads before writes
  Hexagon (target/hexagon) Enable more short-circuit packets (scalar
    core)
  Hexagon (target/hexagon) Enable more short-circuit packets (HVX)

 target/hexagon/translate.h          | 119 +++++++++++++++++++++++-----
 target/hexagon/translate.c          |  77 ++----------------
 target/hexagon/README               |   9 ++-
 target/hexagon/gen_analyze_funcs.py |  55 ++++++++-----
 target/hexagon/hex_common.py        |  98 +++++++++++++----------
 5 files changed, 200 insertions(+), 158 deletions(-)

-- 
2.34.1


