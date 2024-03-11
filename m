Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2B1C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjazn-0002Jf-K9; Mon, 11 Mar 2024 04:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjazj-0002JF-3z
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjazV-0008JJ-Ru
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710145597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jPTNsNYlyuoCf/nljvZGZg2h6owx+osOv81jUJ76EfM=;
 b=WrnajpoOICYYKm97VZVZyT8Cv+sRHVhJnlFWoQUMeIGv6k+uv9s82scZhLsjO635Q6LYsk
 xTFgyLjF2w8n34S50rOWBT8cribJnUho1u6DTfdkDkRpiyYtvZaSf3X2q58NoQGoaxJrgj
 dnk0fBj7uwaOrDMRB43ztXi8XS7Bzkw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-iXJJu7lFPcWepVpUbfL69w-1; Mon, 11 Mar 2024 04:26:35 -0400
X-MC-Unique: iXJJu7lFPcWepVpUbfL69w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45ac612a4dso532721366b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710145594; x=1710750394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jPTNsNYlyuoCf/nljvZGZg2h6owx+osOv81jUJ76EfM=;
 b=CVjFL3RwJryY346LeD/T2jPwT8bIjY/DitkTgqm/rz2Imurg441v5HHQ+Ix+i//7OH
 rFC/dD+O4evY9nsqLitgFzM1QmlkgYpeV+kQEf0Fsf8XbizgMcPeYp6P6UN0UX2c7sBW
 AVa6oDg7klOvOZnMngkWH+Se9vRcFPrxhOmKvH6LhXEYeCuyR7x/UcdX82vC2q8WLvjc
 KKLtbSE9V1XxT66zJa0Fz9x2TyccUg7/BqnFClU7Kq+DQ0xngEhFeoSMxs/xNETdvx5f
 Z5UhnSdzDLv0ZYQ7GvVhjBOJnp/bMl/PWloYT2UYqV3hRhIxBaVi1MawGp2q1m1E2wAQ
 lGMA==
X-Gm-Message-State: AOJu0Yzg3AImaIvmeosqha9JRWR0Xgp3uec9uWHNqhGsmBkw96lHGddC
 UykZqC4H+Z1oQrzWhlPNAqh2LsZF9KBCKuP5kgiai780Rna/KS4S33xJViZ/G/qCGcUxEf8/jqb
 2GGG8ZWsw5PhgvXDoDJppyj+XsmOkUnt6qsHRI2EZr/v85wndNQt3dRIMJx5vkIeQHnSPmzQwv9
 Zcz4GxUy6WQXuasbvbiCmFN0SJN/sH4uXN8aIW
X-Received: by 2002:a17:907:6d0e:b0:a46:2e1c:2a6f with SMTP id
 sa14-20020a1709076d0e00b00a462e1c2a6fmr1378682ejc.2.1710145593969; 
 Mon, 11 Mar 2024 01:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMON1WTLCytqCh/hpBNuQ5jbRhIo0rQjPGv80ymxuy6X5g/+8OTqBKwAjokAKnmFRjzmWAGA==
X-Received: by 2002:a17:907:6d0e:b0:a46:2e1c:2a6f with SMTP id
 sa14-20020a1709076d0e00b00a462e1c2a6fmr1378669ejc.2.1710145593590; 
 Mon, 11 Mar 2024 01:26:33 -0700 (PDT)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 mm5-20020a170906cc4500b00a3d11feb32esm2635201ejb.186.2024.03.11.01.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 01:26:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] tcg/aarch64: fix assertion failure on TSTxx of UINT32_MAX
Date: Mon, 11 Mar 2024 09:26:32 +0100
Message-ID: <20240311082632.671163-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

These are translated to CBZ and CBNZ instructions, and the code generation part
of tcg_out_brcond checks that c is one of TCG_COND_EQ or TCG_COND_NE.

Fixes: 34aff3c2e06 ("tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX", 2024-02-03)
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/aarch64/tcg-target.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index dec8ecc1b65..6ed174bd172 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1465,6 +1465,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
     case TCG_COND_TSTNE:
         /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
         if (b_const && b == UINT32_MAX) {
+            c = (c == TCG_COND_TSTEQ ? TCG_COND_EQ : TCG_COND_NE);
             ext = TCG_TYPE_I32;
             need_cmp = false;
             break;
-- 
2.43.2


