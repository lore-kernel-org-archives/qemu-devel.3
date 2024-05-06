Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD73C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t95-0005tU-JG; Mon, 06 May 2024 03:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8d-0005jP-DV
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8Z-0001Ut-MF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U47eDFslvtODaOBLy6JXUf96nPFKYjL+ASHgodulSSE=;
 b=GS364NWKcGOVCtQ2d+bsXw8mzMktCE2YRh7OcoqtZC84RSNOro6JyLePSiODR6pWyWk7Ug
 +Ek3qcV9/XTCqiinDLjvhYwt+lCMiUbUN6BkTzp5d5jQo83AYjjyVRm+KDrNjLflvMhrmM
 JAAjEM4yvC36nRR4vxTM/xRfcIDff2I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-ODbux_P3PqO8N_umyOs0Jg-1; Mon, 06 May 2024 03:51:37 -0400
X-MC-Unique: ODbux_P3PqO8N_umyOs0Jg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59a17f35c8so100093566b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981896; x=1715586696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U47eDFslvtODaOBLy6JXUf96nPFKYjL+ASHgodulSSE=;
 b=p7xqT8LVTVeqPyxj3Syl7SBF7hCdJyv+iy3BwWQ5Sz6cqWsQN4sgNuRsQGpKweMjq7
 75NNTFqGjNhQoeShxtXFBBvZhY0uEHFDCoUz+eP/LaffhkRqTCLQcAj1CPTFxFeXz19h
 +ooxQPAHwwinxVECcy4OW1tyiCpYUgKLJPzzMGJKhjQ7zyChbDgZQ1Ahk1L06QrPmoqt
 Xrh5qiRIqmD0Lac4k7xAXVvC0h9TqRRAl6JiBnhZQs3R/SvBK5ULNT34aswvGhicGr8l
 kLdzkvgi4YTeniYcqhdP7c3uT9mNdH10/gss3o37nOkzpHsgluazraqSwWAeNkmZUPgc
 QUNw==
X-Gm-Message-State: AOJu0YykXC5bcc4f2bcfmjjXqQyutR+N1ypt+GyPz7zd9NNPRNqmwtBe
 N8twrsh7UDJG26kL7yFJ2JgaInCkNtZbKMOLcMAHhtzbLZLX490ArP4UP/kT2K8TEngRbKfqHPn
 BPAm3alKXnhDE9M7ys8AUzE1FEq/8+qZ55KnafxxVLMqQsIlMze2bm7FR1YMP6XqDKATjnjNZsn
 XeIs/sTa0Ll48F8OEyiWEuwDMzcJKQK5VoQW35
X-Received: by 2002:a17:907:9403:b0:a59:c9b1:cb64 with SMTP id
 dk3-20020a170907940300b00a59c9b1cb64mr2226473ejc.62.1714981895940; 
 Mon, 06 May 2024 00:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAodIeeAwqUU0lZ/vKcSPARM9xLUseQ7v9CTvDNCa1N3EO6YtpTX8R5KwaPf11UASNETz0zA==
X-Received: by 2002:a17:907:9403:b0:a59:c9b1:cb64 with SMTP id
 dk3-20020a170907940300b00a59c9b1cb64mr2226459ejc.62.1714981895582; 
 Mon, 06 May 2024 00:51:35 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 m19-20020a1709060d9300b00a599f627807sm3274717eji.140.2024.05.06.00.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/46] tests/qtest: skip m48t59-test if the machine is absent
Date: Mon,  6 May 2024 09:50:42 +0200
Message-ID: <20240506075125.8238-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Together with the series at https://patchew.org/QEMU/20240423131612.28362-1-pbonzini@redhat.com/,
this allows adding sparc-softmmu to the target list of the
build-without-defaults CI job.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/m48t59-test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
index b9cd209165a..605797ab785 100644
--- a/tests/qtest/m48t59-test.c
+++ b/tests/qtest/m48t59-test.c
@@ -262,11 +262,12 @@ int main(int argc, char **argv)
     base_setup();
 
     g_test_init(&argc, &argv, NULL);
-
-    if (g_test_slow()) {
-        /* Do not run this in timing-sensitive environments */
-        qtest_add_func("/rtc/bcd-check-time", bcd_check_time);
+    if (qtest_has_machine(base_machine)) {
+        if (g_test_slow()) {
+            /* Do not run this in timing-sensitive environments */
+            qtest_add_func("/rtc/bcd-check-time", bcd_check_time);
+        }
+        qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
     }
-    qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
     return g_test_run();
 }
-- 
2.44.0


