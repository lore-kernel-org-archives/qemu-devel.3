Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE0C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Pu-0007jL-GP; Sun, 26 Jul 2026 17:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Po-0007b0-MT
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pn-0004Ig-7z
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eT3gvf59N/ykPu6ZXrIIzDbtUPAepFBOyAyWS1ygdeo=;
 b=O1OklaQpyw5xbo0Kvqocc2JtTlg7uY9GrdVyS9nSVJIGHZouyq5Q+cNRUKJ1fnAYNusboC
 OU7o7ralUXLqykkXAcwelvoBHz3XEYXMSQLujljrYfBHuMB5D2d0l7kv1t6xUpmYKt4p9w
 rTzgwylmRK+9foAlBqbKHA02ee3YMEM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-O3aMmS2TPG2q716JyVwFKA-1; Sun, 26 Jul 2026 17:29:40 -0400
X-MC-Unique: O3aMmS2TPG2q716JyVwFKA-1
X-Mimecast-MFC-AGG-ID: O3aMmS2TPG2q716JyVwFKA_1785101380
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49554715277so19575895e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101379; x=1785706179; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eT3gvf59N/ykPu6ZXrIIzDbtUPAepFBOyAyWS1ygdeo=;
 b=ByehrnY94bdLOZcs0NGHv2H+ijhKdP0CDawWsZMf4rVAKNlsRP3+rGxHoh+OVqSd9e
 eBDAPwiggeCecIebZzKvppB3O4uOIZswHtApELubvMg3/QwMPZJk2CDU7RYIkPtFVsOk
 H+ttNIHVivHGL9DdvRF1D74S7OrlV5mctfGxgkKRKHbJGD8Er7F+ERvfYCpJ7MkgtutB
 GkrzJwxlO/V9h4AUR+h9kzu7Bd8mkvnTcgVM06TG18GN+3JSa0r8lT+sYxGDp6pMK5J6
 rWqz2z8O6Abd2kXvX5Iuzu57Xl5ZS+0qxNCNff9p8sTxveXGzpexf8zhALQhh2rrk72A
 HPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101379; x=1785706179;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eT3gvf59N/ykPu6ZXrIIzDbtUPAepFBOyAyWS1ygdeo=;
 b=U1J1VLy94x9YSZNiMuTXs646qpqUWfm8lSCgFA1SRg29BMq88YSTb8a8Ze8u6NvAvq
 8kyYHs3UKkggFBUsuZ85Ujy+euabnlGfpApJcEsZQN+9RsXe3CyWqWzhMyBM2+bD98P1
 tl4aT7/e0hEEfx00qUudWri4Ck7F2aFdmyeBeRqCQQ4ukrAAxY0VTXONlf/BrnkOsYJm
 DKGvX3eP9GQ/YREZna+/UlW0NV1RDdrrYrVzAKTdeG/sTE2kYYIjfMMcGXGcBc35kfHW
 70YyFWvzc5S/JsU8S91Y5g0OBJdnG7XeyxonPtaESJlzjhgGG8MGLro8UEcB98NoFhoB
 eHwg==
X-Gm-Message-State: AOJu0YxLqVvn+IveTJxDpRUuvMUmQSq/z7ikN4quRKVvkg0w+aR8CYjg
 I5n1eBcxPqeQDaY+AQYyEZx4gIMdh1GQ3s9H/E1IcT6oywC2h/eBI1yjVhh1VEoSNlE8+uYOt6K
 w5uqukV1UPQELEg5jbWa16I34/M8TgPoZY8F64U35U+PtNllbF6Gl0x75Yuw1z49AAl8+qb0GSo
 wcb+jdEFFRTWaF1RQ6gb6UI2ikboMGl0addA==
X-Gm-Gg: AR+sD13Rcz2wwmEwWum6tyjBlbcn0dCsQvBOuepxCbMi9hzVtfHBjv4gvvOPr+Hw0QW
 s6VmmFqgZ2K5XrC88A4pzSymVOUQVIfIJcnZArd3cUFP3ZT2VOyMO0VOxSXZYg3JiLLDxCT+xJ7
 dUjD3Ap0QwNA0STI+SQvkU0csPNxFzjDNzd/CDGK3/bRtYEkqu1EEXjF+TFXk/WTVV9e80wVPwD
 7nAu3MHvdnyk7MK6yRbgID40EP8nc0HlwT+Zkuj/0xNFdmWlO7lX7Tt2+Z6Q0A5GYcTZZdXHyr5
 7mwCNbzm21LYHnC5bAbR7RZAciaKa1FCmfsZF4aQRhHxVTOlP/xgV5l4zyRhgu6QjR0w5xXYv1K
 EkvFkmRSw5DmvxH+hR0tpSg==
X-Received: by 2002:a05:600c:5253:b0:495:636b:e519 with SMTP id
 5b1f17b1804b1-496b56ff142mr84284785e9.21.1785101379487; 
 Sun, 26 Jul 2026 14:29:39 -0700 (PDT)
X-Received: by 2002:a05:600c:5253:b0:495:636b:e519 with SMTP id
 5b1f17b1804b1-496b56ff142mr84284645e9.21.1785101378949; 
 Sun, 26 Jul 2026 14:29:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4eecb4fsm167124435e9.7.2026.07.26.14.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:37 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 15/30] libvhost-user: validate last_batch_head in
 vu_check_queue_inflights
Message-ID: <ba1d2926092414761666e64ce4f9faac5df5a0f5.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

vu_check_queue_inflights uses last_batch_head from the frontend-controlled
inflight shared memory as an index into desc[] without bounds checking.
A malicious or buggy frontend can set last_batch_head >= desc_num,
causing an out-of-bounds write.

Validate last_batch_head before using it.
Note: the value is not guest-accessible so not a security vulnerability.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3974
Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <8133770c75c9907578dd551f4d468140a0a75cd2.1784892981.git.mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 42a5e2f1f5..c1c13dbc90 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1379,6 +1379,12 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
     vq->counter = 0;
 
     if (unlikely(vq->inflight->used_idx != vq->used_idx)) {
+        if (vq->inflight->last_batch_head >= vq->inflight->desc_num) {
+            vu_panic(dev, "vu_check_queue_inflights: last_batch_head %u "
+                     "out of range (desc_num %u)",
+                     vq->inflight->last_batch_head, vq->inflight->desc_num);
+            return -1;
+        }
         vq->inflight->desc[vq->inflight->last_batch_head].inflight = 0;
 
         barrier();
-- 
MST


