Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1674CF94CDF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSaG-0005hq-31; Wed, 22 Apr 2026 04:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSaE-0005eq-9U
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:05:18 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSaC-0001UW-N9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:05:18 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so930201566b.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845115; x=1777449915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zzrl0HPc82N/AwcdZcB8bmuFYVznIFsxHkpdek35u2s=;
 b=sc12JJ0mO4WpwRwaN5ay2Kf/igoeV+Fbj9g0NRuJmm5rNVdw/qad7NMalF9ooEDu1R
 rA5o4OpG2hiJ+147w3frtxO3dIcVpxQrw4ADw0KgJBdcH/LXvQoNVttoX3kDHGiWf71D
 jRMKc2uT7b7fUZil0oZrEoh1FpwDy2FsJHWp+Wr2vls1zavIZmCrd5VJ1HO+J2RVt3ng
 s3vefI5IE8fSrctVNdjpiePg0jKZuwnDWTVMx+I9sudhy/4ovu188tw1FXdXfPNNSNEG
 LIcU7bigG0sykvB2SclWwDUOsBRzbme8uEAq21rRultrgkZciT2+YC1WmfLGhV9gn2lk
 MpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845115; x=1777449915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zzrl0HPc82N/AwcdZcB8bmuFYVznIFsxHkpdek35u2s=;
 b=AuSPhQd6Lpki4ixizkmM9kZARSxEUgdoyYOPiyxZQvefoNHUd16NzNvXNbWGTRRSqM
 OLG3nMGAqylnv1LtXUPLBEtO55rgTaZA2W+TgDebtErUsX/GB9jhlRqSFbJ+65MbAViD
 n+fp09lN8eYnzbPCvU8dH3n3iwLWlt8rywhQLbSWZ9JBZyvml8vaIoFXpbBJtyju1umW
 IRMkwz5AqbTxJMnuK0dvlauRscV/LHiDi0lsqnnil7fZWLLa3Mkdc/lzA4lBnhbmGE2H
 205SEyYiHJAJKW4m0LGXw79pBO3lEQneL4zRAkJA+YlnMje2FEnXh/E1TUoGZAH9OynE
 GGnw==
X-Gm-Message-State: AOJu0YzJevGxespuQQNfrIvF8ma8v+oGe7cfXWwOz0a2OUjKHCk/Zdu1
 rl7tdGWHwWe7qBXFAe7HV3Cf6dWYO7WPW8pFV78GcX6i/9VSLocr0PIBp7Nkz3nTqDLd25jCVdU
 xISAxwHw=
X-Gm-Gg: AeBDiesCO7I8XT4TGsEIvKDVNwL/0CrMZc1XnBUFviURfUYFR4Ra6F9nzLihByvhaqe
 VTtansSkXhh9kgItXb7u8b4OV9qnXCp9p/zJtPo6SqzW23v19cSjkh6blVjXPU2oTRlUL/He5sg
 8gepLoil2MSqrTv5qd2TMzFA1mSz0qwcJrHNAqp6bYPxMQS/aw6vZ791n1Q/YTAHcjAKBvpEUMk
 g4H7xcTW8qlPXv2vWZZIbOs2AwqdSl5bjzJSVSE/pNVhW3HVyyG2XeyezaoeqjtF0YXINMWtyWV
 FiDk2i0wLXaP63Sqt4CYfc4uP5vBwbtQVLlyYqoXEWjP2edET3p5pT2WgXJxglLdr6rGjma03WL
 GvChkhqXb0LiSl1GDdfZzsuGrNEnZZGQiJO8weonap3+g0Ct/AobDxwczaLCmOmGh6kJkydOlbA
 RLhUGnAilqDsAvErR4y/RhsIOKQv88GEJhwvyiJSaZNwtZX4L9AgxpYTNy4QRYbfo7azc5BrUgz
 MZVTyBh4jQ=
X-Received: by 2002:a17:906:c142:b0:ba8:7211:58c with SMTP id
 a640c23a62f3a-ba8721111d5mr568053766b.18.1776845114703; 
 Wed, 22 Apr 2026 01:05:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a092sm9413482f8f.23.2026.04.22.01.05.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:05:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH v2 09/10] MAINTAINERS: Remove PhilMD from firmware sections
Date: Wed, 22 Apr 2026 10:04:04 +0200
Message-ID: <20260422080406.62638-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

I'm not paid to support this code. I haven't followed
it neither, so be fair and just remove myself.
Demote the status to 'Orphaned'.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5aceda193c2..242546498bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2846,9 +2846,8 @@ F: hw/usb/vt82c686-uhci-pci.c
 F: include/hw/isa/vt82c686.h
 
 Firmware configuration (fw_cfg)
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Gerd Hoffmann <kraxel@redhat.com>
-S: Supported
+S: Orphaned
 F: docs/specs/fw_cfg.rst
 F: hw/nvram/fw_cfg*.c
 F: stubs/fw_cfg.c
@@ -3969,7 +3968,6 @@ S: Odd fixes
 F: docs/interop/firmware.json
 
 EDK2 Firmware
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: hw/i386/*ovmf*
-- 
2.53.0


