Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D9C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJX0-0000pD-Ez; Tue, 06 May 2025 10:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVD-0001dP-Cc
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV9-00027J-Oh
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso35844305e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542550; x=1747147350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LxlT5ltl+62C9HFS06L3ExxGD28tq/piucc5fALXoww=;
 b=JatjqQPSNU73oBaehwOUR74cAT4Z1+GkroqWDiEUpcpf/wrBSasTL86HYPd2vPs+qH
 945bqntpoiCf/HCHg4uaziJCR5VzetfXvE7ECmCL7r7kD6/BJieUsQInzOBDoQF+LzmD
 Fq/GJodMjqpaFpk12ZDslu6d3AjzQwbGHFqgFhiVgyjj1TzSzGDlQj+6PRY23IRFvxgX
 rPgkyZE02aRMDqrMO9xaPSLfOF3cDyMJ2oT5r+734WBiteZyeNEtt/C7Xaq6TWhMFmA4
 hQjQJ99bQxznpql2yFkDjw43WZvQsgua8ekCPAOzuhZroXu1yfDqmTPLPJPpqP58x2ys
 d4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542550; x=1747147350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LxlT5ltl+62C9HFS06L3ExxGD28tq/piucc5fALXoww=;
 b=Fjnc9hbYaiey4h5q5pt7+W6R99Py+QbL6rMluz8TqvYA05m8zzqSydMPjsAeLNPMI3
 rkpULbdeRVDVrXsjrGc1QryRKGJJu90GszaWoL4xusaY5h4c+14PsfkqFfeCqvsBTpnT
 P9+MmZ8n5F+onhhQJSCL8gi0ztmhnnLnC6/ESUhqfqOXptTBJi03A/lnffwnnOAAtQ1X
 6SlNunQeC+JRxO3E95S50MJMg1kaDJ9vSXME24WOq53/RMh8XAg7n90PK2JHhFk88GRx
 jTkEGZc/GSlN7/jW/PC6EPAmGOcRFQt2ye3xIg5HB1nukljMEKXjyctp5i9m+Lytu3Y8
 8tIQ==
X-Gm-Message-State: AOJu0YwN1nIJ2LpzzrEdEsoPF2uhQQV6V897EUhKDk5duaiVksm3uoJ9
 5H2fPmKGlQB5TKP7uhaG8XXCCz1bvL8bPJR2/vOXFN512XKE9R30TIrjtU5YnN8WittkAltZJIu
 g
X-Gm-Gg: ASbGncub/X3LKecrzqfz4sQuIHKcxsKCfQPfkM6algS2A6zc03qGiJ+n04mhCHa+6ub
 ftYIdyXUY7OUIua9s5RjB1Izcl5jFGJUPDw7E/Ha3QbBdrmMMqkRycixLMPO9qnP3TUR2Nn7K4c
 daxAvHZNoqsXq0Wq55MHzi0Bkbl0erd6x/OL1yJnsML73bjrvMEAVwCfYS5C9hghyrC7/knOyH9
 ArpvjFEe+RZJMupDnFJqX+HC/Kyq6G/UOpClgv3RrP1cC1Gst66ltPar4uWwWwtiHmO2omHscnm
 lp/LGCTlorMLdAI6G7yMfr2SV9Y93Ue41SwJMrO4G8JRR2k=
X-Google-Smtp-Source: AGHT+IEBgI7n3t/3mFDJp4/AotVJAZtm9HWURtGxci5vCk7LyzzVjvLJ+3ZiJMgudmpELdbWdCHuhw==
X-Received: by 2002:a05:600c:528c:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-441c48dc51dmr100765495e9.19.1746542549902; 
 Tue, 06 May 2025 07:42:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/32] hw/arm/virt: Remove deprecated virt-2.7 machine
Date: Tue,  6 May 2025 15:41:53 +0100
Message-ID: <20250506144214.1221450-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d82cf78b0e..a2a213717cc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3649,16 +3649,3 @@ static void virt_machine_2_8_options(MachineClass *mc)
     vmc->claim_edge_triggered_timers = true;
 }
 DEFINE_VIRT_MACHINE(2, 8)
-
-static void virt_machine_2_7_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_8_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    /* ITS was introduced with 2.8 */
-    vmc->no_its = true;
-    /* Stick with 1K pages for migration compatibility */
-    mc->minimum_page_bits = 0;
-}
-DEFINE_VIRT_MACHINE(2, 7)
-- 
2.43.0


