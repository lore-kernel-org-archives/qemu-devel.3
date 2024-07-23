Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5398AC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDB3-0006e7-Pm; Tue, 23 Jul 2024 06:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDB2-0006co-29
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDB0-0001Zc-Jx
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgG/mkRDkzGxJm+xP/ZVe4hG5yYRqISPsjfYjXIDy78=;
 b=ca+BRSfa8iaDUgW66dTdG1eEWTAhgQPGtE89L1pv/rb5bwtGvNqE1jgX29zijXXDp8FfR+
 bzcuJB0svD/d0maBTnc0nLSIEWGW+h15gA1E/sCX+RjAPivIRnSnoCFoE1Gt4fMLHA9ofo
 H60vzz+HpuuU7wgjcxOaSvsU/ISFxf0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-q0rO56RJNI671sDCHTLauQ-1; Tue, 23 Jul 2024 06:55:24 -0400
X-MC-Unique: q0rO56RJNI671sDCHTLauQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77f0eca759so399505766b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732123; x=1722336923;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgG/mkRDkzGxJm+xP/ZVe4hG5yYRqISPsjfYjXIDy78=;
 b=LvaOistQPaT4wYPcv0sfr7JbnaTlJfMgefS0hrmTKmioNl43oSnsgnc9HBRxjnzju+
 Ij1wlUaTz7P3l0gap8VtA2n8iibJouEzJ+8eZfTgZFashaGIDlnGu/aCzdS6UtW2L6WH
 EciBkvErWl3eZ7FCqSCdhvBYC3IcrMwucKDVLQMqGNn87f8xBUJ+ljh1DXl5w5S5A96Y
 3ArqOiR5jdGfiweQrv9dj65tTJhkq+YwLyeLi6Z6svCfPCwvhaR973eIJoeVcG6jTI5H
 dn7H1vxZ8JL+klrsNSCnQHPaKM4XlOc/xuoJ1ZKdcgi9Pi00TgEB6SSeydyo8KZQuRI6
 DyQA==
X-Gm-Message-State: AOJu0YwLvJaiePxRWKdZlhTVUrvv+kPGCwZVTyrZCivzYsXZTYYts8/N
 2to7xrKquWq6pnSMenXQX37mLlriDrdeyatjEWwV0upXpLN5VJxtQk12h/Bnww12fGY4fzEeHky
 BrvHKXYqtaMzdcK9ah6N+HUZKssvAcI0/PL6qPkCy3V5QIjR4FXCo/yQnzotGJUOWtEt8C2o5XR
 I1tlwWln33HBzvSv0CkFkB1uB5dq6DJQ==
X-Received: by 2002:a17:906:eec5:b0:a72:6e13:a4b6 with SMTP id
 a640c23a62f3a-a7a4c44701bmr613851066b.58.1721732123059; 
 Tue, 23 Jul 2024 03:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXf1r3h9et8o1eEBEF6VrxZkHWCb/x5P5vC7q1UkD2xo/ZLaW6rnGhV4bpYKZDle3ROdIqJA==
X-Received: by 2002:a17:906:eec5:b0:a72:6e13:a4b6 with SMTP id
 a640c23a62f3a-a7a4c44701bmr613847866b.58.1721732122264; 
 Tue, 23 Jul 2024 03:55:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c922b27sm525639566b.164.2024.07.23.03.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:21 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL v2 02/61] MAINTAINERS: add Stefano Garzarella as
 vhost/vhost-user reviewer
Message-ID: <7967b7e0b17cb5e700ca040e0b68ba8fb0035c0d.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Stefano Garzarella <sgarzare@redhat.com>

I have recently been working on supporting vhost-user on any POSIX,
so I want to help maintain it.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240704081336.21208-1-sgarzare@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..b7e9ced3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2209,6 +2209,7 @@ F: docs/devel/vfio-iommufd.rst
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
+R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
 F: docs/interop/vhost-user.json
-- 
MST


