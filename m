Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E31C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9cd-0005Vf-6t; Thu, 08 May 2025 18:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bi4daAwKCocylmtsp34pqlyrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--nabihestefan.bounces.google.com>)
 id 1uD9cb-0005Ui-Eh
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:21:41 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bi4daAwKCocylmtsp34pqlyrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--nabihestefan.bounces.google.com>)
 id 1uD9cZ-0003Rz-FZ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:21:41 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b1f8d149911so1486972a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746742895; x=1747347695; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y5dv+AmlzIvDSwk4btx/YlLu8rd3snmuoU7Mvc+vUso=;
 b=Q1j0F9Ri7y+3CBx43r6lqhnHuS3pFFqJljubVycrkTy0O8//+lUNwBRr/bPSzWydb3
 zXzTFhUgnyDEcDSJ8FBSaThFkK3cAS+t/rAH+l5r2htkkRaDHhNE5PnQcZs+wBg37Ijn
 qYVfzgGe4jfkspvQu6XxiCdaeIDSZGyw+I7+DHHqj8KWTfMC4Fdlg6xEFj6eYzAbO4Az
 kcQfUUlq6C6sCAKkdZ/Kb69YWKqcpNMquIo2L/uZ0TdB07MbUTLbRCY4JzxAv+ZlyiKA
 A2+TDNxUJy6itqi2D4rkLmRzaNjocZO7zAgLT3bijasVA/jVrKhMXBs3UXRi3ztofke/
 A7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746742895; x=1747347695;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5dv+AmlzIvDSwk4btx/YlLu8rd3snmuoU7Mvc+vUso=;
 b=tyhbpYJF1TcFKMvc/ztbxQJBBOti9NtgPGBb/8ioA5yRh9NsyG1NDBaKHM9Akpz2u1
 AZYemlVB/xup0cUe9vLO7rUKSySbC8RTYQqXBMuX9GRvRZY+hoKQWCtcSUn5fYAcMBZW
 WecnoY4/TC4/JpwXFCy6DGpNHqjhZlekADAIQ2zy2OBwVaPWEJ69g40sR5AOHCjXosDT
 XlZULx476wY/Ns0Fe+pT6uS700ooO3/y3PjfPpcWpOyw0HolWhHnLY5lk/4dR8AMeuPU
 PulkSQS1TfwpMs3MnRf9ji4rS9Zd4d/JnmmCbk4DPNZqxUiDEPes2GBBlP7Cv+gmjrqh
 nqDg==
X-Gm-Message-State: AOJu0YwoumjAfvjybfitZ+8Ecavi9SNNGO25X5iSev3m5FH2ulC4km+f
 3BmUGElk1kLPcCFoT2Pg2YXN5lpQH9xB90uBYXqly7wyW2fmvpwHJny6d5SJZ118CPhhZngVuWO
 c+E7PmBiHqGhg1P9tSBVBLOvAMHvyjtwW/3nGsYbPfAUaQ2SI66JNufEsJoDxRT51e/gpQpDxOA
 UaEnsgtwyn7KqkeCiSnfebIAsJJt/PVSz3J6FPkMpEIXSQjZQ1o5gZnhwosgEi/CU=
X-Google-Smtp-Source: AGHT+IHDizn+UK8AprUIQSpynkoFVQHQUuQP4T+obuapwwO9U5gpWIDnBWBzmtAeVfb/Mup1cL/52NwKQY+6H8tV0Lo=
X-Received: from pgn7.prod.google.com ([2002:a63:d47:0:b0:b16:9964:4283])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:78c:b0:1f5:79c4:5da6 with SMTP id
 adf61e73a8af0-215abab9196mr1234154637.5.1746742894769; 
 Thu, 08 May 2025 15:21:34 -0700 (PDT)
Date: Thu,  8 May 2025 22:21:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508222132.748479-1-nabihestefan@google.com>
Subject: [PATCH 0/2] Miscellaneous MSan finding
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, armbru@redhat.com, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3bi4daAwKCocylmtsp34pqlyrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--nabihestefan.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
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

Fixes for miscellaneous msan finding in QEMU

Peter Foley (2):
  util: fix msan findings in keyval
  accel/tcg: fix msan findings in translate-all

 accel/tcg/translate-all.c | 2 +-
 util/keyval.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.49.0.1015.ga840276032-goog


