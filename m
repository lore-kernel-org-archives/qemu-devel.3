Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6666BFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHF9Y-000526-7W; Mon, 27 Apr 2026 02:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wHF9U-00050w-2A
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:06 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wHF9Q-0000hQ-Sj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:02 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso6389357a12.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777270139; x=1777874939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dj5974dVflUeqeR/9kqN6lrYauLJt57H/ZKahF2mZM8=;
 b=darBXUZGMixg6MLchMXJlxawyBEpSr5O03YDGyT6r3pb/ov7LL1qnxmSzHZ07nbn9W
 Hc+Bu+dl+0NTuoYr0X5bUbdnKQrSYTwk9F5zLgPCwlqfqK3IRkDF42LfoNWK0QjTJqNJ
 cElaDPFfuQXfkfxuF6wUjNycO/RI7PeybYF2mbA9fMCxPYlK2YEHeeloURzErGhP29tH
 vt6YkRM57YTF2AKnjpd8SYn9+epKba0KQfzq4RsrGzeRKtKtm0bngiER7CG3hEuMS8UM
 sfgGqgs8WvUNc2ylyAqzZxRy1cWjT7BxR9Oix8TQHTrYc0pnnUsXkfJ0pDEjBGxFfBwQ
 8j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270139; x=1777874939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dj5974dVflUeqeR/9kqN6lrYauLJt57H/ZKahF2mZM8=;
 b=FvghJAjf5s8HC2TZRyWamJ65vR1UGAilVKyiyW+8AscIM6W3DV0T7IEJE3KcSBNgGv
 gV0xXT73XDIhLsf166s68u7/eNMozBQoDdFqYYMD5AS1NYRejuWhi0U55JBL4P7IHqJm
 voHXrkC7wj1r6X/R6QbXEpfIwDGeD7NsI49vbdVHRt1E92RAqkP906N2cjrB5Ik7O9Uj
 RSY2jyd2F5y4GomCx3s3fWZ7fwQfHqLqUh+BSTNOHGeUKbiwmyX2qVeVm3MVYqz/rssD
 fs57FOdZB47OYpfzfH7ZCUIg9vIGZj+hNDP3Pjyy1STVxhfCzKsr+B+1D974WvTTKhPm
 mJJQ==
X-Gm-Message-State: AOJu0YwAux4Ek9AUS+PVEau48U2HCJ77ZdE2F/kz5Pu1xdgMzOYbldQw
 8BqSsKGj7jwsavcvdAwxb5RSYklgTA155hMxwejRpBA2+UMBQ48zRDF7yqHiQRHF/yw=
X-Gm-Gg: AeBDievgG0ZptCrrSjnULNoYr506Aoiyxt0GuXvyP+Dqn/zsj32ThfEXl7jB4xhr/Ta
 PA6mcIXg9rnpjHzHjkeZmKHVgxMAPa7GsNFcp8l/yuN1dyt2ncFpnusLZhGPlmLBLPA5Ob+/7zF
 zUxULrrWpjF9JIrtoGDepXv6psBgQ15ZuX18QCGSYmvE992kn8HTd1aF1z0F6/xPtxkBAUnXpa2
 7ND392yoRNinyyl9RwzbDFb7h7h4aHV+TtguHcLk/YUmyj0LuxUKcvLPExyBqj/SzRo8uHUvshy
 97A44D7nx41EJuDi0G/qTFu0NATAtAiyt5Y0DyASwtMFxAOM4O9ExXcVuQGKPG2ge47J/XjmHo2
 Dy/U2/ZRC6REsby/RWQ96L1mQ/ankk4CF1X0WHHO14qhYC9Nr1WcuzEZTuWq++CUJyQ6ZqKChP1
 W96udd4OogkCgr/Js3paM=
X-Received: by 2002:a05:6a00:8510:b0:82f:9e98:136b with SMTP id
 d2e1a72fcca58-82f9e98218amr25544204b3a.19.1777270139126; 
 Sun, 26 Apr 2026 23:08:59 -0700 (PDT)
Received: from arch ([112.133.246.7]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe41cfsm33847033b3a.43.2026.04.26.23.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:08:58 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH 0/1] target/riscv: Fix medeleg[11] read-only zero bit for
 M-mode ECALL
Date: Mon, 27 Apr 2026 11:38:48 +0530
Message-ID: <20260427060849.749179-1-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=314abh@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch ensures that the read-only zero bit (i.e. the 11th bit) of
medeleg remains zero, adhering the RISC-V specification.

I'm a first time contributor. I was a bit confused when it came to
writing tests for this. However, I did debug it via gdb myself and
confirmed the patch works. I would like to seek guidance on how can I
add a test for CSR issues like this -- or if it's even required in this
specific case.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3438

Abhigyan Kumar (1):
  target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL

 target/riscv/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.54.0


