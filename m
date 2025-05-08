Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61E1C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9Oq-0007Gd-6H; Thu, 08 May 2025 18:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GisdaAwKCi0WJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com>)
 id 1uD9Op-0007EB-0j
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:07:27 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GisdaAwKCi0WJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com>)
 id 1uD9On-0001gg-2s
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:07:26 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-740774348f6so1390231b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746742043; x=1747346843; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r/pZDNj5CYqDMrS+f9OQvU0SRaHFWWrjwhjlTFIbAco=;
 b=yehTiwGUVWhyX8tYLzQkh4VV2Mz28ooi0dCGCyww/rOKiJOW6eN4f6F4Bjicp2GyWi
 aNPN8zAIVt+rry9AHK6lDG+mxLvR/fIVoEmtCV7vBvQguBdAy5B9gLYWH8UF6ALIJTr8
 Z9DAZpiN6e9sI6CcKrNKURfodpwMpVrTFBwL29frOTwaYos/ZneRcFj+CDNxkpsJnpzZ
 vNlJyqwW/EI/7XTtMADFSSxl6/Mzqu2Oc3Lo6lNogQvrM/+hZarLF5Djyk6bvGNRFGsM
 dVp9xCNRsIR5YYoT4P69F3PDwwFklyevMfHrTSvUuInouabsUrmKM2JxDFwQ6LVPoN7E
 ovtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746742043; x=1747346843;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/pZDNj5CYqDMrS+f9OQvU0SRaHFWWrjwhjlTFIbAco=;
 b=FqoBVn8ahDQ86qQP2EUprUqxNd1rz0c355E9heyVlTN6A9n8vtzO70c0FxHTULx1Vd
 0YZEAngXL67vcXvjokMQ1ZCOLrR4k42f2rbAkm19EOItX4OJS6RFYyIlX4uL6zrw0TKr
 uLKdqAYLJ0+V3WIo3KrbR+v5zoavYe4rfNcLGt4CW8bin2btlGHVYZbelKilF8Hr7u0a
 5KYbyHrv3L6wIaqb79izN1UxG0fAJL4wo2bvNTLskvbaUYCdMu2GcnwCCMoxp2dpfWlq
 /EzySJ5hNUkR8rnDmlcszTLpnKNSHdv3GRi3dLB9XmhGwnvf4xzuNBSAuF+kwJXlWsC2
 4Nbg==
X-Gm-Message-State: AOJu0YxKJhWIwufuywEWfAHBHaycjZmf7a8B7WBn+rPZRbONT0tC3pgp
 2C7MlQVHEIhpkLDQM5tVKun3EEFBlaqDRRkx8FhszMsyabnuvXgZenJEhbTWSUXZRjMGh+GxoKf
 vOgqoMp9YVva1dCTz4TpRB4HSdB0AOVJhZU63+5P2Tdm9lQChH75Rm2yDHGwunREwjgC6VYnoBm
 /ZF/JMxT+hegMnlzTk+6l7qi5pINcS/A7XOaGhOCwg0HL7XGpu/BI5UAiiuMxGa/I=
X-Google-Smtp-Source: AGHT+IENqiyMy4+/ihxJHDwwY1VGNo442NG3BiwhXKDzzEYIK00E0XFqRjgE+dQk1oMn+W3CStqOe6ySUPvZ8DPXSzA=
X-Received: from pgbcp14.prod.google.com
 ([2002:a05:6a02:400e:b0:b0c:3032:f595])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:338f:b0:1f1:432:f4a3 with SMTP id
 adf61e73a8af0-215abb397f6mr1064386637.23.1746742042889; 
 Thu, 08 May 2025 15:07:22 -0700 (PDT)
Date: Thu,  8 May 2025 22:07:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508220718.735415-1-nabihestefan@google.com>
Subject: [PATCH 0/2] hw/arm: Nuvoton 8xx - GMAC patches
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: kfting@nuvoton.com, wuhaotsh@google.com, peter.maydell@linaro.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3GisdaAwKCi0WJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

This is a set of patches to add the GMAC devices to the 8xx board and
migrate the GMAC tests to 8xx, which is how they were originally
created.

Hao Wu (1):
  hw/arm: Add GMAC devices to NPCM8XX SoC

Nabih Estefan Diaz (1):
  tests/qtest: Migrate GMAC test from 7xx to 8xx

 hw/arm/npcm8xx.c             | 54 ++++++++++++++++++++---
 include/hw/arm/npcm8xx.h     |  5 ++-
 tests/qtest/meson.build      |  6 ++-
 tests/qtest/npcm_gmac-test.c | 85 ++++++++++++++++++++++++++++++++++--
 4 files changed, 139 insertions(+), 11 deletions(-)

-- 
2.49.0.1015.ga840276032-goog


