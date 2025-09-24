Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B9ACAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LpL-0005hC-ST; Wed, 24 Sep 2025 05:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpE-0005ZI-7O
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lp6-0004rA-9x
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEIu1N4KnJLuolNTYTrmzVOdvxoxWz6ae7kAlH7RbdY=;
 b=QH3XxHGkKwWxsx4w+GCAWVaOhPwMTHGUR5doTv3UbdmtwdDAQMmWNOcVVmBRPKD16bFTZK
 N/a6j6QxjcXejZ5AgiFUWduTcIetWr8vMUT/U0aXfApLcyPQ1TdRUFCiIrqimSh+a8bxEu
 9K9pTv83WsGYmCEwA4Au4V0qV5lpJ2s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-w4X_InbgO2Gt3Bh2Ej4iow-1; Wed, 24 Sep 2025 05:29:59 -0400
X-MC-Unique: w4X_InbgO2Gt3Bh2Ej4iow-1
X-Mimecast-MFC-AGG-ID: w4X_InbgO2Gt3Bh2Ej4iow_1758706198
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b04a302fb7cso591017066b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706197; x=1759310997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEIu1N4KnJLuolNTYTrmzVOdvxoxWz6ae7kAlH7RbdY=;
 b=dqX5Kk6Wh01dDgOVrUVRWw6P6Gw0wt+cyUzEi5nAae6LSCrPZwBKRhvxLD2Wag8xn1
 OzmClHNunEyL3ZyiFlMkGHrxJ+qL/rep54jEIMOUfJySGyOoDdDlJcT1ciI1ZMzcO7Fm
 VPGe79gu4+yhTB7DF6r+JOplaNPYCpKOGSujGlzHMwxFuSbCn98QQSgdZgUeMr0RcCLC
 1CMLeyrNQPDw7+cjtHCNb9csGsK6UC0fBbNP1oTQsa25PAo8eQD/0P3DxO2WHif4q9nn
 e+NTTVu/cMYyWp9kLuc/qFpcrj9a5Wq8WDuNYLjudGqaf64JZn4vOuqCYZ1qgAVy7uCu
 i+tQ==
X-Gm-Message-State: AOJu0Yy/eoJPAHeNeIkIB/ZSVjQDOJdWZWoY+M4zs1qvybutkluxm2Dx
 FPtyWENHBBMPushYWwFvlTIEtoNCzNKaOo6LSGIyky4EIQaUOZGYDSv8ybWtFIbZbWO2GslIEYD
 /ocvJKYmgAiS9h/INJJmsKU9NJhOcqWtzIHjV3AfCOVtFCmsW+gWx1TZpedT9kgWmlvDcsAH7zS
 A4rZo2g7vmMsI3m84MYxDS1leLpyENDxNGVjZEcssv
X-Gm-Gg: ASbGnctE6Oozi4fp5Ekb/StjiIXGOwbz1ggjU5q5Bug4No2EDB8fLEZdm267xwYs6KC
 30y+pbV9LSAXyLDvljkrOlSMxyWhGCg8J9R6n8UDPZP1Nb0wn8nSEizn02JpwKYQ1EnTzbHri/Q
 Gd8tVPXNuSEFEoGNxCQ2TGQck119A7HCT6jbC0aty2zxAQ9X4k67RSuoVptHXTqvQesWzocwy7Y
 qLEIzoq4IRqn6AZAfcUNQyyCSjeCa9ZcwCbAUX2vangivJP6/6LaOTCeb288xkoQZYLuTxzbBpx
 P6ejagiVK031ueHV0FoezIPWch7QQdV+JH5qZ6W4sUBJBH9/Xv5K00ieS5HxWpDhO4f5qEC9n7M
 fFU+yJLhvldPWqQS0xJiieHhlAM32foIioetP8fVLWzzeaQ==
X-Received: by 2002:a17:907:6d0b:b0:b04:806b:c612 with SMTP id
 a640c23a62f3a-b3026c84e17mr593311466b.10.1758706196848; 
 Wed, 24 Sep 2025 02:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsXdHFGSH4xJGFwB5B3XpkCOKRY6g7Q0fiyeoi5GrYk4wCs84w4wrUIYxFH4736GandEGRdA==
X-Received: by 2002:a17:907:6d0b:b0:b04:806b:c612 with SMTP id
 a640c23a62f3a-b3026c84e17mr593308666b.10.1758706196328; 
 Wed, 24 Sep 2025 02:29:56 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2a2a5f6c94sm833205366b.13.2025.09.24.02.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 22/29] hw/core/register: Do not unparent in instance_finalize()
Date: Wed, 24 Sep 2025 11:28:42 +0200
Message-ID: <20250924092850.42047-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250924-use-v4-3-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/register.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 8f63d9f227c..3340df70b06 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -314,7 +314,6 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
 
 void register_finalize_block(RegisterInfoArray *r_array)
 {
-    object_unparent(OBJECT(&r_array->mem));
     g_free(r_array->r);
     g_free(r_array);
 }
-- 
2.51.0


