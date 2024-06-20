Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034ECC2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHRi-0001ha-T4; Thu, 20 Jun 2024 09:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRg-0001be-CO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRe-0006Xd-Pm
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718888597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggQxI/ZZR6ZKzmd07qXaus7hQHvI+R15IGE2EWs6qMQ=;
 b=BvySuifaaRRcTusFyJwhtwEo5W7DZkhu0xZhRNRZbQl32k2rSaPgZal+8+/0UQ7mc1kDQS
 8Ui37NmiEF6/MXXor4k4jAMb7VLK58xsdhAmzuFxarp9wdM1snAVPC+4DP6heFsFxS3H5e
 v8yasXi8wDFQyPCFgRVC7n8U+uZL/I8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-KHoSSO_EPxqDvmxsLgTwcA-1; Thu, 20 Jun 2024 09:03:15 -0400
X-MC-Unique: KHoSSO_EPxqDvmxsLgTwcA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52bc1e919deso638387e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888592; x=1719493392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggQxI/ZZR6ZKzmd07qXaus7hQHvI+R15IGE2EWs6qMQ=;
 b=V1QCWGbU+Xy8Xij2uG6upmdpLl8ae+IfxRSCqNYlv/Z0A0KWbn1huSAbZMo7A1qpKi
 K5cEkZrU/Aemq2xfJF8qN+EvI5PsxUFakKJVBZFqqp/whHoCss489UmvtdZPcZXVgiYO
 XpbAWauPXbGOCPZJ2PVvDVWt86G9YDPkxfecxuLefU9fGkaEM6LgT7D3jEEYJQG+dRy3
 xwWuuJRho91LWTnpenA/KdtBEG4nbQ3bUxAFubBbGTGpXL/bYHeCAlrzT0MCWlGXHOQ/
 fp8hFsxcOjJyrpGZS9U2IYjrrUAj7GqNPexxotI3MCoxSoHGcuX4+aNuaJTi9T8yYoM1
 sTDA==
X-Gm-Message-State: AOJu0YwxFKXfEAqRZOT5o6CMsAPU8IYQd/Kt5CPRrqQ/PbR9lvDLiV7P
 lBtCgmy7wJ4oav59n4njeFoZL7TPJduR9JjoAC2snYqoVE/Q8HmIIhMhL+UqFq1mCFXLF240lD/
 ziKmR57z9RtEVk5fw2k4xdw9frvt9q9XkBeQGjo+9/yQOeaFOj91tO2fvqS1K/rP3EweWgAR7E7
 VjCiIZS9434NHuWPho9MOZ0IxPj8zbv8UZFqZI
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id
 2adb3069b0e04-52ccaa5693emr3925100e87.11.1718888592564; 
 Thu, 20 Jun 2024 06:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhv6hS4JyNuePMtR5yTE+SnK7i8YyUretc3E0b4KyrxqA7rxfJPgVzSU6GzYbMyUwE5+zVCg==
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id
 2adb3069b0e04-52ccaa5693emr3925070e87.11.1718888592095; 
 Thu, 20 Jun 2024 06:03:12 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da3f50sm777493166b.14.2024.06.20.06.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:03:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru
Subject: [PATCH 5/6] meson: remove dead optimization option
Date: Thu, 20 Jun 2024 15:02:53 +0200
Message-ID: <20240620130254.415699-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620130254.415699-1-pbonzini@redhat.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build       | 13 -------------
 meson_options.txt |  2 --
 2 files changed, 15 deletions(-)

diff --git a/meson.build b/meson.build
index 6e694ecd9fe..54e6b09f4fb 100644
--- a/meson.build
+++ b/meson.build
@@ -2874,18 +2874,6 @@ config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
     int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
   '''), error_message: 'AVX2 not available').allowed())
 
-config_host_data.set('CONFIG_AVX512F_OPT', get_option('avx512f') \
-  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512F') \
-  .require(cc.links('''
-    #include <cpuid.h>
-    #include <immintrin.h>
-    static int __attribute__((target("avx512f"))) bar(void *a) {
-      __m512i x = *(__m512i *)a;
-      return _mm512_test_epi64_mask(x, x);
-    }
-    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
-  '''), error_message: 'AVX512F not available').allowed())
-
 config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
   .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
   .require(cc.links('''
@@ -4283,7 +4271,6 @@ summary_info += {'mutex debugging':   get_option('debug_mutex')}
 summary_info += {'memory allocator':  get_option('malloc')}
 summary_info += {'avx2 optimization': config_host_data.get('CONFIG_AVX2_OPT')}
 summary_info += {'avx512bw optimization': config_host_data.get('CONFIG_AVX512BW_OPT')}
-summary_info += {'avx512f optimization': config_host_data.get('CONFIG_AVX512F_OPT')}
 summary_info += {'gcov':              get_option('b_coverage')}
 summary_info += {'thread sanitizer':  get_option('tsan')}
 summary_info += {'CFI support':       get_option('cfi')}
diff --git a/meson_options.txt b/meson_options.txt
index 6065ed2d352..0269fa0f16e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -119,8 +119,6 @@ option('membarrier', type: 'feature', value: 'disabled',
 
 option('avx2', type: 'feature', value: 'auto',
        description: 'AVX2 optimizations')
-option('avx512f', type: 'feature', value: 'disabled',
-       description: 'AVX512F optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
 option('keyring', type: 'feature', value: 'auto',
-- 
2.45.2


