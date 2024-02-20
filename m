Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218BAC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsh-0000hB-EA; Tue, 20 Feb 2024 03:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsf-0000c0-QN
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:37 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsa-0008GU-8J
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:37 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so663642366b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419211; x=1709024011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/tc2tgzYdqf1GRKL9zR1dRy/HHltPh9jD3TH0i4ovo=;
 b=BLs5FPgj0FTL7BqwpifHkCMnxxhLu6Ea7x7dnAup3/8yZ/3BzTA03wNvJ+p3/B0rdv
 UA+CPBV/tzumva24fTJ/PPY5PMKI4yVuw8oFR7NPuZgVQ5FgV6xlGI/DTVcUGenuLWMd
 khkEG5lJjzkjkJ/TLPIwP5ofsFRUe4n8DNX8SpOIAlIZ/kV/kMjfIKwNSWiPP+mH6Qag
 rsg+D36jOay5NWgHQO4UBvc/YA7jo8heKnYNWoCSZ6/MlUGU+W1w+hTWX/tWigJykhoY
 sdL4/z9xhwGTEpOlsicRe8yhh6ZGpN6/0rCNjtPUVKIT7tv6gaKqotwNjhhTXHhNPCZC
 N9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419211; x=1709024011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/tc2tgzYdqf1GRKL9zR1dRy/HHltPh9jD3TH0i4ovo=;
 b=fAvkj0ESfqlOiiAdvusOUnYx8vdfizC09pRUtrbkVymr6RnLCzY59VtqAW0EMHxAku
 H/jF553Lh77wE5Yegb9MKZelJCgNus95BmLycxqrTiPjmgu7D/Cz6zDaLpbMtokOpOHQ
 0IH1bgFkm4wjKtU5fDKMdtkW/4S5cc16qwgqGSykv+kKJcoMV+e5pyXI6qJMWHi+Y2bs
 tyzI/8V2Dwfqr/0I9CA/w9nWzck+/ba/qpqRYgKXfBRVbsoHSQKDfqP95vRfrdioHCW2
 Lx2FWE6RnZmcd7PQ+jiESr3+T+7zn1kbdqkf+D6fGfp4X7KjiFKm/mNLKgk+PL6DIHX3
 E+ow==
X-Gm-Message-State: AOJu0Yws25mcIRfOSh5t4MzynIiEI8d1ThULii2sN2o71qlOiMvpvMq/
 grGMZlCokOHb6G5sI3vqj/z5f59Mm0oHz0CHVdVFHYQXI0CD1t3ZoGvv9zCcVRk=
X-Google-Smtp-Source: AGHT+IH5qV55MwovROUTupL34Mwv5bX7pdp36dJlAQkyKK51UKIejDgCLTWpQ2SHo3XxbosKPiOcoQ==
X-Received: by 2002:a17:906:dff9:b0:a3e:8223:289a with SMTP id
 lc25-20020a170906dff900b00a3e8223289amr2982024ejc.31.1708419210859; 
 Tue, 20 Feb 2024 00:53:30 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:30 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v1 18/21] hexagon: correct typos
Date: Tue, 20 Feb 2024 10:52:25 +0200
Message-Id: <10db19d340ac3f275900f315661904d1aa004949.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 target/hexagon/idef-parser/macros.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/idef-parser/macros.inc b/target/hexagon/idef-parser/macros.inc
index 7478d4db17..94975d9583 100644
--- a/target/hexagon/idef-parser/macros.inc
+++ b/target/hexagon/idef-parser/macros.inc
@@ -127,5 +127,5 @@
 /* Include fHIDE macros which hide type declarations */
 #define fHIDE(A) A
 
-/* Purge non-relavant parts */
+/* Purge non-relevant parts */
 #define fBRANCH_SPECULATE_STALL(A, B, C, D, E)
-- 
γαῖα πυρί μιχθήτω


