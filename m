Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E56E67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKLJ-0000xk-0T; Sun, 21 Dec 2025 09:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLG-0000xC-Lj
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:26 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLF-0001Gk-5m
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:26 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso3546966b3a.2
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327003; x=1766931803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=snW/lAJsvlro2YKDHOq0YZuf450DL4XwjF1IdhKt2ME=;
 b=U8SL4ZDsc+AdxmbqXsBtkZKafJeHghB8aH+wFqe9zZoml0+YvLD6+nGZHIFZ1cnYAD
 +HbLpqSSziuLNFdTWkU6chKpGFiMJ66jBeqHjFcX2IxX0hbLN5HJFxL+mXCvehDaN/FX
 ylfmoKdyi3gzNEzmm+7X6GvUbuWDDBMqziE6fm9QqrkHjirj0H+nQJ58YeltCYNHmk7C
 zNbK/1UKV5BCGQ//jQoXPC/2FUho3ibUab1zzRI/wlNTYdUzHBTYX2gDgoNooKTH86TR
 y+nXHN9AwZkd9eZjmfmzXOE4WgqNzo8XIyyy8g5G//9KoYpPCAYXf65VdJyFPAh8qTsl
 eHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327003; x=1766931803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snW/lAJsvlro2YKDHOq0YZuf450DL4XwjF1IdhKt2ME=;
 b=fWjdrSpzSLsuEvPdYISBdA2xzlFLZnAzcMwdaRFfKnLdcgvjnTlqf/ySFOHQR6m+b0
 ukS/BpOFGljovXUwBn08OqNakbT9SkbfIB4axj6kuYzUozCeYgNMswQmgXgqNGjQbcrP
 9M2DqnMJUZXx24ZXf27HbM+6rNWjjuLQMgze4DOGT9o3bLg+VulX9XWrAq1NBbOWgxxl
 ZSpisFQcbnBAot0hddcNj4B6WVe0CxitE8fK7P3lSECvkp4I4G0eABJCu5Ssn19L00aM
 SpbkTpsx7CNZ+qM8kd8lkrtQm8QHhi24+X1rO+ngf8P3gzOstDorSmkO2luOVUedkyjd
 BHtw==
X-Gm-Message-State: AOJu0YyQ225SM9JV9GoBztMeTgMbgRbHVbdbmNa04MceguYP6wX2fpFB
 U3syr3+z9ZVDIDFS7qZPyKRepe5V8+Z6z2IeMR7z3j+1tAfhNGFDaGqY9uspXp0y+sQ=
X-Gm-Gg: AY/fxX6zIBXdx8GDZgSaQ4SgBDG2zzgO07keurQjvtMub7kw/FXRnBksVFhITdckuai
 HMBl2BQrV1X8c4TWN/uHl2UzI7hMOe60Ja7+pxVWvGR+AaYDWEsd05j8SdciP+oRr0IicWa/vCw
 i2tpoxUgOG9N5w15qRFVtbTwUOZY9UNB+yJH0+yv+mu99Y/D2GsQLUsbQGeLtUDDrY9UrDSpQAt
 nhEIW3xNyMRm/NDPgLuJDw74Z0Wl3EOQpJRqCpdsNI5430+1m2B4U4Zc7p+lZvTy/IneKTc4EfL
 DIj57G60YxDYMgK1G9KlEK7G7pmEZeE/mvU+HDm3jZl/v52DCY6NXyLQsvF0Y1cChBMrdA3ks8N
 y7coBBFB8IkP7IGiIAe+ML6U1sbvA6SA9hCpayVIq3FCMTLWV4NZbpid5Uao0aIJKTaVVLhSB6e
 a2gilpKKuFubkSLhC2A+pCA/rMwv7RkA==
X-Google-Smtp-Source: AGHT+IFSvu6rw+SEcO7SftsuFxTzkACt5CrEtn2hkvre946TzkZbYNI27oBY5lWkqu7XuomSyVhfdQ==
X-Received: by 2002:a05:6a00:4091:b0:7e8:4398:b365 with SMTP id
 d2e1a72fcca58-7ff6666fb6dmr8038243b3a.56.1766327003160; 
 Sun, 21 Dec 2025 06:23:23 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:22 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 00/10] HP-PARISC NCR710 SCSI Controller NetBSD issues
Date: Sun, 21 Dec 2025 19:53:07 +0530
Message-ID: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

In this patch series we fix NetBSD's issues raised in our
NCR710 SCSI Controller for the PA-RISC Machines.

The changes address multiple issues in the NCR710 emulation
that currently prevent proper operation under NetBSD such as:
- DMA flow control
- Interrupt handling
- Command completion
- Device state management

The changes have been tested on PARISC 715 machine running NetBSD.

I would appreciate review and feedback from the maintainers and the community
and would be happy follow up with revision.

I would be delighted if we could get this series merged for the upcoming
release of QEMU.

Thank you,
Soumyajyotii Ssarkar

Soumyajyotii Ssarkar (10):
  scsi:ncr710: Add null pointer checks
  scsi:ncr710: Fix use after free in command_complete
  scsi:ncr710: Fix interrupt related register handing
  scsi:ncr710: Fix DMA State machine and flow control
  scsi:ncr710: Fix table indirect addressing endianness
  scsi:ncr710:Mark command complete in status phase and fix disconnect
  scsi:ncr53c710: Add LUN scanning
  scsi:ncr710: Simplify disconnect handling
  scsi:ncr710: Fix DSA register
  scsi:ncr710: Fix CTEST FIFO status

 hw/scsi/ncr53c710.c | 93 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 23 deletions(-)

-- 
2.49.0


