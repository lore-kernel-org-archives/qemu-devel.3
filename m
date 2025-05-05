Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BA3C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrm1-0004WV-UY; Mon, 05 May 2025 05:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrlG-0003oJ-Om
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrlA-0005ze-Vz
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MCBJ5xtAP2sEtwZTxecdsarRiNYOTzsPMvNmsHN5qM=;
 b=gth1tbO78smLhJsmpIdinR1TDcpWH2C6D6ki2UFfUvbEcvRmyfxrlDcdc3mmbLWn0X7r3H
 3zb8e7tDaCAzdtQhSL+CsefDeVVJ31g/M8I7AEt8T1JuMN5dVIg+MlpGX4mUXcK3np7Djw
 BuwbRPGXxcz83bCrCun7I48zI4a3asw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-l4PlO4XcOwW37QD8W-uBaw-1; Mon, 05 May 2025 05:05:09 -0400
X-MC-Unique: l4PlO4XcOwW37QD8W-uBaw-1
X-Mimecast-MFC-AGG-ID: l4PlO4XcOwW37QD8W-uBaw_1746435908
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so24395585e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435908; x=1747040708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MCBJ5xtAP2sEtwZTxecdsarRiNYOTzsPMvNmsHN5qM=;
 b=RqsxWK4TRAstfvZXAHUObA9acof7ojPFTPJaCQ/gtiZzZN7eiN4ZV4D/+O8dLl2viI
 h+wVdCpOve4uTEMYrVY5KSA+tgZ/MVoYq53SC7rzGxV5WhGamcOapmegGpks+hgCWYUl
 YONha8bnaccoR+S0BPcR03XXcS3cpbG6zNeaxETZuqeCkOqPxBACcdc+9rc13XO6OyN4
 SBm3g2Lpm4nJ+Z83qTZGR24z9mPRJvdqvlJ14KX65j/xqf2bcP3CrW/3Lhnozqak9dQJ
 IgyW26X1uGWnbat/gqfNziWN6BVUCLPMmZCzumhUqJOh/KyejIgAolqQzqi04rnCW424
 S1pA==
X-Gm-Message-State: AOJu0YzN6LrvFVSDvi5LsiSlqa3jkbtKAy393fWRHpzmp8OmFOEXigqT
 DMegZd+LWxS6wNyRJQhoivZ9vyJOErVaVouXOFfh+XkLZ7L0ibtFgacDblVffgPlknyKxUsE9ar
 4IsxJtIGiC9vg7q8IXSIhN7P7wpl5oDbDNzCUpwQfyRLsArzMiNgUUW/lKsAs5WG86hXvkhdVQ3
 BmY4ENnFXIWsU1KpXWcP9r5vAa8O1EMOfzojID
X-Gm-Gg: ASbGnctN26OAnzXO2KZJ/E4tva7TfTDPmfEifwV9pYZ+SqtJ/lznPBHr7DFWfp6sdvf
 //7JtgCRNQWzs21bd8Gm0I7T8L9GHboT6lRc0fLqX79zoGNtav0IylClDAqZ0Tsdkn04cL08olY
 XsB2Oh4aC3/pe8dFovBXHMrf7n06MJa0FPumlb/uKIOX4dLKktUH1gkKVEGx8Eyz56V5xnNghRy
 sfpFvhAeITVaUo0OU20a5FyxjqDRDr0esaAar61iVOhwCgABp2yanmQ90AOleoKfnWgCoI1KAQO
 pb4qu/7thWrofVI=
X-Received: by 2002:a5d:5f4c:0:b0:39c:2688:6edf with SMTP id
 ffacd0b85a97d-3a09fd879f5mr4757526f8f.14.1746435907744; 
 Mon, 05 May 2025 02:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPfOM+qiJU7HatBpa2hM+iVm4GQzW/ZoZETd4upzkhvkbf8z/Wgti0K0h0gtlBbNcQ2zL3Sg==
X-Received: by 2002:a5d:5f4c:0:b0:39c:2688:6edf with SMTP id
 ffacd0b85a97d-3a09fd879f5mr4757497f8f.14.1746435907318; 
 Mon, 05 May 2025 02:05:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae8117sm9871638f8f.56.2025.05.05.02.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 02:05:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 11/11] docs: rust: update for newer minimum supported version
Date: Mon,  5 May 2025 11:04:36 +0200
Message-ID: <20250505090438.24992-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505090438.24992-1-pbonzini@redhat.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Remove leftover notes for Rust changes between 1.63.0 and 1.77.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 557cee72f39..4de86375021 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -71,16 +71,9 @@ Building Rust code with ``--enable-modules`` is not supported yet.
 Supported tools
 '''''''''''''''
 
-QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
+QEMU supports rustc version 1.77.0 and newer.  Notably, the following features
 are missing:
 
-* Generic Associated Types (1.65.0)
-
-* ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
-
-* "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
-  the pinned-init create).
-
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
@@ -105,12 +98,6 @@ are missing:
 
 __ https://github.com/rust-lang/rust/pull/125258
 
-It is expected that QEMU will advance its minimum supported version of
-rustc to 1.77.0 as soon as possible; as of January 2025, blockers
-for that right now are Debian bookworm and 32-bit MIPS processors.
-This unfortunately means that references to statics in constants will
-remain an issue.
-
 QEMU also supports version 0.60.x of bindgen, which is missing option
 ``--generate-cstr``.  This option requires version 0.66.x and will
 be adopted as soon as supporting these older versions is not necessary
-- 
2.49.0


