Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE89D637B1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJnN-0007XV-Nc; Wed, 13 Nov 2024 15:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBJnB-0007Q0-D9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBJn9-0006Pp-N2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731529000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ioC2FDnZvC0DrJdHyAoy/nPRgkbSFczRJ3FWaRRjH+M=;
 b=Gp7aKYLSJ6bPALJA+NloDDLHv1dFyAz8HAq7i0viCV9I8+4GL6xiqjSYVwNss4f7mavyLE
 qD+a9SCBE1Ihg+JvA3AiPptfNiRRj2NnN4qqL/ZgypC+mkY7bQ6FbeW3fZ/18v5WHCTHJ+
 7VbyqsuRzjvf2BxxhqD+H49g6wAT7Lo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451--gBSQKhsMgWykp9IIgPhxA-1; Wed, 13 Nov 2024 15:16:38 -0500
X-MC-Unique: -gBSQKhsMgWykp9IIgPhxA-1
X-Mimecast-MFC-AGG-ID: -gBSQKhsMgWykp9IIgPhxA
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83ab3d46472so836180039f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731528998; x=1732133798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioC2FDnZvC0DrJdHyAoy/nPRgkbSFczRJ3FWaRRjH+M=;
 b=odKRZDapZQoLPdvnAryb07sMFTAjKK+hSNfPL3yU1qF9yBSVN8rBfg1c7MtUJ7P/CI
 fTNxSc22hbb2af6gxxHGPH0lEw9K2xGolvATZseqm8h4emzxnaOoMApuCqFB94gmgfUV
 EIEUB9M4/8uuk7M9O2HpuOeTggvBfAo3RjbY3U3im7H/QXMnwcaZ2t7EwQk+dScbkd7I
 BArp7TzE5pE8Jvi6PwFLVN6VwQy67qvoAjvGhVdSnnPLxcm6DeBXFMYTNj5pO9pu2+Yg
 BQDis9cY7l2M28OKKwopZw5oUJNbqt12vIYW3/vHqEAdmgtPosEWiIva0+UseoDF0Eel
 Dy+w==
X-Gm-Message-State: AOJu0YzTpX9q4MtwUq1ZeWtHNAfVzYjkWD8e6kNve7cdGze7u8xc2quE
 K2caDlmtnfl2JUajMEeQxzXnSVCf8hlOpVkopX/Imuano36msGihIaPkBWd9u6SfEjXZ5WlNF0g
 DqFoMwWYx7Y3zUSh8++nOjxP+dyRYq24rcxX6BK2FMkSOGn2RV+kT3+8fi+DJwBwZvdutwWBVsj
 vuHJktkIa4pHx98+FKO2COGxNCEjtGp8Rw3w==
X-Received: by 2002:a05:6602:2bd4:b0:83a:b74c:800e with SMTP id
 ca18e2360f4ac-83e43275e0emr705875039f.12.1731528997701; 
 Wed, 13 Nov 2024 12:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5QnM4kZu3p8BqKFEZA+EQoNjCS1YweHAFGzSn1ZzNdWvjmGIfBzHNet5d31BufBSTzRH4vg==
X-Received: by 2002:a05:6602:2bd4:b0:83a:b74c:800e with SMTP id
 ca18e2360f4ac-83e43275e0emr705872939f.12.1731528997305; 
 Wed, 13 Nov 2024 12:16:37 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132239bcsm280419039f.10.2024.11.13.12.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:16:36 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Dmitry Frolov <frolov@swemel.ru>
Subject: [PULL 2/2] migration: fix-possible-int-overflow
Date: Wed, 13 Nov 2024 15:16:31 -0500
Message-ID: <20241113201631.2920541-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241113201631.2920541-1-peterx@redhat.com>
References: <20241113201631.2920541-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

From: Dmitry Frolov <frolov@swemel.ru>

stat64_add() takes uint64_t as 2nd argument, but both
"p->next_packet_size" and "p->packet_len" are uint32_t.
Thus, theyr sum may overflow uint32_t.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Link: https://lore.kernel.org/r/20241113140509.325732-2-frolov@swemel.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 4374e14a96..498e71fd10 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -623,7 +623,7 @@ static void *multifd_send_thread(void *opaque)
             }
 
             stat64_add(&mig_stats.multifd_bytes,
-                       p->next_packet_size + p->packet_len);
+                       (uint64_t)p->next_packet_size + p->packet_len);
 
             p->next_packet_size = 0;
             multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
-- 
2.45.0


