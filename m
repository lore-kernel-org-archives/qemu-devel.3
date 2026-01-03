Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579F9FC617E
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 12:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc17T-0003A9-3K; Sat, 03 Jan 2026 07:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc17P-0003A0-QG
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 07:52:31 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc17N-0000rS-Vt
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 07:52:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso130310955e9.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 04:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767444748; x=1768049548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r/nWNJN1XDWpQOj3Vf+9tyeVcOrzXHmX5FPR3uXCwuo=;
 b=D369GKMnP/fmrmKfDhm1GM+9b4m70Av2b1zDd7CvzJnVj3DKofRz9GSSwLx2sGTdPg
 yCaS5pC/lx+sWiNBwgs9wX5MfhMbamrpRLgiVYtwYi4Wc+Yvro8RD4MdRA7uV3h+hplt
 6oIoqe+zwW6ttCIk68p+qaQUugkkCPFxG76Hv69erQOribT9jsK8HiwmiVl2MPbaVWun
 6bNTfkcb0QJAdlIzV5y/WBKPtIqf6Cop1Ezscj0mHIWDmJlNS50NjDkon11WL6qACD8U
 rLfwzoQzTC+cDFbKkqWiUbwcostM424sdICfm5Pm6KWfdXcZxGkfe9CV+JxweT+d/wX5
 lEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767444748; x=1768049548;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/nWNJN1XDWpQOj3Vf+9tyeVcOrzXHmX5FPR3uXCwuo=;
 b=cuXYWAC5eguQpgtCx84IjrPobyqxkLM1uyzxVOkhm3ZE5ppF65N2VWCCygEHpIMmx8
 gNKqOA8M5y2ESW9O0/FrfeRTOVOeZBlpEgnWS2FMBbJ1JxpoYg1OakRMOtKhEQvbQXxE
 l3i9ew/medgz1bPx3EldXvU7Aqw6P99su0c0apHamaQQEKudKLn04jPBNBy1/ifLCKID
 JOqWPVU/XXL+4KPS9orX6wXIGK4Goo6ZcPNQkW9FkJq/qH0SiB2JfdAXNaOFKTVjGsmS
 Y17rDA6ClzYrM1VOeoLGL3i/FnaA1A3yLysDwVwADO5MQKIvNNdB/VSlZLYHlkMbCP6t
 5Erw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmSXeN0MlguW26h5pGMDrn2/sniXmfD+dXZeHGGSqkp7DKky0HC1PeD+GwslcSTBdE9w9Rdo1MavOO@nongnu.org
X-Gm-Message-State: AOJu0Yz0KJgyzDdKmklwicXYGKpn+h9fJhVmWmIHA58uyZ24YDba78nx
 xsYvDpX8VAVnjd8ARUnnwEUrSYwZvwa5fPLZ6i7smBmM1bvmapKkvoiCQCoKldWvJBs=
X-Gm-Gg: AY/fxX4ACyvdmv+Oug15qPfbpmeSmiAhOmRfNV+WsxELHxaPoJF/0JP66uma7xsIGr+
 fBDehEp/gI3h9mjRN4uyIK6kKkUFJfpQHSVfPyKvnD1BuvOHq8slQiWWrpz5B7uj6fOTpyiFxMl
 gaW8jn6iHyRquiaxAhwBXJvnnoJGekPf+CfgX5Y5/OycGZqO+ucmEAxmwAciXLqKopozzheKaLs
 u1jJim7p59EbeJ/W7RXeIXfHi9ZbyHZFN1+BVuCOk1U1mJWMy8jj5n65+fmwlDxXwiObHuTtpgI
 tX05wcX/sTVEMwSXPImaggJpOw5tFWDOt1Zp60Fm5CSiBOMbMHhwJi7u1VcddOI+3e43kNCe3ZB
 fNLacnD+Zm46K3bcFvyjWECZUFgNpOxave59RHYLMpnsHNq0c/6bAuq0Q/xPTpiIXmtjIZrHaH0
 cfiH9wgs1uEG/uczzCTolVGodcB2g20mpe89XMEyty8Bg3i0EHtTPW6c4m5ZOm4/W0+kfnCg==
X-Google-Smtp-Source: AGHT+IHMXksTJHgRo6H9NkTUS/QpVQ0/dp9+ovFIxoerbfyduUUN2U0AtuiMLuR6FGytMTjzKdod0Q==
X-Received: by 2002:a05:6000:1868:b0:431:5ac:1fc with SMTP id
 ffacd0b85a97d-4324e4c9bb8mr55798521f8f.14.1767444747375; 
 Sat, 03 Jan 2026 04:52:27 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm89591537f8f.28.2026.01.03.04.52.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 04:52:26 -0800 (PST)
