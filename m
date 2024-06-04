Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2544CC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZWn-00029Y-Vd; Tue, 04 Jun 2024 15:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWn-00029I-8H
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWl-00015L-8Q
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=Zkp6lUwexdh/zL47G/Dphjyvfe7W13PzgMi1LSLCm1QD1khs0Z8Loju0boRQQ8+1NsCMmi
 LOq28RxrDFKuoiKsbU/0Zk/u9oNxxlxI8Se+vZ1Zp5Xe1UyCoYRZUeF6/fntVCV/z5k8im
 upuRabA637xYfd3nKqN5ocEosU9t8o4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-YLtQwagRO9q-2sDi-AvEdg-1; Tue, 04 Jun 2024 15:08:45 -0400
X-MC-Unique: YLtQwagRO9q-2sDi-AvEdg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4213530af1aso22860405e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528123; x=1718132923;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=crRV9TY5klh7SBSSZdJwG1riMxFcJ6mx1tb/99Cn6iGo+OtlsFjIVH3VWZLPgm4xC1
 dtYtUDwPwrsH9XJMXGqS1KdkLnh3DwN+uHB/vea1jWUopyrtDVKZWb4lznXGKainwzib
 IHiCF0rcLdyqhyxrzPnnCqGj+LxHpe5qIWuDObpLG1uat2dvJWoLXlmqpEm4jG9oBrqx
 Do2qj/e/ndkGIAlks3oWJ4l7ek/Q3dtCw0dJO5xHt8P2Km6yIoU3kHwoiGI6Jymz6G/C
 buVeOrP/gQNvCe1yYEwSvjvb8f7RZMsbpVvEqcCJu7mJE4om5l6sXxTMOUgNZDBm29SH
 vX2A==
X-Gm-Message-State: AOJu0YyTqQOzSwmDkyjFn/tf9y9pEc0t4MPDhS3XLjmc7nHEtzfV3g8/
 sp7ceU7NNOy5MKSraZjrN2JWLtmkoece5SaIbCRUh7pZ+Twgznuw+lwLVvAeWpM2TBq4eDRo0L7
 4GVTUoRTtvZn3Conjq/S/KNv1z/TsBqvvNfeQyE7NTU7aw+vCdwr7QJLEKg/+Rwet+Nh25525YG
 WHeSqVDK57DBtOGm2a2F6pq8WdaM77dw==
X-Received: by 2002:adf:fa82:0:b0:357:dbf1:1d3b with SMTP id
 ffacd0b85a97d-35e8ef7f4e0mr225252f8f.59.1717528122875; 
 Tue, 04 Jun 2024 12:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYNR5RVnoHDGc938FIDM//2FpFPkzV15IrTHFrTnMshg5cBYV9Re5c/6Tw/adkM96928uL+g==
X-Received: by 2002:adf:fa82:0:b0:357:dbf1:1d3b with SMTP id
 ffacd0b85a97d-35e8ef7f4e0mr225233f8f.59.1717528122408; 
 Tue, 04 Jun 2024 12:08:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062ea66sm12351817f8f.78.2024.06.04.12.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:41 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/46] Revert "docs/specs/pvpanic: mark shutdown event as not
 implemented"
Message-ID: <53804a67c6c4431962a7da6302cea44d55181760.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Weißschuh <thomas@t-8ch.de>

The missing functionality has been implemented now.

This reverts commit e739d1935c461d0668057e9dbba9d06f728d29ec.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-8-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pvpanic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index b0f27860ec..61a80480ed 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,7 +29,7 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
-bit 2 (to be implemented)
+bit 2
   a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface
-- 
MST


