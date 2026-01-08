Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D809D1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrmp-0002Oh-0v; Thu, 08 Jan 2026 10:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlp-0001GK-GO
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:56 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlo-0003qj-5c
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:53 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-803474aaa8bso1139614b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885471; x=1768490271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAQpf0m4HgwG3NyjurT915nb5JF68SP63rgAnrYfyaY=;
 b=g5ihM7HrsJy+/tvUB/pV+elxIi1MXqhwJXtpKO8rF3InMxhzQyH/9Ho/MALnoXlQVm
 p49jQpJofJT6VU5QsHB2U4sZCMKbqKu8Q2eN52fIrRQ8uS+mI8XoxEeaVmHx9V5Opj/Y
 3CBfYhJqCyo0GUdIFAlUgxbEUvp6ZGjZJIM0Tmxfd/W2XZ59fZV86IyEa0md98rMX4Ac
 Mj4HG6WkKFHFcW8/sFIwoT6INwJKrPRUoiXdC/58P3SvN1bfzvqZUqzMop9mc7IAQZ09
 wLv7esqnsPF2mSouLXzDZCIvJ/zgaCF9Y+HEs4hjTOEh7ECJzCCeQOTeFybxIvrkgwMF
 rWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885471; x=1768490271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nAQpf0m4HgwG3NyjurT915nb5JF68SP63rgAnrYfyaY=;
 b=u1lR/CRSRQTegAqSpT0rWX4orw9czObpPWVbDgkQr0eTffvh+rO/OHJEYzU1kM660r
 Q7JjipDtd33PpdHdn0UBrXxomhWKZaGA6NpjgA5qsYmrSEXSygTMOy17hxvSVx0X6Jgu
 sQVuZ/79yAXKha3ymvYBfaRDOCl3ZtHhVvfI53WPSGyJA/cZtwbsbMJx4GiQTnfv4XKu
 OhnhS1d0X22i2poIad95u6cWNaX1MevcQnqCmymzLHScMVsMedJU3UUQ1jqireEjDwi4
 xxLE2MZ/CnML8s5g5MeN4yF50Ka5ufhoaUTrb8HI0Cq7OZcPKKJ+Y79OK7kCV+zF643U
 z05g==
X-Gm-Message-State: AOJu0YxNXME9iapaeonKVUdmBEP/0w9b5udP6t9BLgieVjnoPlE/iD7o
 +hXyoO2asJCYe5SoFmcKhjlG9APcpqd9OF3eRsyR8fiZ/u7YQ5MfSKzO7m7QZwWpwBnw6SiN/iQ
 qKKboobFWXrkRJP+6fiRDB19QJzvBLDScU4ZAgTfGl99Xg27eLfKSdKI4xzZfEaypozkkqbN8Pn
 SN7wQdITYu/1N6j7o8/X4Esea+uQ7NfcsAi6A+6y4=
X-Gm-Gg: AY/fxX6bHJ0rOJur7vFFuFd1BDUCn2fdV7q+zjRtO7A3a5pSyUzIb3tLU7WtnBXQS5F
 lLI3YzNwm98JFPxa3uLOWRoncUBIDjotkGICQGIWTphMVPQSYaMT80EAygp1/CIxT/7euT3gs4X
 5cXX53m/sK4aaq1kQ1y6C3YY6z2C1G+dOpIX+7KN2LC5oNO7YULl1FtmU3i3dioLw6c+f2ON+rW
 wbHtxalMJQdzREL8WKbDOKwtd48B4/uHELhPQU47nQ22zhCTwdLvc0xbBmOAwFxVgX1ktdCwqn6
 Ks451OFLq66XIR/SZUuymHwtz96TpHSkULsUiCA3L2qsPSXFSsJKD8ctGdCvn4JuC8nn42hTRTD
 ytqeqU1WMeQ5wBfimAFYNCVIBp3J5kcqH0ozAh2VPtNiPLBeINuhYHQ2E1K2nc1U6sWHlmDP2rs
 SYitu/VMzx6YFXgFiC9N4m3ptVZEFFi3S2ZJulpXgT/RuQx31/QFb6o6s=
X-Google-Smtp-Source: AGHT+IHGuN6de/VSpINBTuPyoU39vA6cUPfVBirAJTJ114oDuRmWKdZ6fDIFuxQE+OjAnG5hVhyNRQ==
X-Received: by 2002:a05:6a00:8d8d:b0:78a:f6be:74f2 with SMTP id
 d2e1a72fcca58-81b7636899fmr6157148b3a.5.1767885470565; 
 Thu, 08 Jan 2026 07:17:50 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:49 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 17/18] target/riscv: Expose Zvfofp4min properity
Date: Thu,  8 Jan 2026 23:16:48 +0800
Message-ID: <20260108151650.16329-18-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ec1bf8034f..0345a4f037 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1390,6 +1390,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 
     /* Zvfofp8min extension for OFP8 conversion */
     MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
+    /* Zvfofp4min extension for OFP4 conversion */
+    MULTI_EXT_CFG_BOOL("x-zvfofp4min", ext_zvfofp4min, false),
 
     { },
 };
-- 
2.43.7


