Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BB1E6ADE9
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 15:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tErj9-00024X-Pr; Sat, 23 Nov 2024 10:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tErj6-000243-Ah
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 10:07:13 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tErj4-0004ps-B2
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 10:07:11 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-296c184ed6bso1825752fac.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 07:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732374428; x=1732979228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8w94NcMuIVb0a/URy0cAmx3GLp73CjgWYd2iM8uynOY=;
 b=cq7vz1eMssvEGjbRzXKhJ27Kha4gZbViuhwfGO/ilXsJ92o2BvdQNtqmlfAma31GQZ
 Mv1Sh2jcUDaUdz30AA6D3yowXrkfdwfQUhqy4qtm5DAaQ3cgaGqTN+HDJ9avMTtJ6Xi2
 9v1xiUvK2fOC8acBRnjOTzLXGKIokYWYz2pysxa3udE2P6rV4IgjcW8mk1ubE19Ds22X
 nYfzoDW25I3MfLE3XsM5rWowT68MlyqvLyYKnMMI6xxKtZFIsrmQc3UD0SaSjcGC0vzW
 9rNGffJF+xC3DTt6E8mNyxnyL9R+ET35r1MeLGoNJ/hVi/x5r20piB+Owpu9rRdUqEVc
 BMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732374428; x=1732979228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8w94NcMuIVb0a/URy0cAmx3GLp73CjgWYd2iM8uynOY=;
 b=CYLTusesukDSPp9guybM7541H1TAJ/Vrc6JKUnUxubuIaP+gl5mbFcbhz1lhAh/ctN
 WwrQocmR6iCOPboq1KB6/1K9j2KAmQDd78PdYLnKDfiYAFKITx8IWngCWsaGRyzHyiNF
 t3/Me4D4glUGyKTye6ilWpUzLZL7DXzUbKKquI2HBcTtPBcPyCPfWIPacz1cp1oeIWVU
 2y2UIPkFmgStuZoVfxoB2rD2d2xOPm64hhzklZph0f8zAz1915Lw/Mgu6RoEI10Hb30R
 QrnQ4x5pCdqO8QOebOiGWFFseFjkCjFEOfJXamJKni6l+YYHVoBVGaNq51DwV03yz4y0
 auCA==
X-Gm-Message-State: AOJu0YzCjni+20W21CALl2zTe+BCZH75MZiBqhVWN8Cxq/o48aGeD/hC
 sdjvEw5tRSQvoOkGWAVJWi1CuTixSg1qaOXY+JmLf0G9YqqfvoqRjz8Z0HzfCqnl8e6v38c91tJ
 5c1I=
X-Gm-Gg: ASbGncuzRkXFSTi81D7giqLBZlG+1RDBSU4oZg1ZOyQY/2D+IVMKk+DwH28EjbPCvzn
 IBts31K5WU4vg7D/8GnYeCL9tQcYdc7PPoq1qSW69/s+kCblaBNwMCA7K3b4n0gEZR9emwXHPW4
 SuZ7RwljcRMrnhjn40diprBk4yXm2d8yLpohKc2fTXAi3ks+k/7C7b2BliIoHwBh7psdCUd0TxY
 yJtFh0vB3GMPXlb6h7IdscqvCXDZD7x7ndBiLbJaRtDjSx+C1MZNGlY2Q==
X-Google-Smtp-Source: AGHT+IGrfnXEQIAyO3RXGpUueRbc5n0+Vl0AoksiBboLktgFvEQ8SAmd3rAVsfHnoLpF1+BgNsw+aQ==
X-Received: by 2002:a05:6871:8915:b0:296:4d07:ba41 with SMTP id
 586e51a60fabf-29720b4600dmr6505735fac.9.1732374428631; 
 Sat, 23 Nov 2024 07:07:08 -0800 (PST)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d82291fsm1396390fac.33.2024.11.23.07.07.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 07:07:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] linux-user patch queue
Date: Sat, 23 Nov 2024 09:07:04 -0600
Message-ID: <20241123150706.19740-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

The following changes since commit 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5:

  Update version for v9.2.0-rc1 release (2024-11-20 18:27:48 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20241122

for you to fetch changes up to d95fd9838b540e69da9b07538ec8ad6ab9eab260:

  linux-user: Fix strace output for s390x mmap() (2024-11-22 14:20:38 -0600)

----------------------------------------------------------------
linux-user: Fix strace output for s390x mmap()
linux-user: Print tid not pid with strace

----------------------------------------------------------------
Ilya Leoshkevich (1):
      linux-user: Fix strace output for s390x mmap()

J. Neuschäfer (1):
      linux-user: Print tid not pid with strace

 linux-user/syscall_defs.h | 7 +++++++
 linux-user/strace.c       | 4 ++--
 linux-user/syscall.c      | 5 +----
 3 files changed, 10 insertions(+), 6 deletions(-)

