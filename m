Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B785EC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29a-0001Ss-Is; Fri, 02 Aug 2024 19:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29X-0001Rf-Fx
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:43 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29V-00043n-IK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:43 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81fbbd4775bso195777739f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643059; x=1723247859;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ByXkIDvzPwN/HxzwjWWN1pKW4FF6y3gTcldsYSEjUOc=;
 b=apDJ9rFMi85mR2eGh2K+1ixd8m+lP+KWlsU/Uzatn1nvixFANusH/l/V4NQ+4b/wEE
 jUtV8xHFQh4+x7f92iyNmf0z0TXmD5obyEvzVp19W7DVEPpC3zcNze4NXVHoFqNMi1Yt
 k9dtsF7XMmldhKixtA/BtJfcAQuX2qjvAXQqIVGpq/zRL1e5agXm/Jce3sUaYQTtxv/O
 +sWC4BRXLnNaOy3Gsfzpvw51uyz5RLIvHoMhxbFhzKg9smoF1RaL4t13DXGQjLaKh3mF
 0zlMtH/lZGeHGGfAec+/wIGLwjIL4g8YlOPCfLA0UfBENKGQMsXtIyEEPE+StqXHPMW/
 t+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643059; x=1723247859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ByXkIDvzPwN/HxzwjWWN1pKW4FF6y3gTcldsYSEjUOc=;
 b=FgYCyrMF58AcXY2lsw51u6aPps2nTYtcsxV9x7VtTQ0ILkBPnJGwYC4vBugsNRM18d
 ruw2Bi0cGZnlo+K39/bSx3t/4Vyw+RioEnXuLZEmc0AGjwYxVIFJ9K/R4EDoGcO8Yp8/
 Fwtx05IFwiAFynXaUA4JROeJSO47MnQ106wT8MWwz8wWTJ6T2xa68PLc4gQDVRLSLfSq
 AbVX4XNYr/udbiShPV2tJRZaOM9lL/rN2mjMl5hOdnCJCDbGOrN+BkrtezshQXzcpHLl
 iF8wXWZ3amJoTQxQEbhyoU6XOwoi7fiU90mvsgll+5a/0goFI1RU/3V2jGflpVdjBdX8
 JXdQ==
X-Gm-Message-State: AOJu0YzxKWWJyt8GlU+R0hdGNAAkUxbGTfgrtZ0xijDt1e48XG4VyfIn
 D/q/E9twIXCb5rOmO5DXsZdxYWXJnCzVBMxklZpvHjnzp/Iw41kKQQRNfXZPXS3JwxpbliTjY5f
 5mos=
X-Google-Smtp-Source: AGHT+IG/qn1TioKdMaMpnJrjuNmbaJEBqk3ULuHUaOEK9UMnAw3d2IXp8uhyYNYw64AfmCvNxILS3Q==
X-Received: by 2002:a05:6602:1593:b0:81f:8f5d:6e19 with SMTP id
 ca18e2360f4ac-81fd435071dmr624785839f.2.1722643058838; 
 Fri, 02 Aug 2024 16:57:38 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 00/17] For 9.2: A bunch of cleanups and work towards variable
 pagesize support
Date: Fri,  2 Aug 2024 17:56:00 -0600
Message-ID: <20240802235617.7971-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series has a number of changes to reduce diffs between blitz and
qemu-project. These are minor and self-contined.

The second half of these changes are the next round of changes in the quest to
support variable page sizes. These are building towards the final set of changes
that will dynamically allocate arrays rather than have them be hard-coded in a

Stacey Son (1):
  bsd-user: Implement cpu_copy()

Warner Losh (16):
  bsd-user: Delete TaskState next member
  bsd-user: Make init_task_state global
  bsd-user: Make cpu_model and cpu_type file scope
  bsd-user: Eliminate unused regs arg in load_elf_binary
  bsd-user: Remove load_flt_binary prototype
  bsd-user: Remove deprecated -p argument
  bsd-user: Eliminate unused qemu_uname_release
  bsd-user: target_msync unused, remove it
  bsd-user: Pass image name down the stack
  bsd-user: Replace set_brk and padzero with zerobss from linux-user
  bsd-user: Use guest_range_valid_untagged to validate range
  bsd-user: target_mprotect: rename prot to target_prot
  bsd-user: target_mmap*: change prot to target_prot
  bsd-user: target_mprotect: use helper host_page_size local
  bsd-user: Define validate_prot_to_pageflags and use in mprotect
  bsd-user: copy linux-user target_mprotect impl

 bsd-user/bsdload.c |   2 +-
 bsd-user/elfload.c | 132 +++++++++++++------------
 bsd-user/main.c    |  48 +++++++---
 bsd-user/mmap.c    | 234 +++++++++++++++++++++++++++------------------
 bsd-user/qemu.h    |   9 +-
 5 files changed, 247 insertions(+), 178 deletions(-)

-- 
2.45.1


