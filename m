Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98B7C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA29N-0006l0-1x; Fri, 25 Sep 2026 05:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1xA29L-0006kb-AA
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1xA29J-0004vE-BB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790328199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qwH/7nJuVRR3H3fLTjoSMSoSzYdhHHvzen7XJ7sHsfo=;
 b=JMUKLTRVskrhaGURuOqXNIgOA/EYr52vB06NyHvq7sBoxSOqJoTijAPxJKPWFcWQmRCc1E
 8/DaC6GpOPV27yturQo0idUxIi5caTPkQp3jTEXEtr4RUUyHXL+UrYtBuDhCrzHz6E1CRW
 caM0CjNt91yXUdGlnJzWoxemUTJacyA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-q7aBJffvM1WbIFRmWfNC5A-1; Fri, 25 Sep 2026 05:23:17 -0400
X-MC-Unique: q7aBJffvM1WbIFRmWfNC5A-1
X-Mimecast-MFC-AGG-ID: q7aBJffvM1WbIFRmWfNC5A_1790328196
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4870487e33aso233128f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790328196; x=1790932996; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qwH/7nJuVRR3H3fLTjoSMSoSzYdhHHvzen7XJ7sHsfo=;
 b=JTDhUQiUptk/lLSrUF2rdHo2gbaT695T6X5oNmQ2tN4lJRuLxDsa9qs9GZRjF+E08C
 XZBy+An1XA+3LtsKrOxxxYcIACaxvJPkcpOv90F5dXhu+bLOALRJoRU+0wc7FFhg9fo9
 t4Cp83EdcPH1vIw8ok5Q7cXnurDZNgIkCzvLrAGjXaefWcDLKfA/lV9tifaYsJIgyxck
 jeszrvLBm6zu0xhKUZdd4N9TcfoWqrlQxETN/O7ttoiHg5T8Zm16p6fYZys+sxKFjDKs
 BrjkygtvNST4/4i2W0snJbQeyA1TonHuc26tlwr9PCzYePEhQI2s9KA42KFC/JnvnvE0
 ECtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790328196; x=1790932996;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qwH/7nJuVRR3H3fLTjoSMSoSzYdhHHvzen7XJ7sHsfo=;
 b=EFEkEPY8C/7NY6HXgg0J7y/VvqZGTnrEdHWnf7uZxbam6PzgpalpMf6o+aGVZ7VCyN
 pp47SmNDe+YJON+s8bno15O3J0qy+2R1b38fJe0R0rqaBDMhnMZuLyMeayVXVhHQUlOd
 ifCTaDHyJ5BQK3oG7dt0LA3EwmJlFqS1x2HFDAvjFJAjJgNGZgPjXALVFyRFzyrvaEhw
 jLhXTV1Cvf26dxe0b3Kog93YouX1v4Tw4/UFnHrKkCrG9Kd7g70pfXAaOm6ay4Y+7wR4
 oEyniNsYQhkXTPP9enI3RX/GaAPON4+JXRSzxmCU2ru56IEQwBBrQJIQStDrswWqqLHX
 a30Q==
X-Gm-Message-State: AFuF++nNsC7bnErXYafBHBWCpVP4iSYHGCzCbowPML15MjTALmgdLyz2
 BA32KHaW+3UEQTZ80BcaChIUofPef/AHOTmWzB9d9F7/V0hqupBitvOiFbkBJNBumjiWdHdU6FP
 VMu5pBiFBG/YntXm65d5q2a7ay1uaU2EfKVk0qAfya9BXIhmg2YfyoV6sCUM2sDNC9L4RKuN46r
 iCStpBOUJlWmBGhdkF/V7m+56X8F2yzXyfwbVV5D3Q
X-Gm-Gg: AYBFou08ze/BeEWpIC15BVle29i3Q+BDza1cQk/Pxcu+mWz6/1O/FMiIk9zouiisXhP
 c9jDOIqlVWWkbygc2xAThNyLvqyGe3gCSLplFyCN6yRsmCt5Hke1+8vZippunOn2H2gw2m1jmcX
 gW9UkNgoj5quaEMNb0HHw1GW67UsuHizvif5Jc2vKUyNgMioacg2OCam/QdCTmVH7RL00SIA+jN
 bTbUP52cr1RU2nk+s0YYYBdi4gz93rDFhGbPQNtywN7UZ/kC1xqMtwrHz+p7eb/R7O8/+uOCbf9
 nOcHAtlWhTOpR0APKHl/c6QuiI1TfMWu4CZgW4M5CLbnfIIuA5fN7ilIldeJzI/TAjImyrI=
X-Received: by 2002:adf:e198:0:b0:486:e5c6:cab with SMTP id
 ffacd0b85a97d-4887174b7ffmr8221520f8f.32.1790328196160; 
 Fri, 25 Sep 2026 02:23:16 -0700 (PDT)
X-Received: by 2002:adf:e198:0:b0:486:e5c6:cab with SMTP id
 ffacd0b85a97d-4887174b7ffmr8221498f8f.32.1790328195730; 
 Fri, 25 Sep 2026 02:23:15 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a74538asm5569877f8f.34.2026.09.25.02.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 02:23:15 -0700 (PDT)
From: Tommaso Califano <tcalifan@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tommaso Califano <tcalifan@redhat.com>
Subject: [PATCH] hw/usb: Fix USB MTP heap OOB read via dlen underflow
Date: Fri, 25 Sep 2026 11:23:14 +0200
Message-ID: <20260925092314.50106-1-tcalifan@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifan@redhat.com;
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

In QEMU’s USB MTP device, usb_mtp_write_metadata() computes
filename_chars = dlen - offsetof(ObjectInfo, filename) where
offsetof(ObjectInfo,filename) = 53. The dlen parameter is the size of the
last USB packet, not the total ObjectInfo size. If the final packet has
fewer than 53 bytes, filename_chars underflows to SIZE_MAX, causing
utf16_to_str() to read far beyond the heap buffer, leaking QEMU host
process memory.

Add a guard to return RES_INVALID_OBJECTINFO, preventing the case.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3992
Signed-off-by: Tommaso Califano <tcalifan@redhat.com>
---
 hw/usb/dev-mtp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1d8cfd32dc..704e6c533d 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1704,7 +1704,15 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
     MTPObject *o;
     MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
     uint32_t next_handle = s->next_handle;
-    size_t filename_chars = dlen - offsetof(ObjectInfo, filename);
+    size_t filename_chars;
+
+    if (dlen < offsetof(ObjectInfo, filename)) {
+         usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
+                            0, 0, 0, 0);
+         return;
+    }
+
+    filename_chars = dlen - offsetof(ObjectInfo, filename);

     /*
      * filename is utf-16. We're intentionally doing
--
2.55.0


