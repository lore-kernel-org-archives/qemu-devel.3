Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43401C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXx-00014t-6F; Sat, 08 Jun 2024 04:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXs-0000sT-MM
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXr-0000AV-8R
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jl7+qZ8Lq0CXcPMg6Cgj2G+ARy4KWfNqMA1f/i5w8wQ=;
 b=i0RTgBWn36t3poDEMJWrxpKBYjfeFAUsAhOZJ8lR8Y8wcIeU5Nu26HubIZQQz0Fl5Lx1Ds
 2lKhXzlhlMeNfme3o/xJhvZozlnp7c1vJpl96eXOqWAHdcXhUotZX6g9XZ9D2aHipDsdmm
 TxWr0wThIP2IzU61dGVSoQMh00rbqt8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-YamLbM2NNrSUT88Kts6STw-1; Sat, 08 Jun 2024 04:35:24 -0400
X-MC-Unique: YamLbM2NNrSUT88Kts6STw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c602f0125so1047075a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835722; x=1718440522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jl7+qZ8Lq0CXcPMg6Cgj2G+ARy4KWfNqMA1f/i5w8wQ=;
 b=kOkv+yFllCXKN2KOnNY5nQ8HaLq/c4oOXy/DQgqDJhio+FxE8NRbpeajlS/qk9C1bt
 a64w2N0U8bKip0rRW9og4EeGsxwm1gAshYncvyP5aeg8XVNt4f6A5YEPkxHu/jZPagjG
 +yo4MQNLcG+TBL1dJJhR/Rk8XvXUjF134NOpuqJYMKkKn6H0ylWX3V5iyUozl+KJwH5M
 RAaI6tIb//rY+3nm8Qu0RQ8a8rsMMH7n+0bgIqyQ8zyI7x+gH2bUzLcPWEt72hUeTPFD
 gda9vs7M9Pr8PcFSpjJtHFu0NykuE+UL56AThXkP01EVkvnFpJFaz3+GECJ4CqsywX4A
 JdHg==
X-Gm-Message-State: AOJu0YymBEMvw1BxMruW/SNpNeFDsyd0p/dG9LlpRf6Z9CBU3wzfsq3j
 C+hIzzFevlmu9qdT1gqKmXq67y6h0sun3ns+H0UA1ISfoSTknPf0h9U6Zo01WgTZBdt/+l1z/6V
 bOLx/zwXJqNptjuxXc5MEjiSu884vLXPcaX+3k/0OOc1Y/R2rJDfeHhDlVZu3JOBh9nuwgWmcNk
 mRhqIuOUTE5p/qF9pn4mELHFWKOa1GmmHehBFP
X-Received: by 2002:a50:8d1a:0:b0:579:eb77:6d83 with SMTP id
 4fb4d7f45d1cf-57c4e3f6decmr3638011a12.13.1717835722676; 
 Sat, 08 Jun 2024 01:35:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU4nQuEPGdY2JTi52BVxeezKOm6ky6zrjRks5lo8yie/9IH1VnJaCkbZr3N5sx2wN7zuqZ4w==
X-Received: by 2002:a50:8d1a:0:b0:579:eb77:6d83 with SMTP id
 4fb4d7f45d1cf-57c4e3f6decmr3638001a12.13.1717835722335; 
 Sat, 08 Jun 2024 01:35:22 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae229729sm3960517a12.79.2024.06.08.01.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 24/42] stubs/meson: Fix qemuutil build when --disable-system
Date: Sat,  8 Jun 2024 10:33:57 +0200
Message-ID: <20240608083415.2769160-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Compiling without system, user, tools or guest-agent fails with the
following error message:

./configure --disable-system --disable-user --disable-tools \
--disable-guest-agent

error message:

/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
/media/liuzhao/data/qemu-cook/build/../util/error-report.c:38: undefined reference to `error_vprintf'
/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
/media/liuzhao/data/qemu-cook/build/../util/error-report.c:215: undefined reference to `error_vprintf'
collect2: error: ld returned 1 exit status

This is because tests/bench and tests/unit both need qemuutil, which
requires error_vprintf stub when system is disabled.

Add error_vprintf stub into stub_ss for all cases other than disabling
system.

Fixes: 3a15604900c4 ("stubs: include stubs only if needed")
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240605152549.1795762-1-zhao1.liu@intel.com>
[Include error-printf.c unconditionally. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/meson.build | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 3b9d42023cb..f15b48d01f0 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -3,6 +3,7 @@
 # below, so that it is clear who needs the stubbed functionality.
 
 stub_ss.add(files('cpu-get-clock.c'))
+stub_ss.add(files('error-printf.c'))
 stub_ss.add(files('fdset.c'))
 stub_ss.add(files('iothread-lock.c'))
 stub_ss.add(files('is-daemonized.c'))
@@ -45,17 +46,10 @@ if have_block or have_ga
   stub_ss.add(files('qmp-quit.c'))
 endif
 
-if have_ga
-  stub_ss.add(files('error-printf.c'))
-endif
-
 if have_block or have_user
   stub_ss.add(files('qtest.c'))
   stub_ss.add(files('vm-stop.c'))
   stub_ss.add(files('vmstate.c'))
-
-  # more symbols provided by the monitor
-  stub_ss.add(files('error-printf.c'))
 endif
 
 if have_user
-- 
2.45.1