Date: Sat, 03 Jan 2026 14:49:02 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 05/11] tests/tcg/plugins/mem.c: remove dependency on
 qemu headers
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-6-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-6-pierrick.bouvier@linaro.org>
Message-ID: <t8ah3c.2y0odx1q5exu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>This plugin uses endianness conversion primitives from QEMU headers. As
>next commit will strongly isolate plugins code from those headers, those
>primitives can't be used anymore.
>
>glib.h provides such primitives:
>https://docs.gtk.org/glib/conversion-macros.html#byte-order-conversion
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/plugins/mem.c | 59 ++++++++++++++++-------------------------
> 1 file changed, 23 insertions(+), 36 deletions(-)
>
>diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
>index 9649bce99ca..7d64e7018f2 100644
>--- a/tests/tcg/plugins/mem.c
>+++ b/tests/tcg/plugins/mem.c
>@@ -12,16 +12,7 @@
> #include <stdio.h>
> #include <glib.h>
> 
>-/*
>- * plugins should not include anything from QEMU aside from the
>- * API header. However as this is a test plugin to exercise the
>- * internals of QEMU and we want to avoid needless code duplication we
>- * do so here. bswap.h is pretty self-contained although it needs a
>- * few things provided by compiler.h.
>- */
>-#include <compiler.h>
> #include <stdbool.h>
>-#include <bswap.h>
> #include <qemu-plugin.h>
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>@@ -152,56 +143,52 @@ static void update_region_info(uint64_t region, uint64_t offset,
>         ri->reads++;
>     }
> 
>+    void *ri_data = &ri->data[offset];
>     switch (value.type) {
>     case QEMU_PLUGIN_MEM_VALUE_U8:
>+    {
>+        uint8_t val = value.data.u8;
>+        uint8_t *p = ri_data;
>         if (is_store) {
>-            ri->data[offset] = value.data.u8;
>-        } else if (ri->data[offset] != value.data.u8) {
>-            unseen_data = true;
>+            *p = val;
>+        } else {
>+            unseen_data = *p != val;
>         }
>         break;
>+    }
>     case QEMU_PLUGIN_MEM_VALUE_U16:
>     {
>-        uint16_t *p = (uint16_t *) &ri->data[offset];
>+        uint16_t val = be ? GUINT16_FROM_BE(value.data.u16) :
>+                            GUINT16_FROM_LE(value.data.u16);
>+        uint16_t *p = ri_data;
>         if (is_store) {
>-            if (be) {
>-                stw_be_p(p, value.data.u16);
>-            } else {
>-                stw_le_p(p, value.data.u16);
>-            }
>+            *p = val;
>         } else {
>-            uint16_t val = be ? lduw_be_p(p) : lduw_le_p(p);
>-            unseen_data = val != value.data.u16;
>+            unseen_data = *p != val;
>         }
>         break;
>     }
>     case QEMU_PLUGIN_MEM_VALUE_U32:
>     {
>-        uint32_t *p = (uint32_t *) &ri->data[offset];
>+        uint32_t val = be ? GUINT32_FROM_BE(value.data.u32) :
>+                            GUINT32_FROM_LE(value.data.u32);
>+        uint32_t *p = ri_data;
>         if (is_store) {
>-            if (be) {
>-                stl_be_p(p, value.data.u32);
>-            } else {
>-                stl_le_p(p, value.data.u32);
>-            }
>+            *p = val;
>         } else {
>-            uint32_t val = be ? ldl_be_p(p) : ldl_le_p(p);
>-            unseen_data = val != value.data.u32;
>+            unseen_data = *p != val;
>         }
>         break;
>     }
>     case QEMU_PLUGIN_MEM_VALUE_U64:
>     {
>-        uint64_t *p = (uint64_t *) &ri->data[offset];
>+        uint64_t val = be ? GUINT64_FROM_BE(value.data.u64) :
>+                            GUINT64_FROM_LE(value.data.u64);
>+        uint64_t *p = ri_data;
>         if (is_store) {
>-            if (be) {
>-                stq_be_p(p, value.data.u64);
>-            } else {
>-                stq_le_p(p, value.data.u64);
>-            }
>+            *p = val;
>         } else {
>-            uint64_t val = be ? ldq_be_p(p) : ldq_le_p(p);
>-            unseen_data = val != value.data.u64;
>+            unseen_data = *p != val;
>         }
>         break;
>     }
>-- 
>2.47.3
>

