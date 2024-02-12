Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC3CC4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRL5-0000ry-77; Mon, 12 Feb 2024 03:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRL2-0000qg-KE
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:06:52 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRL1-00081g-3E
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:06:52 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d73066880eso27078245ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707725209; x=1708330009;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ew/3DuAeSXfD+s12gqctkm5cvqR42b2Xn6oAkbLXiwg=;
 b=O8YDie9T30EmyJKAqjXx3YFGMuyQTF715nG6kcheH6U5PpIkHnNZBsENyL7RAtNmAb
 ncbmcTzCm3/u8hkmCHWHW4Plr2hBBOGCCkvTXYd398V5tRmPSoAserDXZwnivJwGZXGg
 n3mTSKQR/gmWre3rap6T3dCXFXodUokze97AeyOVV2hOhl1evXaYnWNQyammQcZasjaA
 TmGsW1ay8Q+wQrRgHR2upWZCfh9+9w1VbVcXkVytOsAtP1fjGaOEWqzQessNtq9QPT3a
 SNMjMtZ5ta+aipISvMR/uuAAy0PqrM/nD0PsiuY7hWb2WFPOBM1zAvAfMw9nFKmyxGGn
 n+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707725209; x=1708330009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ew/3DuAeSXfD+s12gqctkm5cvqR42b2Xn6oAkbLXiwg=;
 b=Nb6P8eHPTLj+rZHglNrtHNWnfgref+KXWLguVt+YHWpf92HLUDyuq6PHGf/eclvrxT
 9JtOEtDiRqG0+BJPcv+wl/NNsd3Qc/IUVuaMQB1a1Vj9vQ+5cZLu2/Pd0Y2TRcpo4Q0V
 3yCeHdu3z7DGoIiZTv6/RtV7cuBFLh1rqhC6UARgAz2SB1IksMpDUhnV6L+5grT6OqJh
 AQAHh2qBvb7r61kW9IGOs4oEl8/DlKzNmpsnsnbJmjZF5Wwmw80Gya7kqnSFBl1ry/3n
 bw3794Q0h3N4esvp7yDjTrH6p80v009IjujTE9S3aRn2xcsRnDzIoYjNQhs+rQdqkgU4
 grDg==
X-Gm-Message-State: AOJu0YwWh/NEM43kAIURAPn19qFci8AuEjW2d4H12aDQ19r8RTt0ut9d
 kLFEB82NNur111orsCbcXdRb5MV03TXDDWqebSEBgp8lNvzf4obvw5Ltd4eZO87+TW/4zX+HZQM
 N0E4=
X-Google-Smtp-Source: AGHT+IEl4hd5nYeWoOW0rQZJxOwWUxhImiEnWmaqZxHWAiwQtzSYK62NTyYjl9fPi1aUz9dLoN1ogA==
X-Received: by 2002:a17:902:e80e:b0:1da:1780:8b49 with SMTP id
 u14-20020a170902e80e00b001da17808b49mr8297253plg.0.1707725209681; 
 Mon, 12 Feb 2024 00:06:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUcieEq3f6eopbH00fxz5JHZU/cQ9I/IW/F5couJmVwRVbZaETUUVIYbGkVYF69XE4+iswUdQUiSvuI0dY4jGNjkuTW7RbyetOlbxeEhMacKFHJdfSKh0Ya7j9yMaUuv5JEVbQ/W6U8fiszJLqo5ZSaD/seE9Gp5Z51fnNIZp0jbuP4QO2BZ9EO7CWiZ11SGmsXV4fnTLffXRryMiqzzashscStZ2fzw3tvIjE1ctrAOQe9+wHwfpxWpSViFrZmQZlghq46zBPOgZ6XtPoz7a6HWMrBSif/+0HRASRtzP4gRcFSoXIl6VgqL6jeXc9AmbdhJzlACSTx4Mb9ojKfWXncI29hHbS/mx93CLZWuUDDYNmxnamFyPS//CuTcFCHDg==
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a17090330cd00b001d9fc53514esm5404649plc.66.2024.02.12.00.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 00:06:49 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org, jag.raman@oracle.com, peterx@redhat.com,
 stefanha@redhat.com
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v7 5/5] vfio-user: Fix config space access byte order
Date: Mon, 12 Feb 2024 00:06:17 -0800
Message-Id: <20240212080617.2559498-6-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212080617.2559498-1-mnissler@rivosinc.com>
References: <20240212080617.2559498-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x62b.google.com
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


