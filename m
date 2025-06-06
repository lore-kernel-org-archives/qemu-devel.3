Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE121C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIU-0002jf-19; Fri, 06 Jun 2025 08:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIR-0002i9-Hv
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIP-0005v4-Dg
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OivQJNioYdlpUaf6YbGQbquj0nz64DfXDVzbTQpXZ10=;
 b=A5dbrKuLK1GCHY5gKr4TqF2hMjG6j49AXcXFaobjhIvq+knAqvK3nrn/7BoqoXtYM1gbtu
 UNF9iqJ5LgsLJ7nIlXX8+lYpvZPPuvZxmRfQnnJ+pE629nAzMbbfo6MyPylauiNNDCnYsT
 W8aKHvQRvDa0TyXzku7HIEtncSwxtgs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-UDwY3R6oOaST6lIIzmmmvw-1; Fri, 06 Jun 2025 08:35:38 -0400
X-MC-Unique: UDwY3R6oOaST6lIIzmmmvw-1
X-Mimecast-MFC-AGG-ID: UDwY3R6oOaST6lIIzmmmvw_1749213337
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so15676985e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213336; x=1749818136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OivQJNioYdlpUaf6YbGQbquj0nz64DfXDVzbTQpXZ10=;
 b=Uz0Bo9W0GYfqA4uWWHnq0YfbdovehfQvr06xnhHQyhUwYePYD0eRJto8VrtBQS+HyR
 p8WfCor28ZqNur2YXFDxN8xE6VFqzr1FdQHtP7xd/R4GkFKQ3ER0vlGbvxQAT7BxoBXA
 ko6cPyaqsXvp7s3eSeS5ODYcpoBqAKM/B72wbMJbtO1qhvnXXlvnYpOKIgz4ZQoHOC3s
 JaDc0RqDXmeaaJ5CXb8Isic+wzQtXRbhuLrVt2VXnFnbbnKtolQaSPYnDSHetyazUklm
 FrGDvNIPSgDH9lPacZtGo9qkelcv6qS6cQB3V0daLwp1uRp2nwqoRfWHbKoRg4TFaIaJ
 TrMQ==
X-Gm-Message-State: AOJu0Yx4Q6zwqkFUsTJVRZDZJ2gf77sOZcAscygy/PKgh8aBOvb25m89
 ZmbAm5CxCC+SLQUuQoRslTamg7jbtuKPABOTozwGdU8h7tTqDzTXWPzBFjvRwrXmOFd/aHj0jIc
 I63KrY+TdWQjqcxEfcib5lkcgEaLU2k+TYJjDl/cBr8rMEAjXWF3YsjI6oMS9vq0FOM0sVehtTj
 6tWVu5ZA2L2HiSVYuMUxO6RGiwBAqoI5yKtm6yYyzJ
X-Gm-Gg: ASbGnctdQikAz7pZosEF2uXtwPRAi5MD+2X3itU4ZuUpp162yMQfYVd7EUxj6rAgDgg
 oTfVDxZDsE5EOu625WA3c4jq/edg9NqUh0DvAG8HItUSrdvxRDN1EN8iT2zeB/tu9Uv7xhDvGkx
 884XA8q6+cASMXUO1V/vXfNSXJG4ouExBKNGOslwSjLmgy2Pj1RwPAGaykKMT4A5kNk+pMg7Czx
 5T//khm36AJqxwYmSc/Na4xpCc1ndNS6VOYRfqUTUx9+pFOMUOwWwzF6vdoRzjpGaGD74zgZY57
 Jr70cMOQ07/Nxg==
X-Received: by 2002:a05:600c:c4b7:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-4520137c932mr31884255e9.19.1749213336023; 
 Fri, 06 Jun 2025 05:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiA40ztizJJWAF0WEz833FmOdzp76s5qVk5KsVItgIZyKD7/vdWMYrroPTA8RfqqT6yLYy1A==
X-Received: by 2002:a05:600c:c4b7:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-4520137c932mr31884045e9.19.1749213335589; 
 Fri, 06 Jun 2025 05:35:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521370961csm22703135e9.22.2025.06.06.05.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/31] docs: update Rust module status
Date: Fri,  6 Jun 2025 14:34:28 +0200
Message-ID: <20250606123447.538131-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

error is new; offset_of is gone.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index d60d56d0a69..47e9677fcb0 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -160,10 +160,10 @@ module           status
 ``callbacks``    complete
 ``cell``         stable
 ``errno``        complete
+``error``        stable
 ``irq``          complete
 ``memory``       stable
 ``module``       complete
-``offset_of``    stable
 ``qdev``         stable
 ``qom``          stable
 ``sysbus``       stable
-- 
2.49.0


