Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47035C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObN-0000xb-UG; Fri, 09 Feb 2024 05:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObM-0000xL-My
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:24 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObL-0000GY-5R
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:24 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2196dd318f5so520837fac.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476361; x=1708081161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0nDmbykjvknz9prmwYgoWA7RrP+4zfTHRcynakGz08=;
 b=V58PCqYvtv0WiyIxH//RT0plFw4InzIMJV4qOQFn7L5fm9TOrzKC9kAISvM3pQAGhT
 sg4Lk6QG1dXEKy6gHfIZRzTgpCui9ppPAidulHBFjdoHEzn7lXCvamN+MgzCzb+QCWvI
 2irDYGTwwZT849kCqfyinyVmxqNVP4dFGHrcBNuxsGnnHoKRfK2T2unXHxq/m0jNBr6J
 GRgRMw/Xxb7/bC3FzRQ5OGA1ur06SbN1aIYkkFSvViwKvKvVFNazKnnyft69Oqzvijil
 lNjMpUahw9ExEwXEdPbJY8evMxblm1PnSGyjzGY1cWIvzShm4AQRqDj4ZyBurbaGa35S
 QDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476361; x=1708081161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0nDmbykjvknz9prmwYgoWA7RrP+4zfTHRcynakGz08=;
 b=iooMHCaGrS/xbdbtwOqkJcd070RtV6OghGE1QwJo15QomRmjLTSg2f1ApVaMQrzfmv
 gwjiYav6IX+0QnktvEHQzypRtjYnyX7qCp36Qg7xvaOhEvE8VjZ7BFc8msMgq0FC13J+
 LhvPA8aYmLF02qRzF3yysdj0/30GDC4jOjwoilk2bcV0cELqeB3q0B5Ts/9Q2tH9d79+
 POL9RTm0BdxaR8gQkmZPyFvZIhen7G5o7CP+cJpYKEJKUCVhM1Sl/90Zu8iFPUd3oBBq
 iAm7UwCcmYKQ3LnIwpz/PZq76Gu/AxdCngdgU/5vvbJNDz+BsBZkSF9B2KTx72+vlAVN
 1dZw==
X-Gm-Message-State: AOJu0YyUkh6LKUGjYzXA6JBO7VNe2EDEXjyhARWFaJvAtB2p291q8TN4
 c7fDaQSG3o4CvLRZoIfdAB0GZMLJTYhUDnsYSOFSTlXJXKT0aMtjl6urNR7n4rjkSQ==
X-Google-Smtp-Source: AGHT+IFsqIpmwANoi4SqEqYyvSCOjT1KP7xCpLlenuHrWi/fmFOL9NGOpjUf60jH1k50MSYFeUjoPw==
X-Received: by 2002:a05:6870:1641:b0:219:3db5:b540 with SMTP id
 c1-20020a056870164100b002193db5b540mr1196370oae.41.1707476361669; 
 Fri, 09 Feb 2024 02:59:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXkk4G6UUGyojkP9x9P9sZQTEkxqvWujO2rUUYj5rTB0QXakkWd72X1fCibWKc2LUbr+WDW7jWWBnnf8wb7L52hcTeDUb3pZRU2ZQAbYcRSPlrkCGg+ubFmeW6j9pmJsjU6Ezj8wJRfbV0DogKqDr6OOPKtwxfLjt52bF/moU70vWY=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 17/61] target/riscv: remove riscv_cpu_options[]
Date: Fri,  9 Feb 2024 20:57:29 +1000
Message-ID: <20240209105813.3590056-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The array is empty and can be removed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
tested-by tags added, rebased with Alistair's riscv-to-apply.next.
Message-ID: <20240112140201.127083-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         | 1 -
 target/riscv/cpu.c         | 5 -----
 target/riscv/kvm/kvm-cpu.c | 9 ---------
 target/riscv/tcg/tcg-cpu.c | 4 ----
 4 files changed, 19 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3e342a5ae5..a744b2372b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -788,7 +788,6 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
-extern Property riscv_cpu_options[];
 
 typedef struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da8d19c790..f0e3cfda33 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1985,11 +1985,6 @@ static const PropertyInfo prop_cboz_blksize = {
     .set = prop_cboz_blksize_set,
 };
 
-Property riscv_cpu_options[] = {
-
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 /*
  * RVA22U64 defines some 'named features' or 'synthetic extensions'
  * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 748a690b73..4dec91740b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1527,19 +1527,10 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 static void kvm_cpu_instance_init(CPUState *cs)
 {
     Object *obj = OBJECT(RISCV_CPU(cs));
-    DeviceState *dev = DEVICE(obj);
 
     riscv_init_kvm_registers(obj);
 
     kvm_riscv_add_cpu_user_properties(obj);
-
-    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        /* Check if we have a specific KVM handler for the option */
-        if (object_property_find(obj, prop->name)) {
-            continue;
-        }
-        qdev_property_add_static(dev, prop);
-    }
 }
 
 /*
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8afc501a67..b580b83f9a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1301,10 +1301,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
     riscv_cpu_add_profiles(obj);
-
-    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        qdev_property_add_static(DEVICE(obj), prop);
-    }
 }
 
 /*
-- 
2.43.0


