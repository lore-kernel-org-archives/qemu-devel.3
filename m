Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC37C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSVv-0001Nd-OS; Thu, 16 Jan 2025 11:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTs-0003ln-DB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:42 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTi-0004WJ-FO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so972831f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043937; x=1737648737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pERnavJS02WsVkpfgEIKcxRU3EPSk+CF5JdtAAMvhiw=;
 b=zzqMGghh+t31Z5RHf7Slz3eW1XWjS3xX1YjiKNwfnnnLe/Dxa3lNtCi+dGidvSttBn
 /+y8LC3VQuFYkNsI804cgnRdgqlSn5gPVN7K3gTd/ne8DBlioqBXTKTg1RWPwZoduRYJ
 zH6gJF3wPsy3wOWe7E24OrZjoC0GvjA45pebIfahfV+IEdAeKUwnaypP0x8wYDh8tPtL
 fuMZFkUaXxUo4pH7De7O2a313PCnoig41GEU7KMy8D1QKEFhn+lcJw8AwM7WFl+NIIs1
 7deO8SOnuErnwUwmVPMuzYOxw67NSuXApMS+/TPvm1TwDkGPtMuYSNd1lNWi3V9jdTxG
 qc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043937; x=1737648737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pERnavJS02WsVkpfgEIKcxRU3EPSk+CF5JdtAAMvhiw=;
 b=LXIUgSeUwt6h8KabDxa0LPLH6A2YRu/b9WB9DSMp619ZN62m+bIesLSNBd+1BFPPD2
 mgb6tNGmvhCqaYEK2EI9/LuTNV2woDsdfufrVv7t3AveiqfmY2iJaVIwWI4KBYNZPOSB
 UEJy1bwfchmUkD0FPCkHZ/sUPrLOEd4aisBIWp4HS756IxSYtrKWcJ+CyGlAkgiZwT0l
 /ITDqLZYXCV02foECGEG1PVG54+ew98oInkJ8374OZjxTO/1r5KPGtqahOzlLddP8gpl
 bbdCDsLA6k7DA3rHBHD3vdNIYmKRmojba9ttSyUbGKW6vZqbBnp/swBZp+BO/X+9+JHt
 mEvw==
X-Gm-Message-State: AOJu0Yx2w6gJFUQ74rksyFvuhQeg1xOUkPbz9uQ8zWRt0BW747p9ph7c
 PtCwwle8NXQ+rG1pZXE/UGtN6WFat6586O8xQgogW3BvDP5DukMLoED8fWNaoEo=
X-Gm-Gg: ASbGncv8BHwxOkb41Msichbe3dPaNUkFy4bU1WRCWwm37jQoei1a/FA0cFL685jQyq1
 +7Vi4cxu0Oi5G+a/pPDEm0OC1c7TBTHfoFPomdeCbw4KCkXJV1468BQzq8RUY54DgIIIXf+TPkk
 NraI414MSwW/qSW2rU4GJfPMf9Si3R8rUx3SmDWHc29H3UOT/Jrg+ItnIs9ldTrE54IM44opu0g
 ICNLh7nLIUsOJg0nH/qcLpMjlmkLBCSE+g9ZMVnlJs97lcK96+A0wc=
X-Google-Smtp-Source: AGHT+IGgmmk0oyXe3GGpOdxL1Kug7gXIyETMxKRMvrOZ/lal+msBkCz621EF+qn4zaDEXtaemVbxNQ==
X-Received: by 2002:a5d:584f:0:b0:38a:68f4:66a2 with SMTP id
 ffacd0b85a97d-38a87312bdfmr30802999f8f.31.1737043936687; 
 Thu, 16 Jan 2025 08:12:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753c617sm64370335e9.37.2025.01.16.08.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A8F7608C2;
 Thu, 16 Jan 2025 16:03:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 20/37] contrib/plugins/hotpages: fix 32-bit build
Date: Thu, 16 Jan 2025 16:02:49 +0000
Message-Id: <20250116160306.1709518-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-11-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/hotpages.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 8316ae50c7..c6e6493719 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -103,7 +103,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void plugin_init(void)
 {
     page_mask = (page_size - 1);
-    pages = g_hash_table_new(NULL, g_direct_equal);
+    pages = g_hash_table_new(g_int64_hash, g_int64_equal);
 }
 
 static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -130,12 +130,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     page &= ~page_mask;
 
     g_mutex_lock(&lock);
-    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+    count = (PageCounters *) g_hash_table_lookup(pages, &page);
 
     if (!count) {
         count = g_new0(PageCounters, 1);
         count->page_address = page;
-        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
+        g_hash_table_insert(pages, &count->page_address, count);
     }
     if (qemu_plugin_mem_is_store(meminfo)) {
         count->writes++;
-- 
2.39.5


