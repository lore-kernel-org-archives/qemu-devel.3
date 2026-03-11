Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6991FD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XM-0003yt-T8; Tue, 10 Mar 2026 21:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XG-0003xL-Un
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XF-0004oq-8Z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:54 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a9296b3926so105009885ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193132; x=1773797932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lncb1lFJfonHWeqTY58GJy7/jsyPovxRUa7lsbNPfmk=;
 b=BazHiuv93RhoF40nIjOguBcX101YpUk+3LX5VoCOQjj8SGJ+ov0wRIoSlVICKRe0po
 mvLpqw2znjwtlI0O/NWJbSUVm1sjlgKyPPSnQbtu0VAenquVMgy+qmRhON+DEszHF8hi
 UNZ9QIxjcE0Wi705EiLoBPabWcNAja1/CibFj2aA1E+YFtZiWGbA73yYhb00cdYquTEw
 dAasdGYBHxVtkCxy/cj9ksMSpk3EiAOAXb9lOZ8iXWCchgbOWMTob2JP+jGmtgl+9aO+
 /6pN5ZKuwdDAu0ykoIkM4HV6xSbcNQZLwNIBbw6lg3RL/AqKyTXr+v2nfpu/7JDEv7Dh
 4POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193132; x=1773797932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lncb1lFJfonHWeqTY58GJy7/jsyPovxRUa7lsbNPfmk=;
 b=SIdOYjUDXVB0MqqqPs6I9O9aJemD8qcRdS+8OgVc5aF+aTGYRAD82AKxHjJKjsLzoZ
 8qz36Tveb3nhW7VFmm727LilL/h+uvSt9pNIEAS0qxOu9fjK/xtvBlZhhKGenXNAFg88
 6VVlZx5KMRRMra7H4/RzskPLq1OZmHypmyKi0dCsMOwRV7nfP3yEYQTW0ENL8ddMWtF+
 X63zGsYR1sCzioeyCC5MWfzB52SoHG/+jZUwVMJZFPm2b66ZUNMH6uDFAV4QuWw7P6eL
 iNj3/Lt2lbsOn6+1LEI7g4b+XdBxbhsndqJr7qoi9wTMJLHyHIr43PmBrow17YsXLmct
 uGDg==
X-Gm-Message-State: AOJu0YyeuTJCmOYmjku5YfzWXWEF50NWMobrV+2Xi4pz3+wI1DQC5Vaa
 qZ8qXICKMVNFlp0CNQfQS1dn0EFVabXFXT2zSZZbC7381K0OgxhPoHQLevhjpE2epcb1zK3/IPi
 jIFV5
X-Gm-Gg: ATEYQzxvCJOm/IQVG+s2GrUcv25aa/PqUzREqoRy5UkIRfCmSCkeLQcopt6DjgjXB54
 nUy5Mwu0fO7hmbQMrcJ+rwDaGO8gXIjZ/fmRQhpfbPfyMKTpZb9S+05hy5VZQkaUSgoX+C6j7F0
 lNpJ2uE0m7txm7iHhTuzdwTcf24/inu/hWK3IYtkuuVpw428Z5ZBgqY35WO6osO2ccSwI/MId2L
 j1WBtUTfGl/HxuXxP00gdtrK40q9Gk8NZkCT/BHj6OdpSr3AI1tENvT42LtAA1Kg1ixcwowiR09
 wVX2rzrRiz85/6z/smlzfXIyx0YzK4LhKO5KtfumWY83PNXPeUMlTSTEYcZ4Hs6o+ETs+8yquwQ
 hh/iplTEc46cY39C7RHeoxvf9BjQjJDFGkVYqSv0OaVl0QtJGWdsCjeT+Bxkkw0bNbdsg/Hyp99
 tjsWCE7cFaVSCp2IQWLBAujao3448LLj9NRGHC12QbGnOLFnATkN6bNFGZb+kbWTVMotsYSyqCh
 cFD
X-Received: by 2002:a17:902:f651:b0:2ae:3a77:a1f4 with SMTP id
 d9443c01a7336-2aeae7d8956mr8957775ad.24.1773193131578; 
 Tue, 10 Mar 2026 18:38:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 04/16] target/i386/gdbstub: Remove stale comment
Date: Tue, 10 Mar 2026 18:38:25 -0700
Message-ID: <20260311013837.69945-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit ecd6f6a8820 ("gdbstub: Infer number of core
registers from XML") gdb_num_core_regs is inferred for
the x86 targets. Remove a stale comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-5-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/gdbstub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f1ce90a046e..b86520f8f9c 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -39,9 +39,7 @@ static const int gpr_map[CPU_NB_EREGS] = {
 static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
 /*
- * Keep these in sync with assignment to
- * gdb_num_core_regs in target/i386/cpu.c
- * and with the machine description
+ * Keep these in sync with the machine description
  */
 
 /*
-- 
2.47.3


