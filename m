Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C805D33991
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qlb-000178-Eu; Mon, 28 Oct 2024 10:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql6-0000Lj-02
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql3-0003wM-CE
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGXu5CBuE8xwKZlIqcgq1tN+U8GgEV5+6D9N6jIde4E=;
 b=BTjYqQzwBxVY4ejSez+F67VHSjFtxS/D5QV471LKELPj1OZX6jZjupqfpAYClnGgehYU7V
 euGbrjlsEd8Y+xmH0Rk+XglVOGWWiHXlBd8T++BFDriJoh1O0ZOQjEl904fzClZzRh+2us
 HlZVEZ8Y1fM4kwcNcHuGW+rBVuEl3oE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-JCOujsw9OBKzUebCaS2XHA-1; Mon, 28 Oct 2024 10:30:06 -0400
X-MC-Unique: JCOujsw9OBKzUebCaS2XHA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4d51b4efso2022390f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125805; x=1730730605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGXu5CBuE8xwKZlIqcgq1tN+U8GgEV5+6D9N6jIde4E=;
 b=unSAgC3nZ5yxDxxJIstosSNwT2ki7bh+o+Ana1N2bs6YCdnTiv+yUm6f0PI6BIpMwd
 X6pbwnA3ypPbXlq+xD27CeEUHhKCtQuEqyC9UsyEa0ixCpqn/GdJBonvjs1N0c3rBX3F
 h79yNraoEF548FMxh/eC7T//bxgZjzxd84x626NyF6SOjZaCVeUaKpIhff3Yqt8kdV+q
 7RqmfzBo9yTjIGZS/b+7OWPl70Gf6Ka19pDSvX0E3UvQ/kK+vO5of1Ex5OB8q+fhxx00
 Sc17sYiS87i9s+VVVIZcZcf12+TaEM4NE77bzU09ZfFjfplO80b8fkudWqpq+7XNMh8U
 u+Zw==
X-Gm-Message-State: AOJu0YyT8a31ig51se0HPk9vkvOWkyMPimkQ04QtdABGzLhnVLnHDEBM
 9oSW+siuEiz7m9AvRSQ/eK8LiCrA7/quthN5/YgvK7mnNOGHEPxmDOcyAvPrmgss5TswSiMeTEg
 T2JroX0dRtu6JmVLZk1sHlCVLP0+H8MWdUkXiK+i85hH1xvjfKnNY46Bwv2qs3a1yGUfM6IgkaB
 ETvAerhA3hS32+v90TR9i2DwRQ5ltxKT9n8KjWsKQ=
X-Received: by 2002:a5d:5cd0:0:b0:37d:4c4a:77b with SMTP id
 ffacd0b85a97d-3806120e398mr5402837f8f.58.1730125804874; 
 Mon, 28 Oct 2024 07:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp+H0MC6HV87o1T9ea9Ubcv7gqAsQ+PvLq8Op8rXLZxyS6lrnYoNLN7w2YFX8mpitRB3stNQ==
X-Received: by 2002:a5d:5cd0:0:b0:37d:4c4a:77b with SMTP id
 ffacd0b85a97d-3806120e398mr5402823f8f.58.1730125804402; 
 Mon, 28 Oct 2024 07:30:04 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b13223sm9643238f8f.1.2024.10.28.07.30.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/24] rust: do not always select X_PL011_RUST
Date: Mon, 28 Oct 2024 15:29:19 +0100
Message-ID: <20241028142932.363687-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


