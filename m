Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF8FC2BA15
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhwN-0005Xz-G8; Thu, 13 Jun 2024 06:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHhwM-0005Us-FJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:44:22 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHhwK-0003iZ-Sf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:44:22 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a68b41ef3f6so109437366b.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718275459; x=1718880259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qRLh0D8mR2uyrOlBcIm36j/EyX8jLTkYN1gTQ4ipRB0=;
 b=agOdUpbpBYid7+f8mMnFjGLDlYF/v8z8/OWl4xysoUH1ukmb+2X9gYPBgAWcyICNWQ
 w4Q9MxRQq86AdDAwh2sQDHuURAWHqpSZxfk3fDNhuZ9DD3SDdhh0MtSkgDfwF35eVAAq
 NErbelqYk6HNRgqdlyyBBsCwjt0/flPiqxgzGV4+eis5RIOA1eydPCaRERFjjEa2N9t8
 1irdjAabuB0IQn3Q8uFGSGz5DUxwJItdERjVH4MuFHALCamdCH/wMNN3Qvhk9PC602j4
 FSpJecVxYap98/9gI67hGjjm8BUxh89gexaCg0/4/41B6JFsLpsjGcMHIJuX3TDWUNJ5
 sGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718275459; x=1718880259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qRLh0D8mR2uyrOlBcIm36j/EyX8jLTkYN1gTQ4ipRB0=;
 b=FqdPbydCC4LwX+UbIwmvGHyr6SVCaj/X0VvNtS7TrbnQxtVtuJJ72zU5pVdWm3QvRJ
 u2/72zWblePkfXT/G43ETzCwhLtPI8weOVdUhV7RcvwT5lYS94JbNbmTCAEQwCb+xvMW
 qlYK81npNMkhk8KOEXc+HN8XrEKUFIlRv7h6onziYHg/BboT6q4sb09o8FHfVtmYjd/1
 UGKkrwHVRRax7flgT8EtoE11yMMO46gF3fkj+qcav+VzMDbcFMOf2dGeIrWL93CMj0sy
 rfYJ8Uj5fvX8UI/bU3W5Q1EzQCXv55OM3ULQUZpHyQKvvb6+VwVVOfLckwpceYlp/9FT
 5vnQ==
X-Gm-Message-State: AOJu0YxAxu19DPprgUAu/I1pkG+tQ85Pb33TyZJICF0gRRGM2V610VV2
 b7YA21WBvxQQ2CXxvLJesmMibQYevx0I09Q3eXhYmGXIZi0hods+P7qMxUWF1jk+LU0fDSfYTgQ
 N
X-Google-Smtp-Source: AGHT+IGcrAHdvrGfEMjV1/OqSQV26HiBFue6XJ4xmZ4x4TkzcEbCQ6Ez1yP62BL9BR92XjUrwvAhzA==
X-Received: by 2002:a17:906:f813:b0:a6f:507a:b101 with SMTP id
 a640c23a62f3a-a6f507ab193mr177111166b.6.1718275458886; 
 Thu, 13 Jun 2024 03:44:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f431besm58096366b.187.2024.06.13.03.44.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Jun 2024 03:44:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] target/s390x: Fix tracing header path in TCG
 mem_helper.c
Date: Thu, 13 Jun 2024 12:44:13 +0200
Message-ID: <20240613104415.9643-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to keep trace event headers local to their
directory, introduce s390_skeys_get/s390_skeys_set
helpers, fixing:

  In file included from ../../target/s390x/tcg/mem_helper.c:33:
  ../../target/s390x/tcg/trace.h:1:10: fatal error: 'trace/trace-target_s390x_tcg.h' file not found
  #include "trace/trace-target_s390x_tcg.h"
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1 error generated.
  ninja: build stopped: subcommand failed.

Philippe Mathieu-Daudé (2):
  hw/s390x: Introduce s390_skeys_get|set() helpers
  target/s390x: Use s390_skeys_get|set() helper

 include/hw/s390x/storage-keys.h | 10 ++++++++++
 hw/s390x/s390-skeys.c           | 27 +++++++++++++++++++++++++++
 target/s390x/mmu_helper.c       | 11 ++---------
 target/s390x/tcg/mem_helper.c   | 16 ++++------------
 hw/s390x/trace-events           |  4 ++++
 target/s390x/trace-events       |  4 ----
 6 files changed, 47 insertions(+), 25 deletions(-)

-- 
2.41.0


