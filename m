Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA5FDEE56
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG43c-0006hd-QC; Thu, 23 Apr 2026 20:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG43Z-0006gr-0g
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 20:06:05 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG43X-0000zO-Gq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 20:06:04 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso8087510eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776989162; x=1777593962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9pycH1vrpngd62Fq+G7Rj4pLVjPW3yDgHDKQsT+bWY=;
 b=HkUuW2i9cWbX9o+aadbLE8r6bqZ+HMln5icK1XGv4LJKuQlsPBJEHWJveoeEqGoPMY
 51xqBxinLb0LSWSdeRw7Jd9+G9O6XqPm3iZONOmijN0+gg07Zd7nQmNur7MgTplZH7yt
 xZDkvEuc9imqr8+2MzUgS8NTQh98MOxNDICB/8TBEJwqlhoSn7joBxsykO07UPgrVGaD
 nNt+olbyFYk/9BjRQGSfjdL40Qar+mFD2ixqt+mM4AKUvkgjKkQOd2AQ8tLQxYiew+Mu
 4NiWuf4x9nCeAnjERSU71F+Qx5+icFXruze5Auu2lvFmvSON7BpmG1jRKsWqOYeQ705Z
 c9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776989162; x=1777593962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R9pycH1vrpngd62Fq+G7Rj4pLVjPW3yDgHDKQsT+bWY=;
 b=IhP1eai7703W0E+anDuDLp9Ee0TxuZqXY7k5lP+UNQBpDz5xrbc2VuUFafLDG2Iu9Z
 GnL21LKMV44ggTq3ieq9o+21idly3UKm5ojHIhBwCBGkek796qRAqIrDbkO54Mwa9KBT
 DoSCtLkNUEifB1MEzHfAJBou2Ks5+Ds/pgK6h4ILTZ+xhwvF9kbvhy7gyWAnAfI62CQ1
 VRE+wgZ/P0VPx2xVvVU2pmh5WMCtGiaR7gzYquiT2l5zkBKZEsVyGCjg5PhdZC0IR1J+
 vOz4pdw6Fld7pw+4zLFVcZ2xHq4aPAAPV95hJsdsb1GeSUtXI6b9SPkABh7lbxPdg+Vq
 b0IA==
X-Gm-Message-State: AOJu0YwAbo8nWWseeKIre2w0uNFQ7vHOMUvMNi3tk+tzHQTDUqWsRRaP
 cwKvqDkGhwKtZA4TQIkDHh5LP9sxD9qlpG0AE0UfxoWYblNfxPowQu32iBP2WOm6jWM=
X-Gm-Gg: AeBDiesI6Ya/eQ04fz9rUNZBXix0+4T4PgRkotSaA4LBKphrv/ll7V8q0mWiqfaA4oq
 3bHLwRZMw6JcCnA+17AaTEa9x09XykkP9AsUHhf0/yY/qYEnBH5F8UuRGKPuBzZK6nwkMuf0i8o
 dQEj6EtwzmPE8voODDjOkglOCsvyKlPxVT4w3cgw2VYCxp+DiHa3T/CqXfwpR1fwi0CpyMumr97
 Mt/FIRIOLa9ajceSgcr4v3QxtCo7DqHqAieb60vx5QiIwF8WXFprvmSy/afHq1r8IXqDqv2dfhs
 zNlYO/m6YLxBzVn7liEXtf85yZQf2m35/Ei70ESrkOoSJzP7cW9mCuXCAz4AS6E9ZnblzctFoKL
 +wxyfK2s252rmUiC882OoAIlFEBmo/Gc2EdQq+lD+B/wcomreIxuu6aZ8JSaUQCfzV3E2Nkrx2x
 PpGp53FPG6LJf+QD7cLTl1Vf3Aw/Rv5cGKV6JR2xxU/ZXkRh3pgBpFb53OIS3no4xGFA2nYym2
X-Received: by 2002:a05:693c:2c0f:b0:2d3:4252:b127 with SMTP id
 5a478bee46e88-2e479017537mr15538048eec.26.1776989161517; 
 Thu, 23 Apr 2026 17:06:01 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:c4b9:45be:963d:f3a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ea8e4b373dsm12958055eec.6.2026.04.23.17.05.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 17:06:01 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 3/3] target/arm/hvf: configure IPA granule on macOS 26
Date: Thu, 23 Apr 2026 21:05:44 -0300
Message-ID: <20260424000544.9617-4-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424000544.9617-1-lucaaamaral@gmail.com>
References: <20260424000544.9617-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1335.google.com
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
index 1b5860c7..f506fc01 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1270,6 +1270,38 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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


