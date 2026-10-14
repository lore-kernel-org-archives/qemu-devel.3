Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FAFCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGps0-0001Tq-4a; Tue, 13 Oct 2026 23:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprv-000184-4F
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:32 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprt-0001kk-KM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:30 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cd3310348d2so2631767a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949288; x=1792554088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m8M02c4ySR+Lt6uDZ7Aas2C/BIqx0f3wO/wn5zcjyrs=;
 b=VUNRwYRM++kZWrtiXRvNFs/NxzlODBwV+49VP59GqFjHMttTdP5SD9GLP/43EM78Yu
 xy+eUBovinl+WeN0PSdBtwoIiWKkq4rNIeCRwR/nh6WOZhbhTgaZXkuI1GoN6E1hbkUb
 HLOoyph57o0XSLSwGhV5TvDkksRCjrhSfvwvMy5Rs8gn8qARCqvAj78m7ZIZIzTe4wy2
 ardxQTI1QwMkrcobSD/tAEddjC4SSvsnK3N5RCB+TJMD9E9WBBlm2aJAzUE0kwBaH2v2
 ISl3ymesCWdyq6H1kOfRxDnBmaqNrYyL9/nOHHaTfhsuQzEPtQ/oO5Tg8legMB4cymQO
 H4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949288; x=1792554088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m8M02c4ySR+Lt6uDZ7Aas2C/BIqx0f3wO/wn5zcjyrs=;
 b=Q09D+9B5sFVu2XnibpJKddiUyBUaymB89WXM15HU9aQFJuCPOfGuG3Zd5CvjKudSMD
 Ni77oXD+AaWaimC4bs0TSCdT4fWgh/txjUmClGiwGtGUMoWiF/RQhT4buJpoXecuTum7
 vwoqQh4+v5AlRc6QdmAHM/em47PPag89UKDTrN25jl/0ver9epR3l2zhJnGMSnh3e8Nz
 TYi34q28BBfb8MV8f+JsZZ0hxqbshgd/btDo3VhifFZi93yWy5IfV4pErv9dEjKfxLAZ
 YgbaMN2GfcVyOGUM49PTpz1Gg+Y0mIvF4W3tWORUf4nUXTH+LdvJKIzoPuMCnndkGK3A
 k1mw==
X-Gm-Message-State: AFq9FYI4uqcjiagVsUU3NnRqC5M9y0IT5Hr7d/MjjbNFzEvYRDH2KVB7
 fDQeFIF1GxCN4HZekws3iJhrcgUtZyChimIeEahUVERsWBcp6y9W63b5saKF9w==
X-Gm-Gg: AYBFou1xjCyARmg3hOW+MEBmzxfNtpKsuRl+xmcLGMTFOQJA/3vCnGNx19D7q6TF31l
 hdJcin0adl0fPI8GMNZf/CE3MzxiZOvY5xaDLg9+Mq8kgnRFFOzbZQwibKg0+cj44nbUkSWXcWD
 o4mNWGrsxTNmm16E0LWRHbvcxZUjuuKkSkE+WdXnCXWzsj38pGQ8gC0UMhRXjb4IM2MFRvO6vdJ
 3W+ROh82hGIs7SpXULsqgueY3O7pvSEe4mAOslHSSRCKdv/lSUV35FFdc/vl3ZWyfaojETSk/g6
 fGxPmcXd7z7U6dYNK0PnTJmhJhKDuFoWwl+QVKLhMyHk9JtwuqR/T4zu8Fx+ZVemFP2wUyYrdP0
 6G0Ikjf8YcxL1dHM2dhu3qYkmhTuLl90AwRuVDWstIx6JP8OJa4ZslXtr2FLbERxWW4paQ2SBeX
 oZPhLx2uyJUNzav+SsLlY6s7Pn3ByD3KLCLxbsHSkiA34Aj5JFEYK9rZveIy/mT4j3nqaFrHun1
 mqtivUjBj6b9vjU
X-Received: by 2002:a17:90b:43:b0:3ab:330d:6e47 with SMTP id
 98e67ed59e1d1-3ab3a9528fbmr8418277a91.10.1791949288228; 
 Tue, 13 Oct 2026 20:41:28 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PULL 40/52] target/riscv/cpu.c: remove 'bare' condition for .profile
Date: Wed, 14 Oct 2026 13:38:55 +1000
Message-ID: <20261014033907.3332383-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Message-ID: <20260928201107.2049458-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f4ca08583..1c9b400f71 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3167,7 +3167,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.55.0


