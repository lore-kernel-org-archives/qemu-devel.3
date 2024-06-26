Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0A9C30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 19:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMYeh-0007If-R5; Wed, 26 Jun 2024 15:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMYeg-0007IW-SF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 15:50:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMYeY-0002gj-MU
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 15:50:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fa3bdd91c1so30005635ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719431392; x=1720036192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F0Q7Qb8xkJQuzlOXC/gMXk8OrUSiv1snr6tSiHC/3A4=;
 b=FWKURi7ksNH0ktUM84oedeUQqN7WZDzkm5DEZnmPm/vEnvs6B5KAZvb4SHPTL+wF88
 CvlbGRFucOrCnyvpzBcmY/7fhL8Roq82bVOhCOHW5L331RFAmd0CgPcm6PvAHm/noYqV
 /0O7iH03jF0fq0NaY0WhaHEEkFBbfgdmVsppS0FJ3wPdLPccUUxo+mgCQYvtUJCGYg41
 RZkJzfk/MDF4kOBMFI7T4mPIYchm1u/GppTgKDCExOB58oGRi8tMdc8xya8dt9EuTHvc
 pp9KIq+MaZcgfj8BXztx3azpcptlLGbCKnB8OdCFbgKPiRaFK4LYHBSjY5Z70BiVBb98
 9dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719431392; x=1720036192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0Q7Qb8xkJQuzlOXC/gMXk8OrUSiv1snr6tSiHC/3A4=;
 b=LHto6YnbNbQBrz61583bJ2/Vott9J1yHtcWsk30YlR/eE39k6CrazqCQCqCyvIBb2T
 vsiSKhGLoSn2QOIVwtUCm1kUS0imWXfwqh2y82LonxPMuAYn4MhY6p9CY8+Vf0ygpXAo
 0OjMbj4+Oc2i/lsxeJJhdMEeNQLzTBc9Nmrgkv1c5glQ1mmm6QlgZuFcYLAQst6DPVSJ
 qcOd/q33ZNzrI/gxoErtN2fpNbhOXOvtExjOH13FH1+rc2fARTfesbU9TbjbrdQqKOHw
 Dh/gduvxhMY+xnu5TH8v+uEeb5mYaXbgbcY7qoo3ht2ftkZBsMCLG8tMxRPzs7iCTbQV
 t99w==
X-Gm-Message-State: AOJu0Yx9u91n+0fzAJ26b/XvA+AsCTdZyL7+4oSbFb7Ngjjk5zfCw4g/
 Xak/NByzjrAlvCcn/43SOdz2APIjNtzVW+Z+9IPbRNmy70zMKLUD8lJCv07gSw+19hbWSg/N94s
 w
X-Google-Smtp-Source: AGHT+IHOJ1Tw5qXYHayliVZVtoCy7UK8ycp+YUefl4WG21FMQQ84m2pfJiMOOPChVmPQyMs8AEUY/w==
X-Received: by 2002:a17:902:654e:b0:1eb:fc2:1eed with SMTP id
 d9443c01a7336-1fa23ef5f27mr107027725ad.41.1719431392015; 
 Wed, 26 Jun 2024 12:49:52 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb2f0318sm103734625ad.2.2024.06.26.12.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 12:49:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH 0/3] target/i386/sev: Fix 32-bit host build issues
Date: Wed, 26 Jun 2024 12:49:47 -0700
Message-Id: <20240626194950.1725800-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

I separated the fixes into 3 smaller patches
that may be easier to review.

r~

Richard Henderson (3):
  target/i386/sev: Cast id_auth_uaddr through uintptr_t
  target/i386/sev: Use size_t for object sizes
  target/i386/sev: Fix printf formats

 target/i386/sev.c        | 41 ++++++++++++++++++++++------------------
 target/i386/trace-events |  2 +-
 2 files changed, 24 insertions(+), 19 deletions(-)

-- 
2.34.1


