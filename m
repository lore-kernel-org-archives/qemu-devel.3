Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B25C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2S-000303-SV; Tue, 16 Jul 2024 12:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1K-0006XA-1z; Tue, 16 Jul 2024 12:27:19 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1I-0006cN-7E; Tue, 16 Jul 2024 12:27:17 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-25e00f348e6so3141107fac.1; 
 Tue, 16 Jul 2024 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147234; x=1721752034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyPOIb2VK3dD8F4THz9rJokTRHuUTmaR6trLMdHrvl0=;
 b=iUlodgZ488qDY1iBEs5cF2EZeeopKbXggh7GaEPzM6OITVfrF0tOAmnBZPWPyF+ciK
 eZG94lHILxALY3MXAUy56erTK8m6kxbfQZetagvu2djWgw6v2HlE+5Bat7g+iPyna0+v
 uPlCe9YZePx+VDl0GPez2Y1DKQzSnZbIsd5WxkVqxR2dTVvV+KS/lv/IxsFrcKiFQFe7
 NuWlSEW8LU4Rd0EPgGZBmmyq382HKicrhbPZ3mZB21AKmpjbfEHiJWCuwIWAhXJXJ9LP
 cGQVZ/R1le1u904IB6TnfLXk58lve0jkSqlM2vBlwy2QUvBaDYsobQ/MPFcyXelqfTyc
 CRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147234; x=1721752034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyPOIb2VK3dD8F4THz9rJokTRHuUTmaR6trLMdHrvl0=;
 b=VaBQRX6I6lxLZTeFB5xWnjaioGn4Rne78EpCHdp/UKbHAtoWvUlor86wXpJXafzIiY
 hb8baPnRA6uPOe8Zxf9UdZWZ5fXVnzOS1j06Y4jyzUhU8urMm9kU0+b2k/f2wjK2ea4u
 FCoqhkHrG0GJar2R/1YaBjNpRfN5PIOEff45toyXHBzFM7sxlcovY1G0Z99bavBf0LUN
 o+Y4YAcwelYXVTxWMviJIKbtpzKKRqVRUDzHyn9KEW+pK+65ea0aaEmxPudvRSU+632p
 lTqOgPA0hknIbN/xCKtlyy1zW9aOiPCIh4onmOkH/p/BgJTgiceCefAGzLcUi4IY56Bs
 7Ktg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrfpuw/CMQ87jLR/b79/8os+Njgk2PatoM5jSO5nAphwQwVK4fKgkVBfcryyvsWwfCliL0HKpZsNPR/Lz8CZjNNI3REoM=
X-Gm-Message-State: AOJu0YxA1lU0lvZInPv5x0JH5CBvEPG7FspL/e/hqH9Hvah2hyIkc7lQ
 ZfUBi0W+fATNk1AITWgk/lJo0VHJNgXf9Kx1kjltEuZL3AWysrAnk7ngeQ==
X-Google-Smtp-Source: AGHT+IH1G7haDJ80o4RXttZ9v+RvaZNkthlUOhSX+Njl8qCD5Ag07eiR83L7fH89xKeCjBAX1Tw6Fw==
X-Received: by 2002:a05:6870:d189:b0:25e:b999:d24 with SMTP id
 586e51a60fabf-260bd9cfee0mr1972510fac.0.1721147234009; 
 Tue, 16 Jul 2024 09:27:14 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 13/19] ppc/pnv: Implement Power9 CPU core thread state
 indirect register
Date: Wed, 17 Jul 2024 02:26:09 +1000
Message-ID: <20240716162617.32161-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2a.google.com
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

Power9 CPUs have a core thread state register accessible via SPRC/SPRD
indirect registers. This register includes a bit for big-core mode,
which skiboot requires.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 692e48e6bc..e69236d2de 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -319,6 +319,23 @@ target_ulong helper_load_sprd(CPUPPCState *env)
     case 0: /* SCRATCH0-3 */
     case 1: /* SCRATCH4-7 */
         return pc->scratch[(sprc >> 3) & 0x7];
+
+    case 0x1e0: /* core thread state */
+        if (env->excp_model == POWERPC_EXCP_POWER9) {
+            /*
+             * Only implement for POWER9 because skiboot uses it to check
+             * big-core mode. Other bits are unimplemented so we would
+             * prefer to get unimplemented message on POWER10 if it were
+             * used anywhere.
+             */
+            if (pc->big_core) {
+                return PPC_BIT(63);
+            } else {
+                return 0;
+            }
+        }
+        /* fallthru */
+
     default:
         qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
                                   TARGET_FMT_lx"\n", sprc);
-- 
2.45.1


