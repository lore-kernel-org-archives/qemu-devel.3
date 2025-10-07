Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DBECCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68RD-0006Iy-T4; Tue, 07 Oct 2025 10:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qw-000634-IX
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qc-0002NW-7t
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so66621725e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846346; x=1760451146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JlnJcFeHbHMBh2Yw43F702qkS6xRXwUXT+IdK5Bk9a0=;
 b=vPSVBj3uLSf+t6B7bzMUVywxIXLt/WJPxuOQLm3tNXbHzwF9sCdLsmDkzrEHV09JrB
 NgZASooN8gOX81OdskkGiKKQYaoosFuwP1zNOj4b0kNFcVUUBe7og6GjEAx3xCuO3lKo
 4wuR0Xa6iJ9M5OV/GcQxNhwtNdrA3thrwMnyzH6res+dPCbA6RCP20z7KfXcDHva4ivG
 GDTS03szoqv2Y3w9JP68352Ucgfhr4N3R8tTWHxVLrM6Wvbpy/YTcluiS36vzdEaOOSc
 rBj87wUo0Dh7yYjXN4XEBASe9JZkILSVVzuq+kUQ25B0d8aAnHZVYTLFze5E5p7wDwKh
 bG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846346; x=1760451146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlnJcFeHbHMBh2Yw43F702qkS6xRXwUXT+IdK5Bk9a0=;
 b=UszwcJmfcqcVX2Zg94SOxN6NDE/dWHhTizz0bfvIG6l50x515Gb8WZH75ePk84lYqH
 zro6ltAyTFYdCI98QXlfc/UvGN3X0RwQGV3ZB4509I+YNo3CeFt4LHlhZNpp1EDIorCk
 ARADY3Up6WF/NaekE730X4DaeOgbbFWwmpJurXoGW+o29K2Li+tfjvV9XBHS2XKfRORZ
 jeWa7QULDnGGRdBdm1OYiKF79cC83cNEtXNp06EDKFU9+WPJljVwoKbEj6GcuMRlPovB
 6LHNJ02kTConC+d0RWvc/CiVo0YKCf6gKsVy5jYCJ3iUJW/usZTsd/4u4L9lmctOBHYS
 fuFw==
X-Gm-Message-State: AOJu0YwZrYSw9AW5PjF7BDwQ86bhssdUNCbPUEZ8WUm9buIQ8tg67m1B
 jcwxPCrGDOdKKmoYl5Pkzb3TvvwDeM0CEYmDSC0h2cFPDBbMYjNgsnJKZjDPaIkYgx7Bqav8wSY
 hm0Qx
X-Gm-Gg: ASbGnctZEXO8QDmzrUODNd9kjgMfuGcV12wV1DRZcDgfHUJDSd5XPWspOiig2YdxQB7
 u15+iEbu1VMGKD45RWe3y3r8TLGnj/S478mdG15OcoaGXVuG7x/B+LKJJ7dhLiAXQgyYl0fkR+G
 Rr4hOt7lGFErfSLQr5bANGL3N2lPwAsTrR6bnb1PdwD/UpXA0EMiP1CR8eIzgUjj/j4NeeUWLgL
 CAA/rnZKFFyzHefUZrDVFJneRb9g4nCNR0yXAqMNO4A3SWdnkYrCF4VcJ2InRKAQ0Zzpad+K2dx
 UPcQyxXGdmF+nbCzLP3/F3LANkEODQKhmFU/AG/hahSzaqCWX9qgWehFvAHefEQL9aAI0S9W4St
 0J1jGM3PhJ9IJxnl0DrFh3RQe+quhC9NNKiYzEU722CYMRT6WgMKVJcdz
X-Google-Smtp-Source: AGHT+IEDgvkIr4mWzO9HN4FwKG+iXC1nD2zMjORiQ/JStyFCeqXsY/DnkdnPuNYE53lKHx+Z0cGdRA==
X-Received: by 2002:a05:600c:354f:b0:46e:394b:49b7 with SMTP id
 5b1f17b1804b1-46e7116149bmr120698015e9.37.1759846345605; 
 Tue, 07 Oct 2025 07:12:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/62] target/arm: Enable FEAT_RME_GPC2 bits in gpccr_write
Date: Tue,  7 Oct 2025 15:11:15 +0100
Message-ID: <20251007141123.3239867-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 792a47a9c50..b7bf45afc13 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4933,6 +4933,11 @@ static void gpccr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         R_GPCCR_ORGN_MASK | R_GPCCR_SH_MASK | R_GPCCR_PGS_MASK |
         R_GPCCR_GPC_MASK | R_GPCCR_GPCP_MASK;
 
+    if (cpu_isar_feature(aa64_rme_gpc2, env_archcpu(env))) {
+        rw_mask |= R_GPCCR_APPSAA_MASK | R_GPCCR_NSO_MASK |
+                   R_GPCCR_SPAD_MASK | R_GPCCR_NSPAD_MASK | R_GPCCR_RLPAD_MASK;
+    }
+
     env->cp15.gpccr_el3 = (value & rw_mask) | (env->cp15.gpccr_el3 & ~rw_mask);
 }
 
-- 
2.43.0


