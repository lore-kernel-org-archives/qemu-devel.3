Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D499D0C5F8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Gqe-0003Sn-Dc; Fri, 25 Oct 2024 05:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4GqS-0003PF-T2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4GqN-00047N-Tf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729849374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EGXu5CBuE8xwKZlIqcgq1tN+U8GgEV5+6D9N6jIde4E=;
 b=ellBGuPtoTC4BWtZYtDyseMJrGM6TeJGTkcrnWDTbo9VjT7Cvl+DsBY3T7hPHzYm2/6MIj
 PT7Ptv9IA2ADes3eN6Ham7OTRtqcPFMngY852ctKLY/ZDeEdm+v8LT+MziUrn7fZZDpzjv
 gkwWzmWkVdB2MQttd+ADSqngGdx4dI8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-UR_rfZ_lNOa1DRyVAlL9IQ-1; Fri, 25 Oct 2024 05:42:51 -0400
X-MC-Unique: UR_rfZ_lNOa1DRyVAlL9IQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d59ad50f3so992673f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 02:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729849370; x=1730454170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGXu5CBuE8xwKZlIqcgq1tN+U8GgEV5+6D9N6jIde4E=;
 b=aQdni34Tr4xxBcFZbuYJ+j2VTn8tIEEXrUOSxXebxHgzNnMY1rxk2DU2jOeHirED4C
 aOBZ/ZAGFa9jrpgqfXzinNyORQ7ERZnzrLg7TstDUJwreIT4ybJJj6hgc0JPmbz+FYps
 58CNSiICA2Ue9yzgCLhujBSKGGw9d775BoDd0AHbjO+BzR9oh+yhkPaeH39wbXGBS9xl
 TTnnSdHo7A+t+78nohFmdp3iZTpYcDykzX9AakPjMGlSyWGPrRUyLfc7NpsF4RmCl3I/
 AGraBWIkNfNs+/ivlp97mtC2kq6KOhBggZ/TR57rn6eoo8PrkoVOSYinN9nezEF2nAal
 YAxA==
X-Gm-Message-State: AOJu0YyeAEMB3gU86obLmaEUtQckxGeSYjLVqiEYy3WyZDWqivEUpFM8
 IpeBUQhLYRppG1KtvPmS1mdmmzGh4dpxlLzu5qV2gaZEOx2xqMkhQ3wCo65r3K34KK86sR0uZwz
 AQzQ5C3j3GEpXCMoaphI7uZrKVBpCWDX7T25mHSGUI9eBXw8MUZJWIw366+iXBFRPVPqXVKr+jz
 RXAod7aAgSxoYWwOk6AP9tB4rBwubDWSJgj7np5bk=
X-Received: by 2002:a5d:4b4f:0:b0:37d:4ba1:dcff with SMTP id
 ffacd0b85a97d-380458b5eb2mr3538761f8f.42.1729849370127; 
 Fri, 25 Oct 2024 02:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERX/bo/0f21aLEXfvAPl5NBOxWmLHZ0+WaXsTgB9TIYC9J0x3x0l21TrPqurmgSXYW6o6/qw==
X-Received: by 2002:a5d:4b4f:0:b0:37d:4ba1:dcff with SMTP id
 ffacd0b85a97d-380458b5eb2mr3538745f8f.42.1729849369718; 
 Fri, 25 Oct 2024 02:42:49 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b71406sm1065728f8f.84.2024.10.25.02.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 02:42:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org
Subject: [PATCH] rust: do not always select X_PL011_RUST
Date: Fri, 25 Oct 2024 11:42:48 +0200
Message-ID: <20241025094248.152556-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
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


