Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C7CC5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjANT-0000HH-Nn; Wed, 28 Aug 2024 00:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sjANS-0000Gm-8F
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:33:50 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sjANQ-0002d1-09
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:33:49 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-202508cb8ebso42440995ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724819626; x=1725424426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UTlWHwcLfslY4DpgUo4rcjdfFTKnTpEWhLuFnvyTLrM=;
 b=UQuiRf6RLRQZcdhZrlHkPnL8bEawYBEvR4yKxoPX3pWoktGfgY/j/HzDhaowaI7EXk
 sHO3E98FahwIxs57+Z8oy7q2axIyA/P0FZU1wTbSUvk6PBVZ65BIQcQkbEIusn35w/99
 BX3nATZQ+JOIjt5op/yU3MlugGa/RG70T8xcO5vHnb1T+IJlobAA2sXJ0/HyJwoiu60P
 KGPBwyjtXPtLtaKyixzorQafhgsnrTbikuLKZU3ZY7T28Lz0BIE2w7YiXkQf2LDDS5Sp
 tXhM9iL9Nqh0so7qUFFijz3IMGcT/vsdgBv+tJySWXo5X0T0p3WAW6P+xkFCIH/d3oOZ
 lR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724819626; x=1725424426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTlWHwcLfslY4DpgUo4rcjdfFTKnTpEWhLuFnvyTLrM=;
 b=CyOcRpn8QM/4RBEkcy5FGAQoXF1KOzBUo3VRhbpDUD2leq+jvpZsugyIJoclIho2Og
 TQsrxWJ++nLDlwNAsdEmx/2OP/aD/iZRGvADjZgNIk+AHXT5T6KMbaSnNoc3R/4JbGJa
 koOLfmP1HfrXK4zaDHDjC/ViHtfWdjtAYAuVbOAdmchcMll9hjclqk2T9UObDXL/LROT
 OXAsHn1uVbvb/JFzN3o8znvBVvOmkKjA/0v0JV/OhxDu14hs6XZ8hr2394f4fEOJ9UhE
 vpF0OQyAIEd0yakwO2jlkoMoVg5awdNuq0qb/hfWZzQMZQlC8U/Jkzzh7ijArVnHoDvV
 kUPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKsxE4FOlwCIZS2wlR+RwHTMYnMy2KS8QkjNE8C0y/0Gh1ga2eA4Zbd1kNsrCFmThIsooeV8f4bWWq@nongnu.org
X-Gm-Message-State: AOJu0YxJYH3+SdE6vd6Ho1FFQy8XfpdYo40gC0lQc0ZYA0+Vm5z3PTc+
 Nf5r4mGQaJlyn5g5nN2ZnewZh0+rbqvHL2OBrHcIm7SJLrCRHZq3
X-Google-Smtp-Source: AGHT+IH0r0f4aZkVXkRBONZ+FBjyxnIQmW4a4Z7hGKQdeBbgH/bwLenALP36SBFGeyJGRzx137kg7w==
X-Received: by 2002:a17:903:1245:b0:1fc:568d:5f05 with SMTP id
 d9443c01a7336-204f9a60dc9mr11972735ad.8.1724819625964; 
 Tue, 27 Aug 2024 21:33:45 -0700 (PDT)
Received: from wheely.local0.net ([1.146.81.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038557f093sm90342325ad.63.2024.08.27.21.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:33:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] chardev: fixes for recent record/replay on muxed
Date: Wed, 28 Aug 2024 14:33:33 +1000
Message-ID: <20240828043337.14587-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fix a couple of issues that Peter found with recent record/replay
fix for muxed device.

Thanks,
Nick

Nicholas Piggin (2):
  chardev: Fix record/replay error path NULL deref in device creation
  chardev: Remove __-prefixed names

 chardev/char.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.45.2


