Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B95C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWFC-0001g9-PZ; Wed, 13 Mar 2024 17:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWF8-0001X3-5p
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:36 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWF6-0007qS-KK
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:33 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33e99b639e0so175680f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365669; x=1710970469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMlHJDMRIAHpHLqTr2iQoA8Xh8BaIO4Idzn+WvdthY0=;
 b=UOZLtLlM8K1O0iwuXrxMRLJoEOld5PAD7vaQigr/873cQ5Fjrk8NVcL1B1Rda2Q7gT
 t7VVUDaX6aWX4v8HMvqCewkp7fz2CPGi1bhikt2L6h7Jqb2dQr+wwWvGRq2zTOqpPg62
 xKy8iVsTDC+G3KUOu9NQhtdwBRFJILCKq8v7wDAnxhce4KqXrKgfGoe7x2VojGCEf5nl
 GTc4/SahZ4vOSbLJUv7frGdOBy8iEkSlcWSLu19V1amuvvKcLzURVQ/UQL0G6mHgI3Mz
 xc5c2QsMs0Oh2wNIj1ePWieDwG5GqJfd0cbd8+XDq/ngdkSQhfikUZHp3GBUIHEp5+oE
 eBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365669; x=1710970469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMlHJDMRIAHpHLqTr2iQoA8Xh8BaIO4Idzn+WvdthY0=;
 b=duc/6gIjDp+ih4iUqs7HcMYCpOBuzAFcK2BYThcyOWYPOdTFShGQkCYtcESDztaI4V
 vi4qjpIdx0R5opCH4r2KakG/EJ9wxVnpqKF5sJKVzN4ER07inRSNaJvmnglesr0+A4Up
 Y+HJDL4tD6pod6WmWgfNPFxAN/Qe/vJ2ydCVB1aQ9rVgv5iSfJ9PQnRcKslu/uwFdB/S
 EInwJnnMdXpFnJpE3d2LcfeoBaVETFqFDuPeWY/d++soW4Fqy2nXRUjF4eUAgZp8EsT0
 h1icW1rL9/g2QBWW+0ZpFMB0gOyc39TgvMaK6gBsV9EnbU9SaAZQBXjbYPvWzuVzRLrg
 9sBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnWGvzL9zLH+/r/9WHw1kl9PgX5nc/HX9nCRGPqeveQg2LAZlyKG+P+GyRd/efOM/SNOwORHWpERbYAQfBkG5cfEhQ3OQ=
X-Gm-Message-State: AOJu0YyNYPv4Qh+Xd1GwT/70n0hgDT/mKioXxv1Pgvskhbl60ohVhAed
 KxlTjDELhIZZeL/ZhXdY5zO4QSY9GuhcmVp0ArJoDjk7Emw3tfqPYWs8ON4wvYo=
X-Google-Smtp-Source: AGHT+IE5YdWXUTth27hEU1V1E8fyQOBWq8O4KldeXvftJ706S8dQ/FVUZAk+M0ATF9M7WGc3KFO16g==
X-Received: by 2002:adf:f549:0:b0:33e:8aba:cd0a with SMTP id
 j9-20020adff549000000b0033e8abacd0amr2538518wrp.9.1710365669722; 
 Wed, 13 Mar 2024 14:34:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a5d5186000000b0033b48190e5esm62867wrv.67.2024.03.13.14.34.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH-for-9.1 07/12] plugins/api: Check for USER_ONLY definition
 instead of SOFTMMU one
Date: Wed, 13 Mar 2024 22:33:34 +0100
Message-ID: <20240313213339.82071-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/api.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 8fa5a600ac..06d3e95da2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -294,14 +294,14 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
  * Virtual Memory queries
  */
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 static __thread struct qemu_plugin_hwaddr hwaddr_info;
 #endif
 
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr)
 {
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
     CPUState *cpu = current_cpu;
     unsigned int mmu_idx = get_mmuidx(info);
     enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
@@ -323,7 +323,7 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
 
 bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 {
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
     return haddr->is_io;
 #else
     return false;
@@ -332,7 +332,7 @@ bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 
 uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
 {
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
     if (haddr) {
         return haddr->phys_addr;
     }
@@ -342,7 +342,7 @@ uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr)
 
 const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
 {
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
     if (h && h->is_io) {
         MemoryRegion *mr = h->mr;
         if (!mr->name) {
-- 
2.41.0


