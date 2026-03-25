Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3369B103A9A2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ED4-0003ES-HG; Tue, 24 Mar 2026 22:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ED3-0003DP-78
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:43:05 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ED0-0002hO-Lx
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:43:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8297e0b27e5so2424433b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774406580; x=1775011380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2E8rKgHUzP/UX9nRl+/RGcVIASB81IsTlG/cP9cy+I=;
 b=L5iZIPw+8DLUhYqYALChUIwxuF811PdYUXqKuDy7NYQs9aWAZHVkMGmjT2SBTRTu6V
 IfSG+ne+Pg8aRjNXShatDsOUbolxBaJ/U/TsoMflGdlt74D35EGtBz7HudOP9s59U08q
 1Ok5Btlf2MAc/nsmU4bl1yRHwRbQedXtBq+jeHyIPKUrNdTY7n7qQVFDCVyZPDTe0iVm
 WgSD56igtP6YWrvU0MCHC2PFBy+EvHfJzuBASRUlocwJN9qF2cC9MXRAK+mKzkDSoVFW
 hBUqafz60kuvgdD8AwFbgEoHL2UaMroEUj+b6Ha5eMyXD0jClJFxbLQqG+Q1xB2lmwbr
 Bu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406580; x=1775011380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A2E8rKgHUzP/UX9nRl+/RGcVIASB81IsTlG/cP9cy+I=;
 b=Y0NSwMHWw2OzKP5BNCWkeOwPO2RB12Okx6JmcLClVRp46K91/K4/ffith/YVIsvPcU
 n1NzDcpcZydH9bURUhhJ4xarZzFLyW9T75ctsruiIEuMVk0RuqkG/yI++EoKAppIZYnc
 ltjzAYfswFo9OHHSHpGqVFvkRjgpyTYRtfA+LaZuITwAAKTHqkSE0wXoZNbvEO5eFWuN
 OdOtBZ/WTUeoBed7rqvxyZDC8U4+9VcmH8hl9P5vup6MziF3dom22rJl4TEIfsC/nw+U
 XwT/8j7DrEd6sTgy04OotYkIw/hlAgXkTvRWFKjSTwFckZAMAuz6mFZRdqjUbxCr6TVs
 wnIQ==
X-Gm-Message-State: AOJu0YzHksVpfD+m32+NnBE72P7Pg+GjvYCNrAm6q/bhQA9ORV8A+XEi
 YIE3/vmgyg2gesaZac/2GP/rjyqi5zmE9/hxljNSGJg2IEIDPaY8scUa4CbSdrvLXIB/nAxMA2V
 y6I5HZH8=
X-Gm-Gg: ATEYQzyfqiWxujybIkvQLbqpTpAOj5GAok0H/JkRD5+x4HR1u0cdUsLvQsGi5xt2h2d
 lAWB30Vfe6iBOH1F5b0BSL44IIy13Mxd1IBdptnt5Ee8T4WytBEwLsPHIWhjuYVydCWodlL9zPx
 kELqwfoBSmIfcthHB8NeHLzY4fTBIFhdrjlR32CN9dUQ/7vPffUy5BeyAwsw8uRTiLcG939j6ln
 mu2fspBxfZEh1Xyu/Iacdr+TzVY3Jqv91KdMtyGlMi4dczr7XnQlA01t3hqH2t3we/BEI2rRAPy
 3PR9+9P56ZkxLxjE4RWYNKXwr+lcS4au00oilw341JqkW+l3LHQc0+eCAcGNFxjRijq1pjy7eEW
 Zv4MYKHnvFYnhptuBD+EEbSV/ezWucvjikQmn3I/yQ9oq2bNwHWw9HkQvwMpYnBhlNIS3ickZ6T
 WooD3eD8ZMi6KGmlsOSyKP6YMLr+qqBJaKkG2AhCfPW0iYKSfbH//6IzfOgyDYtiNZXrWmkhj6y
 Qi2
X-Received: by 2002:a05:6a00:b486:b0:81f:4a36:1c7c with SMTP id
 d2e1a72fcca58-82c6df281e9mr1709709b3a.23.1774406580262; 
 Tue, 24 Mar 2026 19:43:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b04222f42sm16762716b3a.61.2026.03.24.19.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:42:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 2/3] include/plugins/qemu-plugin.h: add note about endianness
 of value returned by qemu_plugin_mem_get_value
Date: Tue, 24 Mar 2026 19:42:51 -0700
Message-ID: <20260325024252.3369186-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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


