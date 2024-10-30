Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488C2D5B86D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5N-0003qC-6N; Wed, 30 Oct 2024 11:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5L-0003pB-3G
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5J-0007qh-EV
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9NKSka6dUxxXzhi8guhu9YpXYcj6P64i1DB2FeeVAk=;
 b=Ztjq21nZdthoAb5Ry4LyXwweEVtXti1HqvqgXLovS4riJ/KORtYsTPVsUc0wVu/XgD+WYv
 t5i3UiCIAu03kZANTcUifHySOar720prosZOytNTv4moax/ZV8KFjZLWV7Zxqv+G0KWqTs
 vf8YDCQDlDFXNRkw8qpjqKek71bu8mI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-jo27UzoDMvSxr320icYp_w-1; Wed, 30 Oct 2024 11:58:10 -0400
X-MC-Unique: jo27UzoDMvSxr320icYp_w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbf039dccfso289076d6.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303889; x=1730908689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9NKSka6dUxxXzhi8guhu9YpXYcj6P64i1DB2FeeVAk=;
 b=ipPeO5PvcSbKVB89Dcf2CiWDpgi26uTskx+UQ2eKGWE43h+lgAD/5DLclhJyIfQHtB
 +jBdTd+aX3wVjHoGchH3isR5ICu9XPcrcE9Ui58j3a8TAKKcM2ow9/fL93iKngOrLGtW
 ijwYm1uroDTqp0Y0L41hUkmjkoyxklGOYRt1kyAWtht/cftKqC9enkpVWHtw9n46iuPs
 a1A3PDRwpfv4A1TKDvaWSMvazSazeEQz1p/UsqWigsftQXyDfztZDhLy6/uPdj7m7HRk
 VJU+BCaGnv/IdHN4GI7a6VWbkDGeUn1WX0FBIlfZ9pgtrNXKG9kQehgBQhakP/+nzqqQ
 aBsw==
X-Gm-Message-State: AOJu0YzwsfKb3sdl99SMeHEnZIottij0jFkZRvH0oDm6ayPlkFJXnkXY
 GqeAR/uTpDO6pk5B8EKkwhdU5Wq9ImNGZUmpSb1sRfB0RYQOB/mfCs0eeUxRo+jgEe2Ok86E3D+
 lgvhS5U0sdFECD9P8twJK2SxYTo4j5jiRqk57LJnhJEW7u7oMWHp+3K5wn5kivpyRhSIXpSR8g7
 e/GlBzeOAhOyGArBRIzCEKDh0jfWeALy/6fA==
X-Received: by 2002:a05:6214:2d48:b0:6cc:42d:bb6 with SMTP id
 6a1803df08f44-6d1856bb1bdmr229407766d6.16.1730303889090; 
 Wed, 30 Oct 2024 08:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPcJaRcuMSCmloCCup7Rd8Vz8bxa6WrauP/xuwP0iAMbkbEeTcOOj5HIHfocZotB4FLvJ9Cw==
X-Received: by 2002:a05:6214:2d48:b0:6cc:42d:bb6 with SMTP id
 6a1803df08f44-6d1856bb1bdmr229407456d6.16.1730303888713; 
 Wed, 30 Oct 2024 08:58:08 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:58:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 18/18] migration/multifd: Zero p->flags before starting filling
 a packet
Date: Wed, 30 Oct 2024 11:57:34 -0400
Message-ID: <20241030155734.2141398-19-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This way there aren't stale flags there.

p->flags can't contain SYNC to be sent at the next RAM packet since syncs
are now handled separately in multifd_send_thread.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/r/1c96b6cdb797e6f035eb1a4ad9bfc24f4c7f5df8.1730203967.git.maciej.szmigiero@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 697fe86fdf..4374e14a96 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -600,6 +600,7 @@ static void *multifd_send_thread(void *opaque)
          * qatomic_store_release() in multifd_send().
          */
         if (qatomic_load_acquire(&p->pending_job)) {
+            p->flags = 0;
             p->iovs_num = 0;
             assert(!multifd_payload_empty(p->data));
 
@@ -651,7 +652,6 @@ static void *multifd_send_thread(void *opaque)
                 }
                 /* p->next_packet_size will always be zero for a SYNC packet */
                 stat64_add(&mig_stats.multifd_bytes, p->packet_len);
-                p->flags = 0;
             }
 
             qatomic_set(&p->pending_sync, false);
-- 
2.45.0


