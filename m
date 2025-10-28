Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1837CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcw7-00021D-7H; Tue, 28 Oct 2025 02:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcw5-0001wg-Ip
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:12:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcw2-0006eW-P6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:12:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47719ad0c7dso3283175e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631916; x=1762236716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aS0vYK7FAdW5kWmJPk1Aw+AgekaHr8JT0J7mwxVb5Y8=;
 b=l4MjM03AmdtHcEYzfEK377jgo1/UuHByPo565hJSUuVaETIlFN9ohhA0NedgPvZ/9f
 ZQsybBxxB/PtEKckeMdhbRJTQLmRh7g/po15lSJ1e/l3CiurMAeKlVN4PCZ4b2Sf29km
 1HRxn5k+PkbPFQenQMIQlVg52+mo7KI4UAcOSEneYPwtruEHyLV5iDvjHdW7flLwbOr/
 ALZUwHE+HUK701RyicZqwYGmyh5px6aVT0uGYxns9KtIRFKOEAd1kvj6IcOZNUQWDHB4
 weHy6EEjv5hTeIGZ8StxD1uBKs3TYlhTPEiY+vTL/MS3468qVcDPRBKVCosXoiwZ0HOP
 f+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631916; x=1762236716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aS0vYK7FAdW5kWmJPk1Aw+AgekaHr8JT0J7mwxVb5Y8=;
 b=MCPfwLTpezNIPbgHD6pCia+FutGO9zD4ueta3RYxccEyOtBGDw03Z2PwvmxJY+j+h3
 gRwrljAWgjfoLiqSk2tBZEGua2J1dGr21MioOug5ddzSu7Osaj6oVzqkUiG1DvOZ2OyZ
 7mpNPduee8DeTNBeaPOOnuWcTzpXumZAso510crkNFGgSMV48lNrlJ3UAcy9U52WObg/
 0zY/Z2tCbGnpbVWpEBWFlj6MjKHXpSJvGK5hN6oh1nMgGEF4+42G1vTAgx/jHexjIsGe
 5hkiDXoYP3L4iVmgwalN8HR4l++5gf1n/P2aYrqOpL5M6+Y+YEmESSdsTGJyjpi0CJCa
 91YQ==
X-Gm-Message-State: AOJu0Yyd48c25A8xMuZHW7GGWKDaxY5yeBLWvCPGfVSRK787oZTQMmGb
 KgsoBicoRmKpVRgOM3njKZ20dyrEGC5e8uxgsM2JNGDK7Knlt32/xvrCbB5WsOlU/00Yeb15Sxv
 R2Fo8iLg=
X-Gm-Gg: ASbGncsqOfi6Uglez0IqyZxhlBp7e+r6GxzlHViWQcXXmTAVHlerl8thew//9VcUvae
 HW0Q3uk/nURy9931mzzhtlgrG3gNj/zvY2Z7y8H1/dMj4P1XaYOXMcQ/afvUHlFQsl3sr7Ms3N1
 025ngYL83c3ArdabIo9sDy0aywbbEzi9/v+pPw/N8e7SXyMDB1RadlTHGbZy0H4xgHJft8CYYsM
 Ax7oGTY3pDTCxtR+9+L+yyC04inrxrZRwWusxZx+sjw20SlPH6dJliVGc7KEvR62RO7k0OUltcZ
 A7qD4IEDtQqake6knZSehOuZtA2S23Yg6WmI3eXi3c7SYEVqseJolE0qKA7OFmxN/cOW5c37wzl
 5wtGVhtEdG/OT92AFSU+a8ivoGS2U/Yjqm9BRM8QaPNmQIVyrYAz6muKAY1o9OUxZpi5Ia2mafM
 gDAc7EgXaSrh7j7IQGu/4f5pQBNAoNwQoRC2nay9Sj+CkWKl9onyW6Mf0=
X-Google-Smtp-Source: AGHT+IE72oYOMRj8XSpUowEgkmW4Z2idwqu0qjpbI2MexT3/IALEkOeQmPs1V3bK+Xmn7o1P68mtBg==
X-Received: by 2002:a05:6000:609:b0:429:8bfe:d858 with SMTP id
 ffacd0b85a97d-429a7e96e28mr1862265f8f.59.1761631915551; 
 Mon, 27 Oct 2025 23:11:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5773sm19840666f8f.27.2025.10.27.23.11.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:11:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 41/59] target/arm/hvf: Implement dirty page tracking
Date: Tue, 28 Oct 2025 06:42:17 +0100
Message-ID: <20251028054238.14949-42-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Notice writes to pages which are being monitored.  Mark the page dirty,
re-enable writes, and retry the instruction without emulation.

Assert the fault is not from a stage1 page table walk.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v3: TARGET_PAGE_SIZE/MASK -> host page size/mask (rth)
---
 target/arm/hvf/hvf.c | 52 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index de1e8fb8a05..da2f4cf2e9c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1869,9 +1869,10 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         uint32_t srt = (syndrome >> 16) & 0x1f;
         uint32_t cm = (syndrome >> 8) & 0x1;
         uint64_t val = 0;
+        uint64_t ipa = excp->physical_address;
+        AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
 
-        trace_hvf_data_abort(excp->virtual_address,
-                             excp->physical_address, isv,
+        trace_hvf_data_abort(excp->virtual_address, ipa, isv,
                              iswrite, s1ptw, len, srt);
 
         if (cm) {
@@ -1880,23 +1881,56 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
             break;
         }
 
+        /* Handle dirty page logging for ram. */
+        if (iswrite) {
+            hwaddr xlat;
+            MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
+                                                       NULL, true,
+                                                       MEMTXATTRS_UNSPECIFIED);
+            if (memory_region_is_ram(mr)) {
+                uint64_t ipa_page = ipa & qemu_real_host_page_mask();
+
+                /* TODO: Inject exception to the guest. */
+                assert(!mr->readonly);
+
+                if (memory_region_get_dirty_log_mask(mr)) {
+                    size_t page_size = qemu_real_host_page_size();
+
+                    memory_region_set_dirty(mr, ipa_page + xlat, page_size);
+                    hvf_unprotect_dirty_range(ipa_page, page_size);
+                }
+
+                /* Retry with page writes enabled. */
+                break;
+            }
+        }
+
+        /*
+         * TODO: If s1ptw, this is an error in the guest os page tables.
+         * Inject the exception into the guest.
+         */
+        assert(!s1ptw);
+
+        /*
+         * TODO: ISV will be 0 for SIMD or SVE accesses.
+         * Inject the exception into the guest.
+         */
         assert(isv);
 
+        /*
+         * Emulate MMIO.
+         * TODO: Inject faults for errors.
+         */
         if (iswrite) {
             val = hvf_get_reg(cpu, srt);
-            address_space_write(&address_space_memory,
-                                excp->physical_address,
-                                MEMTXATTRS_UNSPECIFIED, &val, len);
+            address_space_write(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
         } else {
-            address_space_read(&address_space_memory,
-                               excp->physical_address,
-                               MEMTXATTRS_UNSPECIFIED, &val, len);
+            address_space_read(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
             if (sse) {
                 val = sextract64(val, 0, len * 8);
             }
             hvf_set_reg(cpu, srt, val);
         }
-
         advance_pc = true;
         break;
     }
-- 
2.51.0


