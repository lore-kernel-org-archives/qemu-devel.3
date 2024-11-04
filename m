Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8552D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ksr-0002Rf-6L; Sun, 03 Nov 2024 19:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ksG-0001h8-J2; Sun, 03 Nov 2024 19:23:17 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ksF-0002rm-5f; Sun, 03 Nov 2024 19:23:16 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cd76c513cso27134195ad.3; 
 Sun, 03 Nov 2024 16:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679792; x=1731284592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeqjtniyFe+naXM0wN5zvD9S7mKNuzwkdgW2O7zUpxg=;
 b=GSgl8X4S9O+cpNGiu4GIm9OhD2H6X8THT230gg0UfYQntNRtZlP6/KfGJO8yx1qFum
 BF0W8KPnP9qAO2sLM8UzYQDl0XodTIC9Mtp6bdawAdlbgpJHYOQ2eMCWvFw/5CaLN04j
 Qz26Rsrw5rshvRtBEc1Rz+T6OMArsTDbsyRfHhy/u2pNBtjXAQghBPhGEK6LFXc6u6YM
 Z0feeCFe+gQcar5UjCBOam1Qd7/uac8YiGGmMBYKSwrSQbDMMHoiebRIYkPb659EMNld
 SCLBESxtMY+Niz5gc8VTrqZJQEqleTkp48Q/BBzUPPyvsPDt3+2LyHnvPx95rBbWFFud
 e1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679792; x=1731284592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NeqjtniyFe+naXM0wN5zvD9S7mKNuzwkdgW2O7zUpxg=;
 b=p2m5Q6m8I8fQGusj0JzLKLmXNxcL6FIptEpp0cvmVd5qw43/fBj/d+40sxg4NnJJn2
 w1CJ47kpMLV+Y9vrwrrsN7mTe2IS5uSWvuZr3g+kJYRAMdMP/b0FdPJyHeSaRU53VcmV
 iGshEaSl5mghbYEGClxnOM2wePXJRhZRqxvR2Iz5A5Ovogw1nqA/TLzC7q0ChIu+xWxx
 ii1vERP0XVQnLjbVInpEk3+WAsLvVSk8m/m2RQDO5HS6eR+WYfrXayOBOVfzwdWPj3wa
 i1KoqcM66WDC75jEiftmEzn6QQlCcARZmxUv0BXSGIXtC+xFM6hYZLLTMwNFksz3kiOD
 4eVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJDbmDFxRuwh2y+ui4CcM8x5/22miBZ5kRAKPJTDHBLkRLulg1U/gbYMNHnDI1bsxORX+A7VYnIA==@nongnu.org
X-Gm-Message-State: AOJu0YyjXtgGAVO7omOWtC9M2mS7YaYpY3bBT/ekY6QcoJ0nPu4z0Lrl
 gO68Hyn2uF/ENRx7D/tPrBPgMoZGE7M1QAKUOHYcgpLKGBUmYnlZwUhj/w==
X-Google-Smtp-Source: AGHT+IEtBE06YU7PZoGPaNAsB65o7X9omExtWF2/sRQQigapfkdHtn8lnVaQijgwcH3mOmG6sGKVtQ==
X-Received: by 2002:a17:903:124d:b0:20c:b9ca:c12d with SMTP id
 d9443c01a7336-210f76d685fmr254347285ad.38.1730679791692; 
 Sun, 03 Nov 2024 16:23:11 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:23:11 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 67/67] MAINTAINERS: Remove myself as reviewer
Date: Mon,  4 Nov 2024 10:18:56 +1000
Message-ID: <20241104001900.682660-68-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

From: David Gibson <david@gibson.dropbear.id.au>

I've now well and truly moved on from ppc and qemu maintenance.  I'm
occupied with other things and am pretty much just ignoring mails on these
topics I'm CCed on.  Time to remove myself.

I'm still listed as a reviewer for Device Tree, I'll keep this for now,
since I do have some interest and it's lower volume.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 840eebc944..a4ad10226f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1471,7 +1471,6 @@ F: tests/functional/test_ppc_40p.py
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Daniel Henrique Barboza <danielhb413@gmail.com>
-R: David Gibson <david@gibson.dropbear.id.au>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
@@ -1562,7 +1561,6 @@ F: tests/functional/test_ppc_amiga.py
 
 Virtual Open Firmware (VOF)
 M: Alexey Kardashevskiy <aik@ozlabs.ru>
-R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/spapr_vof*
-- 
2.45.2


