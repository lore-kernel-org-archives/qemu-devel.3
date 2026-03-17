Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE7DFED9FE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YgV-0004Yw-Cu; Tue, 17 Mar 2026 13:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YgG-0004Wo-Jo
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:58:15 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YgC-0000kB-Fk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:58:10 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-126ea4e9694so839046c88.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773770284; x=1774375084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRfNN7dQR71XGPxf5F8n2Fq8CgG24SE+5S4X1Hu3a50=;
 b=HnButinxL6BGEgsm1RKsVDdiMS7a4nd+299pG1o8OeKeCL7qDAvTqd07ZSxQwH7rHK
 JqupGKbc28Vir0tCpu6X8Ii5evDMIJV2rgsEECkPij0lqgCK/KCAZop1Rhv4FAUmi6DF
 s+SqS7lW3/5tjZn/vWNI9DaOUI2Zl78OELF2faruaGJM9z8aZUO04qzjfRFEc3v6HYaN
 Y6muCnVmak5O1fNxFymNbdsYrygF1cPXvU/dg0qLgi6XmwziLpmjxNmpwNbv1Iae8mwE
 K/0aHRxUper0z1do1RgF85Psv/kPDNuMBhD9D6bbALSb6tnQAEeoMqx5CYhegZYyPhO4
 c2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773770284; x=1774375084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lRfNN7dQR71XGPxf5F8n2Fq8CgG24SE+5S4X1Hu3a50=;
 b=phOgbfn8GsX5/T+rBoO5CldLhQ8sa/opBpAIRWq16Gki2RGBuKCx9zvQVutZRq/H1n
 iHq14E0j2lNdvQqkGb+qhXCaXdeL49qSEOlQ6sUXf5x5/D32BAJx1MptCI/ERHpCJ5nf
 s0+qSlOgIaYtt6KNnz+mOAuUv7zh8SXDTfFacjz0P4qWj6fTtIzS2sr67RxrhrWGh3IS
 GlJPvBkfnfLVLDMjwSogJqS8MnYfbzNSfAehWzgeD4ETIhfBuS6TJ7OQyca6d5mTVge+
 H88L1iCQfLVYqKtc25q4xmjdW+n+3vq57m7/oVlJy7M2fDsmAwNYYY5rTyGE1ycGCUJb
 P4ZQ==
X-Gm-Message-State: AOJu0YxtnSPD+UOSPJcol2/OS+XEOc+R/eZz5pNQMglq15A7CG9ZuFcb
 Rl3tSom9vrDC6alWIOW/aRFoUqIFegLtmgI7GuouZXjfV9R2tikdhi0X9NFYD+Hi
X-Gm-Gg: ATEYQzwmIOKUtb6x1ycRvoPe4hePP0qGz9yiQhLRdUzUZimMFf/4Vzstk2hETeiuxDh
 gUO1TPD62MaVOSgFSaUSR7XN6/uEhgBaJhTSZqTMe8ZiJnbSXlrrS4ryKGR1WzwJoMOH607lHMj
 dxoI/9dG2XVzRv6bTWQvSsC0iU96nYY+vCx7IammQEvUSozo+KmCyIXc/GFhTkCYebwDRW1GBQ2
 cSBO4s+djz5zzEMIvWowJaqqL3PcFyfMwZIFwkn8rV5P0k/GquswmtSbM0Dth225qqbZtLyia++
 TcOWPlz27J16GsOOA7MdNTiVoHDGajQ+IGCvBW3H3iqJTl1p7aOJq6w0zO80ClLLddc5akr0lpr
 1mz+/7nIkUT5j8MTHDlaXg81Xnkp3lF1J7W0Y7nA1O0jHbk3c3JH5eJ6Oe1IKX79s/peMxK6VbM
 bUsGlh3/K+liWEQJnDKd1lFgKKkdEtx42Qyip/if4fGWsmjmG3hwBV
X-Received: by 2002:a05:7022:10c:b0:124:8d7d:2d63 with SMTP id
 a92af1059eb24-129a7195e45mr209803c88.35.1773770283404; 
 Tue, 17 Mar 2026 10:58:03 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e55a2be4sm237884eec.22.2026.03.17.10.58.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:58:03 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 3/3] target/arm/hvf: configure IPA granule on macOS 26
Date: Tue, 17 Mar 2026 14:57:44 -0300
Message-ID: <20260317175744.32469-4-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317175744.32469-1-lucaaamaral@gmail.com>
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
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


