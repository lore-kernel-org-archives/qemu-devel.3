Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D25C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Uw-0006WS-SM; Tue, 12 Mar 2024 13:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Th-0004r5-36; Tue, 12 Mar 2024 12:59:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tf-00080f-Lx; Tue, 12 Mar 2024 12:59:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6ac00616cso651183b3a.0; 
 Tue, 12 Mar 2024 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262786; x=1710867586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RR4P414fAdBrmZ13qWAjaQrr8Q0qRPrUxoYoLYFQP4Y=;
 b=CWdsxo4P4KMjjJJgIPWsDWgzaVz3FYUdnL6fccBl/yqVT/EhmvNrKVPMylmBF0ZHNh
 lmzBsKt60VWc87WaRoTuFbl5iy0mmJpJ1MPNio/zcEwvYu4K3kWoVV1M/Jr8oRdVhiMg
 nTs0qPQv7DHwPmOKboBQbRsPKSX6dejQ3dv2H2jBm3p3EkeWwWE1LRMPtuILmpth4H1Z
 wOBo7dzeCSeh6uZZFT8z0WfCva45fcoLSJWI/ckmOysMIlbbLtfADJ+X4WdYLe+VP7tz
 OEfA9fVdGEoTN1T+/6EQ7fC/t83xV2s3YM8IgWJwoXlrWmkVSBvK0NuMCzxT+SAFJ4xT
 R29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262786; x=1710867586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RR4P414fAdBrmZ13qWAjaQrr8Q0qRPrUxoYoLYFQP4Y=;
 b=FD0WLs1H3oFSqWqLR4w7hVwYBVJoxMnwNf/vF8fyg/SyJRq6iKSS4ZtrBCAX5vkk7v
 9GaeroHE7o0Q1jFXkKXN+51cgZ8Goee51RksA9lgDjKb1YIw8fUH8xv1nLbe7m7VaUxk
 S7ZMfztzUNyb0Eoto1KzmuQrA/cfuoI4sgD3K/ld7BwlWJTDVXrbEKSF57EKHd5dbdae
 vhqM5+jN/priknKbODjL+O7Gmg9qjPL+b+7AeK4RZc5ycLelCbUUvFH0a1KOkKM0jCt5
 WSFxeMjMDcnABs+5Yq+Nn9ZUa9PMqUj2/RaDNpTw/NQBeujk08tFBt8zf607BkBF/Cju
 QRMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB2bvz2xw6xm+edzqLJfePjuUG8BaIp9+nChKnBY4MRwhnyplvv+MfSWF9wBBsqzygMfEuZAr0YsNqXbizHviipxvr
X-Gm-Message-State: AOJu0YyeUvnY0kS7IxLkhQX9SJhBICuVA2ZiAyUv8Bpev3PDQP71QwOR
 9VIE7rE5i5p6ykDV5LCe3KJlbAvbHt+9on4h+fBbrniBeH5RIxJ+uTKydtOC95Y=
X-Google-Smtp-Source: AGHT+IF+oq9z/eloDRaOHluE8HjeVBydTbPXJSa4y/gGhkG92aTj2q8M68vn8dHitimbZ47Aukzzhw==
X-Received: by 2002:a05:6a20:d807:b0:1a3:18be:9b18 with SMTP id
 iv7-20020a056a20d80700b001a318be9b18mr6155005pzb.26.1710262785750; 
 Tue, 12 Mar 2024 09:59:45 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 12/38] MAINTAINERS: Remove myself as reviewer from PPC
Date: Wed, 13 Mar 2024 02:58:23 +1000
Message-ID: <20240312165851.2240242-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Cédric Le Goater <clg@kaod.org>

PPC maintainership has been a side activity for the last 2 years and
it is time to let go some of it now that Nick has taken over.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0087e4f1c7..fe8a7454ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -316,7 +316,6 @@ F: tests/tcg/openrisc/
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 M: Daniel Henrique Barboza <danielhb413@gmail.com>
-R: Cédric Le Goater <clg@kaod.org>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
@@ -468,7 +467,6 @@ F: target/mips/sysemu/
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Daniel Henrique Barboza <danielhb413@gmail.com>
-R: Cédric Le Goater <clg@kaod.org>
 S: Odd Fixes
 F: target/ppc/kvm.c
 
@@ -1508,7 +1506,6 @@ F: tests/avocado/ppc_prep_40p.py
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Daniel Henrique Barboza <danielhb413@gmail.com>
-R: Cédric Le Goater <clg@kaod.org>
 R: David Gibson <david@gibson.dropbear.id.au>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.42.0


