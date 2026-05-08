Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5A6CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtQ-0002jc-Bu; Fri, 08 May 2026 11:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt0-0002c1-MW
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:08 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsx-0001cH-IO
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:06 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-685017d0fbcso1205425eaf.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253182; x=1778857982; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t5VUvwmV5QSm/EY15P6N0RYrvzdvXre9m8Jp8WgG/ug=;
 b=Zd8l2qDycW6bC/TmNxwPBq1OvhSvsPDIrX7jAM7O+YwPajZjJktjda/4SORMr70Iwz
 OJgC7PjIkGhCLx7Ha6JI5JxcB6BaJHoYrp82AWHQhQlIVRxwdHs6o3awboeGmNbTYxLf
 OZLXnHY+MeZuoo3pZl9ADldz+WHnPEOGwsRykJUY0erCKYFHxgiwgWlwbzvitSQCCcaW
 KIZUUpOqlCnUrAtH+j9q6wadtaAsTttomxo0Ce5Xdc/gVGyHHUGO6W50cgUUVJ6kesfA
 xWjvq4aKqiKrtEVNqHW9Hxl3GV+qV8SlNrCo/xOYlWzP9DfeANOM4i+F8fE8kD2SIF/G
 MC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253182; x=1778857982;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t5VUvwmV5QSm/EY15P6N0RYrvzdvXre9m8Jp8WgG/ug=;
 b=idyv+ehFmyCSGPpLdElYeU/vgoa4qQwVx0h69fwUWS0WxvG6lOXXHZyEzKNWm7s6Mt
 25YDNMQ96G2tt1lAAniFd161hBFC59RP2OybwVrMyOxZab5Nj3U9GUO/rWkMF72Y59m6
 1urLNpgr2O+ZlI2Ehd6+xJGgsED5OmTlYqMwXUn9paqFoe1gm37ZVwnJxvTsYPrXgKHw
 KBINtqM0z5AAUWo+oFQuWyIcmYIZ1cuzvXumSJJlNbKF0o9QyxPdx10BIcWTE6T5jX32
 wJcukxt5ur8ySNfEDe7Hhd/0S/aX4tOhQuOWxE433KkGA/gYKeHR+9fUwWnChPZhKDPh
 GXrw==
X-Gm-Message-State: AOJu0YwcS8BVstIm48U8iGTSR7482UKSvy7DJVOFChKat0HJswQ7qehu
 Vt4TmVAtBkyQuDhJf114aiK4fXdA0O9xgqJFO4B1W3OEaYguw2mruixzh1hEJg==
X-Gm-Gg: AeBDieuFsfEzkT/rv1hzGpLzL9EQOEMl1pKewXDrSVRLURSCDvS4Sk7sECMRoON8/PF
 sMBhWrjrneGu479gX6OKML7PxdovWWTQIeXRFYHGxNLl2RrJlf/LuTrLac74U++SFAAPuiMAMLc
 1m1Vynjf8yoLalbAD40eFcUbgqPqar8cER+TEmTuhbpNbcDvZwwqwdwPhkq+BkIBYvXcbKBIFDs
 mOUwGUWY0i3C2gAkqp0VgomBAQKADPVheMnnSFDZxn4KmEdsq0xi0OnJ94hy+cnWj3gWrglDih4
 dOINeep00RiqHGcaeXveIws7MShFS7dZaPDPJASfg0Kl8kgCEcDXKIBzHXWVuKbkmZrIBJLVf/3
 kDprU2vTC3NmWBEIREv0kTtGCRMdlTQtDcgLhWjO/CKH5IO5RHU8bmowZdmXPa3MTeLDO9czyNk
 NWDd+Al7SOPw5+IMaWtT82TDNtLRThXJm8jS9pdC96bGH6WQX+BsHkGjdJaQUstlIbpcFg/peJf
 v7BRkR8p9dWVn63w4r/V6RVqJcFjvphtW0Uemq/Y4HxsiAf9EFQFAg4NBGaDVnjhoFQz+lJ6MZC
 QW5KpeTKTRbGItwFe0ldxSnz3r5Jgaqs93T0M3Iw0Noahgu2LkRtp0+dxDcgvnXwGanbqcBmG0P
 hJHYkaQ==
X-Received: by 2002:a4a:ee83:0:b0:696:1791:add8 with SMTP id
 006d021491bc7-69b25cb508fmr1726891eaf.40.1778253181938; 
 Fri, 08 May 2026 08:13:01 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:04 -0600
Subject: [PATCH v3 04/32] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-4-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the rd == $zero fast paths and let gen_store_gpr() discard
    writes to $zero.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon_translate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..4dd7626835 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.54.0


