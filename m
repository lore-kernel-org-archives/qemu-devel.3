Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E54C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRv-0000Fx-Jf; Tue, 20 May 2025 13:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRs-0000A3-67
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRq-0001AQ-GR
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtWneoMVo461co8B0dUaF2ECam+CQefc0LeGbVUreg4=;
 b=g64QvOYTMZ21c510417rLTTQ977MJ+VwFdOH111OC4QJWOMppjFpiIzUdvQfl/FQJp76dP
 N3C3aBuwXQ2sjaj0bIeLL7rNFnLRqakWuZMwV4jJF/AEsOTSzaDW/euPhRMatYTYwGqHDh
 J7eSuVisMOYAfAFsTrFo3CFnA8aCVZM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-jCmF3QHFMSyVffvg0z7j0g-1; Tue, 20 May 2025 13:08:11 -0400
X-MC-Unique: jCmF3QHFMSyVffvg0z7j0g-1
X-Mimecast-MFC-AGG-ID: jCmF3QHFMSyVffvg0z7j0g_1747760891
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c7c30d8986so1805474785a.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760890; x=1748365690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtWneoMVo461co8B0dUaF2ECam+CQefc0LeGbVUreg4=;
 b=W8T3G9KHznT9eyGj43TtZOb8Jlv+byeDRultm73FqB3WHRU0Z3T/yAeph57lD05u4T
 0UzPjshylkmsznPuenDBtXNGloQbiSv+eCJCUwU3tqaq4DYsAjewUy2S/5rhFGbVkZcZ
 N2S1gPWuvehA0wbmR/aDTZYF6/tPhg/L5qIO4fjPuj8IuiGFFDDOgiIaaH1wJ1QeO3/c
 m8B0H9Vid/0c9KJLZsfUalseEWNAybTM9HkQttF/b3XC13tErVvJ2hC6FKPvgOxUQ6YH
 UNhlIeGlEY3pFwAk6oxAzbz70+/9kYjto92fmL+QwhidepEMIsvQCVmMKgCTQG+3z/Yj
 GwNg==
X-Gm-Message-State: AOJu0Yxm5cPjKbwRWmLslfChLoMagY1CZlB8+NPaJ1i6pm0XObKKob+6
 jcOrcWRb5fQxVyum1cM6CK0YAdOXwU90Ja3dQbNnbQrwXEqcEPbDNC8XYCLSX3Wa/3drE8dKoU/
 kg67KCrWdZ1oAZ4wasfSbDatJQybd2D6rkaXy6fJSPgOtGnhsPqZFRDe+iZKrOcqATcOtJ7mYXx
 qmDdtGkxt72oyxy+86YNoytbH2JAj+rVtXRd7I0A==
X-Gm-Gg: ASbGncudKVb80Z2JPS6FlOu3ngRWWLkjsbSYuPtc8dxnJ3vcMmX0aoj+xbfOki94TQQ
 QLh3UP0eCdTdulxt5mGLLZ1hTGawpiHLE3kaswi0KjVpdjmFm3W2ytkzCGyhtGrOJejqHg8hs0A
 vIthA9T1ufuNU24LQ/FP72y2UJKNvvf2Gthf74G5sHVVdQV2Vd8CR+qDMxHej1Yo6f/M5O8osId
 dPYhQl1jNEJIJ8qh1EPSOTjIHMTuHe9CX5nn8pbYZGAiyanlVzW4DmiSqlgeg4jkjVURDw9KFVk
X-Received: by 2002:a05:620a:410c:b0:7ce:cb67:1ddf with SMTP id
 af79cd13be357-7cecb671ecemr347093285a.49.1747760890206; 
 Tue, 20 May 2025 10:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgfUsBPquxPzooxF4OwspK2hQUz3R0HiZg6gkOR9RCg5zyHzDu0/+aFcyYWY6oyk6C3fzuEw==
X-Received: by 2002:a05:620a:410c:b0:7ce:cb67:1ddf with SMTP id
 af79cd13be357-7cecb671ecemr347087885a.49.1747760889629; 
 Tue, 20 May 2025 10:08:09 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:08:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 10/12] migration/multifd: Don't send device state packets with
 zerocopy flag
Date: Tue, 20 May 2025 13:07:49 -0400
Message-ID: <20250520170751.786787-11-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

If zerocopy is enabled for multifd then QIO_CHANNEL_WRITE_FLAG_ZERO_COPY
flag is forced into all multifd channel write calls via p->write_flags
that was setup in multifd_nocomp_send_setup().

However, device state packets aren't compatible with zerocopy - the data
buffer isn't getting kept pinned until multifd channel flush.

Make sure to mask that QIO_CHANNEL_WRITE_FLAG_ZERO_COPY flag in a multifd
send thread if the data being sent is device state.

Fixes: 0525b91a0b99 ("migration/multifd: Device state transfer support - send side")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/3bd5f48578e29f3a78f41b1e4fbea3d4b2d9b136.1747403393.git.maciej.szmigiero@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index f18b166bcf..b255778855 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -690,6 +690,7 @@ static void *multifd_send_thread(void *opaque)
         if (qatomic_load_acquire(&p->pending_job)) {
             bool is_device_state = multifd_payload_device_state(p->data);
             size_t total_size;
+            int write_flags_masked = 0;
 
             p->flags = 0;
             p->iovs_num = 0;
@@ -697,6 +698,9 @@ static void *multifd_send_thread(void *opaque)
 
             if (is_device_state) {
                 multifd_device_state_send_prepare(p);
+
+                /* Device state packets cannot be sent via zerocopy */
+                write_flags_masked |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
             } else {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
                 if (ret != 0) {
@@ -718,7 +722,8 @@ static void *multifd_send_thread(void *opaque)
                                               &p->data->u.ram, &local_err);
             } else {
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
-                                                  NULL, 0, p->write_flags,
+                                                  NULL, 0,
+                                                  p->write_flags & ~write_flags_masked,
                                                   &local_err);
             }
 
-- 
2.49.0


