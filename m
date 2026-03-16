Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC974FB5E87
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 23:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2HEj-0002MM-J8; Mon, 16 Mar 2026 19:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2HEd-0002LC-AU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 19:20:31 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2HEb-0004MV-FY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 19:20:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2adbfab4501so23070885ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773703228; x=1774308028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cl6zc1RuyhUawW2SgjFV9v/Iau5QGc0h4lMl15PruTA=;
 b=m967S3sec8sFLlypGQs8EM252tZEIIpa4cscu5dDanhpGUf91KHK4BzdicSl/ziWb2
 n8R/QUhvZMttCZCUTiEo20yrxxIVbWAKwG94rrULpnrnmhKSMlCDaG8ieGvpQy/sLfTu
 Aa+L/U89OGxqf0bchyvvDur8VK/L2F49EWOBYCLlHHpnIJPnYuqrnSu/+risxHRDzoaS
 20XtTMEhCUqMMyAllauCCrmeEsTgaB1fWSMSjSjZ0QP5YfwQqQda9a9N7xqsjLbB7uiP
 fmVhvn4i4CwNYGEJVvD2di5EmltXKHHSrRzl7fV35874nNVYuofJP0xztuqll0U471aq
 /s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773703228; x=1774308028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cl6zc1RuyhUawW2SgjFV9v/Iau5QGc0h4lMl15PruTA=;
 b=rjA+Gs7BJ+qA0n+A9sfOnS2H0g2m0t1qd40fsxlugkX4hCetLbXvmL7Z0Sh8YtLXfm
 HcCEJqZyeCOgX3odxpqW9JvfDuAHBnJmh03WYzLgUugzXMB+z7AcquyNaqxCV1H8W5C7
 nXWx2CzaDkI4U5OvUet4hfMhh7UyIF1X7kGvWMM9qCFLMjU7t5xpdwjzswAnBTgAWgI/
 goNY/UjJfJ/68Mx21jPWxPpl2dZheC3Durz0z9MImfLq0+aH7duohBSS9bLmcgq1s53m
 BJ0Z3rCxz1B0CdU/BcHSVUxcALBtKcePOFx2d7qeeSJcKBl+8tjki4CgzuQja/8XrIuo
 gNtg==
X-Gm-Message-State: AOJu0YzixTZaRJLIoDaUPcPenBrRewcZXYluQQEq3xknbCGdMHsRxqli
 mOvmM8YLe29EspvOAnOzStid8QcSiwsiTBsf0EyZSl1tZJpDXc6zdLqpkoYGzId9q4peNuF0AGZ
 IaJIxQUs=
X-Gm-Gg: ATEYQzzjcPZzpDGnLYTNmcFqiXfM/RbwRlWvQpk1eazTcDZclHadlcxyFGztiTSiuHh
 C4n1EAefI0QWzhNh+8dfgdEnUe/ch7ld5dKKGeXtq7XfjjvrNArX7BqKbhELoo5+mI07fC2vPKn
 OU+2EeP+zsdJQhuEzQJTzGgguPiykAshNf3rVSgTbbrbQUizQ5CQgCDHOsigeWzMi0I5Rfp085K
 d/p163mkTJ0pgNfhHz39lAOE8M35lv5L0VZV35CdTy8mWYJbbLnj3ZaFlITp7fCigI+UvzPHvIE
 akJqrIdd2hbY1pG8dJjx0XuPJtIhzOrsFd+QzUAGYwZED1n7+3tQpQVTB7Ci0K7C5KQ3Do0PVmn
 6xPC6Q6NaJfvu6ZmuDNRAMC6+5mpHvktFyLCvqvwns5ipk4VUgQdvlBy5VeHcpNAipIFYlwI+Ww
 55qo/iz6cU1V4uE0Ig1eOGtAsU4CBRHHSOdA45b8m9B64fFcIMxv5FUrxLjTbl+eQwujswmLFXM
 se1Wthpy8PxzCY=
X-Received: by 2002:a17:902:ea09:b0:2b0:4ec8:fb92 with SMTP id
 d9443c01a7336-2b04ec9004emr78715035ad.39.1773703227728; 
 Mon, 16 Mar 2026 16:20:27 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ee1d8sm125247995ad.55.2026.03.16.16.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 16:20:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/1] contrib/plugins/uftrace.c: fix depth for exit events
Date: Mon, 16 Mar 2026 16:20:16 -0700
Message-ID: <20260316232016.455394-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316232016.455394-1-pierrick.bouvier@linaro.org>
References: <20260316232016.455394-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Uftrace plugin was recording wrong depth for exit events, resulting in
incoherent traces, especially for partial ones.

Thanks to Honggyu Kim, one of the original author of uftrace, who
spotted the issue.
https://github.com/namhyung/uftrace/pull/2031#issuecomment-4051762627

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260313063441.2048882-1-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index e3c65a1c930..f974090e23e 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -817,7 +817,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     if (fp == caller.frame_pointer) {
         /* return */
         CallstackEntry e = callstack_pop(cs);
-        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
+        /* uftrace convention is to use same depth as entry */
+        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs) + 1);
         return;
     }
 
-- 
2.47.3


