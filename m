Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4949606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gMQkcLC6;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oQt9zhNE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HL-0002uG-AS; Wed, 28 Oct 2026 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GE-0000sg-3P
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GC-0003tG-D6
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BxO5VMZ1m2vRSXVUX+FNzDo8Rt/mF4GlBwZ8lP6HL3g=;
 b=gMQkcLC6aP8TUCT4karKKE+/m+zLt+yj3+Y2Ymd0WjWv+3LhPJJ9kQ5k/2KwZXdT58eYxT
 YXnbhe3ceWWOwQwBL/52RIFOu4xu5BEOyY5eH/9pTrU7aSFw9TbBjrYDpdAD9KUsa7iif/
 VuDXzosd/qD8D3Ocq/r2T+TuYH9UnUo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-6nfarlJqOJml40iSw5pZkA-1; Wed, 28 Oct 2026 13:16:15 -0400
X-MC-Unique: 6nfarlJqOJml40iSw5pZkA-1
X-Mimecast-MFC-AGG-ID: 6nfarlJqOJml40iSw5pZkA_1793207774
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48df5b058ddso814018f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207774; x=1793812574; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BxO5VMZ1m2vRSXVUX+FNzDo8Rt/mF4GlBwZ8lP6HL3g=;
 b=oQt9zhNEcJxU7xJmdG6gQBymJazdm2n4Fc2DDTchmcF2rBN8bP9cZtCSprRwlzSKb8
 jb+8If78zpYFAzs8C3pW8NBMx4sF2FwOo5nXUKLvHOIkc0TypuBjVERDEu/jI+GWnQ69
 TPxsmASR+2TuMrYTpfLNQVs1BbBBrxhYHZQiOl1ZbIq/yMbZrm/gj3XZFbewm6orPyXq
 QOJkMrX42dDjCbdCfIYqOYv9NjbKHcJwmmaM6TitmPsblnbVKoqFSqCumn++OuZv5Sf+
 asYY8vJN9YQkr8K1a56DpDf18Fj387gMZCohpaiZzlE3LRi7UDUrCJePkE1BA4YKqb6J
 KD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207774; x=1793812574;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BxO5VMZ1m2vRSXVUX+FNzDo8Rt/mF4GlBwZ8lP6HL3g=;
 b=GyO4vFIHLXFkesBhUnLYx1mpYzrY2Ni4ROyqvO9601WoJUw0UV26vmJY2z0JkN8U6Z
 sndmbPgmZ/dEE/0ghzNZTAGdNXGnl/zC20nFAxWVdTYFxWOYZus/yRGWZ1h7Qir1PdDp
 fRLAjZO53cWEyPoom9sxtj2hjt4DlaNnOkoMya3fB0NcIQMRuVCvW4/isAOoql2f9nk+
 RYM6tQCY3MObaZmL2LDc/B4r4B9RMHLxsbSTWXPloCmYP1fXPfiSlhG9hsi43V4cJfBx
 XUAqLwEgGycPH6NFBZ2SsqzBSNPztKK4PVnPo2LlnDeBca86fIsbaGP8Qm7ulwbz21fz
 4gPA==
X-Gm-Message-State: AFq9FYIAeGNYRLipNJM9TO/ONCyJ0ZgzaLwYQDhx8JMveKx6qR72adtp
 WwwZcDHiTNOQmFzo3wDkxJc6PanUfW+DUjn8r76mrqr71sLeU3EAT3QPb/FnosctX1L1KyirqUt
 C1F1RovlhT+Y6xyeZ3k2MGBf0/EPhHh/Dh5/heJROeVIFLyw9WebNdA8K7K+dpcZlt7j7z3coMI
 o1opIM4v+t7aodLJgIt727UApQffWVCWdjAA==
X-Gm-Gg: AYBFou2tzknBRYuAbcUT7ZFKyxhh+PpWgUjP8xHp0EFh7kDGsjfJr+DYm6kec82s0QF
 tjTPVVNZbU++Bi1mur3mWkSjGNrpIGkR1P6Dtle2B36/nwdlk0eauX1EFZDOo1EDHWLmAv0+ULA
 U8sSai2zki3IYO88OYLQDuqhqXGhNgDsAGZefIMcpoXlg+fvWuaO1hU2XXM3KGCG3OJ6HXUGD6P
 dwnJsExMMhlp2RC/OdRXgY5tYgOq3OBoKZDPk7d3ivc/lWu0IGt1RBwZBP0V+60lAKtgizUUezZ
 ultT9ZzcIlHjjLH/kf8BCMIiXoJRBG5Xhlx0XNxU1GDzsHVMkklEeG6G0ro9Ce61XNctmVeenU3
 E2mj2XIg7GmUhPRDmonOTYUtz9ARtLRaJGx0mkn5o
X-Received: by 2002:a05:6000:2207:b0:48e:61c9:4e32 with SMTP id
 ffacd0b85a97d-48e61c94e5emr2679199f8f.32.1793207773914; 
 Wed, 28 Oct 2026 10:16:13 -0700 (PDT)
X-Received: by 2002:a05:6000:2207:b0:48e:61c9:4e32 with SMTP id
 ffacd0b85a97d-48e61c94e5emr2679102f8f.32.1793207773145; 
 Wed, 28 Oct 2026 10:16:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4be6sm27065740f8f.37.2026.10.28.10.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:12 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 51/78] contrib/vhost-user-bridge: Use stderr for debug output
Message-ID: <00c714b33b5ee1b0ced551ab72971191d8b928f6.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yodel Eldar <yodel.eldar@yodel.dev>

Since vhost-user-bridge is solely used for testing, and
logging to stderr ensures proper interleaving of debug
output in automated testing, modify the DPRINT macro to
write to stderr instead of stdout.

Message ID of relevant thread:
<20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260914165250.88382-2-yodel.eldar@yodel.dev>
---
 contrib/vhost-user-bridge/vhost-user-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c b/contrib/vhost-user-bridge/vhost-user-bridge.c
index 3f0fd0fa49..a6f7ec226c 100644
--- a/contrib/vhost-user-bridge/vhost-user-bridge.c
+++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
@@ -41,7 +41,7 @@
 #define DPRINT(...) \
     do { \
         if (VHOST_USER_BRIDGE_DEBUG) { \
-            printf(__VA_ARGS__); \
+            fprintf(stderr, __VA_ARGS__); \
         } \
     } while (0)
 
-- 
MST


