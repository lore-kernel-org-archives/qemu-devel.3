Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CC8CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtXg-0002Jd-VV; Tue, 26 May 2026 11:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRtXf-0002In-Cj
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:18:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRtXd-0007UI-H5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:18:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso72109995e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779808679; x=1780413479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/WSc1DWINEqAPD0KjQwOvLeQ5c6wA/WoSThA/Y8G36E=;
 b=TyG15d+2aZpuUq+PoY9VUbKlCF4Nu8yiL9/xE7GHG2CSa6W4iBi1ZHY2Ha7JKVu8s1
 WozBELZifwuf941lSyamvn4VEJcNPgexumxYph9zjJ2xk3IBY3Qwny/MW6WJd1AJXk8H
 pMlttFZD9Wnhrsz2MKW+OTfPznBpVoJ6Fin3rONTMyPYOYEq4iaXMToR/oFwpzBEl3Dw
 FPLNi3lZgJEVjik+iXI+XSOxj/eHMf9RFoB1AruqFnnoboddi4t71Ds+p/WG5YEGQ5ju
 eoxw1NazCPFkX7aBUSLA2aeTRbl8Iexu+/dDepPy/LyUdZHnxXbU9p3vu6CWkXhTduAi
 DnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779808679; x=1780413479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WSc1DWINEqAPD0KjQwOvLeQ5c6wA/WoSThA/Y8G36E=;
 b=YrQzqfS5tMtedkuwwj4ug/nFlFzjMrPQOcc5yxWZ6Q0yyAfTLjDKxQ3wnxtphAJKk2
 rwFwDw28Vek9QxEM9rLz8+Z2VD1bv8vdzHt66Zx6FOhA2xp2JcOTDY1qeo3+r7Z+MxvA
 qz2EXkuPKdVHd3qvOi/2hq2OAnUOWHHpzpnMuNvRtXDis84aHIIfZcsq0y7pMCmMLzXe
 BOT/9LvVJNKqvg7P4GYqNyip2QV+9dzbMCIxX4fkve2BY9R9BpNpMZ+W24nbNqRF9C9b
 e8FT1zE+7tUnPpmDQ6M4w0jXeShV/M/oM95isVnHdplhfJysNvtsSAeTUrr9JIyD0oeE
 V2Dw==
X-Gm-Message-State: AOJu0YwMZJ7YgIzNXTiknHjc194M8ZmwPqrhRfBCUaMG887kgH39KtSl
 JpATEANaMqtLRU+ZFuKXGNUYrhnYMVLt1hlinNzTpLPAEQfSfhwFaNhtcPm/WWBxZud8z6hCCUu
 EaqJr
X-Gm-Gg: Acq92OHK0us19FvYfFR+bdZtJas4/EXHVemYEk3JidMYCYe+LbqlhWWtxT0h/fkuo2W
 YlUMwyhUdb0OwbYOG+iAp0CLhYz7qfrRwNFC51lKRYUl4ZThmvoQ2j51uYgthOfFcUDkMt34Lg8
 +oXPfSzDZ0zGPwLK64ix5XI0+Tew89cl+PWvhpsbbhRHI3KKWGuvrVr0Uy7MuJF+sID5TtMHoRy
 a0gDCxD7uiMyv+Z3OmL+4YIlDlU3VF/ZWHhZlBfPvyFXpnGlQuisUnNBs0tcgOrFXlRSgQj/yYO
 qdlJZf9YbZUqwbgMk16K3WRDuF+c3VNEyzSI3rWzDdX9qgpq7yMg9kvCkoA9EtshzX4o0lW7YPX
 Hsd6Kyk949rwuczcZNNHdkq4O6jVi3khc2r0M1Q972j1V1RbD+seYz2TE1SVy2nFbhTLSsa6OH3
 5UExI8pmWesb/UxbIcb5g190DdxfHrB+vxXZiQvk9rHmyf+hweklUsPC2lkKZGoAS/6/1vZ0LNH
 Oh3vgrVgTVD5vlxC/t9zHPhpPLwerM=
X-Received: by 2002:a05:600d:8444:20b0:48f:e230:2a21 with SMTP id
 5b1f17b1804b1-490428ee28emr236207835e9.32.1779808679307; 
 Tue, 26 May 2026 08:17:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042ce923asm111485275e9.35.2026.05.26.08.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:17:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] linux-user: tidy up qemu.h
Date: Tue, 26 May 2026 16:17:55 +0100
Message-ID: <20260526151757.2371476-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

linux-user has a qemu.h header which is intended for types and
prototypes that need to be used by source files outside linux-user
itself (e.g.  the gdbstub or the semihosting code).  Prototypes that
are only needed within linux-user itself live in user-internals.h.

This patchset moves a couple of prototypes that snuck into qemu.h
when they ought to live in user-internals.h.

thanks
-- PMM

Peter Maydell (2):
  linux-user: Move init_main_thread() prototype to user-internals.h
  linux-user: Move cpu_copy() to user-internals.h

 linux-user/qemu.h           |  5 -----
 linux-user/user-internals.h | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.43.0


