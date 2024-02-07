Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D3DC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfst-0002s4-Mh; Wed, 07 Feb 2024 06:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfss-0002ru-6N
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsq-0003QV-L6
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paACPjx5AjJVvktrAw4tevc/RRfo0mRznAwClB4qJvw=;
 b=blnR9KF34Av4whSRx7tzfSHBY0Ci+Z4yVlaiRVA/4qNt3sZrnLbRO8E1jGPknNWuvkVs+8
 JIs4YyqDhhYwLTwyHmOFdzdnoWBh8FU8ePzC1blvsBmz3N6QjZqCqUV12kNHteVsYkyAlJ
 6CiNYYZMhggEK14Axi5EdMtVClJo2F8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-j4aA4aYGPLyujMnYoRxIbg-1; Wed, 07 Feb 2024 06:14:26 -0500
X-MC-Unique: j4aA4aYGPLyujMnYoRxIbg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2bc664528fso38452066b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304465; x=1707909265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=paACPjx5AjJVvktrAw4tevc/RRfo0mRznAwClB4qJvw=;
 b=VDagfUZ3aNZtDh/5rHbzUkOSeEZEzKQd7Pi8jDwI4nHmMziqGHOxWpSPi3kNWF6Sxv
 gq7io5o13ROLvJDJL+GQyMwdXPopMeBSH8PNz/kWfoh2Adl/HsAfEPTLnD2t82cCQbT0
 godlP9Fx2nIelXMeQVAff+Dxw58MQbFVoYhfWOaBkb5xZl0QAAdU94jrkS76Zo5sDEcw
 IQcG8OBHQ0z1yQTAK0lUjxxISTHP1PBmbnppvkZMgg7LZtHLsWePMnDy1oO3X7B+P5Oo
 KiBKxN/j3BwOkF+Yt9NHHvUMiRYaOMKUSGBG+2qxXQGof0J0ossx6/jlj1GBOmztv03l
 HXSA==
X-Gm-Message-State: AOJu0Yxnqhmvcv8s//qzeUSItNfpaNaXuMtqJjufYxEQGkEXnDcQMRh0
 +8CVdH5rvDrF4RCxlWuMxqT0ENSIAN18TyZFgbkgDzl+JH8RWDcA4eS3pyvZHCElyLi5UFZFdAR
 01JLays5567Ml7OLDGvaL6CDORrUiVwJBLjxHBG3+hgCOWPRBZGBUMZyGNK3kFWDW7eRIF/dunE
 OX7j3gfy1+0LOfpt9breJHypwwr27dnns3giV7
X-Received: by 2002:a17:907:30c5:b0:a38:5cce:1bad with SMTP id
 vl5-20020a17090730c500b00a385cce1badmr1594826ejb.68.1707304465058; 
 Wed, 07 Feb 2024 03:14:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBegPk8NMvyYS9bRNuEzov70JG/E2VoC7DBp/TnXxVgjJnmn3i3PuSogfhT8OUjORf9ibypA==
X-Received: by 2002:a17:907:30c5:b0:a38:5cce:1bad with SMTP id
 vl5-20020a17090730c500b00a385cce1badmr1594808ejb.68.1707304464741; 
 Wed, 07 Feb 2024 03:14:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUZZ1os9kWU/5oYW2MozpVKZ4jD4Y4kKHyfq/p38dCZTCjMPI0PQ4GPAZYJy5XHy6fWOw53Vt04Sie8qrdljmI+/w==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 qo8-20020a170907874800b00a2b1a20e662sm644165ejc.34.2024.02.07.03.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 5/8] isa: specify instance_size in isa_superio_type_info
Date: Wed,  7 Feb 2024 12:14:07 +0100
Message-ID: <20240207111411.115040-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207111411.115040-1-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Right now all subclasses of TYPE_ISA_SUPERIO have to specify an instance_size,
because the ISASuperIODevice struct adds fields to ISADevice but the type does
not include the increased instance size.  Failure to do so results in an access
past the bounds of struct ISADevice as soon as isa_superio_realize is called.
Fix this by specifying the instance_size already in the superclass.

Cc: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c       | 2 +-
 hw/isa/smc37c669-superio.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index e06a548c682..98d50844f71 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -187,6 +187,7 @@ static const TypeInfo isa_superio_type_info = {
     .abstract = true,
     .class_size = sizeof(ISASuperIOClass),
     .class_init = isa_superio_class_init,
+    .instance_size = sizeof(ISASuperIODevice),
 };
 
 /* SMS FDC37M817 Super I/O */
@@ -203,7 +204,6 @@ static void fdc37m81x_class_init(ObjectClass *klass, void *data)
 static const TypeInfo fdc37m81x_type_info = {
     .name          = TYPE_FDC37M81X_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .instance_size = sizeof(ISASuperIODevice),
     .class_init    = fdc37m81x_class_init,
 };
 
diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index 388e2ed9371..d2e58c9a895 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -85,7 +85,6 @@ static void smc37c669_class_init(ObjectClass *klass, void *data)
 static const TypeInfo smc37c669_type_info = {
     .name          = TYPE_SMC37C669_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .instance_size = sizeof(ISASuperIODevice),
     .class_size    = sizeof(ISASuperIOClass),
     .class_init    = smc37c669_class_init,
 };
-- 
2.43.0


