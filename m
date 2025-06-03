Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A0BC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZSL-0004x2-3F; Tue, 03 Jun 2025 17:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSF-0004vv-V3
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSE-00067O-6i
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wF/7AMFohajP7PDXK4wy6zTmbmhbRvXmaQ09K9UIhpc=;
 b=dKQSH3nmjNIo9JCN7vlvyp1fJUpOP3TgdqXh7fAsWgkdkft+MojoCNBCiJ23a/Kg6yAB2H
 mIolOU4h/km97QG/qQvp3dOY0oOdP0Ty5gza0CDJAYw+tdKaTvqtarL/0hap0EwU/Z1TeI
 CUjuFhN7H8nyFKedLMY6BJwOReotkWg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-K-98M1igM_2Ls6B2kGGl7A-1; Tue, 03 Jun 2025 17:45:52 -0400
X-MC-Unique: K-98M1igM_2Ls6B2kGGl7A-1
X-Mimecast-MFC-AGG-ID: K-98M1igM_2Ls6B2kGGl7A_1748987151
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d6768d4dso32857185e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987150; x=1749591950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wF/7AMFohajP7PDXK4wy6zTmbmhbRvXmaQ09K9UIhpc=;
 b=oIEsC0XtH5clh0yFnbPp+cXciK/Ky0SsCU32fGrC0J4RoQoqI0VR5jgzXebK2KdpZs
 XX6WMatCKkvOzogaFCs/9T3mnL7wZUDoUKcbFgASRmU9K9shk3WgINn7/kBlqqpAkLdI
 8MDmTBlrkYOCHvmRm/JykoA3gTTVsZ5Qpi9NnEWQ4Ei39dJt4M7+Yu0IZMoSTevEYx+x
 v+3u6/Y7z9dYw/WgPhpqhZ6ULuE4w06OWT8+Sqbpd3UrDR2b2ffqPyzb+HY9QS75DvH3
 Je3CepdJZu86SpDIqC+UaLF5wkCmD/PYZEu8qU90EveSMAxQD/Oo6TkIlMFH6PIAZvJw
 sg6g==
X-Gm-Message-State: AOJu0Yz+S+wOuRGqVDI46F/p4lrXRGSbqz+3p0fajVPo0arUmpQzegTQ
 usmKagZUT1SFW6l6JMTzVh2iObaP5w5HLpim7UEM63JKHSlEXK8CMKHsKkmEG4JAghnibnGHjYE
 3aPnW4TVnVn7KHugPTkogjINa/0qYQJ4RlrnyE73M4Xhya78BY9LaMLm6Qeth1C0eSJ4azxDzYY
 xvcFnL74UHN4ns0UXpfJieKf2qdDZuU52D9P35QpWV
X-Gm-Gg: ASbGnct4hM2jzXKxIgpLsD2cExqMy/QGp4d9xZ/p/8k3xINLrI21gre1/WRBBFuWW4u
 33/IUNRweNzi8lSrZQZjoLU8GQTjUaFH2CrTs4N97zXvZQoLh9bQCu3MA6rR2XLC8hobPzuq64M
 Pj5vIDIY/Hn+ODGiSHgQk00MwOi5eE7n5mQgBfeDDW2GsRLlnMvNYxG3idOOUidmntp8RvwlyqO
 pPVrh1YfbsE5HCjqe1DX8h2+gNH3gPKK0ByVeDQ+7VWA6Hg/msHpjUUbOtIcWtBhsIb4u82xTyl
 hDlO1Qh61l/yYA==
X-Received: by 2002:a05:600c:c87:b0:442:ccfa:18c with SMTP id
 5b1f17b1804b1-451f0b482ebmr1954035e9.32.1748987150256; 
 Tue, 03 Jun 2025 14:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1dBDZW8QaikG+bX0OEfGehxBWpEufJBLvkClx6rM0UcrW8GuQd5th4yi4crwhqpMGVpMzNQ==
X-Received: by 2002:a05:600c:c87:b0:442:ccfa:18c with SMTP id
 5b1f17b1804b1-451f0b482ebmr1953885e9.32.1748987149811; 
 Tue, 03 Jun 2025 14:45:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000d8csm174591435e9.24.2025.06.03.14.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/16] meson: use config_base_arch for target libraries
Date: Tue,  3 Jun 2025 23:45:18 +0200
Message-ID: <20250603214523.131185-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Fixed commit introduced common dependencies for target libraries. Alas,
it wrongly reused the 'target' variable, which was previously set from
another loop.

Thus, some dependencies were missing depending on order of target list,
as found here [1].

The fix is to use the correct config_base_arch instead.
Kudos to Thomas Huth who had this right, before I reimplement it, and
introduce this bug.

[1] https://lore.kernel.org/qemu-devel/c54469ce-0385-4aea-b345-47711e9e61de@linaro.org/

Fixes: 4fb54de823e9 (meson: build target libraries with common dependencies)
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20250602233801.2699961-1-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 651bd4f7275..967a10e80b8 100644
--- a/meson.build
+++ b/meson.build
@@ -4135,13 +4135,12 @@ common_all = static_library('common',
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
 foreach target_base_arch, config_base_arch : config_base_arch_mak
-  config_target = config_target_mak[target]
   target_inc = [include_directories('target' / target_base_arch)]
   inc = [common_user_inc + target_inc]
 
-  target_common = common_ss.apply(config_target, strict: false)
-  target_system = system_ss.apply(config_target, strict: false)
-  target_user = user_ss.apply(config_target, strict: false)
+  target_common = common_ss.apply(config_base_arch, strict: false)
+  target_system = system_ss.apply(config_base_arch, strict: false)
+  target_user = user_ss.apply(config_base_arch, strict: false)
   common_deps = []
   system_deps = []
   user_deps = []
-- 
2.49.0


