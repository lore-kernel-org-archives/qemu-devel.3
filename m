Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881DE109E522
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5W9T-0000xK-I2; Wed, 25 Mar 2026 17:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W9S-0000wn-B3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:52:34 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W9P-00034Q-Qm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:52:34 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35a094cc3e9so203458a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774475550; x=1775080350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhuC67npbeF55oq6DIBT6Wta/p6WeDjzvn37ZsiDmLE=;
 b=c+Lzsx4LOvGD7axTIKjOZuXGvW1MTesG+inScQVVpyoQxZtNBnCR3XjD+ijy24Pnyk
 r9yIGciBkWF30MdgbEzY0rX4WEnn+G/IHjANprXZnCkDMpro+4Vhff1KybSzgBUYzy5i
 GoyKrBhtImHypwTVYoFhYFXyk06cNam+K2198w450VGKMhWpAnVpNZfPOb9onYdVuh9V
 eLXqvQV6JyCnKzZ+AY09eGXIN8TM+JGSViYzxuMgtfCFgX57fc1EB3jzx7Z1MqTyTuY8
 Z6cXIqhK6f0ydTtOM0QEFVY+hrpRHJ4n0H4fXiHg0yImNQi9YT/dllfiYgkFwhWTcfSV
 Q24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475550; x=1775080350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OhuC67npbeF55oq6DIBT6Wta/p6WeDjzvn37ZsiDmLE=;
 b=aJk6029lJwbG+6eBnfrrXhLsKUFBr9jAcYr1rlYd6fqleoHYoEC32lEr0DoB8fqAa/
 qtE+kbQMHlFmdjgSiBio4YWkxnX993NWn5FrEophhfKW4xXSIlZ1eh5s57R6KplnbfVr
 5F0zCEbMoyb5fQNUixO+YiqToVVmkCcBQCcu1fXfk7V4FSjDL6Qat4PPrb5BwYUOjJRj
 IqfWsn3OGShiRP3R9LpGNYHRDggTwwtOFKdxHEpGO2ehqeTD7PoqLXS7NV9a6t0ucM1g
 Z20Dc/+YQ6YRIC7zC18VI1/GsBa2R4DibBILfPbbChQv4dJ3U16q4I5sgzH/rxlxXPIv
 6HKQ==
X-Gm-Message-State: AOJu0YzO2cbodZQcXhUPRD+MUGvziM6Y9AmTcD5ZSW61AWSisiE9vZ9K
 S0/VnDv/B1HMdhyaXAr0fwnlAd4xjz53veUDZQa3p+iF0REu6bRBW3CdPLJljxLSdlb6iDeiz1R
 6A7Xvh4s=
X-Gm-Gg: ATEYQzz6Bqwm4/h1Ea6UKvvuktwNRwZxkB0VuW+KJOQSB+AkpDMq6KrbyOyat7LWjA7
 BtxifscWv7TYDSYswUCbbpqZbjOHCEggz5QCp0pAURvCnxOjT/OuP88xRDVk3DCntidu7EPr+a9
 1KeVoM3AMwxo52bINplFw4N2DlWE2dlBaP98twVDzwTkqfp19/vS3CVijx5DR7Cm1zklSYTbiNK
 N9tk74PFPhXAUNjT8pFXvmJVtb+2FKPR3Gj++ROaBcJJ4BRNBSIh1DYc1K45ophS7dYfZxMC93U
 4CMYrEw2l1crv9shjgZhLoNLvDQQEsUmBxrHjq33Mem54VjrPCIwH5LhMP6DTkh2zmqtT/XgOIL
 g7VFvLXu18RmWSh/mNEkVvDrAZBeDBNn6wPKUxYIVWP0tANHlXVyQSdGjLAH8p3B3GoHYLbRq9d
 lKc3Jh5npIj3MtmOhiYnUAavWuVMPxBLIDn5Bu/aJr0k2XCMz/XZizuNh8lN1oUvYghsLWDgPZn
 kQR
X-Received: by 2002:a17:90b:2747:b0:35b:e5cf:20fc with SMTP id
 98e67ed59e1d1-35c0dd98967mr4890427a91.26.1774475550158; 
 Wed, 25 Mar 2026 14:52:30 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0313eedasm6402987a91.5.2026.03.25.14.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 14:52:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 2/3] include/plugins/qemu-plugin.h: add note about endianness
 of value returned by qemu_plugin_mem_get_value
Date: Wed, 25 Mar 2026 14:52:21 -0700
Message-ID: <20260325215222.3678982-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
References: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260325024252.3369186-3-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/plugins/qemu-plugin.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 2ce7a7fb6c3..4eb1d2cd85c 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -374,7 +374,8 @@ enum qemu_plugin_mem_value_type {
  *
  * @type: the memory access size
  * @data: the value accessed during the memory operation (value after
- *        read/write)
+ *        read/write). It's directly stored following host endianness, so no
+ *        further swap is needed.
  */
 typedef struct {
     enum qemu_plugin_mem_value_type type;
@@ -682,7 +683,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
  * qemu_plugin_mem_get_value() - return last value loaded/stored
  * @info: opaque memory transaction handle
  *
- * Returns: memory value
+ * Returns: memory value in host-endian order (no further swap is necessary).
  */
 QEMU_PLUGIN_API
 qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info);
-- 
2.47.3


