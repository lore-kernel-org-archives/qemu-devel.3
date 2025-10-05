Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25906CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFJ-0002AO-QF; Sun, 05 Oct 2025 15:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEw-0000b6-GB
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEv-0006ZV-1X
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsCkkNSHYfcaJuM2hlwVcv/fUH7NdmQE3XTFVuuNZ8Y=;
 b=YMyuopKWMNnnWZTU8LFB1VLpipQGjz9grLvWU2BmkqVoEMlfU9+HJNxIW0+Cyr/Ak8/HjG
 j8pRIzrSr/R1Jj+NaVtE0d/zCs0merwUojl0rBKuzlegaQH1RsOyTSB5dgvLwko5lKN/CC
 tn0ihiW1eYllten0wQKhhbLwI8s6vco=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-0hl0lmFlNVWrbxgpBFgBcA-1; Sun, 05 Oct 2025 15:17:47 -0400
X-MC-Unique: 0hl0lmFlNVWrbxgpBFgBcA-1
X-Mimecast-MFC-AGG-ID: 0hl0lmFlNVWrbxgpBFgBcA_1759691866
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ecdc9dbc5fso2219232f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691865; x=1760296665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsCkkNSHYfcaJuM2hlwVcv/fUH7NdmQE3XTFVuuNZ8Y=;
 b=aSSlTkE8YfbTXZ81UbdOFbHdlzq4h0ECEg8AtLtM8epY0F11HXNj8BLgUQ1BJbxD3W
 a+IpSFRcCO1Fs6kY80WkY1WBQOOsSRxR2cLZUyuOj0YclBnzvytsgEVg5JLBgvzikbBu
 y6/fUSuPJ+JcfqTAUsobBcTZfiZnTLtK4Nt9QqlfnDpGlIQd8tB1xIxi2emAXskgsH1M
 FzB4s2VXJyiLfUFV4RK6XCoDeeIJQZvSW7zp7l7g0Hh259TMvSXbKt2UV+ifh77uIx+L
 X6V4d2DsbIqbxAzO5n5+y5p0vC6LROkEPPlEmRrGPQ/8X8eDOhvoYygKXnNJj2GHQse2
 PhbA==
X-Gm-Message-State: AOJu0YyGeCrIr9IsyoihBYKjvoRlrgILxoTwTzjTwKJcRt35nkl8sl2u
 Dx1Su/2luvZdq/pvJ78C2FGZZ4yA7A+Wu6Q6rsAmi+moPwzsIYUJm2fepQ2mowRhrUdGtS/g4y2
 XPPh1/ClOQI29OVbG7QNLDu1Cly4fZxrHr7cuuPtsTXHIUZL+9j6tyztZH0gZaqtLl6cDrLJ7Y9
 OEUgfIoiRTQl4vfov6UdkYrqDEiNbjz/0gkg==
X-Gm-Gg: ASbGnctxS2vUV35KmpRi65vHHKeOAeVfLmlUvjspmyysmAREn/GXBffZlsaZyIiwdSN
 prabgVg2BZDJGSG8Ks41bU0l4DhIq+k6FayZ5q5J6UauZmsbzAXYgSF36p2tq+GdFtiyc4ut5I/
 BNFZuu1K9FohccxO0tI68CKx4CALbOISjx56Tqp6MsRsskVWtIoxUFVoGxzGjq7GzZYarHHxbZT
 neGchzXnt55VuKbQe6AozIhZ/teb+3qyGWaeq8gW4z9gz3CqgnAL9wf1KMsmeHiuPik03Tjdf/l
 NcQWRjPUIz6X8m0Q7cgEZvx+6wXi8Yf2NRGUOrw=
X-Received: by 2002:a05:600c:354d:b0:46e:6a6a:5cf7 with SMTP id
 5b1f17b1804b1-46e711026c4mr71744945e9.12.1759691865532; 
 Sun, 05 Oct 2025 12:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+NAHvSkvlMe7/e4a6hPO+bRAmn2Zl5nlJ0yUDRL1Nkcoz3/GKwi0PM6Ss0UYqSVkOQOK9DQ==
X-Received: by 2002:a05:600c:354d:b0:46e:6a6a:5cf7 with SMTP id
 5b1f17b1804b1-46e711026c4mr71744845e9.12.1759691865112; 
 Sun, 05 Oct 2025 12:17:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a022d8sm212110245e9.12.2025.10.05.12.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:44 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 45/75] virtio: support irqfd in virtio_notify_config()
Message-ID: <3b11003fa67b3f055637ff52e1fe8327f7590ee1.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio_error() calls virtio_notify_config() to inject a VIRTIO
Configuration Change Notification. This doesn't work from IOThreads
because the BQL is not held and the interrupt code path requires the
BQL.

Follow the same approach as virtio_notify() and use ->config_notifier
(an irqfd) when called from the IOThread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250922220149.498967-4-stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6ce5823898..de89e8104a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2706,7 +2706,12 @@ void virtio_notify_config(VirtIODevice *vdev)
 
     virtio_set_isr(vdev, 0x3);
     vdev->generation++;
-    virtio_notify_vector(vdev, vdev->config_vector);
+
+    if (qemu_in_iothread()) {
+        defer_call(virtio_notify_irqfd_deferred_fn, &vdev->config_notifier);
+    } else {
+        virtio_notify_vector(vdev, vdev->config_vector);
+    }
 }
 
 static bool virtio_device_endian_needed(void *opaque)
-- 
MST


