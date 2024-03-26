Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577FFC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 06:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp0Xd-0004UW-J5; Tue, 26 Mar 2024 02:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rp0Xb-0004UH-Gp
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:44:11 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rp0XZ-0004Xc-Ul
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:44:11 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5a485724ddaso3039146eaf.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711435448; x=1712040248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K0LoU2XIGF9CWsv9t/CK6nInyNKA5xZmNw5rV3g1nsc=;
 b=jnXoTivcxA5aB0JfBqIOivrS6cheHC1ukvx/iZcEl1jL+bFHwxd9hLzfkNxbT65JcG
 F477NhcPihjOUE0Us0UCXRYV6WvzQsBfHhpAtSroubPkG+Tnzjn11wzvtGSdvljAULiE
 w3Fd8fPi1ScXAfFY5LkqOTOnr+IMeqVbjapGAYyFf8w1bzsONqzeXRWBMf6OEXhXLK8C
 QIcANbK/FhFUOQSfdsVI8QuiNEgJ4BvvwH63Fr9TuqwZ26KgNkCbTeYKLzKETGtaUoFl
 +QgRZjP6etzW1EUUthSD1h/kJyTi4mnxGDZbqxAUqC9vXmpbPpQvO51Mw+uhbjLzwqP5
 KBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711435448; x=1712040248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K0LoU2XIGF9CWsv9t/CK6nInyNKA5xZmNw5rV3g1nsc=;
 b=ktceJIGQNXYWcl5mI6+uGcFsuBSDomfW5PV6Zti2SKT7r7bExb1jpzfvyILao5ncI2
 3RD0G06IgHbi1fIujlxnBtAOdv0yNN/G9U2/Jbo8y+3/1WyT2fJV68Npt71nTJQGQdX6
 UnaQb2dCDRz91EnCdmjGfYh+FVsLQl4M+Xe/HpjpIWbygz5om8fX7SwOm0bpFsrdk/IE
 JYXtAMv+kMKNqY6pp2ppeGsyNp4e9mOHiUQ3KbfznyAXKVank29Vb+v+kjr2W/pMhJ2E
 JgDAmNwt8RgG/0QxUTpGZoZ/1oqdoc2POClbXn7nai5oV3n0WJLS2DTQnFX5ujKc65Yh
 OAQg==
X-Gm-Message-State: AOJu0YzC6Sij/FfMYyaldTVxDeLG+/JYfqHLoFBUZ6CLuJ6VfKCyX2RS
 3BgRrtE022dnGgVMiNroUxE0W7BIDi7ab8H3byRJ4/hgHg+Zh3PZts4slNol3EnXHQnwEdCTA3y
 v
X-Google-Smtp-Source: AGHT+IGwne1XKHNz9HwSlqhHpNGzG3uczmRaqp4cNywKMaFBzewjpnlvpIttCuMbH9hd/9fasUtzQQ==
X-Received: by 2002:a05:6358:59a7:b0:181:65ae:874c with SMTP id
 c39-20020a05635859a700b0018165ae874cmr175400rwf.8.1711435448487; 
 Mon, 25 Mar 2024 23:44:08 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a633503000000b005dc36761ad1sm6958819pga.33.2024.03.25.23.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 23:44:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH for-9.0 0/3] target/hppa: Fix overflow computation for shladd
Date: Mon, 25 Mar 2024 20:44:02 -1000
Message-Id: <20240326064405.320551-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

These ??? notes have been there since day one.
This fixes l2diag test 59.


r~


Richard Henderson (3):
  target/hppa: Squash d for pa1.x during decode
  target/hppa: Replace c with uv in do_cond
  target/hppa: Fix overflow computation for shladd

 target/hppa/insns.decode |  20 ++++--
 target/hppa/translate.c  | 135 ++++++++++++++++++++++++++-------------
 2 files changed, 104 insertions(+), 51 deletions(-)

-- 
2.34.1


