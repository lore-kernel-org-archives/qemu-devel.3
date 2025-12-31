Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AD3EE57D1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqin-0007Ub-KU; Wed, 31 Dec 2025 02:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqim-0007Ty-O5
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:16 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqil-0001AQ-7c
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:16 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso17030818b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166454; x=1767771254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sa5EHxYx/snq7aAH+sWySlzd4bZ6Z+JvqzA3ZIoZGIo=;
 b=KPg6O3+8i6Lco72okADxVyOUQzI54T15YYHrtnEO8lqyCk/AoQfKyjBfh3smUfsDKt
 Q+nfdNhbLak+odkIdIK6LqnnhXOHvpUJiy6lBEiPHgx9qpPklFqK+8ezhMa2yJp5rv1s
 h7TCST+I0nKY2/DUcZpGg6/cFbsl+Rzqz/GbekKz349XRjaxJkj2GkZAxOtgD0MysfpJ
 wAoejlr0RtzvJUXhIa3PRpCxa7/6721Vf3FuP/BN88xyXQvPhmTtUvi2L4AiV15W5p9D
 xYfpeirSCHB/EJENB2MtUH3I0LQsdltgqiDfS1rDhXgV8cFpjXroAJtoMxQOIZ3M3pw+
 x10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166454; x=1767771254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sa5EHxYx/snq7aAH+sWySlzd4bZ6Z+JvqzA3ZIoZGIo=;
 b=rya2CxV0gKu8irDuEPTGhnHndijBdsbLPqYE+yYnp8qVDypk5cmwH7cX4bNc694rul
 IM52sn0iYOUkrslwpCc5P4X3CNCefmM70+KMxtGdrxYx97///DsblK8jb9JBDF4+IfuD
 XptUBpdtMiLKvRs9O60L0xWVUKO/hAImgBKASXw8539a1p2gRFBfBopzZ7L3mb9YH2fn
 aCAa5On2+PNyeelCpEE+xIIDaHGTBd+g0zXt5457AoS+GNrWBQNJkJKIciCdzt+tZ7ii
 aat39KmMWFaVH3i2aPVxIzaVFX+WlPPFf1rXcDRq8397GTRhTC53YKnsqdT/BFmd+uXB
 q1+w==
X-Gm-Message-State: AOJu0YxLgc3ya+UlLN5G1MKliiatwHludukFShLy7T9mTkDGhYaqDjWA
 JZIds+BquO0hgJmLoJ2u5U4pLKp+HBTkEIIVc0TwAlFJqktZ+bAIKxAWHetFRVKJIgy6QjG5zbm
 BMR8ogE8=
X-Gm-Gg: AY/fxX5wU1CuzdRl/mKDZNf8AE0jArx+GoRFXaMyDxuSc6u4tgeB8QojNAcuZSMHIeA
 LhjgXwcHfeHIzoS8kvKKx+3zsiM74vgzrblKfIhraAOWayD4i1G5Pz5WH0dFQD3tbFxDXNul8RF
 4qm+ZQFF8wLmNcgrlcbDmZU5wcmV6EHxOvvhjnOSoiDSgMM6sQlpECIAeQwnZJ4vQ2QutkJ8kxC
 7LYT4apj7Rixz3V57c4YwnfFOTv8CXNpFKrOclZ6yRkQV2a7uvAE4ayJNIATx0+83x/7k0/aTKD
 z5HtrsFVMc2e7pLQ8xEpXRLvYbZxt9obmYp5arbQIqtWNw9cMGlFD3Z+e2AXw08stQgxVmCfeLp
 Z1E6QncJ2p8EueaoqW5sQgTwLsCbQb72MEPulcfpk9txwGVhKgcUbi/GeF82+rObfyzVIRIPpQG
 a+uRpGzvStL8dWU1vt54lXPKppGihr0trPMTBDSFFEwF6/KdW0AVTKT0iaettgPMomdUymu4rBu
 UQ=
X-Google-Smtp-Source: AGHT+IEfHLVVRfxI8hd1x0+dbXf3lwrsDSCqzuApNsr3vsT8mjwypJRlqlsAlrB96JLn0KZDTxDSqQ==
X-Received: by 2002:a05:6a00:808c:b0:7e8:450c:61a1 with SMTP id
 d2e1a72fcca58-7ff66a6d896mr33758355b3a.56.1767166453774; 
 Tue, 30 Dec 2025 23:34:13 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 04/11] plugins: define plugin API symbols as extern "C" when
 compiling in C++
Date: Tue, 30 Dec 2025 23:33:54 -0800
Message-ID: <20251231073401.2097765-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x441.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3fa..e44f863d839 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,10 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -1210,4 +1214,8 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
 
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.47.3


