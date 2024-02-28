Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382E9C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEy8-0001Sa-Am; Wed, 28 Feb 2024 03:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEy4-0001Rc-8l
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEy1-0000Pg-M5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OIDX2c2v9PiLO7gzWFWLlGQmuBZReadMu0m/kxNSeeo=;
 b=Ei8wYH2b1GzS4H/afDt1uCy3I5RR8sbwRBkrsXhIlxbA5VaMxNE6rnzqyC5bP6LNPg2b3r
 srz54z+eaNta77tmqmj0+vY7L2wD01Iym6SBPeR60cg3xwneKPx9Eg8vqgu7NXkuuFnduW
 avUHKwisgzjf2q5Yz4+8Iq/pWle1l8U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-cvRSJbDQNQet8NAqfPAuyQ-1; Wed, 28 Feb 2024 03:07:00 -0500
X-MC-Unique: cvRSJbDQNQet8NAqfPAuyQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-564753be3deso2601162a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107618; x=1709712418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OIDX2c2v9PiLO7gzWFWLlGQmuBZReadMu0m/kxNSeeo=;
 b=BfuexXRB0jPsZa/RIsog9DtHLcluhSBZW/55DO7kribblrpNrkOM3u96oPMpJ/DLQM
 XyQ/C6TmSlj7CPZ4nLoG0NUESLoovMcqbIawPDZnCWHb/2rRT7VL21A0uxgFZTK2Gc8o
 A5Vfd/TBFxMMCbMnRPwkDHPFKQFyzCq6VS7xNkQScKBUWtOcDuyaUL7TPqSkXoFTTJPG
 vUNFVjgxBAOJTDnrYgOAAH/GfkmICyuFYU0azlt/3/6xH/JrPuCghWpzABhFPuqIa6U5
 4UlP1Cn9KgdgUWOdZHodArbArXkOaJ0Oj1HAMlChh9ZcbyI/0TysFdYgUBytlchOupzp
 Jfaw==
X-Gm-Message-State: AOJu0YwBYdRRW5qvOxnIBo1wkp6PymexjKj4Vv5MSbZ01omniHdKlcxj
 UaLd9yrluqPzgKGQ3afP2RqdVHUSDrJVutcA9MlQaCmJhZsl3ClYmMwOfMhE4rmYF/1l+4IxpxD
 0nGbyqy6jatNSzamJDj/e8Yz4jeu0dNLBYITUCWtVTVKW40RqQTKKvvDR25zeYc8Dz7qUpHTK8b
 a4WcmsQ2Ra/ujMT6KFIylizmeZWOHoMHEKkceQ
X-Received: by 2002:aa7:d35a:0:b0:565:e084:a84d with SMTP id
 m26-20020aa7d35a000000b00565e084a84dmr5652833edr.24.1709107618591; 
 Wed, 28 Feb 2024 00:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+HIE/cpgxcoo251U2Xhl0wYNDI8j3gJchCevW3WXb8TEVxcTWuPfCSq1odHh/+/Wp88Xj4w==
X-Received: by 2002:aa7:d35a:0:b0:565:e084:a84d with SMTP id
 m26-20020aa7d35a000000b00565e084a84dmr5652812edr.24.1709107618058; 
 Wed, 28 Feb 2024 00:06:58 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a0564020e0a00b005617a858f21sm1543253edh.93.2024.02.28.00.06.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:06:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] pc, target/i486 changes for 2024-02-27
Date: Wed, 28 Feb 2024 09:06:36 +0100
Message-ID: <20240228080646.261365-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit dd88d696ccecc0f3018568f8e281d3d526041e6f:

  Merge tag 'pull-request-2024-02-23' of https://gitlab.com/thuth/qemu into staging (2024-02-24 16:12:51 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e7028c36f0e4cb8e357b627eabfe6efee5cb4ed9:

  ide, vl: turn -win2k-hack into a property on IDE devices (2024-02-26 10:17:16 +0100)

----------------------------------------------------------------
* target/i386: Fix physical address truncation on 32-bit PAE
* Remove globals for options -no-fd-bootchk and -win2k-hack

----------------------------------------------------------------
Paolo Bonzini (10):
      vl, pc: turn -no-fd-bootchk into a machine property
      target/i386: mask high bits of CR3 in 32-bit mode
      target/i386: check validity of VMCB addresses
      target/i386: introduce function to query MMU indices
      target/i386: use separate MMU indexes for 32-bit accesses
      target/i386: Fix physical address truncation
      target/i386: remove unnecessary/wrong application of the A20 mask
      target/i386: leave the A20 bit set in the final NPT walk
      ide: collapse parameters to ide_init_drive
      ide, vl: turn -win2k-hack into a property on IDE devices

 include/hw/i386/pc.h                 |  2 +-
 include/hw/ide/ide-dev.h             |  2 ++
 include/hw/ide/internal.h            |  6 +----
 include/sysemu/sysemu.h              |  1 -
 target/i386/cpu.h                    | 46 +++++++++++++++++++++++++------
 hw/i386/pc.c                         | 31 +++++++++++++++++----
 hw/ide/core.c                        | 43 ++++++++++++++---------------
 hw/ide/ide-dev.c                     |  6 ++---
 system/globals.c                     |  2 --
 system/vl.c                          |  4 +--
 target/i386/cpu.c                    |  9 ++++---
 target/i386/tcg/sysemu/excp_helper.c | 52 +++++++++++++++++-------------------
 target/i386/tcg/sysemu/misc_helper.c |  3 +++
 target/i386/tcg/sysemu/svm_helper.c  | 27 ++++++++++++++-----
 qemu-options.hx                      |  5 ++--
 15 files changed, 149 insertions(+), 90 deletions(-)
-- 
2.43.2


