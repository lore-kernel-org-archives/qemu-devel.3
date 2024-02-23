Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB66C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXre-0006Qy-J0; Fri, 23 Feb 2024 10:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXij-0005at-Jt; Fri, 23 Feb 2024 10:44:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXih-0006IJ-85; Fri, 23 Feb 2024 10:44:16 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dbb47852cdso7943275ad.1; 
 Fri, 23 Feb 2024 07:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703053; x=1709307853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZa3WsnJHLzg9werjuxOzrnjxOzmy7c9BmDhBtjSlwU=;
 b=Xjwpq5EoFR1zwKhYvp3RN7zKKgODjHs50qQsTuxUG+VngmcTIW+7xqtxYp3SnRR2SM
 WHYKsy8Zbvg9Ha/446s7tnOP3lvLNEsrfQUE6oitqUuK84eM9eAM9T6saXgQVAnXiNsy
 l2JKzjGOILufboGGkBk4dshjG7uT6xINUyJgTna9/AlB8JeQmADZkDtixW4y9+Aib3f4
 mDzyfNXUcEzUY9bfh0iV2sUCU5FYzkhc2M/FNOohxWZUA4swLQ3tzKcmuxd7BGaY3PPQ
 xy2FcAxO53m5QvxHgRR2ETarKWpF0TRuDQ5ASoz9O7T5lmZ+SDYQikqnJ67jhVloXfiL
 aXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703053; x=1709307853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZa3WsnJHLzg9werjuxOzrnjxOzmy7c9BmDhBtjSlwU=;
 b=Iyr2P6Bm/4L1iiD1tcYt5fgeCKjLQX45vXIoTCRfPYXopS5QNXsgkv6EkvQkBDgA1f
 44lQsgsvzb9Myj+/ltthjqWutWDVOTtHeehJRNgQsFB8nP0PrHwZhzlcD8wSZ1qEtqe+
 2Cz3ZrbVTL00094eLz83f81eqLYY8q16Z3DuPgQsmPzf+D/ByKdd4DRC/oofNAuQlJOU
 +zW55HvHQO+FBjTXhiUKoM3dKXi0OR2mHLnSIkzkhoIZeGojLUsh2kNRkmEfnX97gDYH
 S2ZPyWCZnS926RW5ND29GuaOnK2feLIdCAmxWZOyceTHeO/Ny+SA9IFHewu3Lrv5Yzqq
 F9xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3SURyuPbnxIerHsPELcJjSeQBpc2t5r3yeACZoK9OfPgYobgG90ANoe0LnDspqxNmVNIcInVlkm1ZI/7yaFZ1Ind3
X-Gm-Message-State: AOJu0YzefOzNmUP2rv3UPh0+JMqlA9Pis9COKxU4hVMZCpvxS+LNO+PQ
 PzZU3L+vsyqFQKCSyFTvN6+QjtCDKCqJL+a6lCT28uXrgCVeDUVo1/T5KnsV
X-Google-Smtp-Source: AGHT+IEGw5ISM/Mm1ey80x4lWI3hyFxdttHNFVvEzt/q7+NrbB87lPhVO6tZos6LBSy1Hv79wHX3dA==
X-Received: by 2002:a17:902:ce92:b0:1db:f392:e993 with SMTP id
 f18-20020a170902ce9200b001dbf392e993mr218425plg.52.1708703053113; 
 Fri, 23 Feb 2024 07:44:13 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:12 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/47] hw/ppc/spapr: Rename 'softmmu' -> 'vhyp_mmu'
Date: Sat, 24 Feb 2024 01:41:34 +1000
Message-ID: <20240223154211.1001692-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

To reduce the use of the term 'softmmu', rename spapr_softmmu.c
to spapr_vhyp_mmu.c.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[np: change name]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/meson.build                           | 2 +-
 hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/ppc/{spapr_softmmu.c => spapr_vhyp_mmu.c} (100%)

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index da14fccce5..15d13e649d 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -31,7 +31,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'pef.c',
 ))
 ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
-  'spapr_softmmu.c',
+  'spapr_vhyp_mmu.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
 if host_os == 'linux'
diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_vhyp_mmu.c
similarity index 100%
rename from hw/ppc/spapr_softmmu.c
rename to hw/ppc/spapr_vhyp_mmu.c
-- 
2.42.0


