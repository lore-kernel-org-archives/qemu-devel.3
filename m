Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA82BCD11DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMb-0004YD-Go; Mon, 25 Mar 2024 06:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vE4BZggKCpUHBDHIz4z5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--smostafa.bounces.google.com>)
 id 1rohMa-0004WD-1q
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:32 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vE4BZggKCpUHBDHIz4z5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--smostafa.bounces.google.com>)
 id 1rohMW-0004dz-Ng
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:31 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-60a54004e9fso76352487b3.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361724; x=1711966524; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pgj4os1SqHzkjhNT3JzTDAWYrp8eBAK4lfJx+p+vw/w=;
 b=Rw8dRiIo1k36AfoecRTpNd+Nbr5jHycuip6r6StDDBg7/j+RbhxNIKx6WlWFQKvt5d
 R7Yq75rJ26pajPGRyhMRT1+pYNt9iA1xwCgkLlDtomEMNNfgkXHJl8vkZ2LAGwJXHsfT
 etduGZCynANIeG7xQt89cPfLk/nY20oYasybBgndQclRhLYPTOh5VAlcUGEB6F9qfEOf
 lT2tApqoXm1KZLa7BdHoJLc83zRJgYk2hTzk6tP6ML3cNGMcECNr7n/+8mGdO0YInCWS
 /fYjfmbkb+kA7dQhfdQ9Yyzpxbs8xCeCX3iVibptXMCK0JWKclftcff6tRPs2YuR6sfZ
 a/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361724; x=1711966524;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pgj4os1SqHzkjhNT3JzTDAWYrp8eBAK4lfJx+p+vw/w=;
 b=G8+A0uXX9S8zbJZPXxwYy0ZzjTSrCgxD0lFiWDWSB3k4ZKVzCdxnEWEnhtijfkRFjB
 AZh6iEpiggIlNk0TjsVir6xyfa2NRt76Es8ba658ehpS4jdmCR3aikHt3sQgyw/gMPej
 1n95znHQ0d1ZvCVJ4bUPwLmrYw8O3qba0Gfw/mbWvxHkRrKUDiRwyA6MFmP8VWrKo5PO
 QFlNdL9gW3BIaG5c/wKmSdTecXh3tgMBlYaJ7Av3hdWrP/MGl/bXFPXrn+RARKSa07Lh
 jyxS7/8uI94FlqYkgpFpCpF8lRbr5y5gUTdYAxzPG46iS85QAmRCp+y3Q+B9J/HCNtxe
 8BZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcGrLBKK3JVv98uHyt8/I9Qbj5Tou1FwaaZ/gFoB8Lqcpr7K4Ti9PqLbrjOPSTSaEUSxUhXNbsvBQISVN4V1JMf519t/Y=
X-Gm-Message-State: AOJu0Yz4fuAsl0ulU13zoE4AL7kA5oTiiYV5iKszLefOXGjSgGymi7m5
 z9uoFOaPH/zGW8LMs9L5nge75bdgfCA8GqYS9anLUM0ziTDM+dgNLZKHLYIS1M0T2M/Zd+8DRfZ
 i6pzwPWiI6g==
X-Google-Smtp-Source: AGHT+IGeoxZ4yGEl/vm/NkDRjH551nWZHf5000vrg0V+z0lFm2Vja1vkx62O+nhZvbHtxs0E0r6mzR2+Ic5pCA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:100a:b0:dc6:ff2b:7e1b with SMTP
 id w10-20020a056902100a00b00dc6ff2b7e1bmr2119524ybt.4.1711361724447; Mon, 25
 Mar 2024 03:15:24 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:14:05 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-10-smostafa@google.com>
Subject: [RFC PATCH 09/12] hw/arm/smmuv3: Advertise S2FWB
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3vE4BZggKCpUHBDHIz4z5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

QEMU doesn's support memory attributes, so FWB is NOP, this
might change in the future if memory attributre would be supported.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e5373f4cfe..288e7cf1ae 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
     if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
         /* XNX is a stage-2-specific feature */
         s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
+        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {
+            /*
+             * QEMU doesn's support memory attributes, so FWB is NOP, this
+             * might change in the future if memory attributre would be
+             * supported.
+             */
+           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
+        }
     }
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
-- 
2.44.0.396.g6e790dbe36-goog


