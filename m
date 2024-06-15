Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A68C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 13:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sITS3-0008MP-FB; Sat, 15 Jun 2024 09:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.joerg@gmail.com>)
 id 1sIRpV-0006Gd-CG; Sat, 15 Jun 2024 07:44:21 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <martin.joerg@gmail.com>)
 id 1sIRpT-0000Ur-6Z; Sat, 15 Jun 2024 07:44:20 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eb77b1d2fcso128163739f.0; 
 Sat, 15 Jun 2024 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718451857; x=1719056657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ux8Dm5lIBUr4VOu/ulNgfoar5Iom7WwzWnL/JaR/fY=;
 b=WKY+vLb4E5K41Db+9h4wVsQE36IdNLlP8kURlvbwp1SRN85ye0M65B3ztbJEHYSRP0
 +ItQ4O6E0a/dEYkteW68fnrdxH8+uD6bSjPQ7MGcUlDR+E0uEkvNIvCxJbTHa8jk4dD7
 KIMThmUV+GUU1+WJR5WlG8djUppoxjprAC9BjpxU0+6LCbvoTGg3q8bfPryLbsVgnTdR
 2XXN6QWR8PdhybuLcuQg0hweIOcJpiRxrmpXqiNj43vkIJlJzuDsOpvhakLABc+qthi7
 Ee4huqUrybNFybfj6CLaTECkSYrAr65JOBKx52LBEGOt+ubNiwtnhC7ytnYDTlU+yL9L
 NuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718451857; x=1719056657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ux8Dm5lIBUr4VOu/ulNgfoar5Iom7WwzWnL/JaR/fY=;
 b=bdVIz2kow2sp6bmWNv48keBk0Q4wEksjJSAmuaK0dCBexgP83pIsfCv2skMFOXpJO+
 Iej7KF+uPDzZFUfMvYC9f1LzqWeXJcWY61QsWaffNNGND/Mm+VBzf6hzMUrqZFAtdIRW
 wLG71LYV9EbqjPHOjSuXsVofkC2lBYNaNJS+F/oQPPkgU4lpZqgrVAB9pC8gpWj6BcEL
 7dR8wLnOKdFOVueVWt2KtKrKtVbfyUVo1XdXsefc2BafjUshHVXdM9hisI+QXe/zRwDi
 ppTYFmpHLP2ZYiaJ10hfck8/8hmetvLTfQAv2i7jHvkTFGWCsd9YeQunH5DM791jI3fB
 /KDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo4uWHjecOHpbvX17WtmFCOYn5hYim3mrKwlu+v5wPGI83L/kS/8o0HZio72RRoHFpqZfeB+Nqm5tMAChFLIT54JmRZazv5A==
X-Gm-Message-State: AOJu0Ywt1nMyyBdcCgaZY6ByUQEsE6C5crb7gf4uMJjhvDPRTtYxXWPM
 Gmc2Iu310EvOl2OPH4Dvaklh1vdb0A/0j5RX5LINsQAUFoHgIEqwno/3SaE2uW7gwg==
X-Google-Smtp-Source: AGHT+IGwVuMq0sCZcYl4fEC99vqFdFsDxMSxSN1ub8iFD8j41hdU01eR3IPOU4ammf1f99OLVrEyvw==
X-Received: by 2002:a05:6602:3426:b0:7eb:9864:410b with SMTP id
 ca18e2360f4ac-7ebeb4b4633mr568297439f.5.1718451856695; 
 Sat, 15 Jun 2024 04:44:16 -0700 (PDT)
Received: from boondocks.. (18.205.134.34.bc.googleusercontent.com.
 [34.134.205.18]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7ebdbaf1edbsm128182339f.55.2024.06.15.04.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 04:44:16 -0700 (PDT)
From: Martin Joerg <martin.joerg@gmail.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, qemu-trivial@nongnu.org,
 Martin Joerg <martin.joerg@gmail.com>
Subject: [PATCH] hmp-commands-info.hx: Add missing info command for stats
 subcommand
Date: Sat, 15 Jun 2024 13:43:23 +0200
Message-ID: <20240615114323.30550-1-martin.joerg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=martin.joerg@gmail.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 15 Jun 2024 09:28:12 -0400
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

Signed-off-by: Martin Joerg <martin.joerg@gmail.com>
---
 hmp-commands-info.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 20a9835ea8..f5639af517 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -892,7 +892,7 @@ ERST
     },
 
 SRST
-  ``stats``
+  ``info stats``
     Show runtime-collected statistics
 ERST
 

