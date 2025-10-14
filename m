Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EDCCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEG-0005mf-MU; Tue, 14 Oct 2025 09:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDz-0005VN-GP
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDt-000144-IZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTZ3ClnJQMXJF+JfzAzYWShwr2lG5rC7REx/EFEbJ/o=;
 b=icK/Y4W8U1kjTn1b0l2+AQvW6CfEQFMCMNci1q3RG2M1T0tYwqUMAdD2a0CjMW9ePjBpim
 jbMAobEALNZYIrjF3v2H5AQh0GSyUo+xY+0IBavnFFoPVuep/7TUbnsCJ3xVsaFaP+Aq01
 tBr5GECSIq/9vRbxdhRIElDVz8EXkoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-9ryCwmJ0NvWVIyrkRMJNig-1; Tue, 14 Oct 2025 09:37:50 -0400
X-MC-Unique: 9ryCwmJ0NvWVIyrkRMJNig-1
X-Mimecast-MFC-AGG-ID: 9ryCwmJ0NvWVIyrkRMJNig_1760449069
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso4616596f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449068; x=1761053868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTZ3ClnJQMXJF+JfzAzYWShwr2lG5rC7REx/EFEbJ/o=;
 b=OXYell6hYO15WU3qHoeRAg9dYz9e1RyaLFZUz+VAd+OLqnVUvlHe6q3mXWUWrzRPg3
 TyN09GZQtcy4bZGDWPIXx6WtbNURDPFCd1ov7w/vp5eiGnmsO43VGrJLJTJUwD8gVTbQ
 R4zIesPzbcejyufFnO1oepLKylkck5/IVa/87HBh4dPHJCw/lIvrAtyGH7xLJGE8m9N9
 BjRydytMsJhyxJADfCswVnypFdtkgYbf2vTxHIdpSR8OwysIL/9CpcuwhcesknjhhiK+
 mfF72TR9tJdZze99mTEcFbOgnwXdvpDROPy9pOKaE3NW71HVFhUccPh4Qbmf9eZg9sYJ
 bbzA==
X-Gm-Message-State: AOJu0YwB/MPQ2jDs0qopT6ldMlUlVHEBl4jZwyEArefiunQjQCgZQppW
 nqMGZW2D6D2KoxN7J6GfBWgpzvrmndpZ3Lj6H5Q1JSBfNY0FMfQVrAOnqcY1kAc6jopY3HTIshj
 CUEQOv/HIPim9bgow8oKtG8stZV4b6H/0QV9jgNc7ToXj76OH7z0I63ONfdC9MYI21pk5fBoykG
 S2XFGDCkQthVJkwCyhb24Tsb2criQHcqO4T79YNVAI
X-Gm-Gg: ASbGncsLq7FFjhfrLV0EJJGah0rXeSU95XDHi/aU9zYJuGtNtpk6avoU8heyPArC6vO
 FF54xpvkvUfQP4aE75M8ctgJDqE2D/xU1sDK578U0tj87HnKmwsxTRc2Dxyoi5TWVhijzLKw9E8
 KDj+xJva1SQbE0GspbMUM0OjfYcvNBb10q1Lh+QGJDn/2MtOCmqIB/rhgqlHM5Eym2SW+wlhpWT
 b4n8rUBudl4DsfZ4zJT2kMjvXwFgNWWGl5mhp2yTEBMrHZphUbrMyI8BL32ddrI6S9a4UWBaElh
 8V0Y+m7QmoEg8NJ9lk+ZiLKfr68+5mRMpfj03v9AkGna+CF3tuNTsYGV1giHkL9RpbJYVUUE2aM
 3AGHKWoqg4lF6S3NwD9RrW95wqwQ8oTvsVe8IMEGR0Co=
X-Received: by 2002:a05:6000:288c:b0:3dc:eb5:51ea with SMTP id
 ffacd0b85a97d-4266e8e0995mr16141079f8f.49.1760449067983; 
 Tue, 14 Oct 2025 06:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Kym2GKQ7rcZhfbWeNFBgZwNZxuBLv0dpUpiOxebr3mC2GbjKhbJx5KGk90AyKaQBtUAASg==
X-Received: by 2002:a05:6000:288c:b0:3dc:eb5:51ea with SMTP id
 ffacd0b85a97d-4266e8e0995mr16141051f8f.49.1760449067534; 
 Tue, 14 Oct 2025 06:37:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf6b4sm23840092f8f.25.2025.10.14.06.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 13/28] async: access bottom half flags with qatomic_read
Date: Tue, 14 Oct 2025 15:36:58 +0200
Message-ID: <20251014133713.1103695-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Running test-aio-multithread under TSAN reveals data races on bh->flags.
Because bottom halves may be scheduled or canceled asynchronously,
without taking a lock, adjust aio_compute_bh_timeout() and aio_ctx_check()
to use a relaxed read to access the flags.

Use an acquire load to ensure that anything that was written prior to
qemu_bh_schedule() is visible.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2749
Closes: https://gitlab.com/qemu-project/qemu/-/issues/851
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/async.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/util/async.c b/util/async.c
index 2719c629ae9..a736d2cd0d0 100644
--- a/util/async.c
+++ b/util/async.c
@@ -256,8 +256,9 @@ static int64_t aio_compute_bh_timeout(BHList *head, int timeout)
     QEMUBH *bh;
 
     QSLIST_FOREACH_RCU(bh, head, next) {
-        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
-            if (bh->flags & BH_IDLE) {
+        int flags = qatomic_load_acquire(&bh->flags);
+        if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+            if (flags & BH_IDLE) {
                 /* idle bottom halves will be polled at least
                  * every 10ms */
                 timeout = 10000000;
@@ -335,14 +336,16 @@ aio_ctx_check(GSource *source)
     aio_notify_accept(ctx);
 
     QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
-        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+        int flags = qatomic_load_acquire(&bh->flags);
+        if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
             return true;
         }
     }
 
     QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
         QSLIST_FOREACH_RCU(bh, &s->bh_list, next) {
-            if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+            int flags = qatomic_load_acquire(&bh->flags);
+            if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
                 return true;
             }
         }
-- 
2.51.0


