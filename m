Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B7606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DekFZuCI;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D4/aJH3E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYx2-0002f4-QP; Thu, 12 Nov 2026 12:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYww-0002V4-KO
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:51:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYwu-0001t6-Fu
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5efGzLZvCbmylAJQMsNNsxRUxYM2sKIajEDpdRF4rI=;
 b=DekFZuCIjxyhV7YEBJPHNXDkGIPxjF+6FCW3zYJ/3fL8A8ZacZItHK4p+C1zH6MjNNHoL3
 RW/mTYnImb4K5jjWjQkvg3nS7RQm41i+C2Hwma9SqVzM+zTam8RArbhRzqwOFBSwEDoAjM
 izgJ1ZmMZ2+BcvaAcXsXw/0F9UZ74DI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Fx-l2oCqPjWzgupTsKj96w-1; Thu, 12 Nov 2026 12:50:57 -0500
X-MC-Unique: Fx-l2oCqPjWzgupTsKj96w-1
X-Mimecast-MFC-AGG-ID: Fx-l2oCqPjWzgupTsKj96w_1794505857
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3aed1b64104so41737a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505857; x=1795110657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v5efGzLZvCbmylAJQMsNNsxRUxYM2sKIajEDpdRF4rI=;
 b=D4/aJH3EyVvEjLlC3T6dHhwZxkhoAv1P5jadBQ0dxGyfKJqYDAbvjhBF9qDQ1wD6ry
 ApT5PHjlIyIoxZA966kFPQdN+EvkJzc/oah+UkA/BzvSDaq2wC9A/oD8hXu93lNyDVL3
 zEcEWxWO0YevmiEHUkX1xJN1HRLZ5wytn4df9P0HrYA2CBhGl4ZJ5XkRJC+0kYmikfbK
 cKqNhtBmKQwqUUJARkhcHmIek67Fs1Hi7HzZEafdj4besLO+f58kuHmcOLVZbbOHetju
 S1xGynn0y8yssxslGF02gEGC2XBhH4+BNg3utvdPc75w1u0NArEduzrnIhMBX79OGxmb
 sQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505857; x=1795110657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v5efGzLZvCbmylAJQMsNNsxRUxYM2sKIajEDpdRF4rI=;
 b=gAJF2gBWUNHbYuHGJnVW47PeMKepebbodLHToJ6IT5SIzN/N6QZMKmBb/7tMAdcs7I
 w/H28JNWfrr8ufAdMMpWcrrS9cIi2SiS680yvQ8cIQlWafV+ICtbqfEjyeOeG1SZpcco
 7m9Fu3WrZxPbgdYe5ss3MY97qaIc9N/Q66Sn2HttcQDTdo3r/G9E4b/Q7fRzzgUuppR1
 M3Spb2AI+0o9gRoGJ0GLLenjk2UM4WlXp1VvqGcZofkSltrkFkqxIz2Ntoh2Zhw+/4b+
 Qh5IfYJky6oFVe8NRi8nQfxHieeioUq10EUwn1OijSUlZprvKZblINTKZGDGmBVviP4O
 b67A==
X-Gm-Message-State: APuU4Z8OqAHlida3RtJd/s4j29IqyK2OmzbUqdufEyitXZ1BhV+IVVCc
 k5mCHBrAB+DgwFHOGuTQmU9jHD9Iz7O8yPIHjMPkngQNcNZ2LbZ4llx7jz907c1Q7b64VzUY+p3
 nlLeY1gofZy50ziitvCqQW/+odrDxJ8SieImtkRn7dhh3+LvVfTvLaQDR5hLD4dIloiPgkvjwzS
 61algShxiIsP6OAOhxsnZp6VoVBQhd1U+wjyTVUhF6Hg==
X-Gm-Gg: AYBFou0n7aFkRWaHX936Aw52+6POFm4+xrV/uYAB0wlvEk/doJAOOZAj9+3nuWIQxGe
 x9vPkelNMCkYaz4YAX8yOtLn3ifbU8kjp5aUDl4tEtKoN6TC04IsMV64SgNqmdoL4F2LgrVeFLR
 ZlIPHFS6jtmE30VqIDsaUZrIGcLyACv3cTJtVrCCY0YPAS9wSA/+PvvDFeWDQZVygefyV5WBEzC
 njT/IWZu7xvjf/8Od9HYyjXflxys7qOL728Esz0+SuS4dVFsbIVkINjF9EXR1yxLn1G314WKhNW
 p5nPYV1Rt6AEo5KFDtMNzxV4UsLigzB3gbRamnr8eJiMXio7tj5hqznK8R05psNGYpig/1fGPgK
 6WxxTtUw1JQmxv6NrrFthMWBUdkABgbUgNbN8xiYGngAgKQ==
X-Received: by 2002:a17:90b:17c8:b0:3ac:9f24:44be with SMTP id
 98e67ed59e1d1-3b182edc482mr6561896a91.29.1794505856720; 
 Thu, 12 Nov 2026 09:50:56 -0800 (PST)
X-Received: by 2002:a17:90b:17c8:b0:3ac:9f24:44be with SMTP id
 98e67ed59e1d1-3b182edc482mr6561868a91.29.1794505856203; 
 Thu, 12 Nov 2026 09:50:56 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0f6e0sm5644294a91.9.2026.11.12.09.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:50:55 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 8/9] hw/usb/dev-mtp: Fix assert failures in
 usb_mtp_write_metadata()
Date: Thu, 12 Nov 2026 18:49:05 +0100
Message-ID: <20261112174907.158825-9-tcalifano@redhat.com>
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

usb_mtp_write_metadata() can be reached with s->write_pending set, after
two successive SendObjectInfo commands, or with a NULL parent object.
Those states hit the existing assertions and abort QEMU.

Return RES_INVALID_OBJECTINFO before the assertions.

Cc: qemu-stable@nongnu.org
Fixes: 53735bef108c ("usb-mtp: Advertise SendObjectInfo for write support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index f6f9bf52ed..d01b38aeac 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1723,7 +1723,7 @@ static void usb_mtp_write_metadata(MTPState *s)
     uint32_t next_handle = s->next_handle;
     size_t filename_chars;
 
-    if (d->length <= offsetof(ObjectInfo, filename)) {
+    if (d->length <= offsetof(ObjectInfo, filename) || s->write_pending || !p) {
         usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                              0, 0, 0, 0);
         return;
@@ -1738,9 +1738,6 @@ static void usb_mtp_write_metadata(MTPState *s)
      */
     filename_chars /= 2;
 
-    assert(!s->write_pending);
-    assert(p != NULL);
-
     filename = utf16_to_str(MIN(dataset->length, filename_chars),
                             dataset->filename);
 
-- 
2.56.0


