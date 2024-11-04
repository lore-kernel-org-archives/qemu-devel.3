Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7806CD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80so-0007wi-49; Mon, 04 Nov 2024 12:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sm-0007uT-25
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sk-0000Sj-IQ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QK+LcKwTEsZTC5wwU8k/6aVDIU/PlZ/5smfW6kbLSso=;
 b=f/ve0QrLxj7wPNbJPXmu3QDSUcUDrbg3iUpNY6LyzLOafkVR3QL62/tlXFOztGMfEU0WzH
 ERsiLMtCkzj11h000Zc2k6hUMVCrtUGdTLcvFJROu96kYX/atZRuLALsAKMfGtoUg6efgv
 6Yk4cwR0HwkCOiJ0hZTakQR4O+gpgAE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-b8Lz2dacPye40Ik_ZpNvSQ-1; Mon, 04 Nov 2024 12:28:48 -0500
X-MC-Unique: b8Lz2dacPye40Ik_ZpNvSQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4317391101aso29014585e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741327; x=1731346127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QK+LcKwTEsZTC5wwU8k/6aVDIU/PlZ/5smfW6kbLSso=;
 b=VwGkWZ00r3qJPBmbjslFv0zL9ZboFDVcJWIyjSU3Mbew7+gkMT3xJrYDw+WlO4N6U7
 ZAKn5TtNs8BVn4WmLMfQo49InBwzqSCF76DXGhuSXBlnGa8fEgyMF6lwcCbK6XPuQZXz
 cviXh2cprMdoMloprSSx9IcS9I1dhXImEeNYdZKuhgpVW/wfsZGtIG/NDUKbekJWIJ0E
 aig0xHE7bav8dvkPgIErpFOGVquAdB/rSmmjcokvOY38qBppn8nNQ9mTUxSzEw58123c
 fsENdVlrIPbxhliC5j+5Nr58B16OwT8kPWVWhnYhq/d8otF7+B8w/lXkmrqEuhp5/LLM
 xhKw==
X-Gm-Message-State: AOJu0Yz+Ge3nt0uOjcXGVYWT6NelCujNTa8p0w9xYufRoldYt3EX1Pbr
 /sGCJyRVKRbNLLGi8LNrv593h4i+5QCb7Kpd6hFxMVju7MoTlTtgprA1xcoYYw3pa69gH52vXWl
 aORDtVRRz9YyQ9P1mmRoouimq53smPSNW9EcROyWMO1KJuallJNL8dmRnlt972vXbWIWf+VDmt/
 VQ/Je2oviTR4+3wdYQkQJP1Tvy473gHnOaR1F75q0=
X-Received: by 2002:a05:600c:35cf:b0:431:3b53:105e with SMTP id
 5b1f17b1804b1-43283244e02mr114578565e9.9.1730741327227; 
 Mon, 04 Nov 2024 09:28:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi1o2sbXYlIEhoE0F3gvtkYiuXjnxDYtY7Uli/ywTdRbnC7z34yPvIrCNJWy+opltzwi/gdA==
X-Received: by 2002:a05:600c:35cf:b0:431:3b53:105e with SMTP id
 5b1f17b1804b1-43283244e02mr114578215e9.9.1730741326790; 
 Mon, 04 Nov 2024 09:28:46 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ab254sm159391945e9.3.2024.11.04.09.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 38/40] rust: make rustfmt optional
Date: Mon,  4 Nov 2024 18:27:17 +0100
Message-ID: <20241104172721.180255-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/meson.build b/meson.build
index fffdeef8c80..a0ae56c9625 100644
--- a/meson.build
+++ b/meson.build
@@ -115,6 +115,10 @@ if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
   endif
 endif
 
+if have_rust
+  rustfmt = find_program('rustfmt', required: false)
+endif
+
 dtrace = not_found
 stap = not_found
 if 'dtrace' in get_option('trace_backends')
@@ -3987,6 +3991,13 @@ if have_rust
     '--allowlist-file', meson.project_source_root() + '/.*',
     '--allowlist-file', meson.project_build_root() + '/.*'
     ]
+  if not rustfmt.found()
+    if bindgen.version().version_compare('<0.65.0')
+      bindgen_args += ['--no-rustfmt-bindings']
+    else
+      bindgen_args += ['--formatter', 'none']
+    endif
+  endif
   if bindgen.version().version_compare('<0.61.0')
     # default in 0.61+
     bindgen_args += ['--size_t-is-usize']
-- 
2.47.0


