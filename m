Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E67C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv3t-0003Cs-8c; Tue, 13 Feb 2024 10:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3r-00036D-AW
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv3p-0005Y6-TK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eavu1uG4NtuHo7emg9gUb4sqremIQ+v3v3eAdA8Z7IY=;
 b=G3tabbd7p0MPFURhGsK2ypBYIZ+nzPowoG3qFnqdKWSlIChZdjkp/Z6SYSyeDy9ljJbSpA
 tYBpdf6/WSqZ5kIuEfrM2SGPeb34w9JTNzYn9eC2aKUE9qC4ViOpG1vVmgRz9Mo/bqxbDz
 X90U1doESVMUsw45tzFFX1vlLDm8djM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-8mqifFFlNxad4Kr-i8f2aA-1; Tue, 13 Feb 2024 10:51:03 -0500
X-MC-Unique: 8mqifFFlNxad4Kr-i8f2aA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a26f2da3c7bso236703966b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839460; x=1708444260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eavu1uG4NtuHo7emg9gUb4sqremIQ+v3v3eAdA8Z7IY=;
 b=YutwIuYRLlApkZduAEGtzNM0lJ9FCOyfSGY6ZPV/K2tgqBGRm/GLimLEGTx13JNgUz
 fu/VbNR3By8R/urmYzC1NdhZfgykEVHmzGjNp3ctiI526LG2anUUcd2ulyGOiaLkYXRP
 i9Xfva8QJB81K1AQczW5Yic+/u2p633HSZ6HhG5NEwPs47Am29rCqEHKkEyL+Q38mgSE
 qNVlEF0WtRT1ncMvhcHNLtB4LVgyQ00YviraS7ro8QujlphoNPksMED4D9p13CrZogIQ
 iaizUSOOJ6tQRx1+3icGS9+D3AZTNE4bpkXmqu6cqQAJ4pdletKHb1GX8d8ratV/Yfvj
 XHXg==
X-Gm-Message-State: AOJu0YxeTN/sqNDAocxO07fPZXEUHm7it10DjfSI2WcMSKcDdF2/pPf3
 gR+w1O+m04OsI5fE1TPi2Y1K/XpkrHIpGOC5xTZNzkml4nGxRznltV4BSGzAiE/NwMLWKiX0Vkp
 skVJJWru65m0/lghvZ216ktVs+HeFdbinocDdfx5i2Q/sqtd2qLv60605a+HvK+VRPFMrKnEWYc
 L4QUZblZhD1es46c6/R6vfn7BBBIqt52wsCqrC
X-Received: by 2002:a17:906:f1cb:b0:a3c:af7e:1660 with SMTP id
 gx11-20020a170906f1cb00b00a3caf7e1660mr3774306ejb.22.1707839459776; 
 Tue, 13 Feb 2024 07:50:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF21+/tB4MY0SeAlJaY4+dS6tUEeNd1XKqx1b24Zd4H9TBnCuZGK048x2V4e0FgIv6VuGvM2Q==
X-Received: by 2002:a17:906:f1cb:b0:a3c:af7e:1660 with SMTP id
 gx11-20020a170906f1cb00b00a3caf7e1660mr3774289ejb.22.1707839459412; 
 Tue, 13 Feb 2024 07:50:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW2sycnd3A6AsTvrCGK0SaRelCQ1dHZ7BNqYk+XgAFn9zomryny6k0/3pEk6KeoFi3jtGpo0++9dxuDl6sp1gwCuLlVO52yhSKpV8VSEh3fpR8OE9Ll
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 tz3-20020a170907c78300b00a3d243d0aa0sm165278ejc.31.2024.02.13.07.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:50:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	shentey@gmail.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 5/9] isa: specify instance_size in isa_superio_type_info
Date: Tue, 13 Feb 2024 16:50:00 +0100
Message-ID: <20240213155005.109954-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213155005.109954-1-pbonzini@redhat.com>
References: <20240213155005.109954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

Fixes: 4c3119a6e3 ("hw/isa/superio: Factor out the parallel code from pc87312.c")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
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


