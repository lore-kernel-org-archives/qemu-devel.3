Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A65C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgX6-0006Tz-73; Thu, 27 Jun 2024 00:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWd-0006ED-6F
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWa-00008p-UV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:22 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7067435d376so983138b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 21:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719461659; x=1720066459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TUFa5RFEE0mlvWgiU9FcmbW/faCfrest43wgdD9lPk=;
 b=vvN0YkCBTLK4YloTkcxWScgPWFioB3uCSpLaARo5uqs2t1pQLS+WNg66O7PACMl8jL
 EfLx+ORXPGoE94/nDDpwuV/ggEvCg+cKiSJeAhtMGYiZyQsTuWN6CxzsjN9fn7hfICYa
 owUppWaJsR+jdtZ8w6eVyupBivDKY1XpaehPWXYz0SP71f1/UI9qIbSLs6Ur0U3zHIWt
 oc8CQuMO+AYgQOz0Tmvf4GDW9bC4D/WD9lH1wRoIjixTxaAgyvS4oVns4AA7MdSFdHiY
 5vja6Mxzvsz6F7ZzgsF0jWy5Ls4NyhyoYMGs/KiWrTo9+Qg+zCkzu4sgFAYZociJwdZ3
 j7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719461659; x=1720066459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TUFa5RFEE0mlvWgiU9FcmbW/faCfrest43wgdD9lPk=;
 b=ikWdypruOC9U11F3txMiFkAbwDG417mWG0SIUezeKsPTZJVdKR+KSIUqDBcEF6fwyi
 S5yJZRVyLJzJ/sW0x1ZLhCe6g4pFlFx4WSpVRluKsw1RGsCkLiZ3Tmw85cIzIKKpsDej
 MOuaDWdaqqFHfUqez8zIVAp6knt8+nWSpx22y6CYGzT2KX/XhoxdcEaSiUTPLTQD6Pcz
 i/IaaOb8xHTvgYbY109i0s4TWPJaw/XBIi2s8sTP9c0zLWD7EWR36wH17BY0nHkBgxqG
 qaKTavEwzWwTDwmCBQi7LxqQmtJ+U+9LmiDXqKnAN+U2QidRMUi+nsUYJHHvVb85ulEg
 TYfQ==
X-Gm-Message-State: AOJu0YwH+AOEDTiRdrtvgQIiLi9hYg/lbuB98vWJPVurSiYnRgS6PnA0
 mmuy72Ook61DHX4C0pvNpD/KAEzj2o83fdpnDtIVA2kwJnvx0NLjmlJX03NWbcClyAY2xa+ylgo
 CwRQ=
X-Google-Smtp-Source: AGHT+IFT0cpYxqD1l+e4JVDfk+ffYxoTYE+C5fMDWBGWZltjgRlOX0SN1GMj/PlGDMPfJQz1uefIaQ==
X-Received: by 2002:a05:6a00:2354:b0:706:3d61:4b21 with SMTP id
 d2e1a72fcca58-706913a1c4cmr12001048b3a.3.1719461658833; 
 Wed, 26 Jun 2024 21:14:18 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72748e8539fsm273045a12.66.2024.06.26.21.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 21:14:18 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 4/9] target/arm: Fix exception case in
 allocation_tag_mem_probe
Date: Thu, 27 Jun 2024 04:13:44 +0000
Message-Id: <20240627041349.356704-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627041349.356704-1-gustavo.romero@linaro.org>
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x436.google.com
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

If page in 'ptr_access' is inaccessible and probe is 'true'
allocation_tag_mem_probe should not throw an exception, but currently it
does, so fix it.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 037ac6dd60..a50d576294 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -96,6 +96,9 @@ static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     assert(!(probe && ra));
 
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+        if (probe) {
+            return NULL;
+        }
         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
                               !(flags & PAGE_VALID), ra);
     }
-- 
2.34.1


