Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772F8C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5DD-0007Tr-C5; Mon, 04 Mar 2024 05:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5DC-0007TP-01
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:22 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5D8-0006IV-Bg
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:21 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dcd0431f00so26278765ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709546776; x=1710151576;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnzpVp5oD/TcNq3luNOD5JKCAhVqC9S3ua2Xfu7/SOs=;
 b=W5UlTy8Q/fHMqIyiOyCRXpeMaAo7+ksnJn+8SPq+Fr29Q9/LlhTG7ZXS/TtXFf0EN6
 0BRD3S0HWR9tVM9Kdk4nEXr1P6yCiyo+DhqROzFnBStEBfLHmGzYRqhTg/QbaKJ3OfNh
 QsRP1LHuCuJ1SG8+ombYqI5kfGcwREwuAj0TazIo635aSTXGLG4sYwxLjjcIwpxm44SO
 r/Qtogi/fdwXx+y2YlDOnwlDQanYU9ShjqZ+GmxC2CZfr+Lzv4vf36LCuW3LeEUqJ+Oi
 rs9GfcWLIsPFT6jYezboKYxpwR4cShwE704kiMPLQ/j6eoobMJBdNgfYgdNu5RkffgIo
 Ti8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709546776; x=1710151576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnzpVp5oD/TcNq3luNOD5JKCAhVqC9S3ua2Xfu7/SOs=;
 b=jgaJVb2DMpx8M1gaQqPWW56/QaKKr/UAzFG53yWcMe5UrC5+QZZEmpC7LKJ3PRZcrC
 OHAPQfFFTE/aGpfzldMCvSuHj0K9LjFv8tG7IDqIeTNl0UOtulxjo+AsJHzm8InVoLin
 t2eFThDbzfqXu39877IU/HDlhPxeEI1F+GINudTqimBE7ciRINNG7YTdMvBRqQ9bZFkk
 WLyzu3/tUIcAXQmLCjoGmvAhgqqRMgoQ2j6kndIfPqNDUOplAYH3isZ7rp1WWTO7qPUR
 jatUxkmGPBa03VAb+Y+k1dEWjg4ZSxgfVzih3e+2ml9aPq46iN0UbD+yWHo+X9KsQV8d
 0c6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdieiSITQOboK+CYL2jELmXVOaDMR0uH6gqU87xb7y4q0XgQSj7Z748Cz+3g6SPLD+IpZsJvAEORtFEKCAPTAlQT0xPew=
X-Gm-Message-State: AOJu0YwdmjdEHxsJfy6qY0UgVITYh0IxA+ouPeMczO1FljbbCKjyGpcR
 fT+M0LUe8+VxFg2z8D4dV759G1voHZ3+vi3hsZ6k9yaL7zfS+2ad9QVa6V5zk+Y=
X-Google-Smtp-Source: AGHT+IGH9RkGDeaxT65gwnBjYMYPmboDYLOQ54D/1YwQYDNmhLc1i+BuDFOl09iYtSkZ/KLbuKACeg==
X-Received: by 2002:a17:902:e5d0:b0:1dc:ffb7:e857 with SMTP id
 u16-20020a170902e5d000b001dcffb7e857mr5284024plf.57.1709546776503; 
 Mon, 04 Mar 2024 02:06:16 -0800 (PST)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a170902e19200b001dc95e7e191sm8091570pla.298.2024.03.04.02.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 02:06:16 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, jag.raman@oracle.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v8 5/5] vfio-user: Fix config space access byte order
Date: Mon,  4 Mar 2024 02:05:54 -0800
Message-Id: <20240304100554.1143763-6-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304100554.1143763-1-mnissler@rivosinc.com>
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PCI config space is little-endian, so on a big-endian host we need to
perform byte swaps for values as they are passed to and received from
the generic PCI config space access machinery.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/remote/vfio-user-obj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index a15e291c9a..0e93d7a7b4 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
     while (bytes > 0) {
         len = (bytes > pci_access_width) ? pci_access_width : bytes;
         if (is_write) {
-            memcpy(&val, ptr, len);
+            val = ldn_le_p(ptr, len);
             pci_host_config_write_common(o->pci_dev, offset,
                                          pci_config_size(o->pci_dev),
                                          val, len);
@@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
         } else {
             val = pci_host_config_read_common(o->pci_dev, offset,
                                               pci_config_size(o->pci_dev), len);
-            memcpy(ptr, &val, len);
+            stn_le_p(ptr, len, val);
             trace_vfu_cfg_read(offset, val);
         }
         offset += len;
-- 
2.34.1


