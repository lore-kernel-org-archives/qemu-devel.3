Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB628D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rq-000583-Op; Mon, 04 Nov 2024 12:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rn-00056S-EK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rg-0000BF-I9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGXu5CBuE8xwKZlIqcgq1tN+U8GgEV5+6D9N6jIde4E=;
 b=NdMdb2RceOy1kvkjwZ7j9ggWBQgGow+shSOm6f2yW2PwrkdT+CjbRzZ8btKB6DXMlfDqqI
 4U6pHKhJMpyN6XBalbUyFwsu/idMZ8ELvLSIJUBHJhKbAIVofcK+PZVu8FhincVRT7AvH6
 EV33p0AXGFXbaWkBpI2oeP/2StX3IT4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-tyMd9xvCPYiFOmxoGtUvGg-1; Mon, 04 Nov 2024 12:27:42 -0500
X-MC-Unique: tyMd9xvCPYiFOmxoGtUvGg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4327bd6bd60so30190135e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741260; x=1731346060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGXu5CBuE8xwKZlIqcgq1tN+U8GgEV5+6D9N6jIde4E=;
 b=Wdj5SUbexm83gQ2HECGu4G4UkP+ZJGYmI7eyqtoJuE0ofdXyeosWOI/8mGmUVn2/1o
 ydccQ9YpwI2HJFwPCeibimnQDIofyxys+W1ih/cR3HM77EWCu/wUv9qOtxj24HxvesAq
 iRuzhJBvc81a0PGT2UVsC7tuxcOXWGjos342XIaazoxSulDBTTNTQ7RxE5FpQ5d3RqAS
 l4wz25yCAManX8ZQNmA9P+hvXEk9VMeWVYh4cRFDGStGEoR73HDovbYi2FLFc0qHXq7E
 QgFjeSfDgP+dboOkpCPKSCcYxUQLsMzhuwJaY8DBnlfwH/oMkf+oE3OsWOdEkyyBq0Yf
 leiw==
X-Gm-Message-State: AOJu0YzEgwpiIjJWZipQzTBbBusC5u/gkCIbmdystdjvnM72vuva7n7e
 RvncYGq2Ad2+YccHLEQtH0tNmGAvvbaLzc0FIGWgDBMy/boAXhPJKbUBjiHsUi2Jee7+xDucMeN
 Y185Zi958bdhSzOIHFNL453+KnIzadctRWSsHsdP/4ZVjK47vpZ8BxOrDYhjHBvNUW1HUvXRkV1
 qRVKRCdEzxAHJ0JGJW/8/zUAURlwCHmNLC5VBdNRo=
X-Received: by 2002:adf:fc8b:0:b0:37d:5026:f787 with SMTP id
 ffacd0b85a97d-380611e10f1mr21783304f8f.38.1730741259878; 
 Mon, 04 Nov 2024 09:27:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUe57SiQ8Ew2bqMxFyy0RrQc+kg1McqIBFild4DPEgFSiA2VMp18QcAYdiMXLn/pG0TaG1mA==
X-Received: by 2002:adf:fc8b:0:b0:37d:5026:f787 with SMTP id
 ffacd0b85a97d-380611e10f1mr21783284f8f.38.1730741259376; 
 Mon, 04 Nov 2024 09:27:39 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e69fsm13732368f8f.69.2024.11.04.09.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/40] rust: do not always select X_PL011_RUST
Date: Mon,  4 Nov 2024 18:26:47 +0100
Message-ID: <20241104172721.180255-9-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Right now the Rust pl011 device is included in all QEMU system
emulator binaries if --enable-rust is passed.  This is not needed
since the board logic in hw/arm/Kconfig will pick it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/hw/char/Kconfig b/rust/hw/char/Kconfig
index a1732a9e97f..5fe800c4806 100644
--- a/rust/hw/char/Kconfig
+++ b/rust/hw/char/Kconfig
@@ -1,3 +1,2 @@
 config X_PL011_RUST
     bool
-    default y if HAVE_RUST
-- 
2.47.0


