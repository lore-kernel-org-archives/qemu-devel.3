Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAF1D60CEC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 22:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDA0I-0002dE-Hn; Mon, 18 Nov 2024 17:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA0B-0002b7-5W
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA09-0006as-PY
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731968024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNbWhUzuTl7PVjee2Nf29buGdAIQPwxZR1jPGOGdLDU=;
 b=c1yeJIfYPzmMFzrDtBpYOMdqwywUCZLqpX/7fP9gRdba+XBo9KKFrIeVh3bi5Z9LnRqvr/
 HMjUend5E3rQM+rt7QT5hL7Oc5G3IPei8L7S41nQ39dUjb+NMzNjU1oNtOXrF5RP+WuJZA
 5N/aOuTPSgYbofJUi5cbVTnbYJyx/0o=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-YYEQtFBdMd-oFdsQ-aYvFQ-1; Mon, 18 Nov 2024 17:13:42 -0500
X-MC-Unique: YYEQtFBdMd-oFdsQ-aYvFQ-1
X-Mimecast-MFC-AGG-ID: YYEQtFBdMd-oFdsQ-aYvFQ
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83aaca0efc6so32076239f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 14:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731968021; x=1732572821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNbWhUzuTl7PVjee2Nf29buGdAIQPwxZR1jPGOGdLDU=;
 b=aZGTLc33KyUPRJaKAjEwYs+aA8cPA9bQdsjP1FoLx9+00RO6RsgCWrhdszJylTh6x4
 kPLAaXu7s+7ozk2Njvj3PIK9R50uUstZu/NhAUHijNpaOd/r6zNcGgpZz94mRGi19OFF
 R+c6gzjhb9IOGdNaeLvDyONacERLZycjrBvJbCcjvlIwY0n+PdU7zGV3rtcq+5T1h18d
 YxEpY70a+WhCygVY8IPPXSeNkWfGnPZnYdi72/4ogJ7e1zTeoayo4p0ALPGMoK+VYQxC
 8GtAw6QSbchUTiorA5fs1yh345x1QidHNDHAInRIlH+2c0CDbjeUcoTFcAdhDGZZsZI4
 bO+w==
X-Gm-Message-State: AOJu0YwIVK8EizvkVuUaS1LmGzJ9O9Dj93FvcEspHYLkPOji1/M26t9j
 gE1HBaLn+//oiNOTrfNsaYBT7y10NsU+Sy6cxBFIxc+7QbpnyyCoAtrKfYKo4cN6Urh0IsFjwHU
 +0u9g2hb8bsaIc/b+viokSgdo4e56lbeqGs2r5cGu6KELftNNT+p+hCEts0xNQ0ue55q62GIle8
 es0P3bI1tIYYn22Q7Iij6HTDRJt3gidfGOzQ==
X-Received: by 2002:a05:6602:14c8:b0:83a:c0ba:73c6 with SMTP id
 ca18e2360f4ac-83e6c31965emr1209375839f.11.1731968020989; 
 Mon, 18 Nov 2024 14:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbSSn8YeTtMCMHNaenElUCfGGpCPnzRTQLmiVZU99knch+t0teprRxawYHabtflej607Wx7g==
X-Received: by 2002:a05:6602:14c8:b0:83a:c0ba:73c6 with SMTP id
 ca18e2360f4ac-83e6c31965emr1209372339f.11.1731968020639; 
 Mon, 18 Nov 2024 14:13:40 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6e7fd9sm2298599173.9.2024.11.18.14.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 14:13:39 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/5] qdev: Make qdev_get_machine() not use container_get()
Date: Mon, 18 Nov 2024 17:13:29 -0500
Message-ID: <20241118221330.3480246-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241118221330.3480246-1-peterx@redhat.com>
References: <20241118221330.3480246-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Currently, qdev_get_machine() has a slightly misuse of container_get(), as
the helper says "get a container" but in reality the goal is to get the
machine object.

Note that it _may_ get a container (at "/machine") in our current unit test
of test-qdev-global-props.c, but it's probably unexpected and worked by
accident..

Switch to an explicit object_resolve_path_component(), with a side benefit
that qdev_get_machine() can happen a lot, and we don't need to split the
string ("/machine") every time.  This also paves way for making the helper
container_get() never try to return a non-container at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index eff297e584..e828088c58 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -825,7 +825,13 @@ Object *qdev_get_machine(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(object_get_root(), "/machine");
+        /*
+         * NOTE: when the machine is not yet created, this helper will
+         * also keep the cached object untouched and return NULL.  The next
+         * invoke of the helper will try to look for the machine again.
+         * It'll only cache the pointer when it's found the first time.
+         */
+        dev = object_resolve_path_component(object_get_root(), "machine");
     }
 
     return dev;
-- 
2.45.0


