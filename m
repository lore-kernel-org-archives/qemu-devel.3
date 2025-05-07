Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD86C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 20:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uClfR-0007Mc-Gp; Wed, 07 May 2025 16:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uClfP-0007HP-QY
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:46:59 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uClfJ-00037Z-Kt
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:46:59 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f94b7bd964so315388b6e.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746650811; x=1747255611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EhPrnWrrEa3D6POxudXMd7e4Z/b8W/qudNgP3sQ1aLE=;
 b=vQFELfWQtJi+uqYsJ273wSSgYFHbfZZlAi91CbPHlbnlar8j6QaP/ypmW+kOXPwXDH
 g90tnETYqWv6NTqgP6KoRYNFT1+RvktiVyMtKiOtWknlT1PEkZFptJX/hUeq06k6yUNS
 iqETttIHUyyTqzYPDdoGfNW73cJjcsbVX59W3ixA9SAmz/Epx3F8oiqBolKjuj1PGQjJ
 qpjv94zfMEpR+DE1UsoGe6+tuq2j3+aRq3NJiY4cdNhfCrhzdpp9GSAejJq8XGcBp0qT
 lermtuhzLyKT+nXHFTRlZPHmxK0XquD3muZFVMvmwwkTDiyxa08NfuCrGg0a//otSsr4
 HkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746650811; x=1747255611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EhPrnWrrEa3D6POxudXMd7e4Z/b8W/qudNgP3sQ1aLE=;
 b=QqVYLJqKnF+NJ3WT0TChzyUDrB7Y744sYZX1PJrg60MDsu7F2fEn35qLwXkfD2v8sU
 MepFJyd3udqaAJK90ja94xjFLsQUv1Lx9/4UuK0AbIDb5O0JSNcaTzch5QCnqKg4lWgO
 4RuWHkYIduAP6IJv+FisddBul5sjwCi2OtQy+Sptybn0mDnK7Go/suNWw1T8KhI20zNU
 FtLoFJRHWNqcFIRrWw4y978l1TFcnoe8cdpkAHzOpFkt0JG1riAbngPzyNwcIMEkdbpK
 wEWS4z/f3QBwrhwdhWJzjqGS6i80GSLUKGYs8jbcY4dzf1VVTqP/akhyVdBI8XqN822S
 EKrQ==
X-Gm-Message-State: AOJu0YxZxjhouw9yTtjrfB14tavce+FONYmReWCJLW6UckeuI4mLT5U9
 7hpTRUWvX8ujgnOXsThF1HvdOUMb2Vunt4wHwaT9rqezgTvcAVDECHzS4CmWGn1m0nD0BL8yAzz
 AQ/M=
X-Gm-Gg: ASbGncs20hauaVZt7OuI/DQ7G2UIHGyyM/WrLj1ImEEtz9V0+AE4Rm2NRMMue1xNJpb
 FFOwx52TnkwGXlkAH0X2oVRzqP26/J4BTi1Ftr3yb+srGMd8WceH5HKX3nmTyeDiKuMhT4FxHqI
 C1qOvA8WnCbJtYsNPew5l93Pel0LjEv5wcpb18iMkeNN/3f+z2VHpoN7Zdso+W7ilZJ2cKdQxwt
 bJB+JMV9isHXfoT6E+mghkNY7LhYg+yOW6oXHF27K0Vg9WIF412V+t48de6H1J89cyZm/7/5crf
 x0HEkI/vhjdKol0vGJRlrISCI1gBqSCx/Rqm3qgpO+Ecvkh8
X-Google-Smtp-Source: AGHT+IH7/ieVTBFFKIEGbzu2A6yU9xqQJKw8wAvcdGFHCv25joYaS7oXC37//qPBJNx37uLpjrfvVg==
X-Received: by 2002:a05:687c:2246:b0:2b8:e6f2:ba7e with SMTP id
 586e51a60fabf-2db81400b71mr607967fac.12.1746650811089; 
 Wed, 07 May 2025 13:46:51 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbc7d1fsm920933fac.11.2025.05.07.13.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 13:46:50 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	thuth@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH 0/3] Fix typo in comments
Date: Wed,  7 May 2025 20:46:23 +0000
Message-Id: <20250507204626.139507-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Nothing exciting in this series, just typo fixes in comments.


Cheers,
Gustavo

Gustavo Romero (3):
  linux-user: Fix typo in comment
  Fix typo in comments
  Fix typo in comments

 block.c                             | 4 ++--
 hw/display/apple-gfx.m              | 2 +-
 hw/xen/xen-hvm-common.c             | 2 +-
 include/exec/cpu-common.h           | 2 +-
 include/hw/xen/interface/io/blkif.h | 2 +-
 linux-user/mmap.c                   | 2 +-
 qapi/machine-target.json            | 2 +-
 qapi/qom.json                       | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.34.1


