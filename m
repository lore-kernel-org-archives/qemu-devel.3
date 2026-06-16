Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA9CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjS-0006en-1K; Tue, 16 Jun 2026 06:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjH-0006A0-W9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:12 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjG-0003oo-Gy
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:11 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c857fba35cfso1951462a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604549; x=1782209349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TVDp/yPz1OKiy1XeIDs0kWwhquE6XmBCHpt58oJajc=;
 b=n8mhZfL4i0s2Nzp0K2y2+yQNVwSlPSu/vsjz2vj/zCoVEn2aeA6H63RVCaFtcl/WIo
 tIoE9nhDDMDOqjY2/v8KagDAHKXjxI1EWB+G83AmN2LgaYpvHpn4UBaWppM1o9Jm2CrU
 On6YFWfYliJ6JhsCDmybFVnvc4hqimYhFVkI6vVxM9zSWah7RP3+xQkLJ3dzyz6P23/D
 d/XtEjx+Q71ZsAvA9evklGq1UslHE1PjMzSMmXEjF9A0NoR7Nm/kNJ3ewIQ/iV2tSxev
 77feaf0WMDAWqkMPyTtpnkvi4wR7ZIE0jRIVQTZCFwyVUyfzegkU1J7vc5ZA0Z0dUIf2
 Msiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604549; x=1782209349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/TVDp/yPz1OKiy1XeIDs0kWwhquE6XmBCHpt58oJajc=;
 b=KRQvVUugihp7NOjg2/FQ4+qnloWZnaJtOr/JtiLGhjwGhBVZDOT6yWmxP+TE/GfyG3
 werMxk9lDnT9TQLzndbWIqqHQkyVXF+OecnkMc8nhMTyx5Defxu9BNcTSEtrPU9LZtQ4
 SWx/5cOnbPsl8RClYyQhU6RKdInP1JheKRVjfCoWYSXg/RbxxnU7ZJsx/GRDhUhr5aKS
 uQWcMSadmF1EbOEh3ga+wX+WuylmRTIbQ4tj/kbwDgvTRiZM5bB4DkqgAuy/0GqXhTx9
 vFqZkVjvE20I73zwyWRkt6HlBjZvo2nlD0CDuu9QuEsciKLivM9SGPzHtOnkJ3037+tr
 jDhA==
X-Gm-Message-State: AOJu0YyVDPkp3qmN/iktjSz0Sjj7S0lyDV+2oXwgk/4G6XZbnHNWpKZ4
 Yd4PKCIDHO2h7GakLHPZzTwi9HsEbFejewpECDEW8T/daoRNoxd2WR659zORVFH/
X-Gm-Gg: Acq92OFVUUsM6WXiBMDd3WmjrcjBH+ufMz06TS77KhWQ8SaFzhVbZ03aR5msTkHzWkQ
 HvIs0dM3wLoq3fFUFFBIE6cVcJWM5fWize9JTFUO//v9GGu1AYMMJhYuINqE/4p7Nt+xNlW3jSQ
 gTIq9ldAD38y9JVKwC4Z4A1jmlRtOwZYCxGuPoWR0D5kx91nmD9q/omVL/+zQLpNe4OGge1oLuG
 oB5ObRNoGEI3UF5T8lZaP+9oPcEhVm5EvXQnVOGR7gtCerAOANn5++RD3YAX1up+axjJ/GyBbjU
 mARzpqLM2xAtvIBnqruHfLm7ZruThpQx6zlr2z4RJLGBHA50o6MhjTyIrfmJqj8OtkHHmInzmm7
 UIBeQSlfn31znLpplr4wmSXoO4LdQig4zGPFOF4mN8xzEm7HK9nqFU+6kwaGmureEsztO+36SKX
 isLE9eJqGAH9hglsPluWG5idN5I1pvSMRhD4tR0+HO
X-Received: by 2002:a05:6a20:d10d:b0:3a2:7ef4:81d9 with SMTP id
 adf61e73a8af0-3b7e4dd781bmr3266176637.44.1781604549262; 
 Tue, 16 Jun 2026 03:09:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 61/83] hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode
 handling
Date: Tue, 16 Jun 2026 20:05:04 +1000
Message-ID: <20260616100527.1939565-62-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jay Chang <jay.chang@sifive.com>

Align SPEC: Bare mode contexts are not cached, so they require
direct memory deallocation via g_free instead of hash table cleanup.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260518072239.16293-3-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 5b28b1ad63..a500cb8440 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1390,7 +1390,16 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
 
 static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
 {
-    if (ref) {
+    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
+
+    if (!ref) {
+        return;
+    }
+
+    /* ref is pointing to ctx in Bare mode. Bare mode ctx is not cached */
+    if (mode == RISCV_IOMMU_DDTP_MODE_BARE) {
+        g_free(ref);
+    } else {
         g_hash_table_unref((GHashTable *)ref);
     }
 }
-- 
2.54.0


