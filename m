Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3B0C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpd-00013n-18; Wed, 17 Jul 2024 01:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpZ-0000q2-P4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpY-0001yp-9i
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYdvr4qiEpyG2gw0AyoyI4aNLrC174pqQVM5gsiHlBw=;
 b=IzruuN2XXRGFx0eOePFm1ijSGCWa9KfJPP5WaFrA4VgMKl8Z5XO4HNSSO9v37fo5b7cZxv
 CVvwXnTYf7BTjX64JNM0yAg/qN7px9SENXigPBGbcfeqxVZVe2xod8znf8v02tB/vSFPWR
 P32G1V/DQPvBs0B9h4C6zIE4BMrra/M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-DboOiFK8NV28eycv0kemmQ-1; Wed, 17 Jul 2024 01:03:53 -0400
X-MC-Unique: DboOiFK8NV28eycv0kemmQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee97349a5fso63506931fa.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192632; x=1721797432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYdvr4qiEpyG2gw0AyoyI4aNLrC174pqQVM5gsiHlBw=;
 b=Y/x0keQbNDqFxHfs4ScYvxeFjhl7qPjUkzpRi3zP6qc5M+kQxNJIIz8FswScdC7Lhc
 MpM0VOiDcOL3vewCeWvGpMDUIb8ILCjG9FXOIJZ0lvAo87EcboAshamZfueWt9f8Fu14
 FWcJBTcxg7In2lZsUC+0qgRTlRhaZEwQ82AbfCg62L5QWp1aCu8LstopJYLzGi0JnJK3
 u2ksDTKGkKiVwz37/D/t0Nl1kXYKN5M+zYr3W7w420MYzHlK9rqxAA9NYlhNkhMzevNv
 ceI6h6pECEFr+BrQHm4imwl/bXXfhT3jKGzSRrVmX7Xu3dKO8NZyGIwZCKIpRWxYs9bc
 90Tg==
X-Gm-Message-State: AOJu0YzLt1Htru1jQldXx6iIjQwhfjuAy5O/ALnbpxEVNZU6ogw8cZE0
 rd7pGCGJlg3QUDLTeahopVIhYz8PfOP0lDHYJ+NMwwoo8x2GAbez0+FSvwPYwo/dYDk4XuDQXpN
 oyDeFcEFRAHh47EzWSf+nyn74Ru95HXIBgqvaopnCAezLOuF+j6UVmystiHK6FsXFHY1pPw3FN6
 1QJ9k4LgKGp8GyMks0UaXBVXzL41ttwkI3dp13
X-Received: by 2002:a05:651c:1992:b0:2ec:565f:ef56 with SMTP id
 38308e7fff4ca-2eefd04f491mr4406211fa.7.1721192631907; 
 Tue, 16 Jul 2024 22:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt/L5LAd88TY+69Z6aGmfcWsh8wIg3ukTbGNyw2A1QQPbyF0tR7GM1b7TQzBXdozVqmIDa9Q==
X-Received: by 2002:a05:651c:1992:b0:2ec:565f:ef56 with SMTP id
 38308e7fff4ca-2eefd04f491mr4406081fa.7.1721192631433; 
 Tue, 16 Jul 2024 22:03:51 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb525sm153463965e9.34.2024.07.16.22.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 07/20] qemu/timer: Add host ticks function for LoongArch
Date: Wed, 17 Jul 2024 07:03:17 +0200
Message-ID: <20240717050331.295371-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Song Gao <gaosong@loongson.cn>

Signed-off-by: Song Gao <gaosong@loongson.cn>
Link: https://lore.kernel.org/r/20240716031500.4193498-1-gaosong@loongson.cn
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 5ce83c79112..fa56ec9481d 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -1016,6 +1016,15 @@ static inline int64_t cpu_get_host_ticks(void)
     return val;
 }
 
+#elif defined(__loongarch64)
+static inline int64_t cpu_get_host_ticks(void)
+{
+    uint64_t val;
+
+    asm volatile("rdtime.d %0, $zero" : "=r"(val));
+    return val;
+}
+
 #else
 /* The host CPU doesn't have an easily accessible cycle counter.
    Just return a monotonically increasing value.  This will be
-- 
2.45.2


