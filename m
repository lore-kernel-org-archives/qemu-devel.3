Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35524C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 00:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYE4w-00085h-6R; Wed, 15 Jan 2025 19:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tYE4p-00084F-E8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 19:49:40 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tYE4n-00012w-Bj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 19:49:39 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163bd70069so5808465ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736988575; x=1737593375;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kqUbD+dP6YKBEqfxOFTFYLUPlQ2bAs6lr1qlPkJnA2k=;
 b=lxqNIE0AXNCTw6azUVRqije++mc4oyza/ci4m8yBnKkywgsu6sc5B4KCfxkFAtcnNz
 SJOY9f6xmhVhcGzhUT+E1AtiXn7/F1AEe0WxiLLGNNmi9RnH9Th/6eLYwaP8HmzUEWkR
 YyXRqYx7wDlkhXHKAWVoXU2K3sBNGvi1z3YbX6qskopwIwBuFDb4YcJd9TsIJIkZD6rx
 w/I0Hw9FxugsLyZmfThkrqSnTQkhWG0bce/ugIcjHS8gEIfR3Uemtyte9XQrC6BLnTTm
 31K8vUuWkNJBYNf3dciekwUCx4BYpL88U1xCyTTk5ifraftebRDo25bRO9wt5HJL7PUJ
 MyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736988575; x=1737593375;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kqUbD+dP6YKBEqfxOFTFYLUPlQ2bAs6lr1qlPkJnA2k=;
 b=f9n5ph/jLAebjEQEkLspvvjgmmSPXx0dZmJRIYq0lzE28KmV94Se15E6c2U4QeBiSR
 jVqqXk6q+xOc/0sME61GS5RccFPn5EGpJNVxGcXylIgDP51cakh8hNjyPwCucVDcQMaM
 e2f9Oa7Y4NF5MFcF/X0LqV7EUV2/3YeEXeortiNrOHglB1MOEQNMZpbEpwveJg0CX/lG
 gr7seXNqyAUA4CHhTdWwPGHiTvAK69fBImcPExH4Ac60UI0be0Bkdu0hD2rWyW0hNpqc
 Llui0r8gLzdi1nelcxMnt7ilSL11ywQvkQ5F9aISPS4EYLm0Tc2+GXWlc56ynGvKm0wf
 Xk0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIagkH6Bi8M4wDxeB5seiy9jYhL7a12GrhgfeMXdoJzPar+7QIeBkicRscs+iuPd5IIg/3j5JJJIS2@nongnu.org
X-Gm-Message-State: AOJu0Yw3os/yEdnoz6//aJtLPH8Tm0GVt+hcDxL16px64l2L651f5B0l
 oAkKO1dirFvSGlDTlZPBdiRwiXqQwsgEkpZgmR33mmpS3EVf5eITa+buOB4lXTitFxuuFI2ZANZ
 c
X-Gm-Gg: ASbGncsLbpfo/3SS0FvOMQfIluQvRrLvAmI7kTHNfL1Lgb0hcl2owaNZG0X3wdlQXRy
 Pywmw9nX6XPpm1K/gIvQeOaurDKOWHTpdjosG3y8kvNjT9kXKZ9lmLn/6bJ3ek2066OTL9Z4Lbl
 Il0D03OYGiXLwrlHpc8PIcj1yJbIOy8FyLhlBtPX8s9uur50SH4cZuGNYr3EsBfwZ6RhKdWg/5W
 3tQAfWDpI7ogBjiZletU50ZA3yrSi9upnZ3x8f3B4zxcEEGLVR6izfj6kdiGmkB/yevPQ==
X-Google-Smtp-Source: AGHT+IE7uBXmbSI6Ml8gdSwZ0aHHEvuvY0CMJCsMXO7DHFEKXS9WhgETPySV1jdgSWMfC0wyM6fX+Q==
X-Received: by 2002:a05:6a00:9a3:b0:725:eacf:cfdb with SMTP id
 d2e1a72fcca58-72d22033ef6mr47666283b3a.24.1736988575199; 
 Wed, 15 Jan 2025 16:49:35 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406587a1sm10036256b3a.105.2025.01.15.16.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 16:49:34 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 0/2] Minor mhpmevent related fixes
Date: Wed, 15 Jan 2025 16:49:31 -0800
Message-Id: <20250115-pmu_minor_fixes-v1-0-c32388defb02@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJtXiGcC/x3LQQqAIBBA0avIrBPUsqKrRIjVVLNIQykC8e5Jy
 8fnJ4gYCCMMLEHAhyJ5VyArBsth3Y6c1mJQQmkhpebXeZuTnA9moxcj76yae6xb3WMD5boC/qF
 M45TzB+hUg6FhAAAA
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Here are two small fixes around mhpmevent encoding and reset value.
The first patch is picked from the platform specific event encoding
series[1].

[1] https://lore.kernel.org/qemu-devel/20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com/

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Atish Patra (2):
      target/riscv: Fix the hpmevent mask
      target/riscv: Mask out upper sscofpmf bits during validation

 target/riscv/cpu_bits.h | 9 ++++++---
 target/riscv/pmu.c      | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)
---
base-commit: b82a273fb2210edf7beb9e5ca1401927fbcbe164
change-id: 20250115-pmu_minor_fixes-7a2b8e3658e4
--
Regards,
Atish patra


