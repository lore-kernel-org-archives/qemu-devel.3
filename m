Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2BAC27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5LR-0006JO-0R; Tue, 11 Jun 2024 13:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rrh.henry@gmail.com>)
 id 1sH4En-000380-77
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 12:20:45 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rrh.henry@gmail.com>)
 id 1sH4El-0000iT-8I
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 12:20:44 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f60a17e3e7so5166805ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718122841; x=1718727641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gZ+7EoDGk4gA0WDlVe7UmUIrn/MfVyZF8QE9Hbo3BGA=;
 b=iOfnaq2sXJN9Ttd5i9QJyqzfI5QcOaLa3/0pWK/2HONlMKzC0zxEzSj+I73FL/3h9e
 rUUD4fmuTfm7HStGpQMxgDg5YLZl2U6B5yxVtSyaTVfGpDOYI4u7FOCPU87BC79vfHQf
 iHkmnqThGxxDRmiEtYwWh5hb7U4pOSrAne09w2PPUMvpasGMqx2JO/qfrvKe9VneDD7l
 y36LPv+5ABkhusMwgdsHWIyUMkK00MaZczVcGKdlt+bgR+Xrad5Xp0fdu7NeeQ6OZXfF
 zswE4qfoThfhmHySNfuYvFvh26CdlQWajxu+auu8tFf38xjmsGJwrJ9Rih2L1MyZEZZu
 dqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718122841; x=1718727641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gZ+7EoDGk4gA0WDlVe7UmUIrn/MfVyZF8QE9Hbo3BGA=;
 b=b2Ofp+x4A1a+Wajq8a2X276sy9b5Lj2/+fhuqH/MBJKAALHMUTqoJa1/3DagYptkvg
 3noFPKFnXxs8h1mVsejNZrI+PUOqsLHyKEvvO803I+rPjiN0jYeec3G3FGR5h4q+N1Z/
 Mwf1pJGEquRSk16oWoZhisG5F7Q+69RIUQBGEbhSwiAk/ueYEtWHByM+SxpKlOU34TkK
 zmw+UFxIzwpGkxV0kx+NYSmXAwqInK6DA0dqXL5uFhy72wmRmd6B2rXm+gkpjEa/J0Dm
 cVFFz5OkauEmkBdi+JxL8D21cwpfSelKvNpd20kt4+zOthe0Tpg6J4FYb3RV9HRX12GK
 UGUg==
X-Gm-Message-State: AOJu0YwXf95xXOrvngvBUQ4V3HQ5L1kUFDP0i7m5CdJdNhToVVOGMNn/
 mpktSQargMr5f5sCajPIdqKLHIiCCWZamSM/m1zdrgoo7qzRDIXWeubWfA==
X-Google-Smtp-Source: AGHT+IFkDjsv6ZzIA2GSJ+xQNkDubozLN4smal5xBDRqV4wVFRbg0z9AeF19GbXgeNcweJbPUgmZMg==
X-Received: by 2002:a17:903:1c5:b0:1f7:1655:825d with SMTP id
 d9443c01a7336-1f716558526mr63597785ad.5.1718122841150; 
 Tue, 11 Jun 2024 09:20:41 -0700 (PDT)
Received: from ahadg-ubnt-05.lan ([2605:59c8:7c5:ea10:1363:e947:a6b8:de4a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6facdba8esm59426355ad.238.2024.06.11.09.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:20:37 -0700 (PDT)
From: "Robert R. Henry" <rrh.henry@gmail.com>
X-Google-Original-From: "Robert R. Henry" <robhenry@microsoft.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 "Robert R. Henry" <robhenry@microsoft.com>
Subject: [PATCH 0/1] i386/tcg fix for IRET as used in dotnet runtime
Date: Tue, 11 Jun 2024 09:20:20 -0700
Message-Id: <20240611162021.269457-1-robhenry@microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rrh.henry@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Jun 2024 13:31:40 -0400
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

This patch fixes the i386/tcg implementation of the IRET instruction
so that IRET can return from user space to user space, as used by the
dotnet runtime to switch threads.

This fixes https://gitlab.com/qemu-project/qemu/-/issues/249

I debugged this issue 4+ years ago, and wrote this patch then.

At the time, I did not fully understand the nuances of the priority
levels in the TCG emulation of the x86, nor of the x86 itself.
I understand less now!

I do not recall exactly how I was led to the conclusion that an
unhandled page fault in kernel space was due to a bug in the code
executed in the tcg emulator for IRET. Eventually, my approach to
debugging was to modify the source for the dotnet runtime so that
immediately prior to the IRET I executed an x87 fpatan2 instruction,
knowing that no modern program used that instruction, and that there
was a single point in QEMU source code that emulated that, making it a
convenient place to put gdb breakpoints to enable further breakpoints in
the IRET emulation code.

With this change the page faults go away, and that the dotnet program
completes as expected. For the curious,
https://github.com/dotnet/runtime/blob/main/src/coreclr/pal/src/arch/amd64/context2.S#L241
shows how the dotnet runtime uses iret.

I have booted BSD, solaris and macosX with this change, and await
results for booting Windows from the Windows kernel team.

I have not tested this with other modern JITers, such as Java,
v8, or HHVM.

Robert R. Henry (1):
  i386/tcg: Allow IRET from user mode to user mode for dotnet runtime

 target/i386/tcg/seg_helper.c | 78 ++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 31 deletions(-)

-- 
2.34.1


