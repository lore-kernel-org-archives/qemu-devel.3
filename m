Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF31D1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlo-0001DZ-SB; Thu, 08 Jan 2026 10:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlZ-00015b-2x
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:41 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlX-0003dJ-Dt
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:36 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so2340932b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885454; x=1768490254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6mlGA7uiLEOZV5HBdCHILUSjjtgFUZKMqLepK9svPQ=;
 b=Vx5aHZtVaQfwBuIbEmxzyAFF8ciQ4J0naouV0jP/dHh9hjLzCS9rg5tjIH8U7xafqt
 hu0fbnv5kDOkMtgLJMB0s8SPZ0OR2f9WtHbis4cuS9bXNNNI5jvhdgF24DgUt9TC3HTr
 5YglNqgtzOwpCBugLJe4al/pKqV3aplN6FOZKWHQpDiWChqJHwovz2FZsVQkJZoUMnDl
 4IeRqElF+KMhCkQ3gZGYxgGaEC8pF7inNzmh4LJ/5LTYl+Cihy3SBCWBNYRuX2QydYTI
 NsjCXbJJqLNk7EIal1nZYj7N9foU+YT13GeWL7SctNfcZFTHqeeLX1hlEWxkW4p2A28C
 VNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885454; x=1768490254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T6mlGA7uiLEOZV5HBdCHILUSjjtgFUZKMqLepK9svPQ=;
 b=BhABL8zTsOYGgha39UY3bx+UfxouOw2fUGjGOnAuhVIcIhpxJ4Dabrm3XlzBm7nMWO
 ERFwISC2Fxk2QY3TUN8fXIQfMwoEOYgPZznI/FKwiKT+RWLb35OrzrKh8fEzQ0U13lz0
 QQJSDVGs5FNwFrvuu6ummzCKeg9k5u07IB0sdGxpWozhMGKs9p7+FIgxhVElQQEyX9Zn
 hHyPuqCzT3632Vl1vWjOHBsj373cO5U1dh9/YIJ+ApNHa8+dJfwtoYdnCK0x01TdT4F+
 wu+BtBuerEsGMatoJb2ID8qou1cHDKcIx4PyBxbbbMSWC17efR5i5dCPqVCxrE2iIcmY
 YL7g==
X-Gm-Message-State: AOJu0Yy6wLi/hHT2JnpqTPhYIorTg23FhS+Iou45oU5wNa/phTVbGA+d
 QWrP7VApBpir8TEMJdZlF/oyf55DbbxAagi9HXZPqtcszZiwmmqURxNanN/w4TeQ4+y0Shh9vo5
 oAnQqo2biIA97FW+GycYThIt/x77MhdHxBuwSXryNTyOrpyYBTJHJagBPvPavJIucoc/WtSnnYR
 OR8PwqeYXupFa36XyoFx2cTmieKw6FxFAOwZVyaQc=
X-Gm-Gg: AY/fxX6UDK2lOO2dnj5iK1J1data2jwVWI3Fzpfi8NUB/kwtAlp+QYCSjT0znCc6aE8
 p4MnztQmsP3QYRlLg3RZ03DIRa19Vj9wj7dumPwW7oR+rTAZbi76T90zE47z99Nw/tmOodm2y0g
 jtfF5SrcTf9yQ216E4WW4Mg22OiP2PL4BdHF3mF6zgebDTBJcCg1KGMgHAwXlM4JOiLxHpWKRPu
 TnshCWIi4EF8E2cqSJ+i1rsOLMbXGCBo+aPheP8/W+nc0piewUqoAACckzFZOVXGbyVKxfXw9WJ
 /jj2fD/vV9aFbE0vdsXFAGRD6ac0e3VF6bdl1gGJqcV7EYl8AZqqC88HNdf0U8+WIhHtXR5ne1c
 2wzFawRjNfwsudLEAFe5ehyXqm10OoplBftPNC8LdyVOQgZzb7SryJi8e8dgcWqYD2A9BMIp2Xf
 bv0tzWQ5FD0uKhwzjG21EEE8W5MLZWTbhD9GJC735j7axtTulzOZZVUS0=
X-Google-Smtp-Source: AGHT+IE7N9ahMUH+iNF52myOONC0Il6vFKSBVg0XcZikqy00rMtvgzcIiWvqG5GAujLrf59cf1SbkA==
X-Received: by 2002:a05:6a00:3487:b0:819:5db9:6c4c with SMTP id
 d2e1a72fcca58-81b7d95ee54mr6114229b3a.8.1767885453799; 
 Thu, 08 Jan 2026 07:17:33 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:33 -0800 (PST)
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
Subject: [PATCH 12/18] target/riscv: Expose Zvfofp8min properity
Date: Thu,  8 Jan 2026 23:16:43 +0800
Message-ID: <20260108151650.16329-13-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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
 target/riscv/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 53b5aeb9b2..081891c97a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1387,6 +1387,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
 
+    /* Zvfofp8min extension for OFP8 conversion */
+    MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
+
     { },
 };
 
-- 
2.43.7


