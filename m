Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8792ECD98E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQiO-0004p0-9T; Tue, 16 Jun 2026 06:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiN-0004oS-3q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:15 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiL-0003bX-HO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:14 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c8857a27041so1312024a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604492; x=1782209292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMD4n4yKqyqaSyFhuXV0YZ2Qu85Y+oSmxAVjdW60sk4=;
 b=GO5qU5QiugC2IyMxcudd4S18WuzTFJTA7RvCKYJuaVxl8RNMzagCi62I7g9qUlWoE5
 juNsGahHDccyA9TsccxeJrRklGJKLgtvPgbvv2atVZXMhvCWOuIQCy2qgEvkPHq4v0Fy
 fGKS3QgdltRFfhHC7Ozm+zCWG5r0AmwvY9w8LHPLZRcFTmPbrM2mMsWE54YGN7XITjNp
 GpMzmdCxHP+Gkb6NXoikIY83l7tSXA8I/Z72zo5FixWsFTtEsw6xJmjxOk2cI8ox3/pw
 DFwDRNxeh21vYZgGekRUThLdlfDVI8MACYBCeDn5BlPnXfno269dYyRoNR+jL4wXm/lx
 LFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604492; x=1782209292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lMD4n4yKqyqaSyFhuXV0YZ2Qu85Y+oSmxAVjdW60sk4=;
 b=YFLzgZto7TZ83NhfF4uINOccMBDv0xbyKFZ4t1L6Y4TznQPf13AIqFAfhruRFq30WO
 BNxtUabtkfX9nflSMMxRyOQSQ2pNlSiQfHwg4A/X0x2pLXVczgyNJq0t3TE0nmY93mhZ
 4SkAYSGb+FYKpG4Zs+DZw7x9xpGoIx+LWm3LWMjI1JYD1sgXCQbcEB1uZ4XdCnspfwyq
 rlfKq0oYckf/l59k9UWF8Vyyf0OxRewKXwbo5Ir47uvwB6ywCLmco7KikjRw8SLeFEIy
 PE9O/R0Roq0+OirFid+Jkkm2hNeGjpiPbagsxSMISKhlgTmFcQ57I7uuyG5f/VZiX918
 0r/Q==
X-Gm-Message-State: AOJu0YxlA05pwzyCHr2YcD2h+s5AQlHESlxtcYcCtyOXZNQO1E42AYCw
 MyqzqUYxOoS4LwyO+mQkxQfTvHKwARUkrLVxYXgcqP2k56+ZIHRcwKES+ekfwggb
X-Gm-Gg: Acq92OE0rpp8ukjjBI58uYppF4qgpmtn7FuPP66qKEBPSu9iK9dTOFzl8vYQT5qUYIM
 DlB6mjVmCIVHMzWoVIK2x+NuYh0bYQZPmk4qX1ANJ0WRCPfICjlFKxL3sq5CN6s/ZHamOADtTC7
 l4A5bvTI7K/hUA/7fkq3xq/sWlpTSlBeqZntRG1Ne48GDX7vrUlgkQPLdhkXRD//prWldYY2j6a
 YueGoXw7Qpk2SWuIXkcPf2BE9hZLGI2zY4g6+lNBg81sbK6HoNC8NIRXrEW77xA2DYayFZXdS0T
 3I2AaLap32kJ9tpV/DudoU1mmHNR0SORGTvBrtP6OvPeO/HHk6TZKDlL76wO9tAVqrG6ewlUTpZ
 +6v8BucloTl5WYvFiT2pdAZbxJsYnslMeoRaClqLgtrJdZuOa3f9Vl2Xa4oEovN6wse2qC/UCbi
 +XYjhS6jx3dN7w3JuZKYghEECIhvqMcEr/pD3lqjtY
X-Received: by 2002:a05:6a21:9206:b0:3b4:3ef0:9132 with SMTP id
 adf61e73a8af0-3b7962554b9mr17021964637.11.1781604490723; 
 Tue, 16 Jun 2026 03:08:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 45/83] target/riscv: Remove target_ulong use in
 get_physical_address()
Date: Tue, 16 Jun 2026 20:04:48 +1000
Message-ID: <20260616100527.1939565-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use uint32_t for RV32, uint64_t otherwise.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-6-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a8d4a1a4f4..430378490f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1675,16 +1675,18 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }
 
-        target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
-        target_ulong old_pte;
+        void *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
+        uint64_t old_pte;
 
         if (riscv_cpu_sxl(env) == MXL_RV32) {
-            old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte),
-                                      cpu_to_le32(updated_pte));
+            uint32_t cmp = cpu_to_le32(pte);
+            uint32_t val = cpu_to_le32(updated_pte);
+            old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cmp, val);
             old_pte = le32_to_cpu(old_pte);
         } else {
-            old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte),
-                                      cpu_to_le64(updated_pte));
+            uint64_t cmp = cpu_to_le64(pte);
+            uint64_t val = cpu_to_le64(updated_pte);
+            old_pte = qatomic_cmpxchg((uint64_t *)pte_pa, cmp, val);
             old_pte = le64_to_cpu(old_pte);
         }
         if (old_pte != pte) {
-- 
2.54.0


