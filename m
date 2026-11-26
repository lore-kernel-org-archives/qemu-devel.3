Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9CF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E6LAA1gV;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lh0qwfqu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbkC-00022i-CA; Thu, 26 Nov 2026 10:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjl-00020b-Qx
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjj-000453-BV
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795708215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KM0uIHEQnyCneCqHtpvpY0epAYxNQVn1feJsHeMP4eo=;
 b=E6LAA1gV7osQ8N3CoLKNqEYBibq24IyAzl8Qd62u3+6Iy9HnyeS40Ra9+UIG2FgW6NO9zH
 OME3C0biFR6J43hj07E6px5Gev7tqYB3IIoB3IIEUDb+blStOaB9axeEg8w4l5Hp46yjuz
 0grYsr0kADVCzW2EMTFHSXbACkD6LoU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-CXRD0eBpOmm3SRGJxs9mlw-1; Thu, 26 Nov 2026 15:50:13 +0000
X-MC-Unique: CXRD0eBpOmm3SRGJxs9mlw-1
X-Mimecast-MFC-AGG-ID: CXRD0eBpOmm3SRGJxs9mlw_1795708212
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-492b5408dedso290554f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795708212; x=1796313012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KM0uIHEQnyCneCqHtpvpY0epAYxNQVn1feJsHeMP4eo=;
 b=lh0qwfqulevgsJmuLGZfLxX0HZQ424ptjHoE53szNkuwX5ngszwbQDYzM8jx9cTy4L
 EMY+l+8/Zsfro8IE4sYYxqPOKa569dhwKbG4NLVHExuwf3tMpnkitUiI6PMtA7xVmd47
 UURHF9SaCTiX3gS/8UqXbfXTzrb4LFjckedsbmTrNEYoaNSxloz/BCCNfGiNoPFbdWRw
 rSkcRF+7KmY3EJdRHjKHPHNykAZczOy3CAfjnNiXcXj+hjZHY6IMKvWngPvD7v+DXh+7
 WIjArhRymLjoFGmj7iW4euJPmypJSj1jmmhn1F634pEfNBuCK8urRib6666SkEnFNkx+
 i5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708212; x=1796313012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KM0uIHEQnyCneCqHtpvpY0epAYxNQVn1feJsHeMP4eo=;
 b=vRNt3bs3jDbIYzqKuUdVdZA1j0JIhP2ySNcZvGNNS9BhT727rBvX2zrgOqzqJDc6nG
 6+41dVNpN2ThAtN3k49WKG6ypSqYz57A9sPpRcBLJOO21ztet/73FX9yjRm8i/Iv0b7v
 TAA/rzFt/O+roPC1NVDMSxR5sctfIInS6kSYa5L8GjX2SC8UkNETgvFieAWUXY4rKZYO
 24gvsG4JXANPGat1TozFMpN3iigcHZ0K7DX4BnZCbSoBjg7odXN2+ThoJl/3MgfZzz0U
 7H1yf0Q3zwZ/nz9usCAMviXw3zZE+4cg8hwz3Ce2aBYoap4CK8fpvSL0awS6CEKLCGxW
 E3IA==
X-Gm-Message-State: APuU4Z9tnAhdrhLQ7MwBeDjmXjp1ZVbM/3Bkk1dHaEufkveVXIIqm4ud
 1MP6R6Bds7ebqEgBfFm3AQRw1OO136Wie/LKMTZpOmekzerSs4MFSjgmUvjUJ4rvo/YxwTwdX38
 FOy+uE6usAO63xkdGJnwkE35wa6Dmom96Mo71j1DHhgxrsXhDoRjigHaF9deq53lZr+iGQVFUK2
 jQ+ZpY6pDknPuOsfjhuPsDACQzU7KuPjGilGKoX3bKQoE7
X-Gm-Gg: AZFdTZfnvvfpSR7e1YtB7PE1ycdnP/L/QqvBt+Q5gkiuUAP4JCFgc1Ef/QowrwzVvod
 XEwrQNvcROfXeOWceDMSk+4x+DTHGhjmhUIbx4VTdxWjzqPgCz+mRHftxTHJfHFHGRUwkUV1Aoo
 uwYjyHWGlYL2ghuID1Kz6pnKuNaQQWnoIWSiO1urJat6jvUdugeKVPpJlbO66eu2ZHirH2ck45r
 ZSFn2QxtVSGGNEnfoKORd9bHXGY2m+do8T10pVl6zV/ztiDiSECf6BkBgCWPXf9tNOZuk+npw3r
 b9N6j6M5j31l3l3dIhugcZ7a3adLx5DqumCph291Ntn4suV1iESR+mbRc+l4d/y+tV0/mluvRjk
 vQH4fCTgoHbjR43WFq/f67l1T553uoYSfkVxWYNiG9sar5yc0nhMx74jf/o9JO5+/R4Y=
X-Received: by 2002:a05:600c:3555:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4bb8882907fmr443255245e9.34.1795708211679; 
 Thu, 26 Nov 2026 07:50:11 -0800 (PST)
X-Received: by 2002:a05:600c:3555:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4bb8882907fmr443254565e9.34.1795708211222; 
 Thu, 26 Nov 2026 07:50:11 -0800 (PST)
Received: from tcalifan-p1g8.redhat.corp ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm593323295e9.15.2026.11.26.07.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:50:10 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Junjie Cao <junjie.cao@linux.dev>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 3/6] hw/usb/dev-mtp: Validate container length on first
 data packet
Date: Thu, 26 Nov 2026 16:49:55 +0100
Message-ID: <20261126154959.81769-4-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126154959.81769-1-tcalifano@redhat.com>
References: <20261126154959.81769-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

usb_mtp_get_data() subtracts sizeof(mtp_container) from the number of
bytes received, without checking. A short packet or a header declaring
less than 12 bytes makes these unsigned values wrap around.

Reject the transfer if is smaller than the container header.

Cc: qemu-stable@nongnu.org
Fixes: 88d5f381ecb2 ("usb-mtp: Introduce write support for MTP objects")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 7f3799fe1d..11726bc5ec 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1783,6 +1783,14 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
             return;
     }
     if (d->first) {
+        if (cpu_to_le32(container->length) < sizeof(mtp_container)) {
+            usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
+                                 0, 0, 0, 0);
+            usb_mtp_data_free(s->data_out);
+            s->data_out = NULL;
+            usb_mtp_reset_pending_write(s);
+            return;
+        }
         /* Total length of incoming data */
         total_len = cpu_to_le32(container->length) - sizeof(mtp_container);
         /* Length of data in this packet */
-- 
2.56.1


