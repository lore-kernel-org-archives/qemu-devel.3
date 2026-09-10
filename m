Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557C7C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4luY-0004Dj-EH; Thu, 10 Sep 2026 17:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lGw-0001Ah-D3
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lGM-0007ye-VI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13Q36j0M5BaF1k6VkvQm4baQtJfJHEebKt7N8YZcxpU=;
 b=HDI169TrA7CEcD5yKi/G1zHmT5fo3oyjZ8spKbDIKvF7S+CC1i4sEIhqruusyXMRs9/Dk/
 IysC40dMUVi9SAwWbxXt9CkpuSKZGSKvcRwzWe4gSSLP0HhbGeulmt08SYS8nm9x8029nL
 aZaP6LxCNBc5JocctdRESyw7GDG6bsw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-EL2qpT6CMAOYAi_Fe-kGLQ-1; Thu, 10 Sep 2026 16:14:29 -0400
X-MC-Unique: EL2qpT6CMAOYAi_Fe-kGLQ-1
X-Mimecast-MFC-AGG-ID: EL2qpT6CMAOYAi_Fe-kGLQ_1789071268
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-485835753caso82959f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071268; x=1789676068; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=13Q36j0M5BaF1k6VkvQm4baQtJfJHEebKt7N8YZcxpU=;
 b=QJXaQibg4eGKJWZVE24NOPuSLQZLTTo2cmaQNEIHdhtWMabavgtYavAFUpVrNecH2i
 ewTIxSEZQ+gDiKro2OSOtEEsao3gfZaVNniUCWMC/XXZ5ID8kHQWYsf8ZYoQHgUXgT+i
 Obn+kkJ4RXtFNKgcmUBGDBhuY65lXHkVhMgbXWFwCUEB0iYVegTpg9NLU82fBlPCYM0z
 D4CNEFqnyqAXp483LQqWI+SdnPTD0ymKY1rzGvzyBtarevE0qEtX55CYOn5p/ewWceDq
 DKu4NqVXCOJ2iLhzoXDfyDDGvzH/aueau3pkxMblsP1cEtqk2LLMRRc/FiCacEvxIVCP
 ojtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071268; x=1789676068;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=13Q36j0M5BaF1k6VkvQm4baQtJfJHEebKt7N8YZcxpU=;
 b=AqmaH+hWkHukHZKktmYPR7Jk8YTf7zq3GogOzI861EdrwqG/IOMByJZzDLRESmckwu
 QnuoIgvaTQql15l0A+KebQWaWqEFKOjTHvGm4ARV8PF9ZGjl/nvurhn0DPxZTOLKZxa4
 AMkoQ4OiCPR5b8IlKwBKSxqMD93FnawAArlxWtI7nawn9TkOzoxCM0H0n0wON69yfdWK
 HOZdiQe/qAQ5Mfrvbos9z8BpoWPhuux/8J4fEsDxocw4oluOIWEbey4xbgPOl7VcKoDa
 pss55a8LRx3qG5QqKuysHHZczNRQ0Dm8pb6dzubquKsZ+bivvNXVpy46HfkTtNZUXA2R
 HiiA==
X-Gm-Message-State: AFuF++lgRFsw7v7bg02PJkE62qFpqadU3en2hlaHuNYILFIBPr6h3qeb
 VORPh3ktofyhtdg6C4veBvYsIax5jwyQ1xL8POVvfUMKX5jfIdBoS3R7FNBP1D7UWlZkqYvOgcP
 JML4J0ke1lDirETKTL3efT8lmyruXw2Om13miLhWumUUn+zl35Jw6HEtYtSmNoTTGegxnCU74vx
 790U3DYtjAyeHSMuPGyyoS0daK5XpjolzWrg==
X-Gm-Gg: AYBFou2jccmiCDhV+cr8eNNS2BCnfguPe96n6wXsMmvWWGzR+/pSh8ddDGE/UEpCeCs
 lcJL14qh3lrVdEL93PNewe8LnumyAtYR7LbeGDXUsRouWzDT/xtoi3aODe9E6y6XiOBoRX8x1TC
 N+hXjVRXfio7ZMweztlpmSJZaXlNCNUPnuAA4xy5riGr3gOp1OMKxn+btYKndYvN//LzEP98VGH
 YbWntEdfosjyawGunBTcCD1zMaXAeM63DeUXObdo5H3Pg+XgEi6wOKxDTSsJBGHVKU4M04ksdpa
 /BzL1UG25deE8uM5kEs0LxqW21r/Cf5MwN7REBm5VtwIuXhJKlbNrcFkrDUsQdkbGMxA5jMs9P4
 ADFlDdWfekeItBT3evvcYwH4=
X-Received: by 2002:a5d:64cf:0:b0:485:8ef9:325f with SMTP id
 ffacd0b85a97d-486eb3421d6mr677606f8f.42.1789071267853; 
 Thu, 10 Sep 2026 13:14:27 -0700 (PDT)
X-Received: by 2002:a5d:64cf:0:b0:485:8ef9:325f with SMTP id
 ffacd0b85a97d-486eb3421d6mr677571f8f.42.1789071267322; 
 Thu, 10 Sep 2026 13:14:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fc02sm744233f8f.16.2026.09.10.13.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:26 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PULL 71/90] virtio-rtc: Report smeared UTC clock type
Message-ID: <ef497a0c335844fe11effd72fb4d305865ebec96.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

The Linux virtio_rtc driver only registers an RTC class device when the
clock type is VIRTIO_RTC_CLOCK_UTC_SMEARED to avoid leap second steps on
pure UTC clocks.

Report VIRTIO_RTC_CLOCK_UTC_SMEARED in clock capabilities so the guest
can expose the device as an RTC device.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260831190612.369235-1-visitorckw@gmail.com>
---
 hw/virtio/virtio-rtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-rtc.c b/hw/virtio/virtio-rtc.c
index 32de9c1650..0dcbe94758 100644
--- a/hw/virtio/virtio-rtc.c
+++ b/hw/virtio/virtio-rtc.c
@@ -62,7 +62,8 @@ static void virtio_rtc_handle_request(VirtIODevice *vdev, VirtQueue *vq)
                 resp.head.status = VIRTIO_RTC_S_ENODEV;
             } else {
                 resp.head.status = VIRTIO_RTC_S_OK;
-                resp.type = VIRTIO_RTC_CLOCK_UTC;
+                resp.type = VIRTIO_RTC_CLOCK_UTC_SMEARED;
+                resp.leap_second_smearing = VIRTIO_RTC_SMEAR_UNSPECIFIED;
             }
             written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
                                    sizeof(resp));
-- 
MST


