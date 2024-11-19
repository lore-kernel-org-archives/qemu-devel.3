Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33736D6C29B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDVpH-0000FV-4V; Tue, 19 Nov 2024 16:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDVpD-0000Dm-AY
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDVp7-0002mu-H9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732051907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NwNdCsLlv2FCsIwBF/DZFNWppyP2mBewd/iZLvuh7i0=;
 b=ZiEkEhBw9TELPGn0c8rfAk0O127t9m9k+V9KeDeB7s9LRbhxjdvVZJ8LiwN0eFff9kF0Ux
 DFrhCgN0C/cg0HOIMuxukpd92jz7zeyW8W+ZQbh3hBidVAfjKiBuaqC67ZplaZovRyoDpX
 9YEaB5azP0/Yp6Zd2o2BPDrhXM8Y4yg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-SO-4d6DAMOWL-eAWVQuKqA-1; Tue, 19 Nov 2024 16:31:46 -0500
X-MC-Unique: SO-4d6DAMOWL-eAWVQuKqA-1
X-Mimecast-MFC-AGG-ID: SO-4d6DAMOWL-eAWVQuKqA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-432d9b8503cso934705e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 13:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732051905; x=1732656705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NwNdCsLlv2FCsIwBF/DZFNWppyP2mBewd/iZLvuh7i0=;
 b=lPxrznIwXsLmWxrgEJMJ+qdXgC/5GLXWUvsdAPOkqTXT3OGHzGGGYh+xumP4K/DJj/
 rtJkg+hq9NYFsDcnJsGy30hsHxCQCMoJ53BOlD+Aw5WI/1KbvNRBOjodAeG/MnZZm4UR
 IaXqeFWR/vvRVxJMLvEIRt4Lmq1c2hLAJUO49NHdUsseeB0pcM1fTBoawL3LcazWtvIg
 JzKOKghaMbe1qzElOTKYNnDBP/7hexlRXybdEH5vcB17GcHioofFuI+ocuETEhe3ANZD
 1pj2ZGHt1a66QKlKnxuEILxmzRplPOhc12GIafcQPpKMdHXxYYFqZB6SvyV2LtOMasLK
 dRtQ==
X-Gm-Message-State: AOJu0Yy5DDqIp08bpCBFnHfNm3aMadrv81Kzmhqm6AngzAzjoSvf6TvT
 NIXNku3LenCSRGvQ1XayPIlIrkY9ga2AEpiR0pAmbIKwk0Z6cCtXGg90azxquy/cR7d58Bm97/5
 H3pAotFTb3kJ3ICHIAXY230QDRd/F8//t1NfMtC0iIfSLQcEMXTX2RjFLQTtEqLTeW32D0CCJT0
 R5vVq1IoJpdnLhgVOS4sZvqogOCDTpeuqsHewX
X-Received: by 2002:a05:600c:5394:b0:431:57cf:f13d with SMTP id
 5b1f17b1804b1-433475fe8b7mr4828815e9.3.1732051904854; 
 Tue, 19 Nov 2024 13:31:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHZ/Tzlg6sZNFUN+uWfXMSPTxHc3X86HGuwRsiOgw1Enqb8PNl8HxEbq6cwAI7RYKVLxu9Nw==
X-Received: by 2002:a05:600c:5394:b0:431:57cf:f13d with SMTP id
 5b1f17b1804b1-433475fe8b7mr4828645e9.3.1732051904493; 
 Tue, 19 Nov 2024 13:31:44 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab80a10sm204514325e9.26.2024.11.19.13.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 13:31:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com,
	thuth@redhat.com
Subject: [PATCH] scsi: fix allocation for s390x loadparm
Date: Tue, 19 Nov 2024 22:31:42 +0100
Message-ID: <20241119213142.77248-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

Coverity reports a possible buffer overrun due to a non-NUL-terminated
string in scsi_property_set_loadparm().  While things are not so easy,
because qdev_prop_sanitize_s390x_loadparm is designed to operate on a
buffer that is not NUL-terminated, in this case the string *does* have
to be NUL-terminated because it is read by scsi_property_get_loadparm
and s390_build_iplb.

Cc: jrossi@linux.ibm.com
Cc: thuth@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8e553487d50..7f13b0588f2 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3152,7 +3152,7 @@ static void scsi_property_set_loadparm(Object *obj, const char *value,
         return;
     }
 
-    lp_str = g_malloc0(strlen(value));
+    lp_str = g_malloc0(strlen(value) + 1);
     if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
         g_free(lp_str);
         return;
-- 
2.47.0


