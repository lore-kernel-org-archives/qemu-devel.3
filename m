Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B21C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYJ1-0005W4-Qy; Tue, 01 Jul 2025 06:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIq-0005ON-9I; Tue, 01 Jul 2025 06:33:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIj-0002Lh-3h; Tue, 01 Jul 2025 06:33:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23526264386so27804335ad.2; 
 Tue, 01 Jul 2025 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751365996; x=1751970796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8gx/O/oVNZBpyXKxn932jEFKdRih4fkiB4W5c1ZnaU=;
 b=fhx7cDbnrTCotSbyjIltOlkWQAmRVbdxpTvudkMX6b/wAQ31a9hfmHxOtSopv3LXGm
 UBwVGaKCbqWCQeYyOf7ATWVrfcRwRBayIpVkuEe0Rt6Fv7mYXNlGVOg/z6LdcmUyQs7D
 BfKYa8kf18wN4qHVsQ0n1f8UJKj5Tr2dGaXltyuvedX3jGvYIz/v3vaWKOAZT3RfWMQt
 TE+Jiuxm9JPrK/RPDNOyC0KxKawcFaANRHrAknakNxI+L9PgkDsUkoL1MRS2TFMSovWq
 QXvQj1og1O/8kP/FxAK+FOeCS1JrcVRZAhxN1HKd5VgiT3W5quq9SM/DedGEfIS4TKVp
 uqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365996; x=1751970796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8gx/O/oVNZBpyXKxn932jEFKdRih4fkiB4W5c1ZnaU=;
 b=tdVCJvXSh+fXTuUOvvsR2+6/5bYSe4+CepNjlSeSGYudN98GC5xhk5mhdEQIL6NGlw
 pQr9v/J/vSju3l8L4EcbUqQ9y8UU2xWzLEC/hGSxyYewfC32ig06MF9YshokzAocXqzE
 R+bnywy7KPUb4hA7zwzGR7fPGPLpNwG/E6LGxL8mqQ7LAnSRSVrgRq5Hx35EQ3k+DVC4
 7pH007jU7402X0iFm4y1rdMvc9Fz95lGe5Bb+P/hnWf9JFXsK41LeG9sKs4yh7N0lc5U
 pGGyP3gLqH2AM80p62g8aHgP8NgZ/m/w/qzz0CJZh7ukgEMfvQAFKCTdvTvX2UAduPLp
 3lLw==
X-Gm-Message-State: AOJu0YwBwhLlKJA6GM6D+hCB76pNATf0Jh1WSiVo5NZ6tuprAqEjMBb5
 Ac/TWvy7LzTM2ZueUvJw9Lrj6atgF2tkd5hfa63VQdeZvN69muMWNWZEp+OXKPdcWFE=
X-Gm-Gg: ASbGncs3wgR0iziD14FRPkh/TV155Zcb8Rr4HSmbWqCVVE3zRZ8TzdmGEoeLxf9+6Tm
 D6vVjvygV7IzskDm3gr9EEBO92WJfN/Svnt/e94408WaUyOn494g7xyWLUYVjD1ZGIeJR17m3Go
 rbXRIt5p/F8DO/8EDOnO8ETZ2FzhYiRLv+zvREOt7bTU0NTds5r17OkWZtbB3yi0JhzGoPF1axN
 XKzhnKkHwFbgpl7+32mkJRpW9KC3ci4zearJYaenF9Ba7K6Dg4mdyOGVxjtbfPNWr+CAZ/ehzfj
 LltqhukZff4y4DAbU11vDrCi+pWjNr76qjGTopkONvL/xNIG5+ucMzuJ1vVm74e0wPvBv6mJ1/c
 FUDdw7fz/uiQZ70fuSCII91djUzb/Efrq3IkmxVZOVeM=
