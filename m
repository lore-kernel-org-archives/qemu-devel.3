Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4060606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QDVk4dqg;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MAIBDsw/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYxT-00034B-DS; Thu, 12 Nov 2026 12:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYxB-0002l2-9X
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:51:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYx9-0001u0-8e
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koeZHuGFMvpHz5FAaCHxb0PJU1w5tV6DbBMJHGBImws=;
 b=QDVk4dqg0Pm0L+FJYWXn2H5N1sMK4B6hMH93xxUgvFBK4xgBXsrcLWLl1QpWqXUITcNWGY
 /sX8uwE1z87r+xlA2s83fyNssOhYQtgQ9ldneURSi1EdeenwylSIdeBk//LSRQXxoisP4Z
 ctA5uwHuODN5pV++IQeg4XkE8pIFOFY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-MUfk6wLYN3SP76y9adSXTQ-1; Thu, 12 Nov 2026 12:51:13 -0500
X-MC-Unique: MUfk6wLYN3SP76y9adSXTQ-1
X-Mimecast-MFC-AGG-ID: MUfk6wLYN3SP76y9adSXTQ_1794505872
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ea63087d79so1111845ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505872; x=1795110672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=koeZHuGFMvpHz5FAaCHxb0PJU1w5tV6DbBMJHGBImws=;
 b=MAIBDsw/2hjwpzdF3P5NkyosiOcptl2YaPUGNToV7Keskkhhte0EjqBWIeQiqWfARj
 yU5CmTq90w7PP5wZElfNjLKlP/Y4XUKRez0wNpuY26Q+uEnhpL1MrX/02IUByxeaeGcZ
 O317EPokEMTWZbbzt/xEGtXLq7BQIObIriLhSB4SK+GPImd2VYg4d0F2FZwU/V0C1Es9
 B6XlQSYJBwoJ50mtQBITl9JGWoS+1wJ4Lh7yapEBFt2qOiPlnDZFv6px5Ry1alYd5W47
 TTGc2Ve6TnVabcXcNL2Zes2Ldf/fHgKak2Id/ID/KMSyXPF0W7luXxsPBD06VeYMxMc+
 yy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505872; x=1795110672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=koeZHuGFMvpHz5FAaCHxb0PJU1w5tV6DbBMJHGBImws=;
 b=Q9AxRwJu4kiXP6vkdwLOVAjmawOkTklke9VQv3qfEOJhpy7BbhFJR5NX/l/u/2nBeF
 wAWEmHUegJSQ8e4FqFExCZdbT7qxb4OBplpf+6hKHb95+7x4ioOrak2GGejO7PcxsZXx
 BIxwZ0Xx0THugEC4me7VZEJDZcDxClpDpuDonSb9ch5S/qlflWfcfXe4VAJFCgvqihzB
 PGVt+e4ZZ3xLI+D/AbmL9nb2fwu8JARHpB4JjNoDykA/UeBjF7MbJEinu+DDTApTlbxY
 oLe1WE98ixVLEZQ9Ajrk6B08IrWRPdRaVhGgTR+mQi5mOM/b7pPrU7I8/qhnLYM8oXiR
 A+YQ==
X-Gm-Message-State: APuU4Z8z00vc/IfB0p5EU1ZzP9+aAIEm0YoSr2DlcZJba7UiskYxuBq3
 9fKNt7YzTcWHE5Fb824HyhowKtxJSqacQ3+wVbXWrjy6JkpDME/G1ij1tE6EPk1rFDMEEwYZfKk
 4GHsux73THZ0wzOi1V5UxWJoFEobS6Eo/bKFjb5Y1XgD/Oc8CUHvOhvo8NLTD1k9YuNN3nl0Kon
 rDj4Sy0cr+4B51lTIqHg2y2w83744uslhgmIfODkKd0g==
X-Gm-Gg: AYBFou1Htq3uPiMd65VZ5ZgfxkGFQbrBPQSCR9CVkxlcxhPOk3r/Bsh00HpwCImY97S
 2e/R6nArLLTEWF9oGw3rjcmhX0C/FsEkIlb9G/SNhZbwcJn/LaLi/qZKIkBL66WmDWnMBvHZ6J9
 Zaef+lc6OKDanWrGcLBWFKRUDzHfAdF2YSjMoV6NHL6OGiF317PHYUeGxPLBpXHsqDW2Nfa6kSm
 LNmECBKtnypvw3ECICoPBqWGLOCGvam9owVYuJbpJOMkSP77nuXENpoXu+rsQE0WnMzSEllheAT
 8xWzQJzW7/QnwD5NCKhBQS1zoi788EePvVoAKxD6SGA/sAnMZNWNaPHzSsO5rYU5sMzJdJlHETg
 b+J6BSkbebSWTqL+qCTTQ1wDi7VMhnR4brYxLSPxggXePbg==
X-Received: by 2002:a17:903:1b50:b0:2e2:d09f:d770 with SMTP id
 d9443c01a7336-2ee0decf0admr733125ad.26.1794505872033; 
 Thu, 12 Nov 2026 09:51:12 -0800 (PST)
X-Received: by 2002:a17:903:1b50:b0:2e2:d09f:d770 with SMTP id
 d9443c01a7336-2ee0decf0admr732995ad.26.1794505871475; 
 Thu, 12 Nov 2026 09:51:11 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d4b950sm36299215ad.13.2026.11.12.09.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:51:10 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 9/9] hw/usb/dev-mtp: Stop processing SendObjectInfo after an
 error
Date: Thu, 12 Nov 2026 18:49:06 +0100
Message-ID: <20261112174907.158825-10-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112174907.158825-1-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When SendObjectInfo fails its checks, usb_mtp_command() queues an error
response and then falls through. It still allocates s->data_out. The
data phase is then dropped because a result is pending, so s->data_out
is never released.

Return right after queueing the error response.

Cc: qemu-stable@nongnu.org
Fixes: 53735bef108c ("usb-mtp: Advertise SendObjectInfo for write support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index d01b38aeac..82970b6437 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1401,14 +1401,17 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (!FLAG_SET(s, MTP_FLAG_WRITABLE)) {
             usb_mtp_queue_result(s, RES_STORE_READ_ONLY,
                                  c->trans, 0, 0, 0, 0);
+            return;
         } else if (c->argv[0] && (c->argv[0] != QEMU_STORAGE_ID)) {
             /* First parameter points to storage id or is 0 */
             usb_mtp_queue_result(s, RES_STORE_NOT_AVAILABLE, c->trans,
                                  0, 0, 0, 0);
+            return;
         } else if (c->argv[1] && !c->argv[0]) {
             /* If second parameter is specified, first must also be specified */
             usb_mtp_queue_result(s, RES_DESTINATION_UNSUPPORTED, c->trans,
                                  0, 0, 0, 0);
+            return;
         } else {
             uint32_t handle = c->argv[1];
             if (handle == 0xFFFFFFFF || handle == 0) {
@@ -1420,9 +1423,11 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
             if (o == NULL) {
                 usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE, c->trans,
                                      0, 0, 0, 0);
+                return;
             } else if (o->format != FMT_ASSOCIATION) {
                 usb_mtp_queue_result(s, RES_INVALID_PARENT_OBJECT, c->trans,
                                      0, 0, 0, 0);
+                return;
             }
         }
         if (o) {
-- 
2.56.0


