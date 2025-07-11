Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AD1C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 02:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua37T-0004U9-0b; Thu, 10 Jul 2025 22:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ua373-0004OM-3g
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:03:45 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ua370-0001yC-JO
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:03:44 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4a9e7c12decso18739861cf.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752199420; x=1752804220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FbgRniIUsawu1x7CAjWQ5r9GqoSPD/4xyyFuPkEZ57o=;
 b=Vv5BlawsD95yR8k4qlKz0DMdyJrJUdJoY0C6nZrI6d/PgUnMz/T2nK/uOKKcR5PUT0
 TTccPOVqcuX7C+OQ1al6lfaocrQ+Cttd6NzJvI6hnS9KdCVTv0IWctnvJ5QmupNfilL0
 MFN5IBnbheW7R/Z5r4XldT4VuncpGmYV5L+W9Soq8P9cfCDcvThezACjnpjUjVFuGHCs
 pq+lbyaZ0ZTptCJuCflhdTOuTMbQfGRP5m+ovbdJ8sgS7QIjI+Pxd299T9VmJh6XE+0+
 PuuMyX+74lvOC2vPkIcoX2DSaahwpgk9x6gmxkiTZTMSJWSyuA8KgBO9kn+0KY0yY1Hh
 BBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752199420; x=1752804220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FbgRniIUsawu1x7CAjWQ5r9GqoSPD/4xyyFuPkEZ57o=;
 b=d7FAAWSqgKAZ121AidnWW1WmEdyN9wTJ2IKz56u1GTlyb6Q6tF+AIC6MY5ODRJKByz
 7W6nUvSpUpyMlHU/Qvgao4YO+VwpXzt9GcYnZ+ExCd7Zqkx9aG7R+57B7j/qLWrv3JFT
 U43rodTy1qfVTw4cpPlAkd7CUrOcoVB1MiVUnmnDvFXrJijVaO78fpGXytttKzme5xNb
 2AV/p9n8UgdQzdonfs65/IfllVlo2wxQIyemYZEg60jqS7i9Z9ju/DtjBg3kdfcTT5nB
 KGt5clzt/4bpmFCZ1gW0Ne2wbENMm/Pqep+uXUYzfktIF0mn4XMR1j2KyhtXZYzm+oB2
 EDeg==
X-Gm-Message-State: AOJu0YwGBXj9N0fFAGZ6m00Ri2c0MyHkEL6pfic+jjBqN8W6TMLuxVBw
 Q29DwGW38HuA+q6HuwXichIy5GRe6vVbhydDK+Fu0Da4aMZ4QofakHACWZsi0Q==
X-Gm-Gg: ASbGncsaTBjkhY6Pi/UX6HsFYLikmUNHG2hGLFBfUSXidTq/zYtGx2TSthMUPhgns/a
 wW7f45HSRBCl6cSWKRALPZMPi8a9wNwBoM24v+WsnQg1SajC0O+c7vGg/XsavcwQTI752FfWh8/
 rMWY7h2ZkGRS+OcmIrS5UgqXA7qITisCEDw+ay2JlhRjSiEVrxyJtHWi8ruY+zJ0s87Th/nD4El
 8XGHCQZeYGgNhpIt5pCuaF3l9dFPi3AO41+2PTGgWzHu8n2ASI1sJ27qFH0+aTCN+ApPor0f3kD
 Zt2JHuMtB2D8cf+yaTMukzY/H29XUqXv/eC6jjTIas2jcMnQzOUVuQ4s9MROjzBKMmZUr7VeQBS
 /GNO7y/DXHNNPeThDC1pZxNvho7XoVPd0Sbwhm9zWociANYJj0fxWcIInRA==
X-Google-Smtp-Source: AGHT+IFr5nce2iJvdrlkr3DD/R1nUKxoo/AJkWRVwxMQSi2iDHrOVG1PDwltuNdQ7PmwGenFZSD10A==
X-Received: by 2002:ac8:7f15:0:b0:4a3:96b7:2a73 with SMTP id
 d75a77b69052e-4a9fb887046mr30183341cf.16.1752199419664; 
 Thu, 10 Jul 2025 19:03:39 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51f:a700:7eb2:b315:2597:18f1])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9ede76d41sm16125761cf.48.2025.07.10.19.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 19:03:39 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 0/2] MAX78000: documentation and test
Date: Thu, 10 Jul 2025 22:03:36 -0400
Message-Id: <20250711020338.586222-1-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x831.google.com
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

Adds .rST documentation and a functional test for the MAX78000FTHR machine
as requested by Peter Maydell.

Jackson Donaldson (2):
  docs/system: arm: Add max78000 board description
  tests/functional: Add a test for the MAX78000 arm machine

 docs/system/arm/max78000.rst              | 35 +++++++++++++++++
 tests/functional/meson.build              |  1 +
 tests/functional/test_arm_max78000fthr.py | 48 +++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 docs/system/arm/max78000.rst
 create mode 100755 tests/functional/test_arm_max78000fthr.py

-- 
2.34.1


