Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E89C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm3Z-0004a9-C3; Tue, 28 Jan 2025 08:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3F-0004WO-Ke
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3E-0006aW-2m
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so40017535e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072486; x=1738677286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0i342P8VSr9afA5LND7tALkWhr4DBdVvCjT09Me9Agg=;
 b=PeIXKkOv/DI7xdIOEg1AeLXDUInspFnBiL0+1hVgMGWhPfypaavq8oLz0BY0TTnpGg
 8Cb0XfpIKjTILIV79vn8g0Yj7krtKCrR/apskwdUsH5P+5xy3aF8Dj1PdYF2mins9RwI
 uSpt01iDeLpKvxPM+sij0BhO5AVdUCkTAHJGZLpd2aUqoMLzQzM7SzXkVmYKRFPApKKr
 /zUrjQ0VjHE5izYNk2B+CD1fN7su4UBqcfEilspEfs2bd5hwLV5ODXjBNhS1yeaaAZgs
 jNuOtyxdAY+TJyQ013h9bQVvDSFWdqgdVtOJaACG7m1alFLtzNRFzJW494Hm7rbnKujy
 kODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072486; x=1738677286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0i342P8VSr9afA5LND7tALkWhr4DBdVvCjT09Me9Agg=;
 b=TptS064fgIsa7hRlYlSsnIPNgIGfZxwbCj5iU/B5GJG7wjQoFNf2RqPskL76rcatrW
 fKa/ulm3IMsza3K464ygCxtsrpdKZASJ6bfhtTtMNNFoxksspZRyaflH15w1l3BUIner
 2jiUra3vvN7zgx6xRgC569einNPaC09WoCDEP6g2GNEEQ6ABWjHXcpJQpqnW2KZFN9St
 bZapQD/OnrA+2ahZDnoZmzN84kYr8tsyx6ftWC6aD2UH5eTvDJGBMZ98gMEQS4M78CDK
 9IOTJ/e42Kiq0ypP0HEUeJvlF7HBcLls+afrHBH7lDhuuF1khcqZrC0CooQBK6Yc+zWO
 ikcw==
X-Gm-Message-State: AOJu0YyCEOtCR/iBnfiOZXc6Vhv1hrWcdx8Q0DayRMgRSMHeVVb4BwQg
 +Te5Lp5qd8PiTQkvi0Jg5wb6zOZR0KWnX1bzSFP2C+owMv748rYaGhgmXZ1vyaRPkCVAM+tsig6
 mBpI=
X-Gm-Gg: ASbGncvOqgfbLHD7YLme5Q1KFqH81WuRnjqYQxAZufWNDVDgT/G4faIIG05+qLascKa
 wcQoD44OIFE/fNgkyGtn5Z3Yi+rGKVGd23ti8/56fY+KXJUnm+zeXSV62Lvfr4Pf2dRj728r9YX
 AfCcvdwwDIT7XyN9TXapim9of/Fg5NwsZ4DWuozAu8hG60Lxe3otx7mJX2SCRlusET4w/T5Ii2u
 ITZilxIgjC29IQRYjkNoYE6t2qTJJ+vhbxsOlm1NYNynJ6e3LnAFXjO4YbsL3hDaCQW/nUOohtS
 f5MLVT++aWqA5KKdl1qDahiwsg070sUSiqrIY9FwlARNvE+217V+5D5o6Gx/2Nw3MQ==
X-Google-Smtp-Source: AGHT+IFszYMNCA760X/36juug+cQmcxc9DtQ3nSuMbWEchxTwOYnx8pEHvT0Le588CdPOzffkysKLQ==
X-Received: by 2002:a05:600c:1f82:b0:436:fbe0:cebe with SMTP id
 5b1f17b1804b1-43891452f6emr461566115e9.30.1738072485683; 
 Tue, 28 Jan 2025 05:54:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438d75de282sm11809185e9.2.2025.01.28.05.54.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 05:54:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] tests/qtest/migration: Initialize MigrationTestEnv::arch
 early
Date: Tue, 28 Jan 2025 14:54:25 +0100
Message-ID: <20250128135429.8500-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some tests expect MigrationTestEnv::arch to be set. Initialize
it early enough to avoid SIGSEGV, for example like the following
g_str_equal() call in migration/precopy-tests.c:

   954 void migration_test_add_precopy(MigrationTestEnv *env)
   955 {
   ...
  1001     if (g_str_equal(env->arch, "x86_64") && env->has_dirty_ring) {
  1002
  1003         migration_test_add("/migration/dirty_ring",
  1004                            test_precopy_unix_dirty_ring);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/migration/framework.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a3bd92a9519..38a0a1a5264 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -938,6 +938,8 @@ MigrationTestEnv *migration_get_env(void)
         exit(1);
     }
 
+    env->arch = qtest_get_arch();
+
     env->has_kvm = qtest_has_accel("kvm");
     env->has_tcg = qtest_has_accel("tcg");
 
@@ -948,7 +950,6 @@ MigrationTestEnv *migration_get_env(void)
 
     env->has_dirty_ring = env->has_kvm && kvm_dirty_ring_supported();
     env->has_uffd = ufd_version_check(&env->uffd_feature_thread_id);
-    env->arch = qtest_get_arch();
     env->is_x86 = !strcmp(env->arch, "i386") || !strcmp(env->arch, "x86_64");
 
     env->tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
-- 
2.47.1


