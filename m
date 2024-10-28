Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6FCD3398C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qkv-0000Cf-9w; Mon, 28 Oct 2024 10:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkd-00009N-R0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkb-0003gz-V3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IqAdLZglfKpF6mjDCcx9wZhknDWLZEahtdtuSLLUoE=;
 b=Pv//e51lOQrZ6rufJ3L1+1yXw/e+G1Ufd3dxbKbdIf7mu6tEbyJtRO5JW8UEmpHWV15YsK
 AU6oW8ZiG1NiX8ACjkTi6N1Z3jtwQvLrY3NlKJQO7Lqhp44nDd3plZlif4CTAY0z8p291V
 fmwOpAuSVxRsU/CO4k25gt28k8uSvj4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-0mqi-hBPNWq4wv9AVN2EwQ-1; Mon, 28 Oct 2024 10:29:38 -0400
X-MC-Unique: 0mqi-hBPNWq4wv9AVN2EwQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so29854315e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125776; x=1730730576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IqAdLZglfKpF6mjDCcx9wZhknDWLZEahtdtuSLLUoE=;
 b=Jw4A0I3sV2TOXeFvLQeFVXdyUtgmP7IhdRsrsy1ww5ZWmk0xYade+t5xcXHN/gdhhZ
 7rygtzuKgkfMl6PTOaiJMD1ZomjcSGK1ZLJu37giEP17QaVG8C3LiBw/VRNGla4WRMjq
 ppfL5KawaVcGbbb9HXLoArCMlIMXIu120zxne+n77jj21Oia+MWCpYMT2AEI5li7fL0g
 8UP9VzioOcdEN8o1/+W23B8DSwNoFdg/1BKMOMpaNVcBngNqgmMFGMWL2NKBMefOgkhk
 kOzWikm/Ec4Y8P+kWfg8BQJ3OK+t2XoeJMYdaf9HiMSoVPD7XNQZYI4G6onl3xHxhSFF
 ASFg==
X-Gm-Message-State: AOJu0YxqPcJ/Da476cAt3CWsRK03V0c71n62cbclLgjeEysVPdZYLgpx
 SAFg72uwEjZskttA1A4Nn6JsueEJ8/FhyNpAIoZdp94onp2fMfEW0vcgaRIKDsqOzA13ncsT6Bm
 T30g0/WdxfNddIrIcY3N/Pzz7Emt8FvuFS/vJV7Dbvn9Z/dLqbM2jle2xMd5XDaIB++SWfqNhvW
 tiL9q1z5bmkV0UJbAvwrFvCoioX5b4g1jp2gBf4W8=
X-Received: by 2002:a05:600c:4f0b:b0:431:4b88:d408 with SMTP id
 5b1f17b1804b1-4319ac6e80dmr70740695e9.5.1730125776128; 
 Mon, 28 Oct 2024 07:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFqUzzKkrLxGnnmzUunDFhhXcb8gYMbwma7vCxKjnQfl8CL0X/p91jNpNksPKrrXKe6+8/xA==
X-Received: by 2002:a05:600c:4f0b:b0:431:4b88:d408 with SMTP id
 5b1f17b1804b1-4319ac6e80dmr70740535e9.5.1730125775773; 
 Mon, 28 Oct 2024 07:29:35 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b9294dsm9598866f8f.105.2024.10.28.07.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/24] stubs: avoid duplicate symbols in libqemuutil.a
Date: Mon, 28 Oct 2024 15:29:08 +0100
Message-ID: <20241028142932.363687-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


