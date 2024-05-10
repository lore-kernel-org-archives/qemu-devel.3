Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDD0C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NoT-00019F-7n; Fri, 10 May 2024 06:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NoR-00017k-KP
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NoP-0001T3-Qq
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ffso10387365e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338152; x=1715942952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cZjM77xwKEbJpKmLT3A1NDbHI9hBidp1PDA51BLQSpY=;
 b=hjE/wIYWUhneWovl2gClxrYF0lU7iScjn+HnlmN311WO2QWzaFbs+fLR9ezrLHD+Z7
 8fluLeqKn5Vkvg53SQINkLh6gcNmKLM09djswq8ZeNBK6Ukqc8sTk29R+yrEcx8xWXNv
 CWr/41WZTS4YohyE/V7yWPlkB1gCYiI65uJLVoQCi3DGYHOLULowtneE437MqhLSc9e5
 jLf4cMU2n+EQAlSN9iqKLAY05W8FgvympyJTMbNbnXhebIaTMOOPPlwid8wIdrwA/ERY
 C/XV3MLbpcisK/xf/9Dg8hL6fLuJmQVY9CT9g/lQ/haWFKsYMXtAjmpsSyOzA8Bq8lK7
 bHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338152; x=1715942952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cZjM77xwKEbJpKmLT3A1NDbHI9hBidp1PDA51BLQSpY=;
 b=w9AczoFAGvpDEsnekJbxxqjXyczVqVVNghwwvCv0ooieEAYcGI8x+nosUs07JllM0G
 pa3OiM/s+FOCaRJ9kUMrv2PTmDHJKd4rKl6vvIcpExhLWYv3OudUmC3A021Ymaofq272
 DcN/kXhhvGYezpAjzSbH5X+5W4q9Yo7EU3Bv9xsvt4OTc04uTCSHnRAGOznaAN7noeqp
 eQTXnpS9v0j5mAcMVe5m4b8yVJJ4GMJ0BDt52bHPdr3QKPG8yDUMWQFdsVvANojlg9SS
 4qQvkFwtoSPdcVwV/qXWPx+eMKR7VjqJ9KOO8BpdmjLkTtYJlMXPdBs+SEIoDN/Pk5Pl
 4MtQ==
X-Gm-Message-State: AOJu0YwmSMuOcrBaecYhI9X0k1rcW25k7vKxPCrKBdbLnEW/b/3DSYnM
 +Mku5r6/mBaxDeKXEMidiFtD6bii3ibLeZQsfjkba8a5Ckkue5gR5KCafgsoan5Ned0lzPZ7mUk
 X
X-Google-Smtp-Source: AGHT+IH46uVuTTAQ+BBftsxQmGw9P4+zW2TPR3t6Wdb1Buyly/dSLdeEPF5bm3XgUtGobYA/S4G4qg==
X-Received: by 2002:a05:600c:450b:b0:41a:7c1d:3326 with SMTP id
 5b1f17b1804b1-41feaa30479mr20356075e9.8.1715338151876; 
 Fri, 10 May 2024 03:49:11 -0700 (PDT)
Received: from m1x-phil.lan (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87b2648fsm94463915e9.7.2024.05.10.03.49.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 May 2024 03:49:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] hw/xen: Simplify legacy backends handling
Date: Fri, 10 May 2024 12:49:01 +0200
Message-ID: <20240510104908.76908-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Respin of Paolo's Xen patches from
https://lore.kernel.org/qemu-devel/20240509170044.190795-1-pbonzini@redhat.com/
rebased on one of my cleanup branches making backend
structures const. Treat xenfb as other backends.

Paolo Bonzini (2):
  hw/xen: initialize legacy backends from xen_bus_init()
  hw/xen: register legacy backends via xen_backend_init

Philippe Mathieu-Daudé (5):
  hw/xen: Remove declarations left over in 'xen-legacy-backend.h'
  hw/xen: Constify XenLegacyDevice::XenDevOps
  hw/xen: Constify xenstore_be::XenDevOps
  hw/xen: Make XenDevOps structures const
  hw/xen: Register framebuffer backend via xen_backend_init()

 include/hw/xen/xen-legacy-backend.h | 15 +--------------
 include/hw/xen/xen_pvdev.h          |  3 +--
 hw/9pfs/xen-9p-backend.c            |  8 +++++++-
 hw/display/xenfb.c                  | 15 +++++++++++++--
 hw/i386/pc.c                        |  1 -
 hw/usb/xen-usb.c                    | 14 ++++----------
 hw/xen/xen-bus.c                    |  4 ++++
 hw/xen/xen-hvm-common.c             |  2 --
 hw/xen/xen-legacy-backend.c         | 24 ++++--------------------
 hw/xenpv/xen_machine_pv.c           |  7 +------
 10 files changed, 35 insertions(+), 58 deletions(-)

-- 
2.41.0


