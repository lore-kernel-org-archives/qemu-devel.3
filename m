Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36B8C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAaD-00050i-VE; Tue, 12 Mar 2024 18:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZu-0004qc-ID
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZr-0004HJ-Pw
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1e4GUGjzQM8a1eupwANxlFHs977Y0k1VRi7DWaQORU=;
 b=W3ufxu6ro6h7bUPksp6UTp/MbwU6wLcfiKlItSW73ypYWaHTUgFA88qyirmC0k9hrVAIl2
 vtKNpxHEqzd/x2El5PwctNQURgt1ZUYn156f7F1o9b4qHPfirdVPzxSSYLM7Qn/h36ugaC
 tZkiwrBfko4xnVeuIG87T/AJNqgxtpQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-n9gIghEyPaSa5ASW0bRh7g-1; Tue, 12 Mar 2024 18:26:29 -0400
X-MC-Unique: n9gIghEyPaSa5ASW0bRh7g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a464f5e2499so14321166b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282388; x=1710887188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1e4GUGjzQM8a1eupwANxlFHs977Y0k1VRi7DWaQORU=;
 b=iepSmQFexDPG7SJ1kBMf9hXzP5uEveeMq0kAf0xHO/0CF0z0JW66d41peUuRT+MenY
 g7n3eLbyuKv+YwSgWiUS62PsC3LM/s80ZnHGjqvoVFiQC6ErpcpEu/UOHIasAiWbxPPv
 VOcILRKAwjGSAJm5yg0cv6B/C/Y8agjvc4eulMBkCqu+e0rx0PyE2oCEZVvRAIdtkQj5
 26dYHH56G4lNZDRkF9FfcpcH1dEZ+mfKmfwwWeeECyX5+xZ55magHt6TzN85DbgNZIFF
 UV2FMYbGq+zaqoCnYyZGCF/Mo5cqYCYidwRo5QxDlmMFacKn5Srmy0P+1cmYJpNDJHtc
 MjUw==
X-Gm-Message-State: AOJu0Yzj3njJ5W+HucBebgtb9/FClGgu50nAKivwPLlPGL3oIiELwXgW
 7ShWGIhBIdkoP+5rbhCgBzY26WE97UMq2f/0PZ0uol9Il9OrtM7GSJMsljky3NQ0LL6h5NrVanf
 zYLCd9MzuDENNxPb42e5NU9r2vfPFus/7SpawevGgcx4FNI1jSLe1xr5ncscrDb2dWKDV8TjDak
 q2OAXph8gDy5zIgVa07C0sQ24K3OGLgDQw
X-Received: by 2002:a17:906:f90f:b0:a44:8caf:a2e0 with SMTP id
 lc15-20020a170906f90f00b00a448cafa2e0mr1929339ejb.74.1710282387751; 
 Tue, 12 Mar 2024 15:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/MCi3z4oMxir9FcDKAtv878bHogVlAHR+NcU0p9cztfKybkEjs04BFHfUYEs8AcH1tkOTdA==
X-Received: by 2002:a17:906:f90f:b0:a44:8caf:a2e0 with SMTP id
 lc15-20020a170906f90f00b00a448cafa2e0mr1929322ejb.74.1710282387215; 
 Tue, 12 Mar 2024 15:26:27 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 ov9-20020a170906fc0900b00a46367a17f7sm1700996ejb.206.2024.03.12.15.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:26 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 18/68] libvhost-user: Don't zero out memory for memory regions
Message-ID: <c6f90b785291389168b15fe797788bcbb5a7803a.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

dev->nregions always covers only valid entries. Stop zeroing out other
array elements that are unused.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-8-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 225283f764..2e8b611385 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -888,13 +888,9 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
 
             munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
 
-            /*
-             * Shift all affected entries by 1 to close the hole at index i and
-             * zero out the last entry.
-             */
+            /* Shift all affected entries by 1 to close the hole at index. */
             memmove(dev->regions + i, dev->regions + i + 1,
                     sizeof(VuDevRegion) * (dev->nregions - i - 1));
-            memset(dev->regions + dev->nregions - 1, 0, sizeof(VuDevRegion));
             DPRINT("Successfully removed a region\n");
             dev->nregions--;
             i--;
@@ -2119,7 +2115,6 @@ vu_init(VuDev *dev,
         DPRINT("%s: failed to malloc mem regions\n", __func__);
         return false;
     }
-    memset(dev->regions, 0, VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
 
     dev->vq = malloc(max_queues * sizeof(dev->vq[0]));
     if (!dev->vq) {
-- 
MST


