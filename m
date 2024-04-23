Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B17C10F15
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnm-0003qa-9m; Tue, 23 Apr 2024 18:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOme-0001U4-V9
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOma-00066U-Tw
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBGt930J+mWhxIR8+PNQsf9tR/wyw+FVArMhumdCz7c=;
 b=Be5IlZcePGT7MatluyQoqqc/Xb+xUpG/+k8ZtVJfuNIZWu4g7zayKVP0/8OFjhKix2gRG+
 6tyWhuz/eMwqsNqh8GxQUWCGcR/B+cZ1p2gGqOYLMxtRKP0ydnihTpq4Y6U+AMUU+nevUq
 x1oYu7IDnBjvKp8xNEvB7I9HLdrySIM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8lhGqAPVMPuSFUoW0TZRug-1; Tue, 23 Apr 2024 18:38:29 -0400
X-MC-Unique: 8lhGqAPVMPuSFUoW0TZRug-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69b37bbded3so17221216d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911909; x=1714516709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBGt930J+mWhxIR8+PNQsf9tR/wyw+FVArMhumdCz7c=;
 b=udY9JKUROZS4sYPK7BNLoiS/bDgPcnCOPKoCSHNfWTSjNIRCviHq8vgSrQAcb5XcfI
 HvB4Pz+fQewPxnkD1ZAYidehJrWQhjWgGfQevEBFK5o1BKxwt+Vdjc7ag69/bK4PRldw
 mxyzNbihxhAEm+I0UygdxagSpw3EjmRRQuHAP330CKFGw1gVBzCN36OteXAFbVT0CrK/
 rkVmiiBeU+/1IvRiRcbgWutRykfsep9hG7oPGnNJC0abPrqXzv8PVNb9R3fqyi2qvY98
 /rnbaS+P7YZ7Bmor/6i3Tj7tMy1ztHiwn6MBHYMAInsijWO/Z8bmQynEE64jp3rO4goN
 DrCg==
X-Gm-Message-State: AOJu0YxouAqtZiz06HinUQWnMJG5YuglgSKc+8N/VhDr7AV/CJeobo6S
 iRsoUAFFBx4qK/1di5LFahDN5L/vUb+v1AQSR1AqtHFQ15GCsEk4JxZxhHbvN280QY6WK3/IZYp
 qzLWnJUr6bIf9yO8L2iCwRjdnddVwh0IiPNoO3SwX5n6AsCMPnhZzuUHM4mFBL2SMBMWYsplK9x
 HQzpHKo/kBZ8w6xxnAnhiCih1yQ8+0t3QIBA==
X-Received: by 2002:ad4:5ecf:0:b0:6a0:6ffa:c306 with SMTP id
 jm15-20020ad45ecf000000b006a06ffac306mr759543qvb.6.1713911908785; 
 Tue, 23 Apr 2024 15:38:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDHkRundaZLdd+7YWRvZK/4Pu4i6XJ4j0hd1FVh9296fEAtRAw70juBMX4oK9STmXODOpnQw==
X-Received: by 2002:ad4:5ecf:0:b0:6a0:6ffa:c306 with SMTP id
 jm15-20020ad45ecf000000b006a06ffac306mr759515qvb.6.1713911908236; 
 Tue, 23 Apr 2024 15:38:28 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Het Gala <het.gala@nutanix.com>
Subject: [PULL 09/26] tests/qtest/migration: Fix typo for vsock in
 SocketAddress_to_str
Date: Tue, 23 Apr 2024 18:37:56 -0400
Message-ID: <20240423223813.3237060-10-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

From: Het Gala <het.gala@nutanix.com>

Signed-off-by: Het Gala <het.gala@nutanix.com>
Link: https://lore.kernel.org/r/20240319204840.211632-2-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3b72cad6c1..ce6d6615b5 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -42,7 +42,7 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     case SOCKET_ADDRESS_TYPE_FD:
         return g_strdup_printf("fd:%s", addr->u.fd.str);
     case SOCKET_ADDRESS_TYPE_VSOCK:
-        return g_strdup_printf("tcp:%s:%s",
+        return g_strdup_printf("vsock:%s:%s",
                                addr->u.vsock.cid,
                                addr->u.vsock.port);
     default:
-- 
2.44.0


