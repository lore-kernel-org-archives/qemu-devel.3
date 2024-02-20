Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FBDC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsO-0008Lp-Dl; Tue, 20 Feb 2024 03:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsL-0008KE-Q0
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:17 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsJ-0008Be-OE
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:17 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3d5e77cfbeso904331666b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419194; x=1709023994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlrhK1LpCylwWHbR84XlfAvVU7thjLK8TeSDt+aYfm4=;
 b=DzuS7b6Kaz3oWwm42ghKHrbVOzzTb9iKHiCDRPNT3/MIlmwhHv3DUsX5Vw1PYag9JV
 YQjk/sdAZ60JgkCAFIzMCbMlDEAkRh+qJDkeLS+pFEFKO5wc0jXw0E0gg2ZWhPyyayG7
 siXu3oflhTfCo51btuTMu0mjzJiaeNn3Y7U36Az/6ORDQSJPnnOK8pl/KS5kkT0FNlw8
 alsOoSEsjOBPhJv+rr5HSBLXrU9I26jlVPKXtdIBy+rZWpMRqNfWBTnbJQWh6VRs2RMJ
 1/RlDkkw7NZKUIj7qOqEwiRKg8/wbnygsKxXisnXkUfFjJaCxgojBnZh7qFGbM2OFIir
 w5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419194; x=1709023994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlrhK1LpCylwWHbR84XlfAvVU7thjLK8TeSDt+aYfm4=;
 b=ZtCr9vuJJXmurq8h/67jh48U2flNgjSro9naSPAMuTJGlc0Obe4Wrfkt3RUdRU5HAa
 l6UMm1PJ3B401UTEpa3YxmjOHiStrrbeGZAx4QyCvGGfb23FEUvgAATzuzk0uNxOwDr2
 +bzvBLiub8E4Oj8/fBZpB9wjOj0iQIXU2K5NxE5QpYn5I4LD50YKQUE5mmYEQHv/TXsY
 KAiRwYm02gfGwo2IE8hNhsSKtN1PKQMYXpkrYMOSnafXKCstKoBxmDqG2moN1NZe6jsA
 G0e8MOUYp+HWI0SDmqotshu81lIEfZ36rbdGATr6jgmhw4w/LUuZZ+p9uNqGyOzgDeiH
 KKuQ==
X-Gm-Message-State: AOJu0Yyv8ZgiIFr+0alJl6qlGROu+gXIVR6qzyCAF+LB0sWF/XyhiQHj
 QfdFKUgUEoUeFpA+VsnCVp8p5JElchHl/UvxPAsOHTwJuSWWMFdfGsYAuEeC+uQ=
X-Google-Smtp-Source: AGHT+IHl4xtOrS0f1TSud33kINBocvq8IVU5P6Fd7rZTaSOHaXUkBaY2Tn+O9hOoGpmAsMNrXjcknA==
X-Received: by 2002:a17:907:7251:b0:a3e:feee:3a5b with SMTP id
 ds17-20020a170907725100b00a3efeee3a5bmr955998ejc.3.1708419194561; 
 Tue, 20 Feb 2024 00:53:14 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:14 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Subject: [PATCH v1 06/21] ppc: correct typos
Date: Tue, 20 Feb 2024 10:52:13 +0200
Message-Id: <95ffc19d9c3877052a1a6dabf91e139fda183427.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/ppc/ppc4xx.h             | 2 +-
 hw/ppc/ppc405.h                     | 2 +-
 target/ppc/translate/vmx-impl.c.inc | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index ea7740239b..c4ecb1652f 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -75,7 +75,7 @@ struct Ppc4xxMalState {
     uint8_t  rxcnum;
 };
 
-/* Peripheral local bus arbitrer */
+/* Peripheral local bus arbiter */
 #define TYPE_PPC4xx_PLB "ppc4xx-plb"
 OBJECT_DECLARE_SIMPLE_TYPE(Ppc4xxPlbState, PPC4xx_PLB);
 struct Ppc4xxPlbState {
diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
index 9a4312691e..a39f0caea1 100644
--- a/hw/ppc/ppc405.h
+++ b/hw/ppc/ppc405.h
@@ -41,7 +41,7 @@ struct Ppc405PobState {
     uint32_t besr1;
 };
 
-/* OPB arbitrer */
+/* OPB arbiter */
 #define TYPE_PPC405_OPBA "ppc405-opba"
 OBJECT_DECLARE_SIMPLE_TYPE(Ppc405OpbaState, PPC405_OPBA);
 struct Ppc405OpbaState {
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 4b91c3489d..b56e615c24 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -1183,7 +1183,7 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
 
 /*
  * Support for Altivec instructions that use bit 31 (Rc) as an opcode
- * bit but also use bit 21 as an actual Rc bit.  In general, thse pairs
+ * bit but also use bit 21 as an actual Rc bit.  In general, these pairs
  * come from different versions of the ISA, so we must also support a
  * pair of flags for each instruction.
  */
-- 
γαῖα πυρί μιχθήτω


