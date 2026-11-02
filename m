Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67330606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=e6BqCbCm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDi-0004ck-1v; Mon, 02 Nov 2026 08:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCs-0003AR-K0
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:16 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCq-0002Gk-62
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2471393f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626571; x=1794231371; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YqXkIrZd8lJyYdEunN1XXS+L2/5lLobvR2vCxboFx1o=;
 b=e6BqCbCmCBGAruuiTna4vw+c6RKtIZ7PgcFPrOlZz0jfeMnPsAxQDpKoEtBJMgQ9t6
 SLRQcRAQ8YMKDhJjth9F+Xa+H91NyaNKkC20TDK77N/IIYRsEXxLg5+HxAnXfs0wpE8q
 40RzVpnvglgGaA2Zw/I0JV90s4lKso3duxXySO9vcvvkceKAx0juuywV9Zd8aijdBE1t
 4pYe9GzM3H4k1YLWy6BxGl2q6PQM7Om3wC02MzuQELYIM/sg1aWrIdMqrG3FvX6TQ1Sy
 du1WHO+Yrh4KfBVEc836W9alxamm62oRXWgm9vzGzOsex9bSpBrmnaFJSwsoLUJIRC06
 BdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626571; x=1794231371;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YqXkIrZd8lJyYdEunN1XXS+L2/5lLobvR2vCxboFx1o=;
 b=T5/501IwfQ9tHpRP6K1e5DmzJG99PSi0iwq+8PeIKFT/JiVN5eXaUHvvuYjaBwMlPX
 7NtqvCR/NusxMRO2W4qEHELUoaMnUS/Ci2R+yvUdN4n8ShgqZfSHM0R6xni+VcOjvtc8
 9Lg3x3W5QuaueFXN533VaDRMd0T7XPL1P7BvYXIdA9uD82iUWYP+UzfqIexb7O/t9Zc7
 NdS00aWfyQVlsBeb1wwLs29gesoMxe2gJJ2Qvozd8d/MXfrv5gtAC6rpiIoMvUWFgFdk
 ftxWARSDaYQVfMAPw2O/eTq17Ux3xB7rZJm2Y4WXYdfe4MQFaSkVpCv6q4UkXBsl00vo
 UpIA==
X-Gm-Message-State: APuU4Z/bY0bIomVhRWiavXpNuzDSKNkbX3hKVV2N0r7mfpDiR6o5hZ+a
 x6e0I5bGRqD+l0Sa+s+dijuMJ1p0VJOUZ1X/Id8nqQirZIM9sGkagIx6S3GJFX1AwmfX5fsu3vI
 ZU9iw1AM=
X-Gm-Gg: AYBFou1wJjaH2bpZPnMRQxu7yaAGWrmH5dLSPCjbg2vAkvbXOzDDprMii3G0Smu2YHD
 sFhZejH8+ywjcpAyROHiLtb7iij+1Zn7eo/2CNkbLz3kq7/a+DM/Y0Xjshc0Yq7XVHsUvto4b8o
 wkqdw2+jwntAx0YJdnu+PJavMWmdpzXbKRaWJWN8fb7HZmMoa2VOhEHhzaW4Im2u0rjcBXmMVIK
 PjYa6L9mNLaRH3G77ocS452XXOZLseyHIHkcZaCHj10DworyD5HGpyPHOYJMD0+gFdtHs/4Tapj
 FxL9YXlGM+vkePHartb6nlbrwAAtyMShtdRTJTtLkYyjXxTpCyxYg0hFSER/vHLZfBAkENLi6SH
 Ggsaxj7ONgfiyyfArXqFBaDblHVCXhSPz3IeIblfuz8wIJRAtub5RHgyGR0P3PIq6TRHCTb+F2K
 Tlkq7ynnnPmPXcTYxnoy1JmNp3u43lJE+uM812iemO2k/tp2mR0UyQrXEXWAnhtxz2K/QfBrjRU
 Wh1lbTlwD7IIe2prPQgOC3oNxEWcUy1/fF2DLrJv54oA/1lT/Zsd7mt1shmY2CrQYK6bUxoHstb
 qMsSs+UYDhckyp1an9qdaMX9M3bshSROA4/U1aM7sGtzAhrIGFckqiDrAjjqyPzVfcZ/rzDi8Xx
 jLVQcY3M6Nlvp54GR4H6syqxt1wPR7YsAEw==
X-Received: by 2002:a5d:588e:0:b0:48e:bf0:35c with SMTP id
 ffacd0b85a97d-48e6e4f543cmr20890743f8f.13.1793626570705; 
 Mon, 02 Nov 2026 05:36:10 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/47] target/arm: Initialize SMCR_EL1.EZT0 for linux-user
Date: Mon,  2 Nov 2026 13:35:18 +0000
Message-ID: <20261102133547.1375701-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

On SME2 systems, Linux sets SMCR_EL1.EZT0 in cpu_enable_sme2()
to allow user space to access ZT0.

linux-user already initializes SMCR_EL1.LEN and FA64 to match the
kernel's setup, but leaves EZT0 clear (see commit 3aad4bc8beb9
"target/arm: Add zt0_excp_el to DisasContext"). Set EZT0 when SME2
is present to keep the emulated EL1 state consistent with Linux.

This has no functional effect because CONFIG_USER_ONLY omits the
ZT0 trap checks.

Reported-by: Samyuktha K <samyu@qti.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261026175220.85545-1-philmd@oss.qualcomm.com
Suggested-by: Sritam Paltasingh <spaltasi@qti.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 510fc9eeb3b..cc104227395 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -387,6 +387,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
                 env->vfp.smcr_el[1] = FIELD_DP64(env->vfp.smcr_el[1],
                                                  SMCR, FA64, 1);
             }
+            if (cpu_isar_feature(aa64_sme2, cpu)) {
+                env->vfp.smcr_el[1] = FIELD_DP64(env->vfp.smcr_el[1],
+                                                 SMCR, EZT0, 1);
+            }
         }
         /*
          * Enable 48-bit address space (TODO: take reserved_va into account).
-- 
2.43.0


