Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D93EC3600C
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXRD-0008CA-H0; Sat, 29 Mar 2025 10:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXR9-00087Q-Sz
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:28 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXR7-0004T7-FZ
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225df540edcso81144655ad.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259523; x=1743864323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6UE3g77XHofe5MwO/2JDN7eKdzN7JmoH+l9nIotsVw=;
 b=JwWq3yVyv6wNgElYFoKJgc7uc10JNJhJREyS2wJ50kmBEPohdi8RJY/ZYFZADkfZc9
 QheN5ICfOt4rKthAwTqUEi6rB796iYQHL9nXiDUnHuAA7qlguHk5+U2t2YqnufQk+r5b
 k4K18LoMRoINkyFlfSgSFmxRMZZH0U5ZNwUXx75tOrspPkLPvtI5sQ3FOQ5g6xInw2YP
 Ofh7VIK6ym45fN3OjQ496wjXYvVMnWX8rRuo6iZSFaAbyYeLVMsgPby4OnMQMfWojq4Q
 A348PyquL0VsEl86cZTnKHb+BiRmsdToshzY3csOk5b4/C0L7dv4Uykk7wjRJSPYvjxt
 D26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259523; x=1743864323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6UE3g77XHofe5MwO/2JDN7eKdzN7JmoH+l9nIotsVw=;
 b=fxDA3QCRm+HnR/Qii/U9n5N5oaaV0MzOGWpInLjBrAO3ssLz6dl1C/Mv2NIXBY4IsK
 e4Z3E+6Eos88fMZ5przEuI4SXYxjbJefB/l9PgsJazrz/eWFzydSdkGSr2Lxpib5NFXN
 gBYT/gIn64O5mbuLorO2sgiQSzWfFuI9nZlu4N5aYSQ6vYoSdbZZXzx65V8nb/u6x6BN
 h3c7kOEXNhp6rPhSayxjr4T/L2EcxIib1GhlA8P+VKImcylgwLQmKo+Bb5wffCJQvOL/
 8fBH2ATEnYcxx+esvja3nCKMJAJvGX7JLZKTQ6gQLJfAvZ6V1qi6zoCK8FV5ZqT0Ooef
 CejQ==
X-Gm-Message-State: AOJu0YyVYF5d5CSj7QQCy5zchh8MljpS/0JGUO5+x5fL5dVngXZ2x9SW
 IqferWTlGR1GVQGObuwWCMJyrQQIzPSIS3mDpb5xQghAKRv1WAGQUCtEUgy5Gs8dfqoq3PFHuSj
 b6CdRVw94tMlNHfqhtlgz/pLf+mXU3Yx9ifCZynwV3NWYivMKj0QOJlKmpclZYuO/C2+XMJ+NFD
 NhLq//oWk/Az/lYEeriG3GDkPMj7BAvGdBPd46aA==
X-Gm-Gg: ASbGnctyjrPwKOdcHlkZSXsyqfCBzHIdX23q4rcYC9wIt3NHhcS8hcLGV4BAYEwoU5u
 WsMFVL9YPC/m5cHslvLv1WZRHCtV35cc4iYvXBT42HeJcakS4V1gS4l0bgVygBn1tOz6awQvA+e
 Wvy5TnsuEKo9MGjIUUrkV6INQi9NHIaFKS9PTjqqy29lMLGPusCJ4OCHgtfgSeV9ij2aV+lCwJW
 lLviXf1dJRA2ALGhGPKOI/kGAB3m7Ya2FFHrt9yqKxZEQj6mFgUpFS7L8hVw+8W2nV5mmPYwGkw
 w15xL6Av4PDGNvyhklx6Ss2d/xNBqxUX6dEiDIr+PAd/CTztfWF+1gJ7NL5VuNLtCi5K1ElxdLw
 5BiMRa/JnPI4UCA==
X-Google-Smtp-Source: AGHT+IHLDZYUrTdHIOm42lODWngkZ812MVphdPjdI7COW2p2SC3kTmFGnObKS+4XFpx1oUarXjLtfQ==
X-Received: by 2002:a17:90a:fc46:b0:2ee:cbd0:4910 with SMTP id
 98e67ed59e1d1-3053186c82emr5298609a91.1.1743259523430; 
 Sat, 29 Mar 2025 07:45:23 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:45:23 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 10/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector narrow instructions
Date: Sat, 29 Mar 2025 22:44:44 +0800
Message-ID: <20250329144446.2619306-11-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x631.google.com
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

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Co-authored-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index f30157939b8..d4d1ad055fa 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -585,7 +585,8 @@ static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 
 static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
 {
-    bool ret = vext_narrow_check_common(s, vd, vs, vm);
+    bool ret = vext_narrow_check_common(s, vd, vs, vm) &&
+               vext_check_input_eew(s, vs, s->sew + 1, -1, 0, vm);
     if (vd != vs) {
         ret &= require_noover(vd, s->lmul, vs, s->lmul + 1);
     }
@@ -608,6 +609,7 @@ static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_sd(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew + 1, vm) &&
            require_align(vs1, s->lmul);
 }
 
-- 
2.43.0


