Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C8C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk74H-0000T4-FY; Tue, 12 Mar 2024 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk740-0000LB-Hl
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk73w-0001KU-3M
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:41:24 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dd84ecfc47so21160545ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268878; x=1710873678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jy7vZjUesFYPne4m15yVNJp4UJvcz2pR+Pm+Kx/ZwJw=;
 b=gXNXxhCC6evF+e/FeF4GrLFxa3eN74i5yg+xoTGHP/0yl5juwLH6UW7E7R7EHWCgfq
 cgVDbkgV68RLyYyqMFCQqU3DsGS6penqAtk6bNdHHeEhPMSVnMNEbNZwKioPFmzKeIjX
 8wHBWRG9xr4flv/cvUmSEcWQa0L9Bl/qxcFaaZIfF4bbJHKaXz/qFrFnNgPyg2ODCWgd
 aEK2au7D2Xhol0X/UiYCBwhe2VH1I9ChKu16RJxSvaki8HTBW5s19PTHOOzO1pzCdkUn
 3U1UWa0NjWbCRgzcHMY9YvNeNFXR0rr3zPb+7uRCuIXazD4Y/Z1xJHXM/NYvOMdcQ/MK
 MfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268878; x=1710873678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jy7vZjUesFYPne4m15yVNJp4UJvcz2pR+Pm+Kx/ZwJw=;
 b=EXWB1h8o/hr+HV36YdtEWYZs40reequc57gJUpH5nyn+7NiMIphRubvROxTxECr2wn
 iq6Ph0pVA+PhCaDOEkatXx448sj3gpsto5CfmkBLIztE+n7D620ewmrZhqkBeyBwWFbC
 QLykv4+ce35pNbBcbU9E2RMAEuyw6l8GsBtWBiZbNEhrYK3xrpIZfDt8Ig+gWzLDEUN/
 IhDhXMmORcJp42ub/buBJZVp+HgF7ZJWKdgfPJuypCpbm+/Opr6KTi2ZZxXq1lVwzTcu
 J+9dDkuuxpJI5/ojtEbAqMW34yuiQ2M/qjkVEGvc4JZwYrtOaXj5HGaL2OhUghfe5J6p
 Q/9w==
X-Gm-Message-State: AOJu0YxtCxfHePil74d9EyeZ+NrncUi+IfVk2Iw+hKmCDJb8Yx5E0vsG
 qw/I+CurwNX3A8o5K5/6dh97lxXebb25ioohHeKgH+fit029EBdCBUjnrB+bGibxsiIfZQ4KlOA
 J
X-Google-Smtp-Source: AGHT+IEMyUNcBb7boRHfS5/EIFmVg8GK5kV1HthQIW2qoSK6gm4eVk7wQ0q03rUjhMMSQ5teDTxadQ==
X-Received: by 2002:a17:902:aa88:b0:1dc:d642:aacd with SMTP id
 d8-20020a170902aa8800b001dcd642aacdmr2104317plr.67.1710268878282; 
 Tue, 12 Mar 2024 11:41:18 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001dca40bb727sm6951739plh.88.2024.03.12.11.41.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:41:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] tcg + linux-user patch queue
Date: Tue, 12 Mar 2024 08:41:07 -1000
Message-Id: <20240312184115.365415-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e4b:

  Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-03-12 11:35:41 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240312

for you to fetch changes up to 4fe19bbbea2cb9f1ec28cfd40cdc7f61e95a790e:

  tcg/aarch64: Fix tcg_out_brcond for test comparisons (2024-03-12 04:09:21 -1000)

----------------------------------------------------------------
linux-user: Add FIFREEZE and FITHAW ioctls
linux-user: Implement PR_*_{CHILD_SUBREAPER,SPECULATION_CTRL,TID_ADDRESS}
linux-user/elfload: Fixes for two Coverity CIDs
tcg/aarch64: Fixes for two TCG_COND_TST{EQ,NE} bugs

----------------------------------------------------------------
Michael Vogt (1):
      linux-user: Add FIFREEZE and FITHAW ioctls

Richard Henderson (7):
      linux-user: Implement PR_{GET,SET}_CHILD_SUBREAPER
      linux-user: Implement PR_{GET,SET}_SPECULATION_CTRL
      linux-user: Implement PR_GET_TID_ADDRESS
      linux-user/elfload: Don't close an unopened file descriptor
      linux-user/elfload: Fully initialize struct target_elf_prpsinfo
      tcg/aarch64: Fix tcg_out_cmp for test comparisons
      tcg/aarch64: Fix tcg_out_brcond for test comparisons

 linux-user/ioctls.h          |  6 ++++++
 linux-user/syscall_defs.h    |  3 +++
 linux-user/elfload.c         | 20 +++++++++++---------
 linux-user/syscall.c         | 22 +++++++++++++++++-----
 tcg/aarch64/tcg-target.c.inc |  4 ++--
 5 files changed, 39 insertions(+), 16 deletions(-)

