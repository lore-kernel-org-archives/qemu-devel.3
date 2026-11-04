Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E5607525C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=EnOYD/EO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgts-0005F5-Vr; Wed, 04 Nov 2026 14:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtn-0004se-P0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:56 -0500
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtm-0002dx-22
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:55 -0500
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-19305bcb72cso1054762c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821432; x=1794426232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QHU/ErwXhFD9iHEqjLD0nNSzi8owSO0EBtC8BboF+1s=;
 b=EnOYD/EO3YdrmN3Yq4xJ5GpMKOoLQhuBXkdkOceJDMHK6sjRo7E3PqKYidqZ19uoJ7
 nNVDAR8tJ8zCUkSYPNYc4DRnqMPx9rn+G89Pei0iv7x17RxBCu6daj7Tj8S0V0MZBHGy
 C8QvAfqcASqyDidtcX8uK5AMbXVLVJ/m/mZfX70jjUILit6luiq6+8/TKjYA5fcIZ8jx
 TGDwt0bAhqnwNw+vA3quDAZwFdX2TBqS5fM/5esoWE3C2OcRzETof0eI+g8PcoLq3MKY
 Yz5sfSoMuNg3HtQ5ahnFeNiaxqZkOHGhTFk6vGxpDxzlLK7tabAE+8d8F6fWSo9wVj3l
 WMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821432; x=1794426232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QHU/ErwXhFD9iHEqjLD0nNSzi8owSO0EBtC8BboF+1s=;
 b=AMfWQIyZEyjB1fZ9RcUj5JidwrGPvCdocZzwZeBQJCVv3qA2yAPY7HrlSbTyHRMIEZ
 UXXVWF1EKlvUk1/qR8rOqLEzZ8ChrzLJTTO+hmcxwOI7HMjLOBy+FSE385aoxdyWnMlp
 O9qBPImj4p11HoRd4mTrYb21sRbE3x38T1kysj0mtrt33T7eYPrWdS1s26m7cRqp5NuV
 p6fFx4gBsPKIRNxfo3q8TQ4C6GTtnuIBkjTKwhr9J6jIQ0t2+p0EiCiC9ZKXI7Ynr8c5
 2dRP2RfmaWm89EdqF82x6kFrALez72ePzcCHLBKhuyWTFi9KYJz2s3gkDZP8H1xcTOeZ
 7kSA==
X-Gm-Message-State: APuU4Z/1pzHp4i0HDoyktxrqYQKZujZbiSL8luiYAshQvjA1DlP+5+o9
 YFAV4Hh8LbNYIlf9zyhwI8pIUUFlYd0aT3tnukiERAP8nWj9zKepOYPNzIPtU2ljPS3h/HSE94j
 zYzCGCW4pFO8ECBFLaqosiEDDTeaMm3h4HgP99+GkN5iYYr4keilU1/5j8OTsKo/rnpKIV6ziki
 shPHbZU0iM92jenUmDr/mXe6xxfoyA3GblmNHxRfd6Tw==
X-Gm-Gg: AYBFou3lxQPpABQSV4yl06I1SaCl5nRRerrT8myZI7xj0W9XajoBc5ZRP90Ji7ktLSF
 QkHn3t+veaz+iMQgxkV4A0wi+D1sbPZj22gj8AyshXjzb42l60NOEvNfhlDzSsnsoXGHO6kSpQL
 3aP8ztk3B0c9mWJMQLx3aPJ+KbmuBVRGkgZl9az/0b2ylzqsvojTfP713jx0/TPizsa0xxtiNOo
 3npTWoHJrlz9tqb0lLngRYKBlIfXeuscb0+fYqQpGNf5A6DnKvbCwRuDZt98o+wMHOPVSmgCKsU
 X5GiOVJ16J+u6DHNB51fDmN6L8s9PzwcI1TpLDPM3NbLKk+UXyvuVcBIt8MB4FIXHzCAaxm9wIr
 naVX/LAjnMH/qLNJeBJh+Bgz7ev4Kch3L7sYPcBmCisal/InH7UF6oMIuYoYut3lkXEU5YFLuNu
 iO45jTzxqJyyBH5GyQkasWjVmjPI/8EAIYhXWzirIEJwX60Z1a/cWmUttXbzzzO1XWic2/ZIMpC
 qSJZVvOnQLlrySaueBoeWS813g9eYDDlksoOXQO46mdOBP+SD4lzg6TchCknJUoMzW2PUlF1zXF
 7XXOOlgbdwvSKPgvFWX+YSFnwPk2QNjPLiQSq8qNJLirg7Vcfg6/fVjc06XjhX4TBk88yfKY3KD
 humyg0YgZ2vJqrLNllyVil7Aby+5/T0ZFRXUPBhsJshxhiISbAQ==
X-Received: by 2002:a05:701b:2059:10b0:1a3:87c8:7efc with SMTP id
 a92af1059eb24-1ac5cb186e4mr25908875c88.39.1793821432421; 
 Wed, 04 Nov 2026 11:43:52 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:52 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 31/38] target/riscv: Add implied rules for Zvfqwbdota8f
 extension
Date: Thu,  5 Nov 2026 03:41:46 +0800
Message-ID: <20261104194155.679241-32-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=max.chou@sifive.com; helo=mail-dl1-x122c.google.com
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

Add implied rules to enable the implied extensions of Zvfqwbdota8f
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b4a9f2c3e30..0a35bc7c416 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2892,6 +2892,15 @@ static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFQWBDOTA8F_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfqwbdota8f),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVFWBDOTA16BF_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvfwbdota16bf),
     .implied_multi_exts = {
@@ -3125,6 +3134,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED,
     &ZVFHMIN_IMPLIED,
+    &ZVFQWBDOTA8F_IMPLIED,
     &ZVFQWDOTA8F_IMPLIED,
     &ZVFWBDOTA16BF_IMPLIED,
     &ZVFWDOTA16BF_IMPLIED,
-- 
2.56.0


