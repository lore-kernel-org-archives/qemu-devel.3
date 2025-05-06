Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9211AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKGA-0005mr-5f; Tue, 06 May 2025 11:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFV-0004OF-MX
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFQ-0002Dv-CH
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfC625DT60DQslJrqD8Pl442kQIAsoNeAmmMzCsWRQo=;
 b=IJgkBIqaMeNZxfMmM//GhuM1IHlvZpKqT5DaME19PJyp/5Ig1kme/4S5nIt4W5iuo7W0aS
 BUvROtTREcWgakVDlM3/RHy4NXdaOF4jfGI5LbMqlKM03k+Gm3ezwtUJ7HDmnnxW/yWSYK
 +vmGlFMg1zfAVkxHhemUtVVibXuvDc0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-kAbOWJh7MTWxb5mzwNVb8g-1; Tue, 06 May 2025 11:30:17 -0400
X-MC-Unique: kAbOWJh7MTWxb5mzwNVb8g-1
X-Mimecast-MFC-AGG-ID: kAbOWJh7MTWxb5mzwNVb8g_1746545416
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4298so2961049f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545415; x=1747150215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfC625DT60DQslJrqD8Pl442kQIAsoNeAmmMzCsWRQo=;
 b=dd3j6egNFTl8mxSj8wRmWC+oM7dyZt3WbKUA8Sa5nrZmvbpP/AIo+wkGvCHRxjqylj
 nBwL7YOvooZLd8lgjEwBVGtujBG6rWjzZV0duuWC8HnnGODtBDJwbE+c3K73ETVev6tH
 EeYUMEuP9zNz0DbtALlnS8nQdVNFXvhHFDSlbRaVoYUXukUrX7pe7uu6E27uhHocdSnW
 OzRUaUefREmRJzvPzRE5uYDMh73eue/BMV2nWUf36lmuOj0S6ShzOWj+ubpby3HTnjF2
 DUVjZXtxb7WbG2HvDhupIXu3/X8WzrjGNKqbREwEW2z576VAjY5xyXqh4d5nvf2nVIw0
 jOkg==
X-Gm-Message-State: AOJu0Yy6g9g2H7tdt1Hav4squW32PB2QO6/yeIt+zVkitV+40RFGt0RF
 ebA9XAssGQFtvlIuuxCkFqDK4JWbTuhCpGcfna7QoFsuOSNVP4LH8J5YXgNvFtIiFoTlrpR6KAz
 26rmM8/hfZdIlSeHO8hyDFX4QUup/pnSZSJclxZoTQOd04ylSrFgX/qEmHVcgP0H7dZwT9fXg/q
 SqITadzXfpaG5nN6R/SF/7QZUHjbauTfxTCpty
X-Gm-Gg: ASbGncskn4DGTiXuam3wYzir/2QxvvgQulAD2zkxApT/Rl5FrWsQ/gZXOoPn4HDulr4
 RHPU0kktQnoIwvXWKeZFmRHX+OXXfnwTT/L3/hKMWiZeaUiYWDiUQPcJYMrteI1yWlz0V4ekslj
 BxdjTbMHIKwtxqcVmwAF/bSTstMmSAVtGTbNpZYQkWbUrW3PLAKxxCwc4QGPUY7UilnC4VvigSP
 QLdB6w1SlLqNThcG1eR8wrFehwomd0BCAiTDOpGICHR3wHJSD1Q/VKCTjhVcSJsqPVMaozWMd+I
 5txxvpQW3IGnasQ=
X-Received: by 2002:adf:ce05:0:b0:3a0:af28:f879 with SMTP id
 ffacd0b85a97d-3a0af28f88dmr2073549f8f.31.1746545415503; 
 Tue, 06 May 2025 08:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPTqc+PbxN96GhXDFspjVskfJNf8kvsV0NmGHH7u+kWzkkF5aSLWstwJnic1W7QDTlxmsmsw==
X-Received: by 2002:adf:ce05:0:b0:3a0:af28:f879 with SMTP id
 ffacd0b85a97d-3a0af28f88dmr2073528f8f.31.1746545415147; 
 Tue, 06 May 2025 08:30:15 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0f09dsm14162866f8f.63.2025.05.06.08.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 22/30] block: Add including of ioctl header for Emscripten build
Date: Tue,  6 May 2025 17:29:17 +0200
Message-ID: <20250506152927.222671-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Including <sys/ioctl.h> is still required on Emscripten, just like on other
platforms, to make the ioctl function available.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/49b6ecdbd23ff83e3f191ef8a9f7cc2feeaea43f.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0d85123d0fd..a845e2836f5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -110,6 +110,10 @@
 #include <sys/diskslice.h>
 #endif
 
+#ifdef EMSCRIPTEN
+#include <sys/ioctl.h>
+#endif
+
 /* OS X does not have O_DSYNC */
 #ifndef O_DSYNC
 #ifdef O_SYNC
-- 
2.49.0


