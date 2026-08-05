Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01633C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wreiq-0008Iy-It; Wed, 05 Aug 2026 12:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wreio-0008IH-Ew
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:44:02 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wreim-0001wa-Td
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:44:02 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso921943a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785948239; x=1786553039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GcM9CWd/ht3d20xl8qsrrISWs+dRJAPurFgEz0tOvKM=;
 b=nXLiSCFwvEjVes3ni5KY3w14CZj9l7UMYhK8W1XOH4eaa9l30KFHFFBJBpKD4/wRSo
 ACGUMXb9zDPQBqArmKurHmDjJLDDR0/EnYtmEn87ADqZZIAJhqjLnzQrRadQk0vkPF9Z
 s7TszKKXIN1kvQ2n2wZ8qlg+Iqy3jt//1MFc2HCtx+9l4fEYEgAEsoSGMpvxAGxmku1S
 s1eRE6RHZJSAXelTHt7wNMpojHtaf1gF/TdwKbhWueD089RfDs1rDaYedNmlWPcj5JDj
 vGa6Re9wIMfGW7gR93PX5RbTRv+3C0V+ZMVX7MaTQbcMcts9a07Y61eXWY4Ws3cDW9WR
 U1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948239; x=1786553039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GcM9CWd/ht3d20xl8qsrrISWs+dRJAPurFgEz0tOvKM=;
 b=oXQDlkB64nEHYsJKAUj1NQxS0RCOrmKzlr+dEO45FjQz1fQ4Tb6Mbv3FkN/9CJsqIf
 PWC96hZxfZgYuBvGfAqc8MpAkGn0EmNQjbxHO2/Ry6hAPmnuG6S6Bbskj5gyEdGExk/V
 4HSoZl/hNgDGYyCUsrCpRgki3Fi/xh7W5WzvFi+ZaApPYoEG2n24ni07H8cUQDXWvYJC
 K3xwefiFFwyMGQW6Y2wKkGzAlOwUN+lspluaHteIDvm4rb0X3nmgGqiaq3PhKsYaOvav
 cEi0xbypwDWjKHaBV5El39L7R3Q8E4xt/0PzDZIe+CAlAmdeMA7CUNZQ8xhslDFa+xek
 ZVRw==
X-Gm-Message-State: AOJu0YzBUrWFWQGYW0c6p5ZO+z7+olcBjys257qqa7KUTR5FQ+2AhK9s
 DPg/gaU/VA/N7t9jyiMcKCFylUaXEuhEf+tL23V5zBCap+6lhvBoKj9tNDu8577SsDglpwli8CV
 FRqGgz6VSL/j0q/w76u0zgthlI1Pk5A1198AlMAFdidVROLufn6PtnxJah1eZcX3FovKwd36EOH
 wWdBdFa+WRuF0BMxv1zjGhRd3pFfQ8E/4FF9Zo89iCJzM31aIj
X-Gm-Gg: AR+sD122538/9Amdk/A+CAV3u0X2Nww84GfAd2kFX83dP1NFfS2ufb0BG8Vle47PsCS
 3Qdmu/EjHgs9Kn+XVx3cQv/uIj5nGu5xUByQjS2InsRFsJBwa80KAIEhMPRm2fGJekK7yU+XDdF
 79Xv+BNHLi5giRLf9IvzoP1Z+M0uZF0KWdc7CcmWBO5Ium1kgMp2gwWUwKsThXYyY6Rxh9TyFRN
 S7tw3UsJtYHd7Qq89Jj2YWJCtLSMNhrsqUi2mdgnDIROrlHNd5m+Cy8C3iJKNG4ZX4mw7aGM21F
 5TCSVZf0aztuoXOdFR879xfCsx52YlZ9JLTEeXE5BydXjoj1ucb00pEhBl7++GK4WquqWlGepHQ
 CXSMbFXgV7G0wkCIen3dShlQCXxZfDQjxPNZLl6u+wJy+YlZzawzkb1elLESmLmyTxUpChc0Qya
 ElnMQqvaRNizdjvwjSumAxYO84DJrxmZ1o5CwMktj4sJCYw6/Y6YtFqe2gUSz2t9gEA5aW5eb4w
 sFlW2QA2MqO9Y0=
X-Received: by 2002:a05:6a21:2293:b0:3c3:994f:b4f5 with SMTP id
 adf61e73a8af0-3cb85eefa11mr11170785637.28.1785948239470; 
 Wed, 05 Aug 2026 09:43:59 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm16719065eec.13.2026.08.05.09.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:43:58 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 3/8] hw/riscv: sifive_u: Align ROM reset vector data
Date: Thu,  6 Aug 2026 00:43:40 +0800
Message-ID: <20260805164345.698208-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805164345.698208-1-frank.chang@sifive.com>
References: <20260805164345.698208-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

The SiFive U ROM reset vector data needs proper 8-byte alignment for
RV64 ld instructions. The misaligned load will cause exception when
Zicclsm is supported as SiFive U CPU doesn't support hardware misaligned
loads and stores.

Add padding to ensure start_addr and fdt_load_addr are placed at 8-byte
aligned offsets and adjust the load instruction offsets to match the new
data layout.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/sifive_u.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 99423ef472d..57a57c96e16 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -564,19 +564,20 @@ static void sifive_u_machine_init(MachineState *machine)
         0,
         0,
         0x00028067,                    /*     jr     t0 */
+        0x00000000,                    /* padding for alignment */
         start_addr,                    /* start: .dword */
         start_addr_hi32,
         fdt_load_addr,                 /* fdt_laddr: .dword */
         fdt_load_addr_hi32,
-        0x00000000,
                                        /* fw_dyn: */
     };
+
     if (riscv_is_32bit(&s->soc.u_cpus)) {
-        reset_vec[4] = 0x0202a583;     /*     lw     a1, 32(t0) */
-        reset_vec[5] = 0x0182a283;     /*     lw     t0, 24(t0) */
+        reset_vec[4] = 0x0242a583;     /*     lw     a1, 36(t0) */
+        reset_vec[5] = 0x01c2a283;     /*     lw     t0, 28(t0) */
     } else {
-        reset_vec[4] = 0x0202b583;     /*     ld     a1, 32(t0) */
-        reset_vec[5] = 0x0182b283;     /*     ld     t0, 24(t0) */
+        reset_vec[4] = 0x0242b583;     /*     ld     a1, 36(t0) */
+        reset_vec[5] = 0x01c2b283;     /*     ld     t0, 28(t0) */
     }
 
 
-- 
2.43.0


