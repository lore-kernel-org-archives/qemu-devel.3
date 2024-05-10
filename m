Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EBCC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5R1g-0003b6-6D; Fri, 10 May 2024 10:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s5R1Y-0003Z7-Vx; Fri, 10 May 2024 10:15:01 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s5R1W-0000eo-OR; Fri, 10 May 2024 10:15:00 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-36c809db200so9040325ab.3; 
 Fri, 10 May 2024 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715350495; x=1715955295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1bhJaZCbZyCInej4Z0OZbMCjYeYw3doeFenOCHnFI+0=;
 b=IagpLmuuciRlplSi1kvnz2Ok2G4K9KT4jpgwSFviw33ONroPL8qQY3qaaisK6IyuMT
 zNETG8yLGSpYIaY2jOk04Fcow2+FPuUfVtrB1YMe4OsVTOUij+uVKbrcuo8oYPO3IIvX
 oFfZn9MLOEcD7bY2enJUxevJ8c2aQHAkoqOMvxNAJCuDgyrNmvVFFv/vRQcBwXDoHitZ
 Vw2ukgjCxCuxQWJ2aKuTgqGdhrFKRD9OZkvQazMEjIToYztey16ywl8vInGQvR1aky0z
 4OY8xOBUUroAPwJnKe9+7L8WXEGo0FcxsTqxF1L5levAk7zbN6zIaPnNlNTOeVjUgIvY
 f8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715350495; x=1715955295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1bhJaZCbZyCInej4Z0OZbMCjYeYw3doeFenOCHnFI+0=;
 b=gicVqpBdeT+ulfmyi1LfgIFauridgUaCVokXI7IoCV69pT9SKMhQffdmlPHqO4qwnn
 w7vGwwlIMhGa9q4Un/j1hGuEhwysbe3eifo0SYJ+lnNWkaDY8Cev0c4sdFKiyMScb4J7
 0ew/tfJle1g2Cup9PEOraKs7hgd4xJVoRXbrUILyzyVxPKXSTrKdmABrs5/WDXBNHWrN
 RU4NJGSDaox9wrLBn9adij1R3FqRRGmKe25nVwVPZTSA53R+Icpvcys6GeQa3lfaD9qg
 lnOdNDjk1o3EfFI3O/BIpjqz2wKmWaYEotaw2mRZhA9QGQxEE4QQ4Xc79a8RdcH3Uf3H
 EB3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP0Nu/+I9eIlJwdyz3FdalYMH599+ak5k6M8uLvYZdxknmsOIKP3uYMNALd4Tu2ShhUs4npHTuQdwSAV4nlTqQL+3sI2c=
X-Gm-Message-State: AOJu0YzdOCQQ64t8Xm918ntC1UtryLrK+Jekkd7lDkhqcbOSpCWa/GOE
 qlH662cM5zO+PwMmF8wUOWkhtGTuaIHj5uNSo53owmmKUKN2WDS4viTotg==
X-Google-Smtp-Source: AGHT+IFnWkSv8WhGBpru4M1ioaQ4GwseACmwT0Vj+hdhNNT5aJMdYKACK2oGEV/fQYR/64oMOItXIw==
X-Received: by 2002:a05:6e02:20e8:b0:36c:4abf:8566 with SMTP id
 e9e14a558f8ab-36cc14e79bemr31564725ab.24.1715350495396; 
 Fri, 10 May 2024 07:14:55 -0700 (PDT)
Received: from wheely.local0.net (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340a632725sm2691453a12.12.2024.05.10.07.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:14:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v2 0/2] ppc/pnv: ADU model for POWER9/10
Date: Sat, 11 May 2024 00:14:43 +1000
Message-ID: <20240510141446.108360-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These patches adds the framework for a proper ADU model rather than
putting registers into the xscom default ops, and implements ADU's
indirect LPC access functionality which IBM's proprietary firmware
uses to provide consoles on UARTs.

Patch 1 should be quite a simple hooking up the xscom address space.

Patch 2 implements one of the memory access functions of the ADU that
drives access to LPC address space from XSCOM register operations which
is non-trivial but there are similar examples already in tree.

Since v1:
- Changed to GPL-2.0-or-later
- Added an assertion for adu-lpc link
- Renamed funcions to pnv_lpc_opb_ prefix rather than pnv_opb_lpc_
- Removed the unnecessary ADU class

Thanks,
Nick

Nicholas Piggin (2):
  ppc/pnv: Begin a more complete ADU LPC model for POWER9/10
  ppc/pnv: Implement ADU access to LPC space

 include/hw/ppc/pnv_adu.h   |  32 ++++++
 include/hw/ppc/pnv_chip.h  |   3 +
 include/hw/ppc/pnv_lpc.h   |   5 +
 include/hw/ppc/pnv_xscom.h |   6 ++
 hw/ppc/pnv.c               |  20 ++++
 hw/ppc/pnv_adu.c           | 206 +++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_lpc.c           |  12 +--
 hw/ppc/pnv_xscom.c         |   9 --
 hw/ppc/meson.build         |   1 +
 hw/ppc/trace-events        |   4 +
 10 files changed, 283 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/ppc/pnv_adu.h
 create mode 100644 hw/ppc/pnv_adu.c

-- 
2.43.0


