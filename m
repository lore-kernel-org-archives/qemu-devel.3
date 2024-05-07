Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82A3C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HLR-0004Of-BQ; Tue, 07 May 2024 05:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4HLG-0004Jq-B1
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:42:35 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4HLE-0007QX-Pr
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:42:34 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5aa1bf6cb40so2028558eaf.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715074951; x=1715679751;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQRoBwM3VtnsocziBWRdu7rYUqFpcQLBHetkRLLTiYU=;
 b=LMbbNQ7kd/cCVdVhY9bCb9lkOCosyI6Wb0OMNKvzQd0ldmsicpIb6n37ojB5f2R8l0
 WLJDJ+58RdFNWD87d8dpkLQfAVsUC6kw0dXdagObPSm2WIpvT00ZvYAu/YNRTs6tcGjr
 Q+cyuSo8RTcTVM5tQhvPvO/+7w80VXhPxin6Pw+jAZjMCq8+L6oCiWK0DcbOaTJOLPkV
 9g39h5rEHaO2fmTwRctVa+5jbF+zohlPhBD058UtsQKgoSDdW1hhVu07nwMK1GbYF93l
 NSZ+ZYniZHWHy1mgC7Niqz1bYNEusfDl8sLSeCRkaYhUSpRSHGYAsMhUuNBWBx0mX2Nb
 S//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074951; x=1715679751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQRoBwM3VtnsocziBWRdu7rYUqFpcQLBHetkRLLTiYU=;
 b=lYhhcQOpZWe94oAuEeaK0TR/KFnKR+U7YTDz6Rn0jux4FLW+XH4249ljrbq+9HFKjE
 m6o5mg2sd7hzx4FRFsq2lFkafviZLo3PSTo0A6zMYNAhudTUGnyjlbwuAboi5ET2QrCs
 uH9Pr8KrRXJbjbFnI0PPbYEq6g3cLvRgPeR/OIayw3w9r7aKCV+AD4SF+WNN5NYvWZcM
 mFqffW43xTft6sULOZT+8BJD82YSCb/0U0XllzuWdyl27QWWAFIaYExjE2fjbrAovuCa
 CDE5IDmx4GOo4VEZDFvbVBM7vniyCOwKtOWAJaNVY5vqCeJgl7+1cnlqcTOWfH5sH8Nu
 KMyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ITn6MMFP9OV2JmOPKDpiAb2OkTFoh7m2ASmYOk7KlE3zrasPo/46HTqqHzqT2AM/xhQJlanP9cj5aHmsEafzYCn4QNE=
X-Gm-Message-State: AOJu0Yz0IeKC2NuD57Ln8wDtXYq6RdT98CE/zz6Z6a2bToXO9Y6C7p3y
 Oocqpn/5Vw+e9yS9JMePY3pRfL0mcdFb2Q1gpNaZzkIeNLvIgTiEFFZiD8yQUg4=
X-Google-Smtp-Source: AGHT+IEG/0TuRLwzQxW/D1sjrN+5fUhu4/gTpvaJuEd30uRZlJBkD1RtlW187x6s3KB6l2+vTrI4Eg==
X-Received: by 2002:a05:6870:c0cb:b0:239:876b:b23d with SMTP id
 e11-20020a056870c0cb00b00239876bb23dmr15527133oad.24.1715074951638; 
 Tue, 07 May 2024 02:42:31 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a62ab04000000b006f45257d3f7sm6434114pff.45.2024.05.07.02.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 02:42:31 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 jag.raman@oracle.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v9 5/5] vfio-user: Fix config space access byte order
Date: Tue,  7 May 2024 02:42:09 -0700
Message-ID: <20240507094210.300566-6-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507094210.300566-1-mnissler@rivosinc.com>
References: <20240507094210.300566-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
2.43.2


