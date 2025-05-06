Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A3BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFv-0005G4-Mn; Tue, 06 May 2025 11:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFY-0004RL-DT
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFV-0002EE-Hr
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qx67xMT1TMuCw8qji95H0O7FGDWHk87xA/Zg/NRoPzU=;
 b=iPxlVmXzw5QvHgAOFZIejx/48H8C8J9M3bJcuK0pTtrofDHcpuP6ot+FxHuQvbJGEqkUDA
 u8XIPa1Uzv/CBAtD8wDJbwqZKfmXuzalS0/8QM032zr65oPcIpuF/r2DkNPwvp19yxPz2p
 KK4Cvf0yeixTs0Zyw7qv6W547Vkh5Is=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-AtwkoTRXPJ6WTIdFBTBZjw-1; Tue, 06 May 2025 11:30:19 -0400
X-MC-Unique: AtwkoTRXPJ6WTIdFBTBZjw-1
X-Mimecast-MFC-AGG-ID: AtwkoTRXPJ6WTIdFBTBZjw_1746545418
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso40984925e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545418; x=1747150218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qx67xMT1TMuCw8qji95H0O7FGDWHk87xA/Zg/NRoPzU=;
 b=I4ooiphDHJwZVuc7ym32nVHn9X9SeyAL6T6AiDPNo+vbs+iiI+xTduZpqp6b/3PTc4
 BeJ/hulzS/QB6ZY00ehUj0SLvvEmlvuBveRGpTBb0t6zlQCmGFX3DYm0GpbN3CP7XtGR
 hf9ECC59rieyOQcZ4FeFOGJjSt/1iYP7pTouZ6wN8LP09LmlaZxe9lsm+bFKUvGsaGG9
 htlWuoJf2FbQjdvH0CTukn5tiu9AvDNLfuC1MW3wYxvvGJUF5hn4gW/JIJ1kZ3EQM7yA
 7BSQHcYQTRAZWet8QAjfC4f0OlDIyaRUBHKUWaARKCt/fbq2ogZPh9hiqHK0V4KNdA+L
 jxGw==
X-Gm-Message-State: AOJu0Yy9o9BNBfA4In8u+89vvpzucVmb0/AxjLKfu2WI/z9kLYXPaOem
 A4Av7QFMLUBHkaOZN8tCT2lql5MlHM/sqQk3v8IkDTBgeadWLpuWc7jFEmu85nylaIorxe2iYfV
 WAZH9GjTwAv54YDV9ySlOCRt7mrdpwdy13veBxIfjY3vCYHa4IaEqFzP/0G/d64tjhISxAkJD6V
 aPuJnbz5VNLyuSjFzUne31lpLOM/gPOh4IqB7e
X-Gm-Gg: ASbGnct2MdZS+L3CvX0WzCzfiiBv1J2uH2Eb2356KbK6U7BLNsTY19/fUkh9oWo3JQJ
 AgZihZdK7iNZMFdYT4Y7OwuabOGyjWGitU4I1PLVQBuBWnyvD/ZdL77T8hAiBKCJ2Tt35UMs/R/
 s/TiqVzvkkcaxDcfjc5xAM1HCvtK1lR8qHRP6Her9n9ZzMNsXmFw6EA//vgLByDyz8YCVrd8nfq
 eTBOa5IVcb2KFoJfB6Fnsx7LwMECm3Cvp8227u5D4TRoWoB9sqnBVQMOMdZhHJj/UHrlLN4tE6T
 2wOHZDBgC3FeB9E=
X-Received: by 2002:a05:600c:5111:b0:43c:fb95:c76f with SMTP id
 5b1f17b1804b1-441c96a2795mr92128545e9.9.1746545417987; 
 Tue, 06 May 2025 08:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh/J8GlUI44Fd4PtAuIRb2mb9YyPfXD3qaO5QwjT7By4wZvr1mNB+AMWucyT+PnSgp13HzUw==
X-Received: by 2002:a05:600c:5111:b0:43c:fb95:c76f with SMTP id
 5b1f17b1804b1-441c96a2795mr92128135e9.9.1746545417470; 
 Tue, 06 May 2025 08:30:17 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89ed4d4sm170854225e9.19.2025.05.06.08.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 23/30] block: Fix type conflict of the copy_file_range stub
Date: Tue,  6 May 2025 17:29:18 +0200
Message-ID: <20250506152927.222671-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Emscripten doesn't provide copy_file_range implementation but it declares
this function in its headers. Meson correctly detects the missing
implementation and unsets HAVE_COPY_FILE_RANGE. However, the stub defined in
file-posix.c causes a type conflict with the declaration from Emscripten
during compilation.

To fix this error, this commit updates the stub implementation in
file-posix.c to exactly match the declaration in Emscripten's headers. The
manpage also aligns with this signature.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/938d2beba15d4bd496a600ee401995fbaa385c62.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index a845e2836f5..ef52ed9169e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2080,8 +2080,11 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 }
 
 #ifndef HAVE_COPY_FILE_RANGE
-static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
-                             off_t *out_off, size_t len, unsigned int flags)
+#ifndef EMSCRIPTEN
+static
+#endif
+ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
+                        off_t *out_off, size_t len, unsigned int flags)
 {
 #ifdef __NR_copy_file_range
     return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
-- 
2.49.0


