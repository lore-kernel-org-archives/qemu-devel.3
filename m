Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A59CC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqpY-0002fm-JD; Fri, 01 Aug 2025 10:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhQ-0005Um-RZ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhO-0002kt-7a
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vse0o5M8ShmOPdFHjK0g7J6ivikmqeKjL1uql6xTckA=;
 b=Df8a6FN0+6qYE3Ee6XPDjIfbGrWDWMiyfF6dKVt1pmVB1tQXPeSEc62EnouEhk8t4GFDBQ
 a9/PbHr+wGyqH23pO05AzEt1jUSMalGLxDFds7qL/dIuCHMYEEVgph3+1Tlh5Lm7MVZ7kz
 /TRqxPUtOZHxhFzZSHq8FjXXzto3EMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-WiVmFxOvO0GzlibPAMmrgQ-1; Fri, 01 Aug 2025 10:25:28 -0400
X-MC-Unique: WiVmFxOvO0GzlibPAMmrgQ-1
X-Mimecast-MFC-AGG-ID: WiVmFxOvO0GzlibPAMmrgQ_1754058327
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b79ad7b8a5so1475590f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058327; x=1754663127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vse0o5M8ShmOPdFHjK0g7J6ivikmqeKjL1uql6xTckA=;
 b=YXephtW+WtrB0XZyRNigOP6TNI3IBUiVgCdcn/adPj6GcyIahiFlp//YdujeeTQpC1
 rf59mTEGgtersZSN3E+kTgrmH+0oB9f5Hp0CiEjDevrBEDOuoGV+Zwgq4YsgKChZlh/s
 nMglwx4sh2+Lv2fi0CKpSeZOaT11ctIxovAtTNVH3zqh4HQ6RE9Bb+3eHAjoGXu5nKYA
 5nqMHv1HXoQWb6npAq9h5ZnYwM0pEXbDx26RY41qSThDo3o3z+1ZpI4SLxmogUt20Q0p
 oJloWf1UBYjWQeW4GDxaa9CrNlFGUlmOraPdE//fqC1a/xsCrVANFu6KvC+Ees2VvYfD
 1BmQ==
X-Gm-Message-State: AOJu0YxumlmCY6dJhtMR8na4VPEAkDHg+ZQj/MqC5tEi14/66mNlo3Sx
 svyzfSqR4ky+8UA6zFzZqzZsXpQl8xo6HyQEQWkkLzcQd9r3+gnG3WC3TO+vB07Vexm//Xmt+U1
 YHeisNGoP5Vvgf7YMvOyXzjKA/IZubXOZtB7l9NUhGk/4HyV3IMZPkMvfIyjyjKdC4i3seJA7vM
 fPFcw7XpKL5+Gb2R5bTSUlS8zZ842waTjGiw==
X-Gm-Gg: ASbGnctGjNpVitjsq97FRiDhDs9jPraHNGhHX88Ypw+bXBZQd9oxxQW+aUtIjw6vvCI
 C65Q5RzVnovgJEgiSEeaFHXI6jLLr3bEok/J5t5T+5hV7j1hN/YLeTxN11gWkp9zVjSAQ1xEnI9
 MtN0gYsajlE27c0+9zx5HaAbGT/Rg09DL61vVUZSITRmRXPk5f/Jtr2mUSrUYsxagiT959xmTR9
 ihBDfHJLGCj8rfJbB0sYIP5uZaf1OLy3LzRC9U/Wg1gbSuUY8h5OvJaMDE0tiELrsd5gIGhnBKp
 0JFyA4/AJ/LxfOKtOhGvfa/B0g7cvNcf
X-Received: by 2002:a05:6000:4014:b0:3b7:95ae:2b10 with SMTP id
 ffacd0b85a97d-3b8d3448293mr2280766f8f.23.1754058326584; 
 Fri, 01 Aug 2025 07:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+T6+HlyFxrAUqsjsKOEhSJpRCl30Ujxs9mziIdTPh0nHTmK7tgZhq8subY3rLFVfuuJYNHw==
X-Received: by 2002:a05:6000:4014:b0:3b7:95ae:2b10 with SMTP id
 ffacd0b85a97d-3b8d3448293mr2280738f8f.23.1754058326089; 
 Fri, 01 Aug 2025 07:25:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c467994sm6003722f8f.50.2025.08.01.07.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:25 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 10/17] hw/i386/amd_iommu: Support MMIO writes to the status
 register
Message-ID: <10690920b0efb3ed8b166443bae8077104bb129d.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Support the writes to the status register so that guest can reset the
EventOverflow, EventLogInt, ComWaitIntr, etc bits after servicing the
respective interrupt.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250801060507.3382-6-sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c9c32cf7b0..6925085d29 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -862,6 +862,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         amdvi_mmio_reg_write(s, size, val, addr);
         amdvi_handle_pprtail_write(s);
         break;
+    case AMDVI_MMIO_STATUS:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
     }
 }
 
-- 
MST


