Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396F606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u8e07hv2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTYlR-0005C1-KS; Wed, 18 Nov 2026 01:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xTYlH-0005BM-5P
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:03:15 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xTYlF-0003ir-EJ
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:03:14 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-483a66818edso377831fac.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794981792; x=1795586592; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tf6wJHVIyABPZMoaRTm7XpuEasULHVflGlQUyCPmJjc=;
 b=u8e07hv2sEarV1CwgtoYLt2MVFSxhFvhNWTbYGhaeCysNg2TRXTXI6y6f0nUdk1Gl1
 lItevWEksLMqoLbH0a1zSenjUKqi24PtjGw5ew7wLn2h5r0yHeMx+LkzzFRQNXa1mypI
 p5jLvzBjMFaa5pL4PY7hKq8KVsU5GOKTxyl8t19gbavLzfIcCy5Ki5kC7wsBOAVqX+Gr
 hXoBL5KMuaZnDLnVCkWL66HTwz4HrjFVJlPSmoEOZfJvSqTFeKRcEVpHpn0voWUFJjzz
 paOEti6nmOOj3+V42vru3dVpDY+CSzMUyDbNoQ8rwGDaCKXfhRCyaiGUNdcjGvrZwJ3W
 M5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794981792; x=1795586592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tf6wJHVIyABPZMoaRTm7XpuEasULHVflGlQUyCPmJjc=;
 b=f4xUHV40XGQKEhBU/Wi1iPDZvC0a23vV8HjQ61Hjw+Q+A4e1yH2J8obp/MJvJfyGQF
 HLMeuAvfzm7h5Zlq6fyZNk5/i4E8ZvrOCe4GxND3gvVAITSAS5jl25bs10kQHk0GntIT
 DZlmYuCOK1KSwv2E6Jw49jxGoYLvBI2xc+NTy4YgoQU5x5z5CV95bvQdxGV9ZLSa/eX5
 fh9n6iSF3pykPMWEqa1T65+2Hmj0w3AFTE+98r+7Xt2ISNwOE5g4lm4PUP+fQVD2ucFh
 GPf3irkyAuO3cnu7ueCh6I3o7isVTsMyOIuwIVsfTatpM27G25JxzfLP4f0ynKmnCOeS
 BP5g==
X-Gm-Message-State: APuU4Z/88S2EvHEmrhaVBKw+tHX9t2EQ5tZu6Ci+QWzPlNH0uzQiibMV
 7yfQlHgYeqABLbJl3ZKZlmgV3kSca7AONbH0uYsS4LiJ4ZsNMCffGKIF
X-Gm-Gg: AYBFou3JjVwwuMRFvGAoKGZftZNlm9htOSiyfVpDOaYdLKSWwUJ6AsFFANXD5At9QF7
 B1rHwT1VewvieMTWV4TjOKvfS/akYFRP1Gfcri0LBOi9Ld0cw9Q0ZE+xT29w2BpMHwWFNdbKL2l
 43z/QlRencRfFlwc7SQUoqzlyi9bcBtbMLOmn4hFYxyXPaVCqyt4yf8HEldPxia7EMcJLk7vfqK
 bM911aLqi1t2OXGBLsevlNOlIG3qcmzEDVIpU4D9l3Y3CuHAjy9Pr5XyDmPaHqO6utAIzZGlNqd
 wWYnJ8Vj1tv7A6ROBXEWhyaRtUg5PyyNzaxwTZJ3Mh7E2m+Hq0SMDqScwfh7Aecmm548hJ1XDzd
 AHawrfC7zN+FnY7bnAubbEtcH7qUH9KxE7JXEgTAQEty+swB3d+Ro4Ltnmy5AS0fK393BaWTwhG
 41W6+MRL3XHtFzODblxGfiFBwWNEity6Y5r0km3EQi3Dg3relOxLBTL/asBF7awmKyyTXOYwPiW
 vHylMTnJuL08PxQ+XsWbsS4UKqWwcfFjeXClNvVmvES9L+TpHbIXtNgKU5zeRdO3MtzuF1ReAMK
 tg3AFn0NdtehqHxRrrAShRKk04Pf6/4CBeCgxkL7rMJQMdk=
X-Received: by 2002:a05:6870:d188:b0:4ad:827b:dcf5 with SMTP id
 586e51a60fabf-4b75da54b25mr1373378fac.10.1794981792076; 
 Tue, 17 Nov 2026 22:03:12 -0800 (PST)
Received: from [127.0.1.1] ([2605:ad80:33:509c:ff29:6c8b:a81b:ce71])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb6bsm1358721fac.4.2026.11.17.22.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 22:03:11 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Date: Wed, 18 Nov 2026 00:02:52 -0600
Subject: [PATCH v2 1/2] target/i386: make error message for -cpu host more
 informative
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-4836-cpu-host-error-v2-1-ba02bb640d9d@gmail.com>
References: <20261118-4836-cpu-host-error-v2-0-ba02bb640d9d@gmail.com>
In-Reply-To: <20261118-4836-cpu-host-error-v2-0-ba02bb640d9d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794981788; l=898;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=retLpvaxak7EvfhoaIt+z23+rFg2vACv2e+tGvhXBFI=;
 b=i1cel7YrNFJIp03UZB+LDfZA0hXDnYl7OkYcB2/4vKKJW32cLQ4abXDoT7oyuUOEx4JkDL572
 SWCJNAXzgZ+BK4Rw5/pHUWetD4lsmA9ZrJGMHDbJ1tEivcICrVT+PlR
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=xmphyr@gmail.com; helo=mail-oa1-x2e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Included the mention of WHPX when the option -cpu host doesn't have
an accelerator option.

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4836
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4..7dd5535f80 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10229,7 +10229,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
         g_autofree char *name = x86_cpu_class_get_model_name(xcc);
-        error_setg(&local_err, "CPU model '%s' requires KVM or HVF", name);
+        error_setg(&local_err, "The '%s' CPU type can only be used with KVM,
+            HVF or WHPX", name);
         goto out;
     }
 

-- 
2.43.0


