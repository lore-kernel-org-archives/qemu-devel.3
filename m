Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2525ED59F60
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDFc-0003xV-Rk; Fri, 12 Dec 2025 19:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3da88aQoKChgAyF0ACF0CG4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--marcmorcos.bounces.google.com>)
 id 1vUDFa-0003wW-Gr
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:12:42 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3da88aQoKChgAyF0ACF0CG4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--marcmorcos.bounces.google.com>)
 id 1vUDFZ-0006iw-1e
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:12:42 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b630753cc38so2556474a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584758; x=1766189558; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8tL7/RGN/sKACTO1/U808dKR26ztwxbHlqQIK/m5vG0=;
 b=u1bDAvUlFtZpWGyaMX+pcdcWTgu+y4hALGG1mvWKv066pcpbsZ5loIF3NjI1zGkHTH
 aAQ1r9aWoI2s3PyfeEY2OzfpkBRLaFGV1xrgPjw7GiXdPym5DC6LjLRkcV3gjtIRCIC9
 9TxMZnpP9JMAZ0RquwltPc87kaHjJT1pfGtoycL8030DGmSK49Z4oQtUD5Ye01219V49
 rFlJmTX5HnSmPl9OewEzPY1QIUak1XPxUDqhQuiEVxz6dapV8HRk8KykmfePv2q8sQQW
 gm26MJbq2FNqtDQEQV+rz7mfEwRE6TPJFRi1/Fx9mE2leZH757Qk57pK2xuhtbL3xqh3
 e2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584758; x=1766189558;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tL7/RGN/sKACTO1/U808dKR26ztwxbHlqQIK/m5vG0=;
 b=m7eiHhWNb8Lv7FYWCL2e2G6jKgn8LsLl4AatK9cUNHB16vkYQSBqMtLDIXu/WWRjPx
 xEz2QpK/97ZuE1zScBlPQXIiLRJlxLyAF/xQ2VZkZkFnzqBUhmt3o2Cc1eXX0I8OA83J
 ScO4rBmcm5hUk2L6HFqcIIOiLaIt7ps2YXiS/tcglP9e3fYERZcS4sxCQzHAO7kDOSOJ
 w7C5ucsS0QoKOfYzA0tnQxcpgEPp1uN0pP0ytWMwHvJXMG3UKnXaD8v+Q0Qr2jHmxKD3
 YbGDoZYTTGF0zbCsw3VRznPHI0vcv2T3Gs9OhRZp+lXG80Nn7sa9Kak/eGid6zAbcFNs
 dwww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzqGj9P53Mf8fywcsCL5z4Sm4MWOU8+QFh04Pq7XQTufuYL8T6CYc6uN/bewxsAzL5mhzR0fxPcfw9@nongnu.org
X-Gm-Message-State: AOJu0Yyz9dSRQC0E0oi/I/Lqm4eFsA3a6ozQ6OfR1qejn2hkTsKq6jnz
 cf0PebC9ipF5lrQ3XS1pKAnIJ/hUtZzRMruB7sMuCs733UkPkvJnpETDFL1LQ8ESgvLFytTEdE1
 7SQSjaS5dCDFaiqqNxRv4Fw==
X-Google-Smtp-Source: AGHT+IFrNe+ETm2sb/OiT9RJHXK2L3myG/SdAJA19fKdPrT2yYE4RFe/z8pcSr8172xCreN5joLoEVTpj7rOkXUQ
X-Received: from dlkk32.prod.google.com ([2002:a05:7022:60a0:b0:11d:cf7a:5407])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:220f:b0:11b:82b8:40ae with SMTP id
 a92af1059eb24-11f34bc7223mr2176784c88.18.1765584757819; 
 Fri, 12 Dec 2025 16:12:37 -0800 (PST)
Date: Sat, 13 Dec 2025 00:12:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001234.2039232-1-marcmorcos@google.com>
Subject: [PATCH 0/4] Clean up TSAN warnings
From: Marc Morcos <marcmorcos@google.com>
To: maintainer_email_from_script@google.com
Cc: cc_list_from_script@google.com, qemu-devel@nongnu.org, 
 Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3da88aQoKChgAyF0ACF0CG4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--marcmorcos.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

When running several tests with tsan, thread races were detected when reading certain variables. This should allieviate the problem.
Additionally, the apicbase member of APICCommonState has been updated to 64 bit to reflect its 36 bit contents.

Marc Morcos (4):
  apic: Resize APICBASE
  thread-pool: Fix thread race
  qmp: Fix thread race
  apic: Make apicbase accesses atomic to fix data race

 hw/i386/kvm/apic.c              | 12 ++++++++----
 hw/intc/apic_common.c           | 24 ++++++++++++++----------
 include/hw/i386/apic_internal.h |  2 +-
 monitor/monitor.c               | 11 ++++++++++-
 monitor/qmp.c                   |  6 ++++--
 util/thread-pool.c              | 30 ++++++++++++++++--------------
 6 files changed, 53 insertions(+), 32 deletions(-)

-- 
2.52.0.239.gd5f0c6e74e-goog


