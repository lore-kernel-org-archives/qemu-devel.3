Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B58C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHO-0002XK-E5; Fri, 26 Jan 2024 09:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHL-0002RO-J4
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:59 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHJ-0007z3-St
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:59 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-510218ab26fso724719e87.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279636; x=1706884436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CbytbZE5r6VKI1aTBZEBghdNkVDSmRfkbInRbv2Plj8=;
 b=ZqeJ10taPdCjvez4CdoAUJCaxLsAXocrTWkQJQP/bw+L6l1WZpQHqOzzauTL/HgCfH
 NSMRt7OnyYGn2OJf0xZN1KZxB7Ac3k+RqyJlbIS9Vq3AnUatSO9Yr4Ka0C7+dfkBEb3Q
 U9kqHop0YtnZKhdJF8kSrTzoZ3cM/1qnJN/bGWh8RjvLyyfSySOiXCE272L0BNNQLK0+
 YRaDa+fTZ3l52EbrNqDdNtDYJYajvEoeEkKIQTX1OQDwxrL/LriWCYqLDBmTnrIG3iAX
 7AeHBmxOXKrkhRAl/1UTotIcXLDJoeDPCPlVSL4wMOl091/Ui4w0ZuFUKei/7f2NA1hb
 HqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279636; x=1706884436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CbytbZE5r6VKI1aTBZEBghdNkVDSmRfkbInRbv2Plj8=;
 b=a+bFUpDtXpH1frAxV2iyHAYwa9ASJoRI+i7+PEJA2ERoVm1TYVjljmjE25lYBsavNr
 mPl64RprL4tZz6MkTzjqo1nTohKPZoj7lmor75lSvWHakOE+YUOSqdUNx/dadwbI9uSx
 WA5zRM4t4iLJ2Dyu1rJLVsqpeS2Q39g09GX8JSq+561tVIx/BV93COpHlOcK5RqYsSdZ
 0xCmFM9sqpZZ5PHR5GvKlnMItT8LgvN8MW8B6Yks93LJi3R/XexgL4KFl6IBnCenCnaW
 ahtPcSLUiDfugeRomuu1BauwQDgQ7C7lvohVm+XjxS7Y2NgvxIYidIudTIacAsPifZmV
 VLaw==
X-Gm-Message-State: AOJu0YwMDp8SsXqjnKtZ8kKIa/9Zux11/jr3JGot1AfXpSutzdnACFkJ
 ucruZvTEGjJ9Z0QxyiHja9xeovmX6P/LSdtQP9yS95HWiP5BMf4YXMomOSRfHGckxf+ogDbfkhq
 2
X-Google-Smtp-Source: AGHT+IHN/1J38rMpghWDj72Ez7d93GxehQXOJaTPrsZp17r7QncdV8Q8+J8HQigE0ahunrOaTcphbQ==
X-Received: by 2002:ac2:59da:0:b0:510:c20:74a9 with SMTP id
 x26-20020ac259da000000b005100c2074a9mr1820442lfn.64.1706279636312; 
 Fri, 26 Jan 2024 06:33:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/36] docs/system/arm/virt.rst: Add note on CPU features off
 by default
Date: Fri, 26 Jan 2024 14:33:36 +0000
Message-Id: <20240126143341.2101237-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add a note on CPU features that are off by default in `virt` machines.
Some CPU features will remain off even if a CPU-capable CPU (e.g.,
`-cpu max`) is selected because they require support in both the CPU
itself and in the wider system. Therefore, the user, besides selecting a
CPU that supports such features, must also turn on the feature using a
machine option.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240122211215.95073-1-gustavo.romero@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index c245c52b7ac..26fcba00b76 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -69,6 +69,19 @@ Supported guest CPU types:
 Note that the default is ``cortex-a15``, so for an AArch64 guest you must
 specify a CPU type.
 
+Also, please note that passing ``max`` CPU (i.e. ``-cpu max``) won't
+enable all the CPU features for a given ``virt`` machine. Where a CPU
+architectural feature requires support in both the CPU itself and in the
+wider system (e.g. the MTE feature), it may not be enabled by default,
+but instead requires a machine option to enable it.
+
+For example, MTE support must be enabled with ``-machine virt,mte=on``,
+as well as by selecting an MTE-capable CPU (e.g., ``max``) with the
+``-cpu`` option.
+
+See the machine-specific options below, or check them for a given machine
+by passing the ``help`` suboption, like: ``-machine virt-9.0,help``.
+
 Graphics output is available, but unlike the x86 PC machine types
 there is no default display device enabled: you should select one from
 the Display devices section of "-device help". The recommended option
-- 
2.34.1


