Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C845FC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURky-0006KU-CJ; Mon, 29 Jan 2024 08:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURku-0006JO-JL
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURkt-0007SY-4j
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706535174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Ku+HrGPXjToZDgNgsmKEWcHlzJmRB3FkB2Wo+Oy33Y=;
 b=iJSAL2Xrq6fNtf+KSHf4hYCV8mQ4QP7H9U58/7npkCC26Set9C9rEw2gwQQSu7J4KoBNtT
 itio/7Mswqi6WhQTtwzF7SvF+meCVcvdxPX317u2RgM+YXyquJJd7aeNysi67aRwAo4f3G
 RmrcsZdNUowapQKhsPAyiZ/lGGfiu+A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-DQqhvIWMPg-Ej9IfL9z3UA-1; Mon, 29 Jan 2024 08:32:52 -0500
X-MC-Unique: DQqhvIWMPg-Ej9IfL9z3UA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a35384ae3beso93336566b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535171; x=1707139971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ku+HrGPXjToZDgNgsmKEWcHlzJmRB3FkB2Wo+Oy33Y=;
 b=RRyjQCndS79IXCUoMbGUZ2uwg+3l4y+VOh9ZRpvnRuvcMQZzqw8r+k0SBy/9vFyhKb
 SaM78fJhQureVyjmP7AZkF8kVrgIKJrKXw0hxPX+3Um80k/9mfEEOOsV0qTBqbJeMb0d
 +VmX48paDn29Fr9EEP465M8bfysdkz6aYcEzb1ARchS+NaXcWCkKY+0tXiEgKbCOgClZ
 9rEkqGZWNYjtOkHJI/hRsdvalJGf18zjy2TFxe2rAUDMFp6iqEYxEwFlvO7bsNI3Lns8
 CESnbFac8anupQu/bs5Ko9NMsUB9iBaBOPFUNjJvnGvGAm2KH9HL0CSpAOYboW22HOWA
 OIiQ==
X-Gm-Message-State: AOJu0Yx02v9iN4GtaDxNcu6rLqrYddcjVutOX4OneFqvr9wPjyuTtg9V
 /+RARdsctqwqi5q/249gql+o9yo2jjL8iUaZDCsFo4tVffsNF0DqTUtyQNLTcPulv1fut2H19/I
 KmCREHgJBQoqvBcxl862Dcy9zUwXUCkvcrZeFsXH/FiNp341+sy1dwx0z0fXvJlRjyGHyu8uZ8X
 mVb7qRM/OmPs6/xCaSkTp+Ct0I6gVs1yxFr1VG
X-Received: by 2002:a17:906:c1ca:b0:a35:8419:4bba with SMTP id
 bw10-20020a170906c1ca00b00a3584194bbamr3221512ejb.7.1706535171160; 
 Mon, 29 Jan 2024 05:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7HKFt43bEgIT+79UdQSAHrNt1Gr4tzrtWaxJN4Bmies1AkTEGmv0IevHXYpU9u+b70IieJQ==
X-Received: by 2002:a17:906:c1ca:b0:a35:8419:4bba with SMTP id
 bw10-20020a170906c1ca00b00a3584194bbamr3221499ejb.7.1706535170773; 
 Mon, 29 Jan 2024 05:32:50 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a1709065fcf00b00a2cea055d92sm3957718ejv.176.2024.01.29.05.32.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 05:32:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] isa-superio: validate floppy.count value
Date: Mon, 29 Jan 2024 14:32:49 +0100
Message-ID: <20240129133249.1105704-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ensure that the value is valid; it can only be zero or one.
And never create a floppy disk controller if it is zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 80e0c34652e..34df335598c 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -116,7 +116,9 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     }
 
     /* Floppy disc */
-    if (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0)) {
+    assert(k->floppy.count <= 1);
+    if (k->floppy.count &&
+        (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0))) {
         isa = isa_new(TYPE_ISA_FDC);
         d = DEVICE(isa);
         if (k->floppy.get_iobase) {
-- 
2.43.0