X-Google-Smtp-Source: AGHT+IFGahn7qLg9A6EjJVwpy4Lb1HV53n4Mr4DY7MCbV0MvDHh+7fSasI1GrVYXrNf169UnIoY5JA==
X-Received: by 2002:a17:902:d607:b0:235:129a:175f with SMTP id
 d9443c01a7336-23ac46527famr260661515ad.34.1751365995661; 
 Tue, 01 Jul 2025 03:33:15 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb2f2183sm109168435ad.75.2025.07.01.03.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:33:15 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 07/12] target/arm: Fix VSTR_SG helper store alignment checks
Date: Tue,  1 Jul 2025 20:01:54 +0930
Message-ID: <20250701103159.62661-8-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x62b.google.com
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

This patch adds alignment checks in the store operations in the VSTR_SG
instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/mve_helper.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index f1e9c87e6a..5b04fa4425 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -277,13 +277,15 @@ DO_VSTR(vstrh_w, 2, w, 4, int32_t)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned e;                                                     \
         uint32_t addr;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG(STTYPE) | MO_ALIGN, mmu_idx);\
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
             }                                                           \
             addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
             if (mask & 1) {                                             \
-                cpu_##STTYPE##_data_ra(env, addr, d[H##ESIZE(e)], GETPC()); \
+                cpu_st##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
             }                                                           \
             if (WB) {                                                   \
                 m[H##ESIZE(e)] = addr;                                  \
@@ -336,6 +338,8 @@ DO_VSTR(vstrh_w, 2, w, 4, int32_t)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned e;                                                     \
         uint32_t addr;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
@@ -343,7 +347,7 @@ DO_VSTR(vstrh_w, 2, w, 4, int32_t)
             addr = ADDRFN(base, m[H4(e & ~1)]);                         \
             addr += 4 * (e & 1);                                        \
             if (mask & 1) {                                             \
-                cpu_stl_data_ra(env, addr, d[H4(e)], GETPC());          \
+                cpu_stl_mmu(env, addr, d[H4(e)], oi, GETPC());          \
             }                                                           \
             if (WB && (e & 1)) {                                        \
                 m[H4(e & ~1)] = addr - 4;                               \
@@ -375,22 +379,22 @@ DO_VLDR_SG(vldrh_sg_os_uw, w, 4, uint32_t, uint32_t, ADDR_ADD_OSH, false)
 DO_VLDR_SG(vldrw_sg_os_uw, l, 4, uint32_t, uint32_t, ADDR_ADD_OSW, false)
 DO_VLDR64_SG(vldrd_sg_os_ud, ADDR_ADD_OSD, false)
 
-DO_VSTR_SG(vstrb_sg_ub, stb, 1, uint8_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrb_sg_uh, stb, 2, uint16_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrb_sg_uw, stb, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uh, stw, 2, uint16_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uw, stw, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrw_sg_uw, stl, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_ub, b, 1, uint8_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_uh, b, 2, uint16_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_uw, b, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uh, w, 2, uint16_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uw, w, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrw_sg_uw, l, 4, uint32_t, ADDR_ADD, false)
 DO_VSTR64_SG(vstrd_sg_ud, ADDR_ADD, false)
 
-DO_VSTR_SG(vstrh_sg_os_uh, stw, 2, uint16_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrh_sg_os_uw, stw, 4, uint32_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrw_sg_os_uw, stl, 4, uint32_t, ADDR_ADD_OSW, false)
+DO_VSTR_SG(vstrh_sg_os_uh, w, 2, uint16_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrh_sg_os_uw, w, 4, uint32_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrw_sg_os_uw, l, 4, uint32_t, ADDR_ADD_OSW, false)
 DO_VSTR64_SG(vstrd_sg_os_ud, ADDR_ADD_OSD, false)
 
 DO_VLDR_SG(vldrw_sg_wb_uw, l, 4, uint32_t, uint32_t, ADDR_ADD, true)
 DO_VLDR64_SG(vldrd_sg_wb_ud, ADDR_ADD, true)
-DO_VSTR_SG(vstrw_sg_wb_uw, stl, 4, uint32_t, ADDR_ADD, true)
+DO_VSTR_SG(vstrw_sg_wb_uw, l, 4, uint32_t, ADDR_ADD, true)
 DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
 
 /*
-- 
2.48.1


