Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4487AC3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 08:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSuX1-0008VU-UY; Sun, 14 Jul 2024 04:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sSuWz-0008SA-H0; Sun, 14 Jul 2024 04:24:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sSuWx-0002xS-IY; Sun, 14 Jul 2024 04:24:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70af22a9c19so2579230b3a.2; 
 Sun, 14 Jul 2024 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720945464; x=1721550264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0MbEPIDs+GV0MWbUmAvR7h5WHSBahAxROZWzN9rqvc=;
 b=Ea6TigV349Zyac6ulXM6N0xSqlbCWow6gnB9izylSdaNh4ulsWE2XNtcOxsn7zbk7I
 1E4/F0aFxvWiAFYULwB4VNDqX2fFWgYkcBCHWv3+MdrR1NHIyfxQtzYm3pG4eFqAZRe8
 q398bv/c5ewugNU6y21l2nMOkgcIvjA/zvrrVltLUWg7j/FsRrQIG1O3ZTV6r+CwxKJ3
 eeUhTpW/AlZF5NjzYFg/L+vBlgdPPAw5f+xXdYmzkyY96gR3XrumSVIaXIUt0i1MKHcB
 EhoI6XODdy59ieOCh5e5ZsK0E81VExj1QnMApyqW/q+ErdxzIny2QauYA2AohV+8NHLl
 Z2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720945464; x=1721550264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0MbEPIDs+GV0MWbUmAvR7h5WHSBahAxROZWzN9rqvc=;
 b=FB8YQP4C6WcLOkwi1soECopNdg2DIBfGTugY5i9Q0jiEjJFMZrc9uPs2dPfuLnOf5d
 EJVy7vN9dTRa7nbI05OVAEs1+NFSt9drXSzzI8CFFCdXMCxzMHzApB0EfGjucyWrocpO
 I5+fnYUOJSBhsLF9aOSc2JML4MiEJhUxsaV1db6e2YjZktb/zR9sA/qJqN7osK8waJkW
 Zjg9pKhb7Kd2DEwYmoj3GhSFfhkrXZj5N1nSa3kcHfT1O5trkkY/EmyVcHjWbCPiUkNj
 quwo3kWRzUmaPGvrVepbLiz5WLCQjA9ywt+2RAtAkLQQAAFkmTKSR87+tONUSdUCCfKX
 g/3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhG0KKh2HBPn428Hm1HsuywClHmNwpQkyDZ2zXRs9N4QsPQEi7aEBKCBtZvtBNV3uC4am5Wz/zUxanucoIkgDp9/5i/dY=
X-Gm-Message-State: AOJu0YwoFxyr6Ann6fowOcN/CH5F3DUHge/wiKwbGfE+lMzbmIlzfZlf
 vKKUovogtlHgn7iMylu1Knm6aITF7AxD890nrW7guSvcNfQCpAZY9ohfELPv
X-Google-Smtp-Source: AGHT+IHcCPjQUy3m4z7eV0L8OFdf2+yMeazLAmbTb4iwAI1+nm/yqnOkFiPK10TxeBGILjWuGnt5vw==
X-Received: by 2002:a05:6a00:3d08:b0:706:8e4:56a1 with SMTP id
 d2e1a72fcca58-70b4356c646mr19885447b3a.18.1720945464053; 
 Sun, 14 Jul 2024 01:24:24 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca7886sm2301390b3a.170.2024.07.14.01.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 01:24:23 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, thuth@redhat.com
Subject: [PULL v2 0/1] ufs queue
Date: Sun, 14 Jul 2024 17:24:15 +0900
Message-Id: <cover.1720944812.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x430.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit 37fbfda8f4145ba1700f63f0cb7be4c108d545de:

  Merge tag 'edgar/xen-queue-2024-07-12.for-upstream' of https://gitlab.com/edgar.iglesias/qemu into staging (2024-07-12 09:53:22 -0700)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240714

for you to fetch changes up to 50475f1511964775ff73c2b07239c3ff571f75cd:

  hw/ufs: Fix mcq register range check logic (2024-07-14 17:11:21 +0900)

----------------------------------------------------------------
hw/ufs:
 - Fix invalid address access in mcq register check

I didn't cc qemu-stable@, as 5c079578d2e4 ("hw/ufs: Add support MCQ of
UFSHCI 4.0") is not yet included in any release tag. If I'm wrong,
please let me know. Thanks.

----------------------------------------------------------------
Jeuk Kim (1):
      hw/ufs: Fix mcq register range check logic

 hw/ufs/ufs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

