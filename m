Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A87E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSaf-0004Nn-VK; Thu, 02 Jan 2025 16:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSae-0004Js-Im
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSad-0001R6-3E
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso3695298f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852725; x=1736457525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDI3lCD1sPhDvWQCISzoMNySRhiCGgE2MRu1ybe3Kgc=;
 b=yA6ZT4lsDGCgd3t/lXcg8mo6FbFDr3qXU3I39hihpc/gLHEzqKljFIzvqsa76o5ivi
 Uvv/dlTq8IQS7QJ22nCLbCi/8PMHASEtol0mVwRujiQ4a8jAqO/S8A93+cyohegMaFLE
 lqDjcQGhMsMDYTcF6XpgcSyq1/vlwELPbcdq5lf9+jM6m0dz4mRlyL5CnGgtmTeEv6Ao
 0fGHTFsP1vIP3bWsVCDOOU0pLN4qIqqttS2wuIqzaN4pvkudhiBYmlry1BnKMLcnIRHW
 aCy5XKv3LrEyeIzv82dY4e+flpv11djTH2Qf5KMl0kupy+IQ3R4vLcw1YJpz/NuPgVyt
 fAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852725; x=1736457525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDI3lCD1sPhDvWQCISzoMNySRhiCGgE2MRu1ybe3Kgc=;
 b=w7EEcZCOrkZl/cMGURCm3k1hL7NsDx3C0L9bKUUC/hVb4OcIWhivM1Hu7xhPwPOIks
 0+Pk56jTTmvn8gEjoWzZetxuCr1nV7rBM54Z4RsTPJJqcOHX4cOv+QP3b1G5StAaY61F
 LdqdPJNppGZ9Dn8V4XlBe1RQD+KVdfysjgltKRMiGwk08aZEsMpUCh+hCJUAD3nP3gYT
 PjztqXJGc7Zzzm+DarZUcM8bCCDVxnAVxBCWZJmZjnDLsb+GnyNykxhMLmXFpIwBpKjW
 sgZLNbQPhNGtMojwOwvQrTR9be6EiJn4qTwxaPayC2YkO7oHnaHeFOiF3CohHZseyg46
 vQBQ==
X-Gm-Message-State: AOJu0YxcgQXXtp89zk0oPpSVQvXWPSEsyaB98/JuenF26Gpp+vSIx8By
 XvthR6FmLAqSHDUGOoVD1zwuPGv8KFJxiuIwh5CM4SknQNUk80StlBlzRsxF7hvzQXS4rEtn7SU
 D5AS0Qw==
X-Gm-Gg: ASbGncvPIfPreaUEhGBhL/zl2lu3NzNpYTIH/5u1pG0S5XQkOhjkCNDgGhORBS10bZy
 Nh/VS5XPqlYWbLaAZgHXD+Hh9x2hC8d9MSQ8I3RUbp0MMqz/V9FwnEguaBSijy2SOMiDdbamEO0
 ZDBvW7AFrOWbxQow9WrsHwr5fHd+4JNvxl07NA2zmTCZZ/x7e5WVUQZI+31Mbvq4Dvd+6CRkcWk
 7hSwGKmFZTxv5Hu0q56RcTdLm2NOyFa+tWA4GcGbp/JW6P0NjHEdpHuXAFyC4e0sRxH0XSxTQMR
 uI2ZILoSdClrQ8ak/OL1/0G9uWQfUQo=
X-Google-Smtp-Source: AGHT+IGVqfWMXOa8PWWxT7VDpGVEh5nDlTlhMEJ4cZk/eo5r036XGZvq+eeNOm7o+8KIKJx/sDlFzQ==
X-Received: by 2002:a05:6000:3cd:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38a222009camr33679904f8f.32.1735852725465; 
 Thu, 02 Jan 2025 13:18:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e140sm39906532f8f.79.2025.01.02.13.18.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 8/8] system: Inline machine_containers[] in
 qemu_create_machine_containers()
Date: Thu,  2 Jan 2025 22:18:00 +0100
Message-ID: <20250102211800.79235-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
References: <20250102211800.79235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Only qemu_create_machine_containers() uses the
machine_containers[] array, restrict the scope
to this single user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
---
 system/vl.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 20e0eaf95ac..0768f93f9f1 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2113,18 +2113,16 @@ static void parse_memory_options(void)
     loc_pop(&loc);
 }
 
-static const char *const machine_containers[] = {
-    "unattached",
-    "peripheral",
-    "peripheral-anon"
-};
-
 static void qemu_create_machine_containers(Object *machine)
 {
-    int i;
+    static const char *const containers[] = {
+        "unattached",
+        "peripheral",
+        "peripheral-anon",
+    };
 
-    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
-        object_property_add_new_container(machine, machine_containers[i]);
+    for (unsigned i = 0; i < ARRAY_SIZE(containers); i++) {
+        object_property_add_new_container(machine, containers[i]);
     }
 }
 
-- 
2.47.1


