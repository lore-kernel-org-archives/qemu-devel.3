Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D2BC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCI-0006vv-0Q; Tue, 02 Jul 2024 10:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeC3-0005nn-CW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBv-0008IT-Sd
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HcSJQ8GU27nlWtSZNyFUAnn1DCnRj6gVV+Uj4seSbXY=;
 b=hH1UCe65TlUQITJf/ZEKJtCBw9FXm7P9uR/2Jm+z0SCdNeunBl2qLI2/RuxuyqUsbsm4lr
 Hvk2XL9WGvonUc9CzXGOMzd4Z513bN50EOLJmkHhNEYW+NZc3vZKMLEv537gS1H6WkmWOs
 eCP1T8H0aCZN2zaWax6fM+Vf/DEsA8k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-yfzBQWZiPA2HH_j3hSrTNg-1; Tue, 02 Jul 2024 10:09:05 -0400
X-MC-Unique: yfzBQWZiPA2HH_j3hSrTNg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-364be6c2468so2623145f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929343; x=1720534143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcSJQ8GU27nlWtSZNyFUAnn1DCnRj6gVV+Uj4seSbXY=;
 b=c+C/HRocXp4IkUnLhypHRT8DnxHH6jLBsbtpf3s4kpeNwUub51iHVs1zFywUWlcvA0
 9fBKn8RjJ6CkX8LmOlgnmM2rmMSCiRKD8tPYz+MSSAoCxBQg+sQ1DsfBFoniblaSTmWs
 5B1s5dtQO9N2uTcbNdZZG7Xbd/fQiCK2lUq3MmJ/tbTlEczy+n+TzBxpo0JzIVuCvjyx
 jtzAndkxGNMQRGuQTeK6Q67QWIH5xlUuN9XH14rq1Elz15MIEWPMoBTBhyW1D+gZuNCN
 rli8r5Bt/XojEEZS7dLp8KVwf146egSwwy35Atw34dSoLMP+2uWDQjQibDqFA9OcKSHV
 XRYw==
X-Gm-Message-State: AOJu0Yy//aSf+rvPZFnTWwq3L3FvyaEkM815Cg+d+1e8jTJ/jGNPAMaO
 9S9AMLrvfXNKKXPVEXH1X2q+7cKT4PEHZFocpBeXK/Cs8z8r06FysxmVKE2RCuJSt+HMNRQpAG3
 1plhF594MwqBN2U3kyKpUJaYg4lTCgO3o1Ac0OsCS0mRYO4P+Z3xftt8Cl2vB8iOM4BmrSVL+dd
 QEggBRz3XEyqBxqDy/8i+hKPz1sSacuw==
X-Received: by 2002:adf:e38d:0:b0:367:4165:ad4 with SMTP id
 ffacd0b85a97d-367756ad1d0mr5423025f8f.16.1719929343604; 
 Tue, 02 Jul 2024 07:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/1JOF+EwSHbKGgI79n7mu21RapdB+qLpqFC0t4t2/B9gFRYamEMqEOEfBJOi8tGG79dihHA==
X-Received: by 2002:adf:e38d:0:b0:367:4165:ad4 with SMTP id
 ffacd0b85a97d-367756ad1d0mr5422999f8f.16.1719929342905; 
 Tue, 02 Jul 2024 07:09:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678e06eba4sm899282f8f.90.2024.07.02.07.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:02 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuxue Liu <yuxue.liu@jaguarmicro.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 40/91] vhost-user-test: don't set call fd -1 non-blocking
Message-ID: <ec1a0a63ed7038ffdcdfbfa1d4542cf32f13cd3a.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
either. This is a normal use case. Calling g_unix_set_fd_nonblocking
at this point will cause the test to fail with an assert.

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


