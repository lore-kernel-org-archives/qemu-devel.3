Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7148CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsM-0008Kc-4l; Tue, 20 Feb 2024 03:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsI-0008Il-Vg
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:15 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsH-00089W-8r
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:14 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so6983492a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419191; x=1709023991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQh9A56lkLDD4DdOG4kCUxj3FidOpLJjLkxaSgM2CaE=;
 b=lIDQNyl9kjjsab09AeHpSGkJCvVxkc+kZnGb2nJLWBgIJWO+HnSUjxwRfCY85Q7c09
 3FrzOujvgtN3bYn1q+3VBQPLEMx/sK6k4RwRAUN6osExkoW3ZnS3O7RwHoregYzdBoSj
 p1cXo4ystrMk/tOv/7uJzCC2agwkMOi4MSOD37Gcumnt8R0sFuw2QLNPtMwB7WodZvEb
 WEajvB6uzM86drusGjgg1axYt/jP2/O89RcxgSrrudAslfBH3zMJMM3rpFWmFq/g68qn
 Wb/IFqcoQuuIC+4ahPEvcGNNWxc3kBZ3Ktu1Es6ri+2S5qzYldqnAqg8C78SrKAA+USd
 tAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419191; x=1709023991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQh9A56lkLDD4DdOG4kCUxj3FidOpLJjLkxaSgM2CaE=;
 b=FIa3Xac3y15ioZi2YE+24YbFCwmeP7TjgdIMe8J+vPO4JEPTm2ud5k9uRM7580pL21
 iESAOUcG/5AMoW65PgshxK4kmBIuDPyA1MSKFZRK5cH201N5TjW3fTeCQS0cUz/uz8WC
 FGO3hC2rj7jPiBI9IJkNMTN0ul/fYK/MbumFCkd6tqv4kDw1gaFv44TmhHfHR7fFSmrx
 mLNc0BNLYmP4qVuoQM4dg5YmXzXps4LLRhDt3J1iSJTbnQ9fydReve/2sEhsGL6ohmkM
 pM4Sc7UOrENdNF8idT75YtMBfGBlYb3Y8epYM5nLcXusv4XC+z0brrcGXK2OxRQXnONb
 Y2Uw==
X-Gm-Message-State: AOJu0YydhjjPZtRzb8TGvSWdiWN2+pbqnniPlszZi7lPjmAFya6IbEYd
 mME5uNtqH9DSEPGAJZaTvbvbCxCFfdKqOQh50eQajyptfeIOvPnlXz21gF1LnAg=
X-Google-Smtp-Source: AGHT+IEC7c2r5N0afUGvXvJWPlWY4A+Dsrkpr8vqY9H3aPY7kySXvlvwTVLlbh0dC/Q/u7asR7L2+g==
X-Received: by 2002:a17:906:fa0c:b0:a3e:998a:cab6 with SMTP id
 lo12-20020a170906fa0c00b00a3e998acab6mr3427880ejb.74.1708419191525; 
 Tue, 20 Feb 2024 00:53:11 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:11 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 04/21] accel/tcg: correct typos
Date: Tue, 20 Feb 2024 10:52:11 +0200
Message-Id: <a7bdde5bf92b22255cb6d280330bab94bdb59a79.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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
 accel/tcg/ldst_atomicity.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 33a04dec52..97dae70d53 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -76,7 +76,7 @@ static int required_atomicity(CPUState *cpu, uintptr_t p, MemOp memop)
         /*
          * Examine the alignment of p to determine if there are subobjects
          * that must be aligned.  Note that we only really need ctz4() --
-         * any more sigificant bits are discarded by the immediately
+         * any more significant bits are discarded by the immediately
          * following comparison.
          */
         tmp = ctz32(p);
-- 
γαῖα πυρί μιχθήτω


