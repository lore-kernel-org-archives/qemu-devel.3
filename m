Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB1606A323
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIZVRBxQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQO-00005E-DK; Sat, 14 Nov 2026 19:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQM-00004z-Mx
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:50 -0500
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQL-00017n-77
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:50 -0500
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-36e99cf7bb3so2966739eec.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703728; x=1795308528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8o6DosXQmVuLdfzqPB19mDNYoMjjsir5bC1ZQdkSNDM=;
 b=bIZVRBxQy5skzizRqKE9J06aSPnV47zUTpKV78ulg96E7RKAnldvdW0G/cRIyE9SGm
 qzPO1BGmApH2vHb76K5yRKbeuUtb4ysXe4BG84URFhfJMmGkARgjcezQe5M7QXV0In1h
 xpD0Xi2rjk2l8DWHCpbA8d9NoS5mwNPTnLbrik4sCs8iBg3qQ4o2CL3XlToIFRTbjWBj
 lc91aIK2FLf4yjcpBTZ46pOTijrq9I5vZD3QdOydDpMHSYouxyi57jNpOMKzNicwjEOH
 9xUwCBzQbiG91CiRKYQ15ILPOiPfpL7Is/fK7u/odmkXCKiBRtiaCN6tNdEI5JSo4qyK
 sIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703728; x=1795308528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8o6DosXQmVuLdfzqPB19mDNYoMjjsir5bC1ZQdkSNDM=;
 b=fArrH88ZYuaZRymOVML+iZdj5sGK/VUceu6WsLoBLWGwNmzM1mKFxTcQH0Loqersyr
 w679Bogy/PUJGoEtKkeVqkqKBw8I8gxUk+E/DBoID8gQiIGWxMXijrO/YHaTkoTQmof6
 WGF0YUaeSBpAlphwIWxqszc8Ou5sb3pj051H5UBmj0QcYoAFvMexXlH5G3fwXdjHZZ3/
 aNB4Qs1xctjhE7BZE3bmaFxOm9DXizTYR5hHSgL9JYimDgZibMEAHbjSL4nIT4ldri7I
 AL8KyPQ1bbU7AN57pL1mNPm2u8C9BNlaKtdQPIPIpFe0Eao3gzp1sloC/ydBiCDrY6CI
 wsjA==
X-Gm-Message-State: APuU4Z9m0tM3o4YpG0JqWR+NfaHU3hS8cKmbCt6ndQDMZ9MAPdco+Qbb
 UjSYXKsccDPGYNqnebyU7K/+uUrYLTTIO0esB1sIa0sf70BIxeulaKk5jIDFJg==
X-Gm-Gg: AYBFou2nSxut5wmbXBZ82MvLwNs6bJQvRtcvYC3ADhQb9CGZClyAJkZcBq6xr15kJSh
 VJmgdVLi/WIOGXgRcq//JQk3MoT42oP2bRKgrI+xP8aWaYPoU4jOvMhnwuFE6gddagJInemgSXi
 8+x8axwqAK523wviecL6GBWZTvwpQiU13Qk2DgKXN1o/oKa6Gwa6xV7DyX4VLFUBVQ/fLyF+naR
 ECicyU1eoyXEKwIPNVa9m4Kv6psiaw1Vjf7lkrjFghjt5WA1O24WVTOAJT/NLGfGQWqn3qDjoj4
 drJdqdBYAq2buNh4lmClr7vTjmQuL90cCh2i5O0Lfh7W99i7wgSaFA1SckxAybEpNkhkwF0yKms
 LgioVBsBwHn+fQi3l23y6oswwKfqLGJ1aPbYdSXcz6C78dAsoFOvoBqdDsG6o23T4xZgQQVO/sI
 3oBMKF+DY67CJE+jdOnzC5BvtFIFn5Kl9jb3CU0Ey5qCWYP1P/SWLVU7N2sCKdzKSwvSSIA/UHJ
 Pm+Z67DprAY/1umYWDxkwiTQW/WepZm3oc1elncllXVkO0Clc2j68JP9OtXHIAIGEk55z6CLD95
 UQQg5skiEatonoytMqK8rhrwW1QkmKqGZg8uoBYeBjPDeG4=
X-Received: by 2002:a05:7300:e9c5:20b0:361:167c:2364 with SMTP id
 5a478bee46e88-37966e3ab7cmr7358840eec.8.1794703727796; 
 Sat, 14 Nov 2026 16:48:47 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:47 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Sunil V L <sunilvl@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 7/8] hw/riscv/server_platform_ref: Fix mtimer frequency
Date: Sun, 15 Nov 2026 10:48:18 +1000
Message-ID: <20261115004819.2586336-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=alistair23@gmail.com; helo=mail-dy1-x132e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sunil V L <sunilvl@oss.qualcomm.com>

The RISC-V server reference platform requires a 1 GHz timer frequency.
Although the timer frequency is advertised as 1 GHz in the device tree,
the mtimer device is still created with a 10 MHz frequency. This mismatch
causes the OS to boot very slowly.

Use the correct 1 GHz frequency when creating the mtimer device.

Fixes: c2fa4320803b ("hw/riscv: server platform reference machine")
Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261111101609.1183263-1-sunilvl@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/server_platform_ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 3526c80d7947..22b3149ee8e8 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -561,7 +561,7 @@ static void rvserver_ref_machine_init(MachineState *machine)
                 base_hartid, hart_count,
                 RISCV_ACLINT_DEFAULT_MTIMECMP,
                 RISCV_ACLINT_DEFAULT_MTIME,
-                RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+                RVSERVER_ACLINT_TIMEBASE_FREQ, true);
 
         /* Per-socket interrupt controller */
         s->irqchip[i] = riscv_create_aia(system_memory, true, s->aia_guests,
-- 
2.55.0


