Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BF0FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWew-0004Fm-C6; Fri, 06 Mar 2026 10:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeu-0004Cv-GJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWes-0002hQ-Ju
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso101964225e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809205; x=1773414005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wo0rXQ6D0LSglAMllL+ii/BMzV/Kw9eNTOAdJyQWzn0=;
 b=jA+v2S8CWuv/efphyyu/h+0qTQpFsXi1nfWbNi2J0tuREtZPZRZq/Tcx/qpSEII3k0
 gcR+Ruvfn9TdMb7tJjh5Ye9PDgoUWyYFN4wWUx9Ng/0AHdAJeZ8xIQCaDvYDIx22nDxj
 RZGkVCA4LhHcTFaYa1ZlwvkjuIVgHIDGYnjADsv//L1TjUHQU8K9ZnSEhDMsnf/pCj06
 lWKxQCHnqqH7pChpESwgUZ7U9Oq9LLuGAc4FaDkp5H/7vzop0KJXEZ1+cCmatRlO73bA
 csc9myZ9Kg/j3QrRRnierb8P+38bYgMH3Es1+cfPn1UFctAzmWjq05BcaGotDpRYnUSZ
 o0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809205; x=1773414005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wo0rXQ6D0LSglAMllL+ii/BMzV/Kw9eNTOAdJyQWzn0=;
 b=UxaGdIxC/tM59DVjDXr6fd8+GrmESifevdvVv7qlpiKmmfH+nIXGhxHvIYQCZOkNWV
 XYcYpV/A+oy52VaKPhSQuPoGoY0N+otY5QpEQCLD4dGS/SKStR+jAjq4Zqqe6IU4fhaU
 0hIPbZSD93FTV10EEiRMBnTLGn/Y+FOs1q7Dotg2LMq9feROnGTGeuYh+vjNJYXDyRe3
 pP3gp3niWHyeZ7LjjL6v8/YrGOWA00+CC1RamJKsH4NnmKyclUguMCfHmGRnGw6/Lnab
 XGh/ITAZdCshrJOBAxaLuWorkPafL0VBjxHN6TURHrbV8+dU1fVsGuLvgtWCfLCLvMr0
 HsKA==
X-Gm-Message-State: AOJu0YyJTqMrpZ2MIt7D/6f+DGLyDhFKjql0DJwEB9m/5+LBPE6paGdA
 R42LfJ696kERdxOwFmOAGZYkI/nCGngt8Ikp2owZHZXFeaJywrbBg0dogffLhvoM7mx0ryeDcYa
 2kQex
X-Gm-Gg: ATEYQzwMXHn/dMRl5OzgPamh/zOOe3dKsJiSOcfoMFx7ewfiwUpyeIuW4Ftyrz8asoI
 mC9sVndrBlxnGD2KYtpOXAVmb6t0IZPPUvB+2JsRQyAm5t8iHJ3bLP/0UKPiTYUHi2TtEZtbT+E
 b00OdqrLmgWkYRIFBB+3CHYGMCwoFq6koNJw6Lkc4OWh7O95nycXljRJl56tj22Grb+zC+uP5rU
 r+bEowHIFB37WpQKzTTGWdaW/pXF5AktZPD3vW4/EcYCelIFr+2zA4iBFBQImaoUpezbG4w9CTz
 JZiDp93jvCh6Z3QQg4n7pHKMlfDFOUVzbLO2chfquVGoELhumOWm5qJJ4Vy2eQ74QaKF2mdYmjJ
 2gED1QwXTc/9scEHjyv9NLjwMvBZXZ03nvzOzl3NRzOsMTy0F6vVzuQo1Q7tjOu52pFQ9WGHsTF
 c7ZFZXRpfDDuG0WOjlWqmo92xO5LMkVuuqs9KRlRzU7tQyZ0vJ0vDlgt3uvukSFFH0HlADkeBKM
 C7TWGjQu9sQZV1TWjSfePZI0WpdgjltV5kYr+VlmA==
X-Received: by 2002:a05:600c:a0d:b0:485:1878:7b8c with SMTP id
 5b1f17b1804b1-4852695b6fcmr38290185e9.18.1772809204932; 
 Fri, 06 Mar 2026 07:00:04 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/49] chardev: Fix QIOChannel refcount
Date: Fri,  6 Mar 2026 14:59:15 +0000
Message-ID: <20260306145939.2162189-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

The IOWatchPoll holds a reference to the iochannel while the "child"
source (iwp->src) is removed from the context and freed. Freeing the
source leads to the iochannel being also freed at
qio_channel_fd_source_finalize().

Later, io_watch_poll_prepare() tries to create another source with the
same iochannel and hits an use after free:

==8241==ERROR: AddressSanitizer: heap-use-after-free on address 0x514000000040
READ of size 8 at 0x514000000040 thread T2
    #0 0x561c2d272fcd in object_get_class  ../qom/object.c:1043:17
    #1 0x561c2d338f84 in QIO_CHANNEL_GET_CLASS  include/io/channel.h:29:1
    #2 0x561c2d33b26f in qio_channel_create_watch  ../io/channel.c:388:30
    #3 0x561c2d2f0993 in io_watch_poll_prepare  ../chardev/char-io.c:65:20
    ...

0x514000000040 is located 0 bytes inside of 392-byte region [0x514000000040,0x5140000001c8)
freed by thread T2 here:
    #0 0x561c2d2319a5 in free
    #1 0x7fb2c0926638 in g_free
    #2 0x561c2d276507 in object_finalize  ../qom/object.c:734:9
    #3 0x561c2d271d0d in object_unref  ../qom/object.c:1231:9
    #4 0x561c2d32ef1d in qio_channel_fd_source_finalize  ../io/channel-watch.c:95:5
    #5 0x7fb2c091d124 in g_source_unref_internal ../glib/gmain.c:2298
    #6 0x561c2d2f0b6c in io_watch_poll_prepare  ../chardev/char-io.c:71:9
    ...

previously allocated by thread T3 (connect) here:
    #0 0x561c2d231c69 in malloc
    #1 0x7fb2c0926518 in g_malloc
    #2 0x561c2d27246e in object_new_with_type  ../qom/object.c:767:15
    #3 0x561c2d272530 in object_new  ../qom/object.c:789:12
    #4 0x561c2d320193 in qio_channel_socket_new  ../io/channel-socket.c:64:31
    #5 0x561c2d308013 in tcp_chr_connect_client_async  ../chardev/char-socket.c:1181:12
    #6 0x561c2d3002e7 in qmp_chardev_open_socket_client  ../chardev/char-socket.c:1281:9
    ...

Fix the issue by incrementing the iochannel reference count when the
IOWatchPoll takes a reference and decrementing when it is finalized.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260302092225.4088227-6-peter.maydell@linaro.org
[PMM: rebased]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 chardev/char-io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index beac5cd245..0e5ba316ed 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -88,6 +88,9 @@ static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc callback,
 static void io_watch_poll_finalize(GSource *source)
 {
     IOWatchPoll *iwp = io_watch_poll_from_source(source);
+
+    object_unref(OBJECT(iwp->ioc));
+
     if (iwp->src) {
         g_source_destroy(iwp->src);
         g_source_unref(iwp->src);
@@ -117,6 +120,8 @@ GSource *io_add_watch_poll(Chardev *chr,
     iwp->fd_can_read = fd_can_read;
     iwp->opaque = user_data;
     iwp->ioc = ioc;
+    object_ref(OBJECT(iwp->ioc));
+
     iwp->fd_read = (GSourceFunc) fd_read;
     iwp->src = NULL;
     iwp->context = context;
-- 
2.43.0


