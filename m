Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E201C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeZm-0004Ls-Sl; Tue, 16 Jul 2024 05:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTeZk-00049d-78
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTeZh-0006BG-Mf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721122459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbmKPpTsCEnytdDZM46Pn6lZlmZXD4Tin+ZNefWZp94=;
 b=T8qHFlIydMvI/AEJE+ecIoZ9S85KeDakkZjabHafnVfNtHZzQH2/ZJPoppVqVOzlXdZb9M
 csFyNdule3ZlqxGtpgMpCZw0VvLJw43KCvZ73usfSJeNQHeaY+RiJf9rXrPuP0q9oc+dAB
 BKAjWIyDZHklzWcGMNKYn34mRZxvTBg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-P_Lp93w5MACMQAa0zG3QuQ-1; Tue, 16 Jul 2024 05:34:14 -0400
X-MC-Unique: P_Lp93w5MACMQAa0zG3QuQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4272718b9b0so37753125e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721122452; x=1721727252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbmKPpTsCEnytdDZM46Pn6lZlmZXD4Tin+ZNefWZp94=;
 b=h72Ee/Q9VoGaHTAtTMQRhfXvfXE3qDn1pffKfcHt7v6Mn33//hvqN5j9fFflRc4BV6
 JjFVQF4gNd2G51MSg95qH917qdh+xBzRvZ0gwu5uvpid1bK5raSel/WVZHJCAwKAt7hd
 ceH5zKVQrPPc4FNHgS5XA6FBlvF90KjB77CvOdlnq4uitjMz9ldo6WM9a2z5LHmUwuUF
 LcsZue3biBmulL7ZGALdvfC1dQJIHolZOiYS0yaXOsWirtQR0ENz5vtGsc5skX/vXw+n
 h/SLPcHpqddUqPJ/OOmc9frr9sAIr/UvzUxWPsKgzOvA1FEQeOw1ulq9vqpWoGUUPs6I
 Btmw==
X-Gm-Message-State: AOJu0Yzsng5BBxMOOU3lCoDGe7KGt1z2VVXuzX8Uq1gsQ7HOpj9sZmMl
 Nh1nw3fyP3v7/6cHxS8ag+HEZ/R87grI5yTk+kpbcq0lpuXCbxIslsuF1Pzc90XyAXbkam6PxOy
 Wk8VA8fOeE7w3h96xVbi5WpFMuP3p5cGZSAs3QXoNN1+MftijASRUg4xiTUpkegQbKuhxqj8XLc
 KMg5Vsu7ep1j33WYyWpotGzxiBUwAlLwpVWW0f
X-Received: by 2002:a05:600c:3589:b0:426:6f3e:feef with SMTP id
 5b1f17b1804b1-427ba69775cmr12111875e9.29.1721122452387; 
 Tue, 16 Jul 2024 02:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWpajKwfeOpmKzBW5f4jWqcm+C/WCC0Z8L5JUCumUCRPmIgaUNRZoi9RDA5Mb+RqFcMnNv2Q==
X-Received: by 2002:a05:600c:3589:b0:426:6f3e:feef with SMTP id
 5b1f17b1804b1-427ba69775cmr12111755e9.29.1721122452124; 
 Tue, 16 Jul 2024 02:34:12 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef44b4sm117935315e9.42.2024.07.16.02.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 02:34:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: taisei1212@outlook.jp
Subject: [PATCH 1/2] hpet: fix clamping of period
Date: Tue, 16 Jul 2024 11:34:06 +0200
Message-ID: <20240716093407.194065-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716093407.194065-1-pbonzini@redhat.com>
References: <20240716093407.194065-1-pbonzini@redhat.com>
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

When writing a new period, the clamping should use a maximum value
rather than a bit mask.  Also, when writing the high bits new_val
is shifted right by 32, so the maximum allowed period should also
be shifted right.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 01efe4885db..16be1278d09 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -548,7 +548,9 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  * FIXME: Clamp period to reasonable min value?
                  * Clamp period to reasonable max value
                  */
-                new_val &= (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1;
+                if (timer->config & HPET_TN_32_BIT) {
+                    new_val = MIN(new_val, ~0u >> 1);
+                }
                 timer->period =
                     (timer->period & 0xffffffff00000000ULL) | new_val;
             }
@@ -567,7 +569,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  * FIXME: Clamp period to reasonable min value?
                  * Clamp period to reasonable max value
                  */
-                new_val &= (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1;
+                new_val = MIN(new_val, ~0u >> 1);
                 timer->period =
                     (timer->period & 0xffffffffULL) | new_val << 32;
                 }
-- 
2.45.2


