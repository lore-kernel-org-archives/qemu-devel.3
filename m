Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0412CE8E6B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x3h-000426-HO; Thu, 24 Oct 2024 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3a-0003yy-Ay
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3T-0000EL-QA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729773306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IqAdLZglfKpF6mjDCcx9wZhknDWLZEahtdtuSLLUoE=;
 b=ISLhFzB1/ra4oVzIgrzlemaRMqX922/CKWnGKoJiks9DMaEob1vz3TCLV7p2ULXUsFHFu/
 0hioxJjl8pVSDBqCekD1zaSizDYi8X4IJf+vpPJJDeDw3oSJwKTpXX1WUg0NU+/SOdVG41
 KAJFYcF3L8WQdPEuGbRrU0bb0WVi5gU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-GU77_GaeP1Kh_mcYXGrf2w-1; Thu, 24 Oct 2024 08:35:05 -0400
X-MC-Unique: GU77_GaeP1Kh_mcYXGrf2w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so6924395e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773303; x=1730378103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IqAdLZglfKpF6mjDCcx9wZhknDWLZEahtdtuSLLUoE=;
 b=pbtPCSEOZc8dLpgUSTh6kVCXfx8nz62//KAvnYE6i66ftS1kjMB4LNxTrWDAwRxdmB
 1nNFejHc8QucTpzp844fzCI4FejW/Mwnzqmhwv4K1v0KdU6OwUbd6tdFD1rKqMyo99Pe
 zXkkBhYAlfvJjZmGoPE61u7bDw+7IepEbxpl7GFN10yOUgSj8YLpN3zC6OE146+57DTT
 qnZ7QSJcZNZEWTe3ubjHEoBVHnHKXxpYDpN/0+j3E7Qmclx7rp8WJlvQ1yfHcgszuFEK
 ZZoJsDQTRUdaIX6DHxkwYSECGV33fM3HrANNUPl3a4JbvwQvY+Am4aMGrpeWaHtPiQ0i
 spcg==
X-Gm-Message-State: AOJu0YzK1fJ0aZ+WFv1XMq6OQ8Y/DT6YCvZbGlTNe7uhIMqf4DzDKUWn
 zyHaDol/FU1GLyeN+L5TTysgl1+Bq7sCOxnaclCXTaBu3TWydOLfYjOm4AFpmq6IVrpEjLdryN1
 GOcyJjjs4bKS6VeWVZAjVpIxxkMiDWouaSMvbOTNhdB7fd+ibp5wZdfh+dmGVbIRhlCZzwEgBIe
 3LLW+WNZO270OP9fKuzQftAiruhJ93EXeaNrRDKkY=
X-Received: by 2002:a05:600c:1c11:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-431841aff4emr52466015e9.29.1729773302878; 
 Thu, 24 Oct 2024 05:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9bGGUeqi0HkJhxwXe67VNrAzubglPXelqgAxyEJYiDrtE9Va8432Ftm9vVaOMIiLSQiEjqA==
X-Received: by 2002:a05:600c:1c11:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-431841aff4emr52465745e9.29.1729773302417; 
 Thu, 24 Oct 2024 05:35:02 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a37935sm11212187f8f.17.2024.10.24.05.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:35:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/8] stubs: avoid duplicate symbols in libqemuutil.a
Date: Thu, 24 Oct 2024 14:34:52 +0200
Message-ID: <20241024123459.59350-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024123459.59350-1-pbonzini@redhat.com>
References: <20241024123459.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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


