Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7579CCD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9a-0007LW-Bp; Sun, 14 Jun 2026 15:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9X-0007L0-EA
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9V-0001Z3-Uk
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvHYgh1Rq601uyfNPLm9pilUaa8bf7wu2aIADqP6I+A=;
 b=gAGbyKaF0xpn85K9IJxBXoRPRqzi8p0pshCv6L7jt9XwK+rkOLHdLrxcZKrAn95rjZAtcn
 c7XS4iaw3q5azXiL0gE9eSBI/apZspTeavnqVDCAqLeTNxpHxXdLZACR/kGo8Y0dGTMU3J
 WR4AHnGv8L6jwAKqaTCplPHaMHJD+58=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-qQ20AIJoNNOCqTRkgMG7rg-1; Sun, 14 Jun 2026 15:05:46 -0400
X-MC-Unique: qQ20AIJoNNOCqTRkgMG7rg-1
X-Mimecast-MFC-AGG-ID: qQ20AIJoNNOCqTRkgMG7rg_1781463945
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4600c8cb13aso1820158f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463945; x=1782068745; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MvHYgh1Rq601uyfNPLm9pilUaa8bf7wu2aIADqP6I+A=;
 b=s3Kj9udLOC4dM84KpBGHWUN7zkHuD4Y/h9UaWLeHL1sRSyEoYgDaxJNSqQ7gClEpFm
 2HVl0eSLF0sFJoVvwHl9HU6l1Lg+jsAZYnivnUzNjBsXxdoHRiEQl/jfQc4sMxos/vMO
 qkJEQRy+qB4icvMUnRyqonYMCRPNTP4vCgF5gEpEYXl5syXQzJUacbj0NfzkMX6+GvMI
 +Sre4+PqQddx3pCg4o0QcOty+sae+HDYeoF154RbdPaYxN2YOcMNT9UJpOMANBUuc2UR
 eBC+zfwOVS3R4wuVSrkZ3QazaQOUOrcggYTnU1HQKMub3kpQeBEkiH5sLECUJAyaUbjG
 C5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463945; x=1782068745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvHYgh1Rq601uyfNPLm9pilUaa8bf7wu2aIADqP6I+A=;
 b=IMCUKeq1Oe6jT2KAt/mvpxVq86uaG7y3k7bHH/Fsy28B0VGoXh223QIh0v2nbIIKLJ
 R9NFS6aaI0BH1aKRl+KFLry6csuluzIYIlPdbpjOHlBXlvqYDA1nSItIPjB0iN+yJ4lY
 3CHbioHujOrMyMMzOvHD8VOzW6DoY7yXENFnPrWNvqyYW0Mmcmh5f9SdsobMRgenMEQM
 XOEEIUz8u6h9vuLGyiy+Xm7cUM274LVedtotyjmIzSnV/FzXfKCfO5OUarsW6chtOMql
 1CHDH0b0Oc/L0wOtOl516pzCWlyXmuYINOmaOTjLq/etcQ1ohe1N0oFccjo4AKstExZP
 OwHw==
X-Gm-Message-State: AOJu0YzE4twpxwd2BzsfPK3zKjNK0Put6B4Ja0kq7AXZ4n3g4A6/AaF8
 xP2jBVZhpWhHLyDsZTA28T29XtbnYC0hBe8yI9UUqFIf8oqAjV1PA5LLfTRfi6iy2lhNhnJx5wq
 3MNDUpZHYAIlOeByJVdshQe1Ax7VG8bK89ZhgZL92tPT4PN31BtP2MWYhUUT0nE9gJVeIxd+IJg
 Nfg3JW2aJAaGZg5MvQj3O/u7FxeGZIcWsXKQ==
X-Gm-Gg: Acq92OH6VLVluApZVROpFNyZTVBfom3ntzemb0OtagUaMaC6AbeqYm6dSRL2hQoUuqd
 x3GWgvapjQEh8Tv5mlctbxcX3pKpAueL2EVn8/sGt29/qCxjx1cL7KDs4eLdwsMXFwq/fHphna3
 x/HpYcELu8V4qYT3wTMWsu1AoCGGtmyYl+VU7jRp7LNWeReHe96Lycn550A2tWYdBxqC3DN5Xbs
 u47pS5AhoExRCtUsEuGO/xVrqTtE+5Pib4sm3FhVtivFslhe6YCnOGU/Uf3XlIOmi6P1Nq+rRM1
 vC8pZCQ1w3FmR2gZcGBYX0NxbnWG8pw5lrXogJZg5dz+Xh1n2xH4C2VjPt/DmmH89J2HpY7Yxl3
 5P9C2IvXGeBsJiCUT6iEjQb0Q4XNYCcWwflvH7wPUWps=
X-Received: by 2002:a05:6000:4a1c:b0:461:9459:874c with SMTP id
 ffacd0b85a97d-46194598a0amr6248570f8f.19.1781463945206; 
 Sun, 14 Jun 2026 12:05:45 -0700 (PDT)
X-Received: by 2002:a05:6000:4a1c:b0:461:9459:874c with SMTP id
 ffacd0b85a97d-46194598a0amr6248528f8f.19.1781463944554; 
 Sun, 14 Jun 2026 12:05:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm30384132f8f.28.2026.06.14.12.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:05:44 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:05:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yunhe Wang <yunhewwww@163.com>,
 qemu-stable@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 001/106] amd_iommu: restrict command buffer head/tail ranges
 to ring size
Message-ID: <3097d54016ea9f8f0436f0b20e1b4d78a02b6aeb.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

The AMD IOMMU command buffer is a ring buffer of cmdbuf_len (a power
of two) entries.  Each entry is 16 bytes and the head pointer cycles
through the set:

  [0, 16, 32, ..., (cmdbuf_len - 1) * AMDVI_COMMAND_SIZE]

The tail pointer is written by the guest through the COMMAND_TAIL MMIO
register (offset 0x2008); the while loop in amdvi_cmdbuf_run() only
terminates when head == tail.  If tail is set to a value higher than
cmdbuf_len * 16, head will cycle through all the elements of the ring
buffer indefinitely, without ever matching tail.  Fix this by further
masking tail (and head, for consistency) against the size of the
ring buffer.

Reported-by: Yunhe Wang <yunhewwww@163.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260511113923.2478812-1-pbonzini@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2..197e452e3c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1578,7 +1578,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
 static inline void amdvi_handle_cmdhead_write(AMDVIState *s)
 {
     s->cmdbuf_head = amdvi_readq(s, AMDVI_MMIO_COMMAND_HEAD)
-                     & AMDVI_MMIO_CMDBUF_HEAD_MASK;
+                     & AMDVI_MMIO_CMDBUF_HEAD_MASK
+                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
     amdvi_cmdbuf_run(s);
 }
 
@@ -1594,7 +1595,8 @@ static inline void amdvi_handle_cmdbase_write(AMDVIState *s)
 static inline void amdvi_handle_cmdtail_write(AMDVIState *s)
 {
     s->cmdbuf_tail = amdvi_readq(s, AMDVI_MMIO_COMMAND_TAIL)
-                     & AMDVI_MMIO_CMDBUF_TAIL_MASK;
+                     & AMDVI_MMIO_CMDBUF_TAIL_MASK
+                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
     amdvi_cmdbuf_run(s);
 }
 
-- 
MST


