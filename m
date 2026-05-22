Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA18CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQC-0005HS-Fl; Thu, 21 May 2026 20:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO6-0002ab-Rj
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO3-0004Mo-7Z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ba856db1c0so49148595ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408309; x=1780013109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4aaVUDqVD+Ykh6MuOiNf7dl0cw463M1lQleLrswrGY=;
 b=M3271byTEW3yI8YWgnZWcwPSMBLhxlb9l3EIbmG75StK/Ofy+stZoQUWoQMxLsUAq1
 Kyck81TspP91ay5TbeHCv5yX0ZHoSAfnCrhrCe07IcyPa4i4pUt38NpMfItoH7UTjkEU
 9bYnSVhd/dxrndlmRMPBaL2MtTBS8cBYwGDE8XnWSIDp9tFD34Hy/SWCb0kvESeFvjxm
 OFuoU+kObPOpNoYCw6yxI17yIjcn/ADn5++ASrfwsCoj5xddjXmt0w7oTniRvsO7pGfM
 WGGV78DkgXha1VdHAJn7+NIyK6FrTDX9cx7CnnTxmeDXzRQKT2gco4LDui4O2sDgGYNE
 FZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408309; x=1780013109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f4aaVUDqVD+Ykh6MuOiNf7dl0cw463M1lQleLrswrGY=;
 b=ESmsbPSOyo4MaQveaoLD9mjU5OyY5LXAsoKpVgOtjbtiGyl7WjAIJuB1RgJ3+eo+9F
 XgD8lOSZhlSvoApnnj9baP/6WktRidsEoj3CADDMBdsdqIGP0JJaiN24L4xYYz3GvD70
 Icbt7YYET682IsBfQ8m9t7A39urAqYyTFrwHSED7lSIa6kACI3GWbSKtSyLHBMupxykP
 x62PoXKVC4H6Q2xy/WKiA1A9ArwlvhT4HJySBvsQEYkmlffQ2USfLZ88/NxKynvn15KB
 MIQ8zSJftvBaD2J+5PLOP7O7IMf7UuQqEunY1Ktwxk/1WkMp70loE7JVXij9n1l465pT
 prbg==
X-Gm-Message-State: AOJu0Yx1Jf7xN9faXz4f3Av/qPFh/gLvgKuILJm26Rkn099DInXRWfA6
 jXSj7CLPWfQ2aHkZgRvFG0nriFHqNPZhLbliM9dc/4TAmcukHnq0oRFRK49YBxFz
X-Gm-Gg: Acq92OHxhd/fMVHEAQNmwBDcMpAtG1GBPnCuLaKOszVn9Pcn9OIzcAxTiRs899GFeK3
 CJn3T/4csNZ/NpvUPW8GyJ1rbihSJdK1i9cvMkmQhMZvx+7MwcaF1T8+MKEfh7Cm76zO317QPW6
 5UIxGZ1cezg/Kph3QxUgBdismgufZTnv6GrKREHH4JHRwInB9yb93msz/d/L00ODA1plpf1kpFu
 02dnwqk98XJeQZfN9ziOMCcPsfkC/Wl//H6J0QiaDM1aso6ZhJZTg4Osu1k+js3DZpR4QqZmWj6
 YqDrZ8ySA6sRMztbWdPkAASGA9NNsFyQ1x/S+NwPZz72HYbHTftayKqy7ifCW+whwM8phEMLZxc
 QkppTIBg0lGXgdDE2RcltlLqoLJjU/fy/v3rP44x1ww6YUeljyJThdh3tyIfgEQzGjy1wloPfny
 8C7VZS7a23KT7hDLgEkMXpz1XFzjXrFFEULvP2fhJG6g==
X-Received: by 2002:a17:902:d4c9:b0:2bc:dd58:3dc4 with SMTP id
 d9443c01a7336-2beb0758026mr10468275ad.32.1779408309456; 
 Thu, 21 May 2026 17:05:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/48] target/riscv/tcg: treat all exts equally in
 cpu_disable_priv_spec_isa_exts
Date: Fri, 22 May 2026 10:03:05 +1000
Message-ID: <20260522000324.23255-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Commit 7e4f75cadf ("target/riscv/tcg: hide warn for named feats when
disabling via priv_ver") changed the design of
disable_priv_spec_isa_exts to not warn when disabling what we were
calling "named features" at that time.

Back in that time we were adding RVA22 profile support and we were dealing
with a RVI innovation: named features.  These can be define as cute
names for pre-existing behavior/parameters, e.g. 'zic64b' means all
cache blocks must have 64 bytes.  They do get inserted in the riscv,isa
but they are not "real" extensions because users shouldn't be setting
them in the command line, or so we thought back then, and we attempted
to model that by calling it "named features".

This didn't age that well: ziccrse is a so called named feature as far as
TCG goes, but then KVM had to treat it as a regular extension that can be
user set and we made an exception: ziccrse is a named feature that is
user set by KVM.

"Named features" are regular extensions that might or might not be user
set, and might or might not warrant special handling during realize()
by setting other parameters.  And we'll being treating them as such,
which will culminate in the end of riscv_cpu_named_features[] array in
the end.

This reverts commit 7e4f75cadf44ee67809c7ca82645a289a5268966.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-5-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a358d91ca5..92406bf41f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -484,15 +484,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
             }
 
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
-
-            /*
-             * Do not show user warnings for named features that users
-             * can't enable/disable in the command line. See commit
-             * 68c9e54bea for more info.
-             */
-            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) {
-                continue;
-            }
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x%" PRIx64
                         " because privilege spec version does not match",
@@ -520,9 +511,11 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_13 = true;
     }
 
+    /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-                          cpu->cfg.cboz_blocksize == 64;
+                          cpu->cfg.cboz_blocksize == 64 &&
+                          cpu->cfg.has_priv_1_12;
 
     cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
 
-- 
2.53.0


