Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3E4C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjx7-0004gd-8j; Tue, 02 Jul 2024 16:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwv-0003iV-6i
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwt-00007r-Em
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LYdZnAc26juhzysGXK6UuvaiCGSQLeNMHoi5Vg2b1dE=;
 b=cRv34tK81jSRL3UDJVVdL/FYDFzAx1pIkg8kwRLIosMrAzUyeCmoTqf0m6ttn9595wqZ2Y
 yrQv5VF6iVBgI+DjNxEUYk4WOt86NXE8uetX97GIUiHPlzwqezx3OxKOj6pWPeIwXXvFH7
 Rqu6jMl6ZHq/UemU116oAAEqXGOnT2o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-QsRCxmD7M9uclBF4PK7ytg-1; Tue, 02 Jul 2024 16:17:57 -0400
X-MC-Unique: QsRCxmD7M9uclBF4PK7ytg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42565672e0aso28971455e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951474; x=1720556274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYdZnAc26juhzysGXK6UuvaiCGSQLeNMHoi5Vg2b1dE=;
 b=nkmou+DyFhePK8RCwijIMKJIdW8tuqZ4OV/mF/Ft6P56PsRzWikuW8WK+Ss9fPy/5T
 9VTpbzxY1nsnAfxY2jMXM2hIHfEsAoMlHMa3393ecBfMxy8Le1bIzbqlU2X/QsGKs7OG
 Qyfm2aK7rgzvGAk2ezHDU0dBBJzHPeaOckPWPlylnu+3DbXfUi730Ik4gAWdgnIYt21S
 lkwGXIlH8rjDE+vchK04pLt/lnliAKuytFgUeSX24ysC6eTce2BN0qAeiSC1P0npUGiZ
 K4g/8lvgBOMXZN2pf7tLzwLjt4krnGB8pW41rORelUUUjuQ050ZxS26TRUfaIt3/Z1CN
 uV4Q==
X-Gm-Message-State: AOJu0Yz3Zb4Cau29gFDrJY4tkwxPS87c9gZ++y8qQic6dkNizFYQVOF6
 VUr6s4G9nzKg2cG0d3eZZVc0fC2sCZ/neqhVT0arSPq1ReYHNbN591C30J3v2K8TSiZ4GLQZLog
 XvTBCFmvltea5FF6v+YTjFRoRHIbPf9EX4jwIH9HadTPlKxA8z1pK1cyEa4jW/5WnQl5vvRDIjN
 wzMH+5JUFKmNRIeWFQoOHzyt4EifKHug==
X-Received: by 2002:a05:6000:2c5:b0:367:3404:1c06 with SMTP id
 ffacd0b85a97d-3677acb5d0amr7351738f8f.20.1719951474573; 
 Tue, 02 Jul 2024 13:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAxUzzc6q18YpcumSovaXREP7m51pgYDf7chhCr0gv/DphSUxf1WUPvhGlI9n2e2fskvfriw==
X-Received: by 2002:a05:6000:2c5:b0:367:3404:1c06 with SMTP id
 ffacd0b85a97d-3677acb5d0amr7351703f8f.20.1719951473903; 
 Tue, 02 Jul 2024 13:17:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e141esm14007396f8f.58.2024.07.02.13.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:53 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuxue Liu <yuxue.liu@jaguarmicro.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 40/88] vhost-user-test: no set non-blocking for cal fd less
 than 0.
Message-ID: <f72fc16910c8f44edf052f52672e0e63bbbc773c.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

In the scenario where vhost-user sets eventfd to -1,
qemu_chr_fe_get_msgfds retrieves fd as -1. When vhost_user_read
receives, it does not perform blocking operations on the descriptor
with fd=-1, so non-blocking operations should not be performed here
either.This is a normal use case. Calling g_unix_set_fd_nonblocking
at this point will cause the test to interrupt.

When vhost_user_write sets the call fd to -1, it sets the number of
fds to 0, so the fds obtained by qemu_chr_fe_get_msgfds will also
be 0.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Message-Id: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f..255bde54ab 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -458,7 +458,10 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_KICK:
     case VHOST_USER_SET_VRING_CALL:
         /* consume the fd */
-        qemu_chr_fe_get_msgfds(chr, &fd, 1);
+        if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
+            qos_printf("call fd: %d, do not set non-blocking\n", fd);
+            break;
+        }
         /*
          * This is a non-blocking eventfd.
          * The receive function forces it to be blocking,
-- 
MST


