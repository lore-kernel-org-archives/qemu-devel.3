Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2950C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZL-0001Y7-Og; Thu, 23 May 2024 19:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYz-0000IT-Eq; Thu, 23 May 2024 19:09:38 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYm-0005np-CN; Thu, 23 May 2024 19:09:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f332511457so2160655ad.2; 
 Thu, 23 May 2024 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505757; x=1717110557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8QQ/AJtkeULSDr3gij8vyBo422tzP42h8e8oFokH9I=;
 b=hTj1UyaGkmoAr8HzFntAyFqug9PUzClnCA7uc41uVIpwXkKtQppQ/Vgz5SVP7lIYWe
 s7l9OCv2uwsxhXkaTKJWuWhTBgilHWsrjWFsfKEZyr3q7289VsdWSaj7M5ToS92KNEW8
 Adi1SncfyQ/FStQxFQy/LAIEZG3EM+O8Tw1O4/69hScvQHbRZfrkp6tHlWESS3Su4TdL
 ER4fOLXp33gV5RTMhm7KaNf5Xt2cgK0923KJTgCuHEO6ZC+6Lvi57hO3D9mhc0CG8hZ3
 IwKXsZoiUTogeIeNcxaQNGT0EbM0SUw8CT74k3PJ/PxMSLpXBSf69g5/CplkQQBgnQgg
 ob7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505757; x=1717110557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8QQ/AJtkeULSDr3gij8vyBo422tzP42h8e8oFokH9I=;
 b=cJbBG/XnrA81PRwzDYa9TT5AWa7iE6KuNnhhwywBMtUwCV55ONoLPnI0elxKxYRc8U
 Qpe9KpROVmiIBOJWMQL1CxRkMQHwAnIaKOeWhb6k+5tq2n+k9wvMUNvTj7m8ckMgn/zA
 afGGHnYr/cGqUcpxM9pZvVcT4LEA81zYnD5MFXpja4nBHBqrv73Qb1dqc0+6PDcAlzwt
 Eio8q2QZksU6uZZEzq4v56Oj29BjlAHHqM1t5UljHNAw24sVTTZgETa/fCAykStLqNVt
 ZpdZiiwW9u/v6zUM6ltzKSk6nDMEERFihFKQBdUFjo2mPGyG7rYE+l5a0NeBM+Ao33UX
 nv/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcu1H8TVdLUXMq08QgJgKWX/v8OQr7T80OyppJcnfgYuMe/baRpOg0/NHkzLDbtcugjpSYog3fBicdydwdamV41xeU
X-Gm-Message-State: AOJu0Yx/L4gD1gW5qR8dkbPTg2GqNPMgEdjy07DJo/INiZn3qPPK5e2Q
 TsJ+DAUD9edyOdA/P8GwXldeNalwC88yQBKLAyF+WuaEBRKULsZFC3Oqig==
X-Google-Smtp-Source: AGHT+IGmeaeQesyDkP8VxdJWHhaqasn9N16CRcUJrtqPZYNrGancK2ypvUbNgHOgICuZqIN/LbEuew==
X-Received: by 2002:a17:902:f688:b0:1e8:6614:51cc with SMTP id
 d9443c01a7336-1f4486d51e7mr9212415ad.5.1716505756921; 
 Thu, 23 May 2024 16:09:16 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 25/72] Adds migration support for Branch History Rolling Buffer
 (BHRB) internal state.
Date: Fri, 24 May 2024 09:06:58 +1000
Message-ID: <20240523230747.45703-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/machine.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 6b6c31d903..731dd8df35 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -711,6 +711,26 @@ static const VMStateDescription vmstate_reservation = {
     }
 };
 
+#ifdef TARGET_PPC64
+static bool bhrb_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+    return (cpu->env.flags & POWERPC_FLAG_BHRB) != 0;
+}
+
+static const VMStateDescription vmstate_bhrb = {
+    .name = "cpu/bhrb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = bhrb_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
+        VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 const VMStateDescription vmstate_ppc_cpu = {
     .name = "cpu",
     .version_id = 5,
@@ -756,6 +776,7 @@ const VMStateDescription vmstate_ppc_cpu = {
 #ifdef TARGET_PPC64
         &vmstate_tm,
         &vmstate_slb,
+        &vmstate_bhrb,
 #endif /* TARGET_PPC64 */
         &vmstate_tlb6xx,
         &vmstate_tlbemb,
-- 
2.43.0


