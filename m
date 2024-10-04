Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F625CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJE-0005Rw-Rr; Fri, 04 Oct 2024 12:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlHA-0000b6-5J
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlH8-0006Vm-Ha
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpRZLu1LDAQ4lHu80CpSku7vlaQLxLoF4YRF8+/3PN0=;
 b=XiPSAYtuhtFx50PBVtAozB4ncIkm4gJ3/EpElGYbVH94cKtej7/BKhf1emsHKlnCodx1zA
 YOH88rluighllbtd62az6GLnizFp4eG98JKknHFuozduWdAw9VYkeAyHXe7B1Q6YTYiBSC
 5pwSnrWMEHzxn53RKbPWX7H2wXYRbkY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-9K51u9bUMf660_J3xpLaPA-1; Fri, 04 Oct 2024 12:35:28 -0400
X-MC-Unique: 9K51u9bUMf660_J3xpLaPA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb6f3c476so17432845e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059727; x=1728664527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpRZLu1LDAQ4lHu80CpSku7vlaQLxLoF4YRF8+/3PN0=;
 b=ancgBlHWpcha1sBgm8kDJPAfX4qa/Sj8XR2vfvYFhWMljVVO9exB9CB+/cpz5YtziH
 dIIzRd2uXoMxg9QbuXpfDM+n+hvoI1M3T0TFBV8SUZ+qx2xO2Pri7essEiJo9RIMv3k2
 RJqC0N9WCYOLS9ir+rhWKKz4BuGvBF4IE58aog2AqPezPLIsSudYcVxoh4vNuE43XWFv
 wb3l+1RMbMhBY1f7WJ5Cqhg7eut9zUlKDANzuqgzt4llUcnNRyLJhz68Q3qguJpbz065
 dTYqHA3C4mAFtMvGfVfiWbF7cGqIs0YO2wpkPshd5cc9G+eL2AA+I3l2ywtt1rYRDVV1
 TZwQ==
X-Gm-Message-State: AOJu0Yxn8lJKh690h0uCV1ajTs3Tjn+88CX2J3j72ej2ls7YCCHuGZ9U
 CpGW4hddkODTveySHh7/1+wYsz2UswvkjIRRKdk5ADD6DEuDammQWkq7s1DvvVcaQ0BcibhnJo6
 EGQP6J2Z9sDV9zzo9o9l8qWon7dZc9d7xKwDH5exMHOBreu5TLKV4mCBh2nuSS4uBzsBW+AVvTn
 yIrUD/uZ9sAGe8PCpuw7W+Egr8FCqCcKUOZmsB1Ww=
X-Received: by 2002:a05:600c:4f4b:b0:42c:bd27:4be4 with SMTP id
 5b1f17b1804b1-42f85aa62e7mr26746795e9.8.1728059726597; 
 Fri, 04 Oct 2024 09:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/0YrhisACE/5G2wPphIx2CVyjsEnTn8543n1EBu2AAxiG0Gn0cmRPWf1RCBhWcQpYxKxY6g==
X-Received: by 2002:a05:600c:4f4b:b0:42c:bd27:4be4 with SMTP id
 5b1f17b1804b1-42f85aa62e7mr26746575e9.8.1728059726071; 
 Fri, 04 Oct 2024 09:35:26 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e83363sm1633325e9.6.2024.10.04.09.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 22/23] qom: set *ambiguous on all paths
Date: Fri,  4 Oct 2024 18:34:14 +0200
Message-ID: <20241004163415.951106-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

So the caller contract is simpler.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20241002080806.2868406-3-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 0adbef29462..222804dcfb5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2201,6 +2201,9 @@ Object *object_resolve_path_type(const char *path, const char *typename,
         }
     } else {
         obj = object_resolve_abs_path(object_get_root(), parts + 1, typename);
+        if (ambiguous) {
+            *ambiguous = false;
+        }
     }
 
     g_strfreev(parts);
-- 
2.46.1


