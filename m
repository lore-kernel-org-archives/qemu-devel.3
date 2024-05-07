Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA00C25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LuO-0006eP-3L; Tue, 07 May 2024 10:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LuJ-0006OF-CR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:35:03 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LuG-0002IO-Uh
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:35:03 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2b36232fa48so2263152a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715092499; x=1715697299;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQRoBwM3VtnsocziBWRdu7rYUqFpcQLBHetkRLLTiYU=;
 b=II3XaxZLLd0GeVQef6lrRQX0/vh02HdWdeVB9JeUkExebtaRXIZXLXrNsVVQC4vgHv
 eoi19Q9pr8DVEdGmjEv9dCYyT9t98iOc5aKSPrtWSijxbseB0p2cXxB32NjZjmLefjS5
 PfYcyf285LGpiFbmaWsXWOz94GO67VNeBxLcC3/1dm9vTlsVvedT/tRvDCJu5yszokHP
 Y6s3F0Z1SqdoVhXHWpKzZZR1RK5yFo0bKBDZdLU03Y8dGCxort2Q/itSJqk2T8o2iUK6
 F/fbbykVY1frofeDVJUspvZqDRoDA/nN06jX8iIgXUP6mPWsAB+HU9glXrAWJZ7sfVeb
 Q+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092499; x=1715697299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQRoBwM3VtnsocziBWRdu7rYUqFpcQLBHetkRLLTiYU=;
 b=lRUOaunbnUWR+lodPvTBZXTGkI0eUnpkFF3g+8JN/YD7fgW/YUWduEHiHANZ3I4A1j
 ykLyfQ8ICA2C1D6MyOclE9SCWiMuvQ5HhuYvtefOQpU5dM7KNeZHBlmV5aXLudWUdzMz
 lH7oSzP1Oid5imiJesVBfn0SG3Aswmb0fpThbfHMhxX84Exy1R5TdSyBMMJ0L1Nc20br
 QppDByGoV2V44i6JTIJj2BuNxbFnx+yTJU5KM5oyKhbe5oTpo8iVSfNqHHvtuHMDKhrO
 5/H9zo5h25rUPd/TZgT6q144mShmuIC/qnz0upTyMkgR/cr1vqupaTz+sp+bLztdrf2x
 YWoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWum7BCd1CumjqsGCmmPSxRpqrDwYTqRCESmt5sZIctoSLRV67ybb/dOMDKmNwlI5MDfz4deWBmmz2MlaRl5KbJhjM1k/k=
X-Gm-Message-State: AOJu0YzlleJ6gMsbRtSZKB20ZCNjEncanXTPSROwUE8OsgA1jbOP/j9k
 SVWeXuHPyaBGhW1PBVuH2iiSjzlkPY1tyizxXEkaA+JxlIPFyHtg9GBZAU7Q5Xg=
X-Google-Smtp-Source: AGHT+IGH8Ldm8JgABb49ziH49B9kVw+z8BaUE98L2DFVZPQ/BWYi4bM2AfUQr17SuC7M+YZBmoRnIQ==
X-Received: by 2002:a17:90a:d44f:b0:2b4:32ae:9d7a with SMTP id
 cz15-20020a17090ad44f00b002b432ae9d7amr9569144pjb.19.1715092495364; 
 Tue, 07 May 2024 07:34:55 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 pq10-20020a17090b3d8a00b002af8056917csm11827206pjb.29.2024.05.07.07.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:34:54 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: jag.raman@oracle.com, peterx@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v10 7/7] vfio-user: Fix config space access byte order
Date: Tue,  7 May 2024 07:34:31 -0700
Message-ID: <20240507143431.464382-8-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507143431.464382-1-mnissler@rivosinc.com>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=mnissler@rivosinc.com; helo=mail-pj1-x102f.google.com
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


