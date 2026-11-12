Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I0VxW3fD;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=W2yTh89c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYwn-000211-0a; Thu, 12 Nov 2026 12:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYwX-0001kJ-GF
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYwS-0001qz-Uf
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gofs97VqTPJGXzem4UEe5yqiASS9b0iFYnxY/vnWy/w=;
 b=I0VxW3fD41EL+Crai2RldBT84oCEEoJKiq+GAAXR13gQXmG5auzgZm5CfwRrN4LrpIGg1N
 PZ8clK5U80tjq2mwmGIF1FnxvQhD+prAQ3UbXQZQCBVcybgrjP0f/yuyK4wpiYPQJcz+Su
 LTLf9+EmMheZvmwdqgcghVytqgIqXoc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-yfFKuDm8N6-3_s_VjJpuAQ-1; Thu, 12 Nov 2026 12:50:28 -0500
X-MC-Unique: yfFKuDm8N6-3_s_VjJpuAQ-1
X-Mimecast-MFC-AGG-ID: yfFKuDm8N6-3_s_VjJpuAQ_1794505828
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-89f84753b43so43885b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505828; x=1795110628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gofs97VqTPJGXzem4UEe5yqiASS9b0iFYnxY/vnWy/w=;
 b=W2yTh89clrU412jYN7PieX5RFWjJupAKIo9hJo5LoAGq/sKeUjiub3/Q+OIkIcyKCy
 nylaB6ureaqOO8V5tdJEaZ7+Sl0K7wetH1Sr5cfQAW9XkDb/GOvi7ygFojPbf9oRURby
 k6lyiHy6GSy/q9OjYjRk3j2GuheZ4FKf3NyJI5pAp7RTaHwxTxqGsZ1rbKyvocOwPUNW
 30qQOuI008+3ChwJM5oU46ZbyQF+Bvtu8g/5PZbK1fSdgEakxpiKuYinQ83k1WDZhSGF
 xFfOypHMwiTOoeEnWN8McUi1nLjAGDuRJPlRJ0OfDXarGNhjRaiOYI1RfRxYQLKtMXu7
 DozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505828; x=1795110628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gofs97VqTPJGXzem4UEe5yqiASS9b0iFYnxY/vnWy/w=;
 b=erknC0NnBFZUPzsJDlw87G15m9Kn7fbW7mp6hvnil5tMf785sQnOj/umSDJVgYOM/F
 azyqHa2jILkcRnhBZ1CWvQMe2DP/R0PI23kwlwidBJMe6NFzMsP068F513OPo5EKBRcV
 eBBYUzL5trgTIpPeuvMkmOwnbkJIA2ufU9f8VcizgIsKDJin6q+O5tomDoKCQAIyH2kH
 40i8jGl9lUdkWrFroI2mWc6xLGC6zE/E9PpTKXkNK9V3NYCHWsA9pSAZWN3GbsODzPxZ
 l6HSu+fg+xY6NW6TKaQrwlltuHUPDtHxi3ubYj114K6dk5Sv5wKaofAjKHOm+/loI+qx
 8J2A==
X-Gm-Message-State: APuU4Z9OGpp9LlUvldmc9Ss0IPuFOjSP3rLVHOB6Paawk/+6/YUrKKGk
 oSL/JrOlYanGchE+xuWUcKZFRw8yLCaycGwwWYaVP8/iKo6LxmAb6RgUhGQf7REEpLFlU81pQvT
 dbGgq03EKg1hym0c2XGSdCcbPcApVE0HvJRyyOPuGo1P4RpusTT5NEX9JoWKvhNiqeCaARsqeV5
 ftw9vNoVu3LGeYi3NhyTR8xayYglnTmj+fnyKs9Yw4+g==
X-Gm-Gg: AYBFou17X4y/ijxs9h9XOhDq6+e+IUteOLA6LN+fgQp03kfIh3r/KsyT8gYex3Z589+
 7PYfW/dMp1iKPzkWjXlH1KqjWnghJ7N3Y/ch5CYVBYuRWS3erN6RqYPK0Jcg5eCR2+LgLyGdeeb
 tddD+1li4Iwy44+CycGmhrOE/wWS+cJZwMlOyW6Pq42tyweJYYn/nOyhf+Qmyy0ydMsMLr8pL2T
 ZY5nhDXcv7ZN0DbvlZDYTa8EFr9G60zrxONkvkVJBHFDx+4GugQKL2naOnicUNmoS2uSFEb9NE9
 Ng72n71sqmNm6FuXWOxhGbNFXKw4l8lI3OnX3KAJ4OtMnVcWqOtV088n7X4ouMwCEHNx7la1faU
 0iVFp0JkzD2EakDSbgOycgGGjBUoofv9m1p38ecnqpsep3g==
X-Received: by 2002:a05:6a21:7008:b0:3e1:6b00:fd1e with SMTP id
 adf61e73a8af0-3f2ff8c79a4mr6258335637.52.1794505827731; 
 Thu, 12 Nov 2026 09:50:27 -0800 (PST)
X-Received: by 2002:a05:6a21:7008:b0:3e1:6b00:fd1e with SMTP id
 adf61e73a8af0-3f2ff8c79a4mr6258310637.52.1794505827137; 
 Thu, 12 Nov 2026 09:50:27 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc18b4352sm88166a12.24.2026.11.12.09.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:50:26 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 6/9] hw/usb/dev-mtp: Detect end of SendObject data correctly
Date: Thu, 12 Nov 2026 18:49:03 +0100
Message-ID: <20261112174907.158825-7-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112174907.158825-1-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The end of a SendObject data phase was detected by a short packet,
assuming a 64-byte max packet size. That only holds for full speed:
on high and super speed endpoints, transfers ending on a 64-byte
boundary were misdetected.

Use the endpoint's max_packet_size. Also end the transfer as soon as
the size declared in ObjectInfo has been received, and fail it with
RES_INCOMPLETE_TRANSFER if a short packet arrives before that.

Cc: qemu-stable@nongnu.org
Fixes: 3e096650a64d ("dev-mtp: Add support for > 4GB file transfers")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6fd92e5a68..82de3ee401 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1845,7 +1845,27 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         usb_packet_copy(p, d->data + d->data_offset, dlen);
         d->offset += dlen;
         d->data_offset += dlen;
-        if ((p->iov.size % 64) || !p->iov.size) {
+        /*
+         * The transfer ends on:
+         *  - A short packet
+         *  - A Zero Length Packet
+         *  - When the declared size has been received.
+         * A size of 0xFFFFFFFF means the object is >= 4GiB and its real size
+         * is unknown, so it can be neither used to detect the end nor checked
+         * against the received length.
+         */
+        if ((p->iov.size % p->ep->max_packet_size) || !p->iov.size ||
+            (s->dataset.size != 0xFFFFFFFF && s->dataset.size == d->offset)) {
+            /* Size is known (< 4GiB) but received data doesn't match it */
+            if (s->dataset.size != 0xFFFFFFFF &&
+                s->dataset.size != d->offset) {
+                usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
+                                     0, 0, 0, 0);
+                usb_mtp_data_free(s->data_out);
+                s->data_out = NULL;
+                usb_mtp_reset_pending_write(s);
+                return;
+            }
             if (d->length == MTP_WRITE_BUF_SZ) {
                 d->write_status = WRITE_END;
             } else {
-- 
2.56.0


