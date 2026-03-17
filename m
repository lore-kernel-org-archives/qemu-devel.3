Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8444CFED9EF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YXb-0003x2-5L; Tue, 17 Mar 2026 13:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXR-0003dr-SA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:07 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXN-000766-WD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:03 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso7216849eec.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769740; x=1774374540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUSbLOobWbo0z0ehlzPpMYjcHrg09tA0492KwnfG5oI=;
 b=GQI6GNbLMrFKDfjxUD1Ph94a1PfNT6fn7m9K6bgtz+BzO0fMGLbuSWw2+3VWWF9gqX
 aMJxxG9pRRd4rJPSc8jvYt7bSX6IegliJAsR4id/4M0azQMZNpVx1R8iLG5Hm4Rcg58M
 5tL2mgz8pgDe2VcbOPAOm+Xk8HrTvxNE/eMBZecPjauzpbZJVm7S5k2wJnedAKavVIrr
 nbcph28qqZloZ646G5cNXj6XDOCjSpHqGJAhBWzV1zHj9dHTVITCfQriUeyPdOFCQJ/N
 P0OwFaJPGzxKhHPVvrB3kp9xG08dylmPxxHDnRDrBPqNiuplWDVbcbZf5X8HJt5WXxcq
 24Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769740; x=1774374540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hUSbLOobWbo0z0ehlzPpMYjcHrg09tA0492KwnfG5oI=;
 b=gIlmdeam+OXgKd7MiNlq5XuuZVndOCguDMZU8bq7GbppyoDmMNpcrO2avJXa/oJki9
 DrO71MT2ReAmIdEBaPKolZGTmHWsPt5aJzFAgPG8CbYZZiyjFoHbVdNwJFPL0X5MwScf
 K1Staxew6tvNPcjQ2gtm86WG2CkjZd6RsF2FyxNFIIy/J5/ywrQ7fGUq/bAzL+CEFN+N
 OFvPSYvZMDnMSndZ6kvgJ/hJ1c8vCUIVe/jOwdyBj5u/uUvO7Olqy2prWr6omlFQtRpp
 XinMA79ArjmjbjSqAVoHIiCBS9jQSVypQsWBQslhiK+ODjBpbwmy4LzLd4+OF22HBybO
 p6DQ==
X-Gm-Message-State: AOJu0YxoelAZ5CpEgbUS4g/nBnf8M2EDrVjXv+fPdyxXnPEd67+WzjcN
 +UPG2ZZl6VAg38JJb+Uv2CQWFpwPM8rMaU0e0O6BP56xNbCGaYYlx1lt1vMpwXUf
X-Gm-Gg: ATEYQzzijXMJByR4FUhtgA4G0sc9X9OMrABWrHP9JzAy1Er1Yq/idxYcHui1FNchQr4
 SqmraHz7gih+eBwoZSfDfx2/ZyGH4xRpZBVRmSHB3lShpwq414Wq6KZo10GnbR6zGeDK4vKeFqg
 +Mg2z2nUfQCMK7sg5RqCvYASzo+Wa3+IaW/5XbXLsJ2uIJ9Qc0wVhsuBI4aFBjC3zpqgMTfCdnE
 6zryMOMhwFT4oceIZZTeKkdt8IYppmC35L6cUNt5J52dbgU/fgB5UpEUPxcJMqgBL4A86ltg0pw
 wr7fEIbQMRtzP2EgIbwNeeQ/ykcq3ifLyi7VLWdcB/dChDsqxh0a7f0G7N5UlzZItujMVj5t40r
 wd3TGm94+CIenmck/noe1a0Ca1oGrFgZJBM0uIyk02undTzBQm+AoXxr8iHYfl/grB2T5Kg2EsA
 OXnqjkQRs6AtLJ2aDdeCAvXFopxiEwuOl9xr+lXyjclbJe200AGSp7
X-Received: by 2002:a05:693c:3011:b0:2c0:c55c:1574 with SMTP id
 5a478bee46e88-2c0e51930cbmr117430eec.21.1773769740308; 
 Tue, 17 Mar 2026 10:49:00 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e5583533sm190487eec.18.2026.03.17.10.48.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:49:00 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, Lucas Amaral <lucaaamaral@gmail.com>,
 Lucas Amaral <lucas@lucasamaral.com>
Subject: [PATCH v4 3/3] target/arm/hvf: configure IPA granule on macOS 26
Date: Tue, 17 Mar 2026 14:48:45 -0300
Message-ID: <20260317174845.31768-4-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317174845.31768-1-lucaaamaral@gmail.com>
References: <20260317174845.31768-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1333.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Read the ipa-granule property (set by hvf_accel_init) and configure
the HVF stage-2 translation granule via hv_vm_config_set_ipa_granule()
on macOS 26+.  When ipa-granule=4k, use HV_IPA_GRANULE_4KB to allow
HVF to map memory at 4KB granularity, matching 4KB-page guests on
hosts with larger page sizes.

If macOS < 26 and a sub-host-page granule was requested, warn and
fall back to the host page size.

Signed-off-by: Lucas Amaral <lucas@lucasamaral.com>
---
 target/arm/hvf/hvf.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1ba5bbf3..e3b1e3e1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1269,6 +1269,38 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    /*
+     * Configure IPA granule from the ipa-granule property.
+     * hvf_get_map_granule() was set by hvf_accel_init() before this call.
+     */
+    {
+        uint64_t granule = hvf_get_map_granule();
+        bool granule_set = false;
+
+#if defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && \
+    (__MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_26_0)
+        if (__builtin_available(macOS 26, *)) {
+            hv_ipa_granule_t hv_gran = (granule <= 4 * KiB)
+                ? HV_IPA_GRANULE_4KB : HV_IPA_GRANULE_16KB;
+            ret = hv_vm_config_set_ipa_granule(config, hv_gran);
+            if (ret != HV_SUCCESS) {
+                error_report("HVF: failed to set IPA granule: %s",
+                             hvf_return_string(ret));
+                goto cleanup;
+            }
+            granule_set = true;
+        }
+#endif
+
+        if (!granule_set && granule < qemu_real_host_page_size()) {
+            warn_report("HVF: ipa-granule=%zuKB requested but macOS < 26; "
+                        "falling back to host page size (%zuKB)",
+                        (size_t)(granule / KiB),
+                        (size_t)(qemu_real_host_page_size() / KiB));
+            hvf_set_map_granule(qemu_real_host_page_size());
+        }
+    }
+
     ret = hv_vm_create(config);
 
 cleanup:
-- 
2.52.0


