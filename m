Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129AC982D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7VZn-0003Lt-Hm; Fri, 18 Sep 2026 06:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZj-0003K0-0H
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:12 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1x7VZf-0007aP-5Y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:12:10 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso7705455e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 03:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789726326; x=1790331126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ImzkDyQh7LMz3GFaLfWGldnOX3oL1DgmW35r5Yk//gg=;
 b=LPuALkdbaeHekqTo7mHC5SwbgWnMegOZuclAdtHABR0NUnug2FHdPamhmXtLmexgaD
 Tl1iPHu0XmOBQ0ecCvwJvp5V742U0g7IE92xfTq9kA+36FJxu0aVUOVO4b1BYPrYNSHO
 bahmTeMfcXV0B6gKrmVZkMp6oGZd4SweQGkIzjDoglSD82b3HR1rb+7gIdzLPNHjnzMs
 ySWjG7vgjVGayZhxMI0B3oYSehB+OvED4pkbLIevpK9xCBDKd/PhLzSmYsgkbU2r4Q5y
 z41fGf4Qo+EvdO9qe+kD/AeiuAey3IfNJVBEh93ia5fZ/C0jOm0nUhwSGWNOn0Aj1Hn+
 JiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789726326; x=1790331126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ImzkDyQh7LMz3GFaLfWGldnOX3oL1DgmW35r5Yk//gg=;
 b=y/7K2XdwBK65yLoqwtb+FOH+e62c1KNhVROhsKC1zePkxsM0pvUVHJj6vK9w5DCbrg
 d9mGbjsYZn8TpuNQ0EzUIGuv7DbQh+NqstVmMlzvEWSQPA8PPa+zyO6J/XPcOwC5uAsP
 tpSszZJpBvcbo7lg69G2kG1fEA62+oeNLWBo9WVsoqpSl6u1Nmnltfs0UbB/lPbg8k0X
 hJCSM8/FoXwEIdWkx1YjONrxAz/DmYuzJIVeZan2y/Li0a59bBVICgQckmHMM9UAcxZr
 ZxhU7Zxp8k+ArFiw9foB+KWyxdWv06uEINknsmuGWOT9fhJhSbWq+cJiSVnGoQ85ugE/
 lgeQ==
X-Gm-Message-State: AFuF++l7lesRkfOGBQqrt9Qa1zzznEf/24Bd/lT+gOy6+2zUDgFPNueB
 tcRBZEHbHdANL+KkJBZQH/3donwSD82abbmBnVaf6t206J6N5kSLrWNFSurPXkmN
X-Gm-Gg: AYBFou0ynRw7Xu/l6XXi75WFCthaWs8WqotHbYzTC1SpGu4CaDsaum6v4CnJWyQcGQr
 NiYPdkC4orDHtWNuo1cmlhW2WS1ohzwmE4UE0CBqo1mOJVUEq5wkhsR9J+Upg8OduvuZE03Vuqu
 f/a9KkCHBkNAJJu/boqWpwl09zccFjX4FQD4N55H4ntPSWY6+li5DPlO9XAUYhTwe8mlhuqGSRG
 zsZb0ma8YX3muc5ki3VET+ANNSToYnFHjn9gvST8wnC/XfPK+sykLhS80FdNIhmpuImd1zGF351
 sMOPRloE4qYxNDlGziIh1I1ZSBtwH10+0J1lYQTTWQ0rjLyybXC5PpMOvHbXQpr7Ff/vNIdWPzN
 1+3US0cYwovS6gaY0+xD25k2kwO6/4iim7bGK9ECH3+rwBH3nyazOLMMDB41+pxllgdkq4ZdUMu
 gkshgNHss6KSCDk2NmZgIM/yNxLf0VbJXnfVH3zusGqkKFOA8W/UnMoPxdlnycD5lFOuG/7DTns
 JSgbVHt49inOEe2PLjGvQ==
X-Received: by 2002:a05:600c:a14:b0:49d:1e09:694a with SMTP id
 5b1f17b1804b1-49fc568f869mr22070695e9.11.1789726325673; 
 Fri, 18 Sep 2026 03:12:05 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc20:5e84:de9d:56c6:df83:7819])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd225898sm153886245e9.9.2026.09.18.03.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:12:05 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 5/7] hw/arm/xilinx_zynq: Make PS frequency configurable
Date: Fri, 18 Sep 2026 12:11:56 +0200
Message-ID: <20260918101158.42101-6-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918101158.42101-1-corvin.koehne@gmail.com>
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

Add ps_clk_freq to ZynqMachineClass so derived machine types can set
their own PS clock frequency instead of using the hardcoded default.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/xilinx_zynq.c         | 3 ++-
 include/hw/arm/xilinx_zynq.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index f7190118f7ff..1e09182b1cbe 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -253,7 +253,7 @@ static void zynq_init(MachineState *machine)
     object_property_add_child(OBJECT(zynq_machine), "ps_clk",
                               OBJECT(zynq_machine->ps_clk));
     object_unref(OBJECT(zynq_machine->ps_clk));
-    clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
+    clock_set_hz(zynq_machine->ps_clk, zmc->ps_clk_freq);
 
     /* Create slcr, keep a pointer to connect clocks */
     slcr = qdev_new("xilinx-zynq_slcr");
@@ -480,6 +480,7 @@ static void zynq_machine_class_init(ObjectClass *oc, const void *data)
                                           " jtag qspi sd nor");
     object_property_set_default_str(prop, "qspi");
     zmc->qspi_flash_type = "n25q128";
+    zmc->ps_clk_freq = PS_CLK_FREQUENCY;
 }
 
 static const TypeInfo zynq_machine_type = {
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
index 33a68cdcd15e..a52caca18eb9 100644
--- a/include/hw/arm/xilinx_zynq.h
+++ b/include/hw/arm/xilinx_zynq.h
@@ -33,6 +33,7 @@ struct ZynqMachineState {
 struct ZynqMachineClass {
     MachineClass parent_class;
     const char *qspi_flash_type;
+    uint64_t ps_clk_freq;
 };
 
 #endif /* QEMU_ARM_ZYNQ_H */
-- 
2.47.3


