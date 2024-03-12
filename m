Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F02FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAac-0005yQ-5B; Tue, 12 Mar 2024 18:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaC-00053b-En
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAa8-0004K0-JW
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYZExF4b/5G+QkupUCgRhC1lWR4Wq2MT6nsHzd4F7G4=;
 b=A3KNTBdENf018SPxZEtyU0YTxJVJRD3YliE09SmenU+axfxsZ+WDUc76a2WLMSXlxWxv4s
 vTTX6Ni8A5LH9tIGdlWg0TtTqTdUBxB7SL6BXmlxVezYp6OCeVQtorR8CC89ZNmxwl2HKj
 de+aWM00FwlZP7NTvJGrglOk8IVssFQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-vVz6AAPiPn283p0nSjTz6A-1; Tue, 12 Mar 2024 18:26:45 -0400
X-MC-Unique: vVz6AAPiPn283p0nSjTz6A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a46447b0b13so67813466b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282404; x=1710887204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYZExF4b/5G+QkupUCgRhC1lWR4Wq2MT6nsHzd4F7G4=;
 b=ZavbaCewPsR3kOTxveJhjZA1xc6bdqzFMfb2VBnVz1zuUS+n4sVEJBEeJZT0pksPUB
 eFg82bjqjQDv9xszD8wwQuFNI4bum7ezc5aQbHdU3WrzPeDdVq9rFuAWUPFD7U/UqJCn
 JlLs13aLhNchk/CJOn+PU4qmQa2aKYomV3tphlBAOnLFYHJqonWQbvhn3VIt4WtVkNLP
 ZMDuMMiLMvcaXxwkN2hZk0XSxUt41Umgr/C+wS3NfQiMXA+uv6nDQX/X+C0vQFpotyEp
 EmUtzV2ZeBk+1hCRh33uvAz21CM8m33Im/WpBDV6B4++FRGSP1L3W6YgmVW3/8zzbhGG
 VIqQ==
X-Gm-Message-State: AOJu0Yy0u/B6yZIfjNnR5YZm/qh7qu57WhI2n34s+rGom3HoDKfGqFIg
 V06EmmMSzFIALz7u3fPkc1gUazxmPI/XR2Yp3jEs/8095VUtBwwlocANEH27jFmMTAoHJx0VNJR
 HTNZkohYr7M+HY3NB9bdlO5R/NwSiKc71b78V60qi3SY9KZuYFIJOvcg+K0eRRw7D6v0Ts2fXcq
 7wvTHOETCKvjtCLOnkzzaSpLZoKv2a5p9Z
X-Received: by 2002:a17:907:a708:b0:a45:becb:6e3d with SMTP id
 vw8-20020a170907a70800b00a45becb6e3dmr8250022ejc.20.1710282403884; 
 Tue, 12 Mar 2024 15:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/xIuX935586122cMvJOFsGklUux1lP46CD3GBOEmRAQ2odG0jk0rQYyFLNq0hMrAJpYAxVQ==
X-Received: by 2002:a17:907:a708:b0:a45:becb:6e3d with SMTP id
 vw8-20020a170907a70800b00a45becb6e3dmr8250004ejc.20.1710282403331; 
 Tue, 12 Mar 2024 15:26:43 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 uz17-20020a170907119100b00a45cac9ae6bsm4213324ejb.162.2024.03.12.15.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:42 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 23/68] libvhost-user: Factor out vq usability check
Message-ID: <2a29022768f1777d71e26b784a264323d1914dd6.1710282274.git.mst@redhat.com>
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

Let's factor it out to prepare for further changes.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-13-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 55aef5fcc6..ed0a978d4f 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -283,6 +283,12 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static bool
+vu_is_vq_usable(VuDev *dev, VuVirtq *vq)
+{
+    return likely(!dev->broken) && likely(vq->vring.avail);
+}
+
 static size_t
 get_fd_hugepagesize(int fd)
 {
@@ -2380,8 +2386,7 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
     idx = vq->last_avail_idx;
 
     total_bufs = in_total = out_total = 0;
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         goto done;
     }
 
@@ -2496,8 +2501,7 @@ vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes,
 bool
 vu_queue_empty(VuDev *dev, VuVirtq *vq)
 {
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return true;
     }
 
@@ -2536,8 +2540,7 @@ vring_notify(VuDev *dev, VuVirtq *vq)
 
 static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
 {
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return;
     }
 
@@ -2862,8 +2865,7 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
     unsigned int head;
     VuVirtqElement *elem;
 
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return NULL;
     }
 
@@ -3020,8 +3022,7 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
 {
     struct vring_used_elem uelem;
 
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return;
     }
 
@@ -3050,8 +3051,7 @@ vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned int count)
 {
     uint16_t old, new;
 
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
+    if (!vu_is_vq_usable(dev, vq)) {
         return;
     }
 
-- 
MST


