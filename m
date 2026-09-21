Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0188C982FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrU-00069F-AU; Mon, 21 Sep 2026 17:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrS-00068h-ST
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:42 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrQ-0000Bc-9x
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:42 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso1262895f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027259; x=1790632059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yUkg0Fkepwg9pVwO14b0SVO+7HouXz/Cw8wAdm8kMeU=;
 b=USfTvXoZQ9R16NGlPsjyKpdHRVu9oxdXq4zk40obdbgTqDGFXo+I9ca1hxb5Co8S9+
 KuRP4qz+QHNoHe2ESRCBYXZje1c4PYI8XUwN8dTM1nsWzuTd4B2A16mfqb86B7BvEaW6
 YQOOlxMnjyvEclvwGzE3tGQK0qBdBPCeW2guXjupC1k2fahdKzO3ebyx0MIbAKA6/10N
 0urnxg0bmOyUf43dPdyupcR2gmw/h5e4dtd6r64wuQvsxJGnd9DSWNuJkEjSa3BiZeZ0
 5dB1F+h8Y2/HvB/5pu2uY0nWvyRCucjTPjmS/tCUN3OHPIGsAkTYtg+KBqjQNlIuS0e1
 tMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027259; x=1790632059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yUkg0Fkepwg9pVwO14b0SVO+7HouXz/Cw8wAdm8kMeU=;
 b=eG6eQs0/z/Qb6CSPixufCwCnkR+On7QQXpAUNP/uoLbCwnRDEbH/INZhZ840B0rcMq
 4Sqij9btByOVu6p6hMSGv0Jv5m0NMtFM0QT5LqcwS5zCELIs688bYLnsQXgzAWDAY50x
 JqGv+jFnMbZl9gkfhTxtWnw5rYLzQyTw2oURlGlDIBV9Gz1PaKiMLulm6sPCdPpX7Qsr
 fD5Xbj7ydPuxjumk9nDTNLRdxt+YU/rIr++EDC1o5IaLJmuQONV8Kp00NYxa1dlf4nFk
 keTFaKImvdbU/lHKlIqRnCWBbO68jFdy76UAupTN2fzKB7cDfDWLM+dYiLrj9wBwxQvR
 3wsw==
X-Gm-Message-State: AFuF++lQqshRvYnJ3lae0f2SyRbinvrbVauGQSLN0I7jvvXP/FvOzF/x
 6gE017bXLXU0dtCRkqIgrBgZubAJEdrJ3LhZW1nH+d9IGOcbUlzV4PeKg/X2PQ==
X-Gm-Gg: AYBFou1E+AKD+mlW+a+N93QV2fABqq3KsoOHsudQ6vhVq2PJImo7Tbsobed8zcry8Bn
 9rze6LG6df7aikWnyqMedM6xc5zYrPLxa5QLWyfvTOEYgsHh+p6N2cIFRSsdIn1whKVJRL8FH9n
 SFQ2t7/6yR6haRZw9hlgIpQphj6qTvsLQk+EzQXkOLa6xuaeoM9JACK/ivxQtRhwksl+HYfZc0A
 FFCZuCJQVaB4H+3PlvzedeStTQKBFVM51lzNgml7t6H9VSxwF/P5/lDKXmxXVyA6Hu+i0bag1mh
 vCN8lDMqlhfvNjArHGMuoH4IlEDITOMFm9cakrpX49HI4pUZSoSlX6X761wpACDqA5YpvXCO4CO
 b1ZRjXoYQDARSQBQppIUYDacRzbhNLBshqXEmHGmdx/lk3q/EtcFVQePuRsd7mOwG9GqGeE6szK
 Gm06/jlgPgssXiLJlZPapYPXMTJQBHK6etvFQysMzTqLmotcLEyDfLwbnVNbA5AnEBc0FerPelg
 u6zzPrctOGp3jpDYTbv0SGPdpfhoZga0TTbsFo8XnQVDG9kBHHAJAMrZ3QTtdEyqSGddjY6Buk4
 3QQ=
X-Received: by 2002:a05:600c:3115:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49fd8a61877mr14733175e9.10.1790027258742; 
 Mon, 21 Sep 2026 14:47:38 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:38 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 09/42] hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM by
 default
Date: Mon, 21 Sep 2026 23:46:37 +0200
Message-ID: <20260921214710.29422-10-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Having two CPUs and 1 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-smp 1 -m 128M` needs to be passed on the command line.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/mcimx7d-sabre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 8d223fca6c..8905bf0016 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -81,6 +81,8 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "mcimx7d-sabre.ram";
     mc->auto_create_sdcard = true;
     mc->ignore_memory_transaction_failures = true;
-- 
2.55.0


