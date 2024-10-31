Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70124D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLO-00073N-PT; Thu, 31 Oct 2024 13:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLN-00072e-Ql
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLM-00078v-Bq
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IqAdLZglfKpF6mjDCcx9wZhknDWLZEahtdtuSLLUoE=;
 b=GNRjZfy3WeJzgZUFvul9Z/lQ0xTmHOTrF0eFnrdqGLJqqOwhC9KUrrONLTLBrshtAUm5m5
 siLgz921x8X98RvlZ5xB7GelDVpo8wRDQltDFflpLoK7eccKiz3c+B4128L9FospzIQr8y
 ekFh84JEOQWCQyACd/fCMVHv1Wpvs4U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-XrSU30tuObKUCys4fPjunQ-1; Thu, 31 Oct 2024 13:52:19 -0400
X-MC-Unique: XrSU30tuObKUCys4fPjunQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so8708915e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397137; x=1731001937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IqAdLZglfKpF6mjDCcx9wZhknDWLZEahtdtuSLLUoE=;
 b=WymXLIz9wY+z0KYmKJsfT7covjIkk3gTVo/3CTgKkxvESL1GFCymfYTFqiRNbP80ba
 c2aoMEVYktEKKzPESNU52awpMr5eQcjgiSIm/p2oQd8Ink5JXqPQXc9Yo5pHN0VnMFCL
 dQCd9RWPBHandRsd6ug3lUtMAuln8aLns5WGdyepAHsvxwlcLSQk4pdkdV80CoZaoJEV
 5+zA9JF3mJf0IUnsdR/Kp+cmixVbg5+IOsU0Wcr7SRIw71hfRER4EXgm3otDYXpiEiYv
 4pIej+e+dRXuOPf64ypQdDsMuSJEZuOhVVml7ZlNS0Dcr702/mkFGhNT/yiEHV4UPxen
 UBFg==
X-Gm-Message-State: AOJu0Yx4WEnocv+yfwDYB6c/kCIlTXnB5+WK0M5FaetoGpSoh3wYrole
 O11OAOKY5Pc/2UKxAHTQSTQYDr0TfmMGOyItDENpcbOalDV6tb1ikenTVgTUZp8YJ/hclIAzWlp
 cZc+HjZ9L5o0H+GcZWSkrBOH7T53I4zVHxj+QGUMEm3rjkP6QUYAl+4eIaARs0y5ycnKVRhsYMI
 7fo+EGOqVdhZInQCWpbEHbHqJU8qtI8+uvGAsVD3o=
X-Received: by 2002:a05:600c:3b94:b0:42c:b74c:d8c3 with SMTP id
 5b1f17b1804b1-4327b82138dmr35502495e9.32.1730397136964; 
 Thu, 31 Oct 2024 10:52:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPjMaeBA9DIdqvLcaNk1ZQY9ecL7hB/8L0IB2QDgUam4hjqnQev4hZo6DhgX2W4+G9m9ltmA==
X-Received: by 2002:a05:600c:3b94:b0:42c:b74c:d8c3 with SMTP id
 5b1f17b1804b1-4327b82138dmr35502315e9.32.1730397136610; 
 Thu, 31 Oct 2024 10:52:16 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5c65b8sm33554055e9.18.2024.10.31.10.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/49] stubs: avoid duplicate symbols in libqemuutil.a
Date: Thu, 31 Oct 2024 18:51:25 +0100
Message-ID: <20241031175214.214455-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qapi_event_send_device_deleted is always included (together with the
rest of QAPI) in libqemuutil.a if either system-mode emulation or tools
are being built, and in that case the stub causes a duplicate symbol
to appear in libqemuutil.a.

Add the symbol only if events are not being requested.

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 772a3e817df..e91614a874d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -55,7 +55,12 @@ endif
 if have_user
   # Symbols that are used by hw/core.
   stub_ss.add(files('cpu-synchronize-state.c'))
-  stub_ss.add(files('qdev.c'))
+
+  # Stubs for QAPI events.  Those can always be included in the build, but
+  # they are not built at all for --disable-system --disable-tools builds.
+  if not (have_system or have_tools)
+    stub_ss.add(files('qdev.c'))
+  endif
 endif
 
 if have_system
-- 
2.47.0


