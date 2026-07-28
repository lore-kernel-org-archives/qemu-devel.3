Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A6EC54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogy9-0005L0-Uc; Tue, 28 Jul 2026 08:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy7-0005JN-Hs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy5-000308-JV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so593129f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241892; x=1785846692; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cRcnjDOvFXhyS+1VsfHi35z98OmmmrC2zPHwTW0UIAk=;
 b=PKBCVmibdyPVEz30JsYgvalG4uFcPZwxUROUJjieetntirCONI3qWOaVXJTuBlOhlW
 XQkvWPAbtwPuetP5Viom4bcK6otognguwcUsh97foB0wwqal87EsT3kLTkzvq6yo0mfy
 6bK9vHatLSsNa3SMgAD+1sF++790gGQjLaJ7n6DI6ZXIqm+e8haU6iplIAMfVdIILC+A
 4ZQUCs3V56mK77si4MQhHM4ZD0INImnDQDmOVr9YQ5ACiAjBjLIMsY0/E8yuTd6F19bF
 ZlRkhpHk1nmC+MwP3yqzZbG0cqzt8xQujC+r5eCGJXa380UHwq2tC7Hh/T2V3iYxBOzl
 TRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241892; x=1785846692;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cRcnjDOvFXhyS+1VsfHi35z98OmmmrC2zPHwTW0UIAk=;
 b=E+QWH4EGV6LgAEFl+0NKxWbT8kOuP5Mo1Qhb4DN+eyUwbzSLDADpqyFPFLq/G29cCT
 pY7AtQFzVX6yLL1TNTfNEFcvqeQlBokIO7Ah2W4fOIt39jawWz4W/pDb4T0I92QbtDAG
 UfGjTnnDa6DADsxi0UXBivdi7bNUcre/lkHsdtAGU0WJQOr/2tlYOqP27bdv3XEzuxu7
 onIW4PMDRW7fKPWuM326LVXyveA526BGcCsqnWijCi+XgESKPwWeGYSNhaiXgVOpaeX3
 YgnU1BMFu/tm6pdLPr1x7pEZ8DFpH/O37Mok2YuxF0SvQTh+vr6whp1pu2JsojOXgu9J
 ULfQ==
X-Gm-Message-State: AOJu0YzpQIWf7zuMjqsfMkC+IDYCO4dcDiKKSE0R5yHJnYxzbOZnzfSU
 rO9wGHuXos1DzK2jjTTElZKDMJHbeGGIsx1iSA86naYoImu8U01bG0iFMNTYXCbGkTk1PeiQC5r
 c9yPV
X-Gm-Gg: AR+sD12lmaq91BECO58eH2gmGGhwtHgwaJYvMPTETe4l8kmT65Vzo2lByPKaBer+E1q
 6ZqhA80YcAEaoZbSpJ+FCz+izUuYNNf82DwdRBfF+MnLbvUfDp5nZvNZCZPkX+7xEuMnfU/l0UV
 S0y71EI5FAs79LRUjvScDau02Q+kT5JotP9lv0mgmJmfgHorUYD7A50hSO+BmHxXvhmhVVuOZ28
 ELlMI4DOrIH9DWha4+i9jRGxAl/ztIydhC+7y+PgfZoV8lzxi01R7KAdVHyE4aC4YMzFRsZy4fd
 kbQPG4kVQORTWYqiAaRqL5KuKBbrr9pGxKtMZezppEVV1/XU2Ph1vKPgc70CFaakirtYgakGPDE
 UFaHcU5WohGVubNj/bc0SgDF6iaxLuPkPzSIXzp0cKt7vvY2Ko0HO+FYv0rdvCOiI6JR5WBsid2
 mB0VNgzDVOE4Hb6j4jECvDite8O/cDvFoBC5sh0RbJH4xLHeeMOP9KrYCv88JqWZKJTJPJOUixs
 QPCuvNH474=
X-Received: by 2002:a05:6000:1ac5:b0:47f:8c78:6b3e with SMTP id
 ffacd0b85a97d-47fb1e85c2bmr2546131f8f.5.1785241891937; 
 Tue, 28 Jul 2026 05:31:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] target/arm: Only compile gicv5-cpuif.c when GICv5 is
 selected
Date: Tue, 28 Jul 2026 13:31:10 +0100
Message-ID: <20260728123127.1711653-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Only compile gicv5-cpuif.c when ARM_GICV5 is Kconfig-selected,
otherwise we get when building with --without-default-devices:

  Undefined symbols for architecture arm64:
    "_gicv5_activate", referenced from:
        _gicr_cdia_read in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_deactivate", referenced from:
        _gic_cddi_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_get_hppi", referenced from:
        _gic_hppi in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_request_config", referenced from:
        _gic_cdrcfg_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_enabled", referenced from:
        _gic_cddis_write in target_arm_tcg_gicv5-cpuif.c.o
        _gic_cden_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_handling", referenced from:
        _gic_cdhm_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_pending", referenced from:
        _gic_cdpend_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_priority", referenced from:
        _gic_cdpri_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_target", referenced from:
        _gic_cdaff_write in target_arm_tcg_gicv5-cpuif.c.o

Fixes: ee0f1ce00db ("target/arm: GICv5 cpuif: Initial skeleton and GSB barrier insns")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260721122135.6288-4-philmd@oss.qualcomm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 227e674ae2f..cbfac0036e7 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -91,6 +91,9 @@ arm_common_system_ss.add(files(
   'tlb_helper.c',
   'tlb-insns.c',
 ))
+arm_common_system_ss.add(when: 'CONFIG_ARM_GICV5', if_true: files(
+  'gicv5-cpuif.c',
+))
 arm_user_ss.add(files(
   'tlb_helper.c',
 ))
-- 
2.43.0


